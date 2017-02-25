Received: from eggs.gnu.org ([2001:4830:134:3::10]:40128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chVv2-0005jI-Sr
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:33:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chVuz-0007Bp-JG
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:33:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1chVuz-0007Ac-B0
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:33:21 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FD388553D
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 06:33:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-6-git-send-email-armbru@redhat.com>
	<eeb7954d-95f9-3db2-edd3-3d953903bcfb@redhat.com>
Date: Sat, 25 Feb 2017 07:33:18 +0100
In-Reply-To: <eeb7954d-95f9-3db2-edd3-3d953903bcfb@redhat.com> (Eric Blake's
	message of "Fri, 24 Feb 2017 15:56:22 -0600")
Message-ID: <878touvky9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 05/21] qmp: Clean up how we enforce
 capability negotiation
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
>> To enforce capability negotiation before normal operation,
>> handle_qmp_command() inspects every command before it's handed off to
>> qmp_dispatch().  This is a bit of a layering violation, and results in
>> duplicated code.
>> 
>> Before capability negotiation (!cur_mon->in_command_mode), we fail
>> commands other than "qmp_capabilities".  This is what enforces
>> capability negotiation.
>> 
>> Afterwards, we fail command "qmp_capabilities".
>> 
>> Clean this up as follows.
>> 
>> The obvious place to fail a command is the command itself, so move the
>> "afterwards" check to qmp_qmp_capabilities().
>> 
>> We do the "before" check in every other command, but that would be
>> bothersome.  Instead, start without all the other commands, by
>> registering only qmp_qmp_capabilities().  Register the others in
>> qmp_qmp_capabilities().
>> 
>> Additionally, replace the generic human-readable error message for
>> CommandNotFound by one that reminds the user to run qmp_capabilities.
>> Without that, we'd regress commit 2d5a834.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  monitor.c | 70 ++++++++++++++++++++++++++++++++++++---------------------------
>>  1 file changed, 40 insertions(+), 30 deletions(-)
>> 
>
>> @@ -3781,12 +3782,21 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
>>      cmd_name = qdict_get_str(qdict, "execute");
>>      trace_handle_qmp_command(mon, cmd_name);
>>  
>> -    if (invalid_qmp_mode(mon, cmd_name, &err)) {
>> -        goto err_out;
>> -    }
>> -
>>      rsp = qmp_dispatch(req);
>>  
>> +    qdict = qdict_get_qdict(qobject_to_qdict(rsp), "error");
>> +    if (qdict) {
>> +        if (!mon->qmp.in_command_mode
>> +            && !strcmp(qdict_get_try_str(qdict, "class"),
>
> Ouch - this can call strcmp(NULL, ...) if the error is ill-formed.  Is
> that a problem?  Can we assert that "class" will always exist as a string?

It's safe, because it comes from qmp_build_error_object().  But I'll
switch to g_strcmp0() to make it more obviously safe.

>> +                       QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_FOUND])) {
>> +            /* Provide a more useful error message */
>> +            qdict_del(qdict, "desc");
>> +            qdict_put(qdict, "desc",
>> +                      qstring_from_str("Expecting capabilities negotiation"
>> +                                       " with 'qmp_capabilities'"));
>> +        }
>> +    }
>> +
>
> Otherwise, I like it.

Thanks!
