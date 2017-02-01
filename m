Received: from eggs.gnu.org ([2001:4830:134:3::10]:57416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cYuD4-0001dt-To
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cYuD3-0003TX-MC
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:40:26 -0500
Date: Wed, 1 Feb 2017 12:40:14 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170201124014.GH3232@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170126110435.2777-1-berrange@redhat.com>
	<20170126110435.2777-4-berrange@redhat.com>
	<20170126123530.GB23095@lemon.Home>
	<20170126132708.GB29127@redhat.com>
	<6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
	<8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
	<20170201121658.GF3232@redhat.com>
	<c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
	<20170201122854.GG3232@redhat.com>
	<37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Wed, Feb 01, 2017 at 01:31:01PM +0100, Max Reitz wrote:
> On 01.02.2017 13:28, Daniel P. Berrange wrote:
> > On Wed, Feb 01, 2017 at 01:23:54PM +0100, Max Reitz wrote:
> >> On 01.02.2017 13:16, Daniel P. Berrange wrote:
> >>> On Wed, Feb 01, 2017 at 01:13:39PM +0100, Max Reitz wrote:
> >>>> On 30.01.2017 19:37, Eric Blake wrote:
> >>>>> On 01/26/2017 07:27 AM, Daniel P. Berrange wrote:
> >>>>>> On Thu, Jan 26, 2017 at 08:35:30PM +0800, Fam Zheng wrote:
> >>>>>>> On Thu, 01/26 11:04, Daniel P. Berrange wrote:
> >>>>>>>> The -n arg to the convert command allows use of a pre-existing image,
> >>>>>>>> rather than creating a new image. This adds a -n arg to the dd command
> >>>>>>>> to get feature parity.
> >>>>>>>
> >>>>>>> I remember there was a discussion about changing qemu-img dd's default to a
> >>>>>>> "conv=nocreat" semantic, if so, "-n" might not be that useful. But that part
> >>>>>>> hasn't made it into the tree, and I'm not sure which direction we should take.
> >>>>>>> (Personally I think default to nocreat is a good idea).
> >>>>>>
> >>>>>> Use nocreat by default would be semantically different from real "dd"
> >>>>>> binary which feels undesirable if the goal is to make "qemu-img dd"
> >>>>>> be as consistent with "dd" as possible.
> >>>>>>
> >>>>>> It would be trivial to rewrite this patch to add support for the "conv"
> >>>>>> option, allowing the user to explicitly give 'qemu-img dd conv=nocreat'
> >>>>>> instead of my 'qemu-img dd -n' syntax, without changing default semantics.
> >>>>>
> >>>>> Adding 'conv=nocreat' (and not '-n') feels like the right way to me.
> >>>>
> >>>> The original idea was to make conv=nocreat a mandatory option, I think.
> >>>> qemu-img was supposed error out if the user did not specify it.
> >>>
> >>> I'm not really seeing a benefit in doing that - it would just break
> >>> existing usage of qemu-img dd for no obvious benefit.
> >>
> >> Well... Is there existing usage?
> > 
> > It shipped in 2.8.0 though, so imho that means we have to assume there
> > are users, and thus additions must to be backwards compatible from now
> > on.
> 
> Depends. I don't think there are too many users, so we could still
> justify a change if there's a very good reason for it.
> 
> I do agree that it's probably not a very good reason, though.
> 
> >> The benefit would be that one could (should?) expect qemu-img dd to
> >> behave on disk images as if they were block devices; and dd to a block
> >> device will not truncate or "recreate" it.
> >>
> >> If you don't give nocreat, it's thus a bit unclear whether you want to
> >> delete and recreate the target or whether you want to write into it.
> >> Some may expect qemu-img dd to behave as if the target is a normal file
> >> (delete and recreate it), others may expect it's treated like a block
> >> device (just write into it). If you force the user to specify nocreat,
> >> it would make the behavior clear.
> >>
> >> (And you can always delete+recreate the target with qemu-img create.)
> >>
> >> It's all a bit complicated. :-/
> > 
> > If the goal is to be compatible with /usr/bin/dd then IIUC, the behaviour
> > needs to be
> > 
> >  - If target is a block device, then silently assume nocreat|notrunc
> >    is set, even if not specified by user
> > 
> >  - If target is a file, then silently create & truncate the file
> >    unless nocreat or notrunc are set
> 
> Yes. But you could easily argue that every image file is a "block device".

IMHO that would be a bad idea as it would mean different behaviour
from dd vs qemu-img dd, when run on raw files.

If we assume nocreat|notrunc behaviour by default, then we would  likely
need to invent new "creat|trunc" flags to let people turn the previous
behaviour back on, which would diverge from 'dd' command.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
