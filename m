Received: from eggs.gnu.org ([2001:4830:134:3::10]:58627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezOjT-0008U3-J3
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezOjQ-0001wX-CJ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:35:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ezOjQ-0001vg-7E
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:35:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72EAC8182D2E
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 15:35:48 +0000 (UTC)
Date: Fri, 23 Mar 2018 23:35:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180323153537.GS32362@xz-mi>
References: <20180323103239.32414-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180323103239.32414-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: fix expected qmp_capabilities
 error description regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com

On Fri, Mar 23, 2018 at 11:32:39AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Fix regression introduced in commit cf869d53172920536a14180a83292b240e9=
d0545:
>=20
> Before:
> {"execute":"foo"}
> {"error": {"class": "CommandNotFound", "desc": "Expecting capabilities =
negotiation with 'qmp_capabilities'"}}
>=20
> After:
> {"execute":"foo"}
> {"error": {"class": "CommandNotFound", "desc": "The command foo has not=
 been found"}}
>=20
> Because qmp_cmd_oob_check() happens before
> monitor_qmp_dispatch_one(). Move the error manipulation code to
> monitor_qmp_respond() instead.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index 6ccd2fc089..d57bbbb134 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3997,6 +3997,18 @@ static void monitor_qmp_respond(Monitor *mon, QO=
bject *rsp,
>              qdict_put_obj(qobject_to(QDict, rsp), "id", id);
>          }
> =20
> +        if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
> +            qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error")=
;
> +            if (qdict
> +                && !g_strcmp0(qdict_get_try_str(qdict, "class"),
> +                          QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_F=
OUND))) {
> +                /* Provide a more useful error message */
> +                qdict_del(qdict, "desc");
> +                qdict_put_str(qdict, "desc", "Expecting capabilities"
> +                              " negotiation with 'qmp_capabilities'");
> +            }
> +        }
> +

If we are going to remove below chunk, how about do it in prettier
way instead of hacking around the error again?  Like:

diff --git a/monitor.c b/monitor.c
index 77f4c41cfa..849fa23bf9 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1203,8 +1203,14 @@ static bool qmp_cmd_oob_check(Monitor *mon, QDict =
*req, Error **errp)
=20
     cmd =3D qmp_find_command(mon->qmp.commands, command);
     if (!cmd) {
-        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
-                  "The command %s has not been found", command);
+        if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
+            error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+                      "Expecting capabilities negotiation "
+                      "with 'qmp_capabilities'");
+        } else {
+            error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+                      "The command %s has not been found", command);
+        }
         return false;
     }
=20
What do you think?

Thanks,

>          monitor_json_emitter(mon, rsp);
>      }
> =20
> @@ -4028,7 +4040,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *=
req_obj)
>  {
>      Monitor *mon, *old_mon;
>      QObject *req, *rsp =3D NULL, *id;
> -    QDict *qdict =3D NULL;
>      bool need_resume;
> =20
>      req =3D req_obj->req;
> @@ -4051,18 +4062,6 @@ static void monitor_qmp_dispatch_one(QMPRequest =
*req_obj)
> =20
>      cur_mon =3D old_mon;
> =20
> -    if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
> -        qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error");
> -        if (qdict
> -            && !g_strcmp0(qdict_get_try_str(qdict, "class"),
> -                    QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND))=
) {
> -            /* Provide a more useful error message */
> -            qdict_del(qdict, "desc");
> -            qdict_put_str(qdict, "desc", "Expecting capabilities negot=
iation"
> -                          " with 'qmp_capabilities'");
> -        }
> -    }
> -
>      /* Respond if necessary */
>      monitor_qmp_respond(mon, rsp, NULL, id);
> =20
> --=20
> 2.17.0.rc1.1.g4c4f2b46a3
>=20

--=20
Peter Xu
