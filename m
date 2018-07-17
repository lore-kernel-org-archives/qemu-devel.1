Received: from eggs.gnu.org ([2001:4830:134:3::10]:39611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffSTs-0006JX-3k
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffSTm-0007vf-Qo
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:05:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ffSTm-0007vL-DX
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:05:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-13-marcandre.lureau@redhat.com>
Date: Tue, 17 Jul 2018 18:05:31 +0200
In-Reply-To: <20180706121354.2021-13-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 6 Jul 2018 14:13:54 +0200")
Message-ID: <87a7qpc0fo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/12] RFC: qmp: rework 'id' handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Copying the guest agent maintainer Michael Roth.

Patch needs a rebase.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Let qmp_dispatch() copy the 'id' field. That way any qmp client will
> conform to the specification, including QGA.

Before this patch, users of the common core shared by QMP and QGA have
to do extra work to conform to qmp-spec.txt.  QMP does, QGA doesn't.
I'm inclined to consider that a bug.

Judging from your description, this patch moves that work into the
shared part.  The patch is therefore not just a rework of 'id' handling,
it's a QGA bug fix, if you're so inclined, else a QGA improvement.

Thus, 1. please rephrase the commit message accordingly, and 2. the
patch needs Michael's approval.

>                                              Furthermore, it
> simplifies the work for qemu monitor.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c           | 31 ++++++++++++-------------------
>  qapi/qmp-dispatch.c | 10 ++++++++--
>  tests/test-qga.c    | 13 +++++--------
>  3 files changed, 25 insertions(+), 29 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index a3efe96d1d..bf192697e4 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -249,8 +249,6 @@ QEMUBH *qmp_dispatcher_bh;
>  struct QMPRequest {
>      /* Owner of the request */
>      Monitor *mon;
> -    /* "id" field of the request */
> -    QObject *id;
>      /*
>       * Request object to be handled or Error to be reported
>       * (exactly one of them is non-null)
> @@ -351,7 +349,6 @@ int monitor_read_password(Monitor *mon, ReadLineFunc =
*readline_func,
>=20=20
>  static void qmp_request_free(QMPRequest *req)
>  {
> -    qobject_unref(req->id);
>      qobject_unref(req->req);
>      error_free(req->err);
>      g_free(req);
> @@ -3991,18 +3988,14 @@ static int monitor_can_read(void *opaque)
>   * Null @rsp can only happen for commands with QCO_NO_SUCCESS_RESP.
>   * Nothing is emitted then.
>   */
> -static void monitor_qmp_respond(Monitor *mon, QDict *rsp, QObject *id)
> +static void monitor_qmp_respond(Monitor *mon, QDict *rsp)
>  {
>      if (rsp) {
> -        if (id) {
> -            qdict_put_obj(rsp, "id", qobject_ref(id));
> -        }
> -
>          qmp_send_response(mon, rsp);
>      }
>  }
>=20=20
> -static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id)
> +static void monitor_qmp_dispatch(Monitor *mon, QObject *req)
>  {
>      Monitor *old_mon;
>      QDict *rsp;
> @@ -4027,7 +4020,7 @@ static void monitor_qmp_dispatch(Monitor *mon, QObj=
ect *req, QObject *id)
>          }
>      }
>=20=20
> -    monitor_qmp_respond(mon, rsp, id);
> +    monitor_qmp_respond(mon, rsp);
>      qobject_unref(rsp);
>  }
>=20=20
> @@ -4081,12 +4074,15 @@ static void monitor_qmp_bh_dispatcher(void *data)
>=20=20
>      need_resume =3D !qmp_oob_enabled(req_obj->mon);
>      if (req_obj->req) {
> -        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?=
: "");
> -        monitor_qmp_dispatch(req_obj->mon, req_obj->req, req_obj->id);
> +        QDict *qdict =3D qobject_to(QDict, req_obj->req);
> +        QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
> +        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "");
> +        monitor_qmp_dispatch(req_obj->mon, req_obj->req);
>      } else {
>          assert(req_obj->err);
>          rsp =3D qmp_error_response(req_obj->err);
> -        monitor_qmp_respond(req_obj->mon, rsp, NULL);
> +        req_obj->err =3D NULL;
> +        monitor_qmp_respond(req_obj->mon, rsp);

Error response without ID before and after the patch.  Okay.

>          qobject_unref(rsp);
>      }
>=20=20
> @@ -4115,8 +4111,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
>=20=20
>      qdict =3D qobject_to(QDict, req);
>      if (qdict) {
> -        id =3D qobject_ref(qdict_get(qdict, "id"));
> -        qdict_del(qdict, "id");
> +        id =3D qdict_get(qdict, "id");
>      } /* else will fail qmp_dispatch() */

Two users of @id remain: trace_monitor_qmp_cmd_out_of_band(), visible
below, and qapi_event_send_command_dropped().  We currently plan to kill
the latter.  The former is guarded by if (qdict && qmp_is_oob(qdict)),
and could therefore safely use qdict_get(qdict, "id").  Together, this
will let us delete the whole conditional here.

>=20=20
>      if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
> @@ -4127,15 +4122,13 @@ static void handle_qmp_command(JSONMessageParser =
*parser, GQueue *tokens)
>=20=20
>      if (qdict && qmp_is_oob(qdict)) {
>          /* OOB commands are executed immediately */
> -        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(id)
> -                                          ?: "");
> -        monitor_qmp_dispatch(mon, req, id);
> +        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(id) ?: "");
> +        monitor_qmp_dispatch(mon, req);
>          return;
>      }
>=20=20
>      req_obj =3D g_new0(QMPRequest, 1);
>      req_obj->mon =3D mon;
> -    req_obj->id =3D id;
>      req_obj->req =3D req;
>      req_obj->err =3D err;
>=20=20
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 90ba5e3074..acea0fcfcd 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -59,6 +59,8 @@ static QDict *qmp_dispatch_check_obj(const QObject *req=
uest, bool allow_oob,
>                             "QMP input member 'arguments' must be an obje=
ct");
>                  return NULL;
>              }
> +        } else if (!strcmp(arg_name, "id")) {
> +            continue;
>          } else {
>              error_setg(errp, "QMP input member '%s' is unexpected",
>                         arg_name);
> @@ -166,8 +168,8 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *re=
quest,
>                      bool allow_oob)
>  {
>      Error *err =3D NULL;
> -    QObject *ret;
> -    QDict *rsp;
> +    QDict *rsp, *dict =3D qobject_to(QDict, request);
> +    QObject *ret, *id =3D dict ? qdict_get(dict, "id") : NULL;

I dislike mixing initialized and uninitialized variables in the same
declaration.

>=20=20
>      ret =3D do_qmp_dispatch(cmds, request, allow_oob, &err);
>=20=20
> @@ -181,5 +183,9 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *re=
quest,
>          rsp =3D NULL;
>      }
>=20=20
> +    if (rsp && id) {
> +        qdict_put_obj(rsp, "id", qobject_ref(id));
> +    }
> +
>      return rsp;
>  }

This puts the ID (if any) into the response.  Good.

The monitor sends command responses only with monitor_qmp_respond().
It's called on two places:

* monitor_qmp_dispatch()

  Gets its response from qmp_dispatch(), which now puts the ID (if any).

* monitor_qmp_bh_dispatcher()

  Error response without ID before and after the patch (see above).

Good.

Not visible in the patch: QGA.  It sends command responses only with
send_response().  Called only in process_event().  Two cases:

* json_parser_parse_err() sets an error

  Error response without ID before and after the patch

* qmp_dispatch()

  Now puts the ID (if any).  This is the externally visible change.

Good.

> diff --git a/tests/test-qga.c b/tests/test-qga.c
> index d638b1571a..4ee8b405f4 100644
> --- a/tests/test-qga.c
> +++ b/tests/test-qga.c
> @@ -227,18 +227,15 @@ static void test_qga_ping(gconstpointer fix)
>      qobject_unref(ret);
>  }
>=20=20
> -static void test_qga_invalid_id(gconstpointer fix)
> +static void test_qga_id(gconstpointer fix)
>  {
>      const TestFixture *fixture =3D fix;
> -    QDict *ret, *error;
> -    const char *class;
> +    QDict *ret;
>=20=20
>      ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-ping', 'id': 1}");
>      g_assert_nonnull(ret);
> -
> -    error =3D qdict_get_qdict(ret, "error");
> -    class =3D qdict_get_try_str(error, "class");
> -    g_assert_cmpstr(class, =3D=3D, "GenericError");
> +    qmp_assert_no_error(ret);
> +    g_assert_cmpint(qdict_get_int(ret, "id"), =3D=3D, 1);
>=20=20
>      qobject_unref(ret);
>  }
> @@ -1014,7 +1011,7 @@ int main(int argc, char **argv)
>      g_test_add_data_func("/qga/file-ops", &fix, test_qga_file_ops);
>      g_test_add_data_func("/qga/file-write-read", &fix, test_qga_file_wri=
te_read);
>      g_test_add_data_func("/qga/get-time", &fix, test_qga_get_time);
> -    g_test_add_data_func("/qga/invalid-id", &fix, test_qga_invalid_id);
> +    g_test_add_data_func("/qga/id", &fix, test_qga_id);
>      g_test_add_data_func("/qga/invalid-oob", &fix, test_qga_invalid_oob);
>      g_test_add_data_func("/qga/invalid-cmd", &fix, test_qga_invalid_cmd);
>      g_test_add_data_func("/qga/invalid-args", &fix, test_qga_invalid_arg=
s);
