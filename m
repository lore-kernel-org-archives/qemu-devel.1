Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD2DC2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 00:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7532220724
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 00:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W20/3h7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7532220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRmJw-0005sr-IS
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 20:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jRmIm-0005I4-2C
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 20:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jRmIk-0003F2-13
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 20:34:43 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:45674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jRmIj-00035M-9d
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 20:34:41 -0400
Received: by mail-lf1-x141.google.com with SMTP id f8so6260896lfe.12
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 17:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=s+fLu8+kpYL2UDxQpBvR5mRT3cXwuSE98RBxX18/uQo=;
 b=W20/3h7wcsV5fyNTi3nDvjJgXr4yh0g4T0G3viPtGeZzgx57ON5WcggMP8mC3jD3ot
 L8BY1rWHg9WVq6AznXr3WB7j7YGKM/Y4s37+cgVSGzjgae6wO+Dv7St2YiMQ0AMHI9x2
 VjK64PflAr98v/XQYBeyCtJjlA41bpje43xpaC0MhSqe11YhzT6FTFvewbkwaef0hnBU
 8Ir4sL2MYsr0P2jPRsVrp7oNS0QNaid7JIFr13pG931AvkmveKdGIp+1aJ+i/s+bzEUi
 Y9PP2VonQD7HuQSH9cCyPyZ0VkoyOYvmWRbdsbl/L8Cm4OqlgxQk2DNvi6uM4U7yX2jd
 b+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=s+fLu8+kpYL2UDxQpBvR5mRT3cXwuSE98RBxX18/uQo=;
 b=iC4u14kBrBurX7Vxks1yqFjXZDwSt4nrwn+ShpCldeskptFLHZ7mBhGExfczN8duiv
 ONQ2zP55Z6+ZibNViTmPL0pRTlK7K646FJp+qGwz9P2t2jCz8qWkcJQOr2izkfWTRepr
 EUikW9S+jCM8l9iSVBB5AgmJwBV0UsV/bhlyOMnaKUr0fEEirN/5Cw8vPGVofmqfajvk
 eTMjHkCRO0E6gFwPGluh5f9/2HE1z4R9E/fKNNx1ZNxrQGkwC66eMh8uLfZRsbuQ5s8s
 VHgqgATfaBLjJIMcsweKU9nxVkrxcO9IynYVzf5Mnck7tDQShih4MhYirrDFROQaE7tX
 0/Qg==
X-Gm-Message-State: AGi0PuZ1lOpihI55t/YM6t4XgQ8K7jw7UnNHzBnxAxExDfWcoKw5imA+
 AleIEK/FcXuotCZlXXmL7eZlq4jXkpIKmzAY7qo=
X-Google-Smtp-Source: APiQypL5iGoWpB3YaJu71y+QbuXrUmZgRyQDmPjChp2tiIemhGafTqSOT+LFLORXxhrxgCnokwiSd2BQ49o0zOMtQoY=
X-Received: by 2002:a19:700b:: with SMTP id h11mr4242097lfc.89.1587688478501; 
 Thu, 23 Apr 2020 17:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <526ab3d1a840ad0693c6c8d38e56602d2c53024b.1587614626.git.elena.ufimtseva@oracle.com>
 <CAE2XoE8WeGXL93G6uLsKDVNrjxWFq5PTO853bdkuzDQ9fB9dtw@mail.gmail.com>
 <271ABACC-3817-43CF-8752-F0FBDDDE6080@oracle.com>
In-Reply-To: <271ABACC-3817-43CF-8752-F0FBDDDE6080@oracle.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 24 Apr 2020 08:34:27 +0800
Message-ID: <CAE2XoE-mh-201qsJ_WfKUe7paVp_Dez8xJtgqXASo3ncd8t1RQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 36/36] multi-process: add configure and usage
 information
To: Jag Raman <jag.raman@oracle.com>
Content-Type: multipart/alternative; boundary="000000000000c66ea305a3fe8785"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::141
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

--000000000000c66ea305a3fe8785
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
> > And also, can the python script be replaced by C implementation?
>
> The functionality in the python script would eventually move to libvirt.
> The python
> script is a temporary measure.
>
> I suggest use qemu as the driver like clang-cl, we preseve the options
currently avaiable in qemu
and then starting remote process by qemu directly, so we libvirt need to
lauch with qemu

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

--000000000000c66ea305a3fe8785
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
V2luZG93cz88YnI+DQo8YnI+DQomZ3Q7IEFuZCBhbHNvLCBjYW4gdGhlIHB5dGhvbiBzY3JpcHQg
YmUgcmVwbGFjZWQgYnkgQyBpbXBsZW1lbnRhdGlvbj88YnI+DQo8YnI+DQpUaGUgZnVuY3Rpb25h
bGl0eSBpbiB0aGUgcHl0aG9uIHNjcmlwdCB3b3VsZCBldmVudHVhbGx5IG1vdmUgdG8gbGlidmly
dC4gVGhlIHB5dGhvbjxicj4NCnNjcmlwdCBpcyBhIHRlbXBvcmFyeSBtZWFzdXJlLjxicj4NCjxi
cj48L2Jsb2NrcXVvdGU+PGRpdj5JIHN1Z2dlc3QgdXNlIHFlbXUgYXMgdGhlIGRyaXZlciBsaWtl
IGNsYW5nLWNsLCB3ZSBwcmVzZXZlIHRoZSBvcHRpb25zIGN1cnJlbnRseSBhdmFpYWJsZSBpbiBx
ZW11PC9kaXY+PGRpdj5hbmQgdGhlbiBzdGFydGluZyByZW1vdGUgcHJvY2VzcyBieSBxZW11IGRp
cmVjdGx5LCBzbyB3ZSBsaWJ2aXJ0IG5lZWQgdG8gbGF1Y2ggd2l0aCBxZW11PC9kaXY+PGRpdj48
L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+DQpUaGFuayB5b3UgdmVyeSBtdWNoITxicj4NCuKAlDxicj4NCkphZzxicj4N
Cjxicj4NCiZndDsgPGJyPg0KJmd0OyBPbiBUaHUsIEFwciAyMywgMjAyMCBhdCAxMjozOCBQTSAm
bHQ7PGEgaHJlZj0ibWFpbHRvOmVsZW5hLnVmaW10c2V2YUBvcmFjbGUuY29tIiB0YXJnZXQ9Il9i
bGFuayI+ZWxlbmEudWZpbXRzZXZhQG9yYWNsZS5jb208L2E+Jmd0OyB3cm90ZTo8YnI+DQomZ3Q7
IEZyb206IEVsZW5hIFVmaW10c2V2YSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmVsZW5hLnVmaW10c2V2
YUBvcmFjbGUuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZWxlbmEudWZpbXRzZXZhQG9yYWNsZS5jb208
L2E+Jmd0Ozxicj4NCiZndDsgPGJyPg0KJmd0OyBTaWduZWQtb2ZmLWJ5OiBFbGVuYSBVZmltdHNl
dmEgJmx0OzxhIGhyZWY9Im1haWx0bzplbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbSIgdGFyZ2V0
PSJfYmxhbmsiPmVsZW5hLnVmaW10c2V2YUBvcmFjbGUuY29tPC9hPiZndDs8YnI+DQomZ3Q7IFNp
Z25lZC1vZmYtYnk6IEphZ2FubmF0aGFuIFJhbWFuICZsdDs8YSBocmVmPSJtYWlsdG86amFnLnJh
bWFuQG9yYWNsZS5jb20iIHRhcmdldD0iX2JsYW5rIj5qYWcucmFtYW5Ab3JhY2xlLmNvbTwvYT4m
Z3Q7PGJyPg0KJmd0OyBTaWduZWQtb2ZmLWJ5OiBKb2huIEcgSm9obnNvbiAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmpvaG4uZy5qb2huc29uQG9yYWNsZS5jb20iIHRhcmdldD0iX2JsYW5rIj5qb2huLmcu
am9obnNvbkBvcmFjbGUuY29tPC9hPiZndDs8YnI+DQomZ3Q7IC0tLTxicj4NCiZndDvCoCBNQUlO
VEFJTkVSU8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICs8YnI+
DQomZ3Q7wqAgZG9jcy9tdWx0aS1wcm9jZXNzLnJzdMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCA4
NSArKysrKysrKysrKysrKysrKysrKysrKysrPGJyPg0KJmd0O8KgIHNjcmlwdHMvbXBxZW11LWxh
dW5jaGVyLXBlcmYtbW9kZS5weSB8IDkyICsrKysrKysrKysrKysrKysrKysrKysrKysrKys8YnI+
DQomZ3Q7wqAgc2NyaXB0cy9tcHFlbXUtbGF1bmNoZXIucHnCoCDCoCDCoCDCoCDCoCDCoHwgNTMg
KysrKysrKysrKysrKysrKzxicj4NCiZndDvCoCA0IGZpbGVzIGNoYW5nZWQsIDIzMiBpbnNlcnRp
b25zKCspPGJyPg0KJmd0O8KgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL211bHRpLXByb2Nlc3Mu
cnN0PGJyPg0KJmd0O8KgIGNyZWF0ZSBtb2RlIDEwMDc1NSBzY3JpcHRzL21wcWVtdS1sYXVuY2hl
ci1wZXJmLW1vZGUucHk8YnI+DQomZ3Q7wqAgY3JlYXRlIG1vZGUgMTAwNzU1IHNjcmlwdHMvbXBx
ZW11LWxhdW5jaGVyLnB5PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IGRpZmYgLS1naXQgYS9NQUlOVEFJ
TkVSUyBiL01BSU5UQUlORVJTPGJyPg0KJmd0OyBpbmRleCBlZDQ4NjE1ZTE1Li44ZmYzYmZhZTZh
IDEwMDY0NDxicj4NCiZndDsgLS0tIGEvTUFJTlRBSU5FUlM8YnI+DQomZ3Q7ICsrKyBiL01BSU5U
QUlORVJTPGJyPg0KJmd0OyBAQCAtMjg4MCw2ICsyODgwLDggQEAgRjogcmVtb3RlL2lvaHViLmM8
YnI+DQomZ3Q7wqAgRjogcmVtb3RlL3JlbW90ZS1vcHRzLmg8YnI+DQomZ3Q7wqAgRjogcmVtb3Rl
L3JlbW90ZS1vcHRzLmM8YnI+DQomZ3Q7wqAgRjogZG9jcy9kZXZlbC9tdWx0aS1wcm9jZXNzLnJz
dDxicj4NCiZndDsgK0Y6IHNjcmlwdHMvbXBxZW11LWxhdW5jaGVyLnB5PGJyPg0KJmd0OyArRjog
c2NyaXB0cy9tcHFlbXUtbGF1bmNoZXItcGVyZi1tb2RlLnB5PGJyPg0KJmd0OyA8YnI+DQomZ3Q7
wqAgQnVpbGQgYW5kIHRlc3QgYXV0b21hdGlvbjxicj4NCiZndDvCoCAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tPGJyPg0KJmd0OyBkaWZmIC0tZ2l0IGEvZG9jcy9tdWx0aS1wcm9jZXNzLnJzdCBi
L2RvY3MvbXVsdGktcHJvY2Vzcy5yc3Q8YnI+DQomZ3Q7IG5ldyBmaWxlIG1vZGUgMTAwNjQ0PGJy
Pg0KJmd0OyBpbmRleCAwMDAwMDAwMDAwLi44Mzg3ZDZjNjkxPGJyPg0KJmd0OyAtLS0gL2Rldi9u
dWxsPGJyPg0KJmd0OyArKysgYi9kb2NzL211bHRpLXByb2Nlc3MucnN0PGJyPg0KJmd0OyBAQCAt
MCwwICsxLDg1IEBAPGJyPg0KJmd0OyArTXVsdGktcHJvY2VzcyBRRU1VPGJyPg0KJmd0OyArPT09
PT09PT09PT09PT09PT09PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArVGhpcyBkb2N1bWVudCBkZXNj
cmliZXMgaG93IHRvIGNvbmZpZ3VyZSBhbmQgdXNlIG11bHRpLXByb2Nlc3MgcWVtdS48YnI+DQom
Z3Q7ICtGb3IgdGhlIGRlc2lnbiBkb2N1bWVudCByZWZlciB0byBkb2NzL2RldmVsL3FlbXUtbXVs
dGlwcm9jZXNzLjxicj4NCiZndDsgKzxicj4NCiZndDsgKzEpIENvbmZpZ3VyYXRpb248YnI+DQom
Z3Q7ICstLS0tLS0tLS0tLS0tLS0tPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArVG8gZW5hYmxlIHN1
cHBvcnQgZm9yIG11bHRpLXByb2Nlc3MgYWRkIC0tZW5hYmxlLW1wcWVtdTxicj4NCiZndDsgK3Rv
IHRoZSBsaXN0IG9mIG9wdGlvbnMgZm9yIHRoZSAmcXVvdDtjb25maWd1cmUmcXVvdDsgc2NyaXB0
Ljxicj4NCiZndDsgKzxicj4NCiZndDsgKzxicj4NCiZndDsgKzIpIFVzYWdlPGJyPg0KJmd0OyAr
LS0tLS0tLS08YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtNdWx0aS1wcm9jZXNzIFFFTVUgcmVxdWly
ZXMgYW4gb3JjaGVzdHJhdG9yIHRvIGxhdW5jaC4gUGxlYXNlIHJlZmVyIHRvIGE8YnI+DQomZ3Q7
ICtsaWdodC13ZWlnaHQgcHl0aG9uIGJhc2VkIG9yY2hlc3RyYXRvciBmb3IgbXBxZW11IGluPGJy
Pg0KJmd0OyArc2NyaXB0cy9tcHFlbXUtbGF1bmNoZXIucHkgdG8gbGF1Y2ggUUVNVSBpbiBtdWx0
aS1wcm9jZXNzIG1vZGUuPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArc2NyaXB0cy9tcHFlbXUtbGF1
bmNoZXItcGVyZi1tb2RlLnB5IGxhdW5jaGVzIGluICZxdW90O3BlcmYmcXVvdDsgbW9kZS4gSW4g
dGhpcyBtb2RlLDxicj4NCiZndDsgK3RoZSBzYW1lIFFFTVUgcHJvY2VzcyBjb25uZWN0cyB0byBt
dWx0aXBsZSByZW1vdGUgZGV2aWNlcywgZWFjaCBlbXVsYXRlZCBpbjxicj4NCiZndDsgK2Egc2Vw
YXJhdGUgcHJvY2Vzcy48YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtBcyBvZiBub3csIHdlIG9ubHkg
c3VwcG9ydCB0aGUgZW11bGF0aW9uIG9mIGxzaTUzYzg5NWEgaW4gYSBzZXBhcmF0ZSBwcm9jZXNz
Ljxicj4NCiZndDsgKzxicj4NCiZndDsgK0ZvbGxvd2luZyBpcyBhIGRlc2NyaXB0aW9uIG9mIGNv
bW1hbmQtbGluZSB1c2VkIHRvIGxhdW5jaCBtcHFlbXUuPGJyPg0KJmd0OyArPGJyPg0KJmd0OyAr
KiBPcmNoZXN0cmF0b3I6PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgLSBUaGUgT3JjaGVzdHJh
dG9yIGNyZWF0ZXMgYSB1bml4IHNvY2tldHBhaXI8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCAt
IEl0IGxhdW5jaGVzIHRoZSByZW1vdGUgcHJvY2VzcyBhbmQgcGFzc2VzIG9uZSBvZiB0aGU8YnI+
DQomZ3Q7ICvCoCDCoCBzb2NrZXRzIHRvIGl0IHZpYSBjb21tYW5kLWxpbmUuPGJyPg0KJmd0OyAr
PGJyPg0KJmd0OyArwqAgLSBJdCB0aGVuIGxhdW5jaGVzIFFFTVUgYW5kIHNwZWNpZmllcyB0aGUg
b3RoZXIgc29ja2V0IGFzIGFuIG9wdGlvbjxicj4NCiZndDsgK8KgIMKgIHRvIHRoZSBQcm94eSBk
ZXZpY2Ugb2JqZWN0PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArKiBSZW1vdGUgUHJvY2Vzczo8YnI+
DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCAtIFRoZSBmaXJzdCBjb21tYW5kLWxpbmUgb3B0aW9uIGlu
IHRoZSByZW1vdGUgcHJvY2VzcyBpcyBvbmUgb2YgdGhlPGJyPg0KJmd0OyArwqAgwqAgc29ja2V0
cyBjcmVhdGVkIGJ5IHRoZSBPcmNoZXN0cmF0b3I8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCAt
IFRoZSByZW1haW5pbmcgb3B0aW9ucyBhcmUgbm8gZGlmZmVyZW50IGZyb20gaG93IG9uZSBsYXVu
Y2hlcyBRRU1VIHdpdGg8YnI+DQomZ3Q7ICvCoCDCoCBkZXZpY2VzLiBUaGUgb25seSBvdGhlciBy
ZXF1aXJlbWVudCBpcyBlYWNoIFBDSSBkZXZpY2UgbXVzdCBoYXZlIGE8YnI+DQomZ3Q7ICvCoCDC
oCB1bmlxdWUgSUQgc3BlY2lmaWVkIHRvIGl0LiBUaGlzIGlzIG5lZWRlZCB0byBwYWlyIHJlbW90
ZSBkZXZpY2Ugd2l0aCB0aGU8YnI+DQomZ3Q7ICvCoCDCoCBQcm94eSBvYmplY3QuPGJyPg0KJmd0
OyArPGJyPg0KJmd0OyArwqAgLSBFeGFtcGxlIGNvbW1hbmQtbGluZSBmb3IgdGhlIHJlbW90ZSBw
cm9jZXNzIGlzIGFzIGZvbGxvd3M6PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqAgL3Vz
ci9iaW4vcWVtdS1zY3N1LWRldiA0wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgLWRldmlj
ZSBsc2k1M2M4OTVhLGlkPWxzaTDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCAtZHJpdmUgaWQ9
ZHJpdmVfaW1hZ2UyLGZpbGU9L2J1aWxkL29sNy1udm1lLXRlc3QtMS5xY293MsKgIMKgIMKgIMKg
IMKgIMKgXDxicj4NCiZndDsgK8KgIMKgIMKgIC1kZXZpY2Ugc2NzaS1oZCxpZD1kcml2ZTIsZHJp
dmU9ZHJpdmVfaW1hZ2UyLGJ1cz1sc2kwLjAsc2NzaS1pZD0wPGJyPg0KJmd0OyArPGJyPg0KJmd0
OyArKiBRRU1VOjxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIC0gU2luY2UgcGFydHMgb2YgdGhl
IFJBTSBhcmUgc2hhcmVkIGJldHdlZW4gUUVNVSAmYW1wOyByZW1vdGUgcHJvY2VzcywgYTxicj4N
CiZndDsgK8KgIMKgIG1lbW9yeS1iYWNrZW5kLW1lbWZkIGlzIHJlcXVpcmVkIHRvIGZhY2lsaXRh
dGUgdGhpcywgYXMgZm9sbG93czo8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCAtb2JqZWN0
IG1lbW9yeS1iYWNrZW5kLW1lbWZkLGlkPW1lbSxzaXplPTJHPGJyPg0KJmd0OyArPGJyPg0KJmd0
OyArwqAgLSBBICZxdW90O3BjaS1wcm94eS1kZXYmcXVvdDsgZGV2aWNlIGlzIGNyZWF0ZWQgZm9y
IGVhY2ggb2YgdGhlIFBDSSBkZXZpY2VzIGVtdWxhdGVkPGJyPg0KJmd0OyArwqAgwqAgaW4gdGhl
IHJlbW90ZSBwcm9jZXNzLiBBICZxdW90O3NvY2tldCZxdW90OyBzdWItb3B0aW9uIHNwZWNpZmll
cyB0aGUgb3RoZXIgZW5kIG9mPGJyPg0KJmd0OyArwqAgwqAgdW5peCBjaGFubmVsIGNyZWF0ZWQg
Ynkgb3JjaGVzdHJhdG9yLiBUaGUgJnF1b3Q7aWQmcXVvdDsgc3ViLW9wdGlvbiBtdXN0IGJlIHNw
ZWNpZmllZDxicj4NCiZndDsgK8KgIMKgIGFuZCBzaG91bGQgYmUgdGhlIHNhbWUgYXMgdGhlICZx
dW90O2lkJnF1b3Q7IHNwZWNpZmllZCBmb3IgdGhlIHJlbW90ZSBQQ0kgZGV2aWNlPGJyPg0KJmd0
OyArPGJyPg0KJmd0OyArwqAgLSBFeGFtcGxlIGNvbW1hbmRsaW5lIGZvciBRRU1VIGlzIGFzIGZv
bGxvd3M6PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgwqAgwqAgLWRldmljZSBwY2ktcHJveHkt
ZGV2LGlkPWxzaTAsc29ja2V0PTM8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICsqIE1vbml0b3IgLyBR
TVA6PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArwqAgLSBUaGUgcmVtb3RlIHByb2Nlc3Mgc3VwcG9y
dHMgUUVNVSBtb25pdG9yLiBJdCBjb3VsZCBiZSBzcGVjaWZpZWQgdXNpbmcgdGhlPGJyPg0KJmd0
OyArwqAgwqAgJnF1b3Q7LW1vbml0b3ImcXVvdDsgb3IgJnF1b3Q7LXFtcCZxdW90OyBjb21tYW5k
LWxpbmUgb3B0aW9uczxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIC0gQXMgYW4gZXhhbXBsZSwg
b25lIGNvdWxkIGNvbm5lY3QgdG8gdGhlIG1vbml0b3IgYnkgYWRkaW5nIHRoZSBmb2xsb3dpbmc8
YnI+DQomZ3Q7ICvCoCDCoCB0byB0aGUgY29tbWFuZC1saW5lIG9mIHRoZSByZW1vdGUgcHJvY2Vz
czxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgIC1tb25pdG9yIHVuaXg6L2hvbWUvcW1w
LXNvY2ssc2VydmVyLG5vd2FpdDxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIC0gVGhlIHVzZXIg
Y291bGQgY29ubmVjdCB0byB0aGUgbW9uaXRvciB1c2luZyB0aGUgcW1wIHNjcmlwdCBvciB1c2lu
Zzxicj4NCiZndDsgK8KgIMKgICZxdW90O3NvY2F0JnF1b3Q7IGFzIG91dGxpbmVkIGJlbG93Ojxi
cj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIMKgIHNvY2F0IC9ob21lL3FtcC1zb2NrIHN0ZGlv
PGJyPg0KJmd0OyBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9tcHFlbXUtbGF1bmNoZXItcGVyZi1tb2Rl
LnB5IGIvc2NyaXB0cy9tcHFlbXUtbGF1bmNoZXItcGVyZi1tb2RlLnB5PGJyPg0KJmd0OyBuZXcg
ZmlsZSBtb2RlIDEwMDc1NTxicj4NCiZndDsgaW5kZXggMDAwMDAwMDAwMC4uMjczMzQyNGM3Njxi
cj4NCiZndDsgLS0tIC9kZXYvbnVsbDxicj4NCiZndDsgKysrIGIvc2NyaXB0cy9tcHFlbXUtbGF1
bmNoZXItcGVyZi1tb2RlLnB5PGJyPg0KJmd0OyBAQCAtMCwwICsxLDkyIEBAPGJyPg0KJmd0OyAr
IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMzxicj4NCiZndDsgKzxicj4NCiZndDsgK2ltcG9ydCBzb2Nr
ZXQ8YnI+DQomZ3Q7ICtpbXBvcnQgb3M8YnI+DQomZ3Q7ICtpbXBvcnQgc3VicHJvY2Vzczxicj4N
CiZndDsgK2ltcG9ydCB0aW1lPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArUFJPQ19RRU1VPSYjMzk7
L3Vzci9iaW4vcWVtdS1zeXN0ZW0teDg2XzY0JiMzOTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtQ
Uk9DX1JFTU9URT0mIzM5Oy91c3IvYmluL3FlbXUtc2NzaS1kZXYmIzM5Ozxicj4NCiZndDsgKzxi
cj4NCiZndDsgK3Byb3h5XzEsIHJlbW90ZV8xID0gc29ja2V0LnNvY2tldHBhaXIoc29ja2V0LkFG
X1VOSVgsIHNvY2tldC5TT0NLX1NUUkVBTSk8YnI+DQomZ3Q7ICtwcm94eV8yLCByZW1vdGVfMiA9
IHNvY2tldC5zb2NrZXRwYWlyKHNvY2tldC5BRl9VTklYLCBzb2NrZXQuU09DS19TVFJFQU0pPGJy
Pg0KJmd0OyArcHJveHlfMywgcmVtb3RlXzMgPSBzb2NrZXQuc29ja2V0cGFpcihzb2NrZXQuQUZf
VU5JWCwgc29ja2V0LlNPQ0tfU1RSRUFNKTxicj4NCiZndDsgKzxicj4NCiZndDsgK3JlbW90ZV9j
bWRfMSA9IFsgUFJPQ19SRU1PVEUswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RyKHJlbW90ZV8xLmZpbGVubygpKSzCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRldmljZSYjMzk7LCAmIzM5O2xzaTUz
Yzg5NWEsaWQ9bHNpMSYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRyaXZl
JiMzOTssICYjMzk7aWQ9ZHJpdmVfaW1hZ2UxLCYjMzk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJiMzOTtmaWxlPS9idWlsZC9vbDctbnZtZS10
ZXN0LTEucWNvdzImIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kZXZpY2UmIzM5OywgJiMzOTtzY3NpLWhkLGlkPWRyaXZl
MSxkcml2ZT1kcml2ZV9pbWFnZTEsJiMzOTvCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTtidXM9
bHNpMS4wLHNjc2ktaWQ9MCYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF08YnI+DQomZ3Q7ICs8YnI+DQom
Z3Q7ICtyZW1vdGVfY21kXzIgPSBbIFBST0NfUkVNT1RFLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+
DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cihyZW1vdGVfMi5maWxlbm8oKSks
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kZXZpY2UmIzM5
OywgJiMzOTtsc2k1M2M4OTVhLGlkPWxzaTImIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAmIzM5Oy1kcml2ZSYjMzk7LCAmIzM5O2lkPWRyaXZlX2ltYWdlMiwmIzM5O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7ZmlsZT0vYnVp
bGQvb2w3LW52bWUtdGVzdC0yLnFjb3cyJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJiMzOTstZGV2aWNlJiMzOTssICYjMzk7c2Nz
aS1oZCxpZD1kcml2ZTIsZHJpdmU9ZHJpdmVfaW1hZ2UyLCYjMzk7wqAgwqAgwqAgwqAgwqAgwqAg
XDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgICYjMzk7YnVzPWxzaTIuMCxzY3NpLWlkPTAmIzM5O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXTxicj4N
CiZndDsgKzxicj4NCiZndDsgK3JlbW90ZV9jbWRfMyA9IFsgUFJPQ19SRU1PVEUswqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RyKHJlbW90
ZV8zLmZpbGVubygpKSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYj
Mzk7LWRldmljZSYjMzk7LCAmIzM5O2xzaTUzYzg5NWEsaWQ9bHNpMyYjMzk7LMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRyaXZlJiMzOTssICYjMzk7aWQ9ZHJpdmVfaW1hZ2UzLCYj
Mzk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
JiMzOTtmaWxlPS9idWlsZC9vbDctbnZtZS10ZXN0LTMucWNvdzImIzM5OyzCoCDCoCDCoCDCoCDC
oCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kZXZpY2Um
IzM5OywgJiMzOTtzY3NpLWhkLGlkPWRyaXZlMyxkcml2ZT1kcml2ZV9pbWFnZTMsJiMzOTvCoCDC
oCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgJiMzOTtidXM9bHNpMy4wLHNjc2ktaWQ9MCYjMzk7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBdPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArcHJveHlfY21kID0gWyBQUk9DX1FFTVUs
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgJiMzOTstbmFtZSYjMzk7LCAmIzM5O09MNy40JiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LW1hY2hpbmUmIzM5OywgJiMzOTtxMzUs
YWNjZWw9a3ZtJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstc21w
JiMzOTssICYjMzk7c29ja2V0cz0xLGNvcmVzPTEsdGhyZWFkcz0xJiMzOTsswqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJiMzOTstbSYjMzk7LCAmIzM5OzIwNDgmIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBc
PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstb2JqZWN0JiMzOTssICYjMzk7
bWVtb3J5LWJhY2tlbmQtbWVtZmQsaWQ9c3lzbWVtLWZpbGUsc2l6ZT0yRyYjMzk7LMKgIMKgIMKg
IMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1udW1hJiMzOTssICYj
Mzk7bm9kZSxtZW1kZXY9c3lzbWVtLWZpbGUmIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMz
OTstZGV2aWNlJiMzOTssICYjMzk7dmlydGlvLXNjc2ktcGNpLGlkPXZpcnRpb19zY3NpX3BjaTAm
IzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJiMzOTstZHJpdmUmIzM5OywgJiMzOTtpZD1kcml2ZV9pbWFnZTEsaWY9bm9uZSxmb3Jt
YXQ9cWNvdzIsJiMzOTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTtmaWxlPS9ob21lL29sNy1o
ZGQtMS5xY293MiYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQom
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1kZXZpY2UmIzM5OywgJiMzOTtzY3NpLWhk
LGlkPWltYWdlMSxkcml2ZT1kcml2ZV9pbWFnZTEsJiMzOTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCYjMzk7YnVzPXZpcnRpb19zY3NpX3BjaTAuMCYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LWJv
b3QmIzM5OywgJiMzOTtkJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LXZuYyYjMzk7LCAmIzM5OzowJiMzOTsswqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LWRldmlj
ZSYjMzk7LCAmIzM5O3BjaS1wcm94eS1kZXYsaWQ9bHNpMSwmIzM5O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7c29ja2V0PSYjMzk7K3N0cihwcm94eV8x
LmZpbGVubygpKSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAgJiMzOTstZGV2aWNlJiMzOTssICYjMzk7cGNpLXByb3h5LWRldixpZD1s
c2kyLCYjMzk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJiMz
OTtzb2NrZXQ9JiMzOTsrc3RyKHByb3h5XzIuZmlsZW5vKCkpLMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1kZXZpY2UmIzM5
OywgJiMzOTtwY2ktcHJveHktZGV2LGlkPWxzaTMsJiMzOTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5O3NvY2tldD0mIzM5OytzdHIocHJveHlfMy5maWxl
bm8oKSnCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCBdPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArcGlkID0gb3MuZm9y
aygpOzxicj4NCiZndDsgK2lmIHBpZCA9PSAwOjxicj4NCiZndDsgK8KgIMKgICMgSW4gcmVtb3Rl
XzE8YnI+DQomZ3Q7ICvCoCDCoCBwcmludCgmIzM5O0xhdW5jaGluZyBSZW1vdGUgcHJvY2VzcyAx
JiMzOTspOzxicj4NCiZndDsgK8KgIMKgIHByb2Nlc3MgPSBzdWJwcm9jZXNzLlBvcGVuKHJlbW90
ZV9jbWRfMSwgcGFzc19mZHM9W3JlbW90ZV8xLmZpbGVubygpXSk8YnI+DQomZ3Q7ICvCoCDCoCBv
cy5fZXhpdCgwKTxicj4NCiZndDsgKzxicj4NCiZndDsgKzxicj4NCiZndDsgK3BpZCA9IG9zLmZv
cmsoKTs8YnI+DQomZ3Q7ICtpZiBwaWQgPT0gMDo8YnI+DQomZ3Q7ICvCoCDCoCAjIEluIHJlbW90
ZV8yPGJyPg0KJmd0OyArwqAgwqAgcHJpbnQoJiMzOTtMYXVuY2hpbmcgUmVtb3RlIHByb2Nlc3Mg
MiYjMzk7KTs8YnI+DQomZ3Q7ICvCoCDCoCBwcm9jZXNzID0gc3VicHJvY2Vzcy5Qb3BlbihyZW1v
dGVfY21kXzIsIHBhc3NfZmRzPVtyZW1vdGVfMi5maWxlbm8oKV0pPGJyPg0KJmd0OyArwqAgwqAg
b3MuX2V4aXQoMCk8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtwaWQgPSBvcy5m
b3JrKCk7PGJyPg0KJmd0OyAraWYgcGlkID09IDA6PGJyPg0KJmd0OyArwqAgwqAgIyBJbiByZW1v
dGVfMzxicj4NCiZndDsgK8KgIMKgIHByaW50KCYjMzk7TGF1bmNoaW5nIFJlbW90ZSBwcm9jZXNz
IDMmIzM5Oyk7PGJyPg0KJmd0OyArwqAgwqAgcHJvY2VzcyA9IHN1YnByb2Nlc3MuUG9wZW4ocmVt
b3RlX2NtZF8zLCBwYXNzX2Zkcz1bcmVtb3RlXzMuZmlsZW5vKCldKTxicj4NCiZndDsgK8KgIMKg
IG9zLl9leGl0KDApPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArPGJyPg0KJmd0OyArcHJpbnQoJiMz
OTtMYXVuY2hpbmcgUHJveHkgcHJvY2VzcyYjMzk7KTs8YnI+DQomZ3Q7ICtwcm9jZXNzID0gc3Vi
cHJvY2Vzcy5Qb3Blbihwcm94eV9jbWQsIHBhc3NfZmRzPVtwcm94eV8xLmZpbGVubygpLMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHByb3h5XzIuZmlsZW5vKCksIHByb3h5XzMuZmlsZW5vKCldKTxicj4NCiZn
dDsgZGlmZiAtLWdpdCBhL3NjcmlwdHMvbXBxZW11LWxhdW5jaGVyLnB5IGIvc2NyaXB0cy9tcHFl
bXUtbGF1bmNoZXIucHk8YnI+DQomZ3Q7IG5ldyBmaWxlIG1vZGUgMTAwNzU1PGJyPg0KJmd0OyBp
bmRleCAwMDAwMDAwMDAwLi44MWUzNzA2NjNlPGJyPg0KJmd0OyAtLS0gL2Rldi9udWxsPGJyPg0K
Jmd0OyArKysgYi9zY3JpcHRzL21wcWVtdS1sYXVuY2hlci5weTxicj4NCiZndDsgQEAgLTAsMCAr
MSw1MyBAQDxicj4NCiZndDsgKyMhL3Vzci9iaW4vZW52IHB5dGhvbjM8YnI+DQomZ3Q7ICtpbXBv
cnQgc29ja2V0PGJyPg0KJmd0OyAraW1wb3J0IG9zPGJyPg0KJmd0OyAraW1wb3J0IHN1YnByb2Nl
c3M8YnI+DQomZ3Q7ICtpbXBvcnQgdGltZTxicj4NCiZndDsgKzxicj4NCiZndDsgK1BST0NfUUVN
VT0mIzM5Oy91c3IvYmluL3FlbXUtc3lzdGVtLXg4Nl82NCYjMzk7PGJyPg0KJmd0OyArPGJyPg0K
Jmd0OyArUFJPQ19SRU1PVEU9JiMzOTsvdXNyL2Jpbi9xZW11LXNjc2ktZGV2JiMzOTs8YnI+DQom
Z3Q7ICs8YnI+DQomZ3Q7ICtwcm94eSwgcmVtb3RlID0gc29ja2V0LnNvY2tldHBhaXIoc29ja2V0
LkFGX1VOSVgsIHNvY2tldC5TT0NLX1NUUkVBTSk8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtyZW1v
dGVfY21kID0gWyBQUk9DX1JFTU9URSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHIocmVtb3RlLmZpbGVubygpKSzCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRldmljZSYjMzk7LCAmIzM5O2xz
aTUzYzg5NWEsaWQ9bHNpMSYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRy
aXZlJiMzOTssICYjMzk7aWQ9ZHJpdmVfaW1hZ2UxLGZpbGU9L2J1aWxkL29sNy1udm1lLXRlc3Qt
MS5xY293MiYjMzk7LMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7
LWRldmljZSYjMzk7LCAmIzM5O3Njc2ktaGQsaWQ9ZHJpdmUxLGRyaXZlPWRyaXZlX2ltYWdlMSxi
dXM9bHNpMS4wLCYjMzk7wqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTtzY3NpLWlkPTAmIzM5OyzCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRldmljZSYjMzk7LCAmIzM5O2xzaTUzYzg5NWEsaWQ9
bHNpMiYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRyaXZlJiMzOTssICYj
Mzk7aWQ9ZHJpdmVfaW1hZ2UyLGZpbGU9L2J1aWxkL29sNy1udm1lLXRlc3QtMi5xY293MiYjMzk7
LMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRldmljZSYjMzk7
LCAmIzM5O3Njc2ktaGQsaWQ9ZHJpdmUyLGRyaXZlPWRyaXZlX2ltYWdlMixidXM9bHNpMi4wLCYj
Mzk7wqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgJiMzOTtzY3NpLWlkPTAmIzM5O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoF08YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICtwcm94eV9jbWQgPSBbIFBST0NfUUVNVSzCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
IzM5Oy1uYW1lJiMzOTssICYjMzk7T0w3LjQmIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstbWFjaGluZSYjMzk7LCAmIzM5O3EzNSxhY2Nl
bD1rdm0mIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1zbXAmIzM5
OywgJiMzOTtzb2NrZXRzPTEsY29yZXM9MSx0aHJlYWRzPTEmIzM5OyzCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCAmIzM5Oy1tJiMzOTssICYjMzk7MjA0OCYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+
DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1vYmplY3QmIzM5OywgJiMzOTttZW1v
cnktYmFja2VuZC1tZW1mZCxpZD1zeXNtZW0tZmlsZSxzaXplPTJHJiMzOTsswqAgwqAgwqAgwqAg
XDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LW51bWEmIzM5OywgJiMzOTtu
b2RlLG1lbWRldj1zeXNtZW0tZmlsZSYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1k
ZXZpY2UmIzM5OywgJiMzOTt2aXJ0aW8tc2NzaS1wY2ksaWQ9dmlydGlvX3Njc2lfcGNpMCYjMzk7
LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCAmIzM5Oy1kcml2ZSYjMzk7LCAmIzM5O2lkPWRyaXZlX2ltYWdlMSxpZj1ub25lLGZvcm1hdD1x
Y293MiwmIzM5O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5O2ZpbGU9L2hvbWUvb2w3LWhkZC0x
LnFjb3cyJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LWRldmljZSYjMzk7LCAmIzM5O3Njc2ktaGQsaWQ9
aW1hZ2UxLGRyaXZlPWRyaXZlX2ltYWdlMSwmIzM5O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJiMz
OTtidXM9dmlydGlvX3Njc2lfcGNpMC4wJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstYm9vdCYj
Mzk7LCAmIzM5O2QmIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAgJiMzOTstdm5jJiMzOTssICYjMzk7OjAmIzM5OyzCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstZGV2aWNlJiMz
OTssICYjMzk7cGNpLXByb3h5LWRldixpZD1sc2kxLHNvY2tldD0mIzM5OytzdHIocHJveHkuZmls
ZW5vKCkpLMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1kZXZpY2Um
IzM5OywgJiMzOTtwY2ktcHJveHktZGV2LGlkPWxzaTIsc29ja2V0PSYjMzk7K3N0cihwcm94eS5m
aWxlbm8oKSnCoCDCoFw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCBdPGJyPg0KJmd0OyAr
PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArcGlkID0gb3MuZm9yaygpOzxicj4NCiZndDsgKzxicj4N
CiZndDsgK2lmIHBpZDo8YnI+DQomZ3Q7ICvCoCDCoCAjIEluIFByb3h5PGJyPg0KJmd0OyArwqAg
wqAgcHJpbnQoJiMzOTtMYXVuY2hpbmcgUUVNVSB3aXRoIFByb3h5IG9iamVjdCYjMzk7KTs8YnI+
DQomZ3Q7ICvCoCDCoCBwcm9jZXNzID0gc3VicHJvY2Vzcy5Qb3Blbihwcm94eV9jbWQsIHBhc3Nf
ZmRzPVtwcm94eS5maWxlbm8oKV0pPGJyPg0KJmd0OyArZWxzZTo8YnI+DQomZ3Q7ICvCoCDCoCAj
IEluIHJlbW90ZTxicj4NCiZndDsgK8KgIMKgIHByaW50KCYjMzk7TGF1bmNoaW5nIFJlbW90ZSBw
cm9jZXNzJiMzOTspOzxicj4NCiZndDsgK8KgIMKgIHByb2Nlc3MgPSBzdWJwcm9jZXNzLlBvcGVu
KHJlbW90ZV9jbWQsIHBhc3NfZmRzPVtyZW1vdGUuZmlsZW5vKCldKTxicj4NCiZndDsgLS0gPGJy
Pg0KJmd0OyAyLjI1LkdJVDxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4NCiZn
dDsgPGJyPg0KJmd0OyAtLSA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAg5q2k6Ie0PGJyPg0KJmd0
OyDnpLw8YnI+DQomZ3Q7IOe9l+WLh+WImjxicj4NCiZndDsgWW91cnM8YnI+DQomZ3Q7wqAgwqAg
wqBzaW5jZXJlbHksPGJyPg0KJmd0OyBZb25nZ2FuZyBMdW88YnI+DQo8YnI+DQo8L2Jsb2NrcXVv
dGU+PC9kaXY+PGJyIGNsZWFyPSJhbGwiPjxkaXY+PGJyPjwvZGl2Pi0tIDxicj48ZGl2IGRpcj0i
bHRyIiBjbGFzcz0iZ21haWxfc2lnbmF0dXJlIj7CoCDCoCDCoCDCoMKgIOatpOiHtDxicj7npLw8
YnI+572X5YuH5YiaPGJyPllvdXJzPGJyPsKgIMKgIHNpbmNlcmVseSw8YnI+WW9uZ2dhbmcgTHVv
PGJyPjwvZGl2PjwvZGl2Pg0K
--000000000000c66ea305a3fe8785--

