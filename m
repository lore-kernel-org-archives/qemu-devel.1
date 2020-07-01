Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9478C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F5720722
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yw1CEOpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F5720722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqYvt-0006OW-VA
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 05:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqYvK-0005yc-Mf
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:20:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35402
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqYvI-0004Lv-Ob
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593595256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OlOFRuSq3+rLzmQ9V5jb2pmpsxiAfibzoK1UDuxv31Y=;
 b=Yw1CEOpWKVy8hSItDuMjX9b2Ed4UAi92oVJtBgKGcBLgFUn4ZC5PpM343GODdfv1QEYLQj
 vh1jLAes+XwCQHLEsfGCgMTkIcd2z/w+DBqYjdyxgofznXH8nCrQgFSk2szkR/rl7Erv87
 BN9EwXKnz+aCSrjTDiaBOa9yXiV1kM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-uVtjcA6SMPCR1vmlBYfLvg-1; Wed, 01 Jul 2020 05:20:51 -0400
X-MC-Unique: uVtjcA6SMPCR1vmlBYfLvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADC3B1052509;
 Wed,  1 Jul 2020 09:20:45 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16DD27AC60;
 Wed,  1 Jul 2020 09:20:44 +0000 (UTC)
Date: Wed, 1 Jul 2020 10:20:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 12/21] multi-process: Connect Proxy Object with device
 in the remote process
Message-ID: <20200701092043.GE126613@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <20f42fce1b701586a23c9abdb3b53d080845e94a.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20f42fce1b701586a23c9abdb3b53d080845e94a.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 10:09:34AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Send a message to the remote process to connect PCI device with the
> corresponding Proxy object in QEMU

I thought the protocol was simplified to a 1:1 device:socket model, but
this patch seems to implement an N:1 model?

In a 1:1 model the CONNECT_DEV message is not necessary because each
socket is already associated with a specific remote device (e.g. qemu -M
remote -object mplink,dev=3Dlsi-scsi-1,sockpath=3D/tmp/lsi-scsi-1.sock).
Connecting to the socket already indicates which device we are talking
to.

The N:1 model will work but it's more complex. There is a main socket
that is used for CONNECT_DEV (anything else?) and we need to worry about
the lifecycle of the per-device sockets that are passed over the main
socket.

> @@ -50,3 +58,34 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondit=
ion cond,
> =20
>      return TRUE;
>  }
> +
> +static void process_connect_dev_msg(MPQemuMsg *msg, QIOChannel *com,
> +                                    Error **errp)
> +{
> +    char *devid =3D (char *)msg->data2;
> +    QIOChannel *dioc =3D NULL;
> +    DeviceState *dev =3D NULL;
> +    MPQemuMsg ret =3D { 0 };
> +    int rc =3D 0;
> +
> +    g_assert(devid && (devid[msg->size - 1] =3D=3D '\0'));

Asserts are not suitable for external input validation since a failure
aborts the program and lets the client cause a denial-of-service. When
there are multiple clients, one misbehaved client shouldn't be able to
kill the server. Please validate devid using an if statement and set
errp on failure.

Can msg->size be 0? If yes, this code accesses before the beginning of
the buffer.

> +
> +    dev =3D qdev_find_recursive(sysbus_get_default(), devid);
> +    if (!dev || !object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        rc =3D 0xff;
> +        goto exit;
> +    }
> +
> +    dioc =3D qio_channel_new_fd(msg->fds[0], errp);

Missing error handling if qio_channel_new_fd() fails. We need to
close(msg->fds[0]) ourselves in this case.

> +
> +    qio_channel_add_watch(dioc, G_IO_IN | G_IO_HUP, mpqemu_process_msg,
> +                          (void *)dev, NULL);
> +
> +exit:
> +    ret.cmd =3D RET_MSG;
> +    ret.bytestream =3D 0;
> +    ret.data1.u64 =3D rc;
> +    ret.size =3D sizeof(ret.data1);
> +
> +    mpqemu_msg_send(&ret, com);
> +}
> diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
> index 6d62399c52..16649ed0ec 100644
> --- a/hw/pci/proxy.c
> +++ b/hw/pci/proxy.c
> @@ -15,10 +15,38 @@
>  #include "io/channel-util.h"
>  #include "hw/qdev-properties.h"
>  #include "monitor/monitor.h"
> +#include "io/mpqemu-link.h"
> =20
>  static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
>  {
> +    DeviceState *dev =3D DEVICE(pdev);
> +    MPQemuMsg msg =3D { 0 };
> +    int fds[2];
> +    Error *local_err =3D NULL;
> +
>      pdev->com =3D qio_channel_new_fd(fd, errp);
> +
> +    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds)) {
> +        error_setg(errp, "Failed to create proxy channel with fd %d", fd=
);
> +        return;

pdev->com needs to be cleaned up.

> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
> index 5887c8c6c0..54df3b254e 100644
> --- a/io/mpqemu-link.c
> +++ b/io/mpqemu-link.c
> @@ -234,6 +234,14 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
>              return false;
>          }
>          break;
> +    case CONNECT_DEV:
> +        if ((msg->num_fds !=3D 1) ||
> +            (msg->fds[0] =3D=3D -1) ||
> +            (msg->fds[0] =3D=3D -1) ||

This line is duplicated.

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl78VWsACgkQnKSrs4Gr
c8jD9wf/RkF+SFT8rfgpVQD5USkqhC0KFybyxRni1l1YPXvGpTs/i44GEDGKdCeI
jT6QHEsZyHA2R94mz2FCP9UQDZW8b+atQ2jgrCpmSCD9Ww1WhPglyT779yDRHlF3
B1PWhQaK1DXmLbhQdKtxD0j+wB+kFWb4yZHJ6h1wmAtPhclpjrUjU14rBqFUFNYD
EVuzJ94uQcQxIUoLc9dcYCSZ1X6rv9Fw8o6Y/wRHSU5D88rrst7i16dyhi9SoII+
GBnVTRqh6f4gmCY0i8OQroBA/70nSQtVZKpaO8cprQt37twUK5k+UFwbz+NWTNyk
4gg46PB6+ZuCWZ2uX56BYx6vYuzDFg==
=RvrS
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--


