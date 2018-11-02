Received: from eggs.gnu.org ([2001:4830:134:3::10]:59090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1gIayC-0008Ls-89
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1gIayB-0006mo-BS
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:02:44 -0400
Date: Fri, 2 Nov 2018 09:00:04 -0600
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20181102150004.GD24372@localhost.localdomain>
References: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
	<20181102105421.GC7521@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102105421.GC7521@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: fix oob access issue(CVE-2018-16847)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, mreitz@redhat.com, pbonzini@redhat.com, ppandit@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Fri, Nov 02, 2018 at 11:54:21AM +0100, Kevin Wolf wrote:
> Am 02.11.2018 um 02:22 hat Li Qiang geschrieben:
> > Currently, the nvme_cmb_ops mr doesn't check the addr and size.
> > This can lead an oob access issue. This is triggerable in the guest.
> > Add check to avoid this issue.
> > 
> > Fixes CVE-2018-16847.
> > 
> > Reported-by: Li Qiang <liq3ea@gmail.com>
> > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  hw/block/nvme.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index fc7dacb..d097add 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -1175,6 +1175,10 @@ static void nvme_cmb_write(void *opaque, hwaddr addr, uint64_t data,
> >      unsigned size)
> >  {
> >      NvmeCtrl *n = (NvmeCtrl *)opaque;
> > +
> > +    if (addr + size > NVME_CMBSZ_GETSIZE(n->bar.cmbsz)) {
> 
> What prevents a guest from moving the device to the end of the address
> space and causing an integer overflow in addr + size?
> 
> If this happens, we still have .max_access_size = 8. The next question is
> then, is NVME_CMBSZ_GETSIZE guaranteed to be at least 8? I suppose yes,
> but do we want to rely on this for security?
> 
> Kevin

The nvme spec at least doesn't allow a way to express a CMB that isn't
at a minimum 4k aligned and sized, so 8 byte access should always be
within the boundary.
