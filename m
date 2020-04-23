Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085E9C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2E220728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn0hJz7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2E220728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRcKG-00023d-RK
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jRcJW-0001bi-Oc
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jRcJV-0006OE-8h
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:54:50 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:42726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jRcJU-0006Nl-PN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:54:48 -0400
Received: by mail-lj1-x241.google.com with SMTP id a21so6280894ljb.9
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=EDXO2UuA5Axig+IzC9wQkfEu4a3YZRJZhrhMoR/dPzI=;
 b=Sn0hJz7bgwNQozm/0wSirJo+IWGTMrixfdAZ5TmRY5CT+bVw+b6k4WaOOlR5W0rrSG
 X/3WzQCc33pmn34zHvvAM8eORLGc4I/lCKtz/JBXjgHzYNIKMElWInGAisBVkiQEknDH
 2iY2Sek7jFByl19BEj/VGcXO+JZiqrdwG25ChzC/t3gdcvujEoi9omQjHvmi8EdptmS+
 8OzoS1XIg9iT83oG0+Psu/kTXzcIk9y0Da2tGdGWNYSdl94tiMrUV0C4ousCsmMSqCpI
 NMsiM68E+mCwMim/HQiXrGZPMYldD3HIsmyEEI0Q4kiGcLx5wJX1qDFV4ZNBCLQc1qAy
 Jcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=EDXO2UuA5Axig+IzC9wQkfEu4a3YZRJZhrhMoR/dPzI=;
 b=dA8k8XlrzV8Jl9qegZo+skFIeweJDIrl7l6UrdIPqOV5b12bl23G8iyuM/wrXZFVi8
 2zI+/eaUjBJoPuXvJ2OMg1kqEEuEaW6JcKRUD/0jjZMsXmXmklR0SfgFhJjnZe4XuqU4
 ZMxfLm6sg2G9z/j6w4Ez/dPqUomO+xUqa3QiJ6OBQTVXhluPlRqvJEAV2+31+jIUg0Xi
 xKucG4g+sF8rPfIaOxo3J7WMHh+RQvwNeK1h3U/PIw73X6Fe3YYqygxIQmFK7jjzYEyR
 GBPyXWtAL5ot0Nt6l9Sbn693vpq2mWckqGqDYM/CS9x3S7tjq1T5fvB9Pk58KTl2oPpS
 dWqQ==
X-Gm-Message-State: AGi0PuaRuPMf4l/36571SFDamjuWk1lRyYnCZk1Pg6exdsPCUNMN7cwG
 d9IbA+GXx3GOqWQHoO/wLlZ7CgH6foyrJW0kAkQ=
X-Google-Smtp-Source: APiQypJTEZVgGSxLXxN7HydGUgBo1JBHGj6mR6tdAdiHkj//zSur33x4dl+AOxU+jkt2TiPGcmBuQ8X5w6U0DA5Apzo=
X-Received: by 2002:a2e:b17a:: with SMTP id a26mr2304511ljm.215.1587650086305; 
 Thu, 23 Apr 2020 06:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <526ab3d1a840ad0693c6c8d38e56602d2c53024b.1587614626.git.elena.ufimtseva@oracle.com>
In-Reply-To: <526ab3d1a840ad0693c6c8d38e56602d2c53024b.1587614626.git.elena.ufimtseva@oracle.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 23 Apr 2020 21:54:34 +0800
Message-ID: <CAE2XoE8WeGXL93G6uLsKDVNrjxWFq5PTO853bdkuzDQ9fB9dtw@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 36/36] multi-process: add configure and usage
 information
To: elena.ufimtseva@oracle.com
Content-Type: multipart/alternative; boundary="0000000000006c060f05a3f59739"
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 stefanha@redhat.com, pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006c060f05a3f59739
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Does multi-process support on Windows?
I found it use mmap and unix socket for inter-process communication, that
may not support under Windows.
And also, can the python script be replaced by C implementation?

On Thu, Apr 23, 2020 at 12:38 PM <elena.ufimtseva@oracle.com> wrote:

> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  MAINTAINERS                          |  2 +
>  docs/multi-process.rst               | 85 +++++++++++++++++++++++++
>  scripts/mpqemu-launcher-perf-mode.py | 92 ++++++++++++++++++++++++++++
>  scripts/mpqemu-launcher.py           | 53 ++++++++++++++++
>  4 files changed, 232 insertions(+)
>  create mode 100644 docs/multi-process.rst
>  create mode 100755 scripts/mpqemu-launcher-perf-mode.py
>  create mode 100755 scripts/mpqemu-launcher.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ed48615e15..8ff3bfae6a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2880,6 +2880,8 @@ F: remote/iohub.c
>  F: remote/remote-opts.h
>  F: remote/remote-opts.c
>  F: docs/devel/multi-process.rst
> +F: scripts/mpqemu-launcher.py
> +F: scripts/mpqemu-launcher-perf-mode.py
>
>  Build and test automation
>  -------------------------
> diff --git a/docs/multi-process.rst b/docs/multi-process.rst
> new file mode 100644
> index 0000000000..8387d6c691
> --- /dev/null
> +++ b/docs/multi-process.rst
> @@ -0,0 +1,85 @@
> +Multi-process QEMU
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document describes how to configure and use multi-process qemu.
> +For the design document refer to docs/devel/qemu-multiprocess.
> +
> +1) Configuration
> +----------------
> +
> +To enable support for multi-process add --enable-mpqemu
> +to the list of options for the "configure" script.
> +
> +
> +2) Usage
> +--------
> +
> +Multi-process QEMU requires an orchestrator to launch. Please refer to a
> +light-weight python based orchestrator for mpqemu in
> +scripts/mpqemu-launcher.py to lauch QEMU in multi-process mode.
> +
> +scripts/mpqemu-launcher-perf-mode.py launches in "perf" mode. In this
> mode,
> +the same QEMU process connects to multiple remote devices, each emulated
> in
> +a separate process.
> +
> +As of now, we only support the emulation of lsi53c895a in a separate
> process.
> +
> +Following is a description of command-line used to launch mpqemu.
> +
> +* Orchestrator:
> +
> +  - The Orchestrator creates a unix socketpair
> +
> +  - It launches the remote process and passes one of the
> +    sockets to it via command-line.
> +
> +  - It then launches QEMU and specifies the other socket as an option
> +    to the Proxy device object
> +
> +* Remote Process:
> +
> +  - The first command-line option in the remote process is one of the
> +    sockets created by the Orchestrator
> +
> +  - The remaining options are no different from how one launches QEMU wi=
th
> +    devices. The only other requirement is each PCI device must have a
> +    unique ID specified to it. This is needed to pair remote device with
> the
> +    Proxy object.
> +
> +  - Example command-line for the remote process is as follows:
> +
> +      /usr/bin/qemu-scsu-dev 4                                          =
 \
> +      -device lsi53c895a,id=3Dlsi0                                      =
   \
> +      -drive id=3Ddrive_image2,file=3D/build/ol7-nvme-test-1.qcow2      =
     \
> +      -device scsi-hd,id=3Ddrive2,drive=3Ddrive_image2,bus=3Dlsi0.0,scsi=
-id=3D0
> +
> +* QEMU:
> +
> +  - Since parts of the RAM are shared between QEMU & remote process, a
> +    memory-backend-memfd is required to facilitate this, as follows:
> +
> +    -object memory-backend-memfd,id=3Dmem,size=3D2G
> +
> +  - A "pci-proxy-dev" device is created for each of the PCI devices
> emulated
> +    in the remote process. A "socket" sub-option specifies the other end
> of
> +    unix channel created by orchestrator. The "id" sub-option must be
> specified
> +    and should be the same as the "id" specified for the remote PCI devi=
ce
> +
> +  - Example commandline for QEMU is as follows:
> +
> +      -device pci-proxy-dev,id=3Dlsi0,socket=3D3
> +
> +* Monitor / QMP:
> +
> +  - The remote process supports QEMU monitor. It could be specified usin=
g
> the
> +    "-monitor" or "-qmp" command-line options
> +
> +  - As an example, one could connect to the monitor by adding the
> following
> +    to the command-line of the remote process
> +
> +      -monitor unix:/home/qmp-sock,server,nowait
> +
> +  - The user could connect to the monitor using the qmp script or using
> +    "socat" as outlined below:
> +
> +      socat /home/qmp-sock stdio
> diff --git a/scripts/mpqemu-launcher-perf-mode.py
> b/scripts/mpqemu-launcher-perf-mode.py
> new file mode 100755
> index 0000000000..2733424c76
> --- /dev/null
> +++ b/scripts/mpqemu-launcher-perf-mode.py
> @@ -0,0 +1,92 @@
> +#!/usr/bin/env python3
> +
> +import socket
> +import os
> +import subprocess
> +import time
> +
> +PROC_QEMU=3D'/usr/bin/qemu-system-x86_64'
> +
> +PROC_REMOTE=3D'/usr/bin/qemu-scsi-dev'
> +
> +proxy_1, remote_1 =3D socket.socketpair(socket.AF_UNIX, socket.SOCK_STRE=
AM)
> +proxy_2, remote_2 =3D socket.socketpair(socket.AF_UNIX, socket.SOCK_STRE=
AM)
> +proxy_3, remote_3 =3D socket.socketpair(socket.AF_UNIX, socket.SOCK_STRE=
AM)
> +
> +remote_cmd_1 =3D [ PROC_REMOTE,
>       \
> +                 str(remote_1.fileno()),
>      \
> +                 '-device', 'lsi53c895a,id=3Dlsi1',
>       \
> +                 '-drive', 'id=3Ddrive_image1,'
>       \
> +                               'file=3D/build/ol7-nvme-test-1.qcow2',
>       \
> +                 '-device', 'scsi-hd,id=3Ddrive1,drive=3Ddrive_image1,'
>       \
> +                                'bus=3Dlsi1.0,scsi-id=3D0',
>       \
> +               ]
> +
> +remote_cmd_2 =3D [ PROC_REMOTE,
>       \
> +                 str(remote_2.fileno()),
>      \
> +                 '-device', 'lsi53c895a,id=3Dlsi2',
>       \
> +                 '-drive', 'id=3Ddrive_image2,'
>       \
> +                               'file=3D/build/ol7-nvme-test-2.qcow2',
>       \
> +                 '-device', 'scsi-hd,id=3Ddrive2,drive=3Ddrive_image2,'
>       \
> +                                'bus=3Dlsi2.0,scsi-id=3D0'
>      \
> +               ]
> +
> +remote_cmd_3 =3D [ PROC_REMOTE,
>       \
> +                 str(remote_3.fileno()),
>      \
> +                 '-device', 'lsi53c895a,id=3Dlsi3',
>       \
> +                 '-drive', 'id=3Ddrive_image3,'
>       \
> +                               'file=3D/build/ol7-nvme-test-3.qcow2',
>       \
> +                 '-device', 'scsi-hd,id=3Ddrive3,drive=3Ddrive_image3,'
>       \
> +                                'bus=3Dlsi3.0,scsi-id=3D0'
>      \
> +               ]
> +
> +proxy_cmd =3D [ PROC_QEMU,
>      \
> +              '-name', 'OL7.4',
>       \
> +              '-machine', 'q35,accel=3Dkvm',
>      \
> +              '-smp', 'sockets=3D1,cores=3D1,threads=3D1',
>      \
> +              '-m', '2048',
>       \
> +              '-object', 'memory-backend-memfd,id=3Dsysmem-file,size=3D2=
G',
>       \
> +              '-numa', 'node,memdev=3Dsysmem-file',
>       \
> +              '-device', 'virtio-scsi-pci,id=3Dvirtio_scsi_pci0',
>       \
> +              '-drive', 'id=3Ddrive_image1,if=3Dnone,format=3Dqcow2,'
>       \
> +                            'file=3D/home/ol7-hdd-1.qcow2',
>       \
> +              '-device', 'scsi-hd,id=3Dimage1,drive=3Ddrive_image1,'
>      \
> +                             'bus=3Dvirtio_scsi_pci0.0',
>      \
> +              '-boot', 'd',
>       \
> +              '-vnc', ':0',
>       \
> +              '-device', 'pci-proxy-dev,id=3Dlsi1,'
>       \
> +                             'socket=3D'+str(proxy_1.fileno()),
>       \
> +              '-device', 'pci-proxy-dev,id=3Dlsi2,'
>       \
> +                             'socket=3D'+str(proxy_2.fileno()),
>       \
> +              '-device', 'pci-proxy-dev,id=3Dlsi3,'
>       \
> +                             'socket=3D'+str(proxy_3.fileno())
>      \
> +            ]
> +
> +
> +pid =3D os.fork();
> +if pid =3D=3D 0:
> +    # In remote_1
> +    print('Launching Remote process 1');
> +    process =3D subprocess.Popen(remote_cmd_1, pass_fds=3D[remote_1.file=
no()])
> +    os._exit(0)
> +
> +
> +pid =3D os.fork();
> +if pid =3D=3D 0:
> +    # In remote_2
> +    print('Launching Remote process 2');
> +    process =3D subprocess.Popen(remote_cmd_2, pass_fds=3D[remote_2.file=
no()])
> +    os._exit(0)
> +
> +
> +pid =3D os.fork();
> +if pid =3D=3D 0:
> +    # In remote_3
> +    print('Launching Remote process 3');
> +    process =3D subprocess.Popen(remote_cmd_3, pass_fds=3D[remote_3.file=
no()])
> +    os._exit(0)
> +
> +
> +print('Launching Proxy process');
> +process =3D subprocess.Popen(proxy_cmd, pass_fds=3D[proxy_1.fileno(),
>       \
> +                           proxy_2.fileno(), proxy_3.fileno()])
> diff --git a/scripts/mpqemu-launcher.py b/scripts/mpqemu-launcher.py
> new file mode 100755
> index 0000000000..81e370663e
> --- /dev/null
> +++ b/scripts/mpqemu-launcher.py
> @@ -0,0 +1,53 @@
> +#!/usr/bin/env python3
> +import socket
> +import os
> +import subprocess
> +import time
> +
> +PROC_QEMU=3D'/usr/bin/qemu-system-x86_64'
> +
> +PROC_REMOTE=3D'/usr/bin/qemu-scsi-dev'
> +
> +proxy, remote =3D socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
> +
> +remote_cmd =3D [ PROC_REMOTE,
>       \
> +               str(remote.fileno()),
>      \
> +               '-device', 'lsi53c895a,id=3Dlsi1',
>       \
> +               '-drive',
> 'id=3Ddrive_image1,file=3D/build/ol7-nvme-test-1.qcow2',  \
> +               '-device',
> 'scsi-hd,id=3Ddrive1,drive=3Ddrive_image1,bus=3Dlsi1.0,'   \
> +                              'scsi-id=3D0',
>      \
> +               '-device', 'lsi53c895a,id=3Dlsi2',
>       \
> +               '-drive',
> 'id=3Ddrive_image2,file=3D/build/ol7-nvme-test-2.qcow2',  \
> +               '-device',
> 'scsi-hd,id=3Ddrive2,drive=3Ddrive_image2,bus=3Dlsi2.0,'   \
> +                              'scsi-id=3D0'
>       \
> +             ]
> +
> +proxy_cmd =3D [ PROC_QEMU,
>      \
> +              '-name', 'OL7.4',
>       \
> +              '-machine', 'q35,accel=3Dkvm',
>      \
> +              '-smp', 'sockets=3D1,cores=3D1,threads=3D1',
>      \
> +              '-m', '2048',
>       \
> +              '-object', 'memory-backend-memfd,id=3Dsysmem-file,size=3D2=
G',
>       \
> +              '-numa', 'node,memdev=3Dsysmem-file',
>       \
> +              '-device', 'virtio-scsi-pci,id=3Dvirtio_scsi_pci0',
>       \
> +              '-drive', 'id=3Ddrive_image1,if=3Dnone,format=3Dqcow2,'
>       \
> +                            'file=3D/home/ol7-hdd-1.qcow2',
>       \
> +              '-device', 'scsi-hd,id=3Dimage1,drive=3Ddrive_image1,'
>      \
> +                             'bus=3Dvirtio_scsi_pci0.0',
>      \
> +              '-boot', 'd',
>       \
> +              '-vnc', ':0',
>       \
> +              '-device',
> 'pci-proxy-dev,id=3Dlsi1,socket=3D'+str(proxy.fileno()),  \
> +              '-device',
> 'pci-proxy-dev,id=3Dlsi2,socket=3D'+str(proxy.fileno())   \
> +            ]
> +
> +
> +pid =3D os.fork();
> +
> +if pid:
> +    # In Proxy
> +    print('Launching QEMU with Proxy object');
> +    process =3D subprocess.Popen(proxy_cmd, pass_fds=3D[proxy.fileno()])
> +else:
> +    # In remote
> +    print('Launching Remote process');
> +    process =3D subprocess.Popen(remote_cmd, pass_fds=3D[remote.fileno()=
])
> --
> 2.25.GIT
>
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000006c060f05a3f59739
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+RG9lc8KgbXVsdGktcHJvY2VzcyBzdXBwb3J0IG9uIFdpbmRvd3M/PGRp
dj5JIGZvdW5kIGl0IHVzZSBtbWFwIGFuZCB1bml4IHNvY2tldCBmb3IgaW50ZXItcHJvY2VzcyBj
b21tdW5pY2F0aW9uLCB0aGF0IG1heSBub3Qgc3VwcG9ydCB1bmRlciBXaW5kb3dzLjwvZGl2Pjxk
aXY+QW5kIGFsc28sIGNhbiB0aGUgcHl0aG9uIHNjcmlwdCBiZSByZXBsYWNlZCBieSBDIGltcGxl
bWVudGF0aW9uPzwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBk
aXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFRodSwgQXByIDIzLCAyMDIwIGF0IDEyOjM4
IFBNICZsdDs8YSBocmVmPSJtYWlsdG86ZWxlbmEudWZpbXRzZXZhQG9yYWNsZS5jb20iPmVsZW5h
LnVmaW10c2V2YUBvcmFjbGUuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5Gcm9t
OiBFbGVuYSBVZmltdHNldmEgJmx0OzxhIGhyZWY9Im1haWx0bzplbGVuYS51ZmltdHNldmFAb3Jh
Y2xlLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmVsZW5hLnVmaW10c2V2YUBvcmFjbGUuY29tPC9hPiZn
dDs8YnI+DQo8YnI+DQpTaWduZWQtb2ZmLWJ5OiBFbGVuYSBVZmltdHNldmEgJmx0OzxhIGhyZWY9
Im1haWx0bzplbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmVsZW5h
LnVmaW10c2V2YUBvcmFjbGUuY29tPC9hPiZndDs8YnI+DQpTaWduZWQtb2ZmLWJ5OiBKYWdhbm5h
dGhhbiBSYW1hbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmphZy5yYW1hbkBvcmFjbGUuY29tIiB0YXJn
ZXQ9Il9ibGFuayI+amFnLnJhbWFuQG9yYWNsZS5jb208L2E+Jmd0Ozxicj4NClNpZ25lZC1vZmYt
Ynk6IEpvaG4gRyBKb2huc29uICZsdDs8YSBocmVmPSJtYWlsdG86am9obi5nLmpvaG5zb25Ab3Jh
Y2xlLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmpvaG4uZy5qb2huc29uQG9yYWNsZS5jb208L2E+Jmd0
Ozxicj4NCi0tLTxicj4NCsKgTUFJTlRBSU5FUlPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB8wqAgMiArPGJyPg0KwqBkb2NzL211bHRpLXByb2Nlc3MucnN0wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB8IDg1ICsrKysrKysrKysrKysrKysrKysrKysrKys8YnI+DQrCoHNjcmlw
dHMvbXBxZW11LWxhdW5jaGVyLXBlcmYtbW9kZS5weSB8IDkyICsrKysrKysrKysrKysrKysrKysr
KysrKysrKys8YnI+DQrCoHNjcmlwdHMvbXBxZW11LWxhdW5jaGVyLnB5wqAgwqAgwqAgwqAgwqAg
wqB8IDUzICsrKysrKysrKysrKysrKys8YnI+DQrCoDQgZmlsZXMgY2hhbmdlZCwgMjMyIGluc2Vy
dGlvbnMoKyk8YnI+DQrCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL211bHRpLXByb2Nlc3MucnN0
PGJyPg0KwqBjcmVhdGUgbW9kZSAxMDA3NTUgc2NyaXB0cy9tcHFlbXUtbGF1bmNoZXItcGVyZi1t
b2RlLnB5PGJyPg0KwqBjcmVhdGUgbW9kZSAxMDA3NTUgc2NyaXB0cy9tcHFlbXUtbGF1bmNoZXIu
cHk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUzxicj4N
CmluZGV4IGVkNDg2MTVlMTUuLjhmZjNiZmFlNmEgMTAwNjQ0PGJyPg0KLS0tIGEvTUFJTlRBSU5F
UlM8YnI+DQorKysgYi9NQUlOVEFJTkVSUzxicj4NCkBAIC0yODgwLDYgKzI4ODAsOCBAQCBGOiBy
ZW1vdGUvaW9odWIuYzxicj4NCsKgRjogcmVtb3RlL3JlbW90ZS1vcHRzLmg8YnI+DQrCoEY6IHJl
bW90ZS9yZW1vdGUtb3B0cy5jPGJyPg0KwqBGOiBkb2NzL2RldmVsL211bHRpLXByb2Nlc3MucnN0
PGJyPg0KK0Y6IHNjcmlwdHMvbXBxZW11LWxhdW5jaGVyLnB5PGJyPg0KK0Y6IHNjcmlwdHMvbXBx
ZW11LWxhdW5jaGVyLXBlcmYtbW9kZS5weTxicj4NCjxicj4NCsKgQnVpbGQgYW5kIHRlc3QgYXV0
b21hdGlvbjxicj4NCsKgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj4NCmRpZmYgLS1naXQg
YS9kb2NzL211bHRpLXByb2Nlc3MucnN0IGIvZG9jcy9tdWx0aS1wcm9jZXNzLnJzdDxicj4NCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0PGJyPg0KaW5kZXggMDAwMDAwMDAwMC4uODM4N2Q2YzY5MTxicj4N
Ci0tLSAvZGV2L251bGw8YnI+DQorKysgYi9kb2NzL211bHRpLXByb2Nlc3MucnN0PGJyPg0KQEAg
LTAsMCArMSw4NSBAQDxicj4NCitNdWx0aS1wcm9jZXNzIFFFTVU8YnI+DQorPT09PT09PT09PT09
PT09PT09PGJyPg0KKzxicj4NCitUaGlzIGRvY3VtZW50IGRlc2NyaWJlcyBob3cgdG8gY29uZmln
dXJlIGFuZCB1c2UgbXVsdGktcHJvY2VzcyBxZW11Ljxicj4NCitGb3IgdGhlIGRlc2lnbiBkb2N1
bWVudCByZWZlciB0byBkb2NzL2RldmVsL3FlbXUtbXVsdGlwcm9jZXNzLjxicj4NCis8YnI+DQor
MSkgQ29uZmlndXJhdGlvbjxicj4NCistLS0tLS0tLS0tLS0tLS0tPGJyPg0KKzxicj4NCitUbyBl
bmFibGUgc3VwcG9ydCBmb3IgbXVsdGktcHJvY2VzcyBhZGQgLS1lbmFibGUtbXBxZW11PGJyPg0K
K3RvIHRoZSBsaXN0IG9mIG9wdGlvbnMgZm9yIHRoZSAmcXVvdDtjb25maWd1cmUmcXVvdDsgc2Ny
aXB0Ljxicj4NCis8YnI+DQorPGJyPg0KKzIpIFVzYWdlPGJyPg0KKy0tLS0tLS0tPGJyPg0KKzxi
cj4NCitNdWx0aS1wcm9jZXNzIFFFTVUgcmVxdWlyZXMgYW4gb3JjaGVzdHJhdG9yIHRvIGxhdW5j
aC4gUGxlYXNlIHJlZmVyIHRvIGE8YnI+DQorbGlnaHQtd2VpZ2h0IHB5dGhvbiBiYXNlZCBvcmNo
ZXN0cmF0b3IgZm9yIG1wcWVtdSBpbjxicj4NCitzY3JpcHRzL21wcWVtdS1sYXVuY2hlci5weSB0
byBsYXVjaCBRRU1VIGluIG11bHRpLXByb2Nlc3MgbW9kZS48YnI+DQorPGJyPg0KK3NjcmlwdHMv
bXBxZW11LWxhdW5jaGVyLXBlcmYtbW9kZS5weSBsYXVuY2hlcyBpbiAmcXVvdDtwZXJmJnF1b3Q7
IG1vZGUuIEluIHRoaXMgbW9kZSw8YnI+DQordGhlIHNhbWUgUUVNVSBwcm9jZXNzIGNvbm5lY3Rz
IHRvIG11bHRpcGxlIHJlbW90ZSBkZXZpY2VzLCBlYWNoIGVtdWxhdGVkIGluPGJyPg0KK2Egc2Vw
YXJhdGUgcHJvY2Vzcy48YnI+DQorPGJyPg0KK0FzIG9mIG5vdywgd2Ugb25seSBzdXBwb3J0IHRo
ZSBlbXVsYXRpb24gb2YgbHNpNTNjODk1YSBpbiBhIHNlcGFyYXRlIHByb2Nlc3MuPGJyPg0KKzxi
cj4NCitGb2xsb3dpbmcgaXMgYSBkZXNjcmlwdGlvbiBvZiBjb21tYW5kLWxpbmUgdXNlZCB0byBs
YXVuY2ggbXBxZW11Ljxicj4NCis8YnI+DQorKiBPcmNoZXN0cmF0b3I6PGJyPg0KKzxicj4NCivC
oCAtIFRoZSBPcmNoZXN0cmF0b3IgY3JlYXRlcyBhIHVuaXggc29ja2V0cGFpcjxicj4NCis8YnI+
DQorwqAgLSBJdCBsYXVuY2hlcyB0aGUgcmVtb3RlIHByb2Nlc3MgYW5kIHBhc3NlcyBvbmUgb2Yg
dGhlPGJyPg0KK8KgIMKgIHNvY2tldHMgdG8gaXQgdmlhIGNvbW1hbmQtbGluZS48YnI+DQorPGJy
Pg0KK8KgIC0gSXQgdGhlbiBsYXVuY2hlcyBRRU1VIGFuZCBzcGVjaWZpZXMgdGhlIG90aGVyIHNv
Y2tldCBhcyBhbiBvcHRpb248YnI+DQorwqAgwqAgdG8gdGhlIFByb3h5IGRldmljZSBvYmplY3Q8
YnI+DQorPGJyPg0KKyogUmVtb3RlIFByb2Nlc3M6PGJyPg0KKzxicj4NCivCoCAtIFRoZSBmaXJz
dCBjb21tYW5kLWxpbmUgb3B0aW9uIGluIHRoZSByZW1vdGUgcHJvY2VzcyBpcyBvbmUgb2YgdGhl
PGJyPg0KK8KgIMKgIHNvY2tldHMgY3JlYXRlZCBieSB0aGUgT3JjaGVzdHJhdG9yPGJyPg0KKzxi
cj4NCivCoCAtIFRoZSByZW1haW5pbmcgb3B0aW9ucyBhcmUgbm8gZGlmZmVyZW50IGZyb20gaG93
IG9uZSBsYXVuY2hlcyBRRU1VIHdpdGg8YnI+DQorwqAgwqAgZGV2aWNlcy4gVGhlIG9ubHkgb3Ro
ZXIgcmVxdWlyZW1lbnQgaXMgZWFjaCBQQ0kgZGV2aWNlIG11c3QgaGF2ZSBhPGJyPg0KK8KgIMKg
IHVuaXF1ZSBJRCBzcGVjaWZpZWQgdG8gaXQuIFRoaXMgaXMgbmVlZGVkIHRvIHBhaXIgcmVtb3Rl
IGRldmljZSB3aXRoIHRoZTxicj4NCivCoCDCoCBQcm94eSBvYmplY3QuPGJyPg0KKzxicj4NCivC
oCAtIEV4YW1wbGUgY29tbWFuZC1saW5lIGZvciB0aGUgcmVtb3RlIHByb2Nlc3MgaXMgYXMgZm9s
bG93czo8YnI+DQorPGJyPg0KK8KgIMKgIMKgIC91c3IvYmluL3FlbXUtc2NzdS1kZXYgNMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXDxicj4NCivCoCDCoCDCoCAtZGV2aWNlIGxzaTUzYzg5NWEsaWQ9bHNpMMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4N
CivCoCDCoCDCoCAtZHJpdmUgaWQ9ZHJpdmVfaW1hZ2UyLGZpbGU9L2J1aWxkL29sNy1udm1lLXRl
c3QtMS5xY293MsKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCAtZGV2aWNlIHNjc2kt
aGQsaWQ9ZHJpdmUyLGRyaXZlPWRyaXZlX2ltYWdlMixidXM9bHNpMC4wLHNjc2ktaWQ9MDxicj4N
Cis8YnI+DQorKiBRRU1VOjxicj4NCis8YnI+DQorwqAgLSBTaW5jZSBwYXJ0cyBvZiB0aGUgUkFN
IGFyZSBzaGFyZWQgYmV0d2VlbiBRRU1VICZhbXA7IHJlbW90ZSBwcm9jZXNzLCBhPGJyPg0KK8Kg
IMKgIG1lbW9yeS1iYWNrZW5kLW1lbWZkIGlzIHJlcXVpcmVkIHRvIGZhY2lsaXRhdGUgdGhpcywg
YXMgZm9sbG93czo8YnI+DQorPGJyPg0KK8KgIMKgIC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtbWVt
ZmQsaWQ9bWVtLHNpemU9Mkc8YnI+DQorPGJyPg0KK8KgIC0gQSAmcXVvdDtwY2ktcHJveHktZGV2
JnF1b3Q7IGRldmljZSBpcyBjcmVhdGVkIGZvciBlYWNoIG9mIHRoZSBQQ0kgZGV2aWNlcyBlbXVs
YXRlZDxicj4NCivCoCDCoCBpbiB0aGUgcmVtb3RlIHByb2Nlc3MuIEEgJnF1b3Q7c29ja2V0JnF1
b3Q7IHN1Yi1vcHRpb24gc3BlY2lmaWVzIHRoZSBvdGhlciBlbmQgb2Y8YnI+DQorwqAgwqAgdW5p
eCBjaGFubmVsIGNyZWF0ZWQgYnkgb3JjaGVzdHJhdG9yLiBUaGUgJnF1b3Q7aWQmcXVvdDsgc3Vi
LW9wdGlvbiBtdXN0IGJlIHNwZWNpZmllZDxicj4NCivCoCDCoCBhbmQgc2hvdWxkIGJlIHRoZSBz
YW1lIGFzIHRoZSAmcXVvdDtpZCZxdW90OyBzcGVjaWZpZWQgZm9yIHRoZSByZW1vdGUgUENJIGRl
dmljZTxicj4NCis8YnI+DQorwqAgLSBFeGFtcGxlIGNvbW1hbmRsaW5lIGZvciBRRU1VIGlzIGFz
IGZvbGxvd3M6PGJyPg0KKzxicj4NCivCoCDCoCDCoCAtZGV2aWNlIHBjaS1wcm94eS1kZXYsaWQ9
bHNpMCxzb2NrZXQ9Mzxicj4NCis8YnI+DQorKiBNb25pdG9yIC8gUU1QOjxicj4NCis8YnI+DQor
wqAgLSBUaGUgcmVtb3RlIHByb2Nlc3Mgc3VwcG9ydHMgUUVNVSBtb25pdG9yLiBJdCBjb3VsZCBi
ZSBzcGVjaWZpZWQgdXNpbmcgdGhlPGJyPg0KK8KgIMKgICZxdW90Oy1tb25pdG9yJnF1b3Q7IG9y
ICZxdW90Oy1xbXAmcXVvdDsgY29tbWFuZC1saW5lIG9wdGlvbnM8YnI+DQorPGJyPg0KK8KgIC0g
QXMgYW4gZXhhbXBsZSwgb25lIGNvdWxkIGNvbm5lY3QgdG8gdGhlIG1vbml0b3IgYnkgYWRkaW5n
IHRoZSBmb2xsb3dpbmc8YnI+DQorwqAgwqAgdG8gdGhlIGNvbW1hbmQtbGluZSBvZiB0aGUgcmVt
b3RlIHByb2Nlc3M8YnI+DQorPGJyPg0KK8KgIMKgIMKgIC1tb25pdG9yIHVuaXg6L2hvbWUvcW1w
LXNvY2ssc2VydmVyLG5vd2FpdDxicj4NCis8YnI+DQorwqAgLSBUaGUgdXNlciBjb3VsZCBjb25u
ZWN0IHRvIHRoZSBtb25pdG9yIHVzaW5nIHRoZSBxbXAgc2NyaXB0IG9yIHVzaW5nPGJyPg0KK8Kg
IMKgICZxdW90O3NvY2F0JnF1b3Q7IGFzIG91dGxpbmVkIGJlbG93Ojxicj4NCis8YnI+DQorwqAg
wqAgwqAgc29jYXQgL2hvbWUvcW1wLXNvY2sgc3RkaW88YnI+DQpkaWZmIC0tZ2l0IGEvc2NyaXB0
cy9tcHFlbXUtbGF1bmNoZXItcGVyZi1tb2RlLnB5IGIvc2NyaXB0cy9tcHFlbXUtbGF1bmNoZXIt
cGVyZi1tb2RlLnB5PGJyPg0KbmV3IGZpbGUgbW9kZSAxMDA3NTU8YnI+DQppbmRleCAwMDAwMDAw
MDAwLi4yNzMzNDI0Yzc2PGJyPg0KLS0tIC9kZXYvbnVsbDxicj4NCisrKyBiL3NjcmlwdHMvbXBx
ZW11LWxhdW5jaGVyLXBlcmYtbW9kZS5weTxicj4NCkBAIC0wLDAgKzEsOTIgQEA8YnI+DQorIyEv
dXNyL2Jpbi9lbnYgcHl0aG9uMzxicj4NCis8YnI+DQoraW1wb3J0IHNvY2tldDxicj4NCitpbXBv
cnQgb3M8YnI+DQoraW1wb3J0IHN1YnByb2Nlc3M8YnI+DQoraW1wb3J0IHRpbWU8YnI+DQorPGJy
Pg0KK1BST0NfUUVNVT0mIzM5Oy91c3IvYmluL3FlbXUtc3lzdGVtLXg4Nl82NCYjMzk7PGJyPg0K
Kzxicj4NCitQUk9DX1JFTU9URT0mIzM5Oy91c3IvYmluL3FlbXUtc2NzaS1kZXYmIzM5Ozxicj4N
Cis8YnI+DQorcHJveHlfMSwgcmVtb3RlXzEgPSBzb2NrZXQuc29ja2V0cGFpcihzb2NrZXQuQUZf
VU5JWCwgc29ja2V0LlNPQ0tfU1RSRUFNKTxicj4NCitwcm94eV8yLCByZW1vdGVfMiA9IHNvY2tl
dC5zb2NrZXRwYWlyKHNvY2tldC5BRl9VTklYLCBzb2NrZXQuU09DS19TVFJFQU0pPGJyPg0KK3By
b3h5XzMsIHJlbW90ZV8zID0gc29ja2V0LnNvY2tldHBhaXIoc29ja2V0LkFGX1VOSVgsIHNvY2tl
dC5TT0NLX1NUUkVBTSk8YnI+DQorPGJyPg0KK3JlbW90ZV9jbWRfMSA9IFsgUFJPQ19SRU1PVEUs
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cihy
ZW1vdGVfMS5maWxlbm8oKSkswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJiMz
OTstZGV2aWNlJiMzOTssICYjMzk7bHNpNTNjODk1YSxpZD1sc2kxJiMzOTsswqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCYjMzk7LWRyaXZlJiMzOTssICYjMzk7aWQ9ZHJpdmVfaW1hZ2UxLCYjMzk7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7ZmlsZT0v
YnVpbGQvb2w3LW52bWUtdGVzdC0xLnFjb3cyJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgXDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRldmljZSYjMzk7LCAmIzM5O3Njc2kt
aGQsaWQ9ZHJpdmUxLGRyaXZlPWRyaXZlX2ltYWdlMSwmIzM5O8KgIMKgIMKgIMKgIMKgIMKgIFw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMz
OTtidXM9bHNpMS4wLHNjc2ktaWQ9MCYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBdPGJyPg0KKzxicj4NCityZW1v
dGVfY21kXzIgPSBbIFBST0NfUkVNT1RFLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBzdHIocmVtb3RlXzIuZmlsZW5vKCkpLMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRldmljZSYjMzk7LCAmIzM5O2xzaTUzYzg5NWEs
aWQ9bHNpMiYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kcml2ZSYjMzk7LCAmIzM5
O2lkPWRyaXZlX2ltYWdlMiwmIzM5O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAmIzM5O2ZpbGU9L2J1aWxkL29sNy1udm1lLXRlc3QtMi5xY293MiYjMzk7
LMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5
Oy1kZXZpY2UmIzM5OywgJiMzOTtzY3NpLWhkLGlkPWRyaXZlMixkcml2ZT1kcml2ZV9pbWFnZTIs
JiMzOTvCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7YnVzPWxzaTIuMCxzY3NpLWlkPTAmIzM5O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoF08YnI+DQorPGJyPg0KK3JlbW90ZV9jbWRfMyA9IFsgUFJPQ19SRU1PVEUswqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cihyZW1vdGVf
My5maWxlbm8oKSkswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJiMzOTstZGV2
aWNlJiMzOTssICYjMzk7bHNpNTNjODk1YSxpZD1sc2kzJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCYjMzk7LWRyaXZlJiMzOTssICYjMzk7aWQ9ZHJpdmVfaW1hZ2UzLCYjMzk7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7ZmlsZT0vYnVpbGQv
b2w3LW52bWUtdGVzdC0zLnFjb3cyJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRldmljZSYjMzk7LCAmIzM5O3Njc2ktaGQsaWQ9
ZHJpdmUzLGRyaXZlPWRyaXZlX2ltYWdlMywmIzM5O8KgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTtidXM9
bHNpMy4wLHNjc2ktaWQ9MCYjMzk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXTxicj4NCis8YnI+DQorcHJveHlfY21k
ID0gWyBQUk9DX1FFTVUswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgICYjMzk7LW5hbWUmIzM5OywgJiMzOTtPTDcuNCYjMzk7LMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstbWFjaGluZSYjMzk7LCAmIzM5
O3EzNSxhY2NlbD1rdm0mIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstc21w
JiMzOTssICYjMzk7c29ja2V0cz0xLGNvcmVzPTEsdGhyZWFkcz0xJiMzOTsswqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
ICYjMzk7LW0mIzM5OywgJiMzOTsyMDQ4JiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1vYmplY3QmIzM5OywgJiMzOTttZW1vcnktYmFj
a2VuZC1tZW1mZCxpZD1zeXNtZW0tZmlsZSxzaXplPTJHJiMzOTsswqAgwqAgwqAgwqAgXDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1udW1hJiMzOTssICYjMzk7bm9kZSxtZW1kZXY9
c3lzbWVtLWZpbGUmIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LWRldmljZSYjMzk7LCAmIzM5
O3ZpcnRpby1zY3NpLXBjaSxpZD12aXJ0aW9fc2NzaV9wY2kwJiMzOTsswqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1kcml2ZSYjMzk7LCAm
IzM5O2lkPWRyaXZlX2ltYWdlMSxpZj1ub25lLGZvcm1hdD1xY293MiwmIzM5O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJiMzOTtmaWxlPS9ob21lL29sNy1oZGQtMS5xY293MiYjMzk7LMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstZGV2
aWNlJiMzOTssICYjMzk7c2NzaS1oZCxpZD1pbWFnZTEsZHJpdmU9ZHJpdmVfaW1hZ2UxLCYjMzk7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgJiMzOTtidXM9dmlydGlvX3Njc2lfcGNpMC4wJiMzOTsswqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgICYjMzk7LWJvb3QmIzM5OywgJiMzOTtkJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy12bmMmIzM5OywgJiMzOTs6MCYjMzk7LMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstZGV2
aWNlJiMzOTssICYjMzk7cGNpLXByb3h5LWRldixpZD1sc2kxLCYjMzk7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7c29ja2V0PSYjMzk7K3N0cihwcm94eV8xLmZp
bGVubygpKSzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgICYjMzk7LWRldmljZSYjMzk7LCAmIzM5O3BjaS1wcm94eS1kZXYsaWQ9bHNpMiwmIzM5
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5O3NvY2tldD0mIzM5
OytzdHIocHJveHlfMi5maWxlbm8oKSkswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1kZXZpY2UmIzM5OywgJiMzOTtwY2ktcHJveHkt
ZGV2LGlkPWxzaTMsJiMzOTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
JiMzOTtzb2NrZXQ9JiMzOTsrc3RyKHByb3h5XzMuZmlsZW5vKCkpwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIF08YnI+DQorPGJyPg0KKzxicj4N
CitwaWQgPSBvcy5mb3JrKCk7PGJyPg0KK2lmIHBpZCA9PSAwOjxicj4NCivCoCDCoCAjIEluIHJl
bW90ZV8xPGJyPg0KK8KgIMKgIHByaW50KCYjMzk7TGF1bmNoaW5nIFJlbW90ZSBwcm9jZXNzIDEm
IzM5Oyk7PGJyPg0KK8KgIMKgIHByb2Nlc3MgPSBzdWJwcm9jZXNzLlBvcGVuKHJlbW90ZV9jbWRf
MSwgcGFzc19mZHM9W3JlbW90ZV8xLmZpbGVubygpXSk8YnI+DQorwqAgwqAgb3MuX2V4aXQoMCk8
YnI+DQorPGJyPg0KKzxicj4NCitwaWQgPSBvcy5mb3JrKCk7PGJyPg0KK2lmIHBpZCA9PSAwOjxi
cj4NCivCoCDCoCAjIEluIHJlbW90ZV8yPGJyPg0KK8KgIMKgIHByaW50KCYjMzk7TGF1bmNoaW5n
IFJlbW90ZSBwcm9jZXNzIDImIzM5Oyk7PGJyPg0KK8KgIMKgIHByb2Nlc3MgPSBzdWJwcm9jZXNz
LlBvcGVuKHJlbW90ZV9jbWRfMiwgcGFzc19mZHM9W3JlbW90ZV8yLmZpbGVubygpXSk8YnI+DQor
wqAgwqAgb3MuX2V4aXQoMCk8YnI+DQorPGJyPg0KKzxicj4NCitwaWQgPSBvcy5mb3JrKCk7PGJy
Pg0KK2lmIHBpZCA9PSAwOjxicj4NCivCoCDCoCAjIEluIHJlbW90ZV8zPGJyPg0KK8KgIMKgIHBy
aW50KCYjMzk7TGF1bmNoaW5nIFJlbW90ZSBwcm9jZXNzIDMmIzM5Oyk7PGJyPg0KK8KgIMKgIHBy
b2Nlc3MgPSBzdWJwcm9jZXNzLlBvcGVuKHJlbW90ZV9jbWRfMywgcGFzc19mZHM9W3JlbW90ZV8z
LmZpbGVubygpXSk8YnI+DQorwqAgwqAgb3MuX2V4aXQoMCk8YnI+DQorPGJyPg0KKzxicj4NCitw
cmludCgmIzM5O0xhdW5jaGluZyBQcm94eSBwcm9jZXNzJiMzOTspOzxicj4NCitwcm9jZXNzID0g
c3VicHJvY2Vzcy5Qb3Blbihwcm94eV9jbWQsIHBhc3NfZmRzPVtwcm94eV8xLmZpbGVubygpLMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBwcm94eV8yLmZpbGVubygpLCBwcm94eV8zLmZpbGVubygpXSk8YnI+DQpkaWZm
IC0tZ2l0IGEvc2NyaXB0cy9tcHFlbXUtbGF1bmNoZXIucHkgYi9zY3JpcHRzL21wcWVtdS1sYXVu
Y2hlci5weTxicj4NCm5ldyBmaWxlIG1vZGUgMTAwNzU1PGJyPg0KaW5kZXggMDAwMDAwMDAwMC4u
ODFlMzcwNjYzZTxicj4NCi0tLSAvZGV2L251bGw8YnI+DQorKysgYi9zY3JpcHRzL21wcWVtdS1s
YXVuY2hlci5weTxicj4NCkBAIC0wLDAgKzEsNTMgQEA8YnI+DQorIyEvdXNyL2Jpbi9lbnYgcHl0
aG9uMzxicj4NCitpbXBvcnQgc29ja2V0PGJyPg0KK2ltcG9ydCBvczxicj4NCitpbXBvcnQgc3Vi
cHJvY2Vzczxicj4NCitpbXBvcnQgdGltZTxicj4NCis8YnI+DQorUFJPQ19RRU1VPSYjMzk7L3Vz
ci9iaW4vcWVtdS1zeXN0ZW0teDg2XzY0JiMzOTs8YnI+DQorPGJyPg0KK1BST0NfUkVNT1RFPSYj
Mzk7L3Vzci9iaW4vcWVtdS1zY3NpLWRldiYjMzk7PGJyPg0KKzxicj4NCitwcm94eSwgcmVtb3Rl
ID0gc29ja2V0LnNvY2tldHBhaXIoc29ja2V0LkFGX1VOSVgsIHNvY2tldC5TT0NLX1NUUkVBTSk8
YnI+DQorPGJyPg0KK3JlbW90ZV9jbWQgPSBbIFBST0NfUkVNT1RFLMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHIocmVtb3RlLmZpbGVubygpKSzC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kZXZpY2UmIzM5Oywg
JiMzOTtsc2k1M2M4OTVhLGlkPWxzaTEmIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJiMzOTst
ZHJpdmUmIzM5OywgJiMzOTtpZD1kcml2ZV9pbWFnZTEsZmlsZT0vYnVpbGQvb2w3LW52bWUtdGVz
dC0xLnFjb3cyJiMzOTsswqAgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRl
dmljZSYjMzk7LCAmIzM5O3Njc2ktaGQsaWQ9ZHJpdmUxLGRyaXZlPWRyaXZlX2ltYWdlMSxidXM9
bHNpMS4wLCYjMzk7wqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICYjMzk7c2NzaS1pZD0wJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgJiMzOTstZGV2aWNlJiMzOTssICYjMzk7bHNpNTNjODk1YSxpZD1sc2kyJiMzOTsswqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWRyaXZlJiMzOTssICYjMzk7aWQ9ZHJpdmVfaW1hZ2Uy
LGZpbGU9L2J1aWxkL29sNy1udm1lLXRlc3QtMi5xY293MiYjMzk7LMKgIFw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1kZXZpY2UmIzM5OywgJiMzOTtzY3NpLWhkLGlkPWRyaXZl
Mixkcml2ZT1kcml2ZV9pbWFnZTIsYnVzPWxzaTIuMCwmIzM5O8KgIMKgXDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5O3Njc2ktaWQ9MCYjMzk7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
XDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoF08YnI+DQorPGJyPg0KK3Byb3h5X2NtZCA9IFsg
UFJPQ19RRU1VLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmIzM5Oy1uYW1lJiMzOTssICYjMzk7T0w3LjQmIzM5OyzCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBc
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LW1hY2hpbmUmIzM5OywgJiMzOTtxMzUs
YWNjZWw9a3ZtJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LXNtcCYjMzk7
LCAmIzM5O3NvY2tldHM9MSxjb3Jlcz0xLHRocmVhZHM9MSYjMzk7LMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5
Oy1tJiMzOTssICYjMzk7MjA0OCYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstb2JqZWN0JiMzOTssICYjMzk7bWVtb3J5LWJhY2tlbmQt
bWVtZmQsaWQ9c3lzbWVtLWZpbGUsc2l6ZT0yRyYjMzk7LMKgIMKgIMKgIMKgIFw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstbnVtYSYjMzk7LCAmIzM5O25vZGUsbWVtZGV2PXN5c21l
bS1maWxlJiMzOTsswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
XDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCAmIzM5Oy1kZXZpY2UmIzM5OywgJiMzOTt2aXJ0
aW8tc2NzaS1wY2ksaWQ9dmlydGlvX3Njc2lfcGNpMCYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstZHJpdmUmIzM5OywgJiMzOTtp
ZD1kcml2ZV9pbWFnZTEsaWY9bm9uZSxmb3JtYXQ9cWNvdzIsJiMzOTvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICYjMzk7ZmlsZT0vaG9tZS9vbDctaGRkLTEucWNvdzImIzM5OyzCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LWRldmljZSYj
Mzk7LCAmIzM5O3Njc2ktaGQsaWQ9aW1hZ2UxLGRyaXZlPWRyaXZlX2ltYWdlMSwmIzM5O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCYjMzk7YnVzPXZpcnRpb19zY3NpX3BjaTAuMCYjMzk7LMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
IzM5Oy1ib290JiMzOTssICYjMzk7ZCYjMzk7LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJiMzOTstdm5jJiMzOTssICYjMzk7OjAmIzM5OyzCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LWRldmljZSYj
Mzk7LCAmIzM5O3BjaS1wcm94eS1kZXYsaWQ9bHNpMSxzb2NrZXQ9JiMzOTsrc3RyKHByb3h5LmZp
bGVubygpKSzCoCBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgICYjMzk7LWRldmljZSYjMzk7
LCAmIzM5O3BjaS1wcm94eS1kZXYsaWQ9bHNpMixzb2NrZXQ9JiMzOTsrc3RyKHByb3h5LmZpbGVu
bygpKcKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBdPGJyPg0KKzxicj4NCis8YnI+DQor
cGlkID0gb3MuZm9yaygpOzxicj4NCis8YnI+DQoraWYgcGlkOjxicj4NCivCoCDCoCAjIEluIFBy
b3h5PGJyPg0KK8KgIMKgIHByaW50KCYjMzk7TGF1bmNoaW5nIFFFTVUgd2l0aCBQcm94eSBvYmpl
Y3QmIzM5Oyk7PGJyPg0KK8KgIMKgIHByb2Nlc3MgPSBzdWJwcm9jZXNzLlBvcGVuKHByb3h5X2Nt
ZCwgcGFzc19mZHM9W3Byb3h5LmZpbGVubygpXSk8YnI+DQorZWxzZTo8YnI+DQorwqAgwqAgIyBJ
biByZW1vdGU8YnI+DQorwqAgwqAgcHJpbnQoJiMzOTtMYXVuY2hpbmcgUmVtb3RlIHByb2Nlc3Mm
IzM5Oyk7PGJyPg0KK8KgIMKgIHByb2Nlc3MgPSBzdWJwcm9jZXNzLlBvcGVuKHJlbW90ZV9jbWQs
IHBhc3NfZmRzPVtyZW1vdGUuZmlsZW5vKCldKTxicj4NCi0tIDxicj4NCjIuMjUuR0lUPGJyPg0K
PGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2PjxiciBjbGVhcj0iYWxsIj48ZGl2Pjxicj48
L2Rpdj4tLSA8YnI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSI+wqAgwqAg
wqAgwqDCoCDmraToh7Q8YnI+56S8PGJyPue9l+WLh+WImjxicj5Zb3Vyczxicj7CoCDCoCBzaW5j
ZXJlbHksPGJyPllvbmdnYW5nIEx1bzxicj48L2Rpdj4NCg==
--0000000000006c060f05a3f59739--

