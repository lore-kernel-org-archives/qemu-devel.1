Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372B0C74A36
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 01:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A0720844
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 01:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JriJHo/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A0720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlOIR-0007QZ-C7
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 21:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45666)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hlOHr-0006c7-75
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hlOHp-0004WD-HA
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:54:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hlOHp-0004Up-83
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:54:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id r1so4391060wrl.7
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 18:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/PMUVmrY2ARplVL3XfABugpLB3GvXOo7X/tk3K246JQ=;
 b=JriJHo/JZz4qvz6USRy5j5mGgTF5uQGUQmMt1kaVN6vLrBThlo3BYji9NU1mDyqGhM
 qJT7ZFQ8kpFK4jqPpTA7RnPSgoSTQsv+8O6Hp96NTqDz2j9GC6cecIDeJ6Olvy+Yj9eM
 1ImdEUA3AGUEFa3MqEOUORJQvffLV7LTH2czzYTX8z6b/Nbuytre+1MImPvVHf4urZmm
 WUmDJYx8DFco1DclCrnJL3WZLIV0MPS/LwSu8MfDlD6VBAgku5noB/j4YYHjiASGxREs
 HdOc+0D0ai8dg+4v9E7y4WUzG1sk47gaUoZXy/J4/y4AhGzlxA+DYS7FIfXNlxHH3Bo7
 TRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/PMUVmrY2ARplVL3XfABugpLB3GvXOo7X/tk3K246JQ=;
 b=WUl1NpkxVXxXZ+4KBY8iptVLlRgtRTvBKdjMg3paNWI4xT5aXEbGJL7f9V8hkN6ZRQ
 5dfWDIoe4+khm5WEF9xvbTVTiq0dFX9JzQJLbILKv+C32vVsnZ6v6c3eTu6pC/nQ5+Ql
 oLFkPYmlsBmFb1GoCQOSpOjhrBta65scyULlI1PaQMReOfCV5cLsVGIgpkDNI1XGjg4d
 ONbIJYEsw4PuodWkcWLNrOy5Z6Ni4RaJT1Iku5YvcX4T3HwA6Vi8dUQeeT5s75LC3gED
 ONXQIKfXKqcfhIDk9jgB7qyfDHAqKq7vJPWN9h7QVeK324SxAqfqQzXghYYJzXIL/2YZ
 fA9g==
X-Gm-Message-State: APjAAAWoz9/zVAHZsNmPOiRUZ0nnHH9OzNAaL9KZvNlX8MqUNWPqt9ec
 W31ZfRTYqCh1PcwFgMgaZC7SJG+IdkezPgFz0jgAUg==
X-Google-Smtp-Source: APXvYqy8Y8FhBsSPkVtTabs9pMRgRl+7o5RnarZdzIqAYODHWGdgFb0raXt3nOcPmIp2zoJlM/X3+P6nRGhjl4t/Ohk=
X-Received: by 2002:adf:de90:: with SMTP id w16mr655540wrl.217.1562810055423; 
 Wed, 10 Jul 2019 18:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <1562781026-27570-1-git-send-email-chihmin.chao@sifive.com>
 <CAKmqyKMHxX6dhopB8fxH31HGAQ3y-EvL+09jNvp3xMS-dxirQA@mail.gmail.com>
In-Reply-To: <CAKmqyKMHxX6dhopB8fxH31HGAQ3y-EvL+09jNvp3xMS-dxirQA@mail.gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Thu, 11 Jul 2019 09:54:04 +0800
Message-ID: <CAEiOBXUZ51h165GMEJEyDhToD2op7Z6S86B+Wnt9taZ3Q2iGfA@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] tests/boot_linux_console: add a test for
 riscv64 + virt
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Caio Carrara <ccarrara@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 11, 2019 at 2:53 AM Alistair Francis <alistair23@gmail.com>
wrote:

> On Wed, Jul 10, 2019 at 10:51 AM Chih-Min Chao <chihmin.chao@sifive.com>
> wrote:
> >
> > Similar to the mips + malta test, it boots a Linux kernel on a virt
> > board and verify the serial is working.  Also, it relies on the serial
> > device set by the machine itself.
> >
> > If riscv64 is a target being built, "make check-acceptance" will
> > automatically include this test by the use of the "arch:riscv64" tags.
> >
> > Alternatively, this test can be run using:
> >
> >   $ avocado run -t arch:riscv64 tests/acceptance
> >
> > Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
>
> Awesome! Thanks for the test case. This will help a lot with RISC-V
> regressions in QEMU.
>
> > ---
> >  tests/acceptance/boot_linux_console.py | 40
> ++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> > index 3215950..bbc6b06 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -354,3 +354,43 @@ class BootLinuxConsole(Test):
> >          self.vm.launch()
> >          console_pattern = 'Kernel command line: %s' %
> kernel_command_line
> >          self.wait_for_console_pattern(console_pattern)
> > +
> > +    def test_riscv64_virt(self):
> > +        """
> > +        :avocado: tags=arch:riscv64
> > +        :avocado: tags=machine:virt
> > +        """
> > +
> > +        kernel_url = ('https://github.com/chihminchao/test-binary/raw/'
>
> These images need to be built with a standard build flow. Having them
> built from SiFive's custom scripts will make debugging problems in the
> future impossible. I'm also a little worried here about GPL
> violations, I'm not sure if it's enough to just point to a script SHA
> to meet GPL source disclosure. I know companies have huge headaches
> meeting GPL requirements so this seems too easy.
>

   I am not very familiar with this kind of binary and source license
conflict.
   Is it ok if I write a simple script with BSD license to build  kernel
and image from sifive's linux/buildroot repo and commit the script to my
test-binary repo ?

>
> > +
> '0b7787305d9e40815c05a805266cc74ff356239e/qemu/riscv64/'
> > +                      'bbl_w_kernel.gz')
>
> Don't use BBL, most people use OpenSBI now which is what we should be
> testing with.
>
   I will try to move to OpenSBI in next version. My environment is based
freedom-u-sdk and It still relays  on BBL. So ..:P

>
> > +        kernel_hash = 'c7f6cc7967975ad42dc61ee0535db01c9cbd0968'
> > +        kernel_path_gz = self.fetch_asset(kernel_url,
> asset_hash=kernel_hash)
> > +        kernel_path = self.workdir + "bbl_w_kernel"
> > +
> > +        with gzip.open(kernel_path_gz, 'rb') as f_in:
> > +            with open(kernel_path, 'wb') as f_out:
> > +                shutil.copyfileobj(f_in, f_out)
> > +
> > +        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
> > +                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
> > +                      'riscv64/rootfs.cpio.gz')
>
> Same comment about build tools.
>
>
> Alistair
>
>     Got it

> > +        initrd_hash = 'f4867d263754961b6f626cdcdc0cb334c47e3b49'
> > +        initrd_path = self.fetch_asset(initrd_url,
> asset_hash=initrd_hash)
> > +
> > +        self.vm.set_machine('virt')
> > +        self.vm.set_console()
> > +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
> > +                               + 'console=ttyS0 noreboot')
> > +        self.vm.add_args('-kernel', kernel_path,
> > +                         '-initrd', initrd_path,
> > +                         '-append', kernel_command_line)
> > +        self.vm.launch()
> > +        self.wait_for_console_pattern('Boot successful.')
> > +
> > +        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
> > +                                               'isa')
> > +        self.exec_command_and_wait_for_pattern('uname -a',
> > +                                               'sifive')
> > +        self.exec_command_and_wait_for_pattern('reboot',
> > +                                               'reboot: Restarting
> system')
> > --
> > 2.7.4
> >
> >
>
