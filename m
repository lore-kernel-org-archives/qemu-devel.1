Received: from eggs.gnu.org ([2001:4830:134:3::10]:37054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWRDx-0002NG-2k
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWRDw-0006OS-19
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:19:09 -0500
Date: Wed, 25 Jan 2017 17:18:53 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170125171853.GF29006@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170103182801.9638-1-berrange@redhat.com>
	<e10208d6-ade6-f31d-83b1-12a12cff6e7f@redhat.com>
	<20170125162932.GE29006@redhat.com>
	<d13ff880-3ce4-1b38-3c23-720768d79593@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d13ff880-3ce4-1b38-3c23-720768d79593@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 00/15] Convert QCow[2] to QCryptoBlock &
 add LUKS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Wed, Jan 25, 2017 at 05:41:59PM +0100, Max Reitz wrote:
> On 25.01.2017 17:29, Daniel P. Berrange wrote:
> > On Wed, Jan 25, 2017 at 04:58:32PM +0100, Max Reitz wrote:
> >> On 03.01.2017 19:27, Daniel P. Berrange wrote:
> >>> This series is a continuation of previous work to support LUKS in
> >>> QEMU. The existing merged code supports LUKS as a standalone
> >>> driver which can be layered over/under any other QEMU block device
> >>> driver. This works well when using LUKS over protocol drivers (file,
> >>> rbd, iscsi, etc, etc), but has some downsides when combined with
> >>> format drivers like qcow2.
> >>
> >> When trying out whether compressed images are actually encrypted (which
> >> they are not, as I wrote in my last reply to patch 12), I noticed that
> >> the user interface still has some flaws:
> > 
> > The original code explicitly forbids this combination
> > 
> >  "qemu-img: Compression and encryption not supported at the same time"
> > 
> > but I guess we lost the error check due to changing to use
> > encryption-format as the option name
> 
> Yes, not supporting it is completely fine, but qemu-img should refuse
> that combination then (or at least warn about it).

Yep, I'll make sure the existing error message covers this scenario.

> 
> >> One is that you actually can't convert to encrypted images any more, or
> >> if you can, it doesn't seem obvious to me:
> >>
> >> $ ./qemu-img convert -O qcow2 --object secret,id=sec0,data=12345 \
> >>     -o encryption-format=luks,luks-key-secret=sec0 \
> >>     foo.qcow2 bar.qcow2
> >> qemu-img: Could not open 'bar.qcow2': Parameter 'key-secret' is required
> >> for cipher
> >>
> >> The issue is that you have to specify the key secret as a runtime
> >> parameter in addition to the creation option. Not only is that a bit
> >> cumbersome, but it's also impossible because --image-opts doesn't work
> >> for the output image.
> > 
> > Yeah, this is a problem I've not figured out a solutiuon for yet - it
> > also affects the previously merged bare luks format code.
> > 
> > Somehow qemu-img needs to know which create options are also required
> > to be passed when opening the newly created image.
> > 
> > Perhaps the BlockDriver struct needs a new callback like
> > 
> >   bdrv_create_opts_to_runtime_opts(QemuOpts *copts, QemuOpts *ropts);
> 
> Yeah, it's tough. For the moment, I'd be fine with qemu-img convert
> working at all, though, even if that means having to specify the secret
> twice. But I don't know if fixing the --image-opts issue is any easier
> -- maybe we can allow image-opts syntax for the targets when -n is
> given? Then you'd have to call qemu-img create and qemu-img convert
> separately (or call qemu-img convert twice, once without -n (which
> successfully creates the image but then fails when trying to open it)
> and once without...), but at least there'd be a way to make it work.
> 
> I have to admit that I personally wouldn't mind a hack in qemu-img
> convert like "copy every option ending in 'key-secret' to the runtime
> opts" too much. But I don't know how much that might infuriate some
> other people.
> 
> It's ugly, yes, but it would work perfectly well for now. I don't think
> it would hurt us in the future. If other parameters appear that we have
> to copy over, we can still implement the well-engineered solution.

This turns out to be pretty trivial to implement. So although it is
a bit ugly, it feels like reasonable approach to take in the short
term.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
