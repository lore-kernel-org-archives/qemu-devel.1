Received: from eggs.gnu.org ([2001:4830:134:3::10]:41669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1df5oH-0007oP-7D
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1df5oG-0001Dk-38
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40027)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1df5oF-0001D7-TN
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:48:40 -0400
References: <1501964858-5159-1-git-send-email-zuban32s@gmail.com>
	<1501964858-5159-2-git-send-email-zuban32s@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8893f281-e30d-d1c6-3da0-14a644da5a03@redhat.com>
Date: Tue, 8 Aug 2017 16:48:26 +0200
MIME-Version: 1.0
In-Reply-To: <1501964858-5159-2-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] acpi-test: Warning! DSDT mismatch (was: [PATCH v4 1/5]
 hw/i386: allow SHPC for Q35 machine)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: Aleksandr Bezzubikov <zuban32s@gmail.com>, ehabkost@redhat.com, kevin@koconnor.net, pbonzini@redhat.com, marcel@redhat.com, imammedo@redhat.com, lersek@redhat.com, Peter Maydell <peter.maydell@linaro.org>

On 05.08.2017 22:27, Aleksandr Bezzubikov wrote:
> Unmask previously masked SHPC feature in _OSC method.
>=20
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  hw/i386/acpi-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b9c245c..98dd424 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1862,9 +1862,9 @@ static Aml *build_q35_osc_method(void)
> =20
>      /*
>       * Always allow native PME, AER (no dependencies)
> -     * Never allow SHPC (no SHPC controller in this system)
> +     * Allow SHPC (PCI bridges can have SHPC controller)
>       */
> -    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1D), a_ctrl));
> +    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
> =20
>      if_ctx2 =3D aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
>      /* Unknown revision */
>=20

Since this patch has been merged, I now get a bunch of ugly warnings
during "make check":

acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-T2ST4Y.dsl,
aml:/tmp/aml-HVUT4Y], Expected [asl:/tmp/asl-00VT4Y.dsl,
aml:tests/acpi-test-data/q35/DSDT].
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-3BKN4Y.dsl,
aml:/tmp/aml-CDKN4Y], Expected [asl:/tmp/asl-2CZM4Y.dsl,
aml:tests/acpi-test-data/q35/DSDT.bridge].
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-ZVPA4Y.dsl,
aml:/tmp/aml-A3PA4Y], Expected [asl:/tmp/asl-F0QA4Y.dsl,
aml:tests/acpi-test-data/q35/DSDT.ipmibt].
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-TX7P4Y.dsl,
aml:/tmp/aml-S97P4Y], Expected [asl:/tmp/asl-AIJP4Y.dsl,
aml:tests/acpi-test-data/q35/DSDT.cphp].
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-6J0C4Y.dsl,
aml:/tmp/aml-DCZC4Y], Expected [asl:/tmp/asl-9I1C4Y.dsl,
aml:tests/acpi-test-data/q35/DSDT.memhp].

Did you maybe forget to update the ACPI test table according to the
changes? (and why was this merged during hard-freeze at all? The
ChangeLog text does not sound like a bug fix?)

 Thomas
