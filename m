Received: from eggs.gnu.org ([209.51.188.92]:54173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gkTBm-0008Q5-N6
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gkTBk-0006B4-DU
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:23:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gkTBj-00068x-VM
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:23:56 -0500
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
	<1547576349-13337-3-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2e5a5fec-3ba7-7bd6-6ffc-c9dfc7079e52@redhat.com>
Date: Fri, 18 Jan 2019 13:23:52 +0100
MIME-Version: 1.0
In-Reply-To: <1547576349-13337-3-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] tests/libqos: rename qpci_init_pc and
 qpci_init_spapr functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

On 2019-01-15 19:19, Paolo Bonzini wrote:
> From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
>=20
> Rename qpci_init_pc in qpci_pc_new and qpci_init_spapr in qpci_spapr_ne=
w,
> since theese function actually allocate a new pci struct and initialize=
 it.
> Changed QOSOps field name from qpci_init to qpci_new.
>=20
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com=
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/e1000e-test.c         | 2 +-
>  tests/i440fx-test.c         | 2 +-
>  tests/ide-test.c            | 2 +-
>  tests/libqos/ahci.c         | 2 +-
>  tests/libqos/libqos-pc.c    | 2 +-
>  tests/libqos/libqos-spapr.c | 2 +-
>  tests/libqos/libqos.c       | 2 +-
>  tests/libqos/libqos.h       | 2 +-
>  tests/libqos/pci-pc.c       | 2 +-
>  tests/libqos/pci-pc.h       | 9 ++++++++-
>  tests/libqos/pci-spapr.c    | 2 +-
>  tests/libqos/pci-spapr.h    | 2 +-
>  tests/q35-test.c            | 4 ++--
>  tests/rtl8139-test.c        | 2 +-
>  tests/sdhci-test.c          | 2 +-
>  tests/tco-test.c            | 2 +-
>  tests/usb-hcd-ehci-test.c   | 2 +-
>  tests/vhost-user-test.c     | 2 +-
>  18 files changed, 26 insertions(+), 19 deletions(-)
>=20
> diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
> index c9408a5..5525589 100644
> --- a/tests/e1000e-test.c
> +++ b/tests/e1000e-test.c
> @@ -395,7 +395,7 @@ static void data_test_init(e1000e_device *d)
>      test_alloc =3D pc_alloc_init(global_qtest);
>      g_assert_nonnull(test_alloc);
> =20
> -    test_bus =3D qpci_init_pc(global_qtest, test_alloc);
> +    test_bus =3D qpci_new_pc(global_qtest, test_alloc);
>      g_assert_nonnull(test_bus);
> =20
>      e1000e_device_init(test_bus, d);
> diff --git a/tests/i440fx-test.c b/tests/i440fx-test.c
> index 4390e55..69205b5 100644
> --- a/tests/i440fx-test.c
> +++ b/tests/i440fx-test.c
> @@ -38,7 +38,7 @@ static QPCIBus *test_start_get_bus(const TestData *s)
>      cmdline =3D g_strdup_printf("-smp %d", s->num_cpus);
>      qtest_start(cmdline);
>      g_free(cmdline);
> -    return qpci_init_pc(global_qtest, NULL);
> +    return qpci_new_pc(global_qtest, NULL);
>  }
> =20
>  static void test_i440fx_defaults(gconstpointer opaque)
> diff --git a/tests/ide-test.c b/tests/ide-test.c
> index f0280e6..8f5adae 100644
> --- a/tests/ide-test.c
> +++ b/tests/ide-test.c
> @@ -157,7 +157,7 @@ static QPCIDevice *get_pci_device(QPCIBar *bmdma_ba=
r, QPCIBar *ide_bar)
>      uint16_t vendor_id, device_id;
> =20
>      if (!pcibus) {
> -        pcibus =3D qpci_init_pc(global_qtest, NULL);
> +        pcibus =3D qpci_new_pc(global_qtest, NULL);
>      }
> =20
>      /* Find PCI device and verify it's the right one */
> diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
> index 63fbc9e..cc1b08e 100644
> --- a/tests/libqos/ahci.c
> +++ b/tests/libqos/ahci.c
> @@ -130,7 +130,7 @@ QPCIDevice *get_ahci_device(QTestState *qts, uint32=
_t *fingerprint)
>      uint32_t ahci_fingerprint;
>      QPCIBus *pcibus;
> =20
> -    pcibus =3D qpci_init_pc(qts, NULL);
> +    pcibus =3D qpci_new_pc(qts, NULL);
> =20
>      /* Find the AHCI PCI device and verify it's the right one. */
>      ahci =3D qpci_device_find(pcibus, QPCI_DEVFN(0x1F, 0x02));
> diff --git a/tests/libqos/libqos-pc.c b/tests/libqos/libqos-pc.c
> index a9c1ace..293f9b6 100644
> --- a/tests/libqos/libqos-pc.c
> +++ b/tests/libqos/libqos-pc.c
> @@ -6,7 +6,7 @@
>  static QOSOps qos_ops =3D {
>      .init_allocator =3D pc_alloc_init_flags,
>      .uninit_allocator =3D pc_alloc_uninit,
> -    .qpci_init =3D qpci_init_pc,
> +    .qpci_new =3D qpci_new_pc,
>      .qpci_free =3D qpci_free_pc,
>      .shutdown =3D qtest_pc_shutdown,
>  };
> diff --git a/tests/libqos/libqos-spapr.c b/tests/libqos/libqos-spapr.c
> index a37791e..64addfe 100644
> --- a/tests/libqos/libqos-spapr.c
> +++ b/tests/libqos/libqos-spapr.c
> @@ -6,7 +6,7 @@
>  static QOSOps qos_ops =3D {
>      .init_allocator =3D spapr_alloc_init_flags,
>      .uninit_allocator =3D spapr_alloc_uninit,
> -    .qpci_init =3D qpci_init_spapr,
> +    .qpci_new =3D qpci_new_spapr,
>      .qpci_free =3D qpci_free_spapr,
>      .shutdown =3D qtest_spapr_shutdown,
>  };
> diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
> index c514187..6c91371 100644
> --- a/tests/libqos/libqos.c
> +++ b/tests/libqos/libqos.c
> @@ -25,7 +25,7 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdlin=
e_fmt, va_list ap)
>      qs->ops =3D ops;
>      if (ops) {
>          qs->alloc =3D ops->init_allocator(qs->qts, ALLOC_NO_FLAGS);
> -        qs->pcibus =3D ops->qpci_init(qs->qts, qs->alloc);
> +        qs->pcibus =3D ops->qpci_new(qs->qts, qs->alloc);
>      }
> =20
>      g_free(cmdline);
> diff --git a/tests/libqos/libqos.h b/tests/libqos/libqos.h
> index 07d4b93..1af6035 100644
> --- a/tests/libqos/libqos.h
> +++ b/tests/libqos/libqos.h
> @@ -10,7 +10,7 @@ typedef struct QOSState QOSState;
>  typedef struct QOSOps {
>      QGuestAllocator *(*init_allocator)(QTestState *qts, QAllocOpts);
>      void (*uninit_allocator)(QGuestAllocator *);
> -    QPCIBus *(*qpci_init)(QTestState *qts, QGuestAllocator *alloc);
> +    QPCIBus *(*qpci_new)(QTestState *qts, QGuestAllocator *alloc);
>      void (*qpci_free)(QPCIBus *bus);
>      void (*shutdown)(QOSState *);
>  } QOSOps;
> diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
> index a4fc02b..43d7082 100644
> --- a/tests/libqos/pci-pc.c
> +++ b/tests/libqos/pci-pc.c
> @@ -116,7 +116,7 @@ static void qpci_pc_config_writel(QPCIBus *bus, int=
 devfn, uint8_t offset, uint3
>      qtest_outl(bus->qts, 0xcfc, value);
>  }
> =20
> -QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
> +QPCIBus *qpci_new_pc(QTestState *qts, QGuestAllocator *alloc)
>  {
>      QPCIBusPC *ret =3D g_new0(QPCIBusPC, 1);
> =20
> diff --git a/tests/libqos/pci-pc.h b/tests/libqos/pci-pc.h
> index 491eeac..84cc300 100644
> --- a/tests/libqos/pci-pc.h
> +++ b/tests/libqos/pci-pc.h
> @@ -16,7 +16,14 @@
>  #include "libqos/pci.h"
>  #include "libqos/malloc.h"
> =20
> -QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc);
> +/* qpci_new_pc():
> +* this function creates a new QPCIBusPC object,

Hmm, you did not notice my previous review, did you? See:

https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01417.html

 Thomas
