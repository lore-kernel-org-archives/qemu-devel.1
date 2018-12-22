Received: from eggs.gnu.org ([2001:4830:134:3::10]:35844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1gadZl-0002XX-2U
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1gadZg-0000Tg-Vz
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:28:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43190 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiangyiwen@huawei.com>)
	id 1gadZg-0000Qb-L6
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:28:00 -0500
References: <20181210173151.16629-1-dgilbert@redhat.com>
From: jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5C1E0380.8060702@huawei.com>
Date: Sat, 22 Dec 2018 17:27:28 +0800
MIME-Version: 1.0
In-Reply-To: <20181210173151.16629-1-dgilbert@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] virtio-fs: shared file system for
 virtual machines3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: sweil@redhat.com, swhiteho@redhat.com, stefanha@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu

On 2018/12/11 1:31, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   This is the first RFC for the QEMU side of 'virtio-fs';
> a new mechanism for mounting host directories into the guest
> in a fast, consistent and secure manner.  Our primary use
> case is kata containers, but it should be usable in other scenarios
> as well.
> 
> There are corresponding patches being posted to Linux kernel,
> libfuse and kata lists.
> 
> For a fuller design description, and benchmark numbers, please see
> Vivek's posting of the kernel set here:
> 
> https://marc.info/?l=linux-kernel&m=154446243024251&w=2
> 
> We've got a small website with instructions on how to use it, here:
> 
> https://virtio-fs.gitlab.io/
> 
> and all the code is available on gitlab at:
> 
> https://gitlab.com/virtio-fs
> 
> QEMU's changes
> --------------
> 
> The QEMU changes are pretty small; 
> 
> There's a new vhost-user device, which is used to carry a stream of
> FUSE messages to an external daemon that actually performs
> all the file IO.  The FUSE daemon is an external process in order to
> achieve better isolation for security and resource control (e.g. number
> of file descriptors) and also because it's cleaner than trying to
> integrate libfuse into QEMU.
> 
> This device has an extra BAR that contains (up to) 3 regions:
> 
>  a) a DAX mapping range ('the cache') - into which QEMU mmap's
>     files on behalf of the external daemon; those files are
>     then directly mapped by the guest in a way similar to a DAX
>     backed file system;  one advantage of this is that multiple
>     guests all accessing the same files should all be sharing
>     those pages of host cache.
> 
>  b) An experimental set of mappings for use by a metadata versioning
>     daemon;  this mapping is shared between multiple guests and
>     the daemon, but only contains a set of version counters that
>     allow a guest to quickly tell if its metadata is stale.
> 
> TODO
> ----
> 
> This is the first RFC, we know we have a bunch of things to clear up:
> 
>   a) The virtio device specificiation is still in flux and is expected
>      to change
> 
>   b) We'd like to find ways of reducing the map/unmap latency for DAX
> 
>   c) The metadata versioning scheme needs to settle out.
> 
>   d) mmap'ing host files has some interesting side effects; for example
>      if the file gets truncated by the host and then the guest accesses
>      the mapping, KVM can fail the guest hard.
> 
> Dr. David Alan Gilbert (6):
>   virtio: Add shared memory capability
>   virtio-fs: Add cache BAR
>   virtio-fs: Add vhost-user slave commands for mapping
>   virtio-fs: Fill in slave commands for mapping
>   virtio-fs: Allow mapping of meta data version table
>   virtio-fs: Allow mapping of journal
> 
> Stefan Hajnoczi (1):
>   virtio: add vhost-user-fs-pci device
> 
>  configure                                   |  10 +
>  contrib/libvhost-user/libvhost-user.h       |   3 +
>  docs/interop/vhost-user.txt                 |  35 ++
>  hw/virtio/Makefile.objs                     |   1 +
>  hw/virtio/vhost-user-fs.c                   | 517 ++++++++++++++++++++
>  hw/virtio/vhost-user.c                      |  16 +
>  hw/virtio/virtio-pci.c                      | 115 +++++
>  hw/virtio/virtio-pci.h                      |  19 +
>  include/hw/pci/pci.h                        |   1 +
>  include/hw/virtio/vhost-user-fs.h           |  79 +++
>  include/standard-headers/linux/virtio_fs.h  |  48 ++
>  include/standard-headers/linux/virtio_ids.h |   1 +
>  include/standard-headers/linux/virtio_pci.h |   9 +
>  13 files changed, 854 insertions(+)
>  create mode 100644 hw/virtio/vhost-user-fs.c
>  create mode 100644 include/hw/virtio/vhost-user-fs.h
>  create mode 100644 include/standard-headers/linux/virtio_fs.h
> 

Hi Dave,

I encounter a problem after running qemu with virtio-fs,

I find I only can mount virtio-fs using the following command:
mount -t virtio_fs /dev/null /mnt/virtio_fs/ -o tag=myfs,rootmode=040000,user_id=0,group_id=0
or mount -t virtio_fs /dev/null /mnt/virtio_fs/ -o tag=myfs,rootmode=040000,user_id=0,group_id=0,dax

Then, I want to know how to use "cache=always" or "cache=none", even "cache=auto", "cache=writeback"?

Thanks,
Yiwen.
