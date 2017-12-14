Received: from eggs.gnu.org ([2001:4830:134:3::10]:45297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePVKn-0002IT-4q
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePVKi-0002Ij-Vs
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:22:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ePVKi-0002I5-NR
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:22:00 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171213181540.7949-1-danielhb@linux.vnet.ibm.com>
	<20171213181540.7949-2-danielhb@linux.vnet.ibm.com>
	<de0c5647-ca81-f5be-db52-9f0d3b173dac@redhat.com>
Date: Thu, 14 Dec 2017 16:21:57 +0100
In-Reply-To: <de0c5647-ca81-f5be-db52-9f0d3b173dac@redhat.com> (Eric Blake's
	message of "Wed, 13 Dec 2017 20:18:43 -0600")
Message-ID: <87ind9xrl6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 1/2] qmp.c: (re)implement qmp_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 12/13/2017 12:15 PM, Daniel Henrique Barboza wrote:
>> Commit 755f196898 ("qapi: Convert the cpu command") added the qmp_cpu
>> function in qmp.c, leaving it blank. It the same commit, a working
>> hmp_cpu was implemented. Since then, no further changes were made in
>> qmp_cpu, resulting now in a working 'cpu' command that works in HMP
>> and a 'cpu' command in QMP that does nothing.
>> 
>> Regardless of what constraints were involved that time in not implemeting
>> qmp_cpu, at this moment it is possible to have both.

If I remember that part of history correctly, implementing the command
in QMP was just as possible back then, but deemed a Bad Idea for the
reason Eric explains below.

What I don't quite remember is why we had to implement it in QMP as a
no-op.  Might have been due to the way QMP and HMP were entangled back
then.

>>                                                      This patch brings
>> the logic of hmp_cpu to qmp_cpu and converts the HMP function to use its
>> QMP counterpart.
>
> I'm not sure I like this. HMP is stateful (you have to remember what
> previous 'cpu' commands have been run to tell what the current command
> will do).  That may be convenient (if not confusing) to humans, but is
> lousy for machine interfaces.  QMP should be stateless as much as
> possible - for any command that would behave differently according to
> what CPU is selected, THAT command (and not a different 'cpu' command
> executed previously) should have a cpu argument alongside all its other
> parameters.
>
> So unless you have a really strong use case for this, I don't think we
> want it.
>
>
>> +++ b/qapi-schema.json
>> @@ -1048,11 +1048,19 @@
>>  ##
>>  # @cpu:
>>  #
>> -# This command is a nop that is only provided for the purposes of compatibility.
>> +# Set the default CPU.
>>  #
>> -# Since: 0.14.0
>> +# @index: The index of the virtual CPU to be set as default
>> +#
>> +# Returns: Nothing on success
>> +#
>> +# Since: 2.12.0
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "cpu", "arguments": { "index": 2 } }
>> +# <- { "return": {} }
>>  #
>> -# Notes: Do not use this command.
>>  ##
>>  { 'command': 'cpu', 'data': {'index': 'int'} }
>>  
>> diff --git a/qmp.c b/qmp.c
>> index e8c303116a..c482225d5c 100644
>> --- a/qmp.c
>> +++ b/qmp.c
>> @@ -115,7 +115,9 @@ void qmp_system_powerdown(Error **erp)
>>  
>>  void qmp_cpu(int64_t index, Error **errp)
>>  {
>> -    /* Just do nothing */
>> +    if (monitor_set_cpu(index) < 0) {
>> +        error_setg(errp, "Invalid CPU index");
>> +    }
>>  }
>>  
>>  void qmp_cpu_add(int64_t id, Error **errp)
>> 
>
> Better yet, let's document that 'cpu' is deprecated, so that we can
> remove it from QMP altogether in a couple of releases.

Yes.

The standard way to deprecate a feature is to add it to appendix
"Deprecated features" in qemu-doc.texi, and make its use trigger
suitable deprecation messages, pointing to a replacement if any.

Unfortunately, we still lack means to signal "X is deprecated, use Y
instead" to a QMP client.  Not important in this case, because the
command has never worked.
