Received: from eggs.gnu.org ([2001:4830:134:3::10]:57084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjt8Z-0004gz-LN
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjt8W-0001Hk-JY
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:45:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjt8W-0001G9-BK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:45:08 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DDD93D956
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 19:45:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-8-git-send-email-armbru@redhat.com>
	<e3776dbf-f2d3-b2ef-4454-9b9dc46d7f20@redhat.com>
Date: Fri, 03 Mar 2017 20:45:05 +0100
In-Reply-To: <e3776dbf-f2d3-b2ef-4454-9b9dc46d7f20@redhat.com> (Eric Blake's
	message of "Fri, 3 Mar 2017 12:40:57 -0600")
Message-ID: <8760jqjgam.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 07/28] qmp: Clean up how we enforce
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

> On 03/03/2017 06:32 AM, Markus Armbruster wrote:
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
>> bothersome.  Instead, start with an alternate list of commant that
>
> s/commant/commands/

Fixed.

>> contains only "qmp_capabilities".  Switch to the full list in
>> qmp_qmp_capabilities().
>> 
>> Additionally, replace the generic human-readable error message for
>> CommandNotFound by one that reminds the user to run qmp_capabilities.
>> Without that, we'd regress commit 2d5a834.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  monitor.c | 76 +++++++++++++++++++++++++++++++++++----------------------------
>>  1 file changed, 42 insertions(+), 34 deletions(-)
>> 
>
>> @@ -3786,11 +3785,20 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
>>      cmd_name = qdict_get_str(qdict, "execute");
>>      trace_handle_qmp_command(mon, cmd_name);
>>  
>> -    if (invalid_qmp_mode(mon, cmd_name, &err)) {
>> -        goto err_out;
>> -    }
>> +    rsp = qmp_dispatch(cur_mon->qmp.commands, req);
>>  
>> -    rsp = qmp_dispatch(&qmp_commands, req);
>> +    qdict = qdict_get_qdict(qobject_to_qdict(rsp), "error");
>> +    if (qdict) {
>> +        if (mon->qmp.commands == &qmp_cap_negotiation_commands
>> +            && !g_strcmp0(qdict_get_try_str(qdict, "class"),
>> +                    QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_FOUND])) {
>
> Could join these two 'if' into one, for less {}, but that's cosmetic.

Or maybe get reshuffle so that qdict_get_qdict() is called only when
needed:

    if (mon->qmp.commands == &qmp_cap_negotiation_commands) {
        qdict = qdict_get_qdict(qobject_to_qdict(rsp), "error");
        if (qdict
            && !g_strcmp0(qdict_get_try_str(qdict, "class"),
                    QapiErrorClass_lookup[ERROR_CLASS_COMMAND_NOT_FOUND])) {
            /* Provide a more useful error message */

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
