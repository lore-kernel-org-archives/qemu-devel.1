Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000E2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27992083B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyrkA8zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27992083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFML-00040d-Q6
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 07:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jmFLL-0002Q5-ST
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:38:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54485
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jmFLH-0002Ys-A5
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592566673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPTG3op+0PMrl8oqjKlIgUxZ5X/S4vBg8V6t8NIYCDU=;
 b=UyrkA8zd79k2zECNhIVgEjB1j/sRUFnbxWKFTnloRA1+199WpNf0zCiE/bsDOP/6ipNWla
 ohkeqnjTbP127oPXXaztOOC76s9S3nj9lBY21TFd4pSjPqi4Bb3Sa2HfdFcG07Zfq69iw0
 BL9xt826zfPEkZJufJWX0CFvtMGoj2k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-ipyS8WGCNT6GmefdUYs_iw-1; Fri, 19 Jun 2020 07:37:43 -0400
X-MC-Unique: ipyS8WGCNT6GmefdUYs_iw-1
Received: by mail-wr1-f69.google.com with SMTP id i10so239935wrn.21
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 04:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6S8kCaio50HxVC2NItbqbYIS4HHuHrbcsBHhvLp7R30=;
 b=bDfVjAUv0Lm2Yuato/6RzS6sMJSRa1XrcUqWVqu236MgS71nF5i61q70vMPRwo7IG6
 XHInkwTpu0wC6JqlaLGcN4vBZiEawna00qJKmPiPiMBM1fQjnW2I7m0UI/XEbY3TvStG
 jITxrZL6qDY+KYmmFl6QpOEIinOE4l9dLCCmBLZn69A2NIjkoDC6PkVY5q0KrpnV9R7j
 VGjYJ5aaoUz8pvUuFfvn+HV0fJr+2Xen2PKLKv1RVVM65xTVW/ao+Er2lJLIYkDCiDnn
 Sro8HpCIDjonFDSU+MIjWktQEi84oAEOXwfDmaihvYiiIf1RZaHgVhVWafeQTD4av1rm
 pjHQ==
X-Gm-Message-State: AOAM5329VApZD29ab1Hnfxm2Oyb/+OeW6Ks26dEJuxLz4eKACEIDxjQq
 MuVg4AmZCS8qpY7YwKxQQtXCx7BzY1jCVHtX3rdiTuRpkM6BATsG3Vtc8ArLVGcY/SWNORY/EB9
 HdvkBumfK2GfgwSI=
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr3234267wmj.5.1592566661992;
 Fri, 19 Jun 2020 04:37:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX+3roFnI1Ac4V6Q6UO5KOGOCEAA7qB/ft3aqEb3SiaOhE7UOVl38hD8EE/eLBdtWpej7pvQ==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr3234224wmj.5.1592566661466;
 Fri, 19 Jun 2020 04:37:41 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id e15sm6920226wme.9.2020.06.19.04.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 04:37:40 -0700 (PDT)
Date: Fri, 19 Jun 2020 07:37:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v10 00/12] acpi: i386 tweaks
Message-ID: <20200619073705-mutt-send-email-mst@kernel.org>
References: <20200619091905.21676-1-kraxel@redhat.com>
 <159256030931.466.17423983568106504697@d1fd068a5071>
MIME-Version: 1.0
In-Reply-To: <159256030931.466.17423983568106504697@d1fd068a5071>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
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
Cc: lvivier@redhat.com, kwolf@redhat.com, thuth@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, kraxel@redhat.com,
 pbonzini@redhat.com, imammedo@redhat.com, jsnow@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 02:51:51AM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200619091905.21676-1-kraxel@redha=
t.com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the asan build test. Please find the testing commands =
and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> export ARCH=3Dx86_64
> make docker-image-fedora V=3D1 NETWORK=3D1
> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 NE=
TWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>   GEN     docs/interop/qemu-qmp-ref.txt
>   GEN     docs/interop/qemu-qmp-ref.7
>   CC      qga/commands.o
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   CC      qga/guest-agent-command-state.o
>   CC      qga/main.o
>   CC      qga/commands-posix.o
> ---
>   GEN     docs/interop/qemu-ga-ref.html
>   GEN     docs/interop/qemu-ga-ref.txt
>   GEN     docs/interop/qemu-ga-ref.7
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-keymap
>   LINK    ivshmem-client
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    ivshmem-server
>   AS      pc-bios/optionrom/multiboot.o
>   AS      pc-bios/optionrom/linuxboot.o
>   CC      pc-bios/optionrom/linuxboot_dma.o
>   AS      pc-bios/optionrom/kvmvapic.o
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-nbd
>   AS      pc-bios/optionrom/pvh.o
>   CC      pc-bios/optionrom/pvh_main.o
> ---
>   BUILD   pc-bios/optionrom/multiboot.raw
>   BUILD   pc-bios/optionrom/linuxboot.raw
>   BUILD   pc-bios/optionrom/linuxboot_dma.raw
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   BUILD   pc-bios/optionrom/kvmvapic.raw
>   SIGN    pc-bios/optionrom/multiboot.bin
>   LINK    qemu-storage-daemon
> ---
>   SIGN    pc-bios/optionrom/linuxboot_dma.bin
>   SIGN    pc-bios/optionrom/kvmvapic.bin
>   BUILD   pc-bios/optionrom/pvh.img
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-img
>   BUILD   pc-bios/optionrom/pvh.raw
>   SIGN    pc-bios/optionrom/pvh.bin
>   LINK    qemu-io
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-edid
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    fsdev/virtfs-proxy-helper
>   LINK    scsi/qemu-pr-helper
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-bridge-helper
>   LINK    virtiofsd
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    vhost-user-input
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-ga
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   GEN     x86_64-softmmu/hmp-commands-info.h
>   GEN     x86_64-softmmu/hmp-commands.h
>   GEN     x86_64-softmmu/config-target.h
> ---
>   CC      x86_64-softmmu/gdbstub-xml.o
>   CC      x86_64-softmmu/trace/generated-helpers.o
>   LINK    x86_64-softmmu/qemu-system-x86_64
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
> common.rc: line 50: test: check: binary operator expected
> (printf '#define QEMU_PKGVERSION ""\n'; printf '#define QEMU_FULL_VERSION=
 "5.0.50"\n'; ) > qemu-version.h.tmp
> make -C /tmp/qemu-test/src/slirp BUILD_DIR=3D"/tmp/qemu-test/build/slirp"=
 PKG_CONFIG=3D"pkg-config" CC=3D"clang" AR=3D"ar"      LD=3D"ld" RANLIB=3D"=
ranlib" CFLAGS=3D"-I/usr/include/pixman-1   -Werror -fsanitize=3Dundefined =
-fsanitize=3Daddress  -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.=
0/include  -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwr=
ite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -=
std=3Dgnu99  -Wold-style-definition -Wtype-limits -Wformat-security -Wforma=
t-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendi=
f-labels -Wexpansion-to-defined -Wno-initializer-overrides -Wno-missing-inc=
lude-dirs -Wno-shift-negative-value -Wno-string-plus-int -Wno-typedef-redef=
inition -Wno-tautological-type-limit-compare -fstack-protector-strong   -I/=
usr/include/p11-kit-1   -DSTRUCT_IOVEC_DEFINED  -I/usr/include/libpng16  -I=
/usr/include/spice-1 -I/usr/include/spice-server -I/usr/include/cacard -I/u=
sr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/nss3 -I/us=
r/include/nspr4 -pthread -I/usr/include/libmount -I/usr/include/blkid -I/us=
r/include/pixman-1   -I/tmp/qemu-test/src/tests -I/tmp/qemu-test/src/tests/=
qtest -g " LDFLAGS=3D"-Wl,--warn-common -fsanitize=3Dundefined -fsanitize=
=3Daddress -Wl,-z,relro -Wl,-z,now -pie -m64  -fstack-protector-strong"
> ---
> clang -iquote /tmp/qemu-test/build/tests/qtest/libqos -iquote tests/qtest=
/libqos -iquote /tmp/qemu-test/src/tcg/i386 -isystem /tmp/qemu-test/src/lin=
ux-headers -isystem /tmp/qemu-test/build/linux-headers -iquote . -iquote /t=
mp/qemu-test/src -iquote /tmp/qemu-test/src/accel/tcg -iquote /tmp/qemu-tes=
t/src/include -iquote /tmp/qemu-test/src/disas/libvixl -I/usr/include/pixma=
n-1   -Werror -fsanitize=3Dundefined -fsanitize=3Daddress  -pthread -I/usr/=
include/glib-2.0 -I/usr/lib64/glib-2.0/include  -fPIE -DPIE -m64 -mcx16 -D_=
GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes=
 -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-=
strict-aliasing -fno-common -fwrapv -std=3Dgnu99  -Wold-style-definition -W=
type-limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers=
 -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wno-i=
nitializer-overrides -Wno-missing-include-dirs -Wno-shift-negative-value -W=
no-string-plus-int -Wno-typedef-redefinition -Wno-tautological-type-limit-c=
ompare -fstack-protector-strong   -I/usr/include/p11-kit-1   -DSTRUCT_IOVEC=
_DEFINED  -I/usr/include/libpng16  -I/usr/include/spice-1 -I/usr/include/sp=
ice-server -I/usr/include/cacard -I/usr/include/glib-2.0 -I/usr/lib64/glib-=
2.0/include -I/usr/include/nss3 -I/usr/include/nspr4 -pthread -I/usr/includ=
e/libmount -I/usr/include/blkid -I/usr/include/pixman-1   -I/tmp/qemu-test/=
src/tests -I/tmp/qemu-test/src/tests/qtest -MMD -MP -MT tests/qtest/libqos/=
fw_cfg.o -MF tests/qtest/libqos/fw_cfg.d -g   -c -o tests/qtest/libqos/fw_c=
fg.o /tmp/qemu-test/src/tests/qtest/libqos/fw_cfg.c
> clang -iquote /tmp/qemu-test/build/tests/qtest/libqos -iquote tests/qtest=
/libqos -iquote /tmp/qemu-test/src/tcg/i386 -isystem /tmp/qemu-test/src/lin=
ux-headers -isystem /tmp/qemu-test/build/linux-headers -iquote . -iquote /t=
mp/qemu-test/src -iquote /tmp/qemu-test/src/accel/tcg -iquote /tmp/qemu-tes=
t/src/include -iquote /tmp/qemu-test/src/disas/libvixl -I/usr/include/pixma=
n-1   -Werror -fsanitize=3Dundefined -fsanitize=3Daddress  -pthread -I/usr/=
include/glib-2.0 -I/usr/lib64/glib-2.0/include  -fPIE -DPIE -m64 -mcx16 -D_=
GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes=
 -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-=
strict-aliasing -fno-common -fwrapv -std=3Dgnu99  -Wold-style-definition -W=
type-limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers=
 -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wno-i=
nitializer-overrides -Wno-missing-include-dirs -Wno-shift-negative-value -W=
no-string-plus-int -Wno-typedef-redefinition -Wno-tautological-type-limit-c=
ompare -fstack-protector-strong   -I/usr/include/p11-kit-1   -DSTRUCT_IOVEC=
_DEFINED  -I/usr/include/libpng16  -I/usr/include/spice-1 -I/usr/include/sp=
ice-server -I/usr/include/cacard -I/usr/include/glib-2.0 -I/usr/lib64/glib-=
2.0/include -I/usr/include/nss3 -I/usr/include/nspr4 -pthread -I/usr/includ=
e/libmount -I/usr/include/blkid -I/usr/include/pixman-1   -I/tmp/qemu-test/=
src/tests -I/tmp/qemu-test/src/tests/qtest -MMD -MP -MT tests/qtest/libqos/=
malloc.o -MF tests/qtest/libqos/malloc.d -g   -c -o tests/qtest/libqos/mall=
oc.o /tmp/qemu-test/src/tests/qtest/libqos/malloc.c
> clang -iquote /tmp/qemu-test/build/. -iquote . -iquote /tmp/qemu-test/src=
/tcg/i386 -isystem /tmp/qemu-test/src/linux-headers -isystem /tmp/qemu-test=
/build/linux-headers -iquote . -iquote /tmp/qemu-test/src -iquote /tmp/qemu=
-test/src/accel/tcg -iquote /tmp/qemu-test/src/include -iquote /tmp/qemu-te=
st/src/disas/libvixl -I/tmp/qemu-test/src/tests/fp -I/tmp/qemu-test/src/tes=
ts/fp/berkeley-softfloat-3/source/include -I/tmp/qemu-test/src/tests/fp/ber=
keley-softfloat-3/source/8086-SSE -I/tmp/qemu-test/src/tests/fp/berkeley-te=
stfloat-3/source -I/usr/include/pixman-1 -Werror -fsanitize=3Dundefined -fs=
anitize=3Daddress -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/in=
clude -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LAR=
GEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-s=
trings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=
=3Dgnu99 -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2=
k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-la=
bels -Wexpansion-to-defined -Wno-initializer-overrides -Wno-missing-include=
-dirs -Wno-shift-negative-value -Wno-string-plus-int -Wno-typedef-redefinit=
ion -Wno-tautological-type-limit-compare -fstack-protector-strong -I/usr/in=
clude/p11-kit-1 -DSTRUCT_IOVEC_DEFINED -I/usr/include/libpng16 -I/usr/inclu=
de/spice-1 -I/usr/include/spice-server -I/usr/include/cacard -I/usr/include=
/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/nss3 -I/usr/include/=
nspr4 -pthread -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/=
pixman-1 -DHW_POISON_H -DTARGET_ARM  -DSOFTFLOAT_ROUND_ODD -DINLINE_LEVEL=
=3D5 -DSOFTFLOAT_FAST_DIV32TO16 -DSOFTFLOAT_FAST_DIV64TO32 -DSOFTFLOAT_FAST=
_INT64  -DFLOAT16 -DFLOAT64 -DEXTFLOAT80 -DFLOAT128 -DFLOAT_ROUND_ODD -DLON=
G_DOUBLE_IS_EXTFLOAT80 -MMD -MP -MT softfloat.o -MF ./softfloat.d -g   -c -=
o softfloat.o /tmp/qemu-test/src/fpu/softfloat.c
> /tmp/qemu-test/src/tests/qht-bench.c:287:29: error: implicit conversion f=
rom 'unsigned long' to 'double' changes value from 18446744073709551615 to =
18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]
>         *threshold =3D rate * UINT64_MAX;
>                           ~ ^~~~~~~~~~
> /usr/include/stdint.h:130:23: note: expanded from macro 'UINT64_MAX'
> ---
> 18446744073709551615UL
> ^~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.


Don't know what happened here, seems to have nothing to do with this
patchset.

> make: *** [/tmp/qemu-test/src/rules.mak:69: tests/qht-bench.o] Error 1
> make: *** Waiting for unfinished jobs....
> clang -iquote /tmp/qemu-test/build/. -iquote . -iquote /tmp/qemu-test/src=
/tcg/i386 -isystem /tmp/qemu-test/src/linux-headers -isystem /tmp/qemu-test=
/build/linux-headers -iquote . -iquote /tmp/qemu-test/src -iquote /tmp/qemu=
-test/src/accel/tcg -iquote /tmp/qemu-test/src/include -iquote /tmp/qemu-te=
st/src/disas/libvixl -I/tmp/qemu-test/src/tests/fp -I/tmp/qemu-test/src/tes=
ts/fp/berkeley-softfloat-3/source/include -I/tmp/qemu-test/src/tests/fp/ber=
keley-softfloat-3/source/8086-SSE -I/tmp/qemu-test/src/tests/fp/berkeley-te=
stfloat-3/source -I/usr/include/pixman-1 -Werror -fsanitize=3Dundefined -fs=
anitize=3Daddress -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/in=
clude -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LAR=
GEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-s=
trings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=
=3Dgnu99 -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2=
k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-la=
bels -Wexpansion-to-defined -Wno-initializer-overrides -Wno-missing-include=
-dirs -Wno-shift-negative-value -Wno-string-plus-int -Wno-typedef-redefinit=
ion -Wno-tautological-type-limit-compare -fstack-protector-strong -I/usr/in=
clude/p11-kit-1 -DSTRUCT_IOVEC_DEFINED -I/usr/include/libpng16 -I/usr/inclu=
de/spice-1 -I/usr/include/spice-server -I/usr/include/cacard -I/usr/include=
/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/nss3 -I/usr/include/=
nspr4 -pthread -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/=
pixman-1 -DHW_POISON_H -DTARGET_ARM  -DSOFTFLOAT_ROUND_ODD -DINLINE_LEVEL=
=3D5 -DSOFTFLOAT_FAST_DIV32TO16 -DSOFTFLOAT_FAST_DIV64TO32 -DSOFTFLOAT_FAST=
_INT64  -DFLOAT16 -DFLOAT64 -DEXTFLOAT80 -DFLOAT128 -DFLOAT_ROUND_ODD -DLON=
G_DOUBLE_IS_EXTFLOAT80  -Wno-strict-prototypes -Wno-unknown-pragmas -Wno-un=
initialized -Wno-missing-prototypes -Wno-return-type -Wno-unused-function -=
Wno-error -MMD -MP -MT uint128_inline.o -MF ./uint128_inline.d -g   -c -o u=
int128_inline.o /tmp/qemu-test/src/tests/fp/berkeley-testfloat-3/source/uin=
t128_inline.c
> clang -iquote /tmp/qemu-test/build/. -iquote . -iquote /tmp/qemu-test/src=
/tcg/i386 -isystem /tmp/qemu-test/src/linux-headers -isystem /tmp/qemu-test=
/build/linux-headers -iquote . -iquote /tmp/qemu-test/src -iquote /tmp/qemu=
-test/src/accel/tcg -iquote /tmp/qemu-test/src/include -iquote /tmp/qemu-te=
st/src/disas/libvixl -I/tmp/qemu-test/src/tests/fp -I/tmp/qemu-test/src/tes=
ts/fp/berkeley-softfloat-3/source/include -I/tmp/qemu-test/src/tests/fp/ber=
keley-softfloat-3/source/8086-SSE -I/tmp/qemu-test/src/tests/fp/berkeley-te=
stfloat-3/source -I/usr/include/pixman-1 -Werror -fsanitize=3Dundefined -fs=
anitize=3Daddress -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/in=
clude -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LAR=
GEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-s=
trings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=
=3Dgnu99 -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2=
k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-la=
bels -Wexpansion-to-defined -Wno-initializer-overrides -Wno-missing-include=
-dirs -Wno-shift-negative-value -Wno-string-plus-int -Wno-typedef-redefinit=
ion -Wno-tautological-type-limit-compare -fstack-protector-strong -I/usr/in=
clude/p11-kit-1 -DSTRUCT_IOVEC_DEFINED -I/usr/include/libpng16 -I/usr/inclu=
de/spice-1 -I/usr/include/spice-server -I/usr/include/cacard -I/usr/include=
/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/nss3 -I/usr/include/=
nspr4 -pthread -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/=
pixman-1 -DHW_POISON_H -DTARGET_ARM  -DSOFTFLOAT_ROUND_ODD -DINLINE_LEVEL=
=3D5 -DSOFTFLOAT_FAST_DIV32TO16 -DSOFTFLOAT_FAST_DIV64TO32 -DSOFTFLOAT_FAST=
_INT64  -DFLOAT16 -DFLOAT64 -DEXTFLOAT80 -DFLOAT128 -DFLOAT_ROUND_ODD -DLON=
G_DOUBLE_IS_EXTFLOAT80  -Wno-strict-prototypes -Wno-unknown-pragmas -Wno-un=
initialized -Wno-missing-prototypes -Wno-return-type -Wno-unused-function -=
Wno-error -MMD -MP -MT uint128.o -MF ./uint128.d -g   -c -o uint128.o /tmp/=
qemu-test/src/tests/fp/berkeley-testfloat-3/source/uint128.c
> ---
> rm -f libtestfloat.a && ar rcs libtestfloat.a uint128_inline.o uint128.o =
fail.o functions_common.o functionInfos.o standardFunctionInfos.o random.o =
genCases_common.o genCases_ui32.o genCases_ui64.o genCases_i32.o genCases_i=
64.o genCases_f16.o genCases_f32.o genCases_f64.o genCases_extF80.o genCase=
s_f128.o genCases_writeTestsTotal.o verCases_inline.o verCases_common.o ver=
Cases_writeFunctionName.o readHex.o writeHex.o writeCase_a_ui32.o writeCase=
_a_ui64.o writeCase_a_f16.o writeCase_ab_f16.o writeCase_abc_f16.o writeCas=
e_a_f32.o writeCase_ab_f32.o writeCase_abc_f32.o writeCase_a_f64.o writeCas=
e_ab_f64.o writeCase_abc_f64.o writeCase_a_extF80M.o writeCase_ab_extF80M.o=
 writeCase_a_f128M.o writeCase_ab_f128M.o writeCase_abc_f128M.o writeCase_z=
_bool.o writeCase_z_ui32.o writeCase_z_ui64.o writeCase_z_f16.o writeCase_z=
_f32.o writeCase_z_f64.o writeCase_z_extF80M.o writeCase_z_f128M.o testLoop=
s_common.o test_a_ui32_z_f16.o test_a_ui32_z_f32.o test_a_ui32_z_f64.o test=
_a_ui32_z_extF80.o test_a_ui32_z_f128.o test_a_ui64_z_f16.o test_a_ui64_z_f=
32.o test_a_ui64_z_f64.o test_a_ui64_z_extF80.o test_a_ui64_z_f128.o test_a=
_i32_z_f16.o test_a_i32_z_f32.o test_a_i32_z_f64.o test_a_i32_z_extF80.o te=
st_a_i32_z_f128.o test_a_i64_z_f16.o test_a_i64_z_f32.o test_a_i64_z_f64.o =
test_a_i64_z_extF80.o test_a_i64_z_f128.o test_a_f16_z_ui32_rx.o test_a_f16=
_z_ui64_rx.o test_a_f16_z_i32_rx.o test_a_f16_z_i64_rx.o test_a_f16_z_ui32_=
x.o test_a_f16_z_ui64_x.o test_a_f16_z_i32_x.o test_a_f16_z_i64_x.o test_a_=
f16_z_f32.o test_a_f16_z_f64.o test_a_f16_z_extF80.o test_a_f16_z_f128.o te=
st_az_f16.o test_az_f16_rx.o test_abz_f16.o test_abcz_f16.o test_ab_f16_z_b=
ool.o test_a_f32_z_ui32_rx.o test_a_f32_z_ui64_rx.o test_a_f32_z_i32_rx.o t=
est_a_f32_z_i64_rx.o test_a_f32_z_ui32_x.o test_a_f32_z_ui64_x.o test_a_f32=
_z_i32_x.o test_a_f32_z_i64_x.o test_a_f32_z_f16.o test_a_f32_z_f64.o test_=
a_f32_z_extF80.o test_a_f32_z_f128.o test_az_f32.o test_az_f32_rx.o test_ab=
z_f32.o test_abcz_f32.o test_ab_f32_z_bool.o test_a_f64_z_ui32_rx.o test_a_=
f64_z_ui64_rx.o test_a_f64_z_i32_rx.o test_a_f64_z_i64_rx.o test_a_f64_z_ui=
32_x.o test_a_f64_z_ui64_x.o test_a_f64_z_i32_x.o test_a_f64_z_i64_x.o test=
_a_f64_z_f16.o test_a_f64_z_f32.o test_a_f64_z_extF80.o test_a_f64_z_f128.o=
 test_az_f64.o test_az_f64_rx.o test_abz_f64.o test_abcz_f64.o test_ab_f64_=
z_bool.o test_a_extF80_z_ui32_rx.o test_a_extF80_z_ui64_rx.o test_a_extF80_=
z_i32_rx.o test_a_extF80_z_i64_rx.o test_a_extF80_z_ui32_x.o test_a_extF80_=
z_ui64_x.o test_a_extF80_z_i32_x.o test_a_extF80_z_i64_x.o test_a_extF80_z_=
f16.o test_a_extF80_z_f32.o test_a_extF80_z_f64.o test_a_extF80_z_f128.o te=
st_az_extF80.o test_az_extF80_rx.o test_abz_extF80.o test_ab_extF80_z_bool.=
o test_a_f128_z_ui32_rx.o test_a_f128_z_ui64_rx.o test_a_f128_z_i32_rx.o te=
st_a_f128_z_i64_rx.o test_a_f128_z_ui32_x.o test_a_f128_z_ui64_x.o test_a_f=
128_z_i32_x.o test_a_f128_z_i64_x.o test_a_f128_z_f16.o test_a_f128_z_f32.o=
 test_a_f128_z_f64.o test_a_f128_z_extF80.o test_az_f128.o test_az_f128_rx.=
o test_abz_f128.o test_abcz_f128.o test_ab_f128_z_bool.o
> rm -f libsoftfloat.a && ar rcs libsoftfloat.a s_eq128.o s_le128.o s_lt128=
.o s_shortShiftLeft128.o s_shortShiftRight128.o s_shortShiftRightJam64.o s_=
shortShiftRightJam64Extra.o s_shortShiftRightJam128.o s_shortShiftRightJam1=
28Extra.o s_shiftRightJam32.o s_shiftRightJam64.o s_shiftRightJam64Extra.o =
s_shiftRightJam128.o s_shiftRightJam128Extra.o s_shiftRightJam256M.o s_coun=
tLeadingZeros8.o s_countLeadingZeros16.o s_countLeadingZeros32.o s_countLea=
dingZeros64.o s_add128.o s_add256M.o s_sub128.o s_sub256M.o s_mul64ByShifte=
d32To128.o s_mul64To128.o s_mul128By32.o s_mul128To256M.o s_approxRecip_1Ks=
.o s_approxRecip32_1.o s_approxRecipSqrt_1Ks.o s_approxRecipSqrt32_1.o s_ro=
undToUI32.o s_roundToUI64.o s_roundToI32.o s_roundToI64.o s_normSubnormalF1=
6Sig.o s_roundPackToF16.o s_normRoundPackToF16.o s_addMagsF16.o s_subMagsF1=
6.o s_mulAddF16.o s_normSubnormalF32Sig.o s_roundPackToF32.o s_normRoundPac=
kToF32.o s_addMagsF32.o s_subMagsF32.o s_mulAddF32.o s_normSubnormalF64Sig.=
o s_roundPackToF64.o s_normRoundPackToF64.o s_addMagsF64.o s_subMagsF64.o s=
_mulAddF64.o s_normSubnormalExtF80Sig.o s_roundPackToExtF80.o s_normRoundPa=
ckToExtF80.o s_addMagsExtF80.o s_subMagsExtF80.o s_normSubnormalF128Sig.o s=
_roundPackToF128.o s_normRoundPackToF128.o s_addMagsF128.o s_subMagsF128.o =
s_mulAddF128.o softfloat_state.o ui32_to_f16.o ui32_to_f32.o ui32_to_f64.o =
ui32_to_extF80.o ui32_to_extF80M.o ui32_to_f128.o ui32_to_f128M.o ui64_to_f=
16.o ui64_to_f32.o ui64_to_f64.o ui64_to_extF80.o ui64_to_extF80M.o ui64_to=
_f128.o ui64_to_f128M.o i32_to_f16.o i32_to_f32.o i32_to_f64.o i32_to_extF8=
0.o i32_to_extF80M.o i32_to_f128.o i32_to_f128M.o i64_to_f16.o i64_to_f32.o=
 i64_to_f64.o i64_to_extF80.o i64_to_extF80M.o i64_to_f128.o i64_to_f128M.o=
 f16_to_ui32.o f16_to_ui64.o f16_to_i32.o f16_to_i64.o f16_to_ui32_r_minMag=
.o f16_to_ui64_r_minMag.o f16_to_i32_r_minMag.o f16_to_i64_r_minMag.o f16_t=
o_f32.o f16_to_f64.o f16_to_extF80.o f16_to_extF80M.o f16_to_f128.o f16_to_=
f128M.o f16_roundToInt.o f16_add.o f16_sub.o f16_mul.o f16_mulAdd.o f16_div=
.o f16_rem.o f16_sqrt.o f16_eq.o f16_le.o f16_lt.o f16_eq_signaling.o f16_l=
e_quiet.o f16_lt_quiet.o f16_isSignalingNaN.o f32_to_ui32.o f32_to_ui64.o f=
32_to_i32.o f32_to_i64.o f32_to_ui32_r_minMag.o f32_to_ui64_r_minMag.o f32_=
to_i32_r_minMag.o f32_to_i64_r_minMag.o f32_to_f16.o f32_to_f64.o f32_to_ex=
tF80.o f32_to_extF80M.o f32_to_f128.o f32_to_f128M.o f32_roundToInt.o f32_a=
dd.o f32_sub.o f32_mul.o f32_mulAdd.o f32_div.o f32_rem.o f32_sqrt.o f32_eq=
.o f32_le.o f32_lt.o f32_eq_signaling.o f32_le_quiet.o f32_lt_quiet.o f32_i=
sSignalingNaN.o f64_to_ui32.o f64_to_ui64.o f64_to_i32.o f64_to_i64.o f64_t=
o_ui32_r_minMag.o f64_to_ui64_r_minMag.o f64_to_i32_r_minMag.o f64_to_i64_r=
_minMag.o f64_to_f16.o f64_to_f32.o f64_to_extF80.o f64_to_extF80M.o f64_to=
_f128.o f64_to_f128M.o f64_roundToInt.o f64_add.o f64_sub.o f64_mul.o f64_m=
ulAdd.o f64_div.o f64_rem.o f64_sqrt.o f64_eq.o f64_le.o f64_lt.o f64_eq_si=
gnaling.o f64_le_quiet.o f64_lt_quiet.o f64_isSignalingNaN.o extF80_to_ui32=
.o extF80_to_ui64.o extF80_to_i32.o extF80_to_i64.o extF80_to_ui32_r_minMag=
.o extF80_to_ui64_r_minMag.o extF80_to_i32_r_minMag.o extF80_to_i64_r_minMa=
g.o extF80_to_f16.o extF80_to_f32.o extF80_to_f64.o extF80_to_f128.o extF80=
_roundToInt.o extF80_add.o extF80_sub.o extF80_mul.o extF80_div.o extF80_re=
m.o extF80_sqrt.o extF80_eq.o extF80_le.o extF80_lt.o extF80_eq_signaling.o=
 extF80_le_quiet.o extF80_lt_quiet.o extF80_isSignalingNaN.o extF80M_to_ui3=
2.o extF80M_to_ui64.o extF80M_to_i32.o extF80M_to_i64.o extF80M_to_ui32_r_m=
inMag.o extF80M_to_ui64_r_minMag.o extF80M_to_i32_r_minMag.o extF80M_to_i64=
_r_minMag.o extF80M_to_f16.o extF80M_to_f32.o extF80M_to_f64.o extF80M_to_f=
128M.o extF80M_roundToInt.o extF80M_add.o extF80M_sub.o extF80M_mul.o extF8=
0M_div.o extF80M_rem.o extF80M_sqrt.o extF80M_eq.o extF80M_le.o extF80M_lt.=
o extF80M_eq_signaling.o extF80M_le_quiet.o extF80M_lt_quiet.o f128_to_ui32=
.o f128_to_ui64.o f128_to_i32.o f128_to_i64.o f128_to_ui32_r_minMag.o f128_=
to_ui64_r_minMag.o f128_to_i32_r_minMag.o f128_to_i64_r_minMag.o f128_to_f1=
6.o f128_to_f32.o f128_to_extF80.o f128_to_f64.o f128_roundToInt.o f128_add=
.o f128_sub.o f128_mul.o f128_mulAdd.o f128_div.o f128_rem.o f128_sqrt.o f1=
28_eq.o f128_le.o f128_lt.o f128_eq_signaling.o f128_le_quiet.o f128_lt_qui=
et.o f128_isSignalingNaN.o f128M_to_ui32.o f128M_to_ui64.o f128M_to_i32.o f=
128M_to_i64.o f128M_to_ui32_r_minMag.o f128M_to_ui64_r_minMag.o f128M_to_i3=
2_r_minMag.o f128M_to_i64_r_minMag.o f128M_to_f16.o f128M_to_f32.o f128M_to=
_extF80M.o f128M_to_f64.o f128M_roundToInt.o f128M_add.o f128M_sub.o f128M_=
mul.o f128M_mulAdd.o f128M_div.o f128M_rem.o f128M_sqrt.o f128M_eq.o f128M_=
le.o f128M_lt.o f128M_eq_signaling.o f128M_le_quiet.o f128M_lt_quiet.o soft=
float_raiseFlags.o s_f16UIToCommonNaN.o s_commonNaNToF16UI.o s_propagateNaN=
F16UI.o s_f32UIToCommonNaN.o s_commonNaNToF32UI.o s_propagateNaNF32UI.o s_f=
64UIToCommonNaN.o s_commonNaNToF64UI.o s_propagateNaNF64UI.o extF80M_isSign=
alingNaN.o s_extF80UIToCommonNaN.o s_commonNaNToExtF80UI.o s_propagateNaNEx=
tF80UI.o f128M_isSignalingNaN.o s_f128UIToCommonNaN.o s_commonNaNToF128UI.o=
 s_propagateNaNF128UI.o
> clang++ -g  -Wl,--warn-common -fsanitize=3Dundefined -fsanitize=3Daddress=
 -Wl,-z,relro -Wl,-z,now -pie -m64  -fstack-protector-strong -o fp-test fp-=
test.o slowfloat.o softfloat.o  libtestfloat.a libsoftfloat.a /tmp/qemu-tes=
t/build/libqemuutil.a   -lm -lz  -lgthread-2.0 -pthread -lglib-2.0  -lnettl=
e  -lgnutls  -lzstd   -lrt
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
> make[1]: Leaving directory '/tmp/qemu-test/build/tests/fp'
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 669, in <module>
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '=
--label', 'com.qemu.instance.uuid=3Dc5a8f4845d0942039c8021411f0c53d3', '-u'=
, '1001', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_L=
IST=3Dx86_64-softmmu', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e',=
 'J=3D14', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D', '-e', 'CCACHE_DIR=3D/var/=
tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache=
:z', '-v', '/var/tmp/patchew-tester-tmp-0pr2axi4/src/docker-src.2020-06-19-=
05.46.55.15290:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'te=
st-debug']' returned non-zero exit status 2.
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dc5a8f4845d0942039c80=
21411f0c53d3
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-0pr2axi4/src'
> make: *** [docker-run-test-debug@fedora] Error 2
>=20
> real    4m53.259s
> user    0m8.170s
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20200619091905.21676-1-kraxel@redhat.com/testing.=
asan/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


