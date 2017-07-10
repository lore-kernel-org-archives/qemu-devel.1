Received: from eggs.gnu.org ([2001:4830:134:3::10]:39472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUYRz-00048I-F2
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUYRy-0000iN-B9
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:10:07 -0400
Date: Mon, 10 Jul 2017 21:09:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170710130942.GD19707@lemon.lan>
References: <20170629132749.997-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170629132749.997-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/11] Block layer thread-safety, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

On Thu, 06/29 15:27, Paolo Bonzini wrote:
> This part takes care of drivers and devices, making sure that they can
> accept concurrent I/O from multiple AioContext.
> 
> The following drivers are thread-safe without using any QemuMutex/CoMutex:
> crypto, gluster, null, rbd, win32-aio.  NBD has already been fixed,
> because the patch fixed an unrelated testcase.
> 
> The following drivers already use mutexes for everything except possibly
> snapshots, which do not (yet?) need protection: bochs, cloop, dmg, qcow,
> parallels, vhdx, vmdk, curl, iscsi, nfs.
> 
> The following drivers already use mutexes for _almost_ everything: vpc
> (missing get_block_status), vdi (missing bitmap access), vvfat (missing
> commit), not protected), qcow2 (must call CoQueue APIs under CoMutex).
> They are fixed by patches 1-5.
> 
> The following drivers must be changed to use CoMutex to protect internal
> data: qed (patches 6-9), sheepdog (patch 10).
> 
> The following driver must be changed to support I/O from any AioContext:
> ssh.  It is fixed by patch 11.
> 
> Paolo
> 
> v1->v2: new patch 8 + adjustments to patch 9 to fix qemu-iotests testcase
>         183 (bdrv_invalidate_cache from block migration)

Thanks, queued:

https://github.com/famz/qemu/tree/staging

Fam
