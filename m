Received: from eggs.gnu.org ([2001:4830:134:3::10]:45753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCnGd-0002U3-CI
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCnGa-00067s-9O
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:53:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCnGa-00067h-0P
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 08:53:12 -0500
Date: Thu, 9 Nov 2017 13:53:06 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171109135306.GF18164@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1509072544-89012-1-git-send-email-eswierk@skyportsystems.com>
	<1510202357-124052-1-git-send-email-eswierk@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1510202357-124052-1-git-send-email-eswierk@skyportsystems.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] e1000e: Reimplement e1000 as a
 variant of e1000e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Leonid Bloch <leonid.bloch@ravellosystems.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org

FWIW, it is generally recommended that new versions of patch series be
posted as a new top level thread, not in-reply-to the previous version.
That way the new posting gets attention near top of a dev's email inbox,
as opposed to hidden away as a reply to a weeks old msg at the back of
the inbox.

On Wed, Nov 08, 2017 at 08:39:15PM -0800, Ed Swierk via Qemu-devel wrote:
> From a hardware functionality and register perspective, the Intel
> 8254x Gigabit Ethernet Controller[1] is roughly a subset of the Intel
> 82574[2], making it practical to implement e1000 device emulation as
> an extension of e1000e.
> 
> That would be a step towards eliminating the existing e1000
> implementation--a bunch of semi-redundant code with its own bugs (like
> the faulty tx checksum offload I reported recently[3]).
> 
> [1] https://www.intel.com/content/dam/doc/manual/pci-pci-x-family-gbe-controllers-software-dev-manual.pdf
> [2] https://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf
> [3] https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg03008.html
> 
> This patch series adds a new e1000-ng device but leaves the existing
> e1000 device alone. Linux 4.1 and Windows 10 e1000 guest drivers
> recognize the e1000-ng device and successfully pass traffic on a Linux
> host.
> 
> Preliminary performance measurements are encouraging: with e1000-ng,
> single-threaded TCP iperf shows about a 2x speedup in tx and rx
> throughput vs e1000, and CPU usage is slighly lower.

That is certainly attractive.

> A ton of work is needed before e1000-ng will be ready to supplant
> e1000: testing with every random guest OS, fixing bugs, figuring out
> migration and other missing functionality. There's no way I can do
> this myself.
> 
> I'd like to propose a more modest and achievable short-term goal: find
> and fix any regressions that might affect users of e1000e and e1000,
> so that the patches can be applied and folks can easily start trying
> out e1000-ng with their favorite guest OS. That means accepting (for
> now) known deficiencies in the new e1000-ng devices, which can be
> addressed by myself and (hopefully) others in follow-up patches. Does
> that sound reasonable?

My fear is that this approach of building a new e1000-ng device in
parallel with having the existing e1000 device is going to cause
long term pain, possibly never getting to a state where the e1000-ng
device can replace the e1000 device. Any time there needs to be a
"big bang" to switch from one impl to another completely different
impl always causes trouble IME. With need for migration wire format
& state compatibility, this is even more difficult. From a code review
POV it will be essentially impossible to have confidence that the new
impl can be a viable drop-in replacement for the old impl.

Is there really no way that you can change the approach to do a more
incremental conversion of the existing code base, but still end up in
the same place at the very end ?

eg just copy all the e1000.c code into the e1000e.c file to start with.
Then gradually merge functional areas over a longish series of patches
to eliminate the duplication. This would make it far more practical to
identify where any regressions come from, and will give reviewers more
confidence that we're not breaking migration compat.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
