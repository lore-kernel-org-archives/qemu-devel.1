Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A02EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 18:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF86204EA
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 18:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AS4UfAJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF86204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k472r-0000OH-3G
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 14:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k471b-00080Y-R9
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 14:23:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24625
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k471S-0006e2-QX
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 14:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596824597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n0iW+0iRaKCFpoJhjQFZ678bNAb99GCjZbclcWVHQ3g=;
 b=AS4UfAJWFvhD0AKwL9B6BwlfJhbvAo0DcwyHHIMdMRURwRUaNt2CUp2c6PmkcetNWbf8kL
 nPuyYWUVeKStD83y61yQtJd/zOHf8HPbeXXApl8XCmf5g/2ZjuNU0O5GsrrwCf6zAqf/zk
 xnSeKu0FnYc28ww1J3iABgYIRmkita4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-idHQFj1fNFuiE6NPSBTzAA-1; Fri, 07 Aug 2020 14:23:09 -0400
X-MC-Unique: idHQFj1fNFuiE6NPSBTzAA-1
Received: by mail-ed1-f69.google.com with SMTP id x68so1043257ede.21
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 11:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n0iW+0iRaKCFpoJhjQFZ678bNAb99GCjZbclcWVHQ3g=;
 b=R+uxaw2zZJK7dhCNry/+TVRP2WU9vpdv2SNAYUU66GcMpm6QLjCCMhe7wRJL9GdmfJ
 YAXpzOTgaRaQyr1BVg2X1+hiSi/NAMRlLeSgWB3h73A/fWQETwAEwkjP3c19N5gfiV4v
 WUwbw+HbO5X72xZYW3gonE+N7WNHMxoK1/jo+kSG9QRNi7YEJBeDEOlLdoB3Ju+e1lGX
 0gfW6c/fcLdlBDbtXvj4i1LE2fBOe/M0rqPJvIyxXW6KjbeOLcXsj3XfJKHkA7EF5ugZ
 vQHZ5I4AdCS80H/N23V36nmd/JpVx8qx2fPS69HtBR8maEkQhrGcnnIQ2M34fgZATOKJ
 8Psg==
X-Gm-Message-State: AOAM532Ii9zlIEJ7Ftki7UnSXko8qpu8kuPA4Oj3M7gECEWg7NLlC02j
 zntY1nVIVD30+WcXmmx5cX7eScA5R2W0tJ+1DoujlTPTgLYzmOiK9ECOD3RVhnYVyV7ClhT//IR
 gRepA5e7mW/VBgPc5HyQAU4DxmG4tB7Y=
X-Received: by 2002:a05:6402:1a54:: with SMTP id
 bf20mr10140091edb.217.1596824588321; 
 Fri, 07 Aug 2020 11:23:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSS+e+C1JSouIvCOS1+1FHjc+l3+6UjI/8c3Bhpcz+cqE/VQNePmzZ1RQ3va26dc9eNJIPv5+N4sDaObe+oSE=
X-Received: by 2002:a05:6402:1a54:: with SMTP id
 bf20mr10140035edb.217.1596824587773; 
 Fri, 07 Aug 2020 11:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-64-git-send-email-pbonzini@redhat.com>
 <20200807172225.bd5i7dhacq64c6td@mozz.bu.edu>
In-Reply-To: <20200807172225.bd5i7dhacq64c6td@mozz.bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Aug 2020 20:22:55 +0200
Message-ID: <CABgObfb9LroZBOW=dfEFWoVumugNi0CyTnzD72MqSG8Qt+s=hQ@mail.gmail.com>
Subject: Re: [PATCH 063/143] meson: convert tests/qtest to meson
To: Alexander Bulekov <alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000052bed505ac4db24d"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 14:23:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000052bed505ac4db24d
Content-Type: text/plain; charset="UTF-8"

Thanks Alexander. Fuzzing wasn't tested at all, so thanks for doing some of
the work for me.

Most things you noticed are bugs or stupidities on my part that I haven't
debugged yet. Release early, release often and all that. The next version
should have all these wrinkles ironed out!

Paolo

Il ven 7 ago 2020, 19:23 Alexander Bulekov <alxndr@bu.edu> ha scritto:

> Thank you, Paolo. I haven't gone through all the other messages yet, so
> maybe I missed some insights that would help with this.
>
> Some notes as I try to build qemu-fuzz-i386.
> * Needed to do git submodule update --init. IIRC this used to happen
>   automatically for stuff like slirp. I will need to update the oss-fuzz
>   build scripts (./scripts/oss-fuzz/build.sh) to init submodules.
>
> * My locally installed Meson was too old. Needed to add --meson=git . Is
>   there a reason this is not the default?
>
> * The make i386-softmmu/{all,fuzz} flavored targets are gone. Good. Now
>   we have qemu-system-i386 and qemu-fuzz-i386
>
> * Trying make qemu-fuzz-i386:
> ../tests/qtest/fuzz/virtio_scsi_fuzz.c:16:10: fatal error:
> 'libqos/virtio-scsi.h' file not found
> #include "libqos/virtio-scsi.h"
>          ^~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> make: *** [Makefile.ninja:2761:
> qemu-fuzz-i386.p/tests_qtest_fuzz_virtio_scsi_fuzz.c.o] Error 1
>
> No big deal, thats probably not the right way to include that stuff
> anyways:
>
> ------------------------
>
> diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c
> b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> index 977ac424ed..6ff6fabe4a 100644
> --- a/tests/qtest/fuzz/virtio_scsi_fuzz.c
> +++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> @@ -13,9 +13,9 @@
>  #include "qemu/osdep.h"
>
>  #include "tests/qtest/libqos/libqtest.h"
> -#include "libqos/virtio-scsi.h"
> -#include "libqos/virtio.h"
> -#include "libqos/virtio-pci.h"
> +#include "tests/qtest/libqos/virtio-scsi.h"
> +#include "tests/qtest/libqos/virtio.h"
> +#include "tests/qtest/libqos/virtio-pci.h"
>  #include "standard-headers/linux/virtio_ids.h"
>  #include "standard-headers/linux/virtio_pci.h"
>  #include "standard-headers/linux/virtio_scsi.h"
>
> ------------------------
>
> * Ok. Lets try again:
> In file included from ../ui/vnc.h:103:
> ../ui/vnc-auth-sasl.h:28:10: fatal error: 'sasl/sasl.h' file not found
> #include <sasl/sasl.h>
>          ^~~~~~~~~~~~~
>
> Didn't need that before - oh well. apt install libsasl-dev
>
> ../ui/input-keymap.c:7:10: fatal error:
> 'ui/input-keymap-atset1-to-qcode.c' file not found
> #include "ui/input-keymap-atset1-to-qcode.c"
>
> Can't find that anywhere. Lets try to clear out the build dir and build
> system without --enable-fuzzing:
> CC=clang-9 CXX=clang++-9 ../configure --enable-sanitizers --meson=git
> make qemu-system-i386
> ...
> ../qemu-options-wrapper.h:32:10: fatal error: 'qemu-options.def' file not
> found
> #include "qemu-options.def"
>
> Ok lets try:
> make qemu-options.def
>
> We get further now:
>
> ../ui/input-keymap.c:7:10: fatal error:
> 'ui/input-keymap-atset1-to-qcode.c' file not found
> #include "ui/input-keymap-atset1-to-qcode.c"
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> lets try: make "ui/input-keymap-atset1-to-qcode.c"
> .. and    make "ui/input-keymap-linux-to-qcode.c"
> .. and    make "ui/input-keymap-qcode-to-atset1.c"
> .. and    make "ui/input-keymap-qcode-to-atset2.c"
> .. and    make "ui/input-keymap-qcode-to-atset3.c"
> .. and    make "ui/input-keymap-qcode-to-linux.c"
> .. and    make "ui/input-keymap-qcode-to-qnum.c"
> .. and    make "ui/input-keymap-qcode-to-sun.c"
> .. and    make "ui/input-keymap-qnum-to-qcode.c"
>
> Since it seems the problems aren't specific to the fuzz target, Lets
> re-try with --enable-fuzzing
>
> Ok, we're very close now:
> clang: error: unknown argument: '-wrap'
> .... 19 times
> clang: error: no such file or directory: 'qtest_inb'
> ....
> clang: error: no such file or directory: 'qtest_memset'
>
> Ok what is it trying to do? Lets do make -n qemu-fuzz-i386:
>
> clang++-9  -o qemu-fuzz-i386
> qemu-fuzz-i386.p/tests_qtest_fuzz_i440fx_fuzz.c.o
> -fsanitize=fuzzer -Ttests/qtest/fuzz/fork_fuzz.ld -wrap qtest_inb -wrap
> qtest_inw -wrap qtest_inl -wrap qtest_outb -wrap qtest_outw -wrap
> qtest_outl -wrap qtest_readb -wrap qtest_readw -wrap qtest_readl -wrap
> qtest_readq -wrap qtest_writeb
>
> Hmm those need to have -Wl, . Lets just hack it in, for now (we also
> don't build qtest_wrappers.o, so lets fix that):
> diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
> index 58ab69a952..0345f6c993 100644
> --- a/tests/qtest/fuzz/meson.build
> +++ b/tests/qtest/fuzz/meson.build
> @@ -1,4 +1,4 @@
> -specific_fuzz_ss.add(files('fuzz.c', 'fork_fuzz.c', 'qos_fuzz.c'), qos)
> +specific_fuzz_ss.add(files('fuzz.c', 'fork_fuzz.c', 'qos_fuzz.c',
> 'qtest_wrappers.c'), qos)
>
>  # Targets
>  specific_fuzz_ss.add(when: 'CONFIG_I440FX', if_true:
> files('i440fx_fuzz.c'))
> @@ -10,25 +10,25 @@ specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI',
> if_true: files('virtio_scsi_fuz
>  fork_fuzz = declare_dependency(
>    link_args: ['-fsanitize=fuzzer',
>                '-Ttests/qtest/fuzz/fork_fuzz.ld',
> -              '-wrap', 'qtest_inb',
> -              '-wrap', 'qtest_inw',
> -              '-wrap', 'qtest_inl',
> -              '-wrap', 'qtest_outb',
> -              '-wrap', 'qtest_outw',
> -              '-wrap', 'qtest_outl',
> -              '-wrap', 'qtest_readb',
> -              '-wrap', 'qtest_readw',
> -              '-wrap', 'qtest_readl',
> -              '-wrap', 'qtest_readq',
> -              '-wrap', 'qtest_writeb',
> -              '-wrap', 'qtest_writew',
> -              '-wrap', 'qtest_writel',
> -              '-wrap', 'qtest_writeq',
> -              '-wrap', 'qtest_memread',
> -              '-wrap', 'qtest_bufread',
> -              '-wrap', 'qtest_memwrite',
> -              '-wrap', 'qtest_bufwrite',
> -              '-wrap', 'qtest_memset']
> +              '-Wl,-wrap,qtest_inb',
> +              '-Wl,-wrap,qtest_inw',
> +              '-Wl,-wrap,qtest_inl',
> +              '-Wl,-wrap,qtest_outb',
> +              '-Wl,-wrap,qtest_outw',
> +              '-Wl,-wrap,qtest_outl',
> +              '-Wl,-wrap,qtest_readb',
> +              '-Wl,-wrap,qtest_readw',
> +              '-Wl,-wrap,qtest_readl',
> +              '-Wl,-wrap,qtest_readq',
> +              '-Wl,-wrap,qtest_writeb',
> +              '-Wl,-wrap,qtest_writew',
> +              '-Wl,-wrap,qtest_writel',
> +              '-Wl,-wrap,qtest_writeq',
> +              '-Wl,-wrap,qtest_memread',
> +              '-Wl,-wrap,qtest_bufread',
> +              '-Wl,-wrap,qtest_memwrite',
> +              '-Wl,-wrap,qtest_bufwrite',
> +              '-Wl,-wrap,qtest_memset']
>  )
>
>  specific_fuzz_ss.add(fork_fuzz)
>
> ../tests/qtest/fuzz/qtest_wrappers.c:15:10: fatal error: 'cpu.h' file not
> found
> #include "cpu.h"
>
> How did we get away with that in the first place?
>
> -----------------------------
> diff --git a/tests/qtest/fuzz/qtest_wrappers.c
> b/tests/qtest/fuzz/qtest_wrappers.c
> index 713c830cdb..0580f8df86 100644
> --- a/tests/qtest/fuzz/qtest_wrappers.c
> +++ b/tests/qtest/fuzz/qtest_wrappers.c
> @@ -12,7 +12,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "cpu.h"
> +#include "hw/core/cpu.h"
>  #include "exec/ioport.h"
>
>  #include "fuzz.h"
> -----------------------------
>
> Ok now:
> Linking target qemu-fuzz-i386
> clang: warning: argument unused during compilation: '-T
> tests/qtest/fuzz/fork_fuzz.ld' [-Wunused-command-line-argument]
> /usr/bin/ld: libcommon.fa.p/softmmu_main.c.o: in function `main':
> /tmp/qemu/build/../softmmu/main.c:47: multiple definition of `main';
> /usr/lib/llvm-9/lib/clang/9.0.1/lib/linux/libclang_rt.fuzzer-x86_64.a(fuzzer.o):(.text.main+0x0):
> first defined here
> /usr/bin/ld: /tmp/qemu/build/../tests/qtest/fuzz/fork_fuzz.c:22: undefined
> reference to `__FUZZ_COUNTERS_START'
>
> We are _very_ close, but this is where I have no idea how to get meson
> to do what I want. Two things:
> 1.) The flag for linking should be something like:
> -Wl,-T$(SRC_PATH)/tests/qtest/fuzz/fork_fuzz.ld . Right now it is
> -T./tests/qtest/fuzz/fork_fuzz.ld
> 2.) We should not be linking against softmmu_main.c.o
>
> I ran with make -n and copied the last (linking step) command and
> manually made these two changes. With that, I find a binary
> ./qemu-fuzz-i386
> and when I run it, I see all the targets I expect to see.
> But when I run one of the actual targets, I get:
> ./qemu-fuzz-i386 --fuzz-target=virtio-net-slirp -runs=1000
> ERROR: no interesting inputs were found. Is the code instrumented for
> coverage? Exit
> So it looks like the -fsanitize=fuzzer (or fsanitize=fuzzer-no-link)
> flag doesn't get passed anywhere during compilation.. (Confirmed that by
> checking make -n)
>
> This feels very close. If I configure, with
> CFLAGS="-fsanitize=fuzzer" , I'm up and running.
>
> Thanks again. Once I know that I'm doing things right, I can work on
> converting the oss-fuzz build script, so it works with meson.
> -Alex
>
> On 200806 2114, Paolo Bonzini wrote:
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  meson.build                                      |   3 +
> >  tests/Makefile.include                           |  49 +---
> >  tests/meson.build                                |   1 +
> >  tests/qtest/Makefile.include                     | 332
> -----------------------
> >  tests/qtest/ac97-test.c                          |   2 +-
> >  tests/qtest/acpi-utils.h                         |   2 +-
> >  tests/qtest/ahci-test.c                          |   2 +-
> >  tests/qtest/arm-cpu-features.c                   |   2 +-
> >  tests/qtest/boot-order-test.c                    |   2 +-
> >  tests/qtest/boot-sector.c                        |   2 +-
> >  tests/qtest/boot-sector.h                        |   2 +-
> >  tests/qtest/boot-serial-test.c                   |   2 +-
> >  tests/qtest/cdrom-test.c                         |   2 +-
> >  tests/qtest/dbus-vmstate-test.c                  |   2 +-
> >  tests/qtest/device-introspect-test.c             |   2 +-
> >  tests/qtest/device-plug-test.c                   |   2 +-
> >  tests/qtest/drive_del-test.c                     |   2 +-
> >  tests/qtest/ds1338-test.c                        |   2 +-
> >  tests/qtest/e1000-test.c                         |   2 +-
> >  tests/qtest/eepro100-test.c                      |   2 +-
> >  tests/qtest/endianness-test.c                    |   2 +-
> >  tests/qtest/es1370-test.c                        |   2 +-
> >  tests/qtest/fuzz/fuzz.c                          |   2 +-
> >  tests/qtest/fuzz/fuzz.h                          |   2 +-
> >  tests/qtest/fuzz/i440fx_fuzz.c                   |   2 +-
> >  tests/qtest/fuzz/qos_fuzz.c                      |   2 +-
> >  tests/qtest/fuzz/virtio_net_fuzz.c               |   2 +-
> >  tests/qtest/fuzz/virtio_scsi_fuzz.c              |   2 +-
> >  tests/qtest/fw_cfg-test.c                        |   2 +-
> >  tests/qtest/hd-geo-test.c                        |   2 +-
> >  tests/qtest/hexloader-test.c                     |   2 +-
> >  tests/qtest/ide-test.c                           |   2 +-
> >  tests/qtest/ipoctal232-test.c                    |   2 +-
> >  tests/qtest/ivshmem-test.c                       |   2 +-
> >  tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c |   4 +-
> >  tests/qtest/libqos/ahci.c                        |   6 +-
> >  tests/qtest/libqos/ahci.h                        |   6 +-
> >  tests/qtest/libqos/arm-imx25-pdk-machine.c       |   6 +-
> >  tests/qtest/libqos/arm-n800-machine.c            |   6 +-
> >  tests/qtest/libqos/arm-raspi2-machine.c          |   4 +-
> >  tests/qtest/libqos/arm-sabrelite-machine.c       |   4 +-
> >  tests/qtest/libqos/arm-smdkc210-machine.c        |   4 +-
> >  tests/qtest/libqos/arm-virt-machine.c            |   6 +-
> >  tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c  |   4 +-
> >  tests/qtest/libqos/e1000e.c                      |   6 +-
> >  tests/qtest/libqos/e1000e.h                      |   2 +-
> >  tests/qtest/libqos/fw_cfg.c                      |   2 +-
> >  tests/qtest/libqos/i2c-imx.c                     |   2 +-
> >  tests/qtest/libqos/i2c-omap.c                    |   2 +-
> >  tests/qtest/libqos/i2c.c                         |   2 +-
> >  tests/qtest/libqos/i2c.h                         |   2 +-
> >  tests/qtest/libqos/libqos-pc.c                   |   6 +-
> >  tests/qtest/libqos/libqos-pc.h                   |   2 +-
> >  tests/qtest/libqos/libqos-spapr.c                |   6 +-
> >  tests/qtest/libqos/libqos-spapr.h                |   2 +-
> >  tests/qtest/libqos/libqos.c                      |   4 +-
> >  tests/qtest/libqos/libqos.h                      |   4 +-
> >  tests/qtest/{ => libqos}/libqtest.h              |   0
> >  tests/qtest/libqos/malloc-pc.c                   |   4 +-
> >  tests/qtest/libqos/malloc-pc.h                   |   2 +-
> >  tests/qtest/libqos/malloc-spapr.c                |   2 +-
> >  tests/qtest/libqos/malloc-spapr.h                |   2 +-
> >  tests/qtest/libqos/malloc.c                      |   2 +-
> >  tests/qtest/libqos/meson.build                   |  57 ++++
> >  tests/qtest/libqos/pci-pc.c                      |   2 +-
> >  tests/qtest/libqos/pci-pc.h                      |   6 +-
> >  tests/qtest/libqos/pci-spapr.c                   |   6 +-
> >  tests/qtest/libqos/pci-spapr.h                   |   6 +-
> >  tests/qtest/libqos/pci.c                         |   4 +-
> >  tests/qtest/libqos/pci.h                         |   2 +-
> >  tests/qtest/libqos/ppc64_pseries-machine.c       |   4 +-
> >  tests/qtest/libqos/qgraph.c                      |   4 +-
> >  tests/qtest/libqos/qgraph.h                      |   6 +-
> >  tests/qtest/libqos/qgraph_internal.h             |   4 +-
> >  tests/qtest/libqos/qos_external.c                |   8 +-
> >  tests/qtest/libqos/qos_external.h                |   4 +-
> >  tests/qtest/libqos/rtas.c                        |   2 +-
> >  tests/qtest/libqos/rtas.h                        |   2 +-
> >  tests/qtest/libqos/sdhci.c                       |   2 +-
> >  tests/qtest/libqos/sdhci.h                       |   2 +-
> >  tests/qtest/libqos/tpci200.c                     |   4 +-
> >  tests/qtest/libqos/usb.c                         |   2 +-
> >  tests/qtest/libqos/usb.h                         |   2 +-
> >  tests/qtest/libqos/virtio-9p.c                   |   4 +-
> >  tests/qtest/libqos/virtio-9p.h                   |   6 +-
> >  tests/qtest/libqos/virtio-balloon.c              |   4 +-
> >  tests/qtest/libqos/virtio-balloon.h              |   6 +-
> >  tests/qtest/libqos/virtio-blk.c                  |   4 +-
> >  tests/qtest/libqos/virtio-blk.h                  |   6 +-
> >  tests/qtest/libqos/virtio-mmio.c                 |   8 +-
> >  tests/qtest/libqos/virtio-mmio.h                 |   4 +-
> >  tests/qtest/libqos/virtio-net.c                  |   4 +-
> >  tests/qtest/libqos/virtio-net.h                  |   6 +-
> >  tests/qtest/libqos/virtio-pci.c                  |  14 +-
> >  tests/qtest/libqos/virtio-pci.h                  |   6 +-
> >  tests/qtest/libqos/virtio-rng.c                  |   4 +-
> >  tests/qtest/libqos/virtio-rng.h                  |   6 +-
> >  tests/qtest/libqos/virtio-scsi.c                 |   4 +-
> >  tests/qtest/libqos/virtio-scsi.h                 |   6 +-
> >  tests/qtest/libqos/virtio-serial.c               |   4 +-
> >  tests/qtest/libqos/virtio-serial.h               |   6 +-
> >  tests/qtest/libqos/virtio.c                      |   2 +-
> >  tests/qtest/libqos/virtio.h                      |   2 +-
> >  tests/qtest/libqos/x86_64_pc-machine.c           |   2 +-
> >  tests/qtest/libqtest-single.h                    |   2 +-
> >  tests/qtest/libqtest.c                           |   2 +-
> >  tests/qtest/m48t59-test.c                        |   2 +-
> >  tests/qtest/machine-none-test.c                  |   2 +-
> >  tests/qtest/megasas-test.c                       |   2 +-
> >  tests/qtest/meson.build                          | 254 +++++++++++++++++
> >  tests/qtest/microbit-test.c                      |   2 +-
> >  tests/qtest/migration-helpers.h                  |   2 +-
> >  tests/qtest/migration-test.c                     |   4 +-
> >  tests/qtest/modules-test.c                       |   2 +-
> >  tests/qtest/ne2000-test.c                        |   2 +-
> >  tests/qtest/numa-test.c                          |   2 +-
> >  tests/qtest/nvme-test.c                          |   2 +-
> >  tests/qtest/pca9552-test.c                       |   2 +-
> >  tests/qtest/pci-test.c                           |   2 +-
> >  tests/qtest/pcnet-test.c                         |   2 +-
> >  tests/qtest/pflash-cfi02-test.c                  |   2 +-
> >  tests/qtest/pnv-xscom-test.c                     |   2 +-
> >  tests/qtest/prom-env-test.c                      |   2 +-
> >  tests/qtest/pvpanic-test.c                       |   2 +-
> >  tests/qtest/pxe-test.c                           |   2 +-
> >  tests/qtest/q35-test.c                           |   2 +-
> >  tests/qtest/qmp-cmd-test.c                       |   2 +-
> >  tests/qtest/qmp-test.c                           |   2 +-
> >  tests/qtest/qom-test.c                           |   2 +-
> >  tests/qtest/rtas-test.c                          |   2 +-
> >  tests/qtest/sdhci-test.c                         |   2 +-
> >  tests/qtest/spapr-phb-test.c                     |   2 +-
> >  tests/qtest/tco-test.c                           |   2 +-
> >  tests/qtest/test-filter-mirror.c                 |   2 +-
> >  tests/qtest/test-filter-redirector.c             |   2 +-
> >  tests/qtest/test-hmp.c                           |   2 +-
> >  tests/qtest/tpm-crb-swtpm-test.c                 |   2 +-
> >  tests/qtest/tpm-tis-device-swtpm-test.c          |   2 +-
> >  tests/qtest/tpm-tis-swtpm-test.c                 |   2 +-
> >  tests/qtest/tpm-util.c                           |   2 +-
> >  tests/qtest/tulip-test.c                         |   2 +-
> >  tests/qtest/virtio-rng-test.c                    |   2 +-
> >  tests/qtest/virtio-test.c                        |   2 +-
> >  tests/qtest/vmgenid-test.c                       |   2 +-
> >  tests/qtest/vmxnet3-test.c                       |   2 +-
> >  tests/qtest/wdt_ib700-test.c                     |   2 +-
> >  tests/test-qga.c                                 |   2 +-
> >  tests/test-qgraph.c                              |   5 +-
> >  148 files changed, 539 insertions(+), 592 deletions(-)
> >  delete mode 100644 tests/qtest/Makefile.include
> >  rename tests/qtest/{ => libqos}/libqtest.h (100%)
> >  create mode 100644 tests/qtest/libqos/meson.build
> >  create mode 100644 tests/qtest/meson.build
> >
> > diff --git a/meson.build b/meson.build
> > index 3daa82e..a81516a 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -511,6 +511,9 @@ subdir('nbd')
> >  subdir('scsi')
> >  subdir('block')
> >
> > +# needed for fuzzing binaries
> > +subdir('tests/qtest/libqos')
> > +
> >  mods = []
> >  block_mods = []
> >  softmmu_mods = []
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index a0e5d3e..567ad69 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -109,6 +109,7 @@ check-unit-y += tests/test-qht$(EXESUF)
> >  check-unit-y += tests/test-qht-par$(EXESUF)
> >  check-unit-y += tests/test-bitops$(EXESUF)
> >  check-unit-y += tests/test-bitcnt$(EXESUF)
> > +check-unit-y += tests/test-qgraph$(EXESUF)
> >  check-unit-y += tests/check-qom-interface$(EXESUF)
> >  check-unit-y += tests/check-qom-proplist$(EXESUF)
> >  check-unit-y += tests/test-qemu-opts$(EXESUF)
> > @@ -306,19 +307,6 @@ tests/test-qapi-gen-timestamp: \
> >       @rm -f tests/test-qapi-doc.texi
> >       @>$@
> >
> > -tests/qtest/dbus-vmstate1.h tests/qtest/dbus-vmstate1.c:
> tests/qtest/dbus-vmstate1-gen-timestamp ;
> > -tests/qtest/dbus-vmstate1-gen-timestamp:
> $(SRC_PATH)/tests/qtest/dbus-vmstate1.xml
> > -     $(call quiet-command,$(GDBUS_CODEGEN) $< \
> > -             --interface-prefix org.qemu --generate-c-code
> tests/qtest/dbus-vmstate1, \
> > -             "GEN","$(@:%-timestamp=%)")
> > -     @>$@
> > -
> > -tests/qtest/dbus-vmstate-test.o-cflags := -DSRCDIR="$(SRC_PATH)"
> > -tests/qtest/dbus-vmstate1.o-cflags := $(GIO_CFLAGS)
> > -tests/qtest/dbus-vmstate1.o-libs := $(GIO_LIBS)
> > -
> > -tests/qtest/dbus-vmstate-test.o: tests/qtest/dbus-vmstate1.h
> > -
> >  tests/test-string-output-visitor$(EXESUF):
> tests/test-string-output-visitor.o $(test-qapi-obj-y)
> >  tests/test-string-input-visitor$(EXESUF):
> tests/test-string-input-visitor.o $(test-qapi-obj-y)
> >  tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o
> $(test-qapi-obj-y) tests/test-qapi-emit-events.o tests/test-qapi-events.o
> > @@ -333,6 +321,7 @@ tests/test-shift128$(EXESUF): tests/test-shift128.o
> $(test-util-obj-y)
> >  tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)
> >  tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-y)
> >  tests/test-bitcnt$(EXESUF): tests/test-bitcnt.o $(test-util-obj-y)
> > +tests/test-qgraph$(EXESUF): tests/test-qgraph.o
> tests/qtest/libqos/qgraph.o $(test-util-obj-y)
> >  tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o
> $(test-crypto-obj-y)
> >  tests/benchmark-crypto-hash$(EXESUF): tests/benchmark-crypto-hash.o
> $(test-crypto-obj-y)
> >  tests/test-crypto-hmac$(EXESUF): tests/test-crypto-hmac.o
> $(test-crypto-obj-y)
> > @@ -396,10 +385,8 @@ tests/migration/initrd-stress.img:
> tests/migration/stress$(EXESUF)
> >       rm $(INITRD_WORK_DIR)/init
> >       rmdir $(INITRD_WORK_DIR)
> >
> > -include $(SRC_PATH)/tests/qtest/Makefile.include
> > -
> >  tests/test-qga$(EXESUF): qga/qemu-ga$(EXESUF)
> > -tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
> > +tests/test-qga$(EXESUF): tests/test-qga.o tests/qtest/libqtest.o
> $(test-util-obj-y)
> >  tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o
> $(test-util-obj-y) libvhost-user.a
> >  tests/qemu-iotests/socket_scm_helper$(EXESUF):
> tests/qemu-iotests/socket_scm_helper.o
> >
> > @@ -440,16 +427,6 @@ define do_test_tap
> >         "TAP","$@")
> >  endef
> >
> > -.PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
> > -$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%:
> %-softmmu/all $(check-qtest-y)
> > -     $(call do_test_human,$(check-qtest-$*-y:%=tests/qtest/%$(EXESUF))
> $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF)), \
> > -       QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
> > -       QTEST_QEMU_IMG=qemu-img$(EXESUF))
> > -
> > -build-qtest: $(patsubst %, %-softmmu/all, $(QTEST_TARGETS))
> $(check-qtest-y)
> > -
> > -build-unit: $(check-unit-y)
> > -
> >  check-unit: $(check-unit-y)
> >       $(call do_test_human, $^)
> >
> > @@ -458,18 +435,9 @@ check-speed: $(check-speed-y)
> >
> >  # gtester tests with TAP output
> >
> > -$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)):
> check-report-qtest-%.tap: %-softmmu/all $(check-qtest-y)
> > -     $(call do_test_tap, $(check-qtest-$*-y:%=tests/qtest/%$(EXESUF))
> $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF)), \
> > -       QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
> > -       QTEST_QEMU_IMG=qemu-img$(EXESUF))
> > -
> >  check-report-unit.tap: $(check-unit-y)
> >       $(call do_test_tap,$^)
> >
> > -# Reports and overall runs
> > -
> > -check-report.tap: $(patsubst %,check-report-qtest-%.tap,
> $(QTEST_TARGETS)) check-report-unit.tap
> > -
> >  # Plugins
> >  ifeq ($(CONFIG_PLUGIN),y)
> >  .PHONY: plugins
> > @@ -582,19 +550,16 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> get-vm-images
> >
> >  # Consolidated targets
> >
> > -.PHONY: check-block check-qtest check-unit check check-clean
> get-vm-images
> > -check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
> > +.PHONY: check-block check-unit check check-clean get-vm-images
> >  ifeq ($(CONFIG_TOOLS),y)
> >  check-block: $(patsubst %,check-%, $(check-block-y))
> >  endif
> > -check-build: build-unit build-qtest
> > +check-build: build-unit
> >
> > -check: check-block check-unit check-qtest
> > +check: check-block check-unit
> >  check-clean:
> >       rm -rf $(check-unit-y) tests/*.o tests/*/*.o
> $(QEMU_IOTESTS_HELPERS-y)
> > -     rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST),
> $(check-qtest-$(target)-y:%=tests/qtest/%$(EXESUF)))
> $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF)))
> >       rm -f tests/test-qapi-gen-timestamp
> > -     rm -f tests/qtest/dbus-vmstate1-gen-timestamp
> >       rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
> >
> >  check: check-block check-qapi-schema check-unit check-qtest
> check-decodetree
> > @@ -606,7 +571,5 @@ clean: check-clean
> >  all: $(QEMU_IOTESTS_HELPERS-y)
> >
> >  -include $(wildcard tests/*.d)
> > --include $(wildcard tests/qtest/*.d)
> > --include $(wildcard tests/qtest/libqos/*.d)
> >
> >  endif
> > diff --git a/tests/meson.build b/tests/meson.build
> > index 8be9c22..d724402 100644
> > --- a/tests/meson.build
> > +++ b/tests/meson.build
> > @@ -8,3 +8,4 @@ if 'CONFIG_TCG' in config_host
> >  endif
> >
> >  subdir('qapi-schema')
> > +subdir('qtest')
> > diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
> > deleted file mode 100644
> > index b0204e4..0000000
> > --- a/tests/qtest/Makefile.include
> > +++ /dev/null
> > @@ -1,332 +0,0 @@
> > -# All QTests for now are POSIX-only, but the dependencies are
> > -# really in libqtest, not in the testcases themselves.
> > -
> > -check-qtest-generic-y += cdrom-test
> > -check-qtest-generic-y += device-introspect-test
> > -check-qtest-generic-y += machine-none-test
> > -check-qtest-generic-y += qmp-test
> > -check-qtest-generic-y += qmp-cmd-test
> > -check-qtest-generic-y += qom-test
> > -check-qtest-generic-$(CONFIG_MODULES) += modules-test
> > -check-qtest-generic-y += test-hmp
> > -
> > -check-qtest-pci-$(CONFIG_RTL8139_PCI) += rtl8139-test
> > -check-qtest-pci-$(CONFIG_VGA) += display-vga-test
> > -check-qtest-pci-$(CONFIG_HDA) += intel-hda-test
> > -check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += ivshmem-test
> > -
> > -DBUS_DAEMON := $(shell which dbus-daemon 2>/dev/null)
> > -ifneq ($(GDBUS_CODEGEN),)
> > -ifneq ($(DBUS_DAEMON),)
> > -# Temporarily disabled due to Patchew failures:
> > -#check-qtest-pci-$(CONFIG_GIO) += dbus-vmstate-test
> > -endif
> > -endif
> > -
> > -check-qtest-i386-$(CONFIG_ISA_TESTDEV) = endianness-test
> > -check-qtest-i386-y += fdc-test
> > -check-qtest-i386-y += ide-test
> > -check-qtest-i386-$(CONFIG_TOOLS) += ahci-test
> > -check-qtest-i386-y += hd-geo-test
> > -check-qtest-i386-y += boot-order-test
> > -check-qtest-i386-y += bios-tables-test
> > -check-qtest-i386-$(CONFIG_SGA) += boot-serial-test
> > -check-qtest-i386-$(CONFIG_SLIRP) += pxe-test
> > -check-qtest-i386-y += rtc-test
> > -check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += ipmi-kcs-test
> > -ifdef CONFIG_LINUX
> > -check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += ipmi-bt-test
> > -endif
> > -check-qtest-i386-y += i440fx-test
> > -check-qtest-i386-y += fw_cfg-test
> > -check-qtest-i386-y += device-plug-test
> > -check-qtest-i386-y += drive_del-test
> > -check-qtest-i386-$(CONFIG_WDT_IB700) += wdt_ib700-test
> > -check-qtest-i386-y += tco-test
> > -check-qtest-i386-y += $(check-qtest-pci-y)
> > -check-qtest-i386-$(CONFIG_PVPANIC) += pvpanic-test
> > -check-qtest-i386-$(CONFIG_I82801B11) += i82801b11-test
> > -check-qtest-i386-$(CONFIG_IOH3420) += ioh3420-test
> > -check-qtest-i386-$(CONFIG_USB_UHCI) += usb-hcd-uhci-test
> > -check-qtest-i386-$(call land,$(CONFIG_USB_EHCI),$(CONFIG_USB_UHCI)) +=
> usb-hcd-ehci-test
> > -check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += usb-hcd-xhci-test
> > -check-qtest-i386-y += cpu-plug-test
> > -check-qtest-i386-y += q35-test
> > -check-qtest-i386-y += vmgenid-test
> > -check-qtest-i386-$(CONFIG_TPM_CRB) += tpm-crb-swtpm-test
> > -check-qtest-i386-$(CONFIG_TPM_CRB) += tpm-crb-test
> > -check-qtest-i386-$(CONFIG_TPM_TIS_ISA) += tpm-tis-swtpm-test
> > -check-qtest-i386-$(CONFIG_TPM_TIS_ISA) += tpm-tis-test
> > -check-qtest-i386-$(CONFIG_SLIRP) += test-netfilter
> > -check-qtest-i386-$(CONFIG_POSIX) += test-filter-mirror
> > -check-qtest-i386-$(CONFIG_RTL8139_PCI) += test-filter-redirector
> > -check-qtest-i386-y += migration-test
> > -check-qtest-i386-y += test-x86-cpuid-compat
> > -check-qtest-i386-y += numa-test
> > -
> > -check-qtest-x86_64-y += $(check-qtest-i386-y)
> > -
> > -check-qtest-avr-y += boot-serial-test
> > -
> > -check-qtest-alpha-y += boot-serial-test
> > -check-qtest-alpha-$(CONFIG_VGA) += display-vga-test
> > -
> > -check-qtest-hppa-y += boot-serial-test
> > -check-qtest-hppa-$(CONFIG_VGA) += display-vga-test
> > -
> > -check-qtest-m68k-y = boot-serial-test
> > -
> > -check-qtest-microblaze-y += boot-serial-test
> > -
> > -check-qtest-mips-$(CONFIG_ISA_TESTDEV) = endianness-test
> > -check-qtest-mips-$(CONFIG_VGA) += display-vga-test
> > -
> > -check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = endianness-test
> > -check-qtest-mips64-$(CONFIG_VGA) += display-vga-test
> > -
> > -check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = endianness-test
> > -check-qtest-mips64el-$(CONFIG_VGA) += display-vga-test
> > -
> > -check-qtest-moxie-y += boot-serial-test
> > -
> > -check-qtest-ppc-$(CONFIG_ISA_TESTDEV) = endianness-test
> > -check-qtest-ppc-y += boot-order-test
> > -check-qtest-ppc-y += prom-env-test
> > -check-qtest-ppc-y += drive_del-test
> > -check-qtest-ppc-y += boot-serial-test
> > -check-qtest-ppc-$(CONFIG_M48T59) += m48t59-test
> > -
> > -check-qtest-ppc64-y += $(check-qtest-ppc-y)
> > -check-qtest-ppc64-$(CONFIG_PSERIES) += device-plug-test
> > -check-qtest-ppc64-$(CONFIG_POWERNV) += pnv-xscom-test
> > -check-qtest-ppc64-y += migration-test
> > -check-qtest-ppc64-$(CONFIG_PSERIES) += rtas-test
> > -check-qtest-ppc64-$(CONFIG_SLIRP) += pxe-test
> > -check-qtest-ppc64-$(CONFIG_USB_UHCI) += usb-hcd-uhci-test
> > -check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += usb-hcd-xhci-test
> > -check-qtest-ppc64-$(CONFIG_SLIRP) += test-netfilter
> > -check-qtest-ppc64-$(CONFIG_POSIX) += test-filter-mirror
> > -check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += test-filter-redirector
> > -check-qtest-ppc64-$(CONFIG_VGA) += display-vga-test
> > -check-qtest-ppc64-y += numa-test
> > -check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += ivshmem-test
> > -check-qtest-ppc64-y += cpu-plug-test
> > -
> > -check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = endianness-test
> > -
> > -check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) = endianness-test
> > -
> > -check-qtest-sparc-y += prom-env-test
> > -check-qtest-sparc-y += m48t59-test
> > -check-qtest-sparc-y += boot-serial-test
> > -
> > -check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = endianness-test
> > -check-qtest-sparc64-y += prom-env-test
> > -check-qtest-sparc64-y += boot-serial-test
> > -
> > -check-qtest-arm-y += arm-cpu-features
> > -check-qtest-arm-y += microbit-test
> > -check-qtest-arm-y += m25p80-test
> > -check-qtest-arm-y += test-arm-mptimer
> > -check-qtest-arm-y += boot-serial-test
> > -check-qtest-arm-y += hexloader-test
> > -check-qtest-arm-$(CONFIG_PFLASH_CFI02) += pflash-cfi02-test
> > -
> > -check-qtest-aarch64-y += arm-cpu-features
> > -check-qtest-aarch64-$(CONFIG_TPM_TIS_SYSBUS) += tpm-tis-device-test
> > -check-qtest-aarch64-$(CONFIG_TPM_TIS_SYSBUS) +=
> tpm-tis-device-swtpm-test
> > -check-qtest-aarch64-y += numa-test
> > -check-qtest-aarch64-y += boot-serial-test
> > -check-qtest-aarch64-y += migration-test
> > -
> > -# TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test
> unconditional
> > -ifneq ($(ARCH),arm)
> > -check-qtest-aarch64-y += bios-tables-test
> > -endif
> > -
> > -check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
> > -
> > -check-qtest-xtensaeb-y += $(check-qtest-xtensa-y)
> > -
> > -check-qtest-s390x-y = boot-serial-test
> > -check-qtest-s390x-$(CONFIG_SLIRP) += pxe-test
> > -check-qtest-s390x-$(CONFIG_SLIRP) += test-netfilter
> > -check-qtest-s390x-$(CONFIG_POSIX) += test-filter-mirror
> > -check-qtest-s390x-$(CONFIG_POSIX) += test-filter-redirector
> > -check-qtest-s390x-y += drive_del-test
> > -check-qtest-s390x-y += device-plug-test
> > -check-qtest-s390x-y += virtio-ccw-test
> > -check-qtest-s390x-y += cpu-plug-test
> > -check-qtest-s390x-y += migration-test
> > -
> > -# libqos / qgraph :
> > -libqgraph-obj-y = tests/qtest/libqos/qgraph.o
> > -
> > -libqos-core-obj-y = $(libqgraph-obj-y) tests/qtest/libqos/pci.o
> tests/qtest/libqos/fw_cfg.o
> > -libqos-core-obj-y += tests/qtest/libqos/malloc.o
> > -libqos-core-obj-y += tests/qtest/libqos/libqos.o
> > -libqos-spapr-obj-y = $(libqos-core-obj-y)
> tests/qtest/libqos/malloc-spapr.o
> > -libqos-spapr-obj-y += tests/qtest/libqos/libqos-spapr.o
> > -libqos-spapr-obj-y += tests/qtest/libqos/rtas.o
> > -libqos-spapr-obj-y += tests/qtest/libqos/pci-spapr.o
> > -libqos-pc-obj-y = $(libqos-core-obj-y) tests/qtest/libqos/pci-pc.o
> > -libqos-pc-obj-y += tests/qtest/libqos/malloc-pc.o
> tests/qtest/libqos/libqos-pc.o
> > -libqos-pc-obj-y += tests/qtest/libqos/ahci.o
> > -libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y)
> tests/qtest/libqos/usb.o
> > -
> > -# qos devices:
> > -libqos-obj-y =  $(libqgraph-obj-y)
> > -libqos-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
> > -libqos-obj-y += tests/qtest/libqos/qos_external.o
> > -libqos-obj-y += tests/qtest/libqos/e1000e.o
> > -libqos-obj-y += tests/qtest/libqos/i2c.o
> > -libqos-obj-y += tests/qtest/libqos/i2c-imx.o
> > -libqos-obj-y += tests/qtest/libqos/i2c-omap.o
> > -libqos-obj-y += tests/qtest/libqos/sdhci.o
> > -libqos-obj-y += tests/qtest/libqos/tpci200.o
> > -libqos-obj-y += tests/qtest/libqos/virtio.o
> > -libqos-obj-$(CONFIG_VIRTFS) += tests/qtest/libqos/virtio-9p.o
> > -libqos-obj-y += tests/qtest/libqos/virtio-balloon.o
> > -libqos-obj-y += tests/qtest/libqos/virtio-blk.o
> > -libqos-obj-y += tests/qtest/libqos/virtio-mmio.o
> > -libqos-obj-y += tests/qtest/libqos/virtio-net.o
> > -libqos-obj-y += tests/qtest/libqos/virtio-pci.o
> > -libqos-obj-y += tests/qtest/libqos/virtio-pci-modern.o
> > -libqos-obj-y += tests/qtest/libqos/virtio-rng.o
> > -libqos-obj-y += tests/qtest/libqos/virtio-scsi.o
> > -libqos-obj-y += tests/qtest/libqos/virtio-serial.o
> > -
> > -# qos machines:
> > -libqos-obj-y += tests/qtest/libqos/aarch64-xlnx-zcu102-machine.o
> > -libqos-obj-y += tests/qtest/libqos/arm-imx25-pdk-machine.o
> > -libqos-obj-y += tests/qtest/libqos/arm-n800-machine.o
> > -libqos-obj-y += tests/qtest/libqos/arm-raspi2-machine.o
> > -libqos-obj-y += tests/qtest/libqos/arm-sabrelite-machine.o
> > -libqos-obj-y += tests/qtest/libqos/arm-smdkc210-machine.o
> > -libqos-obj-y += tests/qtest/libqos/arm-virt-machine.o
> > -libqos-obj-y += tests/qtest/libqos/arm-xilinx-zynq-a9-machine.o
> > -libqos-obj-y += tests/qtest/libqos/ppc64_pseries-machine.o
> > -libqos-obj-y += tests/qtest/libqos/x86_64_pc-machine.o
> > -
> > -# qos tests:
> > -qos-test-obj-y += tests/qtest/qos-test.o
> > -qos-test-obj-y += tests/qtest/ac97-test.o
> > -qos-test-obj-y += tests/qtest/ds1338-test.o
> > -qos-test-obj-y += tests/qtest/e1000-test.o
> > -qos-test-obj-y += tests/qtest/e1000e-test.o
> > -qos-test-obj-y += tests/qtest/eepro100-test.o
> > -qos-test-obj-y += tests/qtest/es1370-test.o
> > -qos-test-obj-y += tests/qtest/ipoctal232-test.o
> > -qos-test-obj-y += tests/qtest/megasas-test.o
> > -qos-test-obj-y += tests/qtest/ne2000-test.o
> > -qos-test-obj-y += tests/qtest/tulip-test.o
> > -qos-test-obj-y += tests/qtest/nvme-test.o
> > -qos-test-obj-y += tests/qtest/pca9552-test.o
> > -qos-test-obj-y += tests/qtest/pci-test.o
> > -qos-test-obj-y += tests/qtest/pcnet-test.o
> > -qos-test-obj-y += tests/qtest/sdhci-test.o
> > -qos-test-obj-y += tests/qtest/spapr-phb-test.o
> > -qos-test-obj-y += tests/qtest/tmp105-test.o
> > -qos-test-obj-y += tests/qtest/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
> > -qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/qtest/vhost-user-test.o
> $(chardev-obj-y) $(test-io-obj-y)
> > -qos-test-obj-y += tests/qtest/virtio-test.o
> > -qos-test-obj-$(CONFIG_VIRTFS) += tests/qtest/virtio-9p-test.o
> > -qos-test-obj-y += tests/qtest/virtio-blk-test.o
> > -qos-test-obj-y += tests/qtest/virtio-net-test.o
> > -qos-test-obj-y += tests/qtest/virtio-rng-test.o
> > -qos-test-obj-y += tests/qtest/virtio-scsi-test.o
> > -qos-test-obj-y += tests/qtest/virtio-serial-test.o
> > -qos-test-obj-y += tests/qtest/vmxnet3-test.o
> > -
> > -check-unit-y += tests/test-qgraph$(EXESUF)
> > -tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
> > -
> > -check-qtest-generic-y += qos-test
> > -tests/qtest/qos-test$(EXESUF): $(qos-test-obj-y) $(libqos-obj-y)
> > -
> > -# QTest dependencies:
> > -tests/qtest/qmp-test$(EXESUF): tests/qtest/qmp-test.o
> > -tests/qtest/qmp-cmd-test$(EXESUF): tests/qtest/qmp-cmd-test.o
> > -tests/qtest/device-introspect-test$(EXESUF):
> tests/qtest/device-introspect-test.o
> > -tests/qtest/rtc-test$(EXESUF): tests/qtest/rtc-test.o
> > -tests/qtest/m48t59-test$(EXESUF): tests/qtest/m48t59-test.o
> > -tests/qtest/hexloader-test$(EXESUF): tests/qtest/hexloader-test.o
> > -tests/qtest/pflash-cfi02$(EXESUF): tests/qtest/pflash-cfi02-test.o
> > -tests/qtest/endianness-test$(EXESUF): tests/qtest/endianness-test.o
> > -tests/qtest/prom-env-test$(EXESUF): tests/qtest/prom-env-test.o
> $(libqos-obj-y)
> > -tests/qtest/rtas-test$(EXESUF): tests/qtest/rtas-test.o
> $(libqos-spapr-obj-y)
> > -tests/qtest/fdc-test$(EXESUF): tests/qtest/fdc-test.o
> > -tests/qtest/ide-test$(EXESUF): tests/qtest/ide-test.o $(libqos-pc-obj-y)
> > -tests/qtest/ahci-test$(EXESUF): tests/qtest/ahci-test.o
> $(libqos-pc-obj-y) qemu-img$(EXESUF)
> > -tests/qtest/ipmi-kcs-test$(EXESUF): tests/qtest/ipmi-kcs-test.o
> > -tests/qtest/ipmi-bt-test$(EXESUF): tests/qtest/ipmi-bt-test.o
> > -tests/qtest/hd-geo-test$(EXESUF): tests/qtest/hd-geo-test.o
> $(libqos-obj-y)
> > -tests/qtest/boot-order-test$(EXESUF): tests/qtest/boot-order-test.o
> $(libqos-obj-y)
> > -tests/qtest/boot-serial-test$(EXESUF): tests/qtest/boot-serial-test.o
> $(libqos-obj-y)
> > -tests/qtest/bios-tables-test$(EXESUF): tests/qtest/bios-tables-test.o \
> > -        tests/qtest/tpm-emu.o $(test-io-obj-y) \
> > -     tests/qtest/boot-sector.o tests/qtest/acpi-utils.o $(libqos-obj-y)
> > -tests/qtest/pxe-test$(EXESUF): tests/qtest/pxe-test.o
> tests/qtest/boot-sector.o $(libqos-obj-y)
> > -tests/qtest/microbit-test$(EXESUF): tests/qtest/microbit-test.o
> > -tests/qtest/m25p80-test$(EXESUF): tests/qtest/m25p80-test.o
> > -tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o
> $(libqos-pc-obj-y)
> > -tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-obj-y)
> > -tests/qtest/fw_cfg-test$(EXESUF): tests/qtest/fw_cfg-test.o
> $(libqos-pc-obj-y)
> > -tests/qtest/rtl8139-test$(EXESUF): tests/qtest/rtl8139-test.o
> $(libqos-pc-obj-y)
> > -tests/qtest/pnv-xscom-test$(EXESUF): tests/qtest/pnv-xscom-test.o
> > -tests/qtest/wdt_ib700-test$(EXESUF): tests/qtest/wdt_ib700-test.o
> > -tests/qtest/tco-test$(EXESUF): tests/qtest/tco-test.o $(libqos-pc-obj-y)
> > -tests/qtest/virtio-ccw-test$(EXESUF): tests/qtest/virtio-ccw-test.o
> > -tests/qtest/display-vga-test$(EXESUF): tests/qtest/display-vga-test.o
> > -tests/qtest/qom-test$(EXESUF): tests/qtest/qom-test.o
> > -tests/qtest/modules-test$(EXESUF): tests/qtest/modules-test.o
> > -tests/qtest/test-hmp$(EXESUF): tests/qtest/test-hmp.o
> > -tests/qtest/machine-none-test$(EXESUF): tests/qtest/machine-none-test.o
> > -tests/qtest/device-plug-test$(EXESUF): tests/qtest/device-plug-test.o
> > -tests/qtest/drive_del-test$(EXESUF): tests/qtest/drive_del-test.o
> > -tests/qtest/pvpanic-test$(EXESUF): tests/qtest/pvpanic-test.o
> > -tests/qtest/i82801b11-test$(EXESUF): tests/qtest/i82801b11-test.o
> > -tests/qtest/intel-hda-test$(EXESUF): tests/qtest/intel-hda-test.o
> > -tests/qtest/ioh3420-test$(EXESUF): tests/qtest/ioh3420-test.o
> > -tests/qtest/usb-hcd-uhci-test$(EXESUF): tests/qtest/usb-hcd-uhci-test.o
> $(libqos-usb-obj-y)
> > -tests/qtest/usb-hcd-ehci-test$(EXESUF): tests/qtest/usb-hcd-ehci-test.o
> $(libqos-usb-obj-y)
> > -tests/qtest/usb-hcd-xhci-test$(EXESUF): tests/qtest/usb-hcd-xhci-test.o
> $(libqos-usb-obj-y)
> > -tests/qtest/cpu-plug-test$(EXESUF): tests/qtest/cpu-plug-test.o
> > -tests/qtest/migration-test$(EXESUF): tests/qtest/migration-test.o
> tests/qtest/migration-helpers.o
> > -tests/qtest/test-netfilter$(EXESUF): tests/qtest/test-netfilter.o
> $(qtest-obj-y)
> > -tests/qtest/test-filter-mirror$(EXESUF):
> tests/qtest/test-filter-mirror.o $(qtest-obj-y)
> > -tests/qtest/test-filter-redirector$(EXESUF):
> tests/qtest/test-filter-redirector.o $(qtest-obj-y)
> > -tests/qtest/test-x86-cpuid-compat$(EXESUF):
> tests/qtest/test-x86-cpuid-compat.o $(qtest-obj-y)
> > -tests/qtest/ivshmem-test$(EXESUF): tests/qtest/ivshmem-test.o
> contrib/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y)
> $(libqos-spapr-obj-y)
> > -tests/qtest/dbus-vmstate-test$(EXESUF): tests/qtest/dbus-vmstate-test.o
> tests/qtest/migration-helpers.o tests/qtest/dbus-vmstate1.o
> $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
> > -tests/qtest/test-arm-mptimer$(EXESUF): tests/qtest/test-arm-mptimer.o
> > -tests/qtest/numa-test$(EXESUF): tests/qtest/numa-test.o
> > -tests/qtest/vmgenid-test$(EXESUF): tests/qtest/vmgenid-test.o
> tests/qtest/boot-sector.o tests/qtest/acpi-utils.o
> > -tests/qtest/cdrom-test$(EXESUF): tests/qtest/cdrom-test.o
> tests/qtest/boot-sector.o $(libqos-obj-y)
> > -tests/qtest/arm-cpu-features$(EXESUF): tests/qtest/arm-cpu-features.o
> > -tests/qtest/tpm-crb-swtpm-test$(EXESUF):
> tests/qtest/tpm-crb-swtpm-test.o tests/qtest/tpm-emu.o \
> > -     tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
> > -tests/qtest/tpm-crb-test$(EXESUF): tests/qtest/tpm-crb-test.o
> tests/qtest/tpm-emu.o $(test-io-obj-y)
> > -tests/qtest/tpm-tis-swtpm-test$(EXESUF):
> tests/qtest/tpm-tis-swtpm-test.o tests/qtest/tpm-emu.o \
> > -     tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
> > -tests/qtest/tpm-tis-device-swtpm-test$(EXESUF):
> tests/qtest/tpm-tis-device-swtpm-test.o tests/qtest/tpm-emu.o \
> > -     tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
> > -tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o
> tests/qtest/tpm-tis-util.o tests/qtest/tpm-emu.o $(test-io-obj-y)
> > -tests/qtest/tpm-tis-device-test$(EXESUF):
> tests/qtest/tpm-tis-device-test.o tests/qtest/tpm-tis-util.o
> tests/qtest/tpm-emu.o $(test-io-obj-y)
> > -
> > -# QTest rules
> > -
> > -TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
> > -QTEST_TARGETS =
> > -# The qtests are not runnable (yet) under TSan due to a known issue.
> > -# https://github.com/google/sanitizers/issues/1116
> > -ifndef CONFIG_TSAN
> > -ifeq ($(CONFIG_POSIX),y)
> > -QTEST_TARGETS = $(TARGETS)
> > -check-qtest-y=$(foreach TARGET,$(TARGETS),
> $(check-qtest-$(TARGET)-y:%=tests/qtest/%$(EXESUF)))
> > -check-qtest-y += $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF))
> > -endif
> > -endif
> > -
> > -qtest-obj-y = tests/qtest/libqtest.o $(test-util-obj-y)
> > -$(check-qtest-y): $(qtest-obj-y)
> > diff --git a/tests/qtest/ac97-test.c b/tests/qtest/ac97-test.c
> > index b084e31..e09f249 100644
> > --- a/tests/qtest/ac97-test.c
> > +++ b/tests/qtest/ac97-test.c
> > @@ -8,7 +8,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "qemu/module.h"
> >  #include "libqos/qgraph.h"
> >  #include "libqos/pci.h"
> > diff --git a/tests/qtest/acpi-utils.h b/tests/qtest/acpi-utils.h
> > index 0c86780..261784d 100644
> > --- a/tests/qtest/acpi-utils.h
> > +++ b/tests/qtest/acpi-utils.h
> > @@ -13,7 +13,7 @@
> >  #ifndef TEST_ACPI_UTILS_H
> >  #define TEST_ACPI_UTILS_H
> >
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >
> >  /* DSDT and SSDTs format */
> >  typedef struct {
> > diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
> > index c8d42ce..ca4294f 100644
> > --- a/tests/qtest/ahci-test.c
> > +++ b/tests/qtest/ahci-test.c
> > @@ -25,7 +25,7 @@
> >  #include "qemu/osdep.h"
> >  #include <getopt.h>
> >
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "libqos/libqos-pc.h"
> >  #include "libqos/ahci.h"
> >  #include "libqos/pci-pc.h"
> > diff --git a/tests/qtest/arm-cpu-features.c
> b/tests/qtest/arm-cpu-features.c
> > index f7e062c..77b5e30 100644
> > --- a/tests/qtest/arm-cpu-features.c
> > +++ b/tests/qtest/arm-cpu-features.c
> > @@ -10,7 +10,7 @@
> >   */
> >  #include "qemu/osdep.h"
> >  #include "qemu/bitops.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "qapi/qmp/qdict.h"
> >  #include "qapi/qmp/qjson.h"
> >
> > diff --git a/tests/qtest/boot-order-test.c
> b/tests/qtest/boot-order-test.c
> > index 2f1c072..fac580d 100644
> > --- a/tests/qtest/boot-order-test.c
> > +++ b/tests/qtest/boot-order-test.c
> > @@ -12,7 +12,7 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "libqos/fw_cfg.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "qapi/qmp/qdict.h"
> >  #include "standard-headers/linux/qemu_fw_cfg.h"
> >
> > diff --git a/tests/qtest/boot-sector.c b/tests/qtest/boot-sector.c
> > index 9e66c6d..24df5c4 100644
> > --- a/tests/qtest/boot-sector.c
> > +++ b/tests/qtest/boot-sector.c
> > @@ -13,7 +13,7 @@
> >  #include "qemu/osdep.h"
> >  #include "boot-sector.h"
> >  #include "qemu-common.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >
> >  #define LOW(x) ((x) & 0xff)
> >  #define HIGH(x) ((x) >> 8)
> > diff --git a/tests/qtest/boot-sector.h b/tests/qtest/boot-sector.h
> > index 6ee6bb4..b339fde 100644
> > --- a/tests/qtest/boot-sector.h
> > +++ b/tests/qtest/boot-sector.h
> > @@ -14,7 +14,7 @@
> >  #ifndef TEST_BOOT_SECTOR_H
> >  #define TEST_BOOT_SECTOR_H
> >
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >
> >  /* Create boot disk file. fname must be a suitable string for mkstemp()
> */
> >  int boot_sector_init(char *fname);
> > diff --git a/tests/qtest/boot-serial-test.c
> b/tests/qtest/boot-serial-test.c
> > index bfe7624..b6b1c23 100644
> > --- a/tests/qtest/boot-serial-test.c
> > +++ b/tests/qtest/boot-serial-test.c
> > @@ -14,7 +14,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "libqos/libqos-spapr.h"
> >
> >  static const uint8_t bios_avr[] = {
> > diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
> > index 833a050..e9afab6 100644
> > --- a/tests/qtest/cdrom-test.c
> > +++ b/tests/qtest/cdrom-test.c
> > @@ -11,7 +11,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "boot-sector.h"
> >  #include "qapi/qmp/qdict.h"
> >
> > diff --git a/tests/qtest/dbus-vmstate-test.c
> b/tests/qtest/dbus-vmstate-test.c
> > index 2e5e47d..aca9b98 100644
> > --- a/tests/qtest/dbus-vmstate-test.c
> > +++ b/tests/qtest/dbus-vmstate-test.c
> > @@ -1,7 +1,7 @@
> >  #include "qemu/osdep.h"
> >  #include <glib/gstdio.h>
> >  #include <gio/gio.h>
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "qemu-common.h"
> >  #include "dbus-vmstate1.h"
> >  #include "migration-helpers.h"
> > diff --git a/tests/qtest/device-introspect-test.c
> b/tests/qtest/device-introspect-test.c
> > index d68b785..9f22340 100644
> > --- a/tests/qtest/device-introspect-test.c
> > +++ b/tests/qtest/device-introspect-test.c
> > @@ -22,7 +22,7 @@
> >  #include "qapi/qmp/qstring.h"
> >  #include "qapi/qmp/qdict.h"
> >  #include "qapi/qmp/qlist.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >
> >  const char common_args[] = "-nodefaults -machine none";
> >
> > diff --git a/tests/qtest/device-plug-test.c
> b/tests/qtest/device-plug-test.c
> > index 318e422..9214892 100644
> > --- a/tests/qtest/device-plug-test.c
> > +++ b/tests/qtest/device-plug-test.c
> > @@ -11,7 +11,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "qapi/qmp/qdict.h"
> >  #include "qapi/qmp/qstring.h"
> >
> > diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
> > index 5f8839b..2ab11ad 100644
> > --- a/tests/qtest/drive_del-test.c
> > +++ b/tests/qtest/drive_del-test.c
> > @@ -11,7 +11,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "libqos/virtio.h"
> >  #include "qapi/qmp/qdict.h"
> >
> > diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
> > index f6ade9a..c5d46bc 100644
> > --- a/tests/qtest/ds1338-test.c
> > +++ b/tests/qtest/ds1338-test.c
> > @@ -18,7 +18,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "libqos/i2c.h"
> >
> >  #define DS1338_ADDR 0x68
> > diff --git a/tests/qtest/e1000-test.c b/tests/qtest/e1000-test.c
> > index c387984..ea286d1 100644
> > --- a/tests/qtest/e1000-test.c
> > +++ b/tests/qtest/e1000-test.c
> > @@ -8,7 +8,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "qemu/module.h"
> >  #include "libqos/qgraph.h"
> >  #include "libqos/pci.h"
> > diff --git a/tests/qtest/eepro100-test.c b/tests/qtest/eepro100-test.c
> > index 8dbffff..d72ad09 100644
> > --- a/tests/qtest/eepro100-test.c
> > +++ b/tests/qtest/eepro100-test.c
> > @@ -8,7 +8,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "qemu/module.h"
> >  #include "libqos/qgraph.h"
> >  #include "libqos/pci.h"
> > diff --git a/tests/qtest/endianness-test.c
> b/tests/qtest/endianness-test.c
> > index cc088ac..4e79e22 100644
> > --- a/tests/qtest/endianness-test.c
> > +++ b/tests/qtest/endianness-test.c
> > @@ -13,7 +13,7 @@
> >
> >  #include "qemu/osdep.h"
> >
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "qemu/bswap.h"
> >
> >  typedef struct TestCase TestCase;
> > diff --git a/tests/qtest/es1370-test.c b/tests/qtest/es1370-test.c
> > index adccdac..2fd7fd2 100644
> > --- a/tests/qtest/es1370-test.c
> > +++ b/tests/qtest/es1370-test.c
> > @@ -8,7 +8,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "qemu/module.h"
> >  #include "libqos/qgraph.h"
> >  #include "libqos/pci.h"
> > diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> > index 031594a..1ceea84 100644
> > --- a/tests/qtest/fuzz/fuzz.c
> > +++ b/tests/qtest/fuzz/fuzz.c
> > @@ -20,7 +20,7 @@
> >  #include "sysemu/sysemu.h"
> >  #include "qemu/main-loop.h"
> >  #include "qemu/rcu.h"
> > -#include "tests/qtest/libqtest.h"
> > +#include "tests/qtest/libqos/libqtest.h"
> >  #include "tests/qtest/libqos/qgraph.h"
> >  #include "fuzz.h"
> >
> > diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
> > index 9ca3d10..8eb765e 100644
> > --- a/tests/qtest/fuzz/fuzz.h
> > +++ b/tests/qtest/fuzz/fuzz.h
> > @@ -18,7 +18,7 @@
> >  #include "qemu/units.h"
> >  #include "qapi/error.h"
> >
> > -#include "tests/qtest/libqtest.h"
> > +#include "tests/qtest/libqos/libqtest.h"
> >
> >  /**
> >   * A libfuzzer fuzzing target
> > diff --git a/tests/qtest/fuzz/i440fx_fuzz.c
> b/tests/qtest/fuzz/i440fx_fuzz.c
> > index bf966d4..f45373f 100644
> > --- a/tests/qtest/fuzz/i440fx_fuzz.c
> > +++ b/tests/qtest/fuzz/i440fx_fuzz.c
> > @@ -13,7 +13,7 @@
> >  #include "qemu/osdep.h"
> >
> >  #include "qemu/main-loop.h"
> > -#include "tests/qtest/libqtest.h"
> > +#include "tests/qtest/libqos/libqtest.h"
> >  #include "tests/qtest/libqos/pci.h"
> >  #include "tests/qtest/libqos/pci-pc.h"
> >  #include "fuzz.h"
> > diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
> > index d52f3eb..b943577 100644
> > --- a/tests/qtest/fuzz/qos_fuzz.c
> > +++ b/tests/qtest/fuzz/qos_fuzz.c
> > @@ -25,7 +25,7 @@
> >  #include "sysemu/sysemu.h"
> >  #include "qemu/main-loop.h"
> >
> > -#include "tests/qtest/libqtest.h"
> > +#include "tests/qtest/libqos/libqtest.h"
> >  #include "tests/qtest/libqos/malloc.h"
> >  #include "tests/qtest/libqos/qgraph.h"
> >  #include "tests/qtest/libqos/qgraph_internal.h"
> > diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c
> b/tests/qtest/fuzz/virtio_net_fuzz.c
> > index a33bd73..277a9e2 100644
> > --- a/tests/qtest/fuzz/virtio_net_fuzz.c
> > +++ b/tests/qtest/fuzz/virtio_net_fuzz.c
> > @@ -13,7 +13,7 @@
> >  #include "qemu/osdep.h"
> >
> >  #include "standard-headers/linux/virtio_config.h"
> > -#include "tests/qtest/libqtest.h"
> > +#include "tests/qtest/libqos/libqtest.h"
> >  #include "tests/qtest/libqos/virtio-net.h"
> >  #include "fuzz.h"
> >  #include "fork_fuzz.h"
> > diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c
> b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> > index 3a9ea13..977ac42 100644
> > --- a/tests/qtest/fuzz/virtio_scsi_fuzz.c
> > +++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
> > @@ -12,7 +12,7 @@
> >
> >  #include "qemu/osdep.h"
> >
> > -#include "tests/qtest/libqtest.h"
> > +#include "tests/qtest/libqos/libqtest.h"
> >  #include "libqos/virtio-scsi.h"
> >  #include "libqos/virtio.h"
> >  #include "libqos/virtio-pci.h"
> > diff --git a/tests/qtest/fw_cfg-test.c b/tests/qtest/fw_cfg-test.c
> > index 5dc807b..95b3907 100644
> > --- a/tests/qtest/fw_cfg-test.c
> > +++ b/tests/qtest/fw_cfg-test.c
> > @@ -12,7 +12,7 @@
> >
> >  #include "qemu/osdep.h"
> >
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "standard-headers/linux/qemu_fw_cfg.h"
> >  #include "libqos/fw_cfg.h"
> >  #include "qemu/bswap.h"
> > diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
> > index 48e8e02..f7b7cfb 100644
> > --- a/tests/qtest/hd-geo-test.c
> > +++ b/tests/qtest/hd-geo-test.c
> > @@ -19,7 +19,7 @@
> >  #include "qemu-common.h"
> >  #include "qemu/bswap.h"
> >  #include "qapi/qmp/qlist.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "libqos/fw_cfg.h"
> >  #include "libqos/libqos.h"
> >  #include "standard-headers/linux/qemu_fw_cfg.h"
> > diff --git a/tests/qtest/hexloader-test.c b/tests/qtest/hexloader-test.c
> > index 8b7aa2d..5615020 100644
> > --- a/tests/qtest/hexloader-test.c
> > +++ b/tests/qtest/hexloader-test.c
> > @@ -10,7 +10,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >
> >  /* Load 'test.hex' and verify that the in-memory contents are as
> expected.
> >   * 'test.hex' is a memory test pattern stored in Hexadecimal Object
> > diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
> > index 5cfd97f..3f8081e 100644
> > --- a/tests/qtest/ide-test.c
> > +++ b/tests/qtest/ide-test.c
> > @@ -25,7 +25,7 @@
> >  #include "qemu/osdep.h"
> >
> >
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "libqos/libqos.h"
> >  #include "libqos/pci-pc.h"
> >  #include "libqos/malloc-pc.h"
> > diff --git a/tests/qtest/ipoctal232-test.c
> b/tests/qtest/ipoctal232-test.c
> > index 53a8c9b..65ce10b 100644
> > --- a/tests/qtest/ipoctal232-test.c
> > +++ b/tests/qtest/ipoctal232-test.c
> > @@ -8,7 +8,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "qemu/module.h"
> >  #include "libqos/qgraph.h"
> >
> > diff --git a/tests/qtest/ivshmem-test.c b/tests/qtest/ivshmem-test.c
> > index ecda256..d5c8b9f 100644
> > --- a/tests/qtest/ivshmem-test.c
> > +++ b/tests/qtest/ivshmem-test.c
> > @@ -13,7 +13,7 @@
> >  #include "contrib/ivshmem-server/ivshmem-server.h"
> >  #include "libqos/libqos-pc.h"
> >  #include "libqos/libqos-spapr.h"
> > -#include "libqtest.h"
> > +#include "libqos/libqtest.h"
> >  #include "qemu-common.h"
> >
> >  #define TMPSHMSIZE (1 << 20)
> > diff --git a/tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c
> b/tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c
> > index 8f827ae..79631cc 100644
> > --- a/tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c
> > +++ b/tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c
> > @@ -19,8 +19,8 @@
> >  #include "qemu/osdep.h"
> >  #include "libqtest.h"
> >  #include "qemu/module.h"
> > -#include "libqos/malloc.h"
> > -#include "libqos/qgraph.h"
> > +#include "malloc.h"
> > +#include "qgraph.h"
> >  #include "sdhci.h"
> >
> >  typedef struct QXlnxZCU102Machine QXlnxZCU102Machine;
> > diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
> > index cc1b08e..2946abc 100644
> > --- a/tests/qtest/libqos/ahci.c
> > +++ b/tests/qtest/libqos/ahci.c
> > @@ -25,8 +25,8 @@
> >  #include "qemu/osdep.h"
> >
> >  #include "libqtest.h"
> > -#include "libqos/ahci.h"
> > -#include "libqos/pci-pc.h"
> > +#include "ahci.h"
> > +#include "pci-pc.h"
> >
> >  #include "qemu-common.h"
> >  #include "qemu/host-utils.h"
> > @@ -579,7 +579,7 @@ void ahci_write_fis(AHCIQState *ahci, AHCICommand
> *cmd)
> >      /* NCQ commands use exclusively 8 bit fields and needs no
> adjustment.
> >       * Only the count field needs to be adjusted for non-NCQ commands.
> >       * The auxiliary FIS fields are defined per-command and are not
> currently
> > -     * implemented in libqos/ahci.o, but may or may not need to be
> flipped. */
> > +     * implemented in ahci.o, but may or may not need to be flipped. */
> >      if (!cmd->props->ncq) {
> >          tmp.count = cpu_to_le16(tmp.count);
> >      }
> > diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
> > index 44ab110..88835b6 100644
> > --- a/tests/qtest/libqos/ahci.h
> > +++ b/tests/qtest/libqos/ahci.h
> > @@ -25,9 +25,9 @@
> >   * THE SOFTWARE.
> >   */
> >
> > -#include "libqos/libqos.h"
> > -#include "libqos/pci.h"
> > -#include "libqos/malloc-pc.h"
> > +#include "libqos.h"
> > +#include "pci.h"
> > +#include "malloc-pc.h"
> >
> >  /*** Supplementary PCI Config Space IDs & Masks ***/
> >  #define PCI_DEVICE_ID_INTEL_Q35_AHCI   (0x2922)
> > diff --git a/tests/qtest/libqos/arm-imx25-pdk-machine.c
> b/tests/qtest/libqos/arm-imx25-pdk-machine.c
> > index 0da3f19..6692adf 100644
> > --- a/tests/qtest/libqos/arm-imx25-pdk-machine.c
> > +++ b/tests/qtest/libqos/arm-imx25-pdk-machine.c
> > @@ -20,9 +20,9 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "libqtest.h"
> > -#include "libqos/malloc.h"
> > -#include "libqos/qgraph.h"
> > -#include "libqos/i2c.h"
> > +#include "malloc.h"
> > +#include "qgraph.h"
> > +#include "i2c.h"
> >
> >  #define ARM_PAGE_SIZE            4096
> >  #define IMX25_PDK_RAM_START      0x80000000
> > diff --git a/tests/qtest/libqos/arm-n800-machine.c
> b/tests/qtest/libqos/arm-n800-machine.c
> > index 35f8207..ff2049c 100644
> > --- a/tests/qtest/libqos/arm-n800-machine.c
> > +++ b/tests/qtest/libqos/arm-n800-machine.c
> > @@ -20,9 +20,9 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "libqtest.h"
> > -#include "libqos/malloc.h"
> > -#include "libqos/qgraph.h"
> > -#include "libqos/i2c.h"
> > +#include "malloc.h"
> > +#include "qgraph.h"
> > +#include "i2c.h"
> >
> >  #define ARM_PAGE_SIZE            4096
> >  #define N800_RAM_START      0x80000000
> > diff --git a/tests/qtest/libqos/arm-raspi2-machine.c
> b/tests/qtest/libqos/arm-raspi2-machine.c
> > index 8480d80..35bb470 100644
> > --- a/tests/qtest/libqos/arm-raspi2-machine.c
> > +++ b/tests/qtest/libqos/arm-raspi2-machine.c
> > @@ -19,8 +19,8 @@
> >  #include "qemu/osdep.h"
> >  #include "libqtest.h"
> >  #include "qemu/module.h"
> > -#include "libqos/malloc.h"
> > -#include "libqos/qgraph.h"
> > +#include "malloc.h"
> > +#include "qgraph.h"
> >  #include "sdhci.h"
> >
> >  #define ARM_PAGE_SIZE             4096
> > diff --git a/tests/qtest/libqos/arm-sabrelite-machine.c
> b/tests/qtest/libqos/arm-sabrelite-machine.c
> > index f6e403b..72425f0 100644
> > --- a/tests/qtest/libqos/arm-sabrelite-machine.c
> > +++ b/tests/qtest/libqos/arm-sabrelite-machine.c
> > @@ -19,8 +19,8 @@
> >  #include "qemu/osdep.h"
> >  #include "libqtest.h"
> >  #include "qemu/module.h"
> > -#include "libqos/malloc.h"
> > -#include "libqos/qgraph.h"
> > +#include "malloc.h"
> > +#include "qgraph.h"
> >  #include "sdhci.h"
> >
> >  #define ARM_PAGE_SIZE            4096
> > diff --git a/tests/qtest/libqos/arm-smdkc210-machine.c
> b/tests/qtest/libqos/arm-smdkc210-machine.c
> > index eebac7f..321b882 100644
> > --- a/tests/qtest/libqos/arm-smdkc210-machine.c
> > +++ b/tests/qtest/libqos/arm-smdkc210-machine.c
> > @@ -19,8 +19,8 @@
> >  #include "qemu/osdep.h"
> >  #include "libqtest.h"
> >  #include "qemu/module.h"
> > -#include "libqos/malloc.h"
> > -#include "libqos/qgraph.h"
> > +#include "malloc.h"
> > +#include "qgraph.h"
> >  #include "sdhci.h"
> >
> >  #define ARM_PAGE_SIZE             4096
> > diff --git a/tests/qtest/libqos/arm-virt-machine.c
> b/tests/qtest/libqos/arm-virt-machine.c
> > index 9316598..e0f5932 100644
> > --- a/tests/qtest/libqos/arm-virt-machine.c
> > +++ b/tests/qtest/libqos/arm-virt-machine.c
> > @@ -19,9 +19,9 @@
> >  #include "qemu/osdep.h"
> >  #include "libqtest.h"
> >  #include "qemu/module.h"
> > -#include "libqos/malloc.h"
> > -#include "libqos/qgraph.h"
> > -#include "libqos/virtio-mmio.h"
> > +#include "malloc.h"
> > +#include "qgraph.h"
> > +#include "virtio-mmio.h"
> >
> >  #define ARM_PAGE_SIZE               4096
> >  #define VIRTIO_MMIO_BASE_ADDR       0x0A003E00
> > diff --git a/tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c
> b/tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c
> > index 473acce..56e53c7 100644
> > --- a/tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c
> > +++ b/tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c
> > @@ -19,8 +19,8 @@
> >  #include "qemu/osdep.h"
> >  #include "libqtest.h"
> >  #include "qemu/module.h"
> > -#include "libqos/malloc.h"
> > -#include "libqos/qgraph.h"
> > +#include "malloc.h"
> > +#include "qgraph.h"
> >  #include "sdhci.h"
> >
> >  typedef struct QXilinxZynqA9Machine QXilinxZynqA9Machine;
> > diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c
> > index e2927ed..a451f61 100644
> > --- a/tests/qtest/libqos/e1000e.c
> > +++ b/tests/qtest/libqos/e1000e.c
> > @@ -18,13 +18,13 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "libqtest.h"
> > -#include "libqos/pci-pc.h"
> > +#include "pci-pc.h"
> >  #include "qemu/sockets.h"
> >  #include "qemu/iov.h"
> >  #include "qemu/module.h"
> >  #include "qemu/bitops.h"
> > -#include "libqos/malloc.h"
> > -#include "libqos/qgraph.h"
> > +#include "malloc.h"
> > +#include "qgraph.h"
> >  #include "e1000e.h"
> >
> >  #define E1000E_IMS      (0x00d0)
> > diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
> > index 35183b2..a22f5fd 100644
> > --- a/tests/qtest/libqos/e1000e.h
> > +++ b/tests/qtest/libqos/e1000e.h
> > @@ -19,7 +19,7 @@
> >  #ifndef QGRAPH_E1000E_H
> >  #define QGRAPH_E1000E_H
> >
> > -#include "libqos/qgraph.h"
> > +#include "qgraph.h"
> >  #include "pci.h"
> >
> >  #define E1000E_RX0_MSG_ID           (0)
> > diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
> > index 1f46258..6b8e1ba 100644
> > --- a/tests/qtest/libqos/fw_cfg.c
> > +++ b/tests/qtest/libqos/fw_cfg.c
> > @@ -13,7 +13,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqos/fw_cfg.h"
> > +#include "fw_cfg.h"
> >  #include "libqtest.h"
> >  #include "qemu/bswap.h"
> >  #include "hw/nvram/fw_cfg.h"
> > diff --git a/tests/qtest/libqos/i2c-imx.c b/tests/qtest/libqos/i2c-imx.c
> > index f33ece5..8f9a7e3 100644
> > --- a/tests/qtest/libqos/i2c-imx.c
> > +++ b/tests/qtest/libqos/i2c-imx.c
> > @@ -18,7 +18,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqos/i2c.h"
> > +#include "i2c.h"
> >
> >
> >  #include "libqtest.h"
> > diff --git a/tests/qtest/libqos/i2c-omap.c
> b/tests/qtest/libqos/i2c-omap.c
> > index 9ae8214..eb4e453 100644
> > --- a/tests/qtest/libqos/i2c-omap.c
> > +++ b/tests/qtest/libqos/i2c-omap.c
> > @@ -7,7 +7,7 @@
> >   * See the COPYING file in the top-level directory.
> >   */
> >  #include "qemu/osdep.h"
> > -#include "libqos/i2c.h"
> > +#include "i2c.h"
> >
> >
> >  #include "qemu/bswap.h"
> > diff --git a/tests/qtest/libqos/i2c.c b/tests/qtest/libqos/i2c.c
> > index 38f800d..ade1bdb 100644
> > --- a/tests/qtest/libqos/i2c.c
> > +++ b/tests/qtest/libqos/i2c.c
> > @@ -7,7 +7,7 @@
> >   * See the COPYING file in the top-level directory.
> >   */
> >  #include "qemu/osdep.h"
> > -#include "libqos/i2c.h"
> > +#include "i2c.h"
> >  #include "libqtest.h"
> >
> >  void qi2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
> > diff --git a/tests/qtest/libqos/i2c.h b/tests/qtest/libqos/i2c.h
> > index c65f087..1341bac 100644
> > --- a/tests/qtest/libqos/i2c.h
> > +++ b/tests/qtest/libqos/i2c.h
> > @@ -10,7 +10,7 @@
> >  #define LIBQOS_I2C_H
> >
> >  #include "libqtest.h"
> > -#include "libqos/qgraph.h"
> > +#include "qgraph.h"
> >
> >  typedef struct I2CAdapter I2CAdapter;
> >  struct I2CAdapter {
> > diff --git a/tests/qtest/libqos/libqos-pc.c
> b/tests/qtest/libqos/libqos-pc.c
> > index d04abc5..db420a5 100644
> > --- a/tests/qtest/libqos/libqos-pc.c
> > +++ b/tests/qtest/libqos/libqos-pc.c
> > @@ -1,7 +1,7 @@
> >  #include "qemu/osdep.h"
> > -#include "libqos/libqos-pc.h"
> > -#include "libqos/malloc-pc.h"
> > -#include "libqos/pci-pc.h"
> > +#include "libqos-pc.h"
> > +#include "malloc-pc.h"
> > +#include "pci-pc.h"
> >
> >  static QOSOps qos_ops = {
> >      .alloc_init = pc_alloc_init,
> > diff --git a/tests/qtest/libqos/libqos-pc.h
> b/tests/qtest/libqos/libqos-pc.h
> > index a0e4c45..1a9923e 100644
> > --- a/tests/qtest/libqos/libqos-pc.h
> > +++ b/tests/qtest/libqos/libqos-pc.h
> > @@ -1,7 +1,7 @@
> >  #ifndef LIBQOS_PC_H
> >  #define LIBQOS_PC_H
> >
> > -#include "libqos/libqos.h"
> > +#include "libqos.h"
> >
> >  QOSState *qtest_pc_vboot(const char *cmdline_fmt, va_list ap);
> >  QOSState *qtest_pc_boot(const char *cmdline_fmt, ...);
> > diff --git a/tests/qtest/libqos/libqos-spapr.c
> b/tests/qtest/libqos/libqos-spapr.c
> > index 8766d54..db0e87b 100644
> > --- a/tests/qtest/libqos/libqos-spapr.c
> > +++ b/tests/qtest/libqos/libqos-spapr.c
> > @@ -1,7 +1,7 @@
> >  #include "qemu/osdep.h"
> > -#include "libqos/libqos-spapr.h"
> > -#include "libqos/malloc-spapr.h"
> > -#include "libqos/pci-spapr.h"
> > +#include "libqos-spapr.h"
> > +#include "malloc-spapr.h"
> > +#include "pci-spapr.h"
> >
> >  static QOSOps qos_ops = {
> >      .alloc_init = spapr_alloc_init,
> > diff --git a/tests/qtest/libqos/libqos-spapr.h
> b/tests/qtest/libqos/libqos-spapr.h
> > index 49bd72d..c613389 100644
> > --- a/tests/qtest/libqos/libqos-spapr.h
> > +++ b/tests/qtest/libqos/libqos-spapr.h
> > @@ -1,7 +1,7 @@
> >  #ifndef LIBQOS_SPAPR_H
> >  #define LIBQOS_SPAPR_H
> >
> > -#include "libqos/libqos.h"
> > +#include "libqos.h"
> >
> >  QOSState *qtest_spapr_vboot(const char *cmdline_fmt, va_list ap);
> >  QOSState *qtest_spapr_boot(const char *cmdline_fmt, ...);
> > diff --git a/tests/qtest/libqos/libqos.c b/tests/qtest/libqos/libqos.c
> > index f229eb2..2251e86 100644
> > --- a/tests/qtest/libqos/libqos.c
> > +++ b/tests/qtest/libqos/libqos.c
> > @@ -2,8 +2,8 @@
> >  #include <sys/wait.h>
> >
> >  #include "libqtest.h"
> > -#include "libqos/libqos.h"
> > -#include "libqos/pci.h"
> > +#include "libqos.h"
> > +#include "pci.h"
> >  #include "qapi/qmp/qdict.h"
> >
> >  /*** Test Setup & Teardown ***/
> > diff --git a/tests/qtest/libqos/libqos.h b/tests/qtest/libqos/libqos.h
> > index 8e971c2..e0b2bfe 100644
> > --- a/tests/qtest/libqos/libqos.h
> > +++ b/tests/qtest/libqos/libqos.h
> > @@ -2,8 +2,8 @@
> >  #define LIBQOS_H
> >
> >  #include "libqtest.h"
> > -#include "libqos/pci.h"
> > -#include "libqos/malloc.h"
> > +#include "pci.h"
> > +#include "malloc.h"
> >
> >  typedef struct QOSState QOSState;
> >
> > diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqos/libqtest.h
> > similarity index 100%
> > rename from tests/qtest/libqtest.h
> > rename to tests/qtest/libqos/libqtest.h
> > diff --git a/tests/qtest/libqos/malloc-pc.c
> b/tests/qtest/libqos/malloc-pc.c
> > index 6f92ce4..16ff960 100644
> > --- a/tests/qtest/libqos/malloc-pc.c
> > +++ b/tests/qtest/libqos/malloc-pc.c
> > @@ -11,8 +11,8 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqos/malloc-pc.h"
> > -#include "libqos/fw_cfg.h"
> > +#include "malloc-pc.h"
> > +#include "fw_cfg.h"
> >
> >  #include "standard-headers/linux/qemu_fw_cfg.h"
> >
> > diff --git a/tests/qtest/libqos/malloc-pc.h
> b/tests/qtest/libqos/malloc-pc.h
> > index 21e75ae..d8d7985 100644
> > --- a/tests/qtest/libqos/malloc-pc.h
> > +++ b/tests/qtest/libqos/malloc-pc.h
> > @@ -13,7 +13,7 @@
> >  #ifndef LIBQOS_MALLOC_PC_H
> >  #define LIBQOS_MALLOC_PC_H
> >
> > -#include "libqos/malloc.h"
> > +#include "malloc.h"
> >
> >  void pc_alloc_init(QGuestAllocator *s, QTestState *qts, QAllocOpts
> flags);
> >
> > diff --git a/tests/qtest/libqos/malloc-spapr.c
> b/tests/qtest/libqos/malloc-spapr.c
> > index 2a6b7e3..84862e4 100644
> > --- a/tests/qtest/libqos/malloc-spapr.c
> > +++ b/tests/qtest/libqos/malloc-spapr.c
> > @@ -6,7 +6,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqos/malloc-spapr.h"
> > +#include "malloc-spapr.h"
> >
> >  #include "qemu-common.h"
> >
> > diff --git a/tests/qtest/libqos/malloc-spapr.h
> b/tests/qtest/libqos/malloc-spapr.h
> > index e5fe9bf..f99572f 100644
> > --- a/tests/qtest/libqos/malloc-spapr.h
> > +++ b/tests/qtest/libqos/malloc-spapr.h
> > @@ -8,7 +8,7 @@
> >  #ifndef LIBQOS_MALLOC_SPAPR_H
> >  #define LIBQOS_MALLOC_SPAPR_H
> >
> > -#include "libqos/malloc.h"
> > +#include "malloc.h"
> >
> >  void spapr_alloc_init(QGuestAllocator *s, QTestState *qts, QAllocOpts
> flags);
> >
> > diff --git a/tests/qtest/libqos/malloc.c b/tests/qtest/libqos/malloc.c
> > index 615422a..f708b01 100644
> > --- a/tests/qtest/libqos/malloc.c
> > +++ b/tests/qtest/libqos/malloc.c
> > @@ -11,7 +11,7 @@
> >   */
> >
> >  #include "qemu/osdep.h"
> > -#include "libqos/malloc.h"
> > +#include "malloc.h"
> >  #include "qemu-common.h"
> >  #include "qemu/host-utils.h"
> >
> > diff --git a/tests/qtest/libqos/meson.build
> b/tests/qtest/libqos/meson.build
> > new file mode 100644
> > index 0000000..e39e779
> > --- /dev/null
> > +++ b/tests/qtest/libqos/meson.build
> > @@ -0,0 +1,57 @@
> > +libqos = static_library('libqos',
> > +  files('../libqtest.c',
> > +        'qgraph.c',
> > +        'qos_external.c',
> > +

--00000000000052bed505ac4db24d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks Alexander. Fuzzing wasn&#39;t tested at all, so th=
anks for doing some of the work for me.<div dir=3D"auto"><br></div><div dir=
=3D"auto">Most things you noticed are bugs or stupidities on my part that I=
 haven&#39;t debugged yet. Release early, release often and all that. The n=
ext version should have all these wrinkles ironed out!<div dir=3D"auto"><br=
></div><div dir=3D"auto">Paolo</div></div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 7 ago 2020, 19:23 Alexande=
r Bulekov &lt;<a href=3D"mailto:alxndr@bu.edu">alxndr@bu.edu</a>&gt; ha scr=
itto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">Thank you, Paolo. I haven&#39=
;t gone through all the other messages yet, so<br>
maybe I missed some insights that would help with this.<br>
<br>
Some notes as I try to build qemu-fuzz-i386.<br>
* Needed to do git submodule update --init. IIRC this used to happen<br>
=C2=A0 automatically for stuff like slirp. I will need to update the oss-fu=
zz<br>
=C2=A0 build scripts (./scripts/oss-fuzz/build.sh) to init submodules.<br>
<br>
* My locally installed Meson was too old. Needed to add --meson=3Dgit . Is<=
br>
=C2=A0 there a reason this is not the default?<br>
<br>
* The make i386-softmmu/{all,fuzz} flavored targets are gone. Good. Now<br>
=C2=A0 we have qemu-system-i386 and qemu-fuzz-i386<br>
<br>
* Trying make qemu-fuzz-i386:<br>
../tests/qtest/fuzz/virtio_scsi_fuzz.c:16:10: fatal error: &#39;libqos/virt=
io-scsi.h&#39; file not found<br>
#include &quot;libqos/virtio-scsi.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~<br>
1 error generated.<br>
make: *** [Makefile.ninja:2761: qemu-fuzz-i386.p/tests_qtest_fuzz_virtio_sc=
si_fuzz.c.o] Error 1<br>
<br>
No big deal, thats probably not the right way to include that stuff<br>
anyways:<br>
<br>
------------------------<br>
<br>
diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_=
scsi_fuzz.c<br>
index 977ac424ed..6ff6fabe4a 100644<br>
--- a/tests/qtest/fuzz/virtio_scsi_fuzz.c<br>
+++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c<br>
@@ -13,9 +13,9 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
<br>
=C2=A0#include &quot;tests/qtest/libqos/libqtest.h&quot;<br>
-#include &quot;libqos/virtio-scsi.h&quot;<br>
-#include &quot;libqos/virtio.h&quot;<br>
-#include &quot;libqos/virtio-pci.h&quot;<br>
+#include &quot;tests/qtest/libqos/virtio-scsi.h&quot;<br>
+#include &quot;tests/qtest/libqos/virtio.h&quot;<br>
+#include &quot;tests/qtest/libqos/virtio-pci.h&quot;<br>
=C2=A0#include &quot;standard-headers/linux/virtio_ids.h&quot;<br>
=C2=A0#include &quot;standard-headers/linux/virtio_pci.h&quot;<br>
=C2=A0#include &quot;standard-headers/linux/virtio_scsi.h&quot;<br>
<br>
------------------------<br>
<br>
* Ok. Lets try again:<br>
In file included from ../ui/vnc.h:103:<br>
../ui/vnc-auth-sasl.h:28:10: fatal error: &#39;sasl/sasl.h&#39; file not fo=
und<br>
#include &lt;sasl/sasl.h&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~<br>
<br>
Didn&#39;t need that before - oh well. apt install libsasl-dev<br>
<br>
../ui/input-keymap.c:7:10: fatal error: &#39;ui/input-keymap-atset1-to-qcod=
e.c&#39; file not found<br>
#include &quot;ui/input-keymap-atset1-to-qcode.c&quot;<br>
<br>
Can&#39;t find that anywhere. Lets try to clear out the build dir and build=
<br>
system without --enable-fuzzing:<br>
CC=3Dclang-9 CXX=3Dclang++-9 ../configure --enable-sanitizers --meson=3Dgit=
<br>
make qemu-system-i386<br>
...<br>
../qemu-options-wrapper.h:32:10: fatal error: &#39;qemu-options.def&#39; fi=
le not found<br>
#include &quot;qemu-options.def&quot;<br>
<br>
Ok lets try:<br>
make qemu-options.def<br>
<br>
We get further now:<br>
<br>
../ui/input-keymap.c:7:10: fatal error: &#39;ui/input-keymap-atset1-to-qcod=
e.c&#39; file not found<br>
#include &quot;ui/input-keymap-atset1-to-qcode.c&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
lets try: make &quot;ui/input-keymap-atset1-to-qcode.c&quot;<br>
.. and=C2=A0 =C2=A0 make &quot;ui/input-keymap-linux-to-qcode.c&quot;<br>
.. and=C2=A0 =C2=A0 make &quot;ui/input-keymap-qcode-to-atset1.c&quot;<br>
.. and=C2=A0 =C2=A0 make &quot;ui/input-keymap-qcode-to-atset2.c&quot;<br>
.. and=C2=A0 =C2=A0 make &quot;ui/input-keymap-qcode-to-atset3.c&quot;<br>
.. and=C2=A0 =C2=A0 make &quot;ui/input-keymap-qcode-to-linux.c&quot;<br>
.. and=C2=A0 =C2=A0 make &quot;ui/input-keymap-qcode-to-qnum.c&quot;<br>
.. and=C2=A0 =C2=A0 make &quot;ui/input-keymap-qcode-to-sun.c&quot;<br>
.. and=C2=A0 =C2=A0 make &quot;ui/input-keymap-qnum-to-qcode.c&quot;<br>
<br>
Since it seems the problems aren&#39;t specific to the fuzz target, Lets<br=
>
re-try with --enable-fuzzing<br>
<br>
Ok, we&#39;re very close now:<br>
clang: error: unknown argument: &#39;-wrap&#39;<br>
.... 19 times<br>
clang: error: no such file or directory: &#39;qtest_inb&#39;<br>
....<br>
clang: error: no such file or directory: &#39;qtest_memset&#39;<br>
<br>
Ok what is it trying to do? Lets do make -n qemu-fuzz-i386:<br>
<br>
clang++-9=C2=A0 -o qemu-fuzz-i386 qemu-fuzz-i386.p/tests_qtest_fuzz_i440fx_=
fuzz.c.o<br>
-fsanitize=3Dfuzzer -Ttests/qtest/fuzz/fork_fuzz.ld -wrap qtest_inb -wrap<b=
r>
qtest_inw -wrap qtest_inl -wrap qtest_outb -wrap qtest_outw -wrap<br>
qtest_outl -wrap qtest_readb -wrap qtest_readw -wrap qtest_readl -wrap<br>
qtest_readq -wrap qtest_writeb<br>
<br>
Hmm those need to have -Wl, . Lets just hack it in, for now (we also<br>
don&#39;t build qtest_wrappers.o, so lets fix that):<br>
diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build<br=
>
index 58ab69a952..0345f6c993 100644<br>
--- a/tests/qtest/fuzz/meson.build<br>
+++ b/tests/qtest/fuzz/meson.build<br>
@@ -1,4 +1,4 @@<br>
-specific_fuzz_ss.add(files(&#39;fuzz.c&#39;, &#39;fork_fuzz.c&#39;, &#39;q=
os_fuzz.c&#39;), qos)<br>
+specific_fuzz_ss.add(files(&#39;fuzz.c&#39;, &#39;fork_fuzz.c&#39;, &#39;q=
os_fuzz.c&#39;, &#39;qtest_wrappers.c&#39;), qos)<br>
<br>
=C2=A0# Targets<br>
=C2=A0specific_fuzz_ss.add(when: &#39;CONFIG_I440FX&#39;, if_true: files(&#=
39;i440fx_fuzz.c&#39;))<br>
@@ -10,25 +10,25 @@ specific_fuzz_ss.add(when: &#39;CONFIG_VIRTIO_SCSI&#39;=
, if_true: files(&#39;virtio_scsi_fuz<br>
=C2=A0fork_fuzz =3D declare_dependency(<br>
=C2=A0 =C2=A0link_args: [&#39;-fsanitize=3Dfuzzer&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-Ttests/qtest/f=
uzz/fork_fuzz.ld&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_inb&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_inw&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_inl&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_outb&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_outw&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_outl&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_readb&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_readw&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_readl&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_readq&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_writeb&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_writew&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_writel&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_writeq&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_memread&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_bufread&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_memwrite&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_bufwrite&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-wrap&#39;, &#39;qte=
st_memset&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_inb&=
#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_inw&=
#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_inl&=
#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_outb=
&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_outw=
&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_outl=
&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_read=
b&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_read=
w&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_read=
l&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_read=
q&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_writ=
eb&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_writ=
ew&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_writ=
el&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_writ=
eq&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_memr=
ead&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_bufr=
ead&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_memw=
rite&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_bufw=
rite&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-Wl,-wrap,qtest_mems=
et&#39;]<br>
=C2=A0)<br>
<br>
=C2=A0specific_fuzz_ss.add(fork_fuzz)<br>
<br>
../tests/qtest/fuzz/qtest_wrappers.c:15:10: fatal error: &#39;cpu.h&#39; fi=
le not found<br>
#include &quot;cpu.h&quot;<br>
<br>
How did we get away with that in the first place?<br>
<br>
-----------------------------<br>
diff --git a/tests/qtest/fuzz/qtest_wrappers.c b/tests/qtest/fuzz/qtest_wra=
ppers.c<br>
index 713c830cdb..0580f8df86 100644<br>
--- a/tests/qtest/fuzz/qtest_wrappers.c<br>
+++ b/tests/qtest/fuzz/qtest_wrappers.c<br>
@@ -12,7 +12,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
-#include &quot;cpu.h&quot;<br>
+#include &quot;hw/core/cpu.h&quot;<br>
=C2=A0#include &quot;exec/ioport.h&quot;<br>
<br>
=C2=A0#include &quot;fuzz.h&quot;<br>
-----------------------------<br>
<br>
Ok now:<br>
Linking target qemu-fuzz-i386<br>
clang: warning: argument unused during compilation: &#39;-T tests/qtest/fuz=
z/fork_fuzz.ld&#39; [-Wunused-command-line-argument]<br>
/usr/bin/ld: libcommon.fa.p/softmmu_main.c.o: in function `main&#39;:<br>
/tmp/qemu/build/../softmmu/main.c:47: multiple definition of `main&#39;; /u=
sr/lib/llvm-9/lib/clang/9.0.1/lib/linux/libclang_rt.fuzzer-x86_64.a(fuzzer.=
o):(.text.main+0x0): first defined here<br>
/usr/bin/ld: /tmp/qemu/build/../tests/qtest/fuzz/fork_fuzz.c:22: undefined =
reference to `__FUZZ_COUNTERS_START&#39;<br>
<br>
We are _very_ close, but this is where I have no idea how to get meson<br>
to do what I want. Two things: <br>
1.) The flag for linking should be something like:<br>
-Wl,-T$(SRC_PATH)/tests/qtest/fuzz/fork_fuzz.ld . Right now it is<br>
-T./tests/qtest/fuzz/fork_fuzz.ld<br>
2.) We should not be linking against softmmu_main.c.o<br>
<br>
I ran with make -n and copied the last (linking step) command and<br>
manually made these two changes. With that, I find a binary ./qemu-fuzz-i38=
6<br>
and when I run it, I see all the targets I expect to see.<br>
But when I run one of the actual targets, I get:<br>
./qemu-fuzz-i386 --fuzz-target=3Dvirtio-net-slirp -runs=3D1000<br>
ERROR: no interesting inputs were found. Is the code instrumented for cover=
age? Exit<br>
So it looks like the -fsanitize=3Dfuzzer (or fsanitize=3Dfuzzer-no-link)<br=
>
flag doesn&#39;t get passed anywhere during compilation.. (Confirmed that b=
y<br>
checking make -n)<br>
<br>
This feels very close. If I configure, with<br>
CFLAGS=3D&quot;-fsanitize=3Dfuzzer&quot; , I&#39;m up and running.<br>
<br>
Thanks again. Once I know that I&#39;m doing things right, I can work on<br=
>
converting the oss-fuzz build script, so it works with meson.<br>
-Alex<br>
<br>
On 200806 2114, Paolo Bonzini wrote:<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 49 +---<br>
&gt;=C2=A0 tests/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +<br>
&gt;=C2=A0 tests/qtest/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 332 -----------------------<br>
&gt;=C2=A0 tests/qtest/ac97-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/acpi-utils.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/ahci-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/arm-cpu-features.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/boot-order-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/boot-sector.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/boot-sector.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/boot-serial-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/cdrom-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/dbus-vmstate-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/device-introspect-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/device-plug-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/drive_del-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/ds1338-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/e1000-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/eepro100-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/endianness-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/es1370-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/fuzz/fuzz.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/fuzz/fuzz.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/fuzz/i440fx_fuzz.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/fuzz/qos_fuzz.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/fuzz/virtio_net_fuzz.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/fuzz/virtio_scsi_fuzz.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/fw_cfg-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/hd-geo-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/hexloader-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/ide-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<b=
r>
&gt;=C2=A0 tests/qtest/ipoctal232-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/ivshmem-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c |=C2=A0 =C2=A04=
 +-<br>
&gt;=C2=A0 tests/qtest/libqos/ahci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/ahci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/arm-imx25-pdk-machine.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/arm-n800-machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/arm-raspi2-machine.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/arm-sabrelite-machine.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/arm-smdkc210-machine.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/arm-virt-machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c=C2=A0 |=C2=A0 =
=C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/e1000e.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/e1000e.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/fw_cfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/i2c-imx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/i2c-omap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/i2c.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/i2c.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/libqos-pc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/libqos-pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/libqos-spapr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/libqos-spapr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/libqos.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/libqos.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/{ =3D&gt; libqos}/libqtest.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A00<br>
&gt;=C2=A0 tests/qtest/libqos/malloc-pc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/malloc-pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/malloc-spapr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/malloc-spapr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/malloc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 57 ++++<br>
&gt;=C2=A0 tests/qtest/libqos/pci-pc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/pci-pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/pci-spapr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/pci-spapr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/pci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/ppc64_pseries-machine.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/qgraph.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/qgraph.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/qgraph_internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/qos_external.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A08 +-<br>
&gt;=C2=A0 tests/qtest/libqos/qos_external.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/rtas.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/rtas.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/sdhci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/sdhci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/tpci200.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/usb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/usb.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-9p.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-9p.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-balloon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-balloon.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-blk.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-mmio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-mmio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-net.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-pci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-rng.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-rng.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-scsi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-scsi.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-serial.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio-serial.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/virtio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqos/x86_64_pc-machine.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqtest-single.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/libqtest.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<b=
r>
&gt;=C2=A0 tests/qtest/m48t59-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/machine-none-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/megasas-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 254 +++++++++++++++++<b=
r>
&gt;=C2=A0 tests/qtest/microbit-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/migration-helpers.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/migration-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 tests/qtest/modules-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/ne2000-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/numa-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/nvme-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/pca9552-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/pci-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<b=
r>
&gt;=C2=A0 tests/qtest/pcnet-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/pflash-cfi02-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/pnv-xscom-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/prom-env-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/pvpanic-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/pxe-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<b=
r>
&gt;=C2=A0 tests/qtest/q35-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<b=
r>
&gt;=C2=A0 tests/qtest/qmp-cmd-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/qmp-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<b=
r>
&gt;=C2=A0 tests/qtest/qom-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<b=
r>
&gt;=C2=A0 tests/qtest/rtas-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/sdhci-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/spapr-phb-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/tco-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<b=
r>
&gt;=C2=A0 tests/qtest/test-filter-mirror.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/test-filter-redirector.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/test-hmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<b=
r>
&gt;=C2=A0 tests/qtest/tpm-crb-swtpm-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/tpm-tis-device-swtpm-test.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/tpm-tis-swtpm-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/tpm-util.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<b=
r>
&gt;=C2=A0 tests/qtest/tulip-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/virtio-rng-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/virtio-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/vmgenid-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/vmxnet3-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/qtest/wdt_ib700-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/test-qga.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A02 +-<br>
&gt;=C2=A0 tests/test-qgraph.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05=
 +-<br>
&gt;=C2=A0 148 files changed, 539 insertions(+), 592 deletions(-)<br>
&gt;=C2=A0 delete mode 100644 tests/qtest/Makefile.include<br>
&gt;=C2=A0 rename tests/qtest/{ =3D&gt; libqos}/libqtest.h (100%)<br>
&gt;=C2=A0 create mode 100644 tests/qtest/libqos/meson.build<br>
&gt;=C2=A0 create mode 100644 tests/qtest/meson.build<br>
&gt; <br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index 3daa82e..a81516a 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -511,6 +511,9 @@ subdir(&#39;nbd&#39;)<br>
&gt;=C2=A0 subdir(&#39;scsi&#39;)<br>
&gt;=C2=A0 subdir(&#39;block&#39;)<br>
&gt;=C2=A0 <br>
&gt; +# needed for fuzzing binaries<br>
&gt; +subdir(&#39;tests/qtest/libqos&#39;)<br>
&gt; +<br>
&gt;=C2=A0 mods =3D []<br>
&gt;=C2=A0 block_mods =3D []<br>
&gt;=C2=A0 softmmu_mods =3D []<br>
&gt; diff --git a/tests/Makefile.include b/tests/Makefile.include<br>
&gt; index a0e5d3e..567ad69 100644<br>
&gt; --- a/tests/Makefile.include<br>
&gt; +++ b/tests/Makefile.include<br>
&gt; @@ -109,6 +109,7 @@ check-unit-y +=3D tests/test-qht$(EXESUF)<br>
&gt;=C2=A0 check-unit-y +=3D tests/test-qht-par$(EXESUF)<br>
&gt;=C2=A0 check-unit-y +=3D tests/test-bitops$(EXESUF)<br>
&gt;=C2=A0 check-unit-y +=3D tests/test-bitcnt$(EXESUF)<br>
&gt; +check-unit-y +=3D tests/test-qgraph$(EXESUF)<br>
&gt;=C2=A0 check-unit-y +=3D tests/check-qom-interface$(EXESUF)<br>
&gt;=C2=A0 check-unit-y +=3D tests/check-qom-proplist$(EXESUF)<br>
&gt;=C2=A0 check-unit-y +=3D tests/test-qemu-opts$(EXESUF)<br>
&gt; @@ -306,19 +307,6 @@ tests/test-qapi-gen-timestamp: \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@rm -f tests/test-qapi-doc.texi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@&gt;$@<br>
&gt;=C2=A0 <br>
&gt; -tests/qtest/dbus-vmstate1.h tests/qtest/dbus-vmstate1.c: tests/qtest/=
dbus-vmstate1-gen-timestamp ;<br>
&gt; -tests/qtest/dbus-vmstate1-gen-timestamp: $(SRC_PATH)/tests/qtest/dbus=
-vmstate1.xml<br>
&gt; -=C2=A0 =C2=A0 =C2=A0$(call quiet-command,$(GDBUS_CODEGEN) $&lt; \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--interface-prefix or=
g.qemu --generate-c-code tests/qtest/dbus-vmstate1, \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;GEN&quot;,&quot=
;$(@:%-timestamp=3D%)&quot;)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0@&gt;$@<br>
&gt; -<br>
&gt; -tests/qtest/dbus-vmstate-test.o-cflags :=3D -DSRCDIR=3D&quot;$(SRC_PA=
TH)&quot;<br>
&gt; -tests/qtest/dbus-vmstate1.o-cflags :=3D $(GIO_CFLAGS)<br>
&gt; -tests/qtest/dbus-vmstate1.o-libs :=3D $(GIO_LIBS)<br>
&gt; -<br>
&gt; -tests/qtest/dbus-vmstate-test.o: tests/qtest/dbus-vmstate1.h<br>
&gt; -<br>
&gt;=C2=A0 tests/test-string-output-visitor$(EXESUF): tests/test-string-out=
put-visitor.o $(test-qapi-obj-y)<br>
&gt;=C2=A0 tests/test-string-input-visitor$(EXESUF): tests/test-string-inpu=
t-visitor.o $(test-qapi-obj-y)<br>
&gt;=C2=A0 tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qap=
i-obj-y) tests/test-qapi-emit-events.o tests/test-qapi-events.o<br>
&gt; @@ -333,6 +321,7 @@ tests/test-shift128$(EXESUF): tests/test-shift128.=
o $(test-util-obj-y)<br>
&gt;=C2=A0 tests/test-mul64$(EXESUF): tests/test-mul64.o $(test-util-obj-y)=
<br>
&gt;=C2=A0 tests/test-bitops$(EXESUF): tests/test-bitops.o $(test-util-obj-=
y)<br>
&gt;=C2=A0 tests/test-bitcnt$(EXESUF): tests/test-bitcnt.o $(test-util-obj-=
y)<br>
&gt; +tests/test-qgraph$(EXESUF): tests/test-qgraph.o tests/qtest/libqos/qg=
raph.o $(test-util-obj-y)<br>
&gt;=C2=A0 tests/test-crypto-hash$(EXESUF): tests/test-crypto-hash.o $(test=
-crypto-obj-y)<br>
&gt;=C2=A0 tests/benchmark-crypto-hash$(EXESUF): tests/benchmark-crypto-has=
h.o $(test-crypto-obj-y)<br>
&gt;=C2=A0 tests/test-crypto-hmac$(EXESUF): tests/test-crypto-hmac.o $(test=
-crypto-obj-y)<br>
&gt; @@ -396,10 +385,8 @@ tests/migration/initrd-stress.img: tests/migratio=
n/stress$(EXESUF)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rm $(INITRD_WORK_DIR)/init<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir $(INITRD_WORK_DIR)<br>
&gt;=C2=A0 <br>
&gt; -include $(SRC_PATH)/tests/qtest/Makefile.include<br>
&gt; -<br>
&gt;=C2=A0 tests/test-qga$(EXESUF): qga/qemu-ga$(EXESUF)<br>
&gt; -tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)<br>
&gt; +tests/test-qga$(EXESUF): tests/test-qga.o tests/qtest/libqtest.o $(te=
st-util-obj-y)<br>
&gt;=C2=A0 tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(te=
st-util-obj-y) libvhost-user.a<br>
&gt;=C2=A0 tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotest=
s/socket_scm_helper.o<br>
&gt;=C2=A0 <br>
&gt; @@ -440,16 +427,6 @@ define do_test_tap<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;TAP&quot;,&quot;$@&quot;)<br>
&gt;=C2=A0 endef<br>
&gt;=C2=A0 <br>
&gt; -.PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))<br>
&gt; -$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-soft=
mmu/all $(check-qtest-y)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0$(call do_test_human,$(check-qtest-$*-y:%=3Dtests=
/qtest/%$(EXESUF)) $(check-qtest-generic-y:%=3Dtests/qtest/%$(EXESUF)), \<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system=
-$* \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))<br>
&gt; -<br>
&gt; -build-qtest: $(patsubst %, %-softmmu/all, $(QTEST_TARGETS)) $(check-q=
test-y)<br>
&gt; -<br>
&gt; -build-unit: $(check-unit-y)<br>
&gt; -<br>
&gt;=C2=A0 check-unit: $(check-unit-y)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call do_test_human, $^)<br>
&gt;=C2=A0 <br>
&gt; @@ -458,18 +435,9 @@ check-speed: $(check-speed-y)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # gtester tests with TAP output<br>
&gt;=C2=A0 <br>
&gt; -$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-repo=
rt-qtest-%.tap: %-softmmu/all $(check-qtest-y)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0$(call do_test_tap, $(check-qtest-$*-y:%=3Dtests/=
qtest/%$(EXESUF)) $(check-qtest-generic-y:%=3Dtests/qtest/%$(EXESUF)), \<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system=
-$* \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))<br>
&gt; -<br>
&gt;=C2=A0 check-report-unit.tap: $(check-unit-y)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call do_test_tap,$^)<br>
&gt;=C2=A0 <br>
&gt; -# Reports and overall runs<br>
&gt; -<br>
&gt; -check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARG=
ETS)) check-report-unit.tap<br>
&gt; -<br>
&gt;=C2=A0 # Plugins<br>
&gt;=C2=A0 ifeq ($(CONFIG_PLUGIN),y)<br>
&gt;=C2=A0 .PHONY: plugins<br>
&gt; @@ -582,19 +550,16 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR=
) get-vm-images<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Consolidated targets<br>
&gt;=C2=A0 <br>
&gt; -.PHONY: check-block check-qtest check-unit check check-clean get-vm-i=
mages<br>
&gt; -check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))<br>
&gt; +.PHONY: check-block check-unit check check-clean get-vm-images<br>
&gt;=C2=A0 ifeq ($(CONFIG_TOOLS),y)<br>
&gt;=C2=A0 check-block: $(patsubst %,check-%, $(check-block-y))<br>
&gt;=C2=A0 endif<br>
&gt; -check-build: build-unit build-qtest<br>
&gt; +check-build: build-unit<br>
&gt;=C2=A0 <br>
&gt; -check: check-block check-unit check-qtest<br>
&gt; +check: check-block check-unit<br>
&gt;=C2=A0 check-clean:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -rf $(check-unit-y) tests/*.o tests/*/*.o=
 $(QEMU_IOTESTS_HELPERS-y)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LI=
ST), $(check-qtest-$(target)-y:%=3Dtests/qtest/%$(EXESUF))) $(check-qtest-g=
eneric-y:%=3Dtests/qtest/%$(EXESUF)))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/test-qapi-gen-timestamp<br>
&gt; -=C2=A0 =C2=A0 =C2=A0rm -f tests/qtest/dbus-vmstate1-gen-timestamp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR=
)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 check: check-block check-qapi-schema check-unit check-qtest chec=
k-decodetree<br>
&gt; @@ -606,7 +571,5 @@ clean: check-clean<br>
&gt;=C2=A0 all: $(QEMU_IOTESTS_HELPERS-y)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 -include $(wildcard tests/*.d)<br>
&gt; --include $(wildcard tests/qtest/*.d)<br>
&gt; --include $(wildcard tests/qtest/libqos/*.d)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 endif<br>
&gt; diff --git a/tests/meson.build b/tests/meson.build<br>
&gt; index 8be9c22..d724402 100644<br>
&gt; --- a/tests/meson.build<br>
&gt; +++ b/tests/meson.build<br>
&gt; @@ -8,3 +8,4 @@ if &#39;CONFIG_TCG&#39; in config_host<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 subdir(&#39;qapi-schema&#39;)<br>
&gt; +subdir(&#39;qtest&#39;)<br>
&gt; diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.inclu=
de<br>
&gt; deleted file mode 100644<br>
&gt; index b0204e4..0000000<br>
&gt; --- a/tests/qtest/Makefile.include<br>
&gt; +++ /dev/null<br>
&gt; @@ -1,332 +0,0 @@<br>
&gt; -# All QTests for now are POSIX-only, but the dependencies are<br>
&gt; -# really in libqtest, not in the testcases themselves.<br>
&gt; -<br>
&gt; -check-qtest-generic-y +=3D cdrom-test<br>
&gt; -check-qtest-generic-y +=3D device-introspect-test<br>
&gt; -check-qtest-generic-y +=3D machine-none-test<br>
&gt; -check-qtest-generic-y +=3D qmp-test<br>
&gt; -check-qtest-generic-y +=3D qmp-cmd-test<br>
&gt; -check-qtest-generic-y +=3D qom-test<br>
&gt; -check-qtest-generic-$(CONFIG_MODULES) +=3D modules-test<br>
&gt; -check-qtest-generic-y +=3D test-hmp<br>
&gt; -<br>
&gt; -check-qtest-pci-$(CONFIG_RTL8139_PCI) +=3D rtl8139-test<br>
&gt; -check-qtest-pci-$(CONFIG_VGA) +=3D display-vga-test<br>
&gt; -check-qtest-pci-$(CONFIG_HDA) +=3D intel-hda-test<br>
&gt; -check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem-test<br>
&gt; -<br>
&gt; -DBUS_DAEMON :=3D $(shell which dbus-daemon 2&gt;/dev/null)<br>
&gt; -ifneq ($(GDBUS_CODEGEN),)<br>
&gt; -ifneq ($(DBUS_DAEMON),)<br>
&gt; -# Temporarily disabled due to Patchew failures:<br>
&gt; -#check-qtest-pci-$(CONFIG_GIO) +=3D dbus-vmstate-test<br>
&gt; -endif<br>
&gt; -endif<br>
&gt; -<br>
&gt; -check-qtest-i386-$(CONFIG_ISA_TESTDEV) =3D endianness-test<br>
&gt; -check-qtest-i386-y +=3D fdc-test<br>
&gt; -check-qtest-i386-y +=3D ide-test<br>
&gt; -check-qtest-i386-$(CONFIG_TOOLS) +=3D ahci-test<br>
&gt; -check-qtest-i386-y +=3D hd-geo-test<br>
&gt; -check-qtest-i386-y +=3D boot-order-test<br>
&gt; -check-qtest-i386-y +=3D bios-tables-test<br>
&gt; -check-qtest-i386-$(CONFIG_SGA) +=3D boot-serial-test<br>
&gt; -check-qtest-i386-$(CONFIG_SLIRP) +=3D pxe-test<br>
&gt; -check-qtest-i386-y +=3D rtc-test<br>
&gt; -check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) +=3D ipmi-kcs-test<br>
&gt; -ifdef CONFIG_LINUX<br>
&gt; -check-qtest-i386-$(CONFIG_ISA_IPMI_BT) +=3D ipmi-bt-test<br>
&gt; -endif<br>
&gt; -check-qtest-i386-y +=3D i440fx-test<br>
&gt; -check-qtest-i386-y +=3D fw_cfg-test<br>
&gt; -check-qtest-i386-y +=3D device-plug-test<br>
&gt; -check-qtest-i386-y +=3D drive_del-test<br>
&gt; -check-qtest-i386-$(CONFIG_WDT_IB700) +=3D wdt_ib700-test<br>
&gt; -check-qtest-i386-y +=3D tco-test<br>
&gt; -check-qtest-i386-y +=3D $(check-qtest-pci-y)<br>
&gt; -check-qtest-i386-$(CONFIG_PVPANIC) +=3D pvpanic-test<br>
&gt; -check-qtest-i386-$(CONFIG_I82801B11) +=3D i82801b11-test<br>
&gt; -check-qtest-i386-$(CONFIG_IOH3420) +=3D ioh3420-test<br>
&gt; -check-qtest-i386-$(CONFIG_USB_UHCI) +=3D usb-hcd-uhci-test<br>
&gt; -check-qtest-i386-$(call land,$(CONFIG_USB_EHCI),$(CONFIG_USB_UHCI)) +=
=3D usb-hcd-ehci-test<br>
&gt; -check-qtest-i386-$(CONFIG_USB_XHCI_NEC) +=3D usb-hcd-xhci-test<br>
&gt; -check-qtest-i386-y +=3D cpu-plug-test<br>
&gt; -check-qtest-i386-y +=3D q35-test<br>
&gt; -check-qtest-i386-y +=3D vmgenid-test<br>
&gt; -check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tpm-crb-swtpm-test<br>
&gt; -check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tpm-crb-test<br>
&gt; -check-qtest-i386-$(CONFIG_TPM_TIS_ISA) +=3D tpm-tis-swtpm-test<br>
&gt; -check-qtest-i386-$(CONFIG_TPM_TIS_ISA) +=3D tpm-tis-test<br>
&gt; -check-qtest-i386-$(CONFIG_SLIRP) +=3D test-netfilter<br>
&gt; -check-qtest-i386-$(CONFIG_POSIX) +=3D test-filter-mirror<br>
&gt; -check-qtest-i386-$(CONFIG_RTL8139_PCI) +=3D test-filter-redirector<br=
>
&gt; -check-qtest-i386-y +=3D migration-test<br>
&gt; -check-qtest-i386-y +=3D test-x86-cpuid-compat<br>
&gt; -check-qtest-i386-y +=3D numa-test<br>
&gt; -<br>
&gt; -check-qtest-x86_64-y +=3D $(check-qtest-i386-y)<br>
&gt; -<br>
&gt; -check-qtest-avr-y +=3D boot-serial-test<br>
&gt; -<br>
&gt; -check-qtest-alpha-y +=3D boot-serial-test<br>
&gt; -check-qtest-alpha-$(CONFIG_VGA) +=3D display-vga-test<br>
&gt; -<br>
&gt; -check-qtest-hppa-y +=3D boot-serial-test<br>
&gt; -check-qtest-hppa-$(CONFIG_VGA) +=3D display-vga-test<br>
&gt; -<br>
&gt; -check-qtest-m68k-y =3D boot-serial-test<br>
&gt; -<br>
&gt; -check-qtest-microblaze-y +=3D boot-serial-test<br>
&gt; -<br>
&gt; -check-qtest-mips-$(CONFIG_ISA_TESTDEV) =3D endianness-test<br>
&gt; -check-qtest-mips-$(CONFIG_VGA) +=3D display-vga-test<br>
&gt; -<br>
&gt; -check-qtest-mips64-$(CONFIG_ISA_TESTDEV) =3D endianness-test<br>
&gt; -check-qtest-mips64-$(CONFIG_VGA) +=3D display-vga-test<br>
&gt; -<br>
&gt; -check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) =3D endianness-test<br>
&gt; -check-qtest-mips64el-$(CONFIG_VGA) +=3D display-vga-test<br>
&gt; -<br>
&gt; -check-qtest-moxie-y +=3D boot-serial-test<br>
&gt; -<br>
&gt; -check-qtest-ppc-$(CONFIG_ISA_TESTDEV) =3D endianness-test<br>
&gt; -check-qtest-ppc-y +=3D boot-order-test<br>
&gt; -check-qtest-ppc-y +=3D prom-env-test<br>
&gt; -check-qtest-ppc-y +=3D drive_del-test<br>
&gt; -check-qtest-ppc-y +=3D boot-serial-test<br>
&gt; -check-qtest-ppc-$(CONFIG_M48T59) +=3D m48t59-test<br>
&gt; -<br>
&gt; -check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)<br>
&gt; -check-qtest-ppc64-$(CONFIG_PSERIES) +=3D device-plug-test<br>
&gt; -check-qtest-ppc64-$(CONFIG_POWERNV) +=3D pnv-xscom-test<br>
&gt; -check-qtest-ppc64-y +=3D migration-test<br>
&gt; -check-qtest-ppc64-$(CONFIG_PSERIES) +=3D rtas-test<br>
&gt; -check-qtest-ppc64-$(CONFIG_SLIRP) +=3D pxe-test<br>
&gt; -check-qtest-ppc64-$(CONFIG_USB_UHCI) +=3D usb-hcd-uhci-test<br>
&gt; -check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) +=3D usb-hcd-xhci-test<br>
&gt; -check-qtest-ppc64-$(CONFIG_SLIRP) +=3D test-netfilter<br>
&gt; -check-qtest-ppc64-$(CONFIG_POSIX) +=3D test-filter-mirror<br>
&gt; -check-qtest-ppc64-$(CONFIG_RTL8139_PCI) +=3D test-filter-redirector<b=
r>
&gt; -check-qtest-ppc64-$(CONFIG_VGA) +=3D display-vga-test<br>
&gt; -check-qtest-ppc64-y +=3D numa-test<br>
&gt; -check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem-test<br>
&gt; -check-qtest-ppc64-y +=3D cpu-plug-test<br>
&gt; -<br>
&gt; -check-qtest-sh4-$(CONFIG_ISA_TESTDEV) =3D endianness-test<br>
&gt; -<br>
&gt; -check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D endianness-test<br>
&gt; -<br>
&gt; -check-qtest-sparc-y +=3D prom-env-test<br>
&gt; -check-qtest-sparc-y +=3D m48t59-test<br>
&gt; -check-qtest-sparc-y +=3D boot-serial-test<br>
&gt; -<br>
&gt; -check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D endianness-test<br>
&gt; -check-qtest-sparc64-y +=3D prom-env-test<br>
&gt; -check-qtest-sparc64-y +=3D boot-serial-test<br>
&gt; -<br>
&gt; -check-qtest-arm-y +=3D arm-cpu-features<br>
&gt; -check-qtest-arm-y +=3D microbit-test<br>
&gt; -check-qtest-arm-y +=3D m25p80-test<br>
&gt; -check-qtest-arm-y +=3D test-arm-mptimer<br>
&gt; -check-qtest-arm-y +=3D boot-serial-test<br>
&gt; -check-qtest-arm-y +=3D hexloader-test<br>
&gt; -check-qtest-arm-$(CONFIG_PFLASH_CFI02) +=3D pflash-cfi02-test<br>
&gt; -<br>
&gt; -check-qtest-aarch64-y +=3D arm-cpu-features<br>
&gt; -check-qtest-aarch64-$(CONFIG_TPM_TIS_SYSBUS) +=3D tpm-tis-device-test=
<br>
&gt; -check-qtest-aarch64-$(CONFIG_TPM_TIS_SYSBUS) +=3D tpm-tis-device-swtp=
m-test<br>
&gt; -check-qtest-aarch64-y +=3D numa-test<br>
&gt; -check-qtest-aarch64-y +=3D boot-serial-test<br>
&gt; -check-qtest-aarch64-y +=3D migration-test<br>
&gt; -<br>
&gt; -# TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test uncon=
ditional<br>
&gt; -ifneq ($(ARCH),arm)<br>
&gt; -check-qtest-aarch64-y +=3D bios-tables-test<br>
&gt; -endif<br>
&gt; -<br>
&gt; -check-qtest-microblazeel-y +=3D $(check-qtest-microblaze-y)<br>
&gt; -<br>
&gt; -check-qtest-xtensaeb-y +=3D $(check-qtest-xtensa-y)<br>
&gt; -<br>
&gt; -check-qtest-s390x-y =3D boot-serial-test<br>
&gt; -check-qtest-s390x-$(CONFIG_SLIRP) +=3D pxe-test<br>
&gt; -check-qtest-s390x-$(CONFIG_SLIRP) +=3D test-netfilter<br>
&gt; -check-qtest-s390x-$(CONFIG_POSIX) +=3D test-filter-mirror<br>
&gt; -check-qtest-s390x-$(CONFIG_POSIX) +=3D test-filter-redirector<br>
&gt; -check-qtest-s390x-y +=3D drive_del-test<br>
&gt; -check-qtest-s390x-y +=3D device-plug-test<br>
&gt; -check-qtest-s390x-y +=3D virtio-ccw-test<br>
&gt; -check-qtest-s390x-y +=3D cpu-plug-test<br>
&gt; -check-qtest-s390x-y +=3D migration-test<br>
&gt; -<br>
&gt; -# libqos / qgraph :<br>
&gt; -libqgraph-obj-y =3D tests/qtest/libqos/qgraph.o<br>
&gt; -<br>
&gt; -libqos-core-obj-y =3D $(libqgraph-obj-y) tests/qtest/libqos/pci.o tes=
ts/qtest/libqos/fw_cfg.o<br>
&gt; -libqos-core-obj-y +=3D tests/qtest/libqos/malloc.o<br>
&gt; -libqos-core-obj-y +=3D tests/qtest/libqos/libqos.o<br>
&gt; -libqos-spapr-obj-y =3D $(libqos-core-obj-y) tests/qtest/libqos/malloc=
-spapr.o<br>
&gt; -libqos-spapr-obj-y +=3D tests/qtest/libqos/libqos-spapr.o<br>
&gt; -libqos-spapr-obj-y +=3D tests/qtest/libqos/rtas.o<br>
&gt; -libqos-spapr-obj-y +=3D tests/qtest/libqos/pci-spapr.o<br>
&gt; -libqos-pc-obj-y =3D $(libqos-core-obj-y) tests/qtest/libqos/pci-pc.o<=
br>
&gt; -libqos-pc-obj-y +=3D tests/qtest/libqos/malloc-pc.o tests/qtest/libqo=
s/libqos-pc.o<br>
&gt; -libqos-pc-obj-y +=3D tests/qtest/libqos/ahci.o<br>
&gt; -libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/q=
test/libqos/usb.o<br>
&gt; -<br>
&gt; -# qos devices:<br>
&gt; -libqos-obj-y =3D=C2=A0 $(libqgraph-obj-y)<br>
&gt; -libqos-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/qos_external.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/e1000e.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/i2c.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/i2c-imx.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/i2c-omap.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/sdhci.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/tpci200.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/virtio.o<br>
&gt; -libqos-obj-$(CONFIG_VIRTFS) +=3D tests/qtest/libqos/virtio-9p.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/virtio-balloon.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/virtio-blk.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/virtio-mmio.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/virtio-net.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/virtio-pci.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/virtio-pci-modern.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/virtio-rng.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/virtio-scsi.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/virtio-serial.o<br>
&gt; -<br>
&gt; -# qos machines:<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/aarch64-xlnx-zcu102-machine.o<br=
>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/arm-imx25-pdk-machine.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/arm-n800-machine.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/arm-raspi2-machine.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/arm-sabrelite-machine.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/arm-smdkc210-machine.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/arm-virt-machine.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/arm-xilinx-zynq-a9-machine.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/ppc64_pseries-machine.o<br>
&gt; -libqos-obj-y +=3D tests/qtest/libqos/x86_64_pc-machine.o<br>
&gt; -<br>
&gt; -# qos tests:<br>
&gt; -qos-test-obj-y +=3D tests/qtest/qos-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/ac97-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/ds1338-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/e1000-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/e1000e-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/eepro100-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/es1370-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/ipoctal232-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/megasas-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/ne2000-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/tulip-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/nvme-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/pca9552-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/pci-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/pcnet-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/sdhci-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/spapr-phb-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/tmp105-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/usb-hcd-ohci-test.o $(libqos-usb-obj-=
y)<br>
&gt; -qos-test-obj-$(CONFIG_VHOST_NET_USER) +=3D tests/qtest/vhost-user-tes=
t.o $(chardev-obj-y) $(test-io-obj-y)<br>
&gt; -qos-test-obj-y +=3D tests/qtest/virtio-test.o<br>
&gt; -qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/qtest/virtio-9p-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/virtio-blk-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/virtio-net-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/virtio-rng-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/virtio-scsi-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/virtio-serial-test.o<br>
&gt; -qos-test-obj-y +=3D tests/qtest/vmxnet3-test.o<br>
&gt; -<br>
&gt; -check-unit-y +=3D tests/test-qgraph$(EXESUF)<br>
&gt; -tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)<br=
>
&gt; -<br>
&gt; -check-qtest-generic-y +=3D qos-test<br>
&gt; -tests/qtest/qos-test$(EXESUF): $(qos-test-obj-y) $(libqos-obj-y)<br>
&gt; -<br>
&gt; -# QTest dependencies:<br>
&gt; -tests/qtest/qmp-test$(EXESUF): tests/qtest/qmp-test.o<br>
&gt; -tests/qtest/qmp-cmd-test$(EXESUF): tests/qtest/qmp-cmd-test.o<br>
&gt; -tests/qtest/device-introspect-test$(EXESUF): tests/qtest/device-intro=
spect-test.o<br>
&gt; -tests/qtest/rtc-test$(EXESUF): tests/qtest/rtc-test.o<br>
&gt; -tests/qtest/m48t59-test$(EXESUF): tests/qtest/m48t59-test.o<br>
&gt; -tests/qtest/hexloader-test$(EXESUF): tests/qtest/hexloader-test.o<br>
&gt; -tests/qtest/pflash-cfi02$(EXESUF): tests/qtest/pflash-cfi02-test.o<br=
>
&gt; -tests/qtest/endianness-test$(EXESUF): tests/qtest/endianness-test.o<b=
r>
&gt; -tests/qtest/prom-env-test$(EXESUF): tests/qtest/prom-env-test.o $(lib=
qos-obj-y)<br>
&gt; -tests/qtest/rtas-test$(EXESUF): tests/qtest/rtas-test.o $(libqos-spap=
r-obj-y)<br>
&gt; -tests/qtest/fdc-test$(EXESUF): tests/qtest/fdc-test.o<br>
&gt; -tests/qtest/ide-test$(EXESUF): tests/qtest/ide-test.o $(libqos-pc-obj=
-y)<br>
&gt; -tests/qtest/ahci-test$(EXESUF): tests/qtest/ahci-test.o $(libqos-pc-o=
bj-y) qemu-img$(EXESUF)<br>
&gt; -tests/qtest/ipmi-kcs-test$(EXESUF): tests/qtest/ipmi-kcs-test.o<br>
&gt; -tests/qtest/ipmi-bt-test$(EXESUF): tests/qtest/ipmi-bt-test.o<br>
&gt; -tests/qtest/hd-geo-test$(EXESUF): tests/qtest/hd-geo-test.o $(libqos-=
obj-y)<br>
&gt; -tests/qtest/boot-order-test$(EXESUF): tests/qtest/boot-order-test.o $=
(libqos-obj-y)<br>
&gt; -tests/qtest/boot-serial-test$(EXESUF): tests/qtest/boot-serial-test.o=
 $(libqos-obj-y)<br>
&gt; -tests/qtest/bios-tables-test$(EXESUF): tests/qtest/bios-tables-test.o=
 \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tests/qtest/tpm-emu.o $(test-io-obj-y) \<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0tests/qtest/boot-sector.o tests/qtest/acpi-utils.=
o $(libqos-obj-y)<br>
&gt; -tests/qtest/pxe-test$(EXESUF): tests/qtest/pxe-test.o tests/qtest/boo=
t-sector.o $(libqos-obj-y)<br>
&gt; -tests/qtest/microbit-test$(EXESUF): tests/qtest/microbit-test.o<br>
&gt; -tests/qtest/m25p80-test$(EXESUF): tests/qtest/m25p80-test.o<br>
&gt; -tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o $(libqos-=
pc-obj-y)<br>
&gt; -tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-obj=
-y)<br>
&gt; -tests/qtest/fw_cfg-test$(EXESUF): tests/qtest/fw_cfg-test.o $(libqos-=
pc-obj-y)<br>
&gt; -tests/qtest/rtl8139-test$(EXESUF): tests/qtest/rtl8139-test.o $(libqo=
s-pc-obj-y)<br>
&gt; -tests/qtest/pnv-xscom-test$(EXESUF): tests/qtest/pnv-xscom-test.o<br>
&gt; -tests/qtest/wdt_ib700-test$(EXESUF): tests/qtest/wdt_ib700-test.o<br>
&gt; -tests/qtest/tco-test$(EXESUF): tests/qtest/tco-test.o $(libqos-pc-obj=
-y)<br>
&gt; -tests/qtest/virtio-ccw-test$(EXESUF): tests/qtest/virtio-ccw-test.o<b=
r>
&gt; -tests/qtest/display-vga-test$(EXESUF): tests/qtest/display-vga-test.o=
<br>
&gt; -tests/qtest/qom-test$(EXESUF): tests/qtest/qom-test.o<br>
&gt; -tests/qtest/modules-test$(EXESUF): tests/qtest/modules-test.o<br>
&gt; -tests/qtest/test-hmp$(EXESUF): tests/qtest/test-hmp.o<br>
&gt; -tests/qtest/machine-none-test$(EXESUF): tests/qtest/machine-none-test=
.o<br>
&gt; -tests/qtest/device-plug-test$(EXESUF): tests/qtest/device-plug-test.o=
<br>
&gt; -tests/qtest/drive_del-test$(EXESUF): tests/qtest/drive_del-test.o<br>
&gt; -tests/qtest/pvpanic-test$(EXESUF): tests/qtest/pvpanic-test.o<br>
&gt; -tests/qtest/i82801b11-test$(EXESUF): tests/qtest/i82801b11-test.o<br>
&gt; -tests/qtest/intel-hda-test$(EXESUF): tests/qtest/intel-hda-test.o<br>
&gt; -tests/qtest/ioh3420-test$(EXESUF): tests/qtest/ioh3420-test.o<br>
&gt; -tests/qtest/usb-hcd-uhci-test$(EXESUF): tests/qtest/usb-hcd-uhci-test=
.o $(libqos-usb-obj-y)<br>
&gt; -tests/qtest/usb-hcd-ehci-test$(EXESUF): tests/qtest/usb-hcd-ehci-test=
.o $(libqos-usb-obj-y)<br>
&gt; -tests/qtest/usb-hcd-xhci-test$(EXESUF): tests/qtest/usb-hcd-xhci-test=
.o $(libqos-usb-obj-y)<br>
&gt; -tests/qtest/cpu-plug-test$(EXESUF): tests/qtest/cpu-plug-test.o<br>
&gt; -tests/qtest/migration-test$(EXESUF): tests/qtest/migration-test.o tes=
ts/qtest/migration-helpers.o<br>
&gt; -tests/qtest/test-netfilter$(EXESUF): tests/qtest/test-netfilter.o $(q=
test-obj-y)<br>
&gt; -tests/qtest/test-filter-mirror$(EXESUF): tests/qtest/test-filter-mirr=
or.o $(qtest-obj-y)<br>
&gt; -tests/qtest/test-filter-redirector$(EXESUF): tests/qtest/test-filter-=
redirector.o $(qtest-obj-y)<br>
&gt; -tests/qtest/test-x86-cpuid-compat$(EXESUF): tests/qtest/test-x86-cpui=
d-compat.o $(qtest-obj-y)<br>
&gt; -tests/qtest/ivshmem-test$(EXESUF): tests/qtest/ivshmem-test.o contrib=
/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)<b=
r>
&gt; -tests/qtest/dbus-vmstate-test$(EXESUF): tests/qtest/dbus-vmstate-test=
.o tests/qtest/migration-helpers.o tests/qtest/dbus-vmstate1.o $(libqos-pc-=
obj-y) $(libqos-spapr-obj-y)<br>
&gt; -tests/qtest/test-arm-mptimer$(EXESUF): tests/qtest/test-arm-mptimer.o=
<br>
&gt; -tests/qtest/numa-test$(EXESUF): tests/qtest/numa-test.o<br>
&gt; -tests/qtest/vmgenid-test$(EXESUF): tests/qtest/vmgenid-test.o tests/q=
test/boot-sector.o tests/qtest/acpi-utils.o<br>
&gt; -tests/qtest/cdrom-test$(EXESUF): tests/qtest/cdrom-test.o tests/qtest=
/boot-sector.o $(libqos-obj-y)<br>
&gt; -tests/qtest/arm-cpu-features$(EXESUF): tests/qtest/arm-cpu-features.o=
<br>
&gt; -tests/qtest/tpm-crb-swtpm-test$(EXESUF): tests/qtest/tpm-crb-swtpm-te=
st.o tests/qtest/tpm-emu.o \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(=
test-io-obj-y)<br>
&gt; -tests/qtest/tpm-crb-test$(EXESUF): tests/qtest/tpm-crb-test.o tests/q=
test/tpm-emu.o $(test-io-obj-y)<br>
&gt; -tests/qtest/tpm-tis-swtpm-test$(EXESUF): tests/qtest/tpm-tis-swtpm-te=
st.o tests/qtest/tpm-emu.o \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(=
test-io-obj-y)<br>
&gt; -tests/qtest/tpm-tis-device-swtpm-test$(EXESUF): tests/qtest/tpm-tis-d=
evice-swtpm-test.o tests/qtest/tpm-emu.o \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(=
test-io-obj-y)<br>
&gt; -tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/q=
test/tpm-tis-util.o tests/qtest/tpm-emu.o $(test-io-obj-y)<br>
&gt; -tests/qtest/tpm-tis-device-test$(EXESUF): tests/qtest/tpm-tis-device-=
test.o tests/qtest/tpm-tis-util.o tests/qtest/tpm-emu.o $(test-io-obj-y)<br=
>
&gt; -<br>
&gt; -# QTest rules<br>
&gt; -<br>
&gt; -TARGETS=3D$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))=
<br>
&gt; -QTEST_TARGETS =3D<br>
&gt; -# The qtests are not runnable (yet) under TSan due to a known issue.<=
br>
&gt; -# <a href=3D"https://github.com/google/sanitizers/issues/1116" rel=3D=
"noreferrer noreferrer" target=3D"_blank">https://github.com/google/sanitiz=
ers/issues/1116</a><br>
&gt; -ifndef CONFIG_TSAN<br>
&gt; -ifeq ($(CONFIG_POSIX),y)<br>
&gt; -QTEST_TARGETS =3D $(TARGETS)<br>
&gt; -check-qtest-y=3D$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-=
y:%=3Dtests/qtest/%$(EXESUF)))<br>
&gt; -check-qtest-y +=3D $(check-qtest-generic-y:%=3Dtests/qtest/%$(EXESUF)=
)<br>
&gt; -endif<br>
&gt; -endif<br>
&gt; -<br>
&gt; -qtest-obj-y =3D tests/qtest/libqtest.o $(test-util-obj-y)<br>
&gt; -$(check-qtest-y): $(qtest-obj-y)<br>
&gt; diff --git a/tests/qtest/ac97-test.c b/tests/qtest/ac97-test.c<br>
&gt; index b084e31..e09f249 100644<br>
&gt; --- a/tests/qtest/ac97-test.c<br>
&gt; +++ b/tests/qtest/ac97-test.c<br>
&gt; @@ -8,7 +8,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/qgraph.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/pci.h&quot;<br>
&gt; diff --git a/tests/qtest/acpi-utils.h b/tests/qtest/acpi-utils.h<br>
&gt; index 0c86780..261784d 100644<br>
&gt; --- a/tests/qtest/acpi-utils.h<br>
&gt; +++ b/tests/qtest/acpi-utils.h<br>
&gt; @@ -13,7 +13,7 @@<br>
&gt;=C2=A0 #ifndef TEST_ACPI_UTILS_H<br>
&gt;=C2=A0 #define TEST_ACPI_UTILS_H<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* DSDT and SSDTs format */<br>
&gt;=C2=A0 typedef struct {<br>
&gt; diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c<br>
&gt; index c8d42ce..ca4294f 100644<br>
&gt; --- a/tests/qtest/ahci-test.c<br>
&gt; +++ b/tests/qtest/ahci-test.c<br>
&gt; @@ -25,7 +25,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &lt;getopt.h&gt;<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/libqos-pc.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/ahci.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/pci-pc.h&quot;<br>
&gt; diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-feat=
ures.c<br>
&gt; index f7e062c..77b5e30 100644<br>
&gt; --- a/tests/qtest/arm-cpu-features.c<br>
&gt; +++ b/tests/qtest/arm-cpu-features.c<br>
&gt; @@ -10,7 +10,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/bitops.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qmp/qdict.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qmp/qjson.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/boot-order-test.c b/tests/qtest/boot-order-te=
st.c<br>
&gt; index 2f1c072..fac580d 100644<br>
&gt; --- a/tests/qtest/boot-order-test.c<br>
&gt; +++ b/tests/qtest/boot-order-test.c<br>
&gt; @@ -12,7 +12,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/fw_cfg.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qmp/qdict.h&quot;<br>
&gt;=C2=A0 #include &quot;standard-headers/linux/qemu_fw_cfg.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/boot-sector.c b/tests/qtest/boot-sector.c<br>
&gt; index 9e66c6d..24df5c4 100644<br>
&gt; --- a/tests/qtest/boot-sector.c<br>
&gt; +++ b/tests/qtest/boot-sector.c<br>
&gt; @@ -13,7 +13,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;boot-sector.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu-common.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define LOW(x) ((x) &amp; 0xff)<br>
&gt;=C2=A0 #define HIGH(x) ((x) &gt;&gt; 8)<br>
&gt; diff --git a/tests/qtest/boot-sector.h b/tests/qtest/boot-sector.h<br>
&gt; index 6ee6bb4..b339fde 100644<br>
&gt; --- a/tests/qtest/boot-sector.h<br>
&gt; +++ b/tests/qtest/boot-sector.h<br>
&gt; @@ -14,7 +14,7 @@<br>
&gt;=C2=A0 #ifndef TEST_BOOT_SECTOR_H<br>
&gt;=C2=A0 #define TEST_BOOT_SECTOR_H<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* Create boot disk file. fname must be a suitable string for mk=
stemp() */<br>
&gt;=C2=A0 int boot_sector_init(char *fname);<br>
&gt; diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-=
test.c<br>
&gt; index bfe7624..b6b1c23 100644<br>
&gt; --- a/tests/qtest/boot-serial-test.c<br>
&gt; +++ b/tests/qtest/boot-serial-test.c<br>
&gt; @@ -14,7 +14,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/libqos-spapr.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static const uint8_t bios_avr[] =3D {<br>
&gt; diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c<br>
&gt; index 833a050..e9afab6 100644<br>
&gt; --- a/tests/qtest/cdrom-test.c<br>
&gt; +++ b/tests/qtest/cdrom-test.c<br>
&gt; @@ -11,7 +11,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;boot-sector.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qmp/qdict.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstat=
e-test.c<br>
&gt; index 2e5e47d..aca9b98 100644<br>
&gt; --- a/tests/qtest/dbus-vmstate-test.c<br>
&gt; +++ b/tests/qtest/dbus-vmstate-test.c<br>
&gt; @@ -1,7 +1,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &lt;glib/gstdio.h&gt;<br>
&gt;=C2=A0 #include &lt;gio/gio.h&gt;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu-common.h&quot;<br>
&gt;=C2=A0 #include &quot;dbus-vmstate1.h&quot;<br>
&gt;=C2=A0 #include &quot;migration-helpers.h&quot;<br>
&gt; diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device=
-introspect-test.c<br>
&gt; index d68b785..9f22340 100644<br>
&gt; --- a/tests/qtest/device-introspect-test.c<br>
&gt; +++ b/tests/qtest/device-introspect-test.c<br>
&gt; @@ -22,7 +22,7 @@<br>
&gt;=C2=A0 #include &quot;qapi/qmp/qstring.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qmp/qdict.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qmp/qlist.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 const char common_args[] =3D &quot;-nodefaults -machine none&quo=
t;;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-=
test.c<br>
&gt; index 318e422..9214892 100644<br>
&gt; --- a/tests/qtest/device-plug-test.c<br>
&gt; +++ b/tests/qtest/device-plug-test.c<br>
&gt; @@ -11,7 +11,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qmp/qdict.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qmp/qstring.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test=
.c<br>
&gt; index 5f8839b..2ab11ad 100644<br>
&gt; --- a/tests/qtest/drive_del-test.c<br>
&gt; +++ b/tests/qtest/drive_del-test.c<br>
&gt; @@ -11,7 +11,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/virtio.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qmp/qdict.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c<br>
&gt; index f6ade9a..c5d46bc 100644<br>
&gt; --- a/tests/qtest/ds1338-test.c<br>
&gt; +++ b/tests/qtest/ds1338-test.c<br>
&gt; @@ -18,7 +18,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/i2c.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define DS1338_ADDR 0x68<br>
&gt; diff --git a/tests/qtest/e1000-test.c b/tests/qtest/e1000-test.c<br>
&gt; index c387984..ea286d1 100644<br>
&gt; --- a/tests/qtest/e1000-test.c<br>
&gt; +++ b/tests/qtest/e1000-test.c<br>
&gt; @@ -8,7 +8,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/qgraph.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/pci.h&quot;<br>
&gt; diff --git a/tests/qtest/eepro100-test.c b/tests/qtest/eepro100-test.c=
<br>
&gt; index 8dbffff..d72ad09 100644<br>
&gt; --- a/tests/qtest/eepro100-test.c<br>
&gt; +++ b/tests/qtest/eepro100-test.c<br>
&gt; @@ -8,7 +8,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/qgraph.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/pci.h&quot;<br>
&gt; diff --git a/tests/qtest/endianness-test.c b/tests/qtest/endianness-te=
st.c<br>
&gt; index cc088ac..4e79e22 100644<br>
&gt; --- a/tests/qtest/endianness-test.c<br>
&gt; +++ b/tests/qtest/endianness-test.c<br>
&gt; @@ -13,7 +13,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/bswap.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct TestCase TestCase;<br>
&gt; diff --git a/tests/qtest/es1370-test.c b/tests/qtest/es1370-test.c<br>
&gt; index adccdac..2fd7fd2 100644<br>
&gt; --- a/tests/qtest/es1370-test.c<br>
&gt; +++ b/tests/qtest/es1370-test.c<br>
&gt; @@ -8,7 +8,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/qgraph.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/pci.h&quot;<br>
&gt; diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c<br>
&gt; index 031594a..1ceea84 100644<br>
&gt; --- a/tests/qtest/fuzz/fuzz.c<br>
&gt; +++ b/tests/qtest/fuzz/fuzz.c<br>
&gt; @@ -20,7 +20,7 @@<br>
&gt;=C2=A0 #include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/main-loop.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/rcu.h&quot;<br>
&gt; -#include &quot;tests/qtest/libqtest.h&quot;<br>
&gt; +#include &quot;tests/qtest/libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;tests/qtest/libqos/qgraph.h&quot;<br>
&gt;=C2=A0 #include &quot;fuzz.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h<br>
&gt; index 9ca3d10..8eb765e 100644<br>
&gt; --- a/tests/qtest/fuzz/fuzz.h<br>
&gt; +++ b/tests/qtest/fuzz/fuzz.h<br>
&gt; @@ -18,7 +18,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/units.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;tests/qtest/libqtest.h&quot;<br>
&gt; +#include &quot;tests/qtest/libqos/libqtest.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* A libfuzzer fuzzing target<br>
&gt; diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_=
fuzz.c<br>
&gt; index bf966d4..f45373f 100644<br>
&gt; --- a/tests/qtest/fuzz/i440fx_fuzz.c<br>
&gt; +++ b/tests/qtest/fuzz/i440fx_fuzz.c<br>
&gt; @@ -13,7 +13,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/main-loop.h&quot;<br>
&gt; -#include &quot;tests/qtest/libqtest.h&quot;<br>
&gt; +#include &quot;tests/qtest/libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;tests/qtest/libqos/pci.h&quot;<br>
&gt;=C2=A0 #include &quot;tests/qtest/libqos/pci-pc.h&quot;<br>
&gt;=C2=A0 #include &quot;fuzz.h&quot;<br>
&gt; diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c=
<br>
&gt; index d52f3eb..b943577 100644<br>
&gt; --- a/tests/qtest/fuzz/qos_fuzz.c<br>
&gt; +++ b/tests/qtest/fuzz/qos_fuzz.c<br>
&gt; @@ -25,7 +25,7 @@<br>
&gt;=C2=A0 #include &quot;sysemu/sysemu.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/main-loop.h&quot;<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;tests/qtest/libqtest.h&quot;<br>
&gt; +#include &quot;tests/qtest/libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;tests/qtest/libqos/malloc.h&quot;<br>
&gt;=C2=A0 #include &quot;tests/qtest/libqos/qgraph.h&quot;<br>
&gt;=C2=A0 #include &quot;tests/qtest/libqos/qgraph_internal.h&quot;<br>
&gt; diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/vir=
tio_net_fuzz.c<br>
&gt; index a33bd73..277a9e2 100644<br>
&gt; --- a/tests/qtest/fuzz/virtio_net_fuzz.c<br>
&gt; +++ b/tests/qtest/fuzz/virtio_net_fuzz.c<br>
&gt; @@ -13,7 +13,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;standard-headers/linux/virtio_config.h&quot;<br>
&gt; -#include &quot;tests/qtest/libqtest.h&quot;<br>
&gt; +#include &quot;tests/qtest/libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;tests/qtest/libqos/virtio-net.h&quot;<br>
&gt;=C2=A0 #include &quot;fuzz.h&quot;<br>
&gt;=C2=A0 #include &quot;fork_fuzz.h&quot;<br>
&gt; diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/vi=
rtio_scsi_fuzz.c<br>
&gt; index 3a9ea13..977ac42 100644<br>
&gt; --- a/tests/qtest/fuzz/virtio_scsi_fuzz.c<br>
&gt; +++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c<br>
&gt; @@ -12,7 +12,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;tests/qtest/libqtest.h&quot;<br>
&gt; +#include &quot;tests/qtest/libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/virtio-scsi.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/virtio.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/virtio-pci.h&quot;<br>
&gt; diff --git a/tests/qtest/fw_cfg-test.c b/tests/qtest/fw_cfg-test.c<br>
&gt; index 5dc807b..95b3907 100644<br>
&gt; --- a/tests/qtest/fw_cfg-test.c<br>
&gt; +++ b/tests/qtest/fw_cfg-test.c<br>
&gt; @@ -12,7 +12,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;standard-headers/linux/qemu_fw_cfg.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/fw_cfg.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/bswap.h&quot;<br>
&gt; diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c<br>
&gt; index 48e8e02..f7b7cfb 100644<br>
&gt; --- a/tests/qtest/hd-geo-test.c<br>
&gt; +++ b/tests/qtest/hd-geo-test.c<br>
&gt; @@ -19,7 +19,7 @@<br>
&gt;=C2=A0 #include &quot;qemu-common.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/bswap.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qmp/qlist.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/fw_cfg.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/libqos.h&quot;<br>
&gt;=C2=A0 #include &quot;standard-headers/linux/qemu_fw_cfg.h&quot;<br>
&gt; diff --git a/tests/qtest/hexloader-test.c b/tests/qtest/hexloader-test=
.c<br>
&gt; index 8b7aa2d..5615020 100644<br>
&gt; --- a/tests/qtest/hexloader-test.c<br>
&gt; +++ b/tests/qtest/hexloader-test.c<br>
&gt; @@ -10,7 +10,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* Load &#39;test.hex&#39; and verify that the in-memory content=
s are as expected.<br>
&gt;=C2=A0 =C2=A0* &#39;test.hex&#39; is a memory test pattern stored in He=
xadecimal Object<br>
&gt; diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c<br>
&gt; index 5cfd97f..3f8081e 100644<br>
&gt; --- a/tests/qtest/ide-test.c<br>
&gt; +++ b/tests/qtest/ide-test.c<br>
&gt; @@ -25,7 +25,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/libqos.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/pci-pc.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/malloc-pc.h&quot;<br>
&gt; diff --git a/tests/qtest/ipoctal232-test.c b/tests/qtest/ipoctal232-te=
st.c<br>
&gt; index 53a8c9b..65ce10b 100644<br>
&gt; --- a/tests/qtest/ipoctal232-test.c<br>
&gt; +++ b/tests/qtest/ipoctal232-test.c<br>
&gt; @@ -8,7 +8,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/qgraph.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/ivshmem-test.c b/tests/qtest/ivshmem-test.c<b=
r>
&gt; index ecda256..d5c8b9f 100644<br>
&gt; --- a/tests/qtest/ivshmem-test.c<br>
&gt; +++ b/tests/qtest/ivshmem-test.c<br>
&gt; @@ -13,7 +13,7 @@<br>
&gt;=C2=A0 #include &quot;contrib/ivshmem-server/ivshmem-server.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/libqos-pc.h&quot;<br>
&gt;=C2=A0 #include &quot;libqos/libqos-spapr.h&quot;<br>
&gt; -#include &quot;libqtest.h&quot;<br>
&gt; +#include &quot;libqos/libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu-common.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define TMPSHMSIZE (1 &lt;&lt; 20)<br>
&gt; diff --git a/tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c b/tests/=
qtest/libqos/aarch64-xlnx-zcu102-machine.c<br>
&gt; index 8f827ae..79631cc 100644<br>
&gt; --- a/tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c<br>
&gt; +++ b/tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c<br>
&gt; @@ -19,8 +19,8 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt; -#include &quot;libqos/malloc.h&quot;<br>
&gt; -#include &quot;libqos/qgraph.h&quot;<br>
&gt; +#include &quot;malloc.h&quot;<br>
&gt; +#include &quot;qgraph.h&quot;<br>
&gt;=C2=A0 #include &quot;sdhci.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct QXlnxZCU102Machine QXlnxZCU102Machine;<br>
&gt; diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c<br>
&gt; index cc1b08e..2946abc 100644<br>
&gt; --- a/tests/qtest/libqos/ahci.c<br>
&gt; +++ b/tests/qtest/libqos/ahci.c<br>
&gt; @@ -25,8 +25,8 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt; -#include &quot;libqos/ahci.h&quot;<br>
&gt; -#include &quot;libqos/pci-pc.h&quot;<br>
&gt; +#include &quot;ahci.h&quot;<br>
&gt; +#include &quot;pci-pc.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu-common.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/host-utils.h&quot;<br>
&gt; @@ -579,7 +579,7 @@ void ahci_write_fis(AHCIQState *ahci, AHCICommand =
*cmd)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* NCQ commands use exclusively 8 bit fields and n=
eeds no adjustment.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Only the count field needs to be adjusted =
for non-NCQ commands.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* The auxiliary FIS fields are defined per-c=
ommand and are not currently<br>
&gt; -=C2=A0 =C2=A0 =C2=A0* implemented in libqos/ahci.o, but may or may no=
t need to be flipped. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* implemented in ahci.o, but may or may not need =
to be flipped. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!cmd-&gt;props-&gt;ncq) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp.count =3D cpu_to_le16(tmp.count)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h<br>
&gt; index 44ab110..88835b6 100644<br>
&gt; --- a/tests/qtest/libqos/ahci.h<br>
&gt; +++ b/tests/qtest/libqos/ahci.h<br>
&gt; @@ -25,9 +25,9 @@<br>
&gt;=C2=A0 =C2=A0* THE SOFTWARE.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;libqos/libqos.h&quot;<br>
&gt; -#include &quot;libqos/pci.h&quot;<br>
&gt; -#include &quot;libqos/malloc-pc.h&quot;<br>
&gt; +#include &quot;libqos.h&quot;<br>
&gt; +#include &quot;pci.h&quot;<br>
&gt; +#include &quot;malloc-pc.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /*** Supplementary PCI Config Space IDs &amp; Masks ***/<br>
&gt;=C2=A0 #define PCI_DEVICE_ID_INTEL_Q35_AHCI=C2=A0 =C2=A0(0x2922)<br>
&gt; diff --git a/tests/qtest/libqos/arm-imx25-pdk-machine.c b/tests/qtest/=
libqos/arm-imx25-pdk-machine.c<br>
&gt; index 0da3f19..6692adf 100644<br>
&gt; --- a/tests/qtest/libqos/arm-imx25-pdk-machine.c<br>
&gt; +++ b/tests/qtest/libqos/arm-imx25-pdk-machine.c<br>
&gt; @@ -20,9 +20,9 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt; -#include &quot;libqos/malloc.h&quot;<br>
&gt; -#include &quot;libqos/qgraph.h&quot;<br>
&gt; -#include &quot;libqos/i2c.h&quot;<br>
&gt; +#include &quot;malloc.h&quot;<br>
&gt; +#include &quot;qgraph.h&quot;<br>
&gt; +#include &quot;i2c.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define ARM_PAGE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4=
096<br>
&gt;=C2=A0 #define IMX25_PDK_RAM_START=C2=A0 =C2=A0 =C2=A0 0x80000000<br>
&gt; diff --git a/tests/qtest/libqos/arm-n800-machine.c b/tests/qtest/libqo=
s/arm-n800-machine.c<br>
&gt; index 35f8207..ff2049c 100644<br>
&gt; --- a/tests/qtest/libqos/arm-n800-machine.c<br>
&gt; +++ b/tests/qtest/libqos/arm-n800-machine.c<br>
&gt; @@ -20,9 +20,9 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt; -#include &quot;libqos/malloc.h&quot;<br>
&gt; -#include &quot;libqos/qgraph.h&quot;<br>
&gt; -#include &quot;libqos/i2c.h&quot;<br>
&gt; +#include &quot;malloc.h&quot;<br>
&gt; +#include &quot;qgraph.h&quot;<br>
&gt; +#include &quot;i2c.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define ARM_PAGE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4=
096<br>
&gt;=C2=A0 #define N800_RAM_START=C2=A0 =C2=A0 =C2=A0 0x80000000<br>
&gt; diff --git a/tests/qtest/libqos/arm-raspi2-machine.c b/tests/qtest/lib=
qos/arm-raspi2-machine.c<br>
&gt; index 8480d80..35bb470 100644<br>
&gt; --- a/tests/qtest/libqos/arm-raspi2-machine.c<br>
&gt; +++ b/tests/qtest/libqos/arm-raspi2-machine.c<br>
&gt; @@ -19,8 +19,8 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt; -#include &quot;libqos/malloc.h&quot;<br>
&gt; -#include &quot;libqos/qgraph.h&quot;<br>
&gt; +#include &quot;malloc.h&quot;<br>
&gt; +#include &quot;qgraph.h&quot;<br>
&gt;=C2=A0 #include &quot;sdhci.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define ARM_PAGE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A04096<br>
&gt; diff --git a/tests/qtest/libqos/arm-sabrelite-machine.c b/tests/qtest/=
libqos/arm-sabrelite-machine.c<br>
&gt; index f6e403b..72425f0 100644<br>
&gt; --- a/tests/qtest/libqos/arm-sabrelite-machine.c<br>
&gt; +++ b/tests/qtest/libqos/arm-sabrelite-machine.c<br>
&gt; @@ -19,8 +19,8 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt; -#include &quot;libqos/malloc.h&quot;<br>
&gt; -#include &quot;libqos/qgraph.h&quot;<br>
&gt; +#include &quot;malloc.h&quot;<br>
&gt; +#include &quot;qgraph.h&quot;<br>
&gt;=C2=A0 #include &quot;sdhci.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define ARM_PAGE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4=
096<br>
&gt; diff --git a/tests/qtest/libqos/arm-smdkc210-machine.c b/tests/qtest/l=
ibqos/arm-smdkc210-machine.c<br>
&gt; index eebac7f..321b882 100644<br>
&gt; --- a/tests/qtest/libqos/arm-smdkc210-machine.c<br>
&gt; +++ b/tests/qtest/libqos/arm-smdkc210-machine.c<br>
&gt; @@ -19,8 +19,8 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt; -#include &quot;libqos/malloc.h&quot;<br>
&gt; -#include &quot;libqos/qgraph.h&quot;<br>
&gt; +#include &quot;malloc.h&quot;<br>
&gt; +#include &quot;qgraph.h&quot;<br>
&gt;=C2=A0 #include &quot;sdhci.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define ARM_PAGE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A04096<br>
&gt; diff --git a/tests/qtest/libqos/arm-virt-machine.c b/tests/qtest/libqo=
s/arm-virt-machine.c<br>
&gt; index 9316598..e0f5932 100644<br>
&gt; --- a/tests/qtest/libqos/arm-virt-machine.c<br>
&gt; +++ b/tests/qtest/libqos/arm-virt-machine.c<br>
&gt; @@ -19,9 +19,9 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt; -#include &quot;libqos/malloc.h&quot;<br>
&gt; -#include &quot;libqos/qgraph.h&quot;<br>
&gt; -#include &quot;libqos/virtio-mmio.h&quot;<br>
&gt; +#include &quot;malloc.h&quot;<br>
&gt; +#include &quot;qgraph.h&quot;<br>
&gt; +#include &quot;virtio-mmio.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define ARM_PAGE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A04096<br>
&gt;=C2=A0 #define VIRTIO_MMIO_BASE_ADDR=C2=A0 =C2=A0 =C2=A0 =C2=A00x0A003E=
00<br>
&gt; diff --git a/tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c b/tests/q=
test/libqos/arm-xilinx-zynq-a9-machine.c<br>
&gt; index 473acce..56e53c7 100644<br>
&gt; --- a/tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c<br>
&gt; +++ b/tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c<br>
&gt; @@ -19,8 +19,8 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt; -#include &quot;libqos/malloc.h&quot;<br>
&gt; -#include &quot;libqos/qgraph.h&quot;<br>
&gt; +#include &quot;malloc.h&quot;<br>
&gt; +#include &quot;qgraph.h&quot;<br>
&gt;=C2=A0 #include &quot;sdhci.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct QXilinxZynqA9Machine QXilinxZynqA9Machine;<br>
&gt; diff --git a/tests/qtest/libqos/e1000e.c b/tests/qtest/libqos/e1000e.c=
<br>
&gt; index e2927ed..a451f61 100644<br>
&gt; --- a/tests/qtest/libqos/e1000e.c<br>
&gt; +++ b/tests/qtest/libqos/e1000e.c<br>
&gt; @@ -18,13 +18,13 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt; -#include &quot;libqos/pci-pc.h&quot;<br>
&gt; +#include &quot;pci-pc.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/sockets.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/iov.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/bitops.h&quot;<br>
&gt; -#include &quot;libqos/malloc.h&quot;<br>
&gt; -#include &quot;libqos/qgraph.h&quot;<br>
&gt; +#include &quot;malloc.h&quot;<br>
&gt; +#include &quot;qgraph.h&quot;<br>
&gt;=C2=A0 #include &quot;e1000e.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define E1000E_IMS=C2=A0 =C2=A0 =C2=A0 (0x00d0)<br>
&gt; diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h=
<br>
&gt; index 35183b2..a22f5fd 100644<br>
&gt; --- a/tests/qtest/libqos/e1000e.h<br>
&gt; +++ b/tests/qtest/libqos/e1000e.h<br>
&gt; @@ -19,7 +19,7 @@<br>
&gt;=C2=A0 #ifndef QGRAPH_E1000E_H<br>
&gt;=C2=A0 #define QGRAPH_E1000E_H<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;libqos/qgraph.h&quot;<br>
&gt; +#include &quot;qgraph.h&quot;<br>
&gt;=C2=A0 #include &quot;pci.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define E1000E_RX0_MSG_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(0)<br>
&gt; diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c=
<br>
&gt; index 1f46258..6b8e1ba 100644<br>
&gt; --- a/tests/qtest/libqos/fw_cfg.c<br>
&gt; +++ b/tests/qtest/libqos/fw_cfg.c<br>
&gt; @@ -13,7 +13,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqos/fw_cfg.h&quot;<br>
&gt; +#include &quot;fw_cfg.h&quot;<br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/bswap.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/nvram/fw_cfg.h&quot;<br>
&gt; diff --git a/tests/qtest/libqos/i2c-imx.c b/tests/qtest/libqos/i2c-imx=
.c<br>
&gt; index f33ece5..8f9a7e3 100644<br>
&gt; --- a/tests/qtest/libqos/i2c-imx.c<br>
&gt; +++ b/tests/qtest/libqos/i2c-imx.c<br>
&gt; @@ -18,7 +18,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqos/i2c.h&quot;<br>
&gt; +#include &quot;i2c.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt; diff --git a/tests/qtest/libqos/i2c-omap.c b/tests/qtest/libqos/i2c-om=
ap.c<br>
&gt; index 9ae8214..eb4e453 100644<br>
&gt; --- a/tests/qtest/libqos/i2c-omap.c<br>
&gt; +++ b/tests/qtest/libqos/i2c-omap.c<br>
&gt; @@ -7,7 +7,7 @@<br>
&gt;=C2=A0 =C2=A0* See the COPYING file in the top-level directory.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqos/i2c.h&quot;<br>
&gt; +#include &quot;i2c.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/bswap.h&quot;<br>
&gt; diff --git a/tests/qtest/libqos/i2c.c b/tests/qtest/libqos/i2c.c<br>
&gt; index 38f800d..ade1bdb 100644<br>
&gt; --- a/tests/qtest/libqos/i2c.c<br>
&gt; +++ b/tests/qtest/libqos/i2c.c<br>
&gt; @@ -7,7 +7,7 @@<br>
&gt;=C2=A0 =C2=A0* See the COPYING file in the top-level directory.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqos/i2c.h&quot;<br>
&gt; +#include &quot;i2c.h&quot;<br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void qi2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t =
len)<br>
&gt; diff --git a/tests/qtest/libqos/i2c.h b/tests/qtest/libqos/i2c.h<br>
&gt; index c65f087..1341bac 100644<br>
&gt; --- a/tests/qtest/libqos/i2c.h<br>
&gt; +++ b/tests/qtest/libqos/i2c.h<br>
&gt; @@ -10,7 +10,7 @@<br>
&gt;=C2=A0 #define LIBQOS_I2C_H<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt; -#include &quot;libqos/qgraph.h&quot;<br>
&gt; +#include &quot;qgraph.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct I2CAdapter I2CAdapter;<br>
&gt;=C2=A0 struct I2CAdapter {<br>
&gt; diff --git a/tests/qtest/libqos/libqos-pc.c b/tests/qtest/libqos/libqo=
s-pc.c<br>
&gt; index d04abc5..db420a5 100644<br>
&gt; --- a/tests/qtest/libqos/libqos-pc.c<br>
&gt; +++ b/tests/qtest/libqos/libqos-pc.c<br>
&gt; @@ -1,7 +1,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqos/libqos-pc.h&quot;<br>
&gt; -#include &quot;libqos/malloc-pc.h&quot;<br>
&gt; -#include &quot;libqos/pci-pc.h&quot;<br>
&gt; +#include &quot;libqos-pc.h&quot;<br>
&gt; +#include &quot;malloc-pc.h&quot;<br>
&gt; +#include &quot;pci-pc.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static QOSOps qos_ops =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .alloc_init =3D pc_alloc_init,<br>
&gt; diff --git a/tests/qtest/libqos/libqos-pc.h b/tests/qtest/libqos/libqo=
s-pc.h<br>
&gt; index a0e4c45..1a9923e 100644<br>
&gt; --- a/tests/qtest/libqos/libqos-pc.h<br>
&gt; +++ b/tests/qtest/libqos/libqos-pc.h<br>
&gt; @@ -1,7 +1,7 @@<br>
&gt;=C2=A0 #ifndef LIBQOS_PC_H<br>
&gt;=C2=A0 #define LIBQOS_PC_H<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;libqos/libqos.h&quot;<br>
&gt; +#include &quot;libqos.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 QOSState *qtest_pc_vboot(const char *cmdline_fmt, va_list ap);<b=
r>
&gt;=C2=A0 QOSState *qtest_pc_boot(const char *cmdline_fmt, ...);<br>
&gt; diff --git a/tests/qtest/libqos/libqos-spapr.c b/tests/qtest/libqos/li=
bqos-spapr.c<br>
&gt; index 8766d54..db0e87b 100644<br>
&gt; --- a/tests/qtest/libqos/libqos-spapr.c<br>
&gt; +++ b/tests/qtest/libqos/libqos-spapr.c<br>
&gt; @@ -1,7 +1,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqos/libqos-spapr.h&quot;<br>
&gt; -#include &quot;libqos/malloc-spapr.h&quot;<br>
&gt; -#include &quot;libqos/pci-spapr.h&quot;<br>
&gt; +#include &quot;libqos-spapr.h&quot;<br>
&gt; +#include &quot;malloc-spapr.h&quot;<br>
&gt; +#include &quot;pci-spapr.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static QOSOps qos_ops =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .alloc_init =3D spapr_alloc_init,<br>
&gt; diff --git a/tests/qtest/libqos/libqos-spapr.h b/tests/qtest/libqos/li=
bqos-spapr.h<br>
&gt; index 49bd72d..c613389 100644<br>
&gt; --- a/tests/qtest/libqos/libqos-spapr.h<br>
&gt; +++ b/tests/qtest/libqos/libqos-spapr.h<br>
&gt; @@ -1,7 +1,7 @@<br>
&gt;=C2=A0 #ifndef LIBQOS_SPAPR_H<br>
&gt;=C2=A0 #define LIBQOS_SPAPR_H<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;libqos/libqos.h&quot;<br>
&gt; +#include &quot;libqos.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 QOSState *qtest_spapr_vboot(const char *cmdline_fmt, va_list ap)=
;<br>
&gt;=C2=A0 QOSState *qtest_spapr_boot(const char *cmdline_fmt, ...);<br>
&gt; diff --git a/tests/qtest/libqos/libqos.c b/tests/qtest/libqos/libqos.c=
<br>
&gt; index f229eb2..2251e86 100644<br>
&gt; --- a/tests/qtest/libqos/libqos.c<br>
&gt; +++ b/tests/qtest/libqos/libqos.c<br>
&gt; @@ -2,8 +2,8 @@<br>
&gt;=C2=A0 #include &lt;sys/wait.h&gt;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt; -#include &quot;libqos/libqos.h&quot;<br>
&gt; -#include &quot;libqos/pci.h&quot;<br>
&gt; +#include &quot;libqos.h&quot;<br>
&gt; +#include &quot;pci.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/qmp/qdict.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /*** Test Setup &amp; Teardown ***/<br>
&gt; diff --git a/tests/qtest/libqos/libqos.h b/tests/qtest/libqos/libqos.h=
<br>
&gt; index 8e971c2..e0b2bfe 100644<br>
&gt; --- a/tests/qtest/libqos/libqos.h<br>
&gt; +++ b/tests/qtest/libqos/libqos.h<br>
&gt; @@ -2,8 +2,8 @@<br>
&gt;=C2=A0 #define LIBQOS_H<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;libqtest.h&quot;<br>
&gt; -#include &quot;libqos/pci.h&quot;<br>
&gt; -#include &quot;libqos/malloc.h&quot;<br>
&gt; +#include &quot;pci.h&quot;<br>
&gt; +#include &quot;malloc.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct QOSState QOSState;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqos/libqtest.h<br=
>
&gt; similarity index 100%<br>
&gt; rename from tests/qtest/libqtest.h<br>
&gt; rename to tests/qtest/libqos/libqtest.h<br>
&gt; diff --git a/tests/qtest/libqos/malloc-pc.c b/tests/qtest/libqos/mallo=
c-pc.c<br>
&gt; index 6f92ce4..16ff960 100644<br>
&gt; --- a/tests/qtest/libqos/malloc-pc.c<br>
&gt; +++ b/tests/qtest/libqos/malloc-pc.c<br>
&gt; @@ -11,8 +11,8 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqos/malloc-pc.h&quot;<br>
&gt; -#include &quot;libqos/fw_cfg.h&quot;<br>
&gt; +#include &quot;malloc-pc.h&quot;<br>
&gt; +#include &quot;fw_cfg.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;standard-headers/linux/qemu_fw_cfg.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/libqos/malloc-pc.h b/tests/qtest/libqos/mallo=
c-pc.h<br>
&gt; index 21e75ae..d8d7985 100644<br>
&gt; --- a/tests/qtest/libqos/malloc-pc.h<br>
&gt; +++ b/tests/qtest/libqos/malloc-pc.h<br>
&gt; @@ -13,7 +13,7 @@<br>
&gt;=C2=A0 #ifndef LIBQOS_MALLOC_PC_H<br>
&gt;=C2=A0 #define LIBQOS_MALLOC_PC_H<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;libqos/malloc.h&quot;<br>
&gt; +#include &quot;malloc.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void pc_alloc_init(QGuestAllocator *s, QTestState *qts, QAllocOp=
ts flags);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/libqos/malloc-spapr.c b/tests/qtest/libqos/ma=
lloc-spapr.c<br>
&gt; index 2a6b7e3..84862e4 100644<br>
&gt; --- a/tests/qtest/libqos/malloc-spapr.c<br>
&gt; +++ b/tests/qtest/libqos/malloc-spapr.c<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqos/malloc-spapr.h&quot;<br>
&gt; +#include &quot;malloc-spapr.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu-common.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/libqos/malloc-spapr.h b/tests/qtest/libqos/ma=
lloc-spapr.h<br>
&gt; index e5fe9bf..f99572f 100644<br>
&gt; --- a/tests/qtest/libqos/malloc-spapr.h<br>
&gt; +++ b/tests/qtest/libqos/malloc-spapr.h<br>
&gt; @@ -8,7 +8,7 @@<br>
&gt;=C2=A0 #ifndef LIBQOS_MALLOC_SPAPR_H<br>
&gt;=C2=A0 #define LIBQOS_MALLOC_SPAPR_H<br>
&gt;=C2=A0 <br>
&gt; -#include &quot;libqos/malloc.h&quot;<br>
&gt; +#include &quot;malloc.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void spapr_alloc_init(QGuestAllocator *s, QTestState *qts, QAllo=
cOpts flags);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/libqos/malloc.c b/tests/qtest/libqos/malloc.c=
<br>
&gt; index 615422a..f708b01 100644<br>
&gt; --- a/tests/qtest/libqos/malloc.c<br>
&gt; +++ b/tests/qtest/libqos/malloc.c<br>
&gt; @@ -11,7 +11,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &quot;libqos/malloc.h&quot;<br>
&gt; +#include &quot;malloc.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu-common.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/host-utils.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson=
.build<br>
&gt; new file mode 100644<br>
&gt; index 0000000..e39e779<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/qtest/libqos/meson.build<br>
&gt; @@ -0,0 +1,57 @@<br>
&gt; +libqos =3D static_library(&#39;libqos&#39;,<br>
&gt; +=C2=A0 files(&#39;../libqtest.c&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;qgraph.c&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;qos_external.c&#39;,<br>
&gt; +=C2=A0 </blockquote></div>

--00000000000052bed505ac4db24d--


