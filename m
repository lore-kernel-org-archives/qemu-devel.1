Received: from eggs.gnu.org ([2001:4830:134:3::10]:37852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPzG-0005rv-4y
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPzF-0004aO-AP
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:55:38 -0500
Date: Fri, 9 Mar 2018 22:55:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180309215512.GA8198@localhost.localdomain>
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-5-kwolf@redhat.com>
	<07d06226-dd95-268f-fcba-f7245ee68683@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d06226-dd95-268f-fcba-f7245ee68683@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] luks: Turn invalid assertion into check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

Am 09.03.2018 um 21:19 hat Eric Blake geschrieben:
> On 03/09/2018 11:27 AM, Kevin Wolf wrote:
> > The .bdrv_getlength implementation of the crypto block driver asserted
> > that the payload offset isn't after EOF. This is an invalid assertion to
> > make as the image file could be corrupted. Instead, check it and return
> > -EIO if the file is too small for the payload offset.
> 
> Good catch.  Probably not a CVE (unless someone can argue some way that
> causing a crash on an attempt to load a maliciously corrupted file can be
> used as a denial of service across a privilege boundary), but definitely
> needs fixing.
> 
> > 
> > Zero length images are fine, so trigger -EIO only on offset > len, not
> > on offset >= len as the assertion did before.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/crypto.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 2035f9ab13..4908d8627f 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -518,7 +518,10 @@ static int64_t block_crypto_getlength(BlockDriverState *bs)
> >       uint64_t offset = qcrypto_block_get_payload_offset(crypto->block);
> >       assert(offset < INT64_MAX);
> 
> Umm, if the file can be corrupted, what's to prevent someone from sticking
> in a negative size that fails this assertion?

In qcrypto_block_luks_open():

    block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
    block->payload_offset = luks->header.payload_offset *
            block->sector_size

The sector size is 512LL, and luks->header.payload_offset is 32 bit.

But I just saw that block_crypto_truncate() has another wrong assertion.
Maybe I should fix that and write a test case for it. Not sure if I'll
add it to this series or as a follow-up during the freeze.

Kevin
