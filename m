Received: from eggs.gnu.org ([2001:4830:134:3::10]:51810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePnqn-00053K-Uo
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePnqk-0006ZH-Nk
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:08:21 -0500
References: <20171215101651.13911-1-david@gibson.dropbear.id.au>
	<20171215101651.13911-3-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f877ff83-5fb1-8728-545e-e373ac41bb58@redhat.com>
Date: Fri, 15 Dec 2017 12:08:13 +0100
MIME-Version: 1.0
In-Reply-To: <20171215101651.13911-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] tests/pxe-test: Use table of testcases
 rather than open-coding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mst@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 15.12.2017 11:16, David Gibson wrote:
> Currently pxe-tests open codes the list of tests for each architecture.
> This changes it to use tables of test parameters, somewhat similar to
> boot-serial-test.
>=20
> This adds the machine type into the table as well, giving us the abilit=
y
> to perform tests on multiple machine types for architectures where ther=
e's
> more than one machine type that matters.
>=20
> NOTE: This changes the names of the tests in the output, to include the
>       machine type and IPv4 vs. IPv6.  I'm not sure if this has the
>       potential to break existing tooling.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  tests/pxe-test.c | 94 +++++++++++++++++++++++++++++++++++++++++++-----=
--------
>  1 file changed, 72 insertions(+), 22 deletions(-)
>=20
> diff --git a/tests/pxe-test.c b/tests/pxe-test.c
> index eb70aa2bc6..f9bca8976d 100644
> --- a/tests/pxe-test.c
> +++ b/tests/pxe-test.c
> @@ -22,29 +22,86 @@
> =20
>  static char disk[] =3D "tests/pxe-test-disk-XXXXXX";
> =20
> -static void test_pxe_one(const char *params, bool ipv6)
> +typedef struct testdef {
> +    const char *machine;    /* Machine type */
> +    const char *model;      /* NIC device model (human readable)*/
> +    const char *extra;      /* Extra parameters, overriding default */
> +} testdef_t;

Not sure whether it's nicer, but you could also add a "is_slow" field to
the struct and then merge the fast and slow tables below...?

> +static testdef_t x86_tests[] =3D {
> +    { "pc", "e1000" },
> +    { "pc", "virtio", "-device virtio-net-pci,netdev=3D" NETNAME },

I think I'd rather rather use "virtio-net-pci" as model name here and
drop the "extra" parameter.

> +    { NULL },
> +};
> +
> +static testdef_t x86_tests_slow[] =3D {
> +    { "pc", "ne2000", "-device ne2k_pci,netdev=3D" NETNAME },
> +    { "pc", "eepro100", "-device i82550,netdev=3D" NETNAME },

dito.

> +    { "pc", "rtl8139" },
> +    { "pc", "vmxnet3" },
> +    { NULL },
> +};
> +
> +static testdef_t ppc64_tests[] =3D {
> +    { "pseries", "spapr-vlan" },
> +    { NULL },
> +};
> +
> +static testdef_t ppc64_tests_slow[] =3D {
> +    { "pseries", "virtio", "-device virtio-net-pci,netdev=3D" NETNAME =
},

dito.

> +    { "pseries", "e1000" },
> +    { NULL },
> +};
> +
> +static testdef_t s390x_tests[] =3D {
> +    { "s390-ccw-virtio", "virtio-ccw",
> +      "-device virtio-net-ccw,bootindex=3D1,netdev=3D" NETNAME },
> +    { NULL },
> +};
> +
> +static void test_pxe_one(const testdef_t *test, bool ipv6)
>  {
>      char *args;
> +    char *defextra;
> +    const char *extra =3D test->extra;
> +
> +    defextra =3D g_strdup_printf("-device %s,netdev=3D" NETNAME, test-=
>model);
> +    if (!extra) {
> +        extra =3D defextra;
> +    }

I'd be nicer to do the g_strdup_printf() only if it is really necessary,
e.g.:

    const char *extra =3D test->extra;

    if (!extra) {
        extra =3D g_strdup_printf(...);
    }

> -    args =3D g_strdup_printf("-machine accel=3Dkvm:tcg -nodefaults -bo=
ot order=3Dn "
> -                           "-netdev user,id=3D" NETNAME ",tftp=3D./,bo=
otfile=3D%s,"
> -                           "ipv4=3D%s,ipv6=3D%s %s", disk, ipv6 ? "off=
" : "on",
> -                           ipv6 ? "on" : "off", params);
> +    args =3D g_strdup_printf(
> +        "-machine %s,accel=3Dkvm:tcg -nodefaults -boot order=3Dn "
> +        "-netdev user,id=3D" NETNAME ",tftp=3D./,bootfile=3D%s,ipv4=3D=
%s,ipv6=3D%s %s",
> +        test->machine, disk, ipv6 ? "off" : "on", ipv6 ? "on" : "off",=
 extra);
> =20
>      qtest_start(args);
>      boot_sector_test();
>      qtest_quit(global_qtest);
>      g_free(args);
> +    g_free(defextra);

... and then:

    if (!test->extra) {
        g_free(extra);
    }

>  }
> =20
>  static void test_pxe_ipv4(gconstpointer data)
>  {
> -    const char *model =3D data;
> -    char *dev_arg;
> +    const testdef_t *test =3D data;
> +
> +    test_pxe_one(test, false);
> +}
> =20
> -    dev_arg =3D g_strdup_printf("-device %s,netdev=3D" NETNAME, model)=
;
> -    test_pxe_one(dev_arg, false);
> -    g_free(dev_arg);
> +static void test_batch(const testdef_t *tests)
> +{
> +    int i;
> +
> +    for (i =3D 0; tests[i].machine; i++) {
> +        const testdef_t *test =3D &tests[i];
> +        char *testname;
> +
> +        testname =3D g_strdup_printf("pxe/ipv4/%s/%s",
> +                                   test->machine, test->model);
> +        qtest_add_data_func(testname, test, test_pxe_ipv4);
> +        g_free(testname);
> +    }
>  }
> =20
>  int main(int argc, char *argv[])
> @@ -59,24 +116,17 @@ int main(int argc, char *argv[])
>      g_test_init(&argc, &argv, NULL);
> =20
>      if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D=
 0) {
> -        qtest_add_data_func("pxe/e1000", "e1000", test_pxe_ipv4);
> -        qtest_add_data_func("pxe/virtio", "virtio-net-pci", test_pxe_i=
pv4);
> +        test_batch(x86_tests);
>          if (g_test_slow()) {
> -            qtest_add_data_func("pxe/ne2000", "ne2k_pci", test_pxe_ipv=
4);
> -            qtest_add_data_func("pxe/eepro100", "i82550", test_pxe_ipv=
4);
> -            qtest_add_data_func("pxe/pcnet", "pcnet", test_pxe_ipv4);
> -            qtest_add_data_func("pxe/rtl8139", "rtl8139", test_pxe_ipv=
4);
> -            qtest_add_data_func("pxe/vmxnet3", "vmxnet3", test_pxe_ipv=
4);
> +            test_batch(x86_tests_slow);
>          }
>      } else if (strcmp(arch, "ppc64") =3D=3D 0) {
> -        qtest_add_data_func("pxe/spapr-vlan", "spapr-vlan", test_pxe_i=
pv4);
> +        test_batch(ppc64_tests);
>          if (g_test_slow()) {
> -            qtest_add_data_func("pxe/virtio", "virtio-net-pci", test_p=
xe_ipv4);
> -            qtest_add_data_func("pxe/e1000", "e1000", test_pxe_ipv4);
> +            test_batch(ppc64_tests_slow);
>          }
>      } else if (g_str_equal(arch, "s390x")) {
> -        qtest_add_data_func("pxe/virtio-ccw",
> -                            "virtio-net-ccw,bootindex=3D1", test_pxe_i=
pv4);
> +        test_batch(s390x_tests);
>      }
>      ret =3D g_test_run();
>      boot_sector_cleanup(disk);
>=20

 Thomas
