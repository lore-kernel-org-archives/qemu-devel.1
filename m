Received: from eggs.gnu.org ([2001:4830:134:3::10]:48401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1erRJc-0004ep-EO
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1erRJb-0007U2-Ed
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:44:20 -0500
Date: Thu, 1 Mar 2018 17:43:55 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180301174355.2d0ef5ae@redhat.com>
In-Reply-To: <ad05c82f-eb31-694d-4688-ae250287cfd6@redhat.com>
References: <1519827835-239519-1-git-send-email-imammedo@redhat.com>
	<1519827835-239519-10-git-send-email-imammedo@redhat.com>
	<986e15d2-47cd-be73-da0f-39874b38a325@redhat.com>
	<20180301102153.0a07f96c@redhat.com>
	<ad05c82f-eb31-694d-4688-ae250287cfd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/10] virt_arm: acpi: reuse common
 build_fadt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org

On Thu, 1 Mar 2018 10:38:52 +0100
Auger Eric <eric.auger@redhat.com> wrote:

[...]
> >>>  {
> >>> @@ -1755,7 +1755,14 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
> >>>  
> >>>      build_append_gas_from_struct(tbl, &f->reset_reg); /* RESET_REG */
> >>>      build_append_int_noprefix(tbl, f->reset_val, 1); /* RESET_VALUE */
> >>> -    build_append_int_noprefix(tbl, 0, 3); /* Reserved, ACPI 3.0 */  
> I meant we could have assert(f->rev < 6) here
> >>> +    /* Since ACPI 5.1 */
> >>> +    if ((f->rev >= 6) || ((f->rev == 5) && f->minor_ver > 0)) {  
> and remove (f->rev >= 6) as in any case rev6 is not supported
> (Hypervisor Vendor Identity field (8 byte) not duly added).
> 
> Or do I miss something?
Nope, you are right.
I've missed 'code above' part and didn't get suggestion the first time.

The reason why I didn't assert here is to keep this part
(in the middle of table) working correctly without need
to touch it when later revisions will add new fields at
the end of table. So all we would have to do is to add
new code at the end and update assert that sets revision limit.

condition here essentially implements specs, i.e. 
from 5.1 onward reserved space should be used for now defined fields.

We might add similar conditions, for other 'Reserved' fields,
in the future if new revisions start to use them.

> Thanks
> 
> Eric
> >>> +        build_append_int_noprefix(tbl, f->arm_boot_arch, 2); /* ARM_BOOT_ARCH */
> >>> +        /* FADT Minor Version */
> >>> +        build_append_int_noprefix(tbl, f->minor_ver, 1);
> >>> +    } else {
> >>> +        build_append_int_noprefix(tbl, 0, 3); /* Reserved upto ACPI 5.0 */
> >>> +    }
> >>>      build_append_int_noprefix(tbl, 0, 8); /* X_FIRMWARE_CTRL */
> >>>  
> >>>      /* XDSDT address to be filled by Guest linker at runtime */
> >>> @@ -1779,6 +1786,18 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
> >>>      build_append_gas_from_struct(tbl, &f->gpe0_blk); /* X_GPE0_BLK */
> >>>      build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0); /* X_GPE1_BLK */
> >>>  
> >>> +    if (f->rev <= 4) {
> >>> +        goto build_hdr;
> >>> +    }
> >>> +
> >>> +    /* SLEEP_CONTROL_REG */
> >>> +    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
> >>> +    /* SLEEP_STATUS_REG */
> >>> +    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
> >>> +
> >>> +    /* TODO: extra fields need to be added to support revisions above rev5 */
> >>> +    assert(f->rev == 5);    
> >> My previous comment about asserting here if f->rev != 5 and previous
> >> (f->rev >= 6) check was skipped but that's not a big deal.  
> > I've thought that I've replied to comment,
> > maybe I just didn't get meaning behind question?
> > So I'll try to explain again.
> > 
> > If we reach this point rev must be 5, so f->rev >= 6 would be confusing
> > at this point. When v6 support is added this assert should be moved after
> > v6 stuff and condition is amended to f->rev == 6.
> > 
> >    
> >> Reviewed-by: Eric Auger <eric.auger@redhat.com>  
> > Thanks!
> >   
> >>
> >> Thanks
> >>
> >> Eric  
[...]
