Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B536AC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FDB2083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAjNVrQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FDB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNNwB-0004pm-JQ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kNNux-0004At-Li
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kNNuu-00011c-Nc
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:16:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601417770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hp4CSoJMVHb1EgUzbVRJcrxMYmAlwVkwmwjWTpt4o3g=;
 b=SAjNVrQlbPDGYviSryUmcthPbfW0n7HFza1D3hAmM96wIM/6xOzkbOqLdA6kp8yOXd+QzU
 Rj57mAyMjiO2Tth1jAMNYdDf4mXHRS550ogjn8l5LSpgZRnHX+7SuaABhq9hyifIqH9uRW
 jLbzGXnSAI66IRyBYE2ChWBfo8Jn8oQ=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-kZw_PkG7OJeDeaSPdnB4QQ-1; Tue, 29 Sep 2020 18:16:05 -0400
X-MC-Unique: kZw_PkG7OJeDeaSPdnB4QQ-1
Received: by mail-vs1-f72.google.com with SMTP id u12so1895284vsh.18
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hp4CSoJMVHb1EgUzbVRJcrxMYmAlwVkwmwjWTpt4o3g=;
 b=M6NbCEJQbwW44bkavydqdebeAJY1O4uafBnIle0CVC2YCFFVF9JpSae1ZWY5L2q8ZO
 iwUyydXW77aRd0Gm7RzmJKYiT7nvyS5Zpr+MFMfZJJwDq9G1FhMQkIcjlEBwMVAlGdAr
 F6JVt3Yb2+cZ16Lky5rVf21ajWbOi6aFLzBvxwX+x3uF2U4XEhOY7m6gKd9AIQsmE0z4
 wPLJiYjFP7JAlSwwE4GYPPlEIdHzdci8z49CbpxN8/lfQgwmrjqTQICnYhf30ym1F03f
 CqCLl+RcOp5yXVIBaMIoMxQqmzipt0CckpJGRT447Ax6G7jEkOcJjGnLQ198KcfkzYl7
 vDfw==
X-Gm-Message-State: AOAM532L7EhwydqFTr1u7CBtBaabv7xAJS3A0hBqjHpqHavDi/eW1cMq
 B/e94w7YUL+wz2jYx1UeVjxlJZC5hUOAJVWQlii488CQQlS0rzcT38jOTSmRH6UIIDFb/b4NfgP
 OfkVArIWs1lNj4iYN4I6IrUqBddb+T70=
X-Received: by 2002:a67:f512:: with SMTP id u18mr4260224vsn.50.1601417765247; 
 Tue, 29 Sep 2020 15:16:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiOI3YX+nLR+2QHNrBULjGqtmToDEzDVBMDRs9YPgK2Ymoit0y4uFr6y/lJioe5uwtJvV+WP1AwAy0e9CBHNU=
X-Received: by 2002:a67:f512:: with SMTP id u18mr4260215vsn.50.1601417764944; 
 Tue, 29 Sep 2020 15:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <160137726426.31007.12061315974029139983.stgit@pasha-ThinkPad-X280>
 <160137734578.31007.14303987304996883900.stgit@pasha-ThinkPad-X280>
In-Reply-To: <160137734578.31007.14303987304996883900.stgit@pasha-ThinkPad-X280>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Tue, 29 Sep 2020 19:15:54 -0300
Message-ID: <CAKJDGDav-v10wTUOZ_ea0WOHzF55tcQcFQWZBhR92Qatc=t9vg@mail.gmail.com>
Subject: Re: [PATCH v6 14/14] tests/acceptance: add reverse debugging test
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wrampazz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa Junior <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Philippe Mathieu Daude <philmd@redhat.com>,
 zhiwei_liu@c-sky.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 8:02 AM Pavel Dovgalyuk
<pavel.dovgalyuk@ispras.ru> wrote:
>
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
>
> This is a test for GDB reverse debugging commands: reverse step and rever=
se continue.
> Every test in this suite consists of two phases: record and replay.
> Recording saves the execution of some instructions and makes an initial
> VM snapshot to allow reverse execution.
> Replay saves the order of the first instructions and then checks that the=
y
> are executed backwards in the correct order.
> After that the execution is replayed to the end, and reverse continue
> command is checked by setting several breakpoints, and asserting
> that the execution is stopped at the last of them.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> --
>
> v5:
>  - disabled (as some other tests) when running on gitlab
>    due to the unidentified timeout problem
> ---
>  MAINTAINERS                           |    1
>  tests/acceptance/reverse_debugging.py |  208 +++++++++++++++++++++++++++=
++++++
>  2 files changed, 209 insertions(+)
>  create mode 100644 tests/acceptance/reverse_debugging.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7dcecb8653..b2cafc36ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2672,6 +2672,7 @@ F: include/sysemu/replay.h
>  F: docs/replay.txt
>  F: stubs/replay.c
>  F: tests/acceptance/replay_kernel.py
> +F: tests/acceptance/reverse_debugging.py
>  F: qapi/replay.json
>
>  IOVA Tree
> diff --git a/tests/acceptance/reverse_debugging.py b/tests/acceptance/rev=
erse_debugging.py
> new file mode 100644
> index 0000000000..b72fdf6cdc
> --- /dev/null
> +++ b/tests/acceptance/reverse_debugging.py
> @@ -0,0 +1,208 @@
> +# Reverse debugging test
> +#
> +# Copyright (c) 2020 ISP RAS
> +#
> +# Author:
> +#  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +import os
> +import logging
> +
> +from avocado import skipIf
> +from avocado_qemu import BUILD_DIR
> +from avocado.utils import gdb
> +from avocado.utils import process
> +from avocado.utils.path import find_command
> +from boot_linux_console import LinuxKernelTest
> +
> +class ReverseDebugging(LinuxKernelTest):
> +    """
> +    Test GDB reverse debugging commands: reverse step and reverse contin=
ue.
> +    Recording saves the execution of some instructions and makes an init=
ial
> +    VM snapshot to allow reverse execution.
> +    Replay saves the order of the first instructions and then checks tha=
t they
> +    are executed backwards in the correct order.
> +    After that the execution is replayed to the end, and reverse continu=
e
> +    command is checked by setting several breakpoints, and asserting
> +    that the execution is stopped at the last of them.
> +    """
> +
> +    timeout =3D 10
> +    STEPS =3D 10
> +    endian_is_le =3D True
> +
> +    def run_vm(self, record, shift, args, replay_path, image_path):
> +        logger =3D logging.getLogger('replay')
> +        vm =3D self.get_vm()
> +        vm.set_console()
> +        if record:
> +            logger.info('recording the execution...')
> +            mode =3D 'record'
> +        else:
> +            logger.info('replaying the execution...')
> +            mode =3D 'replay'
> +            vm.add_args('-s', '-S')
> +        vm.add_args('-icount', 'shift=3D%s,rr=3D%s,rrfile=3D%s,rrsnapsho=
t=3Dinit' %
> +                    (shift, mode, replay_path),
> +                    '-net', 'none')
> +        vm.add_args('-drive', 'file=3D%s,if=3Dnone' % image_path)
> +        if args:
> +            vm.add_args(*args)
> +        vm.launch()
> +        return vm
> +
> +    @staticmethod
> +    def get_reg_le(g, reg):
> +        res =3D g.cmd(b'p%x' % reg)
> +        num =3D 0
> +        for i in range(len(res))[-2::-2]:
> +            num =3D 0x100 * num + int(res[i:i + 2], 16)
> +        return num
> +
> +    @staticmethod
> +    def get_reg_be(g, reg):
> +        res =3D g.cmd(b'p%x' % reg)
> +        return int(res, 16)
> +
> +    def get_reg(self, g, reg):
> +        # value may be encoded in BE or LE order
> +        if self.endian_is_le:
> +            return self.get_reg_le(g, reg)
> +        else:
> +            return self.get_reg_be(g, reg)
> +
> +    def get_pc(self, g):
> +        return self.get_reg(g, self.REG_PC)
> +
> +    def check_pc(self, g, addr):
> +        pc =3D self.get_pc(g)
> +        if pc !=3D addr:
> +            self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))
> +
> +    @staticmethod
> +    def gdb_step(g):
> +        g.cmd(b's', b'T05thread:01;')
> +
> +    @staticmethod
> +    def gdb_bstep(g):
> +        g.cmd(b'bs', b'T05thread:01;')
> +
> +    @staticmethod
> +    def vm_get_icount(vm):
> +        return vm.qmp('query-replay')['return']['icount']
> +
> +    def reverse_debugging(self, shift=3D7, args=3DNone):
> +        logger =3D logging.getLogger('replay')
> +
> +        # create qcow2 for snapshots
> +        logger.info('creating qcow2 image for VM snapshots')
> +        image_path =3D os.path.join(self.workdir, 'disk.qcow2')
> +        qemu_img =3D os.path.join(BUILD_DIR, 'qemu-img')
> +        if not os.path.exists(qemu_img):
> +            qemu_img =3D find_command('qemu-img', False)
> +        if qemu_img is False:
> +            self.cancel('Could not find "qemu-img", which is required to=
 '
> +                        'create the temporary qcow2 image')
> +        cmd =3D '%s create -f qcow2 %s 128M' % (qemu_img, image_path)
> +        process.run(cmd)
> +
> +        replay_path =3D os.path.join(self.workdir, 'replay.bin')
> +
> +        # record the log
> +        vm =3D self.run_vm(True, shift, args, replay_path, image_path)
> +        while self.vm_get_icount(vm) <=3D self.STEPS:
> +            pass
> +        last_icount =3D self.vm_get_icount(vm)
> +        vm.shutdown()
> +
> +        logger.info("recorded log with %s+ steps" % last_icount)
> +
> +        # replay and run debug commands
> +        vm =3D self.run_vm(False, shift, args, replay_path, image_path)
> +        logger.info('connecting to gdbstub')
> +        g =3D gdb.GDBRemote('127.0.0.1', 1234, False, False)
> +        g.connect()
> +        r =3D g.cmd(b'qSupported')
> +        if b'qXfer:features:read+' in r:
> +            g.cmd(b'qXfer:features:read:target.xml:0,ffb')
> +        if b'ReverseStep+' not in r:
> +            self.fail('Reverse step is not supported by QEMU')
> +        if b'ReverseContinue+' not in r:
> +            self.fail('Reverse continue is not supported by QEMU')
> +
> +        logger.info('stepping forward')
> +        steps =3D []
> +        # record first instruction addresses
> +        for _ in range(self.STEPS):
> +            pc =3D self.get_pc(g)
> +            logger.info('saving position %x' % pc)
> +            steps.append(pc)
> +            self.gdb_step(g)
> +
> +        # visit the recorded instruction in reverse order
> +        logger.info('stepping backward')
> +        for addr in steps[::-1]:
> +            self.gdb_bstep(g)
> +            self.check_pc(g, addr)
> +            logger.info('found position %x' % addr)
> +
> +        logger.info('seeking to the end (icount %s)' % (last_icount - 1)=
)
> +        vm.qmp('replay-break', icount=3Dlast_icount - 1)
> +        # continue - will return after pausing
> +        g.cmd(b'c', b'T02thread:01;')
> +
> +        logger.info('setting breakpoints')
> +        for addr in steps:
> +            # hardware breakpoint at addr with len=3D1
> +            g.cmd(b'Z1,%x,1' % addr, b'OK')
> +
> +        logger.info('running reverse continue to reach %x' % steps[-1])
> +        # reverse continue - will return after stopping at the breakpoin=
t
> +        g.cmd(b'bc', b'T05thread:01;')
> +
> +        # assume that none of the first instructions is executed again
> +        # breaking the order of the breakpoints
> +        self.check_pc(g, steps[-1])
> +        logger.info('successfully reached %x' % steps[-1])
> +
> +        logger.info('exitting gdb and qemu')
> +        vm.shutdown()
> +
> +class ReverseDebugging_X86_64(ReverseDebugging):
> +    REG_PC =3D 0x10
> +    REG_CS =3D 0x12
> +    def get_pc(self, g):
> +        return self.get_reg_le(g, self.REG_PC) \
> +            + self.get_reg_le(g, self.REG_CS) * 0x10
> +
> +    # unidentified gitlab timeout problem
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    def test_x86_64_pc(self):
> +        """
> +        :avocado: tags=3Darch:x86_64
> +        :avocado: tags=3Dmachine:pc
> +        """
> +        # start with BIOS only
> +        self.reverse_debugging()
> +
> +class ReverseDebugging_AArch64(ReverseDebugging):
> +    REG_PC =3D 32
> +
> +    # unidentified gitlab timeout problem
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    def test_aarch64_virt(self):
> +        """
> +        :avocado: tags=3Darch:aarch64
> +        :avocado: tags=3Dmachine:virt
> +        :avocado: tags=3Dcpu:cortex-a53
> +        """
> +        kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/=
fedora'
> +                      '/linux/releases/29/Everything/aarch64/os/images/p=
xeboot'
> +                      '/vmlinuz')
> +        kernel_hash =3D '8c73e469fc6ea06a58dc83a628fc695b693b8493'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> +
> +        self.reverse_debugging(
> +            args=3D('-kernel', kernel_path, '-cpu', 'cortex-a53'))
>

The code looks good to me!

Reviewed-by: Willian Rampazzo <willianr@redhat.com>


