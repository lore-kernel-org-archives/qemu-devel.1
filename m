Received: from eggs.gnu.org ([2001:4830:134:3::10]:49082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gKOwu-0006XZ-EE
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 09:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gKOwt-0008WS-B7
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 09:36:52 -0500
Date: Wed, 7 Nov 2018 14:36:28 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181107143628.GG8125@redhat.com>
References: <20181107121319.GC14842@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107121319.GC14842@redhat.com>
Subject: Re: [Qemu-devel] Change in qemu 2.12 causes qemu-img convert to NBD
 to write more data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, eblake@redhat.com, qemu-block@nongnu.org, Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Cc: nsoffer@redhat.com

Another thing I tried was to change the NBD server (nbdkit) so that it
doesn't advertise zero support to the client:

  $ nbdkit --filter=log --filter=nozero memory size=6G logfile=/tmp/log \
      --run './qemu-img convert ./fedora-28.img -n $nbd'
  $ grep '\.\.\.$' /tmp/log | sed 's/.*\([A-Z][a-z]*\).*/\1/' | uniq -c 
   2154 Write

Not surprisingly no zero commands are issued.  The size of the write
commands is very uneven -- it appears to be send one command per block
of zeroes or data.

Nir: If we could get information from imageio about whether zeroing is
implemented efficiently or not by the backend, we could change
virt-v2v / nbdkit to advertise this back to qemu.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
