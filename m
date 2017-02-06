Received: from eggs.gnu.org ([2001:4830:134:3::10]:36037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1caiaH-0003XN-2c
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1caiaG-00049m-0x
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:39:53 -0500
Date: Mon, 6 Feb 2017 12:39:38 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170206123938.GM3029@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <58986D54.8030002@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58986D54.8030002@huawei.com>
Subject: Re: [Qemu-devel] [libvirt] [Block Replication] Question about
 supporting COLO in libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, libvir-list@redhat.com, kwolf@redhat.com, xuquan8@huawei.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, qemu block <qemu-block@nongnu.org>, wencongyang2@huawei.com, "Dong, Eddie" <eddie.dong@intel.com>, stefanha@redhat.com

On Mon, Feb 06, 2017 at 08:34:28PM +0800, Hailiang Zhang wrote:
> Hi,
> I'm trying to implement supporting COLO in libvirt,
> But i found an annoying problem that libvirt does not
> support the command line option argument syntax we used
> for block replication in QEMU.
> 
> That is libvirt does not support the bellow syntax for block:
> -drive driver=qcow2,file.filename=test:a.qcow2
> -drive file=test.qcow2,\
> backing.file.filename=/dev/fdset/1
> 
> It seems to be a new syntax that libvirt does not support
> thought it has been exist in QEMU for a time.
> I found some introductions from
> http://www.linux-kvm.org/images/3/34/Kvm-forum-2013-block-dev-configuration.pdf
> 
> The command line we use for COLO is just like the above syntax,
> For example, for the shared disk in COLO, it is:
>  -drive if=none,driver=qcow2,file.filename=/mnt/ramfs/hidden_disk.img,id=hidden_disk0,\
>         backing.driver=raw,backing.file.filename=1.raw \
>  -drive if=virtio,id=active-disk0,driver=replication,mode=secondary,\
>         file.driver=qcow2,top-id=active-disk0,\
>         file.file.filename=/mnt/ramfs/active_disk.img,\
>         file.backing=hidden_disk0,shared-disk=on
> 
> For the none-shared disk in COLO, it is quite same with the shared-disk:
>   -drive if=none,driver=raw,file.filename=1.raw,id=colo1 \
>   -drive if=xxx,id=topxxx,driver=replication,mode=secondary,top-id=topxxx\
>          file.file.filename=active_disk.qcow2,\
>          file.driver=qcow2,\
>          file.backing.file.filename=hidden_disk.qcow2,\
>          file.backing.driver=qcow2,\
>          file.backing.backing=colo1
> 
> So there seems to be two ways to solve this problem.
> 
> One is to support this new option argument syntax in libvirt,
> but I'm not sure if it is difficult or not to implement it,
> and i don't know where to start either.

Libvirt has to start supporting this new syntax. It is required for
many different use cases beyond just colo. For example, to be able
to explicitly given qemu details about a backing file format to
remove probing, or to be able to set LUKS passwords on backing files,
and more beside

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
