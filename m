Received: from eggs.gnu.org ([2001:4830:134:3::10]:48706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWQS8-0008Rp-VY
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWQS7-0007Tf-Sk
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:29:45 -0500
Date: Wed, 25 Jan 2017 16:29:32 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170125162932.GE29006@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170103182801.9638-1-berrange@redhat.com>
	<e10208d6-ade6-f31d-83b1-12a12cff6e7f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e10208d6-ade6-f31d-83b1-12a12cff6e7f@redhat.com>
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

On Wed, Jan 25, 2017 at 04:58:32PM +0100, Max Reitz wrote:
> On 03.01.2017 19:27, Daniel P. Berrange wrote:
> > This series is a continuation of previous work to support LUKS in
> > QEMU. The existing merged code supports LUKS as a standalone
> > driver which can be layered over/under any other QEMU block device
> > driver. This works well when using LUKS over protocol drivers (file,
> > rbd, iscsi, etc, etc), but has some downsides when combined with
> > format drivers like qcow2.
> 
> When trying out whether compressed images are actually encrypted (which
> they are not, as I wrote in my last reply to patch 12), I noticed that
> the user interface still has some flaws:

The original code explicitly forbids this combination

 "qemu-img: Compression and encryption not supported at the same time"

but I guess we lost the error check due to changing to use
encryption-format as the option name

> One is that you actually can't convert to encrypted images any more, or
> if you can, it doesn't seem obvious to me:
> 
> $ ./qemu-img convert -O qcow2 --object secret,id=sec0,data=12345 \
>     -o encryption-format=luks,luks-key-secret=sec0 \
>     foo.qcow2 bar.qcow2
> qemu-img: Could not open 'bar.qcow2': Parameter 'key-secret' is required
> for cipher
> 
> The issue is that you have to specify the key secret as a runtime
> parameter in addition to the creation option. Not only is that a bit
> cumbersome, but it's also impossible because --image-opts doesn't work
> for the output image.

Yeah, this is a problem I've not figured out a solutiuon for yet - it
also affects the previously merged bare luks format code.

Somehow qemu-img needs to know which create options are also required
to be passed when opening the newly created image.

Perhaps the BlockDriver struct needs a new callback like

  bdrv_create_opts_to_runtime_opts(QemuOpts *copts, QemuOpts *ropts);

> The second flaw is also visible above: The parameter is called
> "luks-key-secret" here, not just "key-secret". The error message should
> reflect that.

This is hard to fix. The "luks-key-secret" parameter refers to the parameter
at the block driver level. The error message though is coming from the crypto
layer whose parameter genuinely is called "key-secret". Fixing it would
require the block layer to pre-emptively check parmaeters, duplicating what
the crypto layer does later, which I didn't really like the idea of.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
