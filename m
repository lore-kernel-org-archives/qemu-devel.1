Received: from eggs.gnu.org ([2001:4830:134:3::10]:46961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eyxMQ-0005SF-Ov
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eyxMP-0002Cp-18
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:22:18 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:45283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eyxMO-0002CP-MT
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 06:22:16 -0400
Received: by mail-wr0-x233.google.com with SMTP id h2so8099133wre.12
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 03:22:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-19-peterx@redhat.com>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-19-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 22 Mar 2018 11:22:14 +0100
Message-ID: <CAJ+F1CJ4w5q3j6EHeicPTbmPHE2hjndzqqr577DZDTpfKftd3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 18/23] qmp: support out-of-band (oob)
 execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Fri, Mar 9, 2018 at 10:00 AM, Peter Xu <peterx@redhat.com> wrote:
> Having "allow-oob" to true for a command does not mean that this command
> will always be run in out-of-band mode.  The out-of-band quick path will
> only be executed if we specify the extra "run-oob" flag when sending the
> QMP request:
>
>     { "execute":   "command-that-allows-oob",
>       "arguments": { ... },
>       "control":   { "run-oob": true } }
>
> The "control" key is introduced to store this extra flag.  "control"
> field is used to store arguments that are shared by all the commands,
> rather than command specific arguments.  Let "run-oob" be the first.
>
> Note that in the patch I exported qmp_dispatch_check_obj() to be used to
> check the request earlier, and at the same time allowed "id" field to be
> there since actually we always allow that.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h |  2 ++
>  monitor.c                   | 84 +++++++++++++++++++++++++++++++++++++++=
+-----
>  qapi/qmp-dispatch.c         | 33 +++++++++++++++++-
>  trace-events                |  2 ++
>  4 files changed, 111 insertions(+), 10 deletions(-)
>
> diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> index 26eb13ff41..ffb4652f71 100644
> --- a/include/qapi/qmp/dispatch.h
> +++ b/include/qapi/qmp/dispatch.h
> @@ -48,6 +48,8 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
>  const char *qmp_command_name(const QmpCommand *cmd);
>  bool qmp_has_success_response(const QmpCommand *cmd);
>  QObject *qmp_build_error_object(Error *err);
> +QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp);
> +bool qmp_is_oob(QDict *dict);
>
>  typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
>
> diff --git a/monitor.c b/monitor.c
> index 4d57a8d341..5c8afe9f50 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1110,6 +1110,44 @@ static void qmp_caps_apply(Monitor *mon, QMPCapabi=
lityList *list)
>      }
>  }
>
> +/*
> + * Return true if check successful, or false otherwise.  When false is
> + * returned, detailed error will be in errp if provided.
> + */
> +static bool qmp_cmd_oob_check(Monitor *mon, QDict *req, Error **errp)
> +{
> +    const char *command;
> +    QmpCommand *cmd;
> +
> +    command =3D qdict_get_try_str(req, "execute");
> +    if (!command) {
> +        error_setg(errp, "Command field 'execute' missing");
> +        return false;
> +    }
> +
> +    cmd =3D qmp_find_command(mon->qmp.commands, command);
> +    if (!cmd) {
> +        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
> +                  "The command %s has not been found", command);
> +        return false;
> +    }
> +
> +    if (qmp_is_oob(req)) {
> +        if (!qmp_oob_enabled(mon)) {
> +            error_setg(errp, "Please enable Out-Of-Band first "
> +                       "for the session during capabilities negociation"=
);
> +            return false;
> +        }
> +        if (!(cmd->options & QCO_ALLOW_OOB)) {
> +            error_setg(errp, "The command %s does not support OOB",
> +                       command);
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
>                            Error **errp)
>  {
> @@ -4001,6 +4039,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
>      QMPRequest *req_obj =3D monitor_qmp_requests_pop_one();
>
>      if (req_obj) {
> +        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?=
: "");
>          monitor_qmp_dispatch_one(req_obj);
>          /* Reschedule instead of looping so the main loop stays responsi=
ve */
>          qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
> @@ -4024,17 +4063,31 @@ static void handle_qmp_command(JSONMessageParser =
*parser, GQueue *tokens)
>          error_setg(&err, QERR_JSON_PARSING);
>      }
>      if (err) {
> -        monitor_qmp_respond(mon, NULL, err, NULL);
> -        qobject_decref(req);
> -        return;
> +        goto err;
> +    }
> +
> +    /* Check against the request in general layout */
> +    qdict =3D qmp_dispatch_check_obj(req, &err);
> +    if (!qdict) {
> +        goto err;
>      }
>
> -    qdict =3D qobject_to_qdict(req);
> -    if (qdict) {
> -        id =3D qdict_get(qdict, "id");
> -        qobject_incref(id);
> -        qdict_del(qdict, "id");
> -    } /* else will fail qmp_dispatch() */
> +    /* Check against OOB specific */
> +    if (!qmp_cmd_oob_check(mon, qdict, &err)) {
> +        goto err;
> +    }

This check happens before monitor_qmp_dispatch_one(), where there is
now dead code for COMMAND_NOT_FOUND error handling (changing the error
description), since it will error here.

A solution is to move the error manipulation code to monitor_qmp_respond():


diff --git a/monitor.c b/monitor.c
index 52b4c77ac3..df09a1657d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3997,6 +3997,18 @@ static void monitor_qmp_respond(Monitor *mon,
QObject *rsp,
             qdict_put_obj(qobject_to(QDict, rsp), "id", id);
         }

+        if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
+            qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error");
+            if (qdict
+                && !g_strcmp0(qdict_get_try_str(qdict, "class"),
+
QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND))) {
+                /* Provide a more useful error message */
+                qdict_del(qdict, "desc");
+                qdict_put_str(qdict, "desc", "Expecting capabilities
negotiation"
+                              " with 'qmp_capabilities'");
+            }
+        }
+
         monitor_json_emitter(mon, rsp);
     }

@@ -4022,7 +4034,6 @@ static void monitor_qmp_dispatch_one(QMPRequest
*req_obj, bool oob_cmd)
 {
     Monitor *mon, *old_mon;
     QObject *req, *rsp =3D NULL, *id;
-    QDict *qdict =3D NULL;
     bool need_resume;

     req =3D req_obj->req;
@@ -4045,18 +4056,6 @@ static void monitor_qmp_dispatch_one(QMPRequest
*req_obj, bool oob_cmd)

     cur_mon =3D old_mon;

-    if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
-        qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error");
-        if (qdict
-            && !g_strcmp0(qdict_get_try_str(qdict, "class"),
-                    QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND))) {
-            /* Provide a more useful error message */
-            qdict_del(qdict, "desc");
-            qdict_put_str(qdict, "desc", "Expecting capabilities negotiati=
on"
-                          " with 'qmp_capabilities'");
-        }
-    }
-
     /* Respond if necessary */
     monitor_qmp_respond(mon, rsp, NULL, id);


> +
> +    id =3D qdict_get(qdict, "id");
> +
> +    /* When OOB is enabled, the "id" field is mandatory. */
> +    if (qmp_oob_enabled(mon) && !id) {
> +        error_setg(&err, "Out-Of-Band capability requires that "
> +                   "every command contains an 'id' field");
> +        goto err;
> +    }
> +
> +    qobject_incref(id);
> +    qdict_del(qdict, "id");
>
>      req_obj =3D g_new0(QMPRequest, 1);
>      req_obj->mon =3D mon;
> @@ -4042,6 +4095,14 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
>      req_obj->req =3D req;
>      req_obj->need_resume =3D false;
>
> +    if (qmp_is_oob(qdict)) {
> +        /* Out-Of-Band (OOB) requests are executed directly in parser. *=
/
> +        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_obj->i=
d)
> +                                          ?: "");
> +        monitor_qmp_dispatch_one(req_obj);
> +        return;
> +    }
> +
>      /* Protect qmp_requests and fetching its length. */
>      qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
>
> @@ -4078,6 +4139,11 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
>
>      /* Kick the dispatcher routine */
>      qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
> +    return;
> +
> +err:
> +    monitor_qmp_respond(mon, NULL, err, NULL);
> +    qobject_decref(req);
>  }
>
>  static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index e31ac4be1f..9a2e18c768 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -17,8 +17,9 @@
>  #include "qapi/qmp/json-parser.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qjson.h"
> +#include "qapi/qmp/qbool.h"
>
> -static QDict *qmp_dispatch_check_obj(const QObject *request, Error **err=
p)
> +QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>  {
>      const QDictEntry *ent;
>      const char *arg_name;
> @@ -50,6 +51,14 @@ static QDict *qmp_dispatch_check_obj(const QObject *re=
quest, Error **errp)
>                             "QMP input member 'arguments' must be an obje=
ct");
>                  return NULL;
>              }
> +        } else if (!strcmp(arg_name, "id")) {
> +            continue;
> +        } else if (!strcmp(arg_name, "control")) {
> +            if (qobject_type(arg_obj) !=3D QTYPE_QDICT) {
> +                error_setg(errp,
> +                           "QMP input member 'control' must be a dict");
> +                return NULL;
> +            }
>          } else {
>              error_setg(errp, "QMP input member '%s' is unexpected",
>                         arg_name);
> @@ -120,6 +129,28 @@ QObject *qmp_build_error_object(Error *err)
>                                error_get_pretty(err));
>  }
>
> +/*
> + * Detect whether a request should be run out-of-band, by quickly
> + * peeking at whether we have: { "control": { "run-oob": True } }. By
> + * default commands are run in-band.
> + */
> +bool qmp_is_oob(QDict *dict)
> +{
> +    QBool *bool_obj;
> +
> +    dict =3D qdict_get_qdict(dict, "control");
> +    if (!dict) {
> +        return false;
> +    }
> +
> +    bool_obj =3D qobject_to_qbool(qdict_get(dict, "run-oob"));
> +    if (!bool_obj) {
> +        return false;
> +    }
> +
> +    return qbool_get_bool(bool_obj);
> +}
> +
>  QObject *qmp_dispatch(QmpCommandList *cmds, QObject *request)
>  {
>      Error *err =3D NULL;
> diff --git a/trace-events b/trace-events
> index fe10c3b487..bd036da278 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -48,6 +48,8 @@ monitor_protocol_event_queue(uint32_t event, void *qdic=
t, uint64_t rate) "event=3D
>  handle_hmp_command(void *mon, const char *cmdline) "mon %p cmdline: %s"
>  handle_qmp_command(void *mon, const char *req) "mon %p req: %s"
>  monitor_suspend(void *ptr, int cnt) "mon %p: %d"
> +monitor_qmp_cmd_in_band(const char *id) "%s"
> +monitor_qmp_cmd_out_of_band(const char *id) "%s"
>
>  # dma-helpers.c
>  dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=3D%p b=
s=3D%p offset=3D%" PRId64 " to_dev=3D%d"
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
