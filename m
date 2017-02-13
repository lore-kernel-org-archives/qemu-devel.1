Received: from eggs.gnu.org ([2001:4830:134:3::10]:56653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cdKFT-0005ih-GP
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cdKFS-0003wc-1M
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:17:11 -0500
Date: Mon, 13 Feb 2017 17:16:57 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170213171657.GI12387@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAJ1JNOd5cZ3RWUAkY=uo7+wwSwQrBWrN6GF_QZFjdVfx49VtGQ@mail.gmail.com>
	<c723ca77-2695-1915-fa9f-e1d868bed1db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c723ca77-2695-1915-fa9f-e1d868bed1db@redhat.com>
Subject: Re: [Qemu-devel] Estimation of qcow2 image size converted from raw
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Maor Lipchuk <mlipchuk@redhat.com>, qemu-devel@nongnu.org, qemu-discuss@nongnu.org, Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Allon Mureinik <amureini@redhat.com>, Qemu-block <qemu-block@nongnu.org>

On Mon, Feb 13, 2017 at 12:03:35PM -0500, John Snow wrote:
> Also keep in mind that changing the cluster size will give you different
> answers, too -- but that different cluster sizes will effect the runtime
> performance of the image as well.

This means that apps trying to figure out this future usage have to
understand fine internal impl details of qcow2 to correctly calculate
it.

> > We think that the best way to solve this issue is to return this info
> > from qemu-img, maybe as a flag to qemu-img convert that will
> > calculate the size of the converted image without doing any writes.
> > 
> 
> Might not be too hard to add, but it wouldn't necessarily be any more
> accurate than if you implemented the same logic, I think.
> 
> Still, it'd be up to us to keep it up to date, but I don't know what
> guarantees we could provide about the accuracy of the estimate or
> preventing it from bitrot if there are format changes..

As opposed to every application trying to implement the logic
themselves...it'll likely bitrot even worse in 3rd party apps
as their maintainers won't notice format changes until they
see a bug report.  Likewise, app developers aren't in a much
better position wrt to accracy - if anything they'll do a worse
job at calculating it since they might miss subtable nuances of
the qcow2 format that qemu developers would more likely get right.

This isn't just a problem wrt to the usage scenario mentioned in
this thread. For active VMs, consider you want to determine whether
you are at risk of overcommitting the filesystem or not. You cannot
simply sum up the image capacity - you need to know the largest
size that the qcow2 file is going to grow to in future[1] - this
again requires the app to calculate overhead of qcow2 metdata to
understand what they've committed to providing in terms of storage

Regards,
Daniel

[1] There is no upper limit if internal snapshots are usedm but if
    we assume use of external snapshots, we should be able to
    calculate the file size commitment.
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
