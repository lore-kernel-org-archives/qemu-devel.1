Received: from eggs.gnu.org ([2001:4830:134:3::10]:47866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g0IBf-0000dm-Dc
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 23:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g0IBc-0001Pe-AG
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 23:20:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49972 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g0IBc-0001PK-4J
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 23:20:56 -0400
Date: Thu, 13 Sep 2018 11:20:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180913032047.GD10763@xz-x1>
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-5-git-send-email-brijesh.singh@amd.com>
	<20180912043539.GD3829@xz-x1>
	<4aae9c00-9db6-83a5-4f47-01141dc6d115@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4aae9c00-9db6-83a5-4f47-01141dc6d115@amd.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] i386: acpi: add IVHD device entry for
 IOAPIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Richard Henderson <rth@twiddle.net>

On Wed, Sep 12, 2018 at 02:11:10PM -0500, Brijesh Singh wrote:
> 
> 
> On 09/11/2018 11:35 PM, Peter Xu wrote:
> > On Tue, Sep 11, 2018 at 11:49:47AM -0500, Brijesh Singh wrote:
> > > When interrupt remapping is enabled, add a special IVHD device
> > > (type IOAPIC) -- which is typically PCI device 14:0.0. Linux IOMMU driver
> > > checks for this special device.
> > > 
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Richard Henderson <rth@twiddle.net>
> > > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> > > Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > > ---
> > >   hw/i386/acpi-build.c | 20 +++++++++++++++++++-
> > >   1 file changed, 19 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index e1ee8ae..5c2c638 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -2519,6 +2519,7 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
> > >   static void
> > >   build_amd_iommu(GArray *table_data, BIOSLinker *linker)
> > >   {
> > > +    int ivhd_table_len = 28;
> > >       int iommu_start = table_data->len;
> > >       AMDVIState *s = AMD_IOMMU_DEVICE(x86_iommu_get_default());
> > > @@ -2540,8 +2541,16 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
> > >                                (1UL << 6) | /* PrefSup      */
> > >                                (1UL << 7),  /* PPRSup       */
> > >                                1);
> > > +
> > > +    /*
> > > +     * When interrupt remapping is enabled, we add a special IVHD device
> > > +     * for type IO-APIC.
> > > +     */
> > > +    if (s->intr_enabled) {
> > > +        ivhd_table_len += 8;
> > > +    }
> > >       /* IVHD length */
> > > -    build_append_int_noprefix(table_data, 28, 2);
> > > +    build_append_int_noprefix(table_data, ivhd_table_len, 2);
> > >       /* DeviceID */
> > >       build_append_int_noprefix(table_data, s->devid, 2);
> > >       /* Capability offset */
> > > @@ -2565,6 +2574,15 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
> > >        */
> > >       build_append_int_noprefix(table_data, 0x0000001, 4);
> > > +    /*
> > > +     * When interrupt remapping is enabled, Linux IOMMU driver also checks
> > > +     * for special IVHD device (type IO-APIC), which is typically presented
> > > +     * as PCI device 14:00.0.
> > > +     */
> > > +    if (s->intr_enabled) {
> > > +        build_append_int_noprefix(table_data, 0x0100a00000000048, 8);
> > 
> > Some comments on the bit definition would be nicer, or "please refer
> > to Table 95 of AMD-Vi spec".
> > 
> > Could I ask how come the 14:00.0?  Is that in the spec somewhere?
> > 
> > And since you explicitly mentioned Linux, then... would it work for
> > Windows too?
> > 
> 
> The PCI 14:00.0 is SouthBridge IOAPIC device. On bare metal the timer
> subsystem is connected to the SB IOAPIC. The IVRS table must contains
> the entry of SB IOAPIC otherwise Linux will not enable the IR mapping
> while parsing the IVRS.
> 
> On bare meta system, IVRS will always have entry for SB IOAPIC. As per
> Windows is concerned, I am not sure if Windows support interrupt remap.
> If it does, adding the SB IOAPIC devid should not cause any problem
> to it because its always available on bare metal system.
> 
> Here is linux commit
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c2ff5cf5294bcbd7fa50f7d860e90a66db7e5059

Thanks for these information.  Please feel free to add some of the
information into the comment, that might explain itself better.  When
referring to commits, I would suggest just use "Please refer to Linux
commit xxx (xxx)" rather than the link though.

Regards,

-- 
Peter Xu
