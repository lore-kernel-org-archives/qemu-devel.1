Received: from eggs.gnu.org ([209.51.188.92]:34391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj3fR-0002hQ-0w
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj3fP-0003CV-Og
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:56:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gj3fP-0003Aj-DL
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:56:43 -0500
Date: Mon, 14 Jan 2019 09:47:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114094746-mutt-send-email-mst@kernel.org>
References: <20190109193115.20655-1-marcandre.lureau@redhat.com>
	<20190109193115.20655-6-marcandre.lureau@redhat.com>
	<20190114111735.531c4cca@redhat.com>
	<CAMxuvaxyPdZtgWPXHwzzeJqaojBzjq3tKfw-kyow5eX_jCLfNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAMxuvaxyPdZtgWPXHwzzeJqaojBzjq3tKfw-kyow5eX_jCLfNw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v16 5/6] acpi: add ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, =?iso-8859-1?Q?Mathieu-Daud=E9=2C?= Philippe <f4bug@amsat.org>, Stefan Berger <stefanb@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On Mon, Jan 14, 2019 at 02:23:16PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Mon, Jan 14, 2019 at 2:17 PM Igor Mammedov <imammedo@redhat.com> wro=
te:
> >
> > On Wed,  9 Jan 2019 23:31:14 +0400
> > Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com> wrote:
> >
> > > The interface is described in the "TCG Platform Reset Attack
> > > Mitigation Specification", chapter 6 "ACPI _DSM Function". Accordin=
g
> > I'd add a spec version here as well adn maybe a link like it's
> > in 4/6 (but links are often go stale so it's not must have, just name
> > and version should be sufficient to find the spec)
> >
> > > to Laszlo, it's not so easy to implement in OVMF, he suggested to d=
o
> > > it in qemu instead.
> > >
> > > See specification documentation for more details, and next commit f=
or
> > > memory clear on reset handling.
> > >
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> > With commit amended
> >
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>=20
> Specification Version 1.00
> https://www.trustedcomputinggroup.org/wp-content/uploads/Platform-Reset=
-Attack-Mitigation-Specification.pdf
>=20
> Michael, do you need me to resend the series or can you update the
> commit message?
>=20
> thanks

Pls resend in a ready form.
Thanks!

> >
> > > ---
> > >  hw/acpi/tpm.c      | 55 ++++++++++++++++++++++++++++++++++++++++++=
++++
> > >  docs/specs/tpm.txt |  2 ++
> > >  2 files changed, 57 insertions(+)
> > >
> > > diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
> > > index 9f205378f2..b96459e45b 100644
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
> > > +                           0x1));
> > > +    field =3D aml_field("TPP3", AML_BYTE_ACC, AML_NOLOCK, AML_PRES=
ERVE);
> > > +    aml_append(field, aml_named_field("MOVV", 8));
> > > +    aml_append(dev, field);
> > > +
> > >      /*
> > >       * DerefOf in Windows is broken with SYSTEM_MEMORY.  Use a dyn=
amic
> > >       * operation region inside of a method for getting FUNC[op].
> > > @@ -399,6 +409,51 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
> > >              aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)))=
;
> > >          }
> > >          aml_append(method, ifctx);
> > > +
> > > +        /*
> > > +         * "TCG Platform Reset Attack Mitigation Specification 1.0=
0",
> > > +         * Chapter 6 "ACPI _DSM Function"
> > > +         */
> > > +        ifctx =3D aml_if(
> > > +            aml_equal(uuid,
> > > +                      aml_touuid("376054ED-CC13-4675-901C-4756D7F2=
D45D")));
> > > +        {
> > > +            /* standard DSM query function */
> > > +            ifctx2 =3D aml_if(aml_equal(function, zero));
> > > +            {
> > > +                uint8_t byte_list[1] =3D { 0x03 }; /* functions 1-=
2 supported */
> > > +
> > > +                aml_append(ifctx2,
> > > +                           aml_return(aml_buffer(sizeof(byte_list)=
,
> > > +                                                 byte_list)));
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
> >
