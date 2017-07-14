Received: from eggs.gnu.org ([2001:4830:134:3::10]:40767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dVxS8-0001f6-1Q
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dVxS7-0002bx-3N
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:04:04 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dVxS6-0002aB-T3
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:04:03 -0400
Received: by mail-wr0-x22e.google.com with SMTP id 77so65067888wrb.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:04:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AT5PR84MB01648353F49E25D22EB79EFBA0AC0@AT5PR84MB0164.NAMPRD84.PROD.OUTLOOK.COM>
References: <AT5PR84MB01644325A091571A2841C65EA0A90@AT5PR84MB0164.NAMPRD84.PROD.OUTLOOK.COM>
	<20170711091841.GE17792@stefanha-x1.localdomain>
	<AT5PR84MB01648353F49E25D22EB79EFBA0AC0@AT5PR84MB0164.NAMPRD84.PROD.OUTLOOK.COM>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 14 Jul 2017 11:03:59 +0100
Message-ID: <CAJSP0QVhP_-e=WrxVnCWz+3hiL0K8ZE1mieVf3txcb-xYsh3UQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Disparity between host and guest CPU utilization
 during disk IO benchmark
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Nagarajan, Padhu (HPE Storage)" <padhu@hpe.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, Jul 14, 2017 at 12:34 AM, Nagarajan, Padhu (HPE Storage)
<padhu@hpe.com> wrote:
> Thanks Stefan. Couldn't get to this earlier. Did another run and took a d=
iff of /proc/interrupts before and after the run. It shows all the interrup=
ts for 'virtio7-req.0' going to CPU1. I guess that explains the "CPU1/KVM" =
vcpu utilization on the host.
>
> 34:        147     666085          0          0   PCI-MSI-edge      virti=
o7-req.0
>
> The only remaining question is the high CPU utilization of the vCPU threa=
ds for this workload. Even when I run a light fio workload (queue depth of =
1 which gives 8K IOPS), the vCPU threads are close to 100% utilization. Why=
 is it high and does it have an impact on guest code that could be executin=
g on the same CPU ?

100% is high for 8K IOPS.  I wonder what "perf top" shows on the host
while the fio benchmark is running inside the guest.

The cross-CPU interrupts you saw suggest you can get better
performance by pinning vcpu and iothreads to host CPUs so that
physical storage interrupts are handed by vcpu and iothreads on the
same host CPU.  See libvirt documentation for pinning vcpus and
iothreads.

Stefan
