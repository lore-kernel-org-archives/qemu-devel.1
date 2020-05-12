Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A119CC54E8E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B60120736
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIexSalV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B60120736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYS3q-0001As-HJ
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 06:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYS2Z-0000G1-Om
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:21:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25557
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYS2Y-0003ek-MF
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589278893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yUI3MlH0FkHX0P1T/HMA3w8UgqL4KXG3R/8t0MQ0Gzk=;
 b=OIexSalV2C5aJQUOJfazw0735UNzsC1JZ8q0aL2NsmBcyQzX1TrUQJ/+XFsMpqJXgFY8Jp
 cI4JVdymW5CHLnb4gWK19HVmKMIIuz/KeKH2Fzz2V7WwVzfydq2KnyxL3OiaJOm6gEEZut
 ayymBtu/WH/3HXjyzgCauakz8Ugf4W8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-QLCGZlRqPS-NTWfKxKpB9Q-1; Tue, 12 May 2020 06:21:29 -0400
X-MC-Unique: QLCGZlRqPS-NTWfKxKpB9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54B1D18FF66C;
 Tue, 12 May 2020 10:21:27 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 699745D9DD;
 Tue, 12 May 2020 10:21:21 +0000 (UTC)
Date: Tue, 12 May 2020 11:21:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 12/36] multi-process: add functions to
 synchronize proxy and remote endpoints
Message-ID: <20200512102120.GC300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <7542e59e646421515051902fcd05fbb69fa4d866.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <7542e59e646421515051902fcd05fbb69fa4d866.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:47PM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> In some cases, for example MMIO read, QEMU has to wait for the remote to
> complete a command before proceeding. An eventfd based mechanism is
> added to synchronize QEMU & remote process.

Why are temporary eventfds used instead of sending a reply message from
the remote device program back to QEMU?

> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  include/io/mpqemu-link.h |  7 +++++
>  io/mpqemu-link.c         | 61 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>=20
> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
> index af401e640c..ef95599bca 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -124,4 +124,11 @@ void mpqemu_link_set_callback(MPQemuLinkState *s,
>  void mpqemu_start_coms(MPQemuLinkState *s, MPQemuChannel* chan);
>  bool mpqemu_msg_valid(MPQemuMsg *msg);
> =20
> +#define GET_REMOTE_WAIT eventfd(0, EFD_CLOEXEC)
> +#define PUT_REMOTE_WAIT(wait) close(wait)

Hiding this in macros makes the code harder to understand.

Why is an eventfd necessary instead of a reply message? It's simpler and
probably faster to use a reply message instead of creating and passing
temporary eventfds.

> +#define PROXY_LINK_WAIT_DONE 1
> +
> +uint64_t wait_for_remote(int efd);
> +void notify_proxy(int fd, uint64_t val);
> +
>  #endif
> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
> index 48f53a8928..cc0a7aecd4 100644
> --- a/io/mpqemu-link.c
> +++ b/io/mpqemu-link.c
> @@ -10,6 +10,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include <poll.h>
> =20
>  #include "qemu/module.h"
>  #include "io/mpqemu-link.h"
> @@ -204,6 +205,66 @@ int mpqemu_msg_recv(MPQemuMsg *msg, MPQemuChannel *c=
han)
>      return rc;
>  }
> =20
> +/*
> + * wait_for_remote() Synchronizes QEMU and the remote process. The maxim=
um
> + *                   wait time is 1s, after which the wait times out.
> + *                   The function alse returns a 64 bit return value aft=
er
> + *                   the wait. The function uses eventfd() to do the wai=
t
> + *                   and pass the return values. eventfd() can't return =
a
> + *                   value of '0'. Therefore, all return values are offs=
et
> + *                   by '1' at the sending end, and corrected at the
> + *                   receiving end.
> + */
> +
> +uint64_t wait_for_remote(int efd)
> +{
> +    struct pollfd pfd =3D { .fd =3D efd, .events =3D POLLIN };
> +    uint64_t val;
> +    int ret;
> +
> +    ret =3D poll(&pfd, 1, 1000);

This 1 second blocking operation is not allowed in an event loop since
it will stall any other event loop activity. If locks are held then
other threads may also be stalled.

It's likely that this will need to change as part of the QEMU event loop
integration. Caller code can be kept mostly unchanged if you use
coroutines.

> +
> +    switch (ret) {
> +    case 0:
> +        qemu_log_mask(LOG_REMOTE_DEBUG, "Error wait_for_remote: Timed ou=
t\n");
> +        /* TODO: Kick-off error recovery */
> +        return UINT64_MAX;
> +    case -1:
> +        qemu_log_mask(LOG_REMOTE_DEBUG, "Poll error wait_for_remote: %s\=
n",
> +                      strerror(errno));
> +        return UINT64_MAX;
> +    default:
> +        if (read(efd, &val, sizeof(val)) =3D=3D -1) {
> +            qemu_log_mask(LOG_REMOTE_DEBUG, "Error wait_for_remote: %s\n=
",
> +                          strerror(errno));
> +            return UINT64_MAX;
> +        }
> +    }
> +
> +    /*
> +     * The remote process could write a non-zero value
> +     * to the eventfd to wake QEMU up. However, the drawback of using ev=
entfd
> +     * for this purpose is that a return value of zero wouldn't wake QEM=
U up.
> +     * Therefore, we offset the return value by one at the remote proces=
s and
> +     * correct it in the QEMU end.
> +     */
> +    val =3D (val =3D=3D UINT64_MAX) ? val : (val - 1);
> +
> +    return val;
> +}
> +
> +void notify_proxy(int efd, uint64_t val)
> +{
> +    val =3D (val =3D=3D UINT64_MAX) ? val : (val + 1);
> +    ssize_t len =3D -1;
> +
> +    len =3D write(efd, &val, sizeof(val));
> +    if (len =3D=3D -1 || len !=3D sizeof(val)) {
> +        qemu_log_mask(LOG_REMOTE_DEBUG, "Error notify_proxy: %s\n",
> +                      strerror(errno));
> +    }
> +}
> +
>  static gboolean mpqemu_link_handler_prepare(GSource *gsrc, gint *timeout=
)
>  {
>      g_assert(timeout);
> --=20
> 2.25.GIT
>=20

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66eKAACgkQnKSrs4Gr
c8hzwQf/fHA6OJUFLZQSL8OKO3EjYSLl5rpNm4eNN4rRNSHCN9QJrYdYKu9OnsCY
cxnOudGx0DIE5OfwD0Lafq6jWiypomXMRtwnVObikuInmwdYFzr0h+HnFhqSPZ9F
4XfrmyS50C+9tRbfTg6i7rl7gc/CcbuQyb7F5KnVjexxIiP7if01L/1Di0QraNaB
EnN6ZqB9aw5WpHrL/B8rSo63YZZsFBxYORKioWXGEerLntzU/RASYGHWuTOtpKK9
lLKVJIPaeuSBmIcWWPdj+CbCBH3/x/D5Eilz3JZAvl5URQfFK3kbvVHvPHFCsJCR
yFbF3GmxvhwcZVmnhj9sABibBE66cw==
=j+S0
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--


