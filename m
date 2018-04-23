Received: from eggs.gnu.org ([2001:4830:134:3::10]:58441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fAbO7-0006Bp-3F
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fAbO6-0005fX-8a
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:20:11 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180420220913.27000-1-mreitz@redhat.com>
References: <20180420220913.27000-1-mreitz@redhat.com>
Date: Mon, 23 Apr 2018 15:19:27 +0200
Message-ID: <w51muxuxdpc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/3] block/file-posix: File
 locking during creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Sat 21 Apr 2018 12:09:10 AM CEST, Max Reitz wrote:
> Currently we do not take permissions on a file while it is being
> created.  That is a bit sad.  The simplest way to test this is the
> following:
>
>     $ qemu-img create -f qcow2 foo.qcow2 64M
>     Formatting 'foo.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
>     $ qemu-img convert -f qcow2 -O qcow2 foo.qcow2 foo.qcow2
>     qemu-img: foo.qcow2: error while converting qcow2: Failed to get "write" lock
>     Is another process using the image?
>     $ qemu-img info foo.qcow2
>     image: foo.qcow2
>     file format: raw
>     virtual size: 0 (0 bytes)
>     disk size: 0

Not quite the same problem, but here's another example of QEMU creating
an image before checking if it can be created:

$ qemu-img create -o cluster_size=2M -f qcow2 img.qcow2 7E
Formatting 'img.qcow2', fmt=qcow2 size=8070450532247928832 encryption=off cluster_size=2097152 lazy_refcounts=off refcount_bits=16
qemu-img: img.qcow2: The image size is too large for file format 'qcow2' (try using a larger cluster size)

$ qemu-img info img.qcow2 
image: img.qcow2
file format: qcow2
virtual size: 0 (0 bytes)
disk size: 6.0M
cluster_size: 2097152
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false

Berto
