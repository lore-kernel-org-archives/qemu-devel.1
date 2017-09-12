Received: from eggs.gnu.org ([2001:4830:134:3::10]:42068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drfeB-000132-RG
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drfe5-000403-M6
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:30:15 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-11-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <65cb854d-5915-dc23-cb5d-0d8b5cecb6ea@redhat.com>
Date: Tue, 12 Sep 2017 09:29:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-11-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 10/38] libqos: Move/rename
 qpci_unplug_acpi_device_test() to pci.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>, "open list:virtio-blk" <qemu-block@nongnu.org>, Laurent Vivier <lvivier@redhat.com>

On 11.09.2017 19:19, Eric Blake wrote:
> Commit 2f8b2767 originally added qpci_plug_device_test() and
> qpci_unplug_acpi_device_test() as a pair, both in pci-pc.c.
> Later, commit cf716b31 moved one half of the pair to pci.c
> when adding PPC64 support.  Keep the implementations of the
> two functions together, and shorten the name to
> qpci_unplug_device_test(), since all callers use the two
> functions in tandem.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqos/pci.h      |  2 +-
>  tests/e1000e-test.c     |  2 +-
>  tests/ivshmem-test.c    |  2 +-
>  tests/libqos/pci-pc.c   | 23 -----------------------
>  tests/libqos/pci.c      | 23 +++++++++++++++++++++++
>  tests/virtio-blk-test.c |  2 +-
>  tests/virtio-net-test.c |  2 +-
>  tests/virtio-rng-test.c |  2 +-
>  8 files changed, 29 insertions(+), 29 deletions(-)
>=20
> diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
> index 429c382282..fdda7eca6e 100644
> --- a/tests/libqos/pci.h
> +++ b/tests/libqos/pci.h
> @@ -111,5 +111,5 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t=
 addr);
>=20
>  void qpci_plug_device_test(const char *driver, const char *id,
>                             uint8_t slot, const char *opts);
> -void qpci_unplug_acpi_device_test(const char *id, uint8_t slot);
> +void qpci_unplug_device_test(const char *id, uint8_t slot);
>  #endif
> diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
> index d8085d944e..4c663a3019 100644
> --- a/tests/e1000e-test.c
> +++ b/tests/e1000e-test.c
> @@ -461,7 +461,7 @@ static void test_e1000e_hotplug(gconstpointer data)
>      qtest_start("-device e1000e");
>=20
>      qpci_plug_device_test("e1000e", "e1000e_net", slot, NULL);
> -    qpci_unplug_acpi_device_test("e1000e_net", slot);
> +    qpci_unplug_device_test("e1000e_net", slot);
>=20
>      qtest_end();
>  }
> diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
> index 37763425ee..8c9ed6a568 100644
> --- a/tests/ivshmem-test.c
> +++ b/tests/ivshmem-test.c
> @@ -427,7 +427,7 @@ static void test_ivshmem_hotplug(void)
>=20
>      qpci_plug_device_test("ivshmem", "iv1", PCI_SLOT_HP, opts);
>      if (strcmp(arch, "ppc64") !=3D 0) {
> -        qpci_unplug_acpi_device_test("iv1", PCI_SLOT_HP);
> +        qpci_unplug_device_test("iv1", PCI_SLOT_HP);
>      }
>=20
>      qtest_end();
> diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
> index e267fd1a44..6305d142a5 100644
> --- a/tests/libqos/pci-pc.c
> +++ b/tests/libqos/pci-pc.c
> @@ -19,9 +19,6 @@
>  #include "qemu-common.h"
>=20
>=20
> -#define ACPI_PCIHP_ADDR         0xae00
> -#define PCI_EJ_BASE             0x0008
> -
>  typedef struct QPCIBusPC
>  {
>      QPCIBus bus;
> @@ -156,23 +153,3 @@ void qpci_free_pc(QPCIBus *bus)
>=20
>      g_free(s);
>  }
> -
> -void qpci_unplug_acpi_device_test(const char *id, uint8_t slot)
> -{
> -    QDict *response;
> -    char *cmd;
> -
> -    cmd =3D g_strdup_printf("{'execute': 'device_del',"
> -                          " 'arguments': {"
> -                          "   'id': '%s'"
> -                          "}}", id);
> -    response =3D qmp(cmd);
> -    g_free(cmd);
> -    g_assert(response);
> -    g_assert(!qdict_haskey(response, "error"));
> -    QDECREF(response);
> -
> -    outb(ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
> -
> -    qmp_eventwait("DEVICE_DELETED");
> -}
> diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
> index 2dcdeade2a..9f36ec73ef 100644
> --- a/tests/libqos/pci.c
> +++ b/tests/libqos/pci.c
> @@ -16,6 +16,9 @@
>  #include "hw/pci/pci_regs.h"
>  #include "qemu/host-utils.h"
>=20
> +#define ACPI_PCIHP_ADDR         0xae00
> +#define PCI_EJ_BASE             0x0008
> +
>  void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
>                           void (*func)(QPCIDevice *dev, int devfn, void=
 *data),
>                           void *data)
> @@ -412,3 +415,23 @@ void qpci_plug_device_test(const char *driver, con=
st char *id,
>      g_assert(!qdict_haskey(response, "error"));
>      QDECREF(response);
>  }
> +
> +void qpci_unplug_device_test(const char *id, uint8_t slot)
> +{
> +    QDict *response;
> +    char *cmd;
> +
> +    cmd =3D g_strdup_printf("{'execute': 'device_del',"
> +                          " 'arguments': {"
> +                          "   'id': '%s'"
> +                          "}}", id);
> +    response =3D qmp(cmd);
> +    g_free(cmd);
> +    g_assert(response);
> +    g_assert(!qdict_haskey(response, "error"));
> +    QDECREF(response);
> +
> +    outb(ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
> +
> +    qmp_eventwait("DEVICE_DELETED");
> +}

No, that's a bad idea. ACPI and that outb() is clearly something
specific to x86, so this should not reside in pci.c but in pci-pc.c

We might be able to unify this - I've had a similar patch here:

 https://patchwork.kernel.org/patch/9905031/

... but I think this needs some more careful thinking and discussion, so
I'd suggest that you remove this from your already huge patch series for
now and we fix it later instead.

 Thomas
