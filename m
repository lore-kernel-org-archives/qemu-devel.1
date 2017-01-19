Received: from eggs.gnu.org ([2001:4830:134:3::10]:45289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cUGd1-0001Nc-DW
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cUGd0-0004q1-4x
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:36:03 -0500
Date: Thu, 19 Jan 2017 17:35:53 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170119173553.GH1947@redhat.com>
References: <20170119143816.21972-1-famz@redhat.com>
	<20170119143816.21972-15-famz@redhat.com>
	<20170119154900.GB16641@redhat.com>
	<9d9d7b54-bc34-e0fe-79d9-1ec83472aca9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d9d7b54-bc34-e0fe-79d9-1ec83472aca9@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v10 14/16] file-posix:
 Implement image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, Jan 19, 2017 at 10:19:29AM -0600, Eric Blake wrote:
> On 01/19/2017 09:49 AM, Daniel P. Berrange wrote:
> > On Thu, Jan 19, 2017 at 10:38:14PM +0800, Fam Zheng wrote:
> >> This implements open flag sensible image locking for local file
> >> and host device protocol.
> >>
> >> virtlockd in libvirt locks the first byte, so we start looking at the
> >> file bytes from 1.
> >>
> >> Quoting what was proposed by Kevin Wolf <kwolf@redhat.com>, there are
> >> four locking modes by combining two bits (BDRV_O_RDWR and
> >> BDRV_O_SHARE_RW), and implemented by taking two locks:
> >>
> 
> >> +/* Posix file locking bytes. Libvirt takes byte 0, so start from byte 1. */
> >> +#define RAW_LOCK_BYTE_MIN             1
> >> +#define RAW_LOCK_BYTE_NO_OTHER_WRITER 1
> >> +#define RAW_LOCK_BYTE_WRITE           2
> > 
> > ...would you mind if QEMU started from say byte 10, leaving the first 10
> > reserved for libvirt uses. This lets libvirt have a continuous space for
> > its own usage if we want to use more bytes
> 
> Thankfully, fcntl() locks can be taken beyond end-of-file, so I think
> we're okay making an arbitrarily larger range of bytes reserved for each
> process, even in the unlikely corner case of passing files smaller than
> 512 bytes.

Not so unlikely.  libguestfs actually detects and works around this
case because qemu was (possibly still is) very broken when you pass
small files.

https://github.com/libguestfs/libguestfs/blob/master/src/drives.c#L395-L441

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
