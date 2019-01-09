Received: from eggs.gnu.org ([209.51.188.92]:58323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ghFIZ-0003EN-4C
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ghFIY-0000Gc-0I
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:57:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22587)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ghFIX-0008Pb-DZ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:57:37 -0500
Date: Wed, 9 Jan 2019 09:57:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190109095652-mutt-send-email-mst@kernel.org>
References: <20190109082902.32271-1-marcandre.lureau@redhat.com>
	<20190109082902.32271-6-marcandre.lureau@redhat.com>
	<20190109093518-mutt-send-email-mst@kernel.org>
	<CAJ+F1CKTwO3zT+raRcEfuVPJz-5iVH8WkFDdSmNtkQZR45JorA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKTwO3zT+raRcEfuVPJz-5iVH8WkFDdSmNtkQZR45JorA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v15 5/6] acpi: add ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>

On Wed, Jan 09, 2019 at 06:55:56PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Wed, Jan 9, 2019 at 6:47 PM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> >
> > On Wed, Jan 09, 2019 at 12:29:01PM +0400, Marc-Andr=E9 Lureau wrote:
> > > The interface is described in the "TCG Platform Reset Attack
> > > Mitigation Specification", chapter 6 "ACPI _DSM Function". Accordin=
g
> > > to Laszlo, it's not so easy to implement in OVMF, he suggested to d=
o
> > > it in qemu instead.
> > >
> > > See specification documentation for more details, and next commit f=
or
> > > memory clear on reset handling.
> > >
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  hw/acpi/tpm.c      | 48 ++++++++++++++++++++++++++++++++++++++++++=
++++
> > >  docs/specs/tpm.txt |  2 ++
> > >  2 files changed, 50 insertions(+)
> > >
> > > diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
> > > index fee9490306..61da1de97b 100644
> > > --- a/hw/acpi/tpm.c
> > > +++ b/hw/acpi/tpm.c
> > > @@ -53,6 +53,16 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
> > >      pprq =3D aml_name("PPRQ");
> > >      pprm =3D aml_name("PPRM");
> > >
> > > +    aml_append(dev,
> > > +               aml_operation_region(
> > > +                   "TPP3", AML_SYSTEM_MEMORY,
> > > +                   aml_int(TPM_PPI_ADDR_BASE +
> > > +                           0x15a /* movv, docs/specs/tpm.txt */),
> > > +                           0x1
> > > ));
> > > +    field =3D aml_field("TPP3", AML_BYTE_ACC, AML_NOLOCK, AML_PRES=
ERVE);
> > > +    aml_append(field, aml_named_field("MOVV", 8));
> > > +    aml_append(dev, field);
> > > +
> > >      /*
> > >       * DerefOf in Windows is broken with SYSTEM_MEMORY.  Use a dyn=
amic
> > >       * operation region inside of a method for getting FUNC[op].
> > > @@ -395,6 +405,44 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
> > >              aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)))=
;
> > >          }
> > >          aml_append(method, ifctx);
> > > +
> > > +        ifctx =3D aml_if(
> > > +            aml_equal(uuid,
> > > +                      aml_touuid("376054ED-CC13-4675-901C-4756D7F2=
D45D")));
> > > +        {
> > > +            /* standard DSM query function */
> >
> > refer to spec chapter here?
>=20
> Yes, we could add a code comment such as:
> /* "TCG Platform Reset Attack Mitigation Specification", chapter 6
> "ACPI _DSM Function" */

You want to include the version as well.

>=20
> >
> > > +            ifctx2 =3D aml_if(aml_equal(function, zero));
> > > +            {
> > > +                uint8_t byte_list[1] =3D { 0x03 };
> >
> > and explain 3 above?
>=20
> /* functions 1-2 are supported */
>=20
> >
> > > +                aml_append(ifctx2, aml_return(aml_buffer(1
> >
> > 1 -> sizeof(byte_list)?
>=20
> ok
>=20
> >
> > > + , byte_list)));
> > > +            }
> > > +            aml_append(ifctx, ifctx2);
> > > +
> > > +            /*
> > > +             * TCG Platform Reset Attack Mitigation Specification =
1.0 Ch.6
> > > +             *
> > > +             * Arg 2 (Integer): Function Index =3D 1
> > > +             * Arg 3 (Package): Arguments =3D Package: Type: Integ=
er
> > > +             *                  Operation Value of the Request
> > > +             * Returns: Type: Integer
> > > +             *          0: Success
> > > +             *          1: General Failure
> > > +             */
> > > +            ifctx2 =3D aml_if(aml_equal(function, one));
> > > +            {
> > > +                aml_append(ifctx2,
> > > +                           aml_store(aml_derefof(aml_index(argumen=
ts, zero)),
> > > +                                     op));
> > > +                {
> > > +                    aml_append(ifctx2, aml_store(op, aml_name("MOV=
V")));
> > > +
> > > +                    /* 0: success */
> > > +                    aml_append(ifctx2, aml_return(zero));
> > > +                }
> > > +            }
> > > +            aml_append(ifctx, ifctx2);
> > > +        }
> > > +        aml_append(method, ifctx);
> > >      }
> > >      aml_append(dev, method);
> > >  }
> > > diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> > > index 424d1511fc..5d8c26b1ad 100644
> > > --- a/docs/specs/tpm.txt
> > > +++ b/docs/specs/tpm.txt
> > > @@ -135,6 +135,8 @@ layout:
> > >   +----------+--------+--------+-----------------------------------=
--------+
> > >   | next_step|   0x1  |  0x159 | Operation to execute after reboot =
by      |
> > >   |          |        |        | firmware. Used by firmware.       =
        |
> > > + +----------+--------+--------+-----------------------------------=
--------+
> > > + | movv     |   0x1  |  0x15a | Memory overwrite variable         =
        |
> > >   +----------+--------+--------+-----------------------------------=
--------+
> > >
> > >     The following values are supported for the 'func' field. They c=
orrespond
> > > --
> > > 2.20.1.2.gb21ebb671b
> >
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
