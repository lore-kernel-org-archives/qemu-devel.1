Received: from eggs.gnu.org ([2001:4830:134:3::10]:41863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckR6Q-0005YH-LB
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckR6N-0000Vu-I3
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:01:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ckR6N-0000Ui-8G
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:01:11 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-11-git-send-email-armbru@redhat.com>
	<dd7a93a5-87d5-83c9-b608-8511036ac394@amsat.org>
Date: Sun, 05 Mar 2017 09:01:07 +0100
In-Reply-To: <dd7a93a5-87d5-83c9-b608-8511036ac394@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 3 Mar 2017 16:55:22
	-0300")
Message-ID: <87efycduf0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/28] qmp: Improve QMP dispatch error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Markus,
>
> On 03/03/2017 09:32 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>  qapi/qmp-dispatch.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
>> index 23b0528..578c6d8 100644
>> --- a/qapi/qmp-dispatch.c
>> +++ b/qapi/qmp-dispatch.c
>> @@ -30,7 +30,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *re=
quest, Error **errp)
>>
>>      dict =3D qobject_to_qdict(request);
>>      if (!dict) {
>> -        error_setg(errp, "Expected '%s' in QMP input", "object");
>> +        error_setg(errp, "QMP input must be a JSON object");
>>          return NULL;
>>      }
>>
>> @@ -41,15 +41,17 @@ static QDict *qmp_dispatch_check_obj(const QObject *=
request, Error **errp)
>>
>>          if (!strcmp(arg_name, "execute")) {
>>              if (qobject_type(arg_obj) !=3D QTYPE_QSTRING) {
>> -                error_setg(errp, "QMP input object member '%s' expects =
'%s'",
>> -                           "execute", "string");
>> +                error_setg(errp,
>> +                           "QMP input object member '%s' must be %s",
>> +                           "execute", "a string");
>
> let's avoid formatting like the rest of this patch.
>
>>                  return NULL;
>>              }
>>              has_exec_key =3D true;
>>          } else if (!strcmp(arg_name, "arguments")) {
>>              if (qobject_type(arg_obj) !=3D QTYPE_QDICT) {
>> -                error_setg(errp, "QMP input object member '%s' expects =
'%s'",
>> -                           "arguments", "object");
>> +                error_setg(errp,
>> +                           "QMP input object member '%s' must be %s",
>> +                           "arguments", "an object");
>
> same.
>
>>                  return NULL;
>>              }
>>          } else {
>> @@ -60,7 +62,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *re=
quest, Error **errp)
>>      }
>>
>>      if (!has_exec_key) {
>> -        error_setg(errp, "Expected '%s' in QMP input", "execute");
>> +        error_setg(errp, "QMP input object lacks key 'execute'");
>>          return NULL;
>>      }
>>
>>

Since substantial other work depends on this series, it needs to go in
sooner rather than later.  I'm therefore *dropping* this patch from the
series.  We can then bikeshed^Wpolish to our heart's content without
holding up other work.

That said: what about this?

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index dc50212..5ad36f8 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -30,7 +30,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *reque=
st, Error **errp)
=20
     dict =3D qobject_to_qdict(request);
     if (!dict) {
-        error_setg(errp, "Expected '%s' in QMP input", "object");
+        error_setg(errp, "QMP input must be a JSON object");
         return NULL;
     }
=20
@@ -41,26 +41,26 @@ static QDict *qmp_dispatch_check_obj(const QObject *req=
uest, Error **errp)
=20
         if (!strcmp(arg_name, "execute")) {
             if (qobject_type(arg_obj) !=3D QTYPE_QSTRING) {
-                error_setg(errp, "QMP input object member '%s' expects '%s=
'",
-                           "execute", "string");
+                error_setg(errp,
+                           "QMP input member 'execute' must be a string");
                 return NULL;
             }
             has_exec_key =3D true;
         } else if (!strcmp(arg_name, "arguments")) {
             if (qobject_type(arg_obj) !=3D QTYPE_QDICT) {
-                error_setg(errp, "QMP input object member '%s' expects '%s=
'",
-                           "arguments", "object");
+                error_setg(errp,
+                           "QMP input member 'arguments' must be an object=
");
                 return NULL;
             }
         } else {
-            error_setg(errp, "QMP input object member '%s' is unexpected",
+            error_setg(errp, "QMP input member '%s' is unexpected",
                        arg_name);
             return NULL;
         }
     }
=20
     if (!has_exec_key) {
-        error_setg(errp, "Expected '%s' in QMP input", "execute");
+        error_setg(errp, "QMP input lacks member 'execute'");
         return NULL;
     }
=20
