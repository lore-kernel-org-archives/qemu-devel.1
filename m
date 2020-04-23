Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CA8C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6807B20857
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WgSiBtUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6807B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRdWx-0004eY-HD
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1jRdNs-00078t-N9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1jRdNr-0006i7-8I
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:03:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jRdNq-0006gX-Kn
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:03:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NF2lX3099166;
 Thu, 23 Apr 2020 15:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=yYVt4morEt0inPIGWrmu8dWMdIHKsGhkju49P2JbVeI=;
 b=WgSiBtUVDC8bdHALx1ANl9yT03zDlFZGegKOP7nSRquRjXVJSW+e03qvCAbmVHUjruH6
 uk6d6JN+RNwPx8X4qxs+L2J6ghAFLnKWQEAEXQXpYkhY5TeICzzjMc320HrPqLdoHs1T
 2DRALNgV8SuG3JvbMTx08DF+41qET2YfPFi97logsyNeqYuQD671FrgkCR/xZs4fZHqq
 ec/XNIhqso472JkERgdQOAnP53mL/uwAfXke9SVhaFAmlheVD4GIPXQGsdlGN2qoD4DY
 0cVhBShnw9WjfgTbgFkECo7dUjQrFXj2zw81pBgo1DwEUtiEYWxjpGSn81Wxl7CTu9ux 5Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 30grpgwjqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 15:03:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NEmQUP085838;
 Thu, 23 Apr 2020 15:01:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 30gb1mvmhj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 15:01:06 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03NF132Y010472;
 Thu, 23 Apr 2020 15:01:03 GMT
Received: from [10.39.224.123] (/10.39.224.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 23 Apr 2020 08:01:02 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH RESEND v6 36/36] multi-process: add configure and usage
 information
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <CAE2XoE8WeGXL93G6uLsKDVNrjxWFq5PTO853bdkuzDQ9fB9dtw@mail.gmail.com>
Date: Thu, 23 Apr 2020 11:01:33 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <271ABACC-3817-43CF-8752-F0FBDDDE6080@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <526ab3d1a840ad0693c6c8d38e56602d2c53024b.1587614626.git.elena.ufimtseva@oracle.com>
 <CAE2XoE8WeGXL93G6uLsKDVNrjxWFq5PTO853bdkuzDQ9fB9dtw@mail.gmail.com>
To: luoyonggang@gmail.com
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=1 bulkscore=0 clxscore=1011
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230118
Received-SPF: pass client-ip=156.151.31.86; envelope-from=jag.raman@oracle.com;
 helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 11:03:18
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Apr 23, 2020, at 9:54 AM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) =
<luoyonggang@gmail.com> wrote:
>=20
> Does multi-process support on Windows?
> I found it use mmap and unix socket for inter-process communication, =
that may not support under Windows.

Hi Yonggang,

We have only tested this on Linux till now. Are you using QEMU with =
Windows?

> And also, can the python script be replaced by C implementation?

The functionality in the python script would eventually move to libvirt. =
The python
script is a temporary measure.

Thank you very much!
=E2=80=94
Jag

>=20
> On Thu, Apr 23, 2020 at 12:38 PM <elena.ufimtseva@oracle.com> wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  MAINTAINERS                          |  2 +
>  docs/multi-process.rst               | 85 +++++++++++++++++++++++++
>  scripts/mpqemu-launcher-perf-mode.py | 92 =
++++++++++++++++++++++++++++
>  scripts/mpqemu-launcher.py           | 53 ++++++++++++++++
>  4 files changed, 232 insertions(+)
>  create mode 100644 docs/multi-process.rst
>  create mode 100755 scripts/mpqemu-launcher-perf-mode.py
>  create mode 100755 scripts/mpqemu-launcher.py
>=20
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
>=20
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
> +Multi-process QEMU requires an orchestrator to launch. Please refer =
to a
> +light-weight python based orchestrator for mpqemu in
> +scripts/mpqemu-launcher.py to lauch QEMU in multi-process mode.
> +
> +scripts/mpqemu-launcher-perf-mode.py launches in "perf" mode. In this =
mode,
> +the same QEMU process connects to multiple remote devices, each =
emulated in
> +a separate process.
> +
> +As of now, we only support the emulation of lsi53c895a in a separate =
process.
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
> +  - The remaining options are no different from how one launches QEMU =
with
> +    devices. The only other requirement is each PCI device must have =
a
> +    unique ID specified to it. This is needed to pair remote device =
with the
> +    Proxy object.
> +
> +  - Example command-line for the remote process is as follows:
> +
> +      /usr/bin/qemu-scsu-dev 4                                        =
   \
> +      -device lsi53c895a,id=3Dlsi0                                    =
     \
> +      -drive id=3Ddrive_image2,file=3D/build/ol7-nvme-test-1.qcow2    =
       \
> +      -device =
scsi-hd,id=3Ddrive2,drive=3Ddrive_image2,bus=3Dlsi0.0,scsi-id=3D0
> +
> +* QEMU:
> +
> +  - Since parts of the RAM are shared between QEMU & remote process, =
a
> +    memory-backend-memfd is required to facilitate this, as follows:
> +
> +    -object memory-backend-memfd,id=3Dmem,size=3D2G
> +
> +  - A "pci-proxy-dev" device is created for each of the PCI devices =
emulated
> +    in the remote process. A "socket" sub-option specifies the other =
end of
> +    unix channel created by orchestrator. The "id" sub-option must be =
specified
> +    and should be the same as the "id" specified for the remote PCI =
device
> +
> +  - Example commandline for QEMU is as follows:
> +
> +      -device pci-proxy-dev,id=3Dlsi0,socket=3D3
> +
> +* Monitor / QMP:
> +
> +  - The remote process supports QEMU monitor. It could be specified =
using the
> +    "-monitor" or "-qmp" command-line options
> +
> +  - As an example, one could connect to the monitor by adding the =
following
> +    to the command-line of the remote process
> +
> +      -monitor unix:/home/qmp-sock,server,nowait
> +
> +  - The user could connect to the monitor using the qmp script or =
using
> +    "socat" as outlined below:
> +
> +      socat /home/qmp-sock stdio
> diff --git a/scripts/mpqemu-launcher-perf-mode.py =
b/scripts/mpqemu-launcher-perf-mode.py
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
> +proxy_1, remote_1 =3D socket.socketpair(socket.AF_UNIX, =
socket.SOCK_STREAM)
> +proxy_2, remote_2 =3D socket.socketpair(socket.AF_UNIX, =
socket.SOCK_STREAM)
> +proxy_3, remote_3 =3D socket.socketpair(socket.AF_UNIX, =
socket.SOCK_STREAM)
> +
> +remote_cmd_1 =3D [ PROC_REMOTE,                                       =
           \
> +                 str(remote_1.fileno()),                              =
         \
> +                 '-device', 'lsi53c895a,id=3Dlsi1',                   =
           \
> +                 '-drive', 'id=3Ddrive_image1,'                       =
           \
> +                               'file=3D/build/ol7-nvme-test-1.qcow2', =
           \
> +                 '-device', 'scsi-hd,id=3Ddrive1,drive=3Ddrive_image1,'=
            \
> +                                'bus=3Dlsi1.0,scsi-id=3D0',           =
             \
> +               ]
> +
> +remote_cmd_2 =3D [ PROC_REMOTE,                                       =
           \
> +                 str(remote_2.fileno()),                              =
         \
> +                 '-device', 'lsi53c895a,id=3Dlsi2',                   =
           \
> +                 '-drive', 'id=3Ddrive_image2,'                       =
           \
> +                               'file=3D/build/ol7-nvme-test-2.qcow2', =
           \
> +                 '-device', 'scsi-hd,id=3Ddrive2,drive=3Ddrive_image2,'=
            \
> +                                'bus=3Dlsi2.0,scsi-id=3D0'            =
             \
> +               ]
> +
> +remote_cmd_3 =3D [ PROC_REMOTE,                                       =
           \
> +                 str(remote_3.fileno()),                              =
         \
> +                 '-device', 'lsi53c895a,id=3Dlsi3',                   =
           \
> +                 '-drive', 'id=3Ddrive_image3,'                       =
           \
> +                               'file=3D/build/ol7-nvme-test-3.qcow2', =
           \
> +                 '-device', 'scsi-hd,id=3Ddrive3,drive=3Ddrive_image3,'=
            \
> +                                'bus=3Dlsi3.0,scsi-id=3D0'            =
             \
> +               ]
> +
> +proxy_cmd =3D [ PROC_QEMU,                                            =
           \
> +              '-name', 'OL7.4',                                       =
         \
> +              '-machine', 'q35,accel=3Dkvm',                          =
           \
> +              '-smp', 'sockets=3D1,cores=3D1,threads=3D1',            =
               \
> +              '-m', '2048',                                           =
         \
> +              '-object', =
'memory-backend-memfd,id=3Dsysmem-file,size=3D2G',        \
> +              '-numa', 'node,memdev=3Dsysmem-file',                   =
           \
> +              '-device', 'virtio-scsi-pci,id=3Dvirtio_scsi_pci0',     =
           \
> +              '-drive', 'id=3Ddrive_image1,if=3Dnone,format=3Dqcow2,' =
               \
> +                            'file=3D/home/ol7-hdd-1.qcow2',           =
           \
> +              '-device', 'scsi-hd,id=3Dimage1,drive=3Ddrive_image1,'  =
             \
> +                             'bus=3Dvirtio_scsi_pci0.0',              =
           \
> +              '-boot', 'd',                                           =
         \
> +              '-vnc', ':0',                                           =
         \
> +              '-device', 'pci-proxy-dev,id=3Dlsi1,'                   =
           \
> +                             'socket=3D'+str(proxy_1.fileno()),       =
           \
> +              '-device', 'pci-proxy-dev,id=3Dlsi2,'                   =
           \
> +                             'socket=3D'+str(proxy_2.fileno()),       =
           \
> +              '-device', 'pci-proxy-dev,id=3Dlsi3,'                   =
           \
> +                             'socket=3D'+str(proxy_3.fileno())        =
           \
> +            ]
> +
> +
> +pid =3D os.fork();
> +if pid =3D=3D 0:
> +    # In remote_1
> +    print('Launching Remote process 1');
> +    process =3D subprocess.Popen(remote_cmd_1, =
pass_fds=3D[remote_1.fileno()])
> +    os._exit(0)
> +
> +
> +pid =3D os.fork();
> +if pid =3D=3D 0:
> +    # In remote_2
> +    print('Launching Remote process 2');
> +    process =3D subprocess.Popen(remote_cmd_2, =
pass_fds=3D[remote_2.fileno()])
> +    os._exit(0)
> +
> +
> +pid =3D os.fork();
> +if pid =3D=3D 0:
> +    # In remote_3
> +    print('Launching Remote process 3');
> +    process =3D subprocess.Popen(remote_cmd_3, =
pass_fds=3D[remote_3.fileno()])
> +    os._exit(0)
> +
> +
> +print('Launching Proxy process');
> +process =3D subprocess.Popen(proxy_cmd, pass_fds=3D[proxy_1.fileno(), =
             \
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
> +proxy, remote =3D socket.socketpair(socket.AF_UNIX, =
socket.SOCK_STREAM)
> +
> +remote_cmd =3D [ PROC_REMOTE,                                         =
           \
> +               str(remote.fileno()),                                  =
         \
> +               '-device', 'lsi53c895a,id=3Dlsi1',                     =
           \
> +               '-drive', =
'id=3Ddrive_image1,file=3D/build/ol7-nvme-test-1.qcow2',  \
> +               '-device', =
'scsi-hd,id=3Ddrive1,drive=3Ddrive_image1,bus=3Dlsi1.0,'   \
> +                              'scsi-id=3D0',                          =
           \
> +               '-device', 'lsi53c895a,id=3Dlsi2',                     =
           \
> +               '-drive', =
'id=3Ddrive_image2,file=3D/build/ol7-nvme-test-2.qcow2',  \
> +               '-device', =
'scsi-hd,id=3Ddrive2,drive=3Ddrive_image2,bus=3Dlsi2.0,'   \
> +                              'scsi-id=3D0'                           =
           \
> +             ]
> +
> +proxy_cmd =3D [ PROC_QEMU,                                            =
           \
> +              '-name', 'OL7.4',                                       =
         \
> +              '-machine', 'q35,accel=3Dkvm',                          =
           \
> +              '-smp', 'sockets=3D1,cores=3D1,threads=3D1',            =
               \
> +              '-m', '2048',                                           =
         \
> +              '-object', =
'memory-backend-memfd,id=3Dsysmem-file,size=3D2G',        \
> +              '-numa', 'node,memdev=3Dsysmem-file',                   =
           \
> +              '-device', 'virtio-scsi-pci,id=3Dvirtio_scsi_pci0',     =
           \
> +              '-drive', 'id=3Ddrive_image1,if=3Dnone,format=3Dqcow2,' =
               \
> +                            'file=3D/home/ol7-hdd-1.qcow2',           =
           \
> +              '-device', 'scsi-hd,id=3Dimage1,drive=3Ddrive_image1,'  =
             \
> +                             'bus=3Dvirtio_scsi_pci0.0',              =
           \
> +              '-boot', 'd',                                           =
         \
> +              '-vnc', ':0',                                           =
         \
> +              '-device', =
'pci-proxy-dev,id=3Dlsi1,socket=3D'+str(proxy.fileno()),  \
> +              '-device', =
'pci-proxy-dev,id=3Dlsi2,socket=3D'+str(proxy.fileno())   \
> +            ]
> +
> +
> +pid =3D os.fork();
> +
> +if pid:
> +    # In Proxy
> +    print('Launching QEMU with Proxy object');
> +    process =3D subprocess.Popen(proxy_cmd, =
pass_fds=3D[proxy.fileno()])
> +else:
> +    # In remote
> +    print('Launching Remote process');
> +    process =3D subprocess.Popen(remote_cmd, =
pass_fds=3D[remote.fileno()])
> --=20
> 2.25.GIT
>=20
>=20
>=20
>=20
> --=20
>          =E6=AD=A4=E8=87=B4
> =E7=A4=BC
> =E7=BD=97=E5=8B=87=E5=88=9A
> Yours
>     sincerely,
> Yonggang Luo


