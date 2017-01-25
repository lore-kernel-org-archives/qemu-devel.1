Received: from eggs.gnu.org ([2001:4830:134:3::10]:33271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cWVZ6-00071D-5Z
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cWVZ1-0003jo-Lm
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:57:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cWVZ1-0003jJ-Fg
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:57:11 -0500
Date: Wed, 25 Jan 2017 23:57:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170125213417-mutt-send-email-mst@kernel.org>
References: <1485297322-10595-1-git-send-email-mst@redhat.com>
	<CAFEAcA_TW1JK8DOHt-=kisvemGXjtuadJ+eH7L8NJwsQcQz8sw@mail.gmail.com>
	<3958a41a-9b0e-4616-19dc-173824a87b31@gmail.com>
	<CAFEAcA_T-bkoHCVS0ZkaReC8HE66R3XQg6ZOMPks=8mWYSx_cQ@mail.gmail.com>
	<CAFEAcA_ypHAVRUpMviwj6-hDsM_MPDNQUf0eBN0ooTG2YwCrnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_ypHAVRUpMviwj6-hDsM_MPDNQUf0eBN0ooTG2YwCrnw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/16] virtio, vhost, pci: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Jan 25, 2017 at 07:24:03PM +0000, Peter Maydell wrote:
> On 25 January 2017 at 18:08, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> > On 25 January 2017 at 18:02, Marcel Apfelbaum
> > <marcel.apfelbaum@gmail.com> wrote:
> >> Strange, I re-based in the same day I posted and compiled just fine.=
..
> >> However, I get the same error using today's master.
> >>
> >> I'll fix and re-post the series.
> >
> > mst has done a rebase of the pull request which I'll retry later.
>=20
> Results:
> /home/petmay01/linaro/qemu-for-merges/hw/display/qxl.c: In function
> =E2=80=98qxl_rom_size=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/hw/display/qxl.c:313:20: error:
> bit-field =E2=80=98<anonymous>=E2=80=99 width not an integer constant
>      QEMU_BUILD_BUG_ON(required_rom_size > rom_size);
>                     ^
>=20
> x86-64 linux host; I guess the usage in this file conflicts
> with your series' rephrasing of the macro for some versions
> of gcc. This is gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609

I guess what happened previously is that gcc did not actually
check this size at all. I posted a patch to rewrite using macros.
Trivial but I still will give maintainer a bit of time to take a look.


> If I rewrite the build-assert in qxl.c as
>     QEMU_BUILD_BUG_ON(sizeof(QXLRom) + sizeof(QXLModes) +
> sizeof(qxl_modes) > 8192);
> it compiles OK (and the build then runs into the error below).
>=20
>=20
> All the other build hosts fell over like this:
>=20
> /home/pm215/qemu/hw/pci-bridge/gen_pcie_root_port.c:54:9: error:
> implicit declaration of function =E2=80=98VMSTATE_PCIE_DEVICE=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>          VMSTATE_PCIE_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot=
),
>          ^
> /home/pm215/qemu/hw/pci-bridge/gen_pcie_root_port.c:54:29: error:
> =E2=80=98parent_obj=E2=80=99 undeclared here (not in a function)
>          VMSTATE_PCIE_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot=
),
>                              ^
> /home/pm215/qemu/hw/pci-bridge/gen_pcie_root_port.c:54:63: error:
> expected expression before =E2=80=98PCIESlot=E2=80=99
>          VMSTATE_PCIE_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot=
),
>=20
> thanks
> -- PMM
