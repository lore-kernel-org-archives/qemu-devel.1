Received: from eggs.gnu.org ([2001:4830:134:3::10]:44508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYVkH-0003AM-QH
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 07:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYVif-0008IZ-Qm
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 07:40:31 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gYVid-0008DP-B4
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 07:40:28 -0500
Received: by mail-oi1-x244.google.com with SMTP id u18so8076450oie.10
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 04:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
	<20181112214224.31560-6-contrib@steffen-goertz.de>
	<CAFEAcA_oxGQY6K4wQ3TTz1moa8rrXd=Hd3bcjE5NM2d=omn0YQ@mail.gmail.com>
	<e1e4c8d7-cb81-7f1d-ae38-a4cac5c85a48@steffen-goertz.de>
	<CAFEAcA_Du4OTLqfNECY=BTvW089RTNu3qpxm2yv=iLL9g-m5qQ@mail.gmail.com>
	<20181216062024.GA6123@stefanha-x1.localdomain>
In-Reply-To: <20181216062024.GA6123@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 16 Dec 2018 12:40:11 +0000
Message-ID: <CAFEAcA-jpTXrrn1XWCPwa64XZrK88OQR6pr70Pw7J7URW-B0uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 05/14] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>

On Sun, 16 Dec 2018 at 06:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Mon, Nov 26, 2018 at 05:43:59PM +0000, Peter Maydell wrote:
> > On Mon, 26 Nov 2018 at 00:24, Steffen G=C3=B6rtz <mail@steffen-goertz.d=
e> wrote:
> > > What else is necessary to invalidate stale blocks?
> >
> > You need an AddressSpace that points to the MemoryRegion(s)
> > you're altering, and you need to use the operations on
> > the AddressSpace like address_space_write(). These will
> > under the hood do the right thing with TB invalidation.
>
> I'm not sure about this.

> I see nothing that invalidates TBs in the address_space_write() code for
> MMIO memory regions (not RAM).  Only the RAM case calls
> invalidate_and_set_dirty().

Hmm, I think I see what you mean -- the problem
is because your ram backed region is created with
memory_region_init_rom_device(), which means that
if you try to write to the MR via address_space_write()
you get the guest access path which ends up in the
MemoryRegionOps write function, whereas what we wanted
was to access the MR via the write-host-RAM code path
which updates the dirty state.

> There are a few complications with this device:
>
> 1. Stores from the CPU are only honored when the NRF51_NVMC_CONFIG_WEN
>    write enable bit is set.  NRF51_NVMC_ERASEPCRx and
>    NRF51_NVMC_ERASEALL commands use a separate erase enable bit
>    (NRF51_NVMC_CONFIG_EEN) and are therefore different from normal
>    writes.

i.e. we want guest writes to the region to go
via a write function so we can impose the right semantics.

> 2. Stores from the CPU can only flip 1s to 0s (this is NOR flash).  When
>    we erase a page of flash memory it must be set to 0xff (i.e. flip
>    0s to 1s).

i.e. we have some other operations which need to perform
writes directly on the underlying storage.

> 3. nrf51_nvm.c:flash_write() does not mark the page dirty for live
>    migration.

...and this is the bug we need to avoid: any write to the
underlying storage must update dirty status, both for
migration and for TCG cached code invalidation.

> My questions:
>
> 1. Is the current rom+mmio device approach okay or should it be modelled
>    differently?
>
> 2. Erase operations cannot use ordinary address_space_write() for the
>    reasons mentioned above.  Should this device directly call
>    cpu_physical_memory_set_dirty_range() and tb_invalidate_phys_range()?

I think that these functions are too low level for devices to be
calling directly, and we should have something at the MemoryRegion or
AddressSpace level to do what we need. Perhaps some API for
"this is a rom_device MemoryRegion, create me a new MemoryRegion
which is a pure RAM MemoryRegion view of the underlying storage".
(The device could then put that into a private AddressSpace and
use that for when it wants to do updates directly to storage.)
Or perhaps we could just say "practically all uses of rom_device
MemoryRegions will want to be able to write to the underlying
storage, we should provide an API that handles flushing for them".

Paolo, do you have a view?

(Our only other users of rom_device are hw/block/pflash_cfi0[12].c;
I think they get away with this because they mostly flip the device
out of romd mode before updating the backing storage. That works
but is very heavyweight, and is almost working by accident rather
than design.)

thanks
-- PMM
