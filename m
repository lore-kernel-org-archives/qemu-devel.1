Received: from eggs.gnu.org ([2001:4830:134:3::10]:38977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1driZr-0000Jq-Gf
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1driZq-0008HJ-2O
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:37:59 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-30-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f489c01c-5671-3942-6d76-c399d8c8014a@redhat.com>
Date: Tue, 12 Sep 2017 12:37:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-30-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 29/38] libqtest: Merge qtest_init() into
 qtest_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, Keith Busch <keith.busch@intel.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>

On 11.09.2017 19:20, Eric Blake wrote:
> Remove the trivial wrapper qtest_init(), and change qtest_start()
> to no longer implicitly set global_qtest, to make it obvious in the
> rest of the testsuite where we are still relying on global_qtest.
> Everything now uses qtest_start() (and friends) and qtest_quit(),
> and explicitly tracks the QTestState between the two (although in
> many cases, this tracking is still done through global_qtest).
> Doing this makes it easier to see what remaining cleanups will be
> needed if we don't want an implicit dependency on global state.
[...]
> diff --git a/tests/libqtest.h b/tests/libqtest.h
> index 817e3a5580..2a21bf4605 100644
> --- a/tests/libqtest.h
> +++ b/tests/libqtest.h
> @@ -27,7 +27,7 @@ extern QTestState *global_qtest;
>   * qtest_start_without_qmp_handshake:
>   * @extra_args: other arguments to pass to QEMU.
>   *
> - * Returns: #QTestState instance.  Does not affect #global_qtest.
> + * Returns: #QTestState instance, handshaking not yet completed.

I'd rather add a description a la:

  * Start QEMU, but do not execute the QMP handshake yet.
  *
  * Returns: #QTestState instance

>   */
>  QTestState *qtest_start_without_qmp_handshake(const char *extra_args);
>=20
> @@ -35,10 +35,7 @@ QTestState *qtest_start_without_qmp_handshake(const =
char *extra_args);
>   * qtest_start:
>   * @args: other arguments to pass to QEMU
>   *
> - * Start QEMU and assign the resulting #QTestState to #global_qtest.
> - * The global variable is used by "shortcut" functions documented belo=
w.
>   *
> - * Returns: #QTestState instance.
> + * Returns: #QTestState instance, handshaking completed.

I'd rather change the description instead of removing it:

  * Start QEMU and execute the initial QMP handshake
  *
  * Returns: #QTestState instance.

>   */
>  QTestState *qtest_start(const char *args);
>=20
> @@ -47,10 +44,7 @@ QTestState *qtest_start(const char *args);
>   * @fmt...: Format for creating other arguments to pass to QEMU, forma=
tted
>   * like sprintf().
>   *
> - * Start QEMU and return the resulting #QTestState (but unlike qtest_s=
tart(),
> - * #global_qtest is left at NULL).
> - *
> - * Returns: #QTestState instance.
> + * Returns: #QTestState instance, handshaking completed.

dito

>   */
>  QTestState *qtest_startf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>=20
> @@ -60,30 +54,11 @@ QTestState *qtest_startf(const char *fmt, ...) GCC_=
FMT_ATTR(1, 2);
>   * like vsprintf().
>   * @ap: Format arguments.
>   *
> - * Start QEMU and return the resulting #QTestState (but unlike qtest_s=
tart(),
> - * #global_qtest is left at NULL).
> - *
> - * Returns: #QTestState instance.
> + * Returns: #QTestState instance, handshaking completed.

dito

>   */
>  QTestState *qtest_vstartf(const char *fmt, va_list ap) GCC_FMT_ATTR(1,=
 0);
>=20
>  /**
> - * qtest_init:
> - * @extra_args: other arguments to pass to QEMU.
> - *
> - * Returns: #QTestState instance.  Does not affect #global_qtest.
> - */
> -static inline QTestState *qtest_init(const char *extra_args)
> -{
> -    QTestState *s;
> -
> -    assert(!global_qtest);
> -    s =3D qtest_start(extra_args);
> -    global_qtest =3D NULL;
> -    return s;
> -}
[...]
> diff --git a/tests/display-vga-test.c b/tests/display-vga-test.c
> index 8667330e3c..d638f15ec3 100644
> --- a/tests/display-vga-test.c
> +++ b/tests/display-vga-test.c
> @@ -12,39 +12,33 @@
>=20
>  static void pci_cirrus(void)
>  {
> -    qtest_start("-vga none -device cirrus-vga");
> -    qtest_quit(global_qtest);
> +    qtest_quit(qtest_start("-vga none -device cirrus-vga"));

I'd prefer to keep this on separate lines ... but that's again just my
personal taste. (also for the othe changes below)

>  }
>=20
>  static void pci_stdvga(void)
>  {
> -    qtest_start("-vga none -device VGA");
> -    qtest_quit(global_qtest);
> +    qtest_quit(qtest_start("-vga none -device VGA"));
>  }
>=20
>  static void pci_secondary(void)
>  {
> -    qtest_start("-vga none -device secondary-vga");
> -    qtest_quit(global_qtest);
> +    qtest_quit(qtest_start("-vga none -device secondary-vga"));
>  }
>=20
>  static void pci_multihead(void)
>  {
> -    qtest_start("-vga none -device VGA -device secondary-vga");
> -    qtest_quit(global_qtest);
> +    qtest_quit(qtest_start("-vga none -device VGA -device secondary-vg=
a"));
>  }
>=20
>  static void pci_virtio_gpu(void)
>  {
> -    qtest_start("-vga none -device virtio-gpu-pci");
> -    qtest_quit(global_qtest);
> +    qtest_quit(qtest_start("-vga none -device virtio-gpu-pci"));
>  }
>=20
>  #ifdef CONFIG_VIRTIO_VGA
>  static void pci_virtio_vga(void)
>  {
> -    qtest_start("-vga none -device virtio-vga");
> -    qtest_quit(global_qtest);
> +    qtest_quit(qtest_start("-vga none -device virtio-vga"));
>  }
>  #endif
[...]
> diff --git a/tests/ne2000-test.c b/tests/ne2000-test.c
> index cae83c5c4c..8e6f7b07c6 100644
> --- a/tests/ne2000-test.c
> +++ b/tests/ne2000-test.c
> @@ -22,7 +22,7 @@ int main(int argc, char **argv)
>      g_test_init(&argc, &argv, NULL);
>      qtest_add_func("/ne2000/pci/nop", pci_nop);
>=20
> -    qtest_start("-device ne2k_pci");
> +    global_qtest =3D qtest_start("-device ne2k_pci");
>      ret =3D g_test_run();
>=20
>      qtest_quit(global_qtest);

For such very trivial tests, it maybe makes sense to use a local
"QTestState *qts" variable here already, so we don't have to touch this
code again later?

> diff --git a/tests/nvme-test.c b/tests/nvme-test.c
> index 3d6c0f39cf..b054ad6fcd 100644
> --- a/tests/nvme-test.c
> +++ b/tests/nvme-test.c
> @@ -22,8 +22,9 @@ int main(int argc, char **argv)
>      g_test_init(&argc, &argv, NULL);
>      qtest_add_func("/nvme/nop", nop);
>=20
> -    qtest_start("-drive id=3Ddrv0,if=3Dnone,file=3Dnull-co://,format=3D=
raw "
> -                "-device nvme,drive=3Ddrv0,serial=3Dfoo");
> +    global_qtest =3D qtest_start(
> +        "-drive id=3Ddrv0,if=3Dnone,file=3Dnull-co://,format=3Draw "
> +        "-device nvme,drive=3Ddrv0,serial=3Dfoo");
>      ret =3D g_test_run();
>=20
>      qtest_quit(global_qtest);

dito

> diff --git a/tests/pcnet-test.c b/tests/pcnet-test.c
> index 98246d3504..a58a5fd7bf 100644
> --- a/tests/pcnet-test.c
> +++ b/tests/pcnet-test.c
> @@ -22,7 +22,7 @@ int main(int argc, char **argv)
>      g_test_init(&argc, &argv, NULL);
>      qtest_add_func("/pcnet/pci/nop", pci_nop);
>=20
> -    qtest_start("-device pcnet");
> +    global_qtest =3D qtest_start("-device pcnet");
>      ret =3D g_test_run();
>=20
>      qtest_quit(global_qtest);

dito

[...]
> diff --git a/tests/virtio-balloon-test.c b/tests/virtio-balloon-test.c
> index 34ad718601..cca7b0e8fb 100644
> --- a/tests/virtio-balloon-test.c
> +++ b/tests/virtio-balloon-test.c
> @@ -22,7 +22,7 @@ int main(int argc, char **argv)
>      g_test_init(&argc, &argv, NULL);
>      qtest_add_func("/virtio/balloon/pci/nop", pci_nop);
>=20
> -    qtest_start("-device virtio-balloon-pci");
> +    global_qtest =3D qtest_start("-device virtio-balloon-pci");
>      ret =3D g_test_run();
>=20
>      qtest_quit(global_qtest);

dito

[...]
> diff --git a/tests/vmxnet3-test.c b/tests/vmxnet3-test.c
> index 631630b4d0..0b4b807616 100644
> --- a/tests/vmxnet3-test.c
> +++ b/tests/vmxnet3-test.c
> @@ -22,7 +22,7 @@ int main(int argc, char **argv)
>      g_test_init(&argc, &argv, NULL);
>      qtest_add_func("/vmxnet3/nop", nop);
>=20
> -    qtest_start("-device vmxnet3");
> +    global_qtest =3D qtest_start("-device vmxnet3");
>      ret =3D g_test_run();
>=20
>      qtest_quit(global_qtest);

dito

 Thomas
