Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFCAC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F191206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlc4zlfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F191206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcCgh-0003rH-Hk
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 14:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kcCfA-00039Q-Le
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:17:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kcCf7-0006TC-D9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604949427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zk6Wnc8VmvwfxheijcMdK/2NbL3F/ZV+eNzWtdsUl/o=;
 b=hlc4zlfLT9vsx9YHCaZ9Qvl3Vs4bq9fEzXPP3qVdLwo+8qRkPEaJLdXTu/NeZ+KDa2kKy3
 J/676jrpugtjKWU2B/DVfqW71/CZ2xLB9yOgV0X1T3lJro94E77fuSaS4ENpRsAHcttjUu
 d3NnDZjE2NTLrk4YYjOtScZp3t72cwc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-OC_nBQ3POYay6VebjJO9lQ-1; Mon, 09 Nov 2020 14:17:05 -0500
X-MC-Unique: OC_nBQ3POYay6VebjJO9lQ-1
Received: by mail-ot1-f70.google.com with SMTP id h7so5519603otn.10
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 11:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zk6Wnc8VmvwfxheijcMdK/2NbL3F/ZV+eNzWtdsUl/o=;
 b=VUP5X93ygC8hileNr4pIxw6WE0En4lOYd3l6AlDIavAo8YsyZmLbX2VYKyfY709D/N
 uUt64NIZ0l5n4dqERqUabUmeLDgxuKIdDssRhyeHbEsELstCPBGQzLI62T1awd/MSylW
 w5YcoGQj1CDYc/Af3YFnli8f7GIceTvzhEa3+r0JX6vFF8jgwYxgjqzliOd/VMXD2wba
 q3O5ztYsQ4WHOkksMVp8ZA43a273IoLMg8tDfl6GZeyLD6ACMZgEACu+YFYaEXfricMO
 9MZZLWvg864Kxq3BvUlWPIJ9Zc3pi74J4RhZuxIuzjS1zHILddqpE5/yq24rm2NYtL43
 fLFg==
X-Gm-Message-State: AOAM53062rjKmNldeCm6YixrD0gFvq2RgMCuUK6OW2dC06D1S4L5o2F0
 fdIFP4jo7ScRFUzIn13vkEpo2ld9HY70d7L5SGg28SHGIJl2sI6BoX3rsTwMxFIv0a20NGBcezl
 hq++wfOEqJK5/+5rjLIIt4B33HruKS2Q=
X-Received: by 2002:a4a:9607:: with SMTP id q7mr11035453ooi.79.1604949424031; 
 Mon, 09 Nov 2020 11:17:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRGd37JC4Lx9D04AQ9E5NCfixEYNfgXjm+sRWKExYHtFIKeh/TeTslyYAGwQfdpKJfJX50wamM9TiFvYJmxwM=
X-Received: by 2002:a4a:9607:: with SMTP id q7mr11035445ooi.79.1604949423797; 
 Mon, 09 Nov 2020 11:17:03 -0800 (PST)
MIME-Version: 1.0
References: <20201109140341.2598016-1-philmd@redhat.com>
 <651d47a4-43d4-d8af-97f8-2871481c53d0@redhat.com>
In-Reply-To: <651d47a4-43d4-d8af-97f8-2871481c53d0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 9 Nov 2020 20:16:52 +0100
Message-ID: <CAP+75-UharQgwBwVJJuj8pVX778=f=TUuCbL7o74VTsti5obxA@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 v2] configure: Check vhost-user is available for
 vhost-user-blk-server
To: QEMU Developers <qemu-devel@nongnu.org>
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
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 9, 2020 at 3:07 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> On 11/9/20 3:03 PM, Philippe Mathieu-Daud=C3=A9 wrote:
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
> >
> > Supersedes: <20201106190409.10571-1-philmd@redhat.com>
> > ---
> >  configure | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index 805f7791503..39b65dcd070 100755
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
> >  #vhost-vdpa backends
> >  test "$vhost_net_vdpa" =3D "" && vhost_net_vdpa=3D$vhost_vdpa
> >  if test "$vhost_net_vdpa" =3D "yes" && test "$vhost_vdpa" =3D "no"; th=
en
> > @@ -2389,7 +2393,6 @@ if test "$vhost_net" =3D ""; then
> >  fi
> >
> >  # libvhost-user is Linux-only
> > -test "$vhost_user_blk_server" =3D "" && vhost_user_blk_server=3D$linux
>
> Pfff I didn't meant to commit this hunk.
> I'll respin, sorry.

Thomas reviewed v3 and finally v2 is better...

>
> >  if test "$vhost_user_blk_server" =3D "yes" && test "$linux" =3D "no"; =
then
> >    error_exit "--enable-vhost-user-blk-server is only available on Linu=
x"
> >  fi
> >
>


