Received: from eggs.gnu.org ([2001:4830:134:3::10]:50542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d8TzC-0003Ze-40
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1d8TzB-0004FO-67
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:57:10 -0400
Date: Wed, 10 May 2017 16:57:00 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170510155700.GY16511@redhat.com>
References: <20170510143205.32013-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170510143205.32013-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] curl: locking cleanups/fixes,
 coroutine conversion, remove aio_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org

On Wed, May 10, 2017 at 04:31:58PM +0200, Paolo Bonzini wrote:
> Since the last patch in v1 didn't work, I bit the bullet and converted
> the whole thing to coroutines (patches 4-6).  This in turns allows a more
> elegant solution to wait for CURLStates to get free (patch 7).
> 
> I tested this by lowering CURL_NUM_STATES to 2.  With this change, the
> buggy case triggers a couple times while booting a Fedora netinst image.

This series fixes the original bug, so:

  Tested-by: Richard W.M. Jones <rjones@redhat.com>

I think the Reported-by in patch 3 should credit Kun Wei for finding
the bug, and we should probably mention the BZ too:

  Reported-by: Kun Wei <kuwei@redhat.com>
  Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1447590

A nit pick perhaps but in patch 5 you say "This was broken before for
disks > 2TB, but now it would break at 4GB.".
I understand after reading it a few times that you mean it would be
broken at 4GB, if you hadn't changed size_t -> uint64_t (on 32 bit
platforms).  Perhaps better to clarify that sentence.

---

I also ran some performance and stability testing.  I used virt-ls for
this.  The following command will iterate over every file in a remote
guest image and print an md5sum:

  LIBGUESTFS_BACKEND=direct \
  LIBGUESTFS_HV=~/d/qemu/x86_64-softmmu/qemu-system-x86_64 \
  virt-ls -a http://somehost/rhel-guest-image-7.1-20150224.0.x86_64.qcow2 \
          -lR --checksum /

I timed this with and without your patches, but there was no
significant difference (but note that virt-ls is a fundamentally
sequential program).

It didn't crash or hang at any time during my testing.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
