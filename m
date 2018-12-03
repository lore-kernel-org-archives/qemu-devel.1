Received: from eggs.gnu.org ([2001:4830:134:3::10]:38263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gTolr-0003eb-3h
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:00:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gTolm-0005nH-TM
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:00:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gTolm-0005mJ-M9
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:00:18 -0500
Date: Mon, 3 Dec 2018 07:00:15 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181203070015.03244928@x1.home>
In-Reply-To: <5C052A3D.01FFE0.13753@m12-18.163.com>
References: <5C052A3D.01FFE0.13753@m12-18.163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Questions about the VFIO device BAR emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: Alex Williamson <alex.l.williamson@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On Mon, 3 Dec 2018 21:06:00 +0800
Li Qiang <liq3ea@163.com> wrote:

> Hello Alex, Paolo and all
>=20
> I have a question about VFIO about the BAR.
>=20
> Why we have two MemoryRegion for every device=E2=80=99s BAR.
> I mean in VFIOBAR we have a field =E2=80=98mr=E2=80=99.
> typedef struct VFIOBAR {
>     VFIORegion region;
>     MemoryRegion *mr;
>     size_t size;
>     uint8_t type;
>     bool ioport;
>     bool mem64;
>     QLIST_HEAD(, VFIOQuirk) quirks;
> } VFIOBAR;
>=20
> And in the field =E2=80=98region=E2=80=99 field of VFIOBAR,
> We also have a MemoryReion named =E2=80=98mem=E2=80=99.
> And the =E2=80=98VFIOBAR=E2=80=99s mr is just the subregion of =E2=80=98V=
FIOREGION=E2=80=99.
>=20
> Why here we can=E2=80=99t use just one MR link VFIOREGION=E2=80=99s =E2=
=80=98mem=E2=80=99field to represent the device=E2=80=99s BAR?

The answer lives in git history:

commit 3a286732d1563bdb440718d4e68137e06af785dd
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Tue Feb 6 11:08:25 2018 -0700

    vfio/pci: Add base BAR MemoryRegion
   =20
    Add one more layer to our stack of MemoryRegions, this base region
    allows us to register BARs independently of the vfio region or to
    extend the size of BARs which do map to a region.  This will be
    useful when we want hypervisor defined BARs or sections of BARs,
    for purposes such as relocating MSI-X emulation.  We therefore call
    msix_init() based on this new base MemoryRegion, while the quirks,
    which only modify regions still operate on those sub-MemoryRegions.
   =20
    Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
