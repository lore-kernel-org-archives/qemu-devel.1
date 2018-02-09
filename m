Received: from eggs.gnu.org ([2001:4830:134:3::10]:38341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekAKn-0007VT-SP
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:11:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekAKj-0008TN-SN
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:11:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ekAKj-0008T3-LZ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:11:25 -0500
Date: Fri, 9 Feb 2018 16:11:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180209151107.GH3998@localhost.localdomain>
References: <1518096522-31141-1-git-send-email-sarna@skytechnology.pl>
	<20180209021950.GK24289@lemon.usersys.redhat.com>
	<2a381250-2cf9-c70c-4805-fc5f0ec4823c@skytechnology.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a381250-2cf9-c70c-4805-fc5f0ec4823c@skytechnology.pl>
Subject: Re: [Qemu-devel] [PATCH] block: unify blocksize types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Piotr Sarna <sarna@skytechnology.pl>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com

Am 09.02.2018 um 10:44 hat Piotr Sarna geschrieben:
> On 09.02.2018 03:19, Fam Zheng wrote:
> > On Thu, 02/08 14:28, Piotr Sarna wrote:
> > > BlockSizes structure used in block size probing has uint32_t types
> > > for logical and physical sizes. These fields are wrongfully assigned
> > > to uint16_t in BlockConf, which results, among other errors,
> > > in assigning 0 instead of 65536 (which will be the case in at least
> > > future LizardFS block device driver among other things).
> > > > This commit makes BlockConf's physical_block_size and logical_block_size > fields uint32_t to avoid inconsistencies.
> > > Signed-off-by: Piotr Sarna <sarna@skytechnology.pl>
> > > ---
> > >   include/hw/block/block.h     | 4 ++--
> > >   include/hw/qdev-properties.h | 2 +-
> > >   2 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> > > index 64b9298..c9e6e27 100644
> > > --- a/include/hw/block/block.h
> > > +++ b/include/hw/block/block.h
> > > @@ -17,8 +17,8 @@
> > >   typedef struct BlockConf {
> > >       BlockBackend *blk;
> > > -    uint16_t physical_block_size;
> > > -    uint16_t logical_block_size;
> > > +    uint32_t physical_block_size;
> > > +    uint32_t logical_block_size;
> > >       uint16_t min_io_size;
> > >       uint32_t opt_io_size;
> > >       int32_t bootindex;
> > > diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> > > index 1d61a35..c68d7bf 100644
> > > --- a/include/hw/qdev-properties.h
> > > +++ b/include/hw/qdev-properties.h
> > > @@ -210,7 +210,7 @@ extern const PropertyInfo qdev_prop_off_auto_pcibar;
> > >   #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
> > >       DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
> > >   #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
> > > -    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
> > > +    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
> > >   #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
> > >       DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
> > >   #define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
> > Do you need to update qdev_prop_blocksize and set_blocksize as well?
> > 
> >      const PropertyInfo qdev_prop_blocksize = {
> >          .name  = "uint16",
> >          .description = "A power of two between 512 and 32768",
> >          .get   = get_uint16,
> >          .set   = set_blocksize,
> >          .set_default_value = set_default_value_uint,
> >      };
> > 
> > Fam
> Yes, I do, thanks - I'll prepare patch v2 today. Also, I haven't found any
> hidden dependencies on blocksize being <= 32768, so I assume changing the
> new max value to 2^31 is safe. Could somebody more familiar with qemu code
> confirm(or invalidate) my assumption?

The IDE code has the following line in the emulation of the IDENTIFY
DEVICE command:

    put_le16(p + 106, 0x6000 | get_physical_block_exp(&dev->conf));

That is, the result of get_physical_block_exp() is just blindly ORed to
the word. The IDE spec says that bits 0-3 contain the exponent. Four
bits mean a maximum of 15 (and 2^15 = 32768). After that, we don't
actually expose a larger block size, but start modifying reserved bits.

I haven't checked other device models, but I wouldn't rule out that they
make similar assumptions.

Kevin
