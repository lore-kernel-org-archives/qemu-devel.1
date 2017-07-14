Received: from eggs.gnu.org ([2001:4830:134:3::10]:43780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVzOG-0004oT-6f
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVzOF-0008JV-7O
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:08:12 -0400
Date: Fri, 14 Jul 2017 13:07:53 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170714120753.GF28095@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170714110048.GC28095@redhat.com> <20170714115742.GG18687@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170714115742.GG18687@lemon>
Subject: Re: [Qemu-devel] qcow2 not cleaning up during image create failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Fri, Jul 14, 2017 at 07:57:43PM +0800, Fam Zheng wrote:
> On Fri, 07/14 12:00, Daniel P. Berrange wrote:
> > I've just been looking at the qcow2 image creation code, and found that
> > if any method in qcow2_create2() returns an error, then we'll report that,
> > but leave the newly created image file on disk in some partially initialized
> > state. A user may unwittingly use this file later with undefined behaviour.
> > This is particularly bad if we fail to setup encryption, because the user
> > is left with a file with no encryption enabled.
> > 
> > So I'm wondering how is the best way to clean up after failure ?
> > 
> > Naively I would like to just unlink(filename), but IIUC, filename is
> > not guaranteed to refer to a local file, and AFAIK, there is not
> > bdrv_delete() method todo this portably.
> > 
> > If we can't delete a file (because its a block device or network
> > volume), then we must at least blank out the just-written qcow2
> > header with zeros.
> > 
> > Ideas / suggestions.
> 
> Or just write the header as the last step?

qcow2 has a multi-step creation process - it writes a minimal header,
then opens the file and writes some more metadata.  So delaying write
of the header is impractical with that approach.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
