Received: from eggs.gnu.org ([2001:4830:134:3::10]:36792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dIpel-0005HW-TF
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 01:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dIpeh-0007A8-52
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 01:06:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:44340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dIpeg-00079e-L5
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 01:06:47 -0400
Date: Thu, 8 Jun 2017 13:06:40 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170608050640.ov5wtygx737ory6z@hz-desktop>
References: <20170607080639.22120-1-haozhong.zhang@intel.com>
	<011f1bfe-f882-d940-52eb-7b5d511f9ffc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011f1bfe-f882-d940-52eb-7b5d511f9ffc@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] nvdimm acpi: fix region format interface
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>

On 06/08/17 11:07 +0800, Xiao Guangrong wrote:
> 
> 
> On 06/07/2017 04:06 PM, Haozhong Zhang wrote:
> > Per ACPI 6.2, section 5.2.25.6 and JEDEC Annex L Release 3, the
> > current region format interface code 0x201 indicates the block
> > addressed function interface 1, rather than a byte addressable
> > interface. Fix it by using 0x301 which indicates the byte addressable
> > no energy backed function interface 1.
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > ---
> >   hw/acpi/nvdimm.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> > index 8e7d6ec034..b5734f5897 100644
> > --- a/hw/acpi/nvdimm.c
> > +++ b/hw/acpi/nvdimm.c
> > @@ -338,9 +338,10 @@ static void nvdimm_build_structure_dcr(GArray *structures, DeviceState *dev)
> >       nfit_dcr->revision_id = cpu_to_le16(1 /* Current Revision supported
> >                                                in ACPI 6.0 is 1. */);
> >       nfit_dcr->serial_number = cpu_to_le32(sn);
> > -    nfit_dcr->fic = cpu_to_le16(0x201 /* Format Interface Code. See Chapter
> > -                                         2: NVDIMM Device Specific Method
> > -                                         (DSM) in DSM Spec Rev1.*/);
> > +    nfit_dcr->fic = cpu_to_le16(0x301 /* Format Interface Code:
> > +                                         Byte addressable, no energy backed.
> > +                                         See ACPI 6.2, sect 5.2.25.6 and
> > +                                         JEDEC Annex L Release 3. */);
> 
> Shouldn't the 'no energy backend' indicator be set only for !dax disk?

Above specs define RFIC for two classes of byte-addressable NVDIMM:
1. 0x10[0|1]: A function containing byte addressable persistent memory
              whose persistence is achieved through the use of DRAM,
              nonvolatile memory (e.g., Flash) and an energy source.
	      Only the DRAM portion is addressable by the system.
2. 0x30[0|1]: A function containing byte addressable persistent
              memory. All of the persistent memory is addressable by
              the system. No external energy source is required.
If the last bit is 0, then it's a proprietary interface.

The external backed energy is a mechanism that implements the
persistence for the first class, and it's not required for the
second class.

The key point in this patch is RFIC provided by QEMU should indicate a
*byte addressable* NVDIMM. Whether it's backed by the external energy
does not matter much here, so I think it's free to choose one of them.

Haozhong
