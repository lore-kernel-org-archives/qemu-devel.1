Received: from eggs.gnu.org ([2001:4830:134:3::10]:54910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=44597b5a6=ross.lagerwall@citrix.com>)
	id 1e0SEH-0002r3-Gz
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=44597b5a6=ross.lagerwall@citrix.com>)
	id 1e0SEE-0001VI-E0
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:59:49 -0400
Received: from smtp.citrix.com ([66.165.176.89]:28312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=44597b5a6=ross.lagerwall@citrix.com>)
	id 1e0SEE-0001Uv-5J
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:59:46 -0400
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <892cb484-361b-f1c1-c294-6b5d7b5e92fb@citrix.com>
Date: Fri, 6 Oct 2017 13:58:18 +0100
MIME-Version: 1.0
In-Reply-To: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/*] xen: xen-domid-restrict improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>

On 10/04/2017 05:18 PM, Ian Jackson wrote:
> (Resending this because 1. I got the CC for xen-devel wrong; 2. I got
> the subject wrong: there are actually 8 patches; 3. I mangled
> Anthony's name in theheaders.  Sorry for the noise.)
> 
> I have been working on trying to get qemu, when running as a Xen
> device model, to _actually_ not have power equivalent to root.
> 
> I think I have achieved this, with some limitations (which will be
> discussed in my series against xen.git.
> 
> However, there are changes to qemu needed.  In particular
> 
>   * The -xen-domid-restrict option does not work properly right now.
>     It only restricts a small subset of the descriptors qemu has open.
>     I am introducing a new library call in the Xen libraries for this,
>     xentoolcore_restrict_all.
> 

Hi Ian,

I'm testing your QEMU and Xen patch series and found that after being 
restricted, QEMU fails to setup up the VGA memory properly which causes 
a complete stall with stdvga. With cirrus it mostly works although it 
seems to have reduced performance.

I think it happens when the VM sets up the BAR some time after 
xen_restrict() has been called. The failure comes from QEMU calling 
xc_domain_add_to_physmap() which calls do_memory_op() and finally 
xencall2(). But the underlying xencall fd has been replaced with /dev/null.

Here is some debug output, all of which occurs after the call to
xentoolcore_restrict_all() has completed. 00:02.0 is the VGA device.

pci_update_mappings_add d=0x7fee0b154000 00:03.0 1,0xf0000000+0x1000000
pci_update_mappings_add d=0x7fee0b1de000 00:02.0 0,0xf1000000+0x800000
xen_client_set_memory 0xf1000000 size 0x800000, log_dirty 1
xen: mapping vram to f1000000 - f1800000
xen: add_to_physmap MFN 80000 to PFN f1000 failed: 25 (errno: 25)
pci_update_mappings_add d=0x7fee0b154000 00:03.0 0,0xc000+0x100
pci_update_mappings_add d=0x7fee0b1a4000 00:04.0 0,0xc100+0x100
pci_update_mappings_add d=0x7fee0b1a4000 00:04.0 1,0xf1800000+0x100
pci_update_mappings_add d=0x7fee0b006e00 00:01.2 4,0xc200+0x20
pci_update_mappings_add d=0x7fee0b65c000 00:01.1 4,0xc220+0x10
pci_update_mappings_add d=0x7fee0b65c000 00:01.1 4,0xc220+0x10
pci_update_mappings_add d=0x7fee0b65c000 00:01.1 4,0xc220+0x10
pci_update_mappings_add d=0x7fee0b65c000 00:01.1 4,0xc220+0x10
pci_update_mappings_add d=0x7fee0b65c000 00:01.1 4,0xc220+0x10
pci_update_mappings_add d=0x7fee0b65c000 00:01.1 4,0xc220+0x10
pci_update_mappings_add d=0x7fee0b65c000 00:01.1 4,0xc220+0x10
pci_update_mappings_add d=0x7fee0b65c000 00:01.1 4,0xc220+0x10
pci_update_mappings_add d=0x7fee0b006e00 00:01.2 4,0xc200+0x20
pci_update_mappings_add d=0x7fee0b006e00 00:01.2 4,0xc200+0x20
pci_update_mappings_add d=0x7fee0b006e00 00:01.2 4,0xc200+0x20
pci_update_mappings_add d=0x7fee0b006e00 00:01.2 4,0xc200+0x20
pci_update_mappings_add d=0x7fee0b006e00 00:01.2 4,0xc200+0x20
pci_update_mappings_add d=0x7fee0b006e00 00:01.2 4,0xc200+0x20
pci_update_mappings_add d=0x7fee0b006e00 00:01.2 4,0xc200+0x20
pci_update_mappings_add d=0x7fee0b1de000 00:02.0 0,0xf1000000+0x800000
xen_client_set_memory 0xf1000000 size 0x800000, log_dirty 1
pci_update_mappings_add d=0x7fee0b1de000 00:02.0 0,0xf1000000+0x800000
xen_client_set_memory 0xf1000000 size 0x800000, log_dirty 1
pci_update_mappings_add d=0x7fee0b1de000 00:02.0 0,0xf1000000+0x800000
xen_client_set_memory 0xf1000000 size 0x800000, log_dirty 1
pci_update_mappings_add d=0x7fee0b1de000 00:02.0 0,0xf1000000+0x800000
xen_client_set_memory 0xf1000000 size 0x800000, log_dirty 1
pci_update_mappings_add d=0x7fee0b1de000 00:02.0 0,0xf1000000+0x800000
xen_client_set_memory 0xf1000000 size 0x800000, log_dirty 1
pci_update_mappings_add d=0x7fee0b1de000 00:02.0 0,0xf1000000+0x800000
xen_client_set_memory 0xf1000000 size 0x800000, log_dirty 1
pci_update_mappings_add d=0x7fee0b1de000 00:02.0 0,0xf1000000+0x800000
xen_client_set_memory 0xf1000000 size 0x800000, log_dirty 1
pci_update_mappings_add d=0x7fee0b154000 00:03.0 0,0xc000+0x100
pci_update_mappings_add d=0x7fee0b154000 00:03.0 1,0xf0000000+0x1000000
pci_update_mappings_add d=0x7fee0b154000 00:03.0 0,0xc000+0x100
pci_update_mappings_add d=0x7fee0b154000 00:03.0 1,0xf0000000+0x1000000
pci_update_mappings_add d=0x7fee0b154000 00:03.0 0,0xc000+0x100
pci_update_mappings_add d=0x7fee0b154000 00:03.0 1,0xf0000000+0x1000000
pci_update_mappings_add d=0x7fee0b154000 00:03.0 0,0xc000+0x100
pci_update_mappings_add d=0x7fee0b154000 00:03.0 1,0xf0000000+0x1000000
pci_update_mappings_add d=0x7fee0b154000 00:03.0 0,0xc000+0x100
pci_update_mappings_add d=0x7fee0b154000 00:03.0 1,0xf0000000+0x1000000
pci_update_mappings_add d=0x7fee0b154000 00:03.0 0,0xc000+0x100
pci_update_mappings_add d=0x7fee0b154000 00:03.0 1,0xf0000000+0x1000000
pci_update_mappings_add d=0x7fee0b154000 00:03.0 0,0xc000+0x100
pci_update_mappings_add d=0x7fee0b154000 00:03.0 1,0xf0000000+0x1000000

Apart from this issue, I was able to boot up and shut down a VM, using 
-xen-domid-restrict, -chroot, and -runasid.

There is a caveat when using -xen-domid-restrict and -chroot at the same 
time. The restriction happens after chrooting, so the chroot directory 
has to contain a valid /dev/null. This is a bit annoying and prevents 
the chroot being on a "nodev" mount.

Regards,
-- 
Ross Lagerwall
