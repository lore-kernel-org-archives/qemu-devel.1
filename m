Received: from eggs.gnu.org ([2001:4830:134:3::10]:55659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fuoPC-0006ZT-1p
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 20:32:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fuoOw-0007EC-BR
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 20:32:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57230
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fuoOv-00078O-Vp
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 20:32:02 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7T0TBKh089599
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 20:32:00 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2m5c7120ds-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 20:31:59 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 28 Aug 2018 18:31:59 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180825135724.8981-10-marcandre.lureau@redhat.com>
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
	<20180825135724.8981-10-marcandre.lureau@redhat.com>
Date: Tue, 28 Aug 2018 19:31:51 -0500
Message-Id: <153550271145.13636.15700383480080441540@sif>
Subject: Re: [Qemu-devel] [PATCH v3 9/9] qmp: common 'id' handling & make
 QGA conform to QMP spec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Quoting Marc-Andr=C3=A9 Lureau (2018-08-25 08:57:24)
> Let qmp_dispatch() copy the 'id' field. That way any qmp client will
> conform to the specification, including QGA. Furthermore, it
> simplifies the work for qemu monitor.
> =

> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  monitor.c           | 33 ++++++++++++---------------------
>  qapi/qmp-dispatch.c | 10 ++++++++--
>  tests/test-qga.c    | 13 +++++--------
>  3 files changed, 25 insertions(+), 31 deletions(-)
> =

> diff --git a/monitor.c b/monitor.c
> index 295866d3ec..7126e403b0 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -248,8 +248,6 @@ QEMUBH *qmp_dispatcher_bh;
>  struct QMPRequest {
>      /* Owner of the request */
>      Monitor *mon;
> -    /* "id" field of the request */
> -    QObject *id;
>      /*
>       * Request object to be handled or Error to be reported
>       * (exactly one of them is non-null)
> @@ -350,7 +348,6 @@ int monitor_read_password(Monitor *mon, ReadLineFunc =
*readline_func,
> =

>  static void qmp_request_free(QMPRequest *req)
>  {
> -    qobject_unref(req->id);
>      qobject_unref(req->req);
>      error_free(req->err);
>      g_free(req);
> @@ -4043,18 +4040,14 @@ static int monitor_can_read(void *opaque)
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
> =

> -static void monitor_qmp_dispatch(Monitor *mon, QObject *req, QObject *id)
> +static void monitor_qmp_dispatch(Monitor *mon, QObject *req)
>  {
>      Monitor *old_mon;
>      QDict *rsp;
> @@ -4079,7 +4072,7 @@ static void monitor_qmp_dispatch(Monitor *mon, QObj=
ect *req, QObject *id)
>          }
>      }
> =

> -    monitor_qmp_respond(mon, rsp, id);
> +    monitor_qmp_respond(mon, rsp);
>      qobject_unref(rsp);
>  }
> =

> @@ -4134,13 +4127,15 @@ static void monitor_qmp_bh_dispatcher(void *data)
>      /*  qmp_oob_enabled() might change after "qmp_capabilities" */
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
>          req_obj->err =3D NULL;
> -        monitor_qmp_respond(req_obj->mon, rsp, NULL);
> +        monitor_qmp_respond(req_obj->mon, rsp);
>          qobject_unref(rsp);
>      }
> =

> @@ -4167,8 +4162,7 @@ static void handle_qmp_command(void *opaque, QObjec=
t *req, Error *err)
> =

>      qdict =3D qobject_to(QDict, req);
>      if (qdict) {
> -        id =3D qobject_ref(qdict_get(qdict, "id"));
> -        qdict_del(qdict, "id");
> +        id =3D qdict_get(qdict, "id");
>      } /* else will fail qmp_dispatch() */
> =

>      if (req && trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND))=
 {
> @@ -4179,17 +4173,14 @@ static void handle_qmp_command(void *opaque, QObj=
ect *req, Error *err)
> =

>      if (qdict && qmp_is_oob(qdict)) {
>          /* OOB commands are executed immediately */
> -        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(id)
> -                                          ?: "");
> -        monitor_qmp_dispatch(mon, req, id);
> +        trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(id) ?: "");
> +        monitor_qmp_dispatch(mon, req);
>          qobject_unref(req);
> -        qobject_unref(id);
>          return;
>      }
> =

>      req_obj =3D g_new0(QMPRequest, 1);
>      req_obj->mon =3D mon;
> -    req_obj->id =3D id;
>      req_obj->req =3D req;
>      req_obj->err =3D err;
> =

> @@ -4224,7 +4215,7 @@ static void handle_qmp_command(void *opaque, QObjec=
t *req, Error *err)
> =

>      /*
>       * Put the request to the end of queue so that requests will be
> -     * handled in time order.  Ownership for req_obj, req, id,
> +     * handled in time order.  Ownership for req_obj, req,
>       * etc. will be delivered to the handler side.
>       */
>      g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 1d922e04f7..5f812bb9f2 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -58,6 +58,8 @@ static QDict *qmp_dispatch_check_obj(const QObject *req=
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
> @@ -165,11 +167,11 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *=
request,
>                      bool allow_oob)
>  {
>      Error *err =3D NULL;
> -    QObject *ret;
> +    QDict *dict =3D qobject_to(QDict, request);
> +    QObject *ret, *id =3D dict ? qdict_get(dict, "id") : NULL;
>      QDict *rsp;
> =

>      ret =3D do_qmp_dispatch(cmds, request, allow_oob, &err);
> -
>      if (err) {
>          rsp =3D qmp_error_response(err);
>      } else if (ret) {
> @@ -180,5 +182,9 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *re=
quest,
>          rsp =3D NULL;
>      }
> =

> +    if (rsp && id) {
> +        qdict_put_obj(rsp, "id", qobject_ref(id));
> +    }
> +
>      return rsp;
>  }
> diff --git a/tests/test-qga.c b/tests/test-qga.c
> index f69cdf6c03..e00c62f6f7 100644
> --- a/tests/test-qga.c
> +++ b/tests/test-qga.c
> @@ -225,18 +225,15 @@ static void test_qga_ping(gconstpointer fix)
>      qobject_unref(ret);
>  }
> =

> -static void test_qga_invalid_id(gconstpointer fix)
> +static void test_qga_id(gconstpointer fix)
>  {
>      const TestFixture *fixture =3D fix;
> -    QDict *ret, *error;
> -    const char *class;
> +    QDict *ret;
> =

>      ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-ping', 'id': 1}");
>      g_assert_nonnull(ret);
> -
> -    error =3D qdict_get_qdict(ret, "error");
> -    class =3D qdict_get_try_str(error, "class");
> -    g_assert_cmpstr(class, =3D=3D, "GenericError");
> +    qmp_assert_no_error(ret);
> +    g_assert_cmpint(qdict_get_int(ret, "id"), =3D=3D, 1);
> =

>      qobject_unref(ret);
>  }
> @@ -997,7 +994,7 @@ int main(int argc, char **argv)
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
> -- =

> 2.18.0.547.g1d89318c48
>=20
