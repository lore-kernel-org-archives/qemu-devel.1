Received: from eggs.gnu.org ([2001:4830:134:3::10]:50459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpAHX-00050Q-OQ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpAHT-0004Qu-17
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:36:31 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-13-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <28a1f49b-ed07-8c46-eb0c-be9b92d106fe@redhat.com>
Date: Tue, 5 Sep 2017 11:36:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-13-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 12/29] libqos: Track QTestState with
 QPCIBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 01.09.2017 20:03, Eric Blake wrote:
> When initializing a QPCIBus, track which QTestState the bus is
> associated with (so that a later patch can then explicitly use
> that test state for all communication on the bus, rather than
> blindly relying on global_qtest).  Update the initialization
> functions to take another parameter, and update all callers to
> pass in state (for now, most callers get away with passing the
> current global_qtest as the current state, although this required
> fixing the order of initialization to ensure qtest_start() is
> called before qpci_init*() in rtl8139-test, and provided an
> opportunity to pass in the allocator in e1000e-test).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
[...]
> diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
> index 6226546c28..c95428e1cb 100644
> --- a/tests/libqos/libqos.c
> +++ b/tests/libqos/libqos.c
> @@ -26,8 +26,8 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdlin=
e_fmt, va_list ap)
>          if (ops->init_allocator) {
>              qs->alloc =3D ops->init_allocator(ALLOC_NO_FLAGS);
>          }
> -        if (ops->qpci_init && qs->alloc) {
> -            qs->pcibus =3D ops->qpci_init(qs->alloc);
> +        if (ops->qpci_init) {

Why did you remove the check for qs->alloc?

> +            qs->pcibus =3D ops->qpci_init(qs->qts, qs->alloc);
>          }
>      }
>=20
> diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
> index 02ce49927a..85b34c6d13 100644
> --- a/tests/libqos/pci-pc.c
> +++ b/tests/libqos/pci-pc.c
> @@ -115,11 +115,14 @@ static void qpci_pc_config_writel(QPCIBus *bus, i=
nt devfn, uint8_t offset, uint3
>      outl(0xcfc, value);
>  }
>=20
> -QPCIBus *qpci_init_pc(QGuestAllocator *alloc)
> +QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
>  {
>      QPCIBusPC *ret;
>=20
> +    assert(qts);
> +
>      ret =3D g_malloc(sizeof(*ret));
> +    ret->bus.qts =3D qts;
>=20
>      ret->bus.pio_readb =3D qpci_pc_pio_readb;
>      ret->bus.pio_readw =3D qpci_pc_pio_readw;
> diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
> index 2043f1e123..cd9b8f52d2 100644
> --- a/tests/libqos/pci-spapr.c
> +++ b/tests/libqos/pci-spapr.c
> @@ -154,11 +154,14 @@ static void qpci_spapr_config_writel(QPCIBus *bus=
, int devfn, uint8_t offset,
>  #define SPAPR_PCI_MMIO32_WIN_SIZE    0x80000000 /* 2 GiB */
>  #define SPAPR_PCI_IO_WIN_SIZE        0x10000
>=20
> -QPCIBus *qpci_init_spapr(QGuestAllocator *alloc)
> +QPCIBus *qpci_init_spapr(QTestState *qts, QGuestAllocator *alloc)
>  {
>      QPCIBusSPAPR *ret;
>=20
> +    assert(qts);
> +
>      ret =3D g_malloc(sizeof(*ret));

+1 for using g_malloc0 here instead.

> +    ret->bus.qts =3D qts;
>=20
>      ret->alloc =3D alloc;
>=20
> @@ -201,6 +204,7 @@ QPCIBus *qpci_init_spapr(QGuestAllocator *alloc)
>      ret->bus.mmio_alloc_ptr =3D ret->mmio32.pci_base;
>      ret->bus.mmio_limit =3D ret->mmio32.pci_base + ret->mmio32.size;
>=20
> +

Superfluous white space change.

>      return &ret->bus;
>  }

 Thomas
