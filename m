Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A17C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24D720736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRTIM7C0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24D720736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRkmM-0007Jc-3G
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 18:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jRklY-0006kQ-PU
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jRklX-0004Fd-1y
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:56:20 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jRklW-0004Ar-JZ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:56:18 -0400
Received: by mail-lj1-x241.google.com with SMTP id n6so7955079ljg.12
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 15:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=QUEH/Om5oEHXpkM5HIheZnx7fj9Ba+UVbOZIxq32mxA=;
 b=eRTIM7C01pSmTqj3vvQ6FMwA89vZmO0P9oY8wPjlpj9rgEJRggG2By/IgqtfFYM2fv
 vbqPvM3h+8N7M1PmAyfYB7qoaB+NZU9CDUR2fra6hR8fqQJmboUoT0sZeoy3+st2sKzM
 JHEyelouLNHfmg1JDuSO4V6EsbKsmaYAIqXEyKQRj/QSdV82S1wh8LjEHyFRdFAb3Vcg
 M2YFlXl+c+3b8U2AIsD9p72ufiRS2oR4vNdFmZXVcN1C7qSztYiM4d6G+qUyhfV4up1K
 aIjPdOSY0dylfwEJdax3sYWQaOzeZZFufYb1nm61p+1mMzGfiQ7AmVaUK0gcWxNFPR4s
 KVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=QUEH/Om5oEHXpkM5HIheZnx7fj9Ba+UVbOZIxq32mxA=;
 b=h8Hhda/YVC2Fc4MJ8Hz3mxo0nLp+stLsvTaoQAJcWF2xPizXhPYAeXH4Fh5nf50a9B
 3Loqb3DTLg/Iuu2BZWHIVxex5hS44ufRdzM+6+YgyGgxFby7eRM6fexykLcz88RS2weg
 mk3Gg2CXQ0D/TCRIfTryYDdLym1uaLaw1B5oVV4ALNeMtVBd6xUgnBCOuKoU8H5qtdou
 ymCkFgZ23ju/AwDXBcRpBG02ntev15RnXcoCIfFz6+wXBP4AG0os5YLPFDkCQIaO89Pd
 uOWWG/rbWdyH1lDZT5d5zEeWzOmqLXxO0E0L3YR3iiNw0aE/adBWTIWy+EaZMQ7yFTWu
 Q+zg==
X-Gm-Message-State: AGi0PuausTr9cOGdmuzoPeX3ezoDr3oJ/7NAVHnw8KhdDeJpxE00dYV5
 4pXMlOmEq4xj2mLBo8XqYhEMqWXyNQOr0lbMfh4=
X-Google-Smtp-Source: APiQypJ63W+VGc1Rald6lPWXPvLpGcg2Oh819KH4CqqmPxB1zIZZecSpnMnsjOpn1JIb+w0Tkdr/bTwMghUu2oCqQkE=
X-Received: by 2002:a2e:9496:: with SMTP id c22mr3608910ljh.165.1587682576010; 
 Thu, 23 Apr 2020 15:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <526ab3d1a840ad0693c6c8d38e56602d2c53024b.1587614626.git.elena.ufimtseva@oracle.com>
 <CAE2XoE8WeGXL93G6uLsKDVNrjxWFq5PTO853bdkuzDQ9fB9dtw@mail.gmail.com>
 <271ABACC-3817-43CF-8752-F0FBDDDE6080@oracle.com>
In-Reply-To: <271ABACC-3817-43CF-8752-F0FBDDDE6080@oracle.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 24 Apr 2020 06:56:04 +0800
Message-ID: <CAE2XoE-avJnd1x81V6DHR20TqOOqWa3mocdV+1hc6y0ogGtTKQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 36/36] multi-process: add configure and usage
 information
To: Jag Raman <jag.raman@oracle.com>
Content-Type: multipart/alternative; boundary="000000000000f595d405a3fd27a1"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::241
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
Reply-To: luoyonggang@gmail.com
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, Felipe Franciosi <felipe@nutanix.com>,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, stefanha@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f595d405a3fd27a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2020 at 11:03 PM Jag Raman <jag.raman@oracle.com> wrote:

>
>
> > On Apr 23, 2020, at 9:54 AM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) =
<luoyonggang@gmail.com>
> wrote:
> >
> > Does multi-process support on Windows?
> > I found it use mmap and unix socket for inter-process communication,
> that may not support under Windows.
>
> Hi Yonggang,
>
> We have only tested this on Linux till now. Are you using QEMU with
> Windows?
>
Yeap, I am using QEMU with windows.

>
> > And also, can the python script be replaced by C implementation?
>
> The functionality in the python script would eventually move to libvirt.
> The python
> script is a temporary measure.
>
> Does that means without libvirt, the QEMU can not be called directly?

> Thank you very much!
> =E2=80=94
> Jag
>
> >
> > On Thu, Apr 23, 2020 at 12:38 PM <elena.ufimtseva@oracle.com> wrote:
> > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> >
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > ---
> >  MAINTAINERS                          |  2 +
> >  docs/multi-process.rst               | 85 +++++++++++++++++++++++++
> >  scripts/mpqemu-launcher-perf-mode.py | 92 ++++++++++++++++++++++++++++
> >  scripts/mpqemu-launcher.py           | 53 ++++++++++++++++
> >  4 files changed, 232 insertions(+)
> >  create mode 100644 docs/multi-process.rst
> >  create mode 100755 scripts/mpqemu-launcher-perf-mode.py
> >  create mode 100755 scripts/mpqemu-launcher.py
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ed48615e15..8ff3bfae6a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2880,6 +2880,8 @@ F: remote/iohub.c
> >  F: remote/remote-opts.h
> >  F: remote/remote-opts.c
> >  F: docs/devel/multi-process.rst
> > +F: scripts/mpqemu-launcher.py
> > +F: scripts/mpqemu-launcher-perf-mode.py
> >
> >  Build and test automation
> >  -------------------------
> > diff --git a/docs/multi-process.rst b/docs/multi-process.rst
> > new file mode 100644
> > index 0000000000..8387d6c691
> > --- /dev/null
> > +++ b/docs/multi-process.rst
> > @@ -0,0 +1,85 @@
> > +Multi-process QEMU
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This document describes how to configure and use multi-process qemu.
> > +For the design document refer to docs/devel/qemu-multiprocess.
> > +
> > +1) Configuration
> > +----------------
> > +
> > +To enable support for multi-process add --enable-mpqemu
> > +to the list of options for the "configure" script.
> > +
> > +
> > +2) Usage
> > +--------
> > +
> > +Multi-process QEMU requires an orchestrator to launch. Please refer to=
 a
> > +light-weight python based orchestrator for mpqemu in
> > +scripts/mpqemu-launcher.py to lauch QEMU in multi-process mode.
> > +
> > +scripts/mpqemu-launcher-perf-mode.py launches in "perf" mode. In this
> mode,
> > +the same QEMU process connects to multiple remote devices, each
> emulated in
> > +a separate process.
> > +
> > +As of now, we only support the emulation of lsi53c895a in a separate
> process.
> > +
> > +Following is a description of command-line used to launch mpqemu.
> > +
> > +* Orchestrator:
> > +
> > +  - The Orchestrator creates a unix socketpair
> > +
> > +  - It launches the remote process and passes one of the
> > +    sockets to it via command-line.
> > +
> > +  - It then launches QEMU and specifies the other socket as an option
> > +    to the Proxy device object
> > +
> > +* Remote Process:
> > +
> > +  - The first command-line option in the remote process is one of the
> > +    sockets created by the Orchestrator
> > +
> > +  - The remaining options are no different from how one launches QEMU
> with
> > +    devices. The only other requirement is each PCI device must have a
> > +    unique ID specified to it. This is needed to pair remote device
> with the
> > +    Proxy object.
> > +
> > +  - Example command-line for the remote process is as follows:
> > +
> > +      /usr/bin/qemu-scsu-dev 4
>  \
> > +      -device lsi53c895a,id=3Dlsi0
>  \
> > +      -drive id=3Ddrive_image2,file=3D/build/ol7-nvme-test-1.qcow2
>  \
> > +      -device scsi-hd,id=3Ddrive2,drive=3Ddrive_image2,bus=3Dlsi0.0,sc=
si-id=3D0
> > +
> > +* QEMU:
> > +
> > +  - Since parts of the RAM are shared between QEMU & remote process, a
> > +    memory-backend-memfd is required to facilitate this, as follows:
> > +
> > +    -object memory-backend-memfd,id=3Dmem,size=3D2G
> > +
> > +  - A "pci-proxy-dev" device is created for each of the PCI devices
> emulated
> > +    in the remote process. A "socket" sub-option specifies the other
> end of
> > +    unix channel created by orchestrator. The "id" sub-option must be
> specified
> > +    and should be the same as the "id" specified for the remote PCI
> device
> > +
> > +  - Example commandline for QEMU is as follows:
> > +
> > +      -device pci-proxy-dev,id=3Dlsi0,socket=3D3
> > +
> > +* Monitor / QMP:
> > +
> > +  - The remote process supports QEMU monitor. It could be specified
> using the
> > +    "-monitor" or "-qmp" command-line options
> > +
> > +  - As an example, one could connect to the monitor by adding the
> following
> > +    to the command-line of the remote process
> > +
> > +      -monitor unix:/home/qmp-sock,server,nowait
> > +
> > +  - The user could connect to the monitor using the qmp script or usin=
g
> > +    "socat" as outlined below:
> > +
> > +      socat /home/qmp-sock stdio
> > diff --git a/scripts/mpqemu-launcher-perf-mode.py
> b/scripts/mpqemu-launcher-perf-mode.py
> > new file mode 100755
> > index 0000000000..2733424c76
> > --- /dev/null
> > +++ b/scripts/mpqemu-launcher-perf-mode.py
> > @@ -0,0 +1,92 @@
> > +#!/usr/bin/env python3
> > +
> > +import socket
> > +import os
> > +import subprocess
> > +import time
> > +
> > +PROC_QEMU=3D'/usr/bin/qemu-system-x86_64'
> > +
> > +PROC_REMOTE=3D'/usr/bin/qemu-scsi-dev'
> > +
> > +proxy_1, remote_1 =3D socket.socketpair(socket.AF_UNIX,
> socket.SOCK_STREAM)
> > +proxy_2, remote_2 =3D socket.socketpair(socket.AF_UNIX,
> socket.SOCK_STREAM)
> > +proxy_3, remote_3 =3D socket.socketpair(socket.AF_UNIX,
> socket.SOCK_STREAM)
> > +
> > +remote_cmd_1 =3D [ PROC_REMOTE,
>         \
> > +                 str(remote_1.fileno()),
>        \
> > +                 '-device', 'lsi53c895a,id=3Dlsi1',
>         \
> > +                 '-drive', 'id=3Ddrive_image1,'
>         \
> > +                               'file=3D/build/ol7-nvme-test-1.qcow2',
>         \
> > +                 '-device', 'scsi-hd,id=3Ddrive1,drive=3Ddrive_image1,=
'
>         \
> > +                                'bus=3Dlsi1.0,scsi-id=3D0',
>         \
> > +               ]
> > +
> > +remote_cmd_2 =3D [ PROC_REMOTE,
>         \
> > +                 str(remote_2.fileno()),
>        \
> > +                 '-device', 'lsi53c895a,id=3Dlsi2',
>         \
> > +                 '-drive', 'id=3Ddrive_image2,'
>         \
> > +                               'file=3D/build/ol7-nvme-test-2.qcow2',
>         \
> > +                 '-device', 'scsi-hd,id=3Ddrive2,drive=3Ddrive_image2,=
'
>         \
> > +                                'bus=3Dlsi2.0,scsi-id=3D0'
>        \
> > +               ]
> > +
> > +remote_cmd_3 =3D [ PROC_REMOTE,
>         \
> > +                 str(remote_3.fileno()),
>        \
> > +                 '-device', 'lsi53c895a,id=3Dlsi3',
>         \
> > +                 '-drive', 'id=3Ddrive_image3,'
>         \
> > +                               'file=3D/build/ol7-nvme-test-3.qcow2',
>         \
> > +                 '-device', 'scsi-hd,id=3Ddrive3,drive=3Ddrive_image3,=
'
>         \
> > +                                'bus=3Dlsi3.0,scsi-id=3D0'
>        \
> > +               ]
> > +
> > +proxy_cmd =3D [ PROC_QEMU,
>        \
> > +              '-name', 'OL7.4',
>         \
> > +              '-machine', 'q35,accel=3Dkvm',
>        \
> > +              '-smp', 'sockets=3D1,cores=3D1,threads=3D1',
>        \
> > +              '-m', '2048',
>         \
> > +              '-object',
> 'memory-backend-memfd,id=3Dsysmem-file,size=3D2G',        \
> > +              '-numa', 'node,memdev=3Dsysmem-file',
>         \
> > +              '-device', 'virtio-scsi-pci,id=3Dvirtio_scsi_pci0',
>         \
> > +              '-drive', 'id=3Ddrive_image1,if=3Dnone,format=3Dqcow2,'
>         \
> > +                            'file=3D/home/ol7-hdd-1.qcow2',
>         \
> > +              '-device', 'scsi-hd,id=3Dimage1,drive=3Ddrive_image1,'
>        \
> > +                             'bus=3Dvirtio_scsi_pci0.0',
>        \
> > +              '-boot', 'd',
>         \
> > +              '-vnc', ':0',
>         \
> > +              '-device', 'pci-proxy-dev,id=3Dlsi1,'
>         \
> > +                             'socket=3D'+str(proxy_1.fileno()),
>         \
> > +              '-device', 'pci-proxy-dev,id=3Dlsi2,'
>         \
> > +                             'socket=3D'+str(proxy_2.fileno()),
>         \
> > +              '-device', 'pci-proxy-dev,id=3Dlsi3,'
>         \
> > +                             'socket=3D'+str(proxy_3.fileno())
>        \
> > +            ]
> > +
> > +
> > +pid =3D os.fork();
> > +if pid =3D=3D 0:
> > +    # In remote_1
> > +    print('Launching Remote process 1');
> > +    process =3D subprocess.Popen(remote_cmd_1,
> pass_fds=3D[remote_1.fileno()])
> > +    os._exit(0)
> > +
> > +
> > +pid =3D os.fork();
> > +if pid =3D=3D 0:
> > +    # In remote_2
> > +    print('Launching Remote process 2');
> > +    process =3D subprocess.Popen(remote_cmd_2,
> pass_fds=3D[remote_2.fileno()])
> > +    os._exit(0)
> > +
> > +
> > +pid =3D os.fork();
> > +if pid =3D=3D 0:
> > +    # In remote_3
> > +    print('Launching Remote process 3');
> > +    process =3D subprocess.Popen(remote_cmd_3,
> pass_fds=3D[remote_3.fileno()])
> > +    os._exit(0)
> > +
> > +
> > +print('Launching Proxy process');
> > +process =3D subprocess.Popen(proxy_cmd, pass_fds=3D[proxy_1.fileno(),
>         \
> > +                           proxy_2.fileno(), proxy_3.fileno()])
> > diff --git a/scripts/mpqemu-launcher.py b/scripts/mpqemu-launcher.py
> > new file mode 100755
> > index 0000000000..81e370663e
> > --- /dev/null
> > +++ b/scripts/mpqemu-launcher.py
> > @@ -0,0 +1,53 @@
> > +#!/usr/bin/env python3
> > +import socket
> > +import os
> > +import subprocess
> > +import time
> > +
> > +PROC_QEMU=3D'/usr/bin/qemu-system-x86_64'
> > +
> > +PROC_REMOTE=3D'/usr/bin/qemu-scsi-dev'
> > +
> > +proxy, remote =3D socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM=
)
> > +
> > +remote_cmd =3D [ PROC_REMOTE,
>         \
> > +               str(remote.fileno()),
>        \
> > +               '-device', 'lsi53c895a,id=3Dlsi1',
>         \
> > +               '-drive',
> 'id=3Ddrive_image1,file=3D/build/ol7-nvme-test-1.qcow2',  \
> > +               '-device',
> 'scsi-hd,id=3Ddrive1,drive=3Ddrive_image1,bus=3Dlsi1.0,'   \
> > +                              'scsi-id=3D0',
>        \
> > +               '-device', 'lsi53c895a,id=3Dlsi2',
>         \
> > +               '-drive',
> 'id=3Ddrive_image2,file=3D/build/ol7-nvme-test-2.qcow2',  \
> > +               '-device',
> 'scsi-hd,id=3Ddrive2,drive=3Ddrive_image2,bus=3Dlsi2.0,'   \
> > +                              'scsi-id=3D0'
>         \
> > +             ]
> > +
> > +proxy_cmd =3D [ PROC_QEMU,
>        \
> > +              '-name', 'OL7.4',
>         \
> > +              '-machine', 'q35,accel=3Dkvm',
>        \
> > +              '-smp', 'sockets=3D1,cores=3D1,threads=3D1',
>        \
> > +              '-m', '2048',
>         \
> > +              '-object',
> 'memory-backend-memfd,id=3Dsysmem-file,size=3D2G',        \
> > +              '-numa', 'node,memdev=3Dsysmem-file',
>         \
> > +              '-device', 'virtio-scsi-pci,id=3Dvirtio_scsi_pci0',
>         \
> > +              '-drive', 'id=3Ddrive_image1,if=3Dnone,format=3Dqcow2,'
>         \
> > +                            'file=3D/home/ol7-hdd-1.qcow2',
>         \
> > +              '-device', 'scsi-hd,id=3Dimage1,drive=3Ddrive_image1,'
>        \
> > +                             'bus=3Dvirtio_scsi_pci0.0',
>        \
> > +              '-boot', 'd',
>         \
> > +              '-vnc', ':0',
>         \
> > +              '-device',
> 'pci-proxy-dev,id=3Dlsi1,socket=3D'+str(proxy.fileno()),  \
> > +              '-device',
> 'pci-proxy-dev,id=3Dlsi2,socket=3D'+str(proxy.fileno())   \
> > +            ]
> > +
> > +
> > +pid =3D os.fork();
> > +
> > +if pid:
> > +    # In Proxy
> > +    print('Launching QEMU with Proxy object');
> > +    process =3D subprocess.Popen(proxy_cmd, pass_fds=3D[proxy.fileno()=
])
> > +else:
> > +    # In remote
> > +    print('Launching Remote process');
> > +    process =3D subprocess.Popen(remote_cmd, pass_fds=3D[remote.fileno=
()])
> > --
> > 2.25.GIT
> >
> >
> >
> >
> > --
> >          =E6=AD=A4=E8=87=B4
> > =E7=A4=BC
> > =E7=BD=97=E5=8B=87=E5=88=9A
> > Yours
> >     sincerely,
> > Yonggang Luo
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000f595d405a3fd27a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFRodSwgQXBy
IDIzLCAyMDIwIGF0IDExOjAzIFBNIEphZyBSYW1hbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmphZy5y
YW1hbkBvcmFjbGUuY29tIj5qYWcucmFtYW5Ab3JhY2xlLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+PGJyPg0KPGJyPg0KJmd0OyBPbiBBcHIgMjMsIDIwMjAsIGF0IDk6NTQgQU0s
IOe9l+WLh+WImihZb25nZ2FuZyBMdW8pICZsdDs8YSBocmVmPSJtYWlsdG86bHVveW9uZ2dhbmdA
Z21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bHVveW9uZ2dhbmdAZ21haWwuY29tPC9hPiZndDsg
d3JvdGU6PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IERvZXMgbXVsdGktcHJvY2VzcyBzdXBwb3J0IG9u
IFdpbmRvd3M/PGJyPg0KJmd0OyBJIGZvdW5kIGl0IHVzZSBtbWFwIGFuZCB1bml4IHNvY2tldCBm
b3IgaW50ZXItcHJvY2VzcyBjb21tdW5pY2F0aW9uLCB0aGF0IG1heSBub3Qgc3VwcG9ydCB1bmRl
ciBXaW5kb3dzLjxicj4NCjxicj4NCkhpIFlvbmdnYW5nLDxicj4NCjxicj4NCldlIGhhdmUgb25s
eSB0ZXN0ZWQgdGhpcyBvbiBMaW51eCB0aWxsIG5vdy4gQXJlIHlvdSB1c2luZyBRRU1VIHdpdGgg
V2luZG93cz88YnI+PC9ibG9ja3F1b3RlPjxkaXY+WWVhcCwgSSBhbSB1c2luZyBRRU1VIHdpdGgg
d2luZG93cy7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQs
MjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCjxicj4NCiZndDsgQW5kIGFsc28sIGNhbiB0aGUgcHl0
aG9uIHNjcmlwdCBiZSByZXBsYWNlZCBieSBDIGltcGxlbWVudGF0aW9uPzxicj4NCjxicj4NClRo
ZSBmdW5jdGlvbmFsaXR5IGluIHRoZSBweXRob24gc2NyaXB0IHdvdWxkIGV2ZW50dWFsbHkgbW92
ZSB0byBsaWJ2aXJ0LiBUaGUgcHl0aG9uPGJyPg0Kc2NyaXB0IGlzIGEgdGVtcG9yYXJ5IG1lYXN1
cmUuPGJyPg0KPGJyPjwvYmxvY2txdW90ZT48ZGl2PkRvZXMgdGhhdCBtZWFucyB3aXRob3V0IGxp
YnZpcnQsIHRoZSBRRU1VIGNhbiBub3QgYmUgY2FsbGVkIGRpcmVjdGx5P8KgPC9kaXY+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4
O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgi
Pg0KVGhhbmsgeW91IHZlcnkgbXVjaCE8YnI+DQrigJQ8YnI+DQpKYWc8YnI+DQo8YnI+DQomZ3Q7
IDxicj4NCiZndDsgT24gVGh1LCBBcHIgMjMsIDIwMjAgYXQgMTI6MzggUE0gJmx0OzxhIGhyZWY9
Im1haWx0bzplbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmVsZW5h
LnVmaW10c2V2YUBvcmFjbGUuY29tPC9hPiZndDsgd3JvdGU6PGJyPg0KJmd0OyBGcm9tOiBFbGVu
YSBVZmltdHNldmEgJmx0OzxhIGhyZWY9Im1haWx0bzplbGVuYS51ZmltdHNldmFAb3JhY2xlLmNv
bSIgdGFyZ2V0PSJfYmxhbmsiPmVsZW5hLnVmaW10c2V2YUBvcmFjbGUuY29tPC9hPiZndDs8YnI+
DQomZ3Q7IDxicj4NCiZndDsgU2lnbmVkLW9mZi1ieTogRWxlbmEgVWZpbXRzZXZhICZsdDs8YSBo
cmVmPSJtYWlsdG86ZWxlbmEudWZpbXRzZXZhQG9yYWNsZS5jb20iIHRhcmdldD0iX2JsYW5rIj5l
bGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbTwvYT4mZ3Q7PGJyPg0KJmd0OyBTaWduZWQtb2ZmLWJ5
OiBKYWdhbm5hdGhhbiBSYW1hbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmphZy5yYW1hbkBvcmFjbGUu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+amFnLnJhbWFuQG9yYWNsZS5jb208L2E+Jmd0Ozxicj4NCiZn
dDsgU2lnbmVkLW9mZi1ieTogSm9obiBHIEpvaG5zb24gJmx0OzxhIGhyZWY9Im1haWx0bzpqb2hu
Lmcuam9obnNvbkBvcmFjbGUuY29tIiB0YXJnZXQ9Il9ibGFuayI+am9obi5nLmpvaG5zb25Ab3Jh
Y2xlLmNvbTwvYT4mZ3Q7PGJyPg0KJmd0OyAtLS08YnI+DQomZ3Q7wqAgTUFJTlRBSU5FUlPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMiArPGJyPg0KJmd0O8KgIGRv
Y3MvbXVsdGktcHJvY2Vzcy5yc3TCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgODUgKysrKysrKysr
KysrKysrKysrKysrKysrKzxicj4NCiZndDvCoCBzY3JpcHRzL21wcWVtdS1sYXVuY2hlci1wZXJm
LW1vZGUucHkgfCA5MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrPGJyPg0KJmd0O8KgIHNj
cmlwdHMvbXBxZW11LWxhdW5jaGVyLnB5wqAgwqAgwqAgwqAgwqAgwqB8IDUzICsrKysrKysrKysr
KysrKys8YnI+DQomZ3Q7wqAgNCBmaWxlcyBjaGFuZ2VkLCAyMzIgaW5zZXJ0aW9ucygrKTxicj4N
CiZndDvCoCBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9tdWx0aS1wcm9jZXNzLnJzdDxicj4NCiZn
dDvCoCBjcmVhdGUgbW9kZSAxMDA3NTUgc2NyaXB0cy9tcHFlbXUtbGF1bmNoZXItcGVyZi1tb2Rl
LnB5PGJyPg0KJmd0O8KgIGNyZWF0ZSBtb2RlIDEwMDc1NSBzY3JpcHRzL21wcWVtdS1sYXVuY2hl
ci5weTxicj4NCiZndDsgPGJyPg0KJmd0OyBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlO
VEFJTkVSUzxicj4NCiZndDsgaW5kZXggZWQ0ODYxNWUxNS4uOGZmM2JmYWU2YSAxMDA2NDQ8YnI+
DQomZ3Q7IC0tLSBhL01BSU5UQUlORVJTPGJyPg0KJmd0OyArKysgYi9NQUlOVEFJTkVSUzxicj4N
CiZndDsgQEAgLTI4ODAsNiArMjg4MCw4IEBAIEY6IHJlbW90ZS9pb2h1Yi5jPGJyPg0KJmd0O8Kg
IEY6IHJlbW90ZS9yZW1vdGUtb3B0cy5oPGJyPg0KJmd0O8KgIEY6IHJlbW90ZS9yZW1vdGUtb3B0
cy5jPGJyPg0KJmd0O8KgIEY6IGRvY3MvZGV2ZWwvbXVsdGktcHJvY2Vzcy5yc3Q8YnI+DQomZ3Q7
ICtGOiBzY3JpcHRzL21wcWVtdS1sYXVuY2hlci5weTxicj4NCiZndDsgK0Y6IHNjcmlwdHMvbXBx
ZW11LWxhdW5jaGVyLXBlcmYtbW9kZS5weTxicj4NCiZndDsgPGJyPg0KJmd0O8KgIEJ1aWxkIGFu
ZCB0ZXN0IGF1dG9tYXRpb248YnI+DQomZ3Q7wqAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxi
cj4NCiZndDsgZGlmZiAtLWdpdCBhL2RvY3MvbXVsdGktcHJvY2Vzcy5yc3QgYi9kb2NzL211bHRp
LXByb2Nlc3MucnN0PGJyPg0KJmd0OyBuZXcgZmlsZSBtb2RlIDEwMDY0NDxicj4NCiZndDsgaW5k
ZXggMDAwMDAwMDAwMC4uODM4N2Q2YzY5MTxicj4NCiZndDsgLS0tIC9kZXYvbnVsbDxicj4NCiZn
dDsgKysrIGIvZG9jcy9tdWx0aS1wcm9jZXNzLnJzdDxicj4NCiZndDsgQEAgLTAsMCArMSw4NSBA
QDxicj4NCiZndDsgK011bHRpLXByb2Nlc3MgUUVNVTxicj4NCiZndDsgKz09PT09PT09PT09PT09
PT09PTxicj4NCiZndDsgKzxicj4NCiZndDsgK1RoaXMgZG9jdW1lbnQgZGVzY3JpYmVzIGhvdyB0
byBjb25maWd1cmUgYW5kIHVzZSBtdWx0aS1wcm9jZXNzIHFlbXUuPGJyPg0KJmd0OyArRm9yIHRo
ZSBkZXNpZ24gZG9jdW1lbnQgcmVmZXIgdG8gZG9jcy9kZXZlbC9xZW11LW11bHRpcHJvY2Vzcy48
YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICsxKSBDb25maWd1cmF0aW9uPGJyPg0KJmd0OyArLS0tLS0t
LS0tLS0tLS0tLTxicj4NCiZndDsgKzxicj4NCiZndDsgK1RvIGVuYWJsZSBzdXBwb3J0IGZvciBt
dWx0aS1wcm9jZXNzIGFkZCAtLWVuYWJsZS1tcHFlbXU8YnI+DQomZ3Q7ICt0byB0aGUgbGlzdCBv
ZiBvcHRpb25zIGZvciB0aGUgJnF1b3Q7Y29uZmlndXJlJnF1b3Q7IHNjcmlwdC48YnI+DQomZ3Q7
ICs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICsyKSBVc2FnZTxicj4NCiZndDsgKy0tLS0tLS0tPGJy
Pg0KJmd0OyArPGJyPg0KJmd0OyArTXVsdGktcHJvY2VzcyBRRU1VIHJlcXVpcmVzIGFuIG9yY2hl
c3RyYXRvciB0byBsYXVuY2guIFBsZWFzZSByZWZlciB0byBhPGJyPg0KJmd0OyArbGlnaHQtd2Vp
Z2h0IHB5dGhvbiBiYXNlZCBvcmNoZXN0cmF0b3IgZm9yIG1wcWVtdSBpbjxicj4NCiZndDsgK3Nj
cmlwdHMvbXBxZW11LWxhdW5jaGVyLnB5IHRvIGxhdWNoIFFFTVUgaW4gbXVsdGktcHJvY2VzcyBt
b2RlLjxicj4NCiZndDsgKzxicj4NCiZndDsgK3NjcmlwdHMvbXBxZW11LWxhdW5jaGVyLXBlcmYt
bW9kZS5weSBsYXVuY2hlcyBpbiAmcXVvdDtwZXJmJnF1b3Q7IG1vZGUuIEluIHRoaXMgbW9kZSw8
YnI+DQomZ3Q7ICt0aGUgc2FtZSBRRU1VIHByb2Nlc3MgY29ubmVjdHMgdG8gbXVsdGlwbGUgcmVt
b3RlIGRldmljZXMsIGVhY2ggZW11bGF0ZWQgaW48YnI+DQomZ3Q7ICthIHNlcGFyYXRlIHByb2Nl
c3MuPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArQXMgb2Ygbm93LCB3ZSBvbmx5IHN1cHBvcnQgdGhl
IGVtdWxhdGlvbiBvZiBsc2k1M2M4OTVhIGluIGEgc2VwYXJhdGUgcHJvY2Vzcy48YnI+DQomZ3Q7
ICs8YnI+DQomZ3Q7ICtGb2xsb3dpbmcgaXMgYSBkZXNjcmlwdGlvbiBvZiBjb21tYW5kLWxpbmUg
dXNlZCB0byBsYXVuY2ggbXBxZW11Ljxicj4NCiZndDsgKzxicj4NCiZndDsgKyogT3JjaGVzdHJh
dG9yOjxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIC0gVGhlIE9yY2hlc3RyYXRvciBjcmVhdGVz
IGEgdW5peCBzb2NrZXRwYWlyPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgLSBJdCBsYXVuY2hl
cyB0aGUgcmVtb3RlIHByb2Nlc3MgYW5kIHBhc3NlcyBvbmUgb2YgdGhlPGJyPg0KJmd0OyArwqAg
wqAgc29ja2V0cyB0byBpdCB2aWEgY29tbWFuZC1saW5lLjxicj4NCiZndDsgKzxicj4NCiZndDsg
K8KgIC0gSXQgdGhlbiBsYXVuY2hlcyBRRU1VIGFuZCBzcGVjaWZpZXMgdGhlIG90aGVyIHNvY2tl
dCBhcyBhbiBvcHRpb248YnI+DQomZ3Q7ICvCoCDCoCB0byB0aGUgUHJveHkgZGV2aWNlIG9iamVj
dDxicj4NCiZndDsgKzxicj4NCiZndDsgKyogUmVtb3RlIFByb2Nlc3M6PGJyPg0KJmd0OyArPGJy
Pg0KJmd0OyArwqAgLSBUaGUgZmlyc3QgY29tbWFuZC1saW5lIG9wdGlvbiBpbiB0aGUgcmVtb3Rl
IHByb2Nlc3MgaXMgb25lIG9mIHRoZTxicj4NCiZndDsgK8KgIMKgIHNvY2tldHMgY3JlYXRlZCBi
eSB0aGUgT3JjaGVzdHJhdG9yPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgLSBUaGUgcmVtYWlu
aW5nIG9wdGlvbnMgYXJlIG5vIGRpZmZlcmVudCBmcm9tIGhvdyBvbmUgbGF1bmNoZXMgUUVNVSB3
aXRoPGJyPg0KJmd0OyArwqAgwqAgZGV2aWNlcy4gVGhlIG9ubHkgb3RoZXIgcmVxdWlyZW1lbnQg
aXMgZWFjaCBQQ0kgZGV2aWNlIG11c3QgaGF2ZSBhPGJyPg0KJmd0OyArwqAgwqAgdW5pcXVlIElE
IHNwZWNpZmllZCB0byBpdC4gVGhpcyBpcyBuZWVkZWQgdG8gcGFpciByZW1vdGUgZGV2aWNlIHdp
dGggdGhlPGJyPg0KJmd0OyArwqAgwqAgUHJveHkgb2JqZWN0Ljxicj4NCiZndDsgKzxicj4NCiZn
dDsgK8KgIC0gRXhhbXBsZSBjb21tYW5kLWxpbmUgZm9yIHRoZSByZW1vdGUgcHJvY2VzcyBpcyBh
cyBmb2xsb3dzOjxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgIC91c3IvYmluL3FlbXUt
c2NzdS1kZXYgNMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCiZndDsgK8KgIMKgIMKgIC1kZXZpY2UgbHNpNTNjODk1
YSxpZD1sc2kwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgLWRyaXZlIGlkPWRyaXZlX2ltYWdl
MixmaWxlPS9idWlsZC9vbDctbnZtZS10ZXN0LTEucWNvdzLCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
DQomZ3Q7ICvCoCDCoCDCoCAtZGV2aWNlIHNjc2ktaGQsaWQ9ZHJpdmUyLGRyaXZlPWRyaXZlX2lt
YWdlMixidXM9bHNpMC4wLHNjc2ktaWQ9MDxicj4NCiZndDsgKzxicj4NCiZndDsgKyogUUVNVTo8
YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCAtIFNpbmNlIHBhcnRzIG9mIHRoZSBSQU0gYXJlIHNo
YXJlZCBiZXR3ZWVuIFFFTVUgJmFtcDsgcmVtb3RlIHByb2Nlc3MsIGE8YnI+DQomZ3Q7ICvCoCDC
oCBtZW1vcnktYmFja2VuZC1tZW1mZCBpcyByZXF1aXJlZCB0byBmYWNpbGl0YXRlIHRoaXMsIGFz
IGZvbGxvd3M6PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgLW9iamVjdCBtZW1vcnktYmFj
a2VuZC1tZW1mZCxpZD1tZW0sc2l6ZT0yRzxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIC0gQSAm
cXVvdDtwY2ktcHJveHktZGV2JnF1b3Q7IGRldmljZSBpcyBjcmVhdGVkIGZvciBlYWNoIG9mIHRo
ZSBQQ0kgZGV2aWNlcyBlbXVsYXRlZDxicj4NCiZndDsgK8KgIMKgIGluIHRoZSByZW1vdGUgcHJv
Y2Vzcy4gQSAmcXVvdDtzb2NrZXQmcXVvdDsgc3ViLW9wdGlvbiBzcGVjaWZpZXMgdGhlIG90aGVy
IGVuZCBvZjxicj4NCiZndDsgK8KgIMKgIHVuaXggY2hhbm5lbCBjcmVhdGVkIGJ5IG9yY2hlc3Ry
YXRvci4gVGhlICZxdW90O2lkJnF1b3Q7IHN1Yi1vcHRpb24gbXVzdCBiZSBzcGVjaWZpZWQ8YnI+
DQomZ3Q7ICvCoCDCoCBhbmQgc2hvdWxkIGJlIHRoZSBzYW1lIGFzIHRoZSAmcXVvdDtpZCZxdW90
OyBzcGVjaWZpZWQgZm9yIHRoZSByZW1vdGUgUENJIGRldmljZTxicj4NCiZndDsgKzxicj4NCiZn
dDsgK8KgIC0gRXhhbXBsZSBjb21tYW5kbGluZSBmb3IgUUVNVSBpcyBhcyBmb2xsb3dzOjxicj4N
CiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgIC1kZXZpY2UgcGNpLXByb3h5LWRldixpZD1sc2kw
LHNvY2tldD0zPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArKiBNb25pdG9yIC8gUU1QOjxicj4NCiZn
dDsgKzxicj4NCiZndDsgK8KgIC0gVGhlIHJlbW90ZSBwcm9jZXNzIHN1cHBvcnRzIFFFTVUgbW9u
aXRvci4gSXQgY291bGQgYmUgc3BlY2lmaWVkIHVzaW5nIHRoZTxicj4NCiZndDsgK8KgIMKgICZx
dW90Oy1tb25pdG9yJnF1b3Q7IG9yICZxdW90Oy1xbXAmcXVvdDsgY29tbWFuZC1saW5lIG9wdGlv
bnM8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCAtIEFzIGFuIGV4YW1wbGUsIG9uZSBjb3VsZCBj
b25uZWN0IHRvIHRoZSBtb25pdG9yIGJ5IGFkZGluZyB0aGUgZm9sbG93aW5nPGJyPg0KJmd0OyAr
wqAgwqAgdG8gdGhlIGNvbW1hbmQtbGluZSBvZiB0aGUgcmVtb3RlIHByb2Nlc3M8YnI+DQomZ3Q7
ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoCAtbW9uaXRvciB1bml4Oi9ob21lL3FtcC1zb2NrLHNlcnZl
cixub3dhaXQ8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCAtIFRoZSB1c2VyIGNvdWxkIGNvbm5l
Y3QgdG8gdGhlIG1vbml0b3IgdXNpbmcgdGhlIHFtcCBzY3JpcHQgb3IgdXNpbmc8YnI+DQomZ3Q7
ICvCoCDCoCAmcXVvdDtzb2NhdCZxdW90OyBhcyBvdXRsaW5lZCBiZWxvdzo8YnI+DQomZ3Q7ICs8
YnI+DQomZ3Q7ICvCoCDCoCDCoCBzb2NhdCAvaG9tZS9xbXAtc29jayBzdGRpbzxicj4NCiZndDsg
ZGlmZiAtLWdpdCBhL3NjcmlwdHMvbXBxZW11LWxhdW5jaGVyLXBlcmYtbW9kZS5weSBiL3Njcmlw
dHMvbXBxZW11LWxhdW5jaGVyLXBlcmYtbW9kZS5weTxicj4NCiZndDsgbmV3IGZpbGUgbW9kZSAx
MDA3NTU8YnI+DQomZ3Q7IGluZGV4IDAwMDAwMDAwMDAuLjI3MzM0MjRjNzY8YnI+DQomZ3Q7IC0t
LSAvZGV2L251bGw8YnI+DQomZ3Q7ICsrKyBiL3NjcmlwdHMvbXBxZW11LWxhdW5jaGVyLXBlcmYt
bW9kZS5weTxicj4NCiZndDsgQEAgLTAsMCArMSw5MiBAQDxicj4NCiZndDsgKyMhL3Vzci9iaW4v
ZW52IHB5dGhvbjM8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtpbXBvcnQgc29ja2V0PGJyPg0KJmd0
OyAraW1wb3J0IG9zPGJyPg0KJmd0OyAraW1wb3J0IHN1YnByb2Nlc3M8YnI+DQomZ3Q7ICtpbXBv
cnQgdGltZTxicj4NCiZndDsgKzxicj4NCiZndDsgK1BST0NfUUVNVT0mIzM5Oy91c3IvYmluL3Fl
bXUtc3lzdGVtLXg4Nl82NCYjMzk7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArUFJPQ19SRU1PVEU9
JiMzOTsvdXNyL2Jpbi9xZW11LXNjc2ktZGV2JiMzOTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtw
cm94eV8xLCByZW1vdGVfMSA9IHNvY2tldC5zb2NrZXRwYWlyKHNvY2tldC5BRl9VTklYLCBzb2Nr
ZXQuU09DS19TVFJFQU0pPGJyPg0KJmd0OyArcHJveHlfMiwgcmVtb3RlXzIgPSBzb2NrZXQuc29j
a2V0cGFpcihzb2NrZXQuQUZfVU5JWCwgc29ja2V0LlNPQ0tfU1RSRUFNKTxicj4NCiZndDsgK3By
b3h5XzMsIHJlbW90ZV8zID0gc29ja2V0LnNvY2tldHBhaXIoc29ja2V0LkFGX1VOSVgsIHNvY2tl
dC5TT0NLX1NUUkVBTSk8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtyZW1vdGVfY21kXzEgPSBbIFBS
T0NfUkVNT1RFLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHN0cihyZW1vdGVfMS5maWxlbm8oKSkswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kZXZpY2UmIzM5OywgJiMzOTtsc2k1M2M4OTVhLGlkPWxz
aTEmIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kcml2ZSYjMzk7LCAmIzM5
O2lkPWRyaXZlX2ltYWdlMSwmIzM5O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7ZmlsZT0vYnVpbGQvb2w3LW52bWUtdGVzdC0xLnFjb3cy
JiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgJiMzOTstZGV2aWNlJiMzOTssICYjMzk7c2NzaS1oZCxpZD1kcml2ZTEsZHJpdmU9ZHJp
dmVfaW1hZ2UxLCYjMzk7wqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7YnVzPWxzaTEuMCxzY3Np
LWlkPTAmIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBdPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArcmVtb3Rl
X2NtZF8yID0gWyBQUk9DX1JFTU9URSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHIocmVtb3RlXzIuZmlsZW5vKCkpLMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJiMzOTstZGV2aWNlJiMzOTssICYjMzk7bHNp
NTNjODk1YSxpZD1sc2kyJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJiMzOTstZHJp
dmUmIzM5OywgJiMzOTtpZD1kcml2ZV9pbWFnZTIsJiMzOTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5O2ZpbGU9L2J1aWxkL29sNy1udm1l
LXRlc3QtMi5xY293MiYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRldmljZSYjMzk7LCAmIzM5O3Njc2ktaGQsaWQ9ZHJp
dmUyLGRyaXZlPWRyaXZlX2ltYWdlMiwmIzM5O8KgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5O2J1
cz1sc2kyLjAsc2NzaS1pZD0wJiMzOTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF08YnI+DQomZ3Q7ICs8YnI+
DQomZ3Q7ICtyZW1vdGVfY21kXzMgPSBbIFBST0NfUkVNT1RFLMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8
YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cihyZW1vdGVfMy5maWxlbm8o
KSkswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kZXZpY2Um
IzM5OywgJiMzOTtsc2k1M2M4OTVhLGlkPWxzaTMmIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAmIzM5Oy1kcml2ZSYjMzk7LCAmIzM5O2lkPWRyaXZlX2ltYWdlMywmIzM5O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7ZmlsZT0v
YnVpbGQvb2w3LW52bWUtdGVzdC0zLnFjb3cyJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgXDxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJiMzOTstZGV2aWNlJiMzOTssICYjMzk7
c2NzaS1oZCxpZD1kcml2ZTMsZHJpdmU9ZHJpdmVfaW1hZ2UzLCYjMzk7wqAgwqAgwqAgwqAgwqAg
wqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgICYjMzk7YnVzPWxzaTMuMCxzY3NpLWlkPTAmIzM5O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXTxi
cj4NCiZndDsgKzxicj4NCiZndDsgK3Byb3h5X2NtZCA9IFsgUFJPQ19RRU1VLMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LW5h
bWUmIzM5OywgJiMzOTtPTDcuNCYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1tYWNoaW5lJiMzOTssICYjMzk7cTM1LGFjY2VsPWt2bSYj
Mzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LXNtcCYjMzk7LCAmIzM5
O3NvY2tldHM9MSxjb3Jlcz0xLHRocmVhZHM9MSYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7
LW0mIzM5OywgJiMzOTsyMDQ4JiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LW9iamVjdCYjMzk7LCAmIzM5O21lbW9yeS1iYWNr
ZW5kLW1lbWZkLGlkPXN5c21lbS1maWxlLHNpemU9MkcmIzM5OyzCoCDCoCDCoCDCoCBcPGJyPg0K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstbnVtYSYjMzk7LCAmIzM5O25vZGUsbWVt
ZGV2PXN5c21lbS1maWxlJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LWRldmljZSYj
Mzk7LCAmIzM5O3ZpcnRpby1zY3NpLXBjaSxpZD12aXJ0aW9fc2NzaV9wY2kwJiMzOTsswqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7
LWRyaXZlJiMzOTssICYjMzk7aWQ9ZHJpdmVfaW1hZ2UxLGlmPW5vbmUsZm9ybWF0PXFjb3cyLCYj
Mzk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7ZmlsZT0vaG9tZS9vbDctaGRkLTEucWNvdzIm
IzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAgJiMzOTstZGV2aWNlJiMzOTssICYjMzk7c2NzaS1oZCxpZD1pbWFnZTEs
ZHJpdmU9ZHJpdmVfaW1hZ2UxLCYjMzk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5O2J1cz12
aXJ0aW9fc2NzaV9wY2kwLjAmIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1ib290JiMzOTssICYj
Mzk7ZCYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmIzM5Oy12bmMmIzM5OywgJiMzOTs6MCYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1kZXZpY2UmIzM5OywgJiMz
OTtwY2ktcHJveHktZGV2LGlkPWxzaTEsJiMzOTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAmIzM5O3NvY2tldD0mIzM5OytzdHIocHJveHlfMS5maWxlbm8oKSks
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgICYjMzk7LWRldmljZSYjMzk7LCAmIzM5O3BjaS1wcm94eS1kZXYsaWQ9bHNpMiwmIzM5O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7c29ja2V0PSYj
Mzk7K3N0cihwcm94eV8yLmZpbGVubygpKSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJy
Pg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstZGV2aWNlJiMzOTssICYjMzk7cGNp
LXByb3h5LWRldixpZD1sc2kzLCYjMzk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgJiMzOTtzb2NrZXQ9JiMzOTsrc3RyKHByb3h5XzMuZmlsZW5vKCkpwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgXTxi
cj4NCiZndDsgKzxicj4NCiZndDsgKzxicj4NCiZndDsgK3BpZCA9IG9zLmZvcmsoKTs8YnI+DQom
Z3Q7ICtpZiBwaWQgPT0gMDo8YnI+DQomZ3Q7ICvCoCDCoCAjIEluIHJlbW90ZV8xPGJyPg0KJmd0
OyArwqAgwqAgcHJpbnQoJiMzOTtMYXVuY2hpbmcgUmVtb3RlIHByb2Nlc3MgMSYjMzk7KTs8YnI+
DQomZ3Q7ICvCoCDCoCBwcm9jZXNzID0gc3VicHJvY2Vzcy5Qb3BlbihyZW1vdGVfY21kXzEsIHBh
c3NfZmRzPVtyZW1vdGVfMS5maWxlbm8oKV0pPGJyPg0KJmd0OyArwqAgwqAgb3MuX2V4aXQoMCk8
YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtwaWQgPSBvcy5mb3JrKCk7PGJyPg0K
Jmd0OyAraWYgcGlkID09IDA6PGJyPg0KJmd0OyArwqAgwqAgIyBJbiByZW1vdGVfMjxicj4NCiZn
dDsgK8KgIMKgIHByaW50KCYjMzk7TGF1bmNoaW5nIFJlbW90ZSBwcm9jZXNzIDImIzM5Oyk7PGJy
Pg0KJmd0OyArwqAgwqAgcHJvY2VzcyA9IHN1YnByb2Nlc3MuUG9wZW4ocmVtb3RlX2NtZF8yLCBw
YXNzX2Zkcz1bcmVtb3RlXzIuZmlsZW5vKCldKTxicj4NCiZndDsgK8KgIMKgIG9zLl9leGl0KDAp
PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArcGlkID0gb3MuZm9yaygpOzxicj4N
CiZndDsgK2lmIHBpZCA9PSAwOjxicj4NCiZndDsgK8KgIMKgICMgSW4gcmVtb3RlXzM8YnI+DQom
Z3Q7ICvCoCDCoCBwcmludCgmIzM5O0xhdW5jaGluZyBSZW1vdGUgcHJvY2VzcyAzJiMzOTspOzxi
cj4NCiZndDsgK8KgIMKgIHByb2Nlc3MgPSBzdWJwcm9jZXNzLlBvcGVuKHJlbW90ZV9jbWRfMywg
cGFzc19mZHM9W3JlbW90ZV8zLmZpbGVubygpXSk8YnI+DQomZ3Q7ICvCoCDCoCBvcy5fZXhpdCgw
KTxicj4NCiZndDsgKzxicj4NCiZndDsgKzxicj4NCiZndDsgK3ByaW50KCYjMzk7TGF1bmNoaW5n
IFByb3h5IHByb2Nlc3MmIzM5Oyk7PGJyPg0KJmd0OyArcHJvY2VzcyA9IHN1YnByb2Nlc3MuUG9w
ZW4ocHJveHlfY21kLCBwYXNzX2Zkcz1bcHJveHlfMS5maWxlbm8oKSzCoCDCoCDCoCDCoCDCoCDC
oCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBwcm94eV8yLmZpbGVubygpLCBwcm94eV8zLmZpbGVubygpXSk8YnI+DQomZ3Q7IGRpZmYgLS1n
aXQgYS9zY3JpcHRzL21wcWVtdS1sYXVuY2hlci5weSBiL3NjcmlwdHMvbXBxZW11LWxhdW5jaGVy
LnB5PGJyPg0KJmd0OyBuZXcgZmlsZSBtb2RlIDEwMDc1NTxicj4NCiZndDsgaW5kZXggMDAwMDAw
MDAwMC4uODFlMzcwNjYzZTxicj4NCiZndDsgLS0tIC9kZXYvbnVsbDxicj4NCiZndDsgKysrIGIv
c2NyaXB0cy9tcHFlbXUtbGF1bmNoZXIucHk8YnI+DQomZ3Q7IEBAIC0wLDAgKzEsNTMgQEA8YnI+
DQomZ3Q7ICsjIS91c3IvYmluL2VudiBweXRob24zPGJyPg0KJmd0OyAraW1wb3J0IHNvY2tldDxi
cj4NCiZndDsgK2ltcG9ydCBvczxicj4NCiZndDsgK2ltcG9ydCBzdWJwcm9jZXNzPGJyPg0KJmd0
OyAraW1wb3J0IHRpbWU8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtQUk9DX1FFTVU9JiMzOTsvdXNy
L2Jpbi9xZW11LXN5c3RlbS14ODZfNjQmIzM5Ozxicj4NCiZndDsgKzxicj4NCiZndDsgK1BST0Nf
UkVNT1RFPSYjMzk7L3Vzci9iaW4vcWVtdS1zY3NpLWRldiYjMzk7PGJyPg0KJmd0OyArPGJyPg0K
Jmd0OyArcHJveHksIHJlbW90ZSA9IHNvY2tldC5zb2NrZXRwYWlyKHNvY2tldC5BRl9VTklYLCBz
b2NrZXQuU09DS19TVFJFQU0pPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArcmVtb3RlX2NtZCA9IFsg
UFJPQ19SRU1PVEUswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc3RyKHJlbW90ZS5maWxlbm8oKSkswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kZXZpY2UmIzM5OywgJiMzOTtsc2k1M2M4OTVhLGlk
PWxzaTEmIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kcml2ZSYjMzk7LCAm
IzM5O2lkPWRyaXZlX2ltYWdlMSxmaWxlPS9idWlsZC9vbDctbnZtZS10ZXN0LTEucWNvdzImIzM5
OyzCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kZXZpY2UmIzM5
OywgJiMzOTtzY3NpLWhkLGlkPWRyaXZlMSxkcml2ZT1kcml2ZV9pbWFnZTEsYnVzPWxzaTEuMCwm
IzM5O8KgIMKgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgICYjMzk7c2NzaS1pZD0wJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAmIzM5Oy1kZXZpY2UmIzM5OywgJiMzOTtsc2k1M2M4OTVhLGlkPWxzaTImIzM5OyzC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kcml2ZSYjMzk7LCAmIzM5O2lkPWRyaXZl
X2ltYWdlMixmaWxlPS9idWlsZC9vbDctbnZtZS10ZXN0LTIucWNvdzImIzM5OyzCoCBcPGJyPg0K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kZXZpY2UmIzM5OywgJiMzOTtzY3Np
LWhkLGlkPWRyaXZlMixkcml2ZT1kcml2ZV9pbWFnZTIsYnVzPWxzaTIuMCwmIzM5O8KgIMKgXDxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICYj
Mzk7c2NzaS1pZD0wJiMzOTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqBdPGJyPg0K
Jmd0OyArPGJyPg0KJmd0OyArcHJveHlfY21kID0gWyBQUk9DX1FFTVUswqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstbmFtZSYj
Mzk7LCAmIzM5O09MNy40JiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgICYjMzk7LW1hY2hpbmUmIzM5OywgJiMzOTtxMzUsYWNjZWw9a3ZtJiMzOTss
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBc
PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstc21wJiMzOTssICYjMzk7c29j
a2V0cz0xLGNvcmVzPTEsdGhyZWFkcz0xJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstbSYj
Mzk7LCAmIzM5OzIwNDgmIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstb2JqZWN0JiMzOTssICYjMzk7bWVtb3J5LWJhY2tlbmQt
bWVtZmQsaWQ9c3lzbWVtLWZpbGUsc2l6ZT0yRyYjMzk7LMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1udW1hJiMzOTssICYjMzk7bm9kZSxtZW1kZXY9
c3lzbWVtLWZpbGUmIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstZGV2aWNlJiMzOTss
ICYjMzk7dmlydGlvLXNjc2ktcGNpLGlkPXZpcnRpb19zY3NpX3BjaTAmIzM5OyzCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstZHJp
dmUmIzM5OywgJiMzOTtpZD1kcml2ZV9pbWFnZTEsaWY9bm9uZSxmb3JtYXQ9cWNvdzIsJiMzOTvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTtmaWxlPS9ob21lL29sNy1oZGQtMS5xY293MiYjMzk7
LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCAmIzM5Oy1kZXZpY2UmIzM5OywgJiMzOTtzY3NpLWhkLGlkPWltYWdlMSxkcml2
ZT1kcml2ZV9pbWFnZTEsJiMzOTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7YnVzPXZpcnRp
b19zY3NpX3BjaTAuMCYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
XDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LWJvb3QmIzM5OywgJiMzOTtk
JiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgICYjMzk7LXZuYyYjMzk7LCAmIzM5OzowJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LWRldmljZSYjMzk7LCAmIzM5O3Bj
aS1wcm94eS1kZXYsaWQ9bHNpMSxzb2NrZXQ9JiMzOTsrc3RyKHByb3h5LmZpbGVubygpKSzCoCBc
PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstZGV2aWNlJiMzOTssICYjMzk7
cGNpLXByb3h5LWRldixpZD1sc2kyLHNvY2tldD0mIzM5OytzdHIocHJveHkuZmlsZW5vKCkpwqAg
wqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgXTxicj4NCiZndDsgKzxicj4NCiZndDsg
Kzxicj4NCiZndDsgK3BpZCA9IG9zLmZvcmsoKTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtpZiBw
aWQ6PGJyPg0KJmd0OyArwqAgwqAgIyBJbiBQcm94eTxicj4NCiZndDsgK8KgIMKgIHByaW50KCYj
Mzk7TGF1bmNoaW5nIFFFTVUgd2l0aCBQcm94eSBvYmplY3QmIzM5Oyk7PGJyPg0KJmd0OyArwqAg
wqAgcHJvY2VzcyA9IHN1YnByb2Nlc3MuUG9wZW4ocHJveHlfY21kLCBwYXNzX2Zkcz1bcHJveHku
ZmlsZW5vKCldKTxicj4NCiZndDsgK2Vsc2U6PGJyPg0KJmd0OyArwqAgwqAgIyBJbiByZW1vdGU8
YnI+DQomZ3Q7ICvCoCDCoCBwcmludCgmIzM5O0xhdW5jaGluZyBSZW1vdGUgcHJvY2VzcyYjMzk7
KTs8YnI+DQomZ3Q7ICvCoCDCoCBwcm9jZXNzID0gc3VicHJvY2Vzcy5Qb3BlbihyZW1vdGVfY21k
LCBwYXNzX2Zkcz1bcmVtb3RlLmZpbGVubygpXSk8YnI+DQomZ3Q7IC0tIDxicj4NCiZndDsgMi4y
NS5HSVQ8YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZn
dDsgLS0gPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIOatpOiHtDxicj4NCiZndDsg56S8PGJyPg0K
Jmd0OyDnvZfli4fliJo8YnI+DQomZ3Q7IFlvdXJzPGJyPg0KJmd0O8KgIMKgIMKgc2luY2VyZWx5
LDxicj4NCiZndDsgWW9uZ2dhbmcgTHVvPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2Pjxi
ciBjbGVhcj0iYWxsIj48ZGl2Pjxicj48L2Rpdj4tLSA8YnI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9
ImdtYWlsX3NpZ25hdHVyZSI+wqAgwqAgwqAgwqDCoCDmraToh7Q8YnI+56S8PGJyPue9l+WLh+WI
mjxicj5Zb3Vyczxicj7CoCDCoCBzaW5jZXJlbHksPGJyPllvbmdnYW5nIEx1bzxicj48L2Rpdj48
L2Rpdj4NCg==
--000000000000f595d405a3fd27a1--

