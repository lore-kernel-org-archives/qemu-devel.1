Received: from eggs.gnu.org ([2001:4830:134:3::10]:55006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW0IF-0001eC-CO
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:33:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW0IB-0001Mk-AK
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:33:47 -0500
Date: Tue, 24 Jan 2017 12:33:34 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124123334.GL14563@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-12-berrange@redhat.com>
	<318a09df-58a2-4eb0-46ea-65d93be9ab4a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <318a09df-58a2-4eb0-46ea-65d93be9ab4a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 11/15] qcow2: convert QCow2 to use
 QCryptoBlock for encryption
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

On Sat, Jan 21, 2017 at 08:07:57PM +0100, Max Reitz wrote:
> On 03.01.2017 19:27, Daniel P. Berrange wrote:
> > This converts the qcow2 driver to make use of the QCryptoBlock
> > APIs for encrypting image content, using the legacyy QCow2 AES
> > scheme.
> > 
> > With this change it is now required to use the QCryptoSecret
> > object for providing passwords, instead of the current block
> > password APIs / interactive prompting.
> > 
> >   $QEMU \
> >     -object secret,id=sec0,filename=/home/berrange/encrypted.pw \
> >     -drive file=/home/berrange/encrypted.qcow2,aes-key-secret=sec0
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block/qcow2-cluster.c      |  47 +----------
> >  block/qcow2.c              | 190 +++++++++++++++++++++++++++++----------------
> >  block/qcow2.h              |   5 +-
> >  qapi/block-core.json       |   7 +-
> >  tests/qemu-iotests/049     |   2 +-
> >  tests/qemu-iotests/049.out |   4 +-
> >  tests/qemu-iotests/082.out |  27 +++++++
> >  tests/qemu-iotests/087     |  28 ++++++-
> >  tests/qemu-iotests/087.out |   6 +-
> >  tests/qemu-iotests/134     |  18 +++--
> >  tests/qemu-iotests/134.out |  10 +--
> >  tests/qemu-iotests/158     |  19 +++--
> >  tests/qemu-iotests/158.out |  14 +---
> >  13 files changed, 219 insertions(+), 158 deletions(-)
> 
> [...]
> 
> > diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
> > index af618b8..c2458d8 100755
> > --- a/tests/qemu-iotests/134
> > +++ b/tests/qemu-iotests/134
> > @@ -43,23 +43,31 @@ _supported_os Linux
> >  
> >  
> >  size=128M
> > -IMGOPTS="encryption=on" _make_test_img $size
> > +
> > +SECRET="secret,id=sec0,data=astrochicken"
> > +SECRETALT="secret,id=sec0,data=platypus"
> > +
> > +_make_test_img --object $SECRET -o "encryption=on,qcow-key-secret=sec0" $size
> > +
> > +IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,qcow-key-secret=sec0"
> > +
> > +QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
> 
> While I agree that it makes sense to have this variable, we
> unfortunately do not have it. Yet. ;-)
> 
> It should be defined somewhere and it should probably actually contain
> all non-format options (such as the cache mode).

Yes, that was what I had originally, but somehow I lost it during a
rebase somewhere...


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
