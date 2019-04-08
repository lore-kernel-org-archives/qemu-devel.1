Received: from eggs.gnu.org ([209.51.188.92]:43406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDNLL-00043L-JH
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 02:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDNDq-0004W7-Ic
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 01:53:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDNDq-0004TE-0o
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 01:53:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190322134447.14831-1-jfreimann@redhat.com>
	<20190404082933.ke7tvryocpdd2h54@jenstp.localdomain>
	<20190405085628.GA2819@work-vm>
	<20190405092010.2hnwu36w4ited4rl@jenstp.localdomain>
Date: Mon, 08 Apr 2019 07:53:21 +0200
In-Reply-To: <20190405092010.2hnwu36w4ited4rl@jenstp.localdomain> (Jens
	Freimann's message of "Fri, 5 Apr 2019 11:20:10 +0200")
Message-ID: <87imvpjb5a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] implement the failover feature for
 assigned network devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, pkrempa@redhat.com, ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, armbru@redhat.com, liran.alon@oracle.com, laine@redhat.com, ogerlitz@mellanox.com, ailan@redhat.com

Jens Freimann <jfreimann@redhat.com> writes:

> On Fri, Apr 05, 2019 at 09:56:29AM +0100, Dr. David Alan Gilbert wrote:
>>* Jens Freimann (jfreimann@redhat.com) wrote:
> [...]
>>> > Commandline: There is a dependency between vfio-pci and virtio-net
>>> > devices. One points to the other via new parameters
>>> > primar=<primary qdev id> and standby='<standby qdev id>'. This means
>>> > that the primary device needs to be specified after standby device on
>>> > the qemu command line. Not sure how to solve this.
>>> >
>>> > Error handling: Patches don't cover all possible error scenarios yet.
>>> >
>>> > I have tested this with a mlx5 NIC and was able to migrate the VM with
>>> > above mentioned workarounds for open problems.
>>> >
>>> > Command line example:
>>> >
>>> > qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
>>> >        -machine q35,kernel-irqchip=split -cpu host   \
>>> >        -k fr   \
>>> >        -serial stdio   \
>>> >        -net none \
>>> >        -qmp unix:/tmp/qmp.socket,server,nowait \
>>> >        -monitor telnet:127.0.0.1:5555,server,nowait \
>>> >        -device pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
>>> >        -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
>>> >        -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
>>> >        -netdev tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on \
>>> >        -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,primary=hostdev0 \
>>> >        -device vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1 \
>>
>>Yes, that's a bit grim; it's circular dependency on the 'hostdev0' and
>>'net1' id's.  cc'ing in Markus.
>
> Dan had an idea how to avoid having to specify the id for the
> virtio-net device. I'm currently looking into it, but it seems like it
> should work. 

Excellent.  A circular dependency between -device could only lead to
trouble.
