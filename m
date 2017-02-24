Received: from eggs.gnu.org ([2001:4830:134:3::10]:45039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chMMj-0005YR-GB
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chMMf-0002dV-Dd
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:21:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1chMMf-0002d0-4w
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:21:17 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53EEB81229
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 20:21:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-5-git-send-email-armbru@redhat.com>
	<bc882971-0828-079b-e0b1-0d50fad215d3@redhat.com>
Date: Fri, 24 Feb 2017 21:21:14 +0100
In-Reply-To: <bc882971-0828-079b-e0b1-0d50fad215d3@redhat.com> (Eric Blake's
	message of "Fri, 24 Feb 2017 13:39:10 -0600")
Message-ID: <87lgsvxrut.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 04/21] qmp: Dumb down how we run QMP
 command registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/23/2017 03:45 PM, Markus Armbruster wrote:
>> The way we get QMP commands registered is high tech:
>> 
>> * qapi-commands.py generates qmp_init_marshal() that does the actual work
>> 
>> * it also generates the magic to register it as a MODULE_INIT_QAPI
>>   function, so it runs when someone calls
>>   module_call_init(MODULE_INIT_QAPI)
>> 
>> * main() calls module_call_init()
>> 
>> QEMU needs to register a few non-qapified commands.  Same high tech
>> works: monitor.c has its own qmp_init_marshal() along with the magic
>> to make it run in module_call_init(MODULE_INIT_QAPI).
>
> Eww. Two static functions with the same name, which really messes with
> gdb debugging.
>
>> 
>> QEMU also needs to unregister commands that are not wanted in this
>> build's configuration (commit 5032a16).  Simple enough:
>> qmp_unregister_commands_hack().  The difficulty is to make it run
>> after the generated qmp_init_marshal().  We can't simply run it in
>> monitor.c's qmp_init_marshal(), because the order in which the
>> registered functions run is indeterminate.  So qmp_init_marshal()
>> registers qmp_init_marshal() separately.  Since registering *appends*
>
> Another case of "A sets up A" when you meant "A sets up B", but this
> time, I'm fairly certain you mean qmp_init_marshal() registers
> qmp_unregister_commands_hack() separately.

Correct.  I'll fix it.

>> to the list of registered functions, this will make it run after all
>> the functions that have been registered already.
>> 
>> I suspect it takes a long and expensive computer science education to
>> not find this silly.
>
> ROFL
> (does that mean I didn't spend enough on my education? I'm sure you
> could arrange to sell me an online certificate if I wanted more... :)

Plenty of peddlers out there!

>> Dumb it down as follows:
>> 
>> * Drop MODULE_INIT_QAPI entirely
>> 
>> * Give the generated qmp_init_marshal() external linkage.
>> 
>> * Call it instead of module_call_init(MODULE_INIT_QAPI)
>> 
>> * Except in QEMU proper, call new monitor_init_qmp_commands() that in
>>   turn calls the generated qmp_init_marshal(), registers the
>>   additional commands and unregisters the unwanted ones.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> -static void qmp_init_marshal(void)
>> +void monitor_init_qmp_commands(void)
>>  {
>> +    qmp_init_marshal();
>> +
>>      qmp_register_command("query-qmp-schema", qmp_query_qmp_schema,
>>                           QCO_NO_OPTIONS);
>>      qmp_register_command("device_add", qmp_device_add,
>> @@ -1004,12 +1006,9 @@ static void qmp_init_marshal(void)
>>      qmp_register_command("netdev_add", qmp_netdev_add,
>>                           QCO_NO_OPTIONS);
>>  
>> -    /* call it after the rest of qapi_init() */
>> -    register_module_init(qmp_unregister_commands_hack, MODULE_INIT_QAPI);
>> +    qmp_unregister_commands_hack();
>
> We could inline this function now, but keeping the _hack() name around
> reminds us to consider conditional-compilation support in the generator
> at a later date, so I'm fine with the approach you took.

Exactly.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
