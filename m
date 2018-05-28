Received: from eggs.gnu.org ([2001:4830:134:3::10]:46130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNFfp-0001sg-O2
	for qemu-devel@nongnu.org; Mon, 28 May 2018 06:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNFfm-0005zl-Lf
	for qemu-devel@nongnu.org; Mon, 28 May 2018 06:46:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45948 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNFfm-0005yy-G9
	for qemu-devel@nongnu.org; Mon, 28 May 2018 06:46:42 -0400
Date: Mon, 28 May 2018 18:46:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180528104636.GF2584@xz-mi>
References: <152749874146.3829.13327505377905335957.malonedeb@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <152749874146.3829.13327505377905335957.malonedeb@chaenomeles.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1773753] [NEW] virsh managed save fails with
 qemu version v2.12.0-813-g5a5c383b13-dirty on powerpc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1773753 <1773753@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Mon, May 28, 2018 at 09:12:21AM -0000, Satheesh Rajendran wrote:
> Public bug reported:
> 
> Host Env:
> IBM Power8 with Fedora28 base with compiled upstream kernel, qemu, libvirt.
> 
> Host Kernel: 4.17.0-rc5-00069-g3acf4e395260
> 
> qemu-kvm(5a5c383b1373aeb6c87a0d6060f6c3dc7c53082b):
> v2.12.0-813-g5a5c383b13-dirty
> 
> libvirt(4804a4db33a37f828d033733bc47f6eff5d262c3):
> 
> Guest Kernel: 4.17.0-rc7
> 
> Steps to recreate:
> Define a guest attached with above setup and start.
> # virsh start avocado-vt-vm1
> 
> guest console;...
> # uname -r
> 4.17.0-rc7
> [root@atest-guest ~]# lscpu
> Architecture:        ppc64le
> Byte Order:          Little Endian
> CPU(s):              3
> On-line CPU(s) list: 0-2
> Thread(s) per core:  1
> Core(s) per socket:  1
> Socket(s):           3
> NUMA node(s):        1
> Model:               2.1 (pvr 004b 0201)
> Model name:          POWER8 (architected), altivec supported
> Hypervisor vendor:   KVM
> Virtualization type: para
> L1d cache:           64K
> L1i cache:           32K
> NUMA node0 CPU(s):   0-2
> 
> 
> # virsh managedsave avocado-vt-vm1 
> 
> Domain avocado-vt-vm1 state saved by libvirt
> 
> # virsh list
>  Id    Name                           State
> ----------------------------------------------------
> 
> # virsh start avocado-vt-vm1 ----Hangs forever and vm state goes to
> paused.

Libvirt is using fd migration, right?  If so, I suspect this is the
same problem with the iotest failure, and the fix should be in a pull
request:

  Message-Id: <20180525133246.7839-2-quintela@redhat.com>
  Subject: [Qemu-devel] [PULL 1/2] migration: fix exec/fd migrations

Regards,

-- 
Peter Xu
