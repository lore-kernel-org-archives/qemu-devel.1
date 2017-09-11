Received: from eggs.gnu.org ([2001:4830:134:3::10]:43881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drWHn-0008Eb-2V
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drWHj-0004Tr-Pi
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:30:31 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:54404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drWHj-0004SX-ES
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:30:27 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id CC26C931EF
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 23:30:25 +0200 (CEST)
Date: Mon, 11 Sep 2017 23:30:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170911233008.0c807473@bahia.lan>
In-Reply-To: <20170911172022.4738-18-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-18-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/B5UOpXGiqka2+OCpe4Hb4nr";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v7 17/38] libqos: Use explicit QTestState
 for remaining libqos operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>

--Sig_/B5UOpXGiqka2+OCpe4Hb4nr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Sep 2017 12:20:01 -0500
Eric Blake <eblake@redhat.com> wrote:

> Drop one more client of global_qtest by teaching all remaining
> libqos stragglers to pass in an explicit QTestState.  Change the
> setting of global_qtest from being implicit in libqos' call to
> qtest_start() to instead be explicit in all clients that are
> still relying on global_qtest.
>=20
> Note that qmp_execute() can be greatly simplified in the process,
> and that we also get rid of interpolation of a JSON string into a
> temporary variable when qtest_qmp() can do it more reliably.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v7: split libqos changes from test-ahci, catch more spots
> ---

For tests/virtio-9p-test.c.

Acked-by: Greg Kurz <groug@kaod.org>

>  tests/ahci-test.c         |  1 +
>  tests/ivshmem-test.c      |  1 +
>  tests/libqos/libqos-pc.c  |  2 +-
>  tests/libqos/libqos.c     | 30 ++++++++++--------------------
>  tests/megasas-test.c      |  5 ++++-
>  tests/rtas-test.c         |  1 +
>  tests/usb-hcd-uhci-test.c |  1 +
>  C    |  1 +
>  tests/virtio-blk-test.c   |  1 +
>  tests/virtio-net-test.c   | 15 +++++++++------
>  tests/virtio-scsi-test.c  | 16 +++++++++-------
>  11 files changed, 39 insertions(+), 35 deletions(-)
>=20
> diff --git a/tests/ahci-test.c b/tests/ahci-test.c
> index c94d1bd712..d6696cc370 100644
> --- a/tests/ahci-test.c
> +++ b/tests/ahci-test.c
> @@ -157,6 +157,7 @@ static AHCIQState *ahci_vboot(const char *cli, va_lis=
t ap)
>=20
>      s =3D g_malloc0(sizeof(AHCIQState));
>      s->parent =3D qtest_pc_vboot(cli, ap);
> +    global_qtest =3D s->parent->qts;
>      alloc_set_flags(s->parent->alloc, ALLOC_LEAK_ASSERT);
>=20
>      /* Verify that we have an AHCI device present. */
> diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
> index d35c922254..d8f8530a4d 100644
> --- a/tests/ivshmem-test.c
> +++ b/tests/ivshmem-test.c
> @@ -131,6 +131,7 @@ static void setup_vm_cmd(IVState *s, const char *cmd,=
 bool msix)
>          g_printerr("ivshmem-test tests are only available on x86 or ppc6=
4\n");
>          exit(EXIT_FAILURE);
>      }
> +    global_qtest =3D s->qs->qts;
>      s->dev =3D get_device(s->qs->pcibus);
>=20
>      s->reg_bar =3D qpci_iomap(s->dev, 0, &barsize);
> diff --git a/tests/libqos/libqos-pc.c b/tests/libqos/libqos-pc.c
> index b554758802..a9c1aceaa7 100644
> --- a/tests/libqos/libqos-pc.c
> +++ b/tests/libqos/libqos-pc.c
> @@ -25,7 +25,7 @@ QOSState *qtest_pc_boot(const char *cmdline_fmt, ...)
>      qs =3D qtest_vboot(&qos_ops, cmdline_fmt, ap);
>      va_end(ap);
>=20
> -    qtest_irq_intercept_in(global_qtest, "ioapic");
> +    qtest_irq_intercept_in(qs->qts, "ioapic");
>=20
>      return qs;
>  }
> diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
> index 40018b9c07..9798e1d027 100644
> --- a/tests/libqos/libqos.c
> +++ b/tests/libqos/libqos.c
> @@ -20,7 +20,7 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdline_=
fmt, va_list ap)
>      QOSState *qs =3D g_new0(QOSState, 1);
>=20
>      cmdline =3D g_strdup_vprintf(cmdline_fmt, ap);
> -    qs->qts =3D qtest_start(cmdline);
> +    qs->qts =3D qtest_init(cmdline);
>      qs->ops =3D ops;
>      if (ops) {
>          qs->alloc =3D ops->init_allocator(qs->qts, ALLOC_NO_FLAGS);
> @@ -80,29 +80,21 @@ void set_context(QOSState *s)
>      global_qtest =3D s->qts;
>  }
>=20
> -static QDict *qmp_execute(const char *command)
> +static QDict *qmp_execute(QTestState *qts, const char *command)
>  {
> -    char *fmt;
> -    QDict *rsp;
> -
> -    fmt =3D g_strdup_printf("{ 'execute': '%s' }", command);
> -    rsp =3D qmp(fmt);
> -    g_free(fmt);
> -
> -    return rsp;
> +    return qtest_qmp(qts, "{ 'execute': %s }", command);
>  }
>=20
>  void migrate(QOSState *from, QOSState *to, const char *uri)
>  {
>      const char *st;
> -    char *s;
>      QDict *rsp, *sub;
>      bool running;
>=20
>      set_context(from);
>=20
>      /* Is the machine currently running? */
> -    rsp =3D qmp_execute("query-status");
> +    rsp =3D qmp_execute(from->qts, "query-status");
>      g_assert(qdict_haskey(rsp, "return"));
>      sub =3D qdict_get_qdict(rsp, "return");
>      g_assert(qdict_haskey(sub, "running"));
> @@ -110,30 +102,28 @@ void migrate(QOSState *from, QOSState *to, const ch=
ar *uri)
>      QDECREF(rsp);
>=20
>      /* Issue the migrate command. */
> -    s =3D g_strdup_printf("{ 'execute': 'migrate',"
> -                        "'arguments': { 'uri': '%s' } }",
> -                        uri);
> -    rsp =3D qmp(s);
> -    g_free(s);
> +    rsp =3D qtest_qmp(from->qts,
> +                    "{ 'execute': 'migrate', 'arguments': { 'uri': %s }}=
",
> +                    uri);
>      g_assert(qdict_haskey(rsp, "return"));
>      QDECREF(rsp);
>=20
>      /* Wait for STOP event, but only if we were running: */
>      if (running) {
> -        qmp_eventwait("STOP");
> +        qtest_qmp_eventwait(from->qts, "STOP");
>      }
>=20
>      /* If we were running, we can wait for an event. */
>      if (running) {
>          migrate_allocator(from->alloc, to->alloc);
>          set_context(to);
> -        qmp_eventwait("RESUME");
> +        qtest_qmp_eventwait(to->qts, "RESUME");
>          return;
>      }
>=20
>      /* Otherwise, we need to wait: poll until migration is completed. */
>      while (1) {
> -        rsp =3D qmp_execute("query-migrate");
> +        rsp =3D qmp_execute(from->qts, "query-migrate");
>          g_assert(qdict_haskey(rsp, "return"));
>          sub =3D qdict_get_qdict(rsp, "return");
>          g_assert(qdict_haskey(sub, "status"));
> diff --git a/tests/megasas-test.c b/tests/megasas-test.c
> index ce960e7f81..81837e14af 100644
> --- a/tests/megasas-test.c
> +++ b/tests/megasas-test.c
> @@ -15,13 +15,16 @@
>=20
>  static QOSState *qmegasas_start(const char *extra_opts)
>  {
> +    QOSState *qs;
>      const char *arch =3D qtest_get_arch();
>      const char *cmd =3D "-drive id=3Dhd0,if=3Dnone,file=3Dnull-co://,for=
mat=3Draw "
>                        "-device megasas,id=3Dscsi0,addr=3D04.0 "
>                        "-device scsi-hd,bus=3Dscsi0.0,drive=3Dhd0 %s";
>=20
>      if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0=
) {
> -        return qtest_pc_boot(cmd, extra_opts ? : "");
> +        qs =3D qtest_pc_boot(cmd, extra_opts ? : "");
> +        global_qtest =3D qs->qts;
> +        return qs;
>      }
>=20
>      g_printerr("virtio-scsi tests are only available on x86 or ppc64\n");
> diff --git a/tests/rtas-test.c b/tests/rtas-test.c
> index 34a692163f..009bda6d23 100644
> --- a/tests/rtas-test.c
> +++ b/tests/rtas-test.c
> @@ -14,6 +14,7 @@ static void test_rtas_get_time_of_day(void)
>      time_t t1, t2;
>=20
>      qs =3D qtest_spapr_boot("-machine pseries");
> +    global_qtest =3D qs->qts;
>=20
>      t1 =3D time(NULL);
>      ret =3D qrtas_get_time_of_day(qs->qts, qs->alloc, &tm, &ns);
> diff --git a/tests/usb-hcd-uhci-test.c b/tests/usb-hcd-uhci-test.c
> index 0fb7f8d223..290416d845 100644
> --- a/tests/usb-hcd-uhci-test.c
> +++ b/tests/usb-hcd-uhci-test.c
> @@ -95,6 +95,7 @@ int main(int argc, char **argv)
>                     "available on x86 or ppc64\n");
>          exit(EXIT_FAILURE);
>      }
> +    global_qtest =3D qs->qts;
>      ret =3D g_test_run();
>      qtest_shutdown(qs);
>=20
> diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
> index ad33d96387..07cbb7f37c 100644
> --- a/tests/virtio-9p-test.c
> +++ b/tests/virtio-9p-test.c
> @@ -46,6 +46,7 @@ static QVirtIO9P *qvirtio_9p_start(const char *driver)
>          g_printerr("virtio-9p tests are only available on x86 or ppc64\n=
");
>          exit(EXIT_FAILURE);
>      }
> +    global_qtest =3D v9p->qs->qts;
>=20
>      return v9p;
>  }
> diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
> index 99bb6f26cd..0cf33b6810 100644
> --- a/tests/virtio-blk-test.c
> +++ b/tests/virtio-blk-test.c
> @@ -77,6 +77,7 @@ static QOSState *pci_test_start(void)
>          g_printerr("virtio-blk tests are only available on x86 or ppc64\=
n");
>          exit(EXIT_FAILURE);
>      }
> +    global_qtest =3D qs->qts;
>      unlink(tmp_path);
>      g_free(tmp_path);
>      return qs;
> diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
> index 8b43d3dd65..acecef0a3e 100644
> --- a/tests/virtio-net-test.c
> +++ b/tests/virtio-net-test.c
> @@ -53,18 +53,21 @@ static QVirtioPCIDevice *virtio_net_pci_init(QPCIBus =
*bus, int slot)
>=20
>  static QOSState *pci_test_start(int socket)
>  {
> +    QOSState *qs;
>      const char *arch =3D qtest_get_arch();
>      const char *cmd =3D "-netdev socket,fd=3D%d,id=3Dhs0 -device "
>                        "virtio-net-pci,netdev=3Dhs0";
>=20
>      if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0=
) {
> -        return qtest_pc_boot(cmd, socket);
> +        qs =3D qtest_pc_boot(cmd, socket);
> +    } else if (strcmp(arch, "ppc64") =3D=3D 0) {
> +        qs =3D qtest_spapr_boot(cmd, socket);
> +    } else {
> +        g_printerr("virtio-net tests are only available on x86 or ppc64\=
n");
> +        exit(EXIT_FAILURE);
>      }
> -    if (strcmp(arch, "ppc64") =3D=3D 0) {
> -        return qtest_spapr_boot(cmd, socket);
> -    }
> -    g_printerr("virtio-net tests are only available on x86 or ppc64\n");
> -    exit(EXIT_FAILURE);
> +    global_qtest =3D qs->qts;
> +    return qs;
>  }
>=20
>  static void driver_init(QVirtioDevice *dev)
> diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
> index 87a3b6e81a..4d544ddbc3 100644
> --- a/tests/virtio-scsi-test.c
> +++ b/tests/virtio-scsi-test.c
> @@ -34,20 +34,22 @@ typedef struct {
>=20
>  static QOSState *qvirtio_scsi_start(const char *extra_opts)
>  {
> +    QOSState *qs;
>      const char *arch =3D qtest_get_arch();
>      const char *cmd =3D "-drive id=3Ddrv0,if=3Dnone,file=3Dnull-co://,fo=
rmat=3Draw "
>                        "-device virtio-scsi-pci,id=3Dvs0 "
>                        "-device scsi-hd,bus=3Dvs0.0,drive=3Ddrv0 %s";
>=20
>      if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0=
) {
> -        return qtest_pc_boot(cmd, extra_opts ? : "");
> +        qs =3D qtest_pc_boot(cmd, extra_opts ? : "");
> +    } else if (strcmp(arch, "ppc64") =3D=3D 0) {
> +        qs =3D qtest_spapr_boot(cmd, extra_opts ? : "");
> +    } else {
> +        g_printerr("virtio-scsi tests are only available on x86 or ppc64=
\n");
> +        exit(EXIT_FAILURE);
>      }
> -    if (strcmp(arch, "ppc64") =3D=3D 0) {
> -        return qtest_spapr_boot(cmd, extra_opts ? : "");
> -    }
> -
> -    g_printerr("virtio-scsi tests are only available on x86 or ppc64\n");
> -    exit(EXIT_FAILURE);
> +    global_qtest =3D qs->qts;
> +    return qs;
>  }
>=20
>  static void qvirtio_scsi_stop(QOSState *qs)


--Sig_/B5UOpXGiqka2+OCpe4Hb4nr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbcAYAAKCRAC/DrrAQHb
wrm9AKCk8t8Omn0gxweWYJ7fJeNXA9AakQCgnSikIESEju7P9qC5Eujnbgo4NOU=
=bdVQ
-----END PGP SIGNATURE-----

--Sig_/B5UOpXGiqka2+OCpe4Hb4nr--
