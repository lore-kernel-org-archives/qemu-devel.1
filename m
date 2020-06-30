Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7649C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 18:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86AF2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 18:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6eIWyZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86AF2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqL4F-00036o-Qf
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 14:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqL3E-0002d2-2L
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 14:32:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqL3B-0007O0-4G
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 14:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593541925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P05tAodN1Xip3ZXeHeuWJtzG6B+gTD8OmmFBWdJQzBw=;
 b=h6eIWyZ4SRzIhc51fm4K8fCxzVxeDbw+XXNeN2VgA+dsOYzpLWcfbJPW4VF5KzjTvq+aEt
 CXG5Oceb+E9KlyL1kWs7fe8gSgLjW/fOBePZUsS6p0JOFfExrI0TOPoDyBfwQut/OUPc61
 5E2dz7BiYrwEGYRkzHhOflJ2KljW64U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-tpWV5a2JPOeupzw6vK7a3w-1; Tue, 30 Jun 2020 14:31:57 -0400
X-MC-Unique: tpWV5a2JPOeupzw6vK7a3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF356804003;
 Tue, 30 Jun 2020 18:31:54 +0000 (UTC)
Received: from localhost (ovpn-112-113.ams2.redhat.com [10.36.112.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 947A97BED1;
 Tue, 30 Jun 2020 18:31:48 +0000 (UTC)
Date: Tue, 30 Jun 2020 19:31:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 07/21] multi-process: add co-routines to communicate
 with remote
Message-ID: <20200630183147.GA111989@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <d7013c71ba09fb73bc61a725088bebd91f0fda30.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <d7013c71ba09fb73bc61a725088bebd91f0fda30.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 10:09:29AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> process to avoid blocking the main loop during the message exchanges.
> To be used by proxy device.

The nested aio_poll() in this patch could be a problem. I've highlighted
it here so that others skimming through this series can join the
discussion without reading all my review comments:

  qemu_coroutine_enter(req.co);
  while (!req.finished) {
      aio_poll(qemu_get_aio_context(), false);

This is called from the proxy device, which means the vCPU thread. The
QEMU global mutex is held here.

aio_poll() does not release the mutex, so other vCPU threads will not be
able to run QEMU code until mpqemu_msg_send_reply_co() completes and the
QEMU global mutex has been released again.

Our goal is to do blocking socket I/O here since our vCPU thread cannot
make progress until the remote device replies. This means we can forget
about QEMU's event loop and simply do blocking I/O from the vCPU thread.
The QEMU global mutex can be dropped around the send/recv but a
per-socket mutex is needed to protect against multiple vCPU threads
interleaving requests.

I think this boils down to:

  /*
   * Blocking version of send+recv for the proxy device. Called from
   * vCPU thread where we cannot make progress until the remote device
   * has replied. Releases and re-acquires the QEMU global mutex.
   */
  uint64_t mpqemu_msg_send_and_await_reply(MPQemuMsg *msg, QIOChannel *ioc,
                                           Error **errp)
  {
      uint64_t ret;

      qemu_mutex_unlock_iothread();

      qemu_mutex_lock(&mplink->io_mutex);
      blocking_send(ioc, msg);
      ret =3D blocking_recv(ioc);
      qemu_mutex_unlock(&mplink->io_mutex);

      qemu_mutex_lock_iothread();

      return ret;
  }

This is very simple! The tricky thing is combining this approach with
mplink I/O that happens in the event loop. The heartbeat is one example.
I don't remember the protocol details enough to know how the other
message exchanges work. Code running in the event loop is not allowed to
block, so it really needs to use coroutines.

>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  include/io/mpqemu-link.h | 16 +++++++++
>  io/mpqemu-link.c         | 78 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
>=20
> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
> index 1542e8ed07..52aa89656c 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -17,6 +17,7 @@
>  #include "qom/object.h"
>  #include "qemu/thread.h"
>  #include "io/channel.h"
> +#include "io/channel-socket.h"
> =20
>  #define REMOTE_MAX_FDS 8
> =20
> @@ -30,6 +31,7 @@
>   */
>  typedef enum {
>      INIT =3D 0,
> +    RET_MSG,
>      MAX =3D INT_MAX,
>  } MPQemuCmd;
> =20
> @@ -67,6 +69,20 @@ typedef struct {
>      uint8_t *data2;
>  } MPQemuMsg;
> =20
> +struct MPQemuRequest {
> +    MPQemuMsg *msg;
> +    QIOChannelSocket *sioc;
> +    Coroutine *co;
> +    bool finished;
> +    int error;
> +    long ret;
> +};
> +
> +typedef struct MPQemuRequest MPQemuRequest;
> +
> +uint64_t mpqemu_msg_send_reply_co(MPQemuMsg *msg, QIOChannel *ioc,

This function sends a message and waits for the reply. The name confuses
me, I would guess that this function sends a reply. Perhaps
mpqemu_msg_send_and_await_reply() is a clearer name.

> +                                  Error **errp);

Functions with "co" in their name run in coroutine context. This
function does not. Please remove the _co from the name to avoid
confusion.

> +
>  void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc);
>  int mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc);
> =20
> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
> index bfc542b5fd..c430b4d6a2 100644
> --- a/io/mpqemu-link.c
> +++ b/io/mpqemu-link.c
> @@ -16,6 +16,8 @@
>  #include "qapi/error.h"
>  #include "qemu/iov.h"
>  #include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
> +#include "io/channel-socket.h"
> =20
>  void mpqemu_msg_send(MPQemuMsg *msg, QIOChannel *ioc)
>  {
> @@ -118,6 +120,82 @@ int mpqemu_msg_recv(MPQemuMsg *msg, QIOChannel *ioc)
>      return 0;
>  }
> =20
> +/* Use in proxy only as it clobbers fd handlers. */
> +static void coroutine_fn mpqemu_msg_send_co(void *data)
> +{
> +    MPQemuRequest *req =3D (MPQemuRequest *)data;
> +    MPQemuMsg msg_reply =3D {0};
> +    long ret =3D -EINVAL;
> +
> +    if (!req->sioc) {
> +        error_report("No channel available to send command %d",
> +                     req->msg->cmd);

Can this ever happen?

> +        atomic_mb_set(&req->finished, true);

Why is atomic_mb_set() used here?

> +        req->error =3D -EINVAL;
> +        return;
> +    }
> +
> +    req->co =3D qemu_coroutine_self();
> +    mpqemu_msg_send(req->msg, QIO_CHANNEL(req->sioc));
> +
> +    yield_until_fd_readable(req->sioc->fd);
> +
> +    ret =3D mpqemu_msg_recv(&msg_reply, QIO_CHANNEL(req->sioc));

mpqemu_msg_recv() already yields when called from a coroutine. Why is
yield_until_fd_readable() called explicitly here?

After removing the yield_until_fd_readable() it will also be possible to
use QIOChannel instead of the more specific QIOChannelSocket. That will
make the code a little simpler because the QIO_CHANNEL() casts can be
removed.

> +    if (ret < 0) {
> +        error_report("ERROR: failed to get a reply for command %d, \
> +                     errno %s, ret is %ld",

C doesn't support backslash string wrapping in a useful way. The
backslash tells the preprocessor to wrap the line but the string will
contain the leading whitespace.

This format string is equivalent to:

  "ERROR: failed to get a reply for command %d,                    errno %s=
, ret is %ld"

A common way of wrapping strings is:

  error_report("ERROR: failed to get a reply for command %d, "
               "errno %s, ret is %ld",

> +                     req->msg->cmd, strerror(errno), ret);
> +        req->error =3D -errno;

s/errno/ret/

> +    } else {
> +        if (!mpqemu_msg_valid(&msg_reply) || msg_reply.cmd !=3D RET_MSG)=
 {
> +            error_report("ERROR: Invalid reply received for command %d",
> +                         req->msg->cmd);
> +            req->error =3D -EINVAL;
> +        } else {
> +            req->ret =3D msg_reply.data1.u64;
> +        }
> +    }
> +    atomic_mb_set(&req->finished, true);
> +}
> +
> +/*
> + * Create if needed and enter co-routine to send the message to the
> + * remote channel ioc and wait for the reply.
> + * Resturns the value from the reply message, sets the error on failure.

s/Resturns/Returns/

> + */
> +
> +uint64_t mpqemu_msg_send_reply_co(MPQemuMsg *msg, QIOChannel *ioc,
> +                                  Error **errp)
> +{
> +    MPQemuRequest req =3D {0};
> +    uint64_t ret =3D UINT64_MAX;
> +
> +    req.sioc =3D QIO_CHANNEL_SOCKET(ioc);
> +    if (!req.sioc) {
> +        return ret;

The doc comment says "sets the error on failure" but this error return
does not set errp.

> +    }
> +
> +    req.msg =3D msg;
> +    req.ret =3D 0;
> +    req.finished =3D false;
> +
> +    if (!req.co) {

req.co is always NULL here because it's a local variable initialized to
0 at the beginning of this function.

> +        req.co =3D qemu_coroutine_create(mpqemu_msg_send_co, &req);
> +    }
> +
> +    qemu_coroutine_enter(req.co);
> +    while (!req.finished) {
> +        aio_poll(qemu_get_aio_context(), false);

The second argument must be true so that aio_poll() waits for activity
instead of returning immediately. If it returns immediately then this
loop will consume 100% CPU.

> +    }
> +    if (req.error) {
> +        error_setg(errp, "Error exchanging message with remote process, =
"\
> +                        "socket %d, error %d", req.sioc->fd, req.error);
> +    }
> +    ret =3D req.ret;
> +
> +    return ret;
> +}
> +
>  bool mpqemu_msg_valid(MPQemuMsg *msg)
>  {
>      if (msg->cmd >=3D MAX && msg->cmd < 0) {
> --=20
> 2.25.GIT
>=20

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl77hRIACgkQnKSrs4Gr
c8hcgQf/V7bb7CXcLGlDoin2LT3Z8bbYLWgxy49XzZHL/02ZDzIaZJ/5Y3oFC8iQ
DR//Ovv9F28rosYYPMqTjEjiJYSxrYH+VmD6amzWKoZvjioEfV1t75JKhECuZHhq
NrDzR0JiI+u0pKUEXnll2QQy4xVrV9JDxSo4nyk4f/EBjgIEsadRSyXiQz5lNNkj
BkyphGr1wirBtqQ2QTiFtDQfJRoagfaS4C31wzPbi2soE2HF7iy/03Ujlxv2Vmyw
9MgAkzKf4Ax0WuxkWgrxe1gOChtzGNhTM1eCoCxPLvgXzHLs/j2eiWb88UIxD/8o
eNJVJcdNjXhSSB+VY934/F4Kk9NyoQ==
=b1B6
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--


