Received: from eggs.gnu.org ([2001:4830:134:3::10]:52141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fbI0p-0004P9-Fe
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 00:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fbI0m-00067X-Ax
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 00:06:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fbI0m-00066a-5a
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 00:06:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AE884075386
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 04:06:23 +0000 (UTC)
Date: Fri, 6 Jul 2018 12:06:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180706040612.GF23001@xz-mi>
References: <20180705164201.9853-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180705164201.9853-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: fix double-free of request error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Thu, Jul 05, 2018 at 06:42:01PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> qmp_error_response() will free the given error. Fix double-free in
> later qmp_request_free().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

And not related to current patch...

> ---
>  monitor.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/monitor.c b/monitor.c
> index 3c9c97b73f..7af1f18d13 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4186,6 +4186,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
>      } else {
>          assert(req_obj->err);
>          rsp =3D qmp_error_response(req_obj->err);
> +        req_obj->err =3D NULL;
>          monitor_qmp_respond(req_obj->mon, rsp, NULL);

... here not sure whether we should just pass in req_obj->id instead
of NULL, or maybe we can do some more assertions like:

diff --git a/monitor.c b/monitor.c
index 9eb9f06599..04d2c50f4e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4215,10 +4215,12 @@ static void monitor_qmp_bh_dispatcher(void *data)
=20
     mon =3D req_obj->mon;
     if (req_obj->req) {
+        assert(!req_obj->err);
         trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?=
: "");
         monitor_qmp_dispatch(mon, req_obj->req, req_obj->id);
     } else {
         assert(req_obj->err);
+        assert(!req_obj->id);
         rsp =3D qmp_error_response(req_obj->err);
         monitor_qmp_respond(mon, rsp, NULL);
         qobject_unref(rsp);

Thanks,

--=20
Peter Xu
