Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A613C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 19:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283E3207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 19:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOy+4zYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283E3207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdfel-0004mL-AA
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 15:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1jdfdU-0003ol-OV
 for qemu-devel@nongnu.org; Tue, 26 May 2020 15:53:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39976
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1jdfdS-00015u-CB
 for qemu-devel@nongnu.org; Tue, 26 May 2020 15:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590522791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3QV6QIRY0HpZCj0NyI4KZPgFhKodoMOAGQdG9LhuX4=;
 b=DOy+4zYXh1iAlP496/IkyBDCAL5fnc/SHGFAqwlF4WVnBcFbWAyn0MjmtRkMBtaZ+DfOX1
 SIKihf8C7l4cir7nC/YtSXjijcmIWceMotr8aBoE84W8Qn0T1SB/04jD5+mzPtUAvmXqVG
 q+ZS5mrqnLaqAcTqfk2kv6uB+vqQO50=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453--OyQBJx0PUOvNVlDPnq0qA-1; Tue, 26 May 2020 15:53:06 -0400
X-MC-Unique: -OyQBJx0PUOvNVlDPnq0qA-1
Received: by mail-vk1-f198.google.com with SMTP id y68so8407658vkd.14
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 12:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X3QV6QIRY0HpZCj0NyI4KZPgFhKodoMOAGQdG9LhuX4=;
 b=khsWGc3u9x+OG73omdHfuXi+HXZEGpYEzyQ5+Ge5RuXOmuzIXkExWKzMuOUcsHp4Ns
 786jrzCqg1ZEj9UR81O/NUO8EJwjmIOp6TitTVsWeOJliHPw9glxtpfwx+zV7Rg1Y49d
 vGmrkTNudDiodumVHjSizgVq2gxlmNLEQuWJiBP6XCINrYNZJ63n/W0Mj+iAGnifPgCm
 32HTwEvPB78w5m9uDEd7GKEgGjlGCEwnoPthg/R7kVVlApA3ysDRVv/bm/Eowu9WiqSr
 gxVfbig0IumTLmQKhgZYAiVGUvdcMY4aBBhnPLDGRH7lBYwIRxi/f/zIbSy7Kv6d8Jp6
 aYHA==
X-Gm-Message-State: AOAM531tYg+ATP4b1X2HYKHR4Hyd2n5Y76eKsymu4g1Rfaj7j1PwJPca
 M06o/bsFxbr5zBEnvvLvb/8uXGhDTedUeQqDUM6rfNZN0pn5PPYD4nnjBUV9ntvnyStGhh8wBjY
 1RJFyJNtw8y/n45zqu4kg1NNiFVCnBSk=
X-Received: by 2002:a67:7d47:: with SMTP id y68mr2311299vsc.145.1590522786096; 
 Tue, 26 May 2020 12:53:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9su+Dhq/NlqBxxjtsGAfyIRfPiUJtUQsLplBZXqJXWe2Y1aLB0XSFxIluAZxPdLznYKGJt5qkDz/hewg7BAg=
X-Received: by 2002:a67:7d47:: with SMTP id y68mr2311281vsc.145.1590522785792; 
 Tue, 26 May 2020 12:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <159040554265.2615.8993443700754452381.stgit@pasha-ThinkPad-X280>
 <159040559302.2615.18392869399102145442.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159040559302.2615.18392869399102145442.stgit@pasha-ThinkPad-X280>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Tue, 26 May 2020 16:52:54 -0300
Message-ID: <CAKJDGDaTn92DbHnJW-qSU_xx4ZRY0my1ofKfeSkWD1KvDOwY6Q@mail.gmail.com>
Subject: Re: [PATCH 9/9] tests/acceptance: Linux boot test for record/replay
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, Cleber Rosa Junior <crosa@redhat.com>,
 pbonzini@redhat.com, Philippe Mathieu Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 8:30 AM Pavel Dovgalyuk
<Pavel.Dovgaluk@gmail.com> wrote:
>
> This patch adds a test for record/replay, which boots Linux
> image from the disk and interacts with the network.
> The idea and code of this test is borrowed from boot_linux.py
> However, currently record/replay works only for x86_64,
> therefore other tests were excluded.
>
> Each test consists of the following phases:
>  - downloading the disk image
>  - recording the execution
>  - replaying the execution
>
> Replay does not validates the output, but waits until QEMU
> finishes the execution. This is reasonable, because
> QEMU usually hangs when replay goes wrong.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  MAINTAINERS                      |    1
>  tests/acceptance/replay_linux.py |  140 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 141 insertions(+)
>  create mode 100644 tests/acceptance/replay_linux.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9a9ce4f66..97f066a9b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2498,6 +2498,7 @@ F: include/sysemu/replay.h
>  F: docs/replay.txt
>  F: stubs/replay.c
>  F: tests/acceptance/replay_kernel.py
> +F: tests/acceptance/replay_linux.py
>
>  IOVA Tree
>  M: Peter Xu <peterx@redhat.com>
> diff --git a/tests/acceptance/replay_linux.py b/tests/acceptance/replay_linux.py
> new file mode 100644
> index 0000000000..08eedb23ef
> --- /dev/null
> +++ b/tests/acceptance/replay_linux.py
> @@ -0,0 +1,140 @@
> +# Record/replay test that boots a complete Linux system via a cloud image
> +#
> +# Copyright (c) 2020 ISP RAS
> +#
> +# Author:
> +#  Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +
> +from avocado_qemu import Test, BUILD_DIR
> +
> +from avocado.utils import cloudinit
> +from avocado.utils import network
> +from avocado.utils import vmimage
> +from avocado.utils import datadrainer
> +from avocado.utils.path import find_command
> +
> +class ReplayLinux(Test):
> +    """
> +    Boots a Linux system, checking for a successful initialization
> +    """
> +
> +    timeout = 1800
> +    chksum = None
> +    hdd = 'ide-hd'
> +    cd = 'ide-cd'
> +    bus = ''
> +
> +    def setUp(self):
> +        super(ReplayLinux, self).setUp()
> +        self.prepare_boot()
> +        self.prepare_cloudinit()
> +
> +    def vm_add_disk(self, vm, path, id, device):
> +        bus_string = ''
> +        if self.bus != '':
> +            bus_string = ',bus=%s.%d' % (self.bus, id,)
> +        vm.add_args('-drive', 'file=%s,snapshot,id=disk%s,if=none' % (path, id))
> +        vm.add_args('-drive', 'driver=blkreplay,id=disk%s-rr,if=none,image=disk%s' % (id, id))
> +        vm.add_args('-device', '%s,drive=disk%s-rr%s' % (device, id, bus_string))
> +
> +    def prepare_boot(self):
> +        self.log.debug('Looking for and selecting a qemu-img binary to be '
> +                       'used to create the bootable snapshot image')
> +        # If qemu-img has been built, use it, otherwise the system wide one
> +        # will be used.  If none is available, the test will cancel.
> +        qemu_img = os.path.join(BUILD_DIR, 'qemu-img')
> +        if not os.path.exists(qemu_img):
> +            qemu_img = find_command('qemu-img', False)
> +        if qemu_img is False:
> +            self.cancel('Could not find "qemu-img", which is required to '
> +                        'create the bootable image')
> +        vmimage.QEMU_IMG = qemu_img
> +
> +        self.log.info('Downloading/preparing boot image')
> +        # Fedora 31 only provides ppc64le images
> +        image_arch = self.arch
> +        if image_arch == 'ppc64':
> +            image_arch = 'ppc64le'
> +        try:
> +            self.boot = vmimage.get(
> +                'fedora', arch=image_arch, version='31',
> +                checksum=self.chksum,
> +                algorithm='sha256',
> +                cache_dir=self.cache_dirs[0],
> +                snapshot_dir=self.workdir)
> +        except:
> +            self.cancel('Failed to download/prepare boot image')
> +
> +    def prepare_cloudinit(self):
> +        self.log.info('Preparing cloudinit image')
> +        try:
> +            self.cloudinit_iso = os.path.join(self.workdir, 'cloudinit.iso')
> +            self.phone_home_port = network.find_free_port()
> +            cloudinit.iso(self.cloudinit_iso, self.name,
> +                          username='root',
> +                          password='password',
> +                          # QEMU's hard coded usermode router address
> +                          phone_home_host='10.0.2.2',
> +                          phone_home_port=self.phone_home_port)
> +        except Exception:
> +            self.cancel('Failed to prepared cloudinit image')
> +
> +    def launch_and_wait(self, record, args, shift):
> +        vm = self.get_vm()
> +        vm.add_args('-smp', '1')
> +        vm.add_args('-m', '1024')
> +        vm.add_args('-object', 'filter-replay,id=replay,netdev=hub0port0')
> +        vm.add_args(*args)
> +        self.vm_add_disk(vm, self.boot.path, 0, self.hdd)
> +        self.vm_add_disk(vm, self.cloudinit_iso, 1, self.cd)
> +        if record:
> +            mode = 'record'
> +        else:
> +            mode = 'replay'
> +        vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s' %
> +                    (shift, mode, os.path.join(self.workdir, 'replay.bin')))
> +
> +        vm.set_console()
> +        vm.launch()
> +        console_drainer = datadrainer.LineLogger(vm.console_socket.fileno(),
> +                                                 logger=self.log.getChild('console'),
> +                                                 stop_check=(lambda : not vm.is_running()))
> +        console_drainer.start()
> +        if record:
> +            self.log.info('VM launched, waiting for boot confirmation from guest')
> +            cloudinit.wait_for_phone_home(('0.0.0.0', self.phone_home_port), self.name)
> +            vm.shutdown()
> +        else:
> +            self.log.info('VM launched, waiting the recorded execution to be replayed')
> +            vm.wait()
> +
> +    def run_rr(self, args=(), shift=7):

I did not spot this in my previous e-mail, sorry about that. Here you
can use the default value of args as None and handle it in the
launch_and_wait method. It is usually recommended to use a None value
for default arguments in Python instead of an empty structure.

> +        self.launch_and_wait(True, args, shift)
> +        self.launch_and_wait(False, args, shift)
> +
> +class ReplayLinuxX8664(ReplayLinux):
> +    """
> +    :avocado: tags=arch:x86_64
> +    """
> +    bus = 'ide'
> +
> +    chksum = 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0'
> +
> +    def test_pc_i440fx(self):
> +        """
> +        :avocado: tags=machine:pc
> +        :avocado: tags=accel:tcg
> +        """
> +        self.run_rr(shift=1)
> +
> +    def test_pc_q35(self):
> +        """
> +        :avocado: tags=machine:q35
> +        :avocado: tags=accel:tcg
> +        """
> +        self.run_rr(shift=3)
>
>


