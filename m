Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987D0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D2120E65
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmYPw/Uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D2120E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFBn-0004Ro-Qp
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFAp-0003Xu-Nb
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 03:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFAn-00086r-4P
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 03:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602575800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+3NTyBj5GzOi6cP8V7JZ9rv+J6wy5W0IV0WQdWhOm0=;
 b=cmYPw/UkfxGgC7m0sysFIQiD7dsp3kxtnaebwUPE/K57rOc/vL+PFZmRF8qxSb/b/r8ZeW
 n9NkB45q/wlUv5KBtdsG5ODlGdREpdrXuCUGg9tAA6+r8lUwFU4aIIQCNaD2EOdn9ZGxLj
 xIcbErcV3iBDDi9r82afAVmzsVmDU9E=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-Uqqoyj6FNw6JBzdX1VMv-w-1; Tue, 13 Oct 2020 03:56:38 -0400
X-MC-Unique: Uqqoyj6FNw6JBzdX1VMv-w-1
Received: by mail-oi1-f200.google.com with SMTP id 17so8166716oie.4
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 00:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=M+3NTyBj5GzOi6cP8V7JZ9rv+J6wy5W0IV0WQdWhOm0=;
 b=JMNfetznizJ7uqBRXcYHYuE2UBmwIHV0DWCX78PdpEraN5vQzhkzvh8VPt0/YwMfs5
 ODZNksJcEWwu4ZPGaUCoxBPpnwtfhOzMqve4nHCeSq7D0UAVxeS/8jRUyeGtBE4YRucA
 /VUf2RKJYNqYL+xWOSxACBXdqZcfE9MJFuuexaPkyDI/cpR7iuNOjKmHOpZd431cmpfj
 GdCxgVoxMfIUVBmG7O1JFNKU5jDuy6QoZy2ETHhZ301eEtkihmCfaEhOT5HT0sY1fXPg
 u1Eu+Sao/Urq0fdPyVhsDQqKb96Tz1bQDso4tKm/vEGN82RJJwq+vyKsSJXFDGvnt9qf
 W68w==
X-Gm-Message-State: AOAM531EATGeSV6Gz3ltO/rVE8CZSzL2NxajFT+G5L1bTBS1SovWzq5P
 clVARA32vNo/uGtPPzQTRJjd9eiXilMKPX2SRkbVcNGIjguKlx2ViY/jAVTeC4TwIn5E9psbqGT
 sT24irsMdaaEzHlls02Fnj5VorUMq1Pc=
X-Received: by 2002:aca:afcc:: with SMTP id y195mr13231364oie.30.1602575796973; 
 Tue, 13 Oct 2020 00:56:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyGpI1MpSeip8NhK9G3SR1jL515AOK8gP1mOepn5G0t4CEDoj1FA1ykXg21RHz6NT1FkYf/et3eQhsd3BILtU=
X-Received: by 2002:aca:afcc:: with SMTP id y195mr13231349oie.30.1602575796657; 
 Tue, 13 Oct 2020 00:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201009063432.303441-1-armbru@redhat.com>
 <20201009063432.303441-10-armbru@redhat.com>
 <87zh4rzpot.fsf@linaro.org> <20201012112506.GC7777@merkur.fritz.box>
 <99cc6bd1-58fd-af29-0b41-3f3e5043cc3a@amsat.org>
 <20201012124743.GD7777@merkur.fritz.box>
 <87r1q3zdv9.fsf@linaro.org>
 <20201012184919.d4ivnajku6ydewpm@mail.bwidawsk.net>
In-Reply-To: <20201012184919.d4ivnajku6ydewpm@mail.bwidawsk.net>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 13 Oct 2020 09:56:25 +0200
Message-ID: <CAP+75-UChQJ_YtUU40ttn=1GwNuYQ7X9xXS+CWg+ZXcLL-jocQ@mail.gmail.com>
Subject: Re: [PULL 09/14] qmp: Move dispatcher to a coroutine
To: Ben Widawsky <ben@bwidawsk.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 12, 2020 at 8:57 PM Ben Widawsky <ben@bwidawsk.net> wrote:
>
> On 20-10-12 16:02:34, Alex Benn=C3=A9e wrote:
> >
> > Kevin Wolf <kwolf@redhat.com> writes:
> >
> > > Am 12.10.2020 um 13:53 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
> > >> On 10/12/20 1:25 PM, Kevin Wolf wrote:
> > >> > Am 12.10.2020 um 12:47 hat Alex Benn=C3=A9e geschrieben:
> > >> > >
> > >> > > Markus Armbruster <armbru@redhat.com> writes:
> > >> > >
> > >> > > > From: Kevin Wolf <kwolf@redhat.com>
> > >> > > >
> > >> > > > This moves the QMP dispatcher to a coroutine and runs all QMP =
command
> > >> > > > handlers that declare 'coroutine': true in coroutine context s=
o they
> > >> > > > can avoid blocking the main loop while doing I/O or waiting fo=
r other
> > >> > > > events.
> > >> > >
> > >> > > This subtly changes the replay behaviour leading to a hang in:
> > >> > >
> > >> > >    10:55:18 [alex.bennee@hackbox2:~/l/q/b/bisect] (625581c2=E2=
=80=A6)|=E2=9C=9A1(+1/-1) + ./tests/venv/bin/avocado run tests/acceptance/r=
eplay_kernel.py:ReplayKernel.test_arm_virt
> > >> > >    Fetching asset from tests/acceptance/replay_kernel.py:ReplayK=
ernel.test_arm_virt
> > >> > >    JOB ID     : ec11fd2544f06e6c0d421f16afa757b49f7ed734
> > >> > >    JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-1=
0-12T11.40-ec11fd2/job.log
> > >> > >     (1/1) tests/acceptance/replay_kernel.py:ReplayKernel.test_ar=
m_virt: ERROR: Could not perform graceful shutdown (26.27 s)
> > >> > >    RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 0 | WARN 0 | IN=
TERRUPT 0 | CANCEL 0
> > >> > >    JOB TIME   : 27.77 s
> > >> > >
> > >> > > Looking at the log:
> > >> > >
> > >> > >    2020-10-12 11:40:31,426 __init__         L0085 DEBUG| [    3.=
887411] rtc-pl031 9010000.pl031: setting system clock to 2020-10-12 10:40:3=
1 UTC (1602499231)
> > >> > >    2020-10-12 11:40:31,428 __init__         L0085 DEBUG| [    3.=
887431] sr_init: No PMIC hook to init smartreflex
> > >> > >    2020-10-12 11:40:31,447 __init__         L0085 DEBUG| [    3.=
897193] uart-pl011 9000000.pl011: no DMA platform data
> > >> > >    2020-10-12 11:40:31,460 __init__         L0085 DEBUG| [    3.=
897242] md: Waiting for all devices to be available before autodetect
> > >> > >    2020-10-12 11:40:31,462 __init__         L0085 DEBUG| [    3.=
897259] md: If you don't use raid, use raid=3Dnoautodetect
> > >> > >    2020-10-12 11:40:31,475 __init__         L0085 DEBUG| [    3.=
897819] md: Autodetecting RAID arrays.
> > >> > >    2020-10-12 11:40:31,476 __init__         L0085 DEBUG| [    3.=
897832] md: autorun ...
> > >> > >    2020-10-12 11:40:31,477 __init__         L0085 DEBUG| [    3.=
897842] md: ... autorun DONE.
> > >> > >    2020-10-12 11:40:31,483 __init__         L0085 DEBUG| [    3.=
897962] VFS: Cannot open root device "(null)" or unknown-block(0,0): error =
-6
> > >> > >    2020-10-12 11:40:31,483 qmp              L0245 DEBUG| >>> {'e=
xecute': 'quit'}
> > >> > >    2020-10-12 11:40:31,495 qmp              L0145 DEBUG| <<< {'t=
imestamp': {'seconds': 1602499231, 'microseconds': 493379}, 'event': 'SHUTD=
OWN', 'data': {'guest': True, 'reason': 'guest-reset'}}
> > >> > >    2020-10-12 11:40:31,733 machine          L0325 WARNI| qemu re=
ceived signal 6; command: "./qemu-system-arm -display none -vga none -chard=
ev socket,id=3Dmon,path=3D/var/tmp/tmpzls53khe/qemu-8487-monitor.sock -mon =
chardev=3Dmon,mode=3Dcontrol -machine virt -chardev socket,id=3Dconsole,pat=
h=3D/var/tmp/tmpzls53khe/qemu-8487-console.sock,server,nowait -serial chard=
ev:console -icount shift=3D1,rr=3Drecord,rrfile=3D/var/tmp/avocado_n00stdrf=
/avocado_job_aw60qdul/1-tests_acceptance_replay_kernel.py_ReplayKernel.test=
_arm_virt/replay.bin -kernel /home/alex.bennee/avocado/data/cache/by_locati=
on/62750ce9e069e69e6a7ff04ff54c382ee660b92a/vmlinuz -append printk.time=3D1=
 panic=3D-1 console=3DttyAMA0 -net none -no-reboot"
> > >> >
> > >> > This looks like a crash (SIGABRT) rather than a hang. Do you have =
a
> > >> > stack trace for the crashed process?
> > >>
> > >> No crash, exit(0):
> > >
> > > Why does the log say "qemu received signal 6" then?
> > >
> > >> VFS: Cannot open root device "(null)" or unknown-block(0,0): error -=
6
> > >
> > > Alex has this error in the logs before this commit, so I assume this =
is
> > > expected. All of the following is then probably expected, too, becaus=
e
> > > it follows directly from this error:
> > >
> > >> Please append a correct "root=3D" boot option; here are the availabl=
e
> > >> partitions:
> > >> Kernel panic - not syncing: VFS: Unable to mount root fs on
> > >> unknown-block(0,0)
> > >> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.16-300.fc29.armv7hl #=
1
> > >> Hardware name: Generic DT based system
> > >> [<c0313f7c>] (unwind_backtrace) from [<c030dc64>] (show_stack+0x20/0=
x24)
> > >> [<c030dc64>] (show_stack) from [<c0b50ec4>] (dump_stack+0x88/0xa8)
> > >> [<c0b50ec4>] (dump_stack) from [<c03592f8>] (panic+0xd4/0x26c)
> > >> [<c03592f8>] (panic) from [<c110183c>] (mount_block_root+0x250/0x2ec=
)
> > >> [<c110183c>] (mount_block_root) from [<c1101950>] (mount_root+0x78/0=
x90)
> > >> [<c1101950>] (mount_root) from [<c1101ac4>] (prepare_namespace+0x15c=
/0x19c)
> > >> [<c1101ac4>] (prepare_namespace) from [<c11012e8>]
> > >> (kernel_init_freeable+0x2c0/0x370)
> > >> [<c11012e8>] (kernel_init_freeable) from [<c0b63914>]
> > >> (kernel_init+0x18/0x128)
> > >> [<c0b63914>] (kernel_init) from [<c03010e8>] (ret_from_fork+0x14/0x2=
c)
> > >> Exception stack(0xc790bfb0 to 0xc790bff8)
> > >> bfa0:                                     00000000 00000000 00000000
> > >> 00000000
> > >> bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > >> 00000000
> > >> bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > >>
> > >> -> PSCI call
> > >>    -> QEMU_PSCI_0_2_FN_SYSTEM_RESET
> > >>       -> SHUTDOWN_CAUSE_GUEST_RESET
> > >>          -> exit(0)
> >
> > Yes - the test is recording the kernel up until the point it gives up.
> >
> > > Hm... So you're saying that the test sends a 'quit' QMP command, but
> > > before it could be processed, the guest causes QEMU to exit, so the t=
est
> > > will never receive a reply to its request?
> > >
> > > If commit 9ce44e2ce2 changes anything about this, it seems to me that=
 it
> > > would be that more QMP commands are processed during monitor_cleanup(=
)
> > > because it doesn't just delete the dispatcher BH, but waits until it'=
s
> > > not busy any more.
> > >
> > > Looking at this code again, however, the order in monitor_cleanup() i=
s
> > > probably wrong. We should first shut down the dispatcher (which may
> > > still be using Monitor objects) and then destroy the monitors. This
> > > could possibly explain a crash, but probably not wrong results with a
> > > successful shutdown.
> >
> > I suspect this is a race between QEMU shutting down because the guest
> > shut it down and the acceptance test trying to shut things down via QMP=
.
> > I think the proper fix is either to:
>
> I'm not sure my problem is the same, but I do have the same symptom.
>
> >
> >   - s/panic=3D-1/panic=3D0/ in the command line (and probably drop --no=
-reboot)
> >
> > which would let the acceptance test cleanly shutdown via QMP.
>
> I tried this, which works well on some of the platforms which were failin=
g.
> -    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D1 panic=3D-1 '
> +    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D1 panic=3D-0 '
>
>      def run_vm(self, kernel_path, kernel_command_line, console_pattern,
>                 record, shift, args, replay_path):
> @@ -47,8 +47,8 @@ class ReplayKernel(LinuxKernelTest):
>                      (shift, mode, replay_path),
>                      '-kernel', kernel_path,
>                      '-append', kernel_command_line,
> -                    '-net', 'none',
> -                    '-no-reboot')
> +                    '-net', 'none'
> +                    )
>          if args:
>              vm.add_args(*args)
>          vm.launch()
> @@ -154,7 +154,7 @@ class ReplayKernel(LinuxKernelTest):
>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
>                                 'console=3DttyS0,115200 '
>                                 'usbcore.nousb '
> -                               'panic=3D-1 noreboot')
> +                               'panic=3D-0')
>          console_pattern =3D 'Boot successful.'
>
> >
> >   - modify the test to declare that qemu will shutdown itself and
> >     therefor no "quit" needs to be sent
> >
> > WDYT?

Can you send it as a formal patch please? :)

> >
> > --
> > Alex Benn=C3=A9e
> >
>


