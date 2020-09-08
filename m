Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EDFC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 13:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C159922597
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 13:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdfJsDnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C159922597
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFdGY-0005f4-VG
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 09:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFdFl-0004lq-Iu
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 09:01:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFdFj-0003zA-5S
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 09:01:41 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so633515wrw.11
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8FyJoLHgMTM2n4ZDJTEcV+3rqYOjlTykXAEfWTsNFOI=;
 b=vdfJsDndoXyGEwe/FPoXB0LORIBlX0LIHJAsxgUVM0KZzGcmEi7e7LiT/bHZxs2/nQ
 /kPIl7L8lsliqBabdcgtp2bUoCBmn4Z+cqt8VCfwo9jE4tbZ8eCvKVGE8uVhR4NcPHEf
 DHOBUYsymmk37Sr0lQNqKIy7aRy6da3n04fLlbYxkb0wvM2ew3n9pP+641s0oT1r2mqE
 ZMFojpFWUviM+NZ9vsA18hYb58GPjk8knzE6b7zcwUQekzttWkHgyp2nhKbKWnZpDq7J
 /SNkqEohV+5PBGCOmcwALkBe56U6ZvY3OVvSbeA4P6Y2TQKj++OSvhJXXRiQ25cs4T7y
 F6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8FyJoLHgMTM2n4ZDJTEcV+3rqYOjlTykXAEfWTsNFOI=;
 b=XQRmQukdbd051nK+1+M3M1/pct67PiWkN4HrCVjm2kGmhiLRHMcpTWP2S2gDxVCy08
 QaXFZm5xvKjlvGRpZ1ZpQ0tvDtK4se+Hy3nUwU4ai4+CqNkgxT5NRG8TpDJlQlkFki/I
 /QNwhW2WF2uB7kLTqreyuwN1MNjM7IJxVuB5T4Tqthr/QVa+4JAHWS72aTDKGAjXDB3H
 barm0RSNJmTMX1UnpNvMEVXYQOrAqgILIDCouvzYVlMYhBDf1kbxdBAO56J0jXYm6Hgc
 aOUMagvXTjSpoAObW4n+6mW+9hxdxLLOw6FgM7C41ZIFzPAyhkx7pyCOrWuJU+rZ//YN
 6yAA==
X-Gm-Message-State: AOAM533ri5Pu9y+1Ej9nuGNoZ5mU+nKK4iqyYv+LolhwEnQdtaaMloz8
 1IGcdB/y2jWBl0dkzmKR74pvAQ==
X-Google-Smtp-Source: ABdhPJwZSKExjkxfQGOprJ2eI5m2ejRko0x7C5hx9/olY67d6sO826vfoWTBAwWI1XQtW+L6cyVnlQ==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr26425131wrm.355.1599570088724; 
 Tue, 08 Sep 2020 06:01:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n4sm34086074wrp.61.2020.09.08.06.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 06:01:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 685791FF7E;
 Tue,  8 Sep 2020 14:01:24 +0100 (BST)
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903463379.28509.561479052940546124.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3 15/15] tests/acceptance: add reverse debugging test
In-reply-to: <159903463379.28509.561479052940546124.stgit@pasha-ThinkPad-X280>
Date: Tue, 08 Sep 2020 14:01:24 +0100
Message-ID: <87tuw8pgm3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:

> From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
>
> This is a test for GDB reverse debugging commands: reverse step and rever=
se continue.
> Every test in this suite consists of two phases: record and replay.
> Recording saves the execution of some instructions and makes an initial
> VM snapshot to allow reverse execution.
> Replay saves the order of the first instructions and then checks that they
> are executed backwards in the correct order.
> After that the execution is replayed to the end, and reverse continue
> command is checked by setting several breakpoints, and asserting
> that the execution is stopped at the last of them.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> ---
>  MAINTAINERS                           |    1=20
>  tests/acceptance/reverse_debugging.py |  203 +++++++++++++++++++++++++++=
++++++
>  2 files changed, 204 insertions(+)
>  create mode 100644 tests/acceptance/reverse_debugging.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e49af700c9..76450f1bdf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2644,6 +2644,7 @@ F: include/sysemu/replay.h
>  F: docs/replay.txt
>  F: stubs/replay.c
>  F: tests/acceptance/replay_kernel.py
> +F: tests/acceptance/reverse_debugging.py
>  F: qapi/replay.json
>=20=20
>  IOVA Tree
> diff --git a/tests/acceptance/reverse_debugging.py b/tests/acceptance/rev=
erse_debugging.py
> new file mode 100644
> index 0000000000..dda42e1c1a
> --- /dev/null
> +++ b/tests/acceptance/reverse_debugging.py
> @@ -0,0 +1,203 @@
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
> +    After that the execution is replayed to the end, and reverse continue
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

These seem a little hacky. Can't we issue normal gdb commands. In the
SVE tests I use:

    frame =3D gdb.selected_frame()
    for i in range(0, 32):
        rname =3D "z%d" % (i)
        zreg =3D frame.read_register(rname)

which works with the symbolic name and doesn't need endian tricks to
sort it out.

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

Hmm so these are packet commands? Can't we access via the python API? Clebb=
er?

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
> +        logger.info('seeking to the end (icount %s)' % (last_icount - 1))
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
> +        # reverse continue - will return after stopping at the breakpoint
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

Quibbles aside it's excellent to have a test that exercises the
functionality.

--=20
Alex Benn=C3=A9e

