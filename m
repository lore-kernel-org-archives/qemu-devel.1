Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48829C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3889206B2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2AXJmwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3889206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcC9f-0002wF-KH
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kcC6j-0001ZV-UT
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:41:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kcC6g-0001n3-8e
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604947289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1HeV/o/n3zLvz2AbBXhfYPVzN0yMsWUCqUVeBABmxI=;
 b=X2AXJmwyU9UyUw6qYhG+ivOP3YAx8P/9aemspvS3GfPD4PhPC+jGllb0h7lrfrPq1GBV8b
 HL2uQ+jhGAi8ZPRGDUptFclJjTOtvhzhURmaloo3CXaAkOW3FHoaaU7xhVg4aWMskFWQFD
 v2fU83PGc+6XRbUXoR0ZcpWimjDHEys=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-v4VtQBawPhi8cyceEEzi1g-1; Mon, 09 Nov 2020 13:41:26 -0500
X-MC-Unique: v4VtQBawPhi8cyceEEzi1g-1
Received: by mail-oi1-f198.google.com with SMTP id h65so5010657oia.14
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 10:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Y1HeV/o/n3zLvz2AbBXhfYPVzN0yMsWUCqUVeBABmxI=;
 b=Hf67olQ5wEF5YMVwVB72kasNYRhoZhW2F3XTZ3PjIKZ3q8bAz4p2Edf/gFxKC0JZW8
 6kJRBYdCEFn2p9QAMp8Zg7TJP3mXPvdsQ9sFVTGh9vN6UmE4I0EGvk7DvfedyqdAL7Bk
 eOpLJdSHAijcPe5DhnuhhSZU+1e2Pv6kz+SNJXq4GMsRwxKFY7Ej2qI6pCNIoVEvDugW
 O+UKZJMHN79oZOxKH/aIiNikefovZuZuxSzQZV0L8+H25hr1fNy5w5EZXPVP26WmzlFc
 Qze1VCNtXzH7yD5xPZssoPDKVPvgyzzbwQj6MCUa2fKSTZNG+5dIjKKCDBDwJa6xeIhT
 EX6A==
X-Gm-Message-State: AOAM531014jcWVd9O5IPin7zXKgKCuqqMxyUtlAXQr7Fi0pW3VMF+v3e
 DDTLFO32QF4uOdqYG56xXI4jgB0vFOsokoiZJVWhAaBl16TcTN7Z6V7ADWty2aehtfoHFk6gjXO
 c8wIGDIJLeozipZt3sAFmjbbHyroZ6A0=
X-Received: by 2002:aca:c314:: with SMTP id t20mr380911oif.30.1604947285546;
 Mon, 09 Nov 2020 10:41:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxspcyCD0FRRrMEBRy1QXV+LSDyZttovqmNnTPfxoF9lm1Rq5i7BbnIPDIapGC3PFWSe+tgr8BIer7y+ZpdRKI=
X-Received: by 2002:aca:c314:: with SMTP id t20mr380889oif.30.1604947285178;
 Mon, 09 Nov 2020 10:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20201109140730.2600017-1-philmd@redhat.com>
 <50725a6d-f2b4-bf46-4f36-a4e7bf7f89fa@redhat.com>
In-Reply-To: <50725a6d-f2b4-bf46-4f36-a4e7bf7f89fa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 9 Nov 2020 19:41:14 +0100
Message-ID: <CAP+75-XXvG+CzqRRsbYE20O=tLR5jZVEgSAKDg-5Y7GW5r-4cg@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 v3] configure: Check vhost-user is available for
 vhost-user-blk-server
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 9, 2020 at 6:22 PM Thomas Huth <thuth@redhat.com> wrote:
> On 09/11/2020 15.07, Philippe Mathieu-Daud=C3=A9 wrote:
> > Check vhost-user is available when building vhost-user-blk-server.
> >
> > This fixes:
> >
> >  $ ../configure \
> >       --disable-vhost-user --enable-vhost-user-blk-server && \
> >    make qemu-nbd
> >  ...
> >  [505/505] Linking target qemu-nbd
> >  FAILED: qemu-nbd
> >  cc  -o qemu-nbd qemu-nbd.p/qemu-nbd.c.o -Wl,--as-needed -Wl,--no-undef=
ined -pie -Wl,--whole-archive libblockdev.fa libblock.fa libcrypto.fa libau=
thz.fa libqom.fa libio.fa -Wl,--no-whole-archive -Wl,--warn-common -Wl,-z,r=
elro -Wl,-z,now -m64 -fstack-protector-strong -Wl,--start-group libqemuutil=
.a libblockdev.fa libblock.fa libcrypto.fa libauthz.fa libqom.fa libio.fa @=
block.syms -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lgio-2.0 -lgobject-2.0 -lgli=
b-2.0 -pthread -lgnutls -lutil -lm -lgthread-2.0 -lglib-2.0 -lbz2 -lgthread=
-2.0 -lglib-2.0 -lssh -lrbd -lrados -lcurl -lxml2 -lzstd -lacl -lgfapi -lgl=
usterfs -lgfrpc -lgfxdr -luuid -laio /usr/lib64/libz.so -L/usr/lib64/iscsi =
-liscsi -lnettle -lgnutls -lpam -Wl,--end-group
> >  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): i=
n function `vu_blk_process_vq':
> >  block/export/vhost-user-blk-server.c:203: undefined reference to `vu_g=
et_queue'
> >  /usr/bin/ld: block/export/vhost-user-blk-server.c:208: undefined refer=
ence to `vu_queue_pop'
> >  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): i=
n function `vu_blk_queue_set_started':
> >  block/export/vhost-user-blk-server.c:228: undefined reference to `vu_g=
et_queue'
> >  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): i=
n function `vu_blk_req_complete':
> >  block/export/vhost-user-blk-server.c:55: undefined reference to `vu_qu=
eue_push'
> >  /usr/bin/ld: block/export/vhost-user-blk-server.c:56: undefined refere=
nce to `vu_queue_notify'
> >  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): i=
n function `vu_blk_queue_set_started':
> >  block/export/vhost-user-blk-server.c:229: undefined reference to `vu_s=
et_queue_handler'
> >  /usr/bin/ld: libqemuutil.a(util_vhost-user-server.c.o): in function `v=
u_client_trip':
> >  util/vhost-user-server.c:176: undefined reference to `vu_dispatch'
> >  /usr/bin/ld: util/vhost-user-server.c:180: undefined reference to `vu_=
deinit'
> >  /usr/bin/ld: libqemuutil.a(util_vhost-user-server.c.o): in function `v=
u_accept':
> >  util/vhost-user-server.c:291: undefined reference to `vu_init'
> >  collect2: error: ld returned 1 exit status
> >  ninja: build stopped: subcommand failed.
> >  make: *** [Makefile:171: run-ninja] Error 1
> >
> > Now we get:
> >
> >  $ ../configure \
> >       --disable-vhost-user --enable-vhost-user-blk-server && \
> >  ERROR: --enable-vhost-user-blk-server requires --enable-vhost-user
> >
> > Fixes: bc15e44cb21 ("configure: introduce --enable-vhost-user-blk-serve=
r")
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> > Since v1:
> > - Addressed Thomas review comments
> > https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg02188.html
> > ---
> >  configure | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/configure b/configure
> > index 805f7791503..3124be82da1 100755
> > --- a/configure
> > +++ b/configure
> > @@ -2375,6 +2375,10 @@ test "$vhost_user_fs" =3D "" && vhost_user_fs=3D=
$vhost_user
> >  if test "$vhost_user_fs" =3D "yes" && test "$vhost_user" =3D "no"; the=
n
> >    error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
> >  fi
> > +test "$vhost_user_blk_server" =3D "" && vhost_user_blk_server=3D$vhost=
_user
> > +if test "$vhost_user_blk_server" =3D "yes" && test "$vhost_user" =3D "=
no"; then
> > +  error_exit "--enable-vhost-user-blk-server requires --enable-vhost-u=
ser"
> > +fi
>
> A little bit later in this file, we've got :
>
> # libvhost-user is Linux-only
> test "$vhost_user_blk_server" =3D "" && vhost_user_blk_server=3D$linux
> if test "$vhost_user_blk_server" =3D "yes" && test "$linux" =3D "no"; the=
n
>   error_exit "--enable-vhost-user-blk-server is only available on Linux"
> fi
>
> I think it would be better to add the new code there instead.
> Also maybe better do something like:
>
> test "$vhost_user_blk_server" =3D "" && test "$vhost_user" =3D "yes" \
>  &&  vhost_user_blk_server=3D$linux
>
> instead?

I understood this option is similar to the other vhost-user related ones
and should be treated the same way.

>
>  Thomas
>


