Received: from eggs.gnu.org ([2001:4830:134:3::10]:57315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cX6YR-0003Ob-5Z
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:27:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cX6YN-0006RB-DJ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:27:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cX6YN-0006R3-4m
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:26:59 -0500
Date: Fri, 27 Jan 2017 13:26:50 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170127132650.GA31231@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1483601042-6435-1-git-send-email-jitendra.kolhe@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1483601042-6435-1-git-send-email-jitendra.kolhe@hpe.com>
Subject: Re: [Qemu-devel] [PATCH RFC] mem-prealloc: Reduce large guest
 start-up and migration time.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jitendra Kolhe <jitendra.kolhe@hpe.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, armbru@redhat.com, renganathan.meenakshisundaram@hpe.com, mohan_parthasarathy@hpe.com, pbonzini@redhat.com

On Thu, Jan 05, 2017 at 12:54:02PM +0530, Jitendra Kolhe wrote:
> Using "-mem-prealloc" option for a very large guest leads to huge guest
> start-up and migration time. This is because with "-mem-prealloc" option
> qemu tries to map every guest page (create address translations), and
> make sure the pages are available during runtime. virsh/libvirt by
> default, seems to use "-mem-prealloc" option in case the guest is
> configured to use huge pages. The patch tries to map all guest pages
> simultaneously by spawning multiple threads. Given the problem is more
> prominent for large guests, the patch limits the changes to the guests
> of at-least 64GB of memory size. Currently limiting the change to QEMU
> library functions on POSIX compliant host only, as we are not sure if
> the problem exists on win32. Below are some stats with "-mem-prealloc"
> option for guest configured to use huge pages.
> 
> ------------------------------------------------------------------------
> Idle Guest      | Start-up time | Migration time
> ------------------------------------------------------------------------
> Guest stats with 2M HugePage usage - single threaded (existing code)
> ------------------------------------------------------------------------
> 64 Core - 4TB   | 54m11.796s    | 75m43.843s
> 64 Core - 1TB   | 8m56.576s     | 14m29.049s
> 64 Core - 256GB | 2m11.245s     | 3m26.598s
> ------------------------------------------------------------------------
> Guest stats with 2M HugePage usage - map guest pages using 8 threads
> ------------------------------------------------------------------------
> 64 Core - 4TB   | 5m1.027s      | 34m10.565s
> 64 Core - 1TB   | 1m10.366s     | 8m28.188s
> 64 Core - 256GB | 0m19.040s     | 2m10.148s
> -----------------------------------------------------------------------
> Guest stats with 2M HugePage usage - map guest pages using 16 threads
> -----------------------------------------------------------------------
> 64 Core - 4TB   | 1m58.970s     | 31m43.400s
> 64 Core - 1TB   | 0m39.885s     | 7m55.289s
> 64 Core - 256GB | 0m11.960s     | 2m0.135s
> -----------------------------------------------------------------------

For comparison, what is performance like if you replace memset() in
the current code with a call to mlock().

IIUC, huge pages are non-swappable once allocated, so it feels like
we ought to be able to just call mlock() to preallocate them with
no downside, rather than spawning many threads to memset() them.

Of course you'd still need the memset() trick if qemu was given
non-hugepages in combination with --mem-prealloc, as you don't
want to lock normal pages into ram permanently.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
