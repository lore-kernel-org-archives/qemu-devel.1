Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC43C2D0C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E025124676
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+pb/ta8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E025124676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwv7-0002BU-2U
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ihwqC-0004pu-5Q
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ihwqA-0000S4-GV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:31:47 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ihwqA-0000HG-1D
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:31:46 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so5819897wmi.5
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 06:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=L1XHzR3L0UKWQWfjmW2ug1sO8EYNVNufKA/2pud2anY=;
 b=Z+pb/ta8AkUNy98XvBuvvkKM5fcx2EwXCm+QpGrQx+8qr87l4Urrqz7HrXkIvVB7D9
 cKHnbfqaeNPgDuZqKQkTRJiWfyK00mfv3B/2HUOVH5CSVREFYl6MJVTlVwBH1Y8yYOM6
 /ysOtY+aQQ/iYF7X7IJveM0AMrX0tQWfIfR+Ff2W5nmZgqfmzMegAYW+usojfte+ti9j
 /1/N2IjjS96s/vNpCaC8YwQ1xhXu3h8hOkL0XxdZwaa61SPhY2dgQk54SKqcSSXVtpdN
 QDy67eAuJIB4gyBRmh78F/UCeEEzr8QkAq3yCc6W03TGYdN9qyO8wYHGyXsZ9P49eCYq
 7T4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=L1XHzR3L0UKWQWfjmW2ug1sO8EYNVNufKA/2pud2anY=;
 b=jH0VISJNPLm8aFIbzduCs0QS1BhZ+OBThXHHeAnGGkJlonvO1udHQFt2xTuFryroxS
 KwmcDC23kCtAxV7QZUHhmoG+x/Nh6ttb1WdJWkpeH2g6QQ8qv4Na9bSl40a++cSYoxc8
 so0HbOqO8O6gNnEUrThkPxNr8rv0nTmX2TFAiXXYtex+HGESwhHlNNV/5DEm7xlaO1Dn
 X+Hp5lNX71U/DR0ZPyMplzh3Ss7yYSfiN3GZSkcVazY7WVRv8wt9lHu/c3ptACV0ZCfc
 3yGkxLiA/x8uu02u0tPRl3GHaW0iOzn6NCGqZbWZQMMHVlrFLOOeWx47WQKcmdQVaoav
 FtyQ==
X-Gm-Message-State: APjAAAXDAdxhsC2r6t/sdMid/r7bZwGhd1ZI/F5wI+P/MhpOszibQjMC
 Htzd7BMrJ9YcrLWi77AoqXE=
X-Google-Smtp-Source: APXvYqyO3Bq33GKouNG8LDJHsqu2POyyDNRpDLJuBtWjrMtfFsWHitF52j+qkn6wS6G4CG3M01H/Xg==
X-Received: by 2002:a1c:e90e:: with SMTP id q14mr10485058wmc.108.1576765904102; 
 Thu, 19 Dec 2019 06:31:44 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d12sm6503974wrp.62.2019.12.19.06.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 06:31:43 -0800 (PST)
Date: Thu, 19 Dec 2019 14:31:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [RFC] Implementing vhost-user-blk device backend
Message-ID: <20191219143141.GF1624084@stefanha-x1.localdomain>
References: <CAJAkqrWm28qXtsFmaENAcsDNQV7gE=sd+YyA5ADmm2Vo9DKrUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Content-Disposition: inline
In-Reply-To: <CAJAkqrWm28qXtsFmaENAcsDNQV7gE=sd+YyA5ADmm2Vo9DKrUQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Kevin Wolf <kwolf@redhat.com>, Bharat Singh <bharatlkmlkvm@gmail.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 10:27:28PM +0800, Coiby Xu wrote:
> Hi all,
>=20
> This is an implementation of vhost-user-blk device backend by
> following https://wiki.qemu.org/Google_Summer_of_Code_2019#vhost-user-blk=
_device_backend.
> raw/qcow2 disk images can now be shared via vhost user protocol. In
> this way, it could provide better performance than QEMU's existing NBD
> support.

Thank you for working on this feature!

> +static size_t vub_iov_to_buf(const struct iovec *iov,
> +                             const unsigned int iov_cnt, void *buf)

Please take a look at utils/iov.c.  iov_to_buf_full() can be used
instead of defining this function.

> +{
> +    size_t len;
> +    unsigned int i;
> +
> +    len =3D 0;
> +    for (i =3D 0; i < iov_cnt; i++) {
> +        memcpy(buf + len,  iov[i].iov_base, iov[i].iov_len);
> +        len +=3D iov[i].iov_len;
> +    }
> +    return len;
> +}
> +
> +static  VubDev *vub_device;

If you switch to -object (see below) then this global pointer will go
away so I won't comment on it throughout this patch.

> +static void vub_accept(QIONetListener *listener, QIOChannelSocket *sioc,
> +                       gpointer opaque)
> +{
> +    /* only one connection */
> +    if (vub_device->sioc) {
> +        return;
> +    }
> +
> +    vub_device->sioc =3D sioc;
> +    vub_device->listener =3D listener;
> +    /*
> +     * increase the object reference, so cioc will not freeed by
> +     * qio_net_listener_channel_func which will call object_unref(OBJECT=
(sioc))
> +     */
> +    object_ref(OBJECT(sioc));
> +
> +    qio_channel_set_name(QIO_CHANNEL(sioc), "vhost-server");
> +    if (!vug_init(&vub_device->parent, VHOST_USER_BLK_MAX_QUEUES, sioc->=
fd,
> +                  vub_panic_cb, &vub_iface)) {
> +        fprintf(stderr, "Failed to initialized libvhost-user-glib\n");
> +    }

vug_init() uses the default GMainContext, which is bad for performance
when there are many devices because it cannot take advantage of
multi-core CPUs.  vhost-user-server should support IOThread so that
devices can be run in dedicated threads.

The nbd/server.c:NBDExport->ctx field serves this purpose in the NBD
server.  It's a little trickier with libvhost-user-glib because the API
currently doesn't allow passing in a GMainContext and will need to be
extended.

> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index cfcc044ce4..d8de179747 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1614,6 +1614,33 @@ STEXI
>  @findex acl_reset
>  Remove all matches from the access control list, and set the default
>  policy back to @code{deny}.
> +ETEXI
> +
> +    {
> +        .name       =3D "vhost_user_server_stop",
> +        .args_type  =3D "",
> +        .params     =3D "vhost_user_server_stop",
> +        .help       =3D "stop vhost-user-blk device backend",
> +        .cmd        =3D hmp_vhost_user_server_stop,
> +    },
> +STEXI
> +@item vhost_user_server_stop
> +@findex vhost_user_server_stop
> +Stop the QEMU embedded vhost-user-blk device backend server.
> +ETEXI

The NBD server supports multiple client connections and exports
(drives).  A vhost-user socket only supports one connection and one
device.  I think it will be necessary to assign a unique identifier to
every vhost-user server.

By the way, I think the server should be a UserCreatable Object so the
following syntax works:

  $ qemu -object vhost-user-server,id=3DID,chardev=3DCHARDEV,writable=3Don|=
off

And existing HMP/QMP commands can be used:

  (qemu) object_add vhost-user-server,id=3DID,chardev=3DCHARDEV,writable=3D=
on|off
  (qemu) object_del ID

This way we don't need to define new HMP/QMP/command-line syntax for
vhost-user-server.

If you grep for UserCreatable you'll find examples like "iothread",
"secret", "throttle-group", etc.

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl37ic0ACgkQnKSrs4Gr
c8jnswf9HhH67QT9cBavA2DzBhCpkMTYNJcKeybYFM6omrZZesQJGjU1xfte4F2h
Dbk5WEvrRnCV6+p1UC2PsuC7sCEOImjVdIrTSW/JmgEWYMGMac7RWCOLhP5+J9PA
I4P3wtW7lUBv9Kf2jWrGOlleJZ0QvASk1RcXEL3wr0Bv5rToYPnz4rKQp9vxCusC
ptIaEoCLiux8DGkbAELh7+ewHyBpBURFqWnW0+mV5I1NtNRolHAvvyTa82rI1qzX
X8j5HQnpvASzQkcMQML0yI2RtByMQEFVBX9ssygmoEh2ypnklQ1Qk+XJp2sqBjnN
XRu5ZplMb4BNV/gfbUUTDH26UxqkNA==
=Qa3N
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--

