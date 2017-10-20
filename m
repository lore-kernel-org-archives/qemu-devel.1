Received: from eggs.gnu.org ([2001:4830:134:3::10]:50942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5Qms-0007Oo-HY
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e5Qmr-000563-CM
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:28:06 -0400
Date: Fri, 20 Oct 2017 14:27:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171020062757.GE29815@lemon>
References: <20171009125940.24220-1-ashijeetacharya@gmail.com>
	<20171009141236.GC28199@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009141236.GC28199@lemon>
Subject: Re: [Qemu-devel] [PATCH v9 0/8] Optimize VMDK I/O by allocating
 multiple clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@gmail.com, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com

On Mon, 10/09 22:12, Fam Zheng wrote:
> On Mon, 10/09 18:29, Ashijeet Acharya wrote:
> > Optimization test results:
> > 
> > This patch series improves 128 KB sequential write performance to an
> > empty VMDK file by 54%
> > 
> > Benchmark command: ./qemu-img bench -w -c 1024 -s 128K -d 1 -t none -f
> > vmdk test.vmdk
> > 
> > Changes in v9:
> > - rebase the series
> 
> Thanks, looks good to me, applied:
> 
> https://github.com/famz/qemu/tree/staging

Ashijeet: I've been testing my branch and it seems installing Fedora/CentOS to a
VMDK image is broken with your patches applied. Both guest and QEMU are
responsive, but the installing of packages stops to make any progress at some
point:

Installing rootfiles.noarch (317/318)
Installing langpacks-en.noarch (318/318)
Performing post-installation setup tasks
Configuring fedora-release.noarch
Configuring filesystem.x86_64
Configuring GeoIP-GeoLite-data.noarch
Configuring python3.x86_64
Configuring fedora-logos.x86_64
Configuring kernel-core.x86_64

# hang here

Can you reproduce this on your machine?

My command line is something like this:

qemu-system-x86_64 -enable-kvm -cpu host -m 1G -qmp unix:/home/fam/.q/qemu-8DOC9EF4/qmp,server,nowait -name 8DOC9EF4 -netdev user,id=vnet,hostfwd=:0.0.0.0:10022-:22 -device virtio-net-pci,netdev=vnet -drive file=/var/tmp/test2.vmdk,if=none,id=drive-1,cache=none,aio=native -device virtio-blk-pci,drive=drive-1 -cdrom /stor/iso/CentOS-6.9-x86_64-minimal.iso -pidfile /home/fam/.q/qemu-8DOC9EF4/pid

qemu.git master doesn't have this problem. So I'll drop this series from the
pull request until it is resolved.

Fam
