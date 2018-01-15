Received: from eggs.gnu.org ([2001:4830:134:3::10]:43459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eb5nl-0001kU-Mx
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eb5ng-0008Ig-QN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:31:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eb5ng-0008GI-LE
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:31:48 -0500
Date: Mon, 15 Jan 2018 15:31:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180115153137.32432502@redhat.com>
In-Reply-To: <93fd6ae0-ab03-3e4a-cb85-26ab492e0f79@linux.vnet.ibm.com>
References: <1515609318-1897-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1515609318-1897-3-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CJwt+txMjY1AtCRF0_FzkgAm_qv8_itHUwnWD9s_Oucqg@mail.gmail.com>
	<93fd6ae0-ab03-3e4a-cb85-26ab492e0f79@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] acpi: implement aml_lless_equal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>, kevin@koconnor.net, QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 12 Jan 2018 14:42:14 -0500
Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:

> On 01/12/2018 10:17 AM, Marc-Andr=C3=A9 Lureau wrote:
> > 2018-01-10 19:35 GMT+01:00 Stefan Berger <stefanb@linux.vnet.ibm.com>: =
=20
> >> LLessEqualOp =3D LNotOp LGreaterOp
> >>
> >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com> =20
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> =20
>=20
> Thanks. I added a comment line above the function now:
>=20
> /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLLessEqual */

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> >
> > =20
> >> ---
> >>   hw/acpi/aml-build.c         | 10 ++++++++++
> >>   include/hw/acpi/aml-build.h |  1 +
> >>   2 files changed, 11 insertions(+)
> >>
> >> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> >> index 36a6cc4..597a58d 100644
> >> --- a/hw/acpi/aml-build.c
> >> +++ b/hw/acpi/aml-build.c
> >> @@ -568,6 +568,16 @@ Aml *aml_lless(Aml *arg1, Aml *arg2)
> >>       return var;
> >>   }
> >>
> >> +Aml *aml_lless_equal(Aml *arg1, Aml *arg2)
> >> +{
> >> +    /* LLessEqualOp :=3D LNotOp LGreaterOp */
> >> +    Aml *var =3D aml_opcode(0x92 /* LNotOp */);
> >> +    build_append_byte(var->buf, 0x94 /* LGreaterOp */);
> >> +    aml_append(var, arg1);
> >> +    aml_append(var, arg2);
> >> +    return var;
> >> +}
> >> +
> >>   /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefAdd */
> >>   Aml *aml_add(Aml *arg1, Aml *arg2, Aml *dst)
> >>   {
> >> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> >> index 88d0738..c4398cc 100644
> >> --- a/include/hw/acpi/aml-build.h
> >> +++ b/include/hw/acpi/aml-build.h
> >> @@ -267,6 +267,7 @@ Aml *aml_lor(Aml *arg1, Aml *arg2);
> >>   Aml *aml_shiftleft(Aml *arg1, Aml *count);
> >>   Aml *aml_shiftright(Aml *arg1, Aml *count, Aml *dst);
> >>   Aml *aml_lless(Aml *arg1, Aml *arg2);
> >> +Aml *aml_lless_equal(Aml *arg1, Aml *arg2);
> >>   Aml *aml_add(Aml *arg1, Aml *arg2, Aml *dst);
> >>   Aml *aml_subtract(Aml *arg1, Aml *arg2, Aml *dst);
> >>   Aml *aml_increment(Aml *arg);
> >> --
> >> 2.5.5
> >>
> >> =20
> >
> > =20
>=20
>=20
