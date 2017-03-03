Received: from eggs.gnu.org ([2001:4830:134:3::10]:54506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjt1c-00018W-QX
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjt1Z-0005py-O1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:38:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjt1Z-0005pd-F5
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:37:57 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82E3DC049D59
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 19:37:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-6-git-send-email-armbru@redhat.com>
	<96e019e3-7fe9-7ce6-ea57-28dd77d0f7cb@redhat.com>
Date: Fri, 03 Mar 2017 20:37:54 +0100
In-Reply-To: <96e019e3-7fe9-7ce6-ea57-28dd77d0f7cb@redhat.com> (Eric Blake's
	message of "Fri, 3 Mar 2017 12:24:12 -0600")
Message-ID: <87h93ajgml.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 05/28] qapi: Support multiple command
 registries per program
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
>> The command registry encapsulates a single command list.  Give the
>> functions using it a parameter instead.  Define suitable command lists
>> in monitor, guest agent and test-qmp-commands.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/qapi/qmp/dispatch.h | 22 ++++++++++++++--------
>>  monitor.c                   | 31 +++++++++++++++++--------------
>>  qapi/qmp-dispatch.c         | 17 +++++++++++++----
>>  qapi/qmp-registry.c         | 37 ++++++++++++++++++-------------------
>>  qga/commands.c              |  2 +-
>>  qga/guest-agent-core.h      |  2 ++
>>  qga/main.c                  | 19 ++++++++++---------
>>  scripts/qapi-commands.py    | 16 ++++++++++------
>>  tests/test-qmp-commands.c   | 12 +++++++-----
>>  9 files changed, 92 insertions(+), 66 deletions(-)
>> 
>
>> +++ b/qapi/qmp-dispatch.c
>> @@ -67,7 +67,11 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>>      return dict;
>>  }
>>  
>> -static QObject *do_qmp_dispatch(QObject *request, Error **errp)
>> +volatile QmpCommand *save_cmd;
>
> A comment why volatile is necessary would be nice...

Uh...

>> +QmpCommand cmd2;
>> +
>> +static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
>> +                                Error **errp)
>>  {
>>      Error *local_err = NULL;
>>      const char *command;
>> @@ -81,7 +85,7 @@ static QObject *do_qmp_dispatch(QObject *request, Error **errp)
>>      }
>>  
>>      command = qdict_get_str(dict, "execute");
>> -    cmd = qmp_find_command(command);
>> +    cmd = qmp_find_command(cmds, command);
>>      if (cmd == NULL) {
>>          error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
>>                    "The command %s has not been found", command);
>> @@ -93,6 +97,9 @@ static QObject *do_qmp_dispatch(QObject *request, Error **errp)
>>          return NULL;
>>      }
>>  
>> +    assert(!cmd->options & QCO_NO_SUCCESS_RESP);
>> +    save_cmd = cmd;
>> +    cmd2 = *cmd;
>>      if (!qdict_haskey(dict, "arguments")) {
>>          args = qdict_new();
>>      } else {
>> @@ -111,6 +118,8 @@ static QObject *do_qmp_dispatch(QObject *request, Error **errp)
>>  
>>      QDECREF(args);
>>  
>> +    assert(!cmd->options & QCO_NO_SUCCESS_RESP);
>> +    assert(ret || local_err);
>
> ...or is this leftovers from your debugging?

Corret.  I'll drop it.

> The rest of the patch looks fine; it is converting a global variable
> into a per-instance variable.

Squashing in the obvious garbage collection.  May I add your R-by?



diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 95a0f48..72827a3 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -67,9 +67,6 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
     return dict;
 }
 
-volatile QmpCommand *save_cmd;
-QmpCommand cmd2;
-
 static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
                                 Error **errp)
 {
@@ -97,9 +94,6 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
         return NULL;
     }
 
-    assert(!cmd->options & QCO_NO_SUCCESS_RESP);
-    save_cmd = cmd;
-    cmd2 = *cmd;
     if (!qdict_haskey(dict, "arguments")) {
         args = qdict_new();
     } else {
@@ -118,8 +112,6 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
 
     QDECREF(args);
 
-    assert(!cmd->options & QCO_NO_SUCCESS_RESP);
-    assert(ret || local_err);
     return ret;
 }
 
