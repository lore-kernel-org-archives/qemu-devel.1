Received: from eggs.gnu.org ([2001:4830:134:3::10]:47644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fXnAk-0002TK-02
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fXnAe-0004mw-4S
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:34:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fXnAd-0004mn-VR
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:34:08 -0400
Date: Tue, 26 Jun 2018 14:34:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180626143404.2ee79c69@redhat.com>
In-Reply-To: <CAJ+F1C+pYQ-7e-8KqNNwRb4Jtq_HmZUowtiGPjFWV7AE3JL_TA@mail.gmail.com>
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-5-marcandre.lureau@redhat.com>
	<20180621150203.2c985ed2@redhat.com>
	<CAJ+F1CJHraqeM2q5G-ooVfp771r_K4g=osJG=J6PTH4aV0BprQ@mail.gmail.com>
	<20180621163335.19010217@redhat.com>
	<CAJ+F1C+pYQ-7e-8KqNNwRb4Jtq_HmZUowtiGPjFWV7AE3JL_TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] tpm: add a fake ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 26 Jun 2018 11:22:26 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> On Thu, Jun 21, 2018 at 4:33 PM, Igor Mammedov <imammedo@redhat.com> wrot=
e:
> > On Thu, 21 Jun 2018 15:24:44 +0200
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> > =20
> >> Hi
> >>
> >> On Thu, Jun 21, 2018 at 3:02 PM, Igor Mammedov <imammedo@redhat.com> w=
rote: =20
> >> > On Tue, 15 May 2018 14:14:33 +0200
> >> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> >> > =20
> >> >> This allows to pass the last failing test from the Windows HLK TPM =
2.0
> >> >> TCG PPI 1.3 tests.
> >> >>
> >> >> The interface is described in the "TCG Platform Reset Attack
> >> >> Mitigation Specification", chapter 6 "ACPI _DSM Function". Whether =
or
> >> >> not we should have a real implementation remains an open question t=
o me. =20
> >> > might it cause security issues? =20
> >>
> >> Good question. If the guest assumes success of this operation perhaps.
> >> I'll check the spec.
> >> =20
> >> > What are implications of faking it and how hard it's to implement th=
ing
> >> > per spec? =20
> >>
> >> Laszlo answerd that in "[Qemu-devel] investigating TPM for
> >> OVMF-on-QEMU"  2f2b) TCG Memory Clear Interface =20
> > I get that it's optional, but we probably shouldn't advertise/fake
> > feature if it's not supported. =20
>=20
> As said in the commit message, the objective was to pass the Windows
> HLK test. If we don't want to advertize a fake interface, I am fine
> droping this patch. We'll have to revisit with Laszlo the work needed
> in the firmware to support it.
I think it would be safer to drop this patch.


> > =20
> >> =20
> >> >
> >> > =20
> >> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> >> ---
> >> >>  hw/i386/acpi-build.c | 9 +++++++++
> >> >>  1 file changed, 9 insertions(+)
> >> >>
> >> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> >> index 95be4f0710..392a1e50bd 100644
> >> >> --- a/hw/i386/acpi-build.c
> >> >> +++ b/hw/i386/acpi-build.c
> >> >> @@ -2072,6 +2072,15 @@ build_tpm_ppi(Aml *dev)
> >> >>              aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
> >> >>          }
> >> >>          aml_append(method, ifctx);
> >> >> +
> >> >> +       /* dummy MOR Memory Clear for the sake of WLK PPI test */
> >> >> +        ifctx =3D aml_if(
> >> >> +            aml_equal(aml_arg(0),
> >> >> +                      aml_touuid("376054ED-CC13-4675-901C-4756D7F2=
D45D")));
> >> >> +        {
> >> >> +            aml_append(ifctx, aml_return(aml_int(0)));
> >> >> +        }
> >> >> +        aml_append(method, ifctx);
> >> >>      }
> >> >>      aml_append(dev, method);
> >> >>  } =20
> >> >
> >> > =20
> >>
> >>
> >> =20
> > =20
>=20
>=20
>=20
