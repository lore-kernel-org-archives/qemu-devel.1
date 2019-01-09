Received: from eggs.gnu.org ([209.51.188.92]:56019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghFHA-000268-SB
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghFH9-0007W0-UY
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:56:12 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ghFH9-0007UV-NT
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:56:11 -0500
Received: by mail-wm1-x342.google.com with SMTP id m22so8596944wml.3
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 06:56:11 -0800 (PST)
MIME-Version: 1.0
References: <20190109082902.32271-1-marcandre.lureau@redhat.com>
	<20190109082902.32271-6-marcandre.lureau@redhat.com>
	<20190109093518-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190109093518-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 9 Jan 2019 18:55:56 +0400
Message-ID: <CAJ+F1CKTwO3zT+raRcEfuVPJz-5iVH8WkFDdSmNtkQZR45JorA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>

Hi

On Wed, Jan 9, 2019 at 6:47 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jan 09, 2019 at 12:29:01PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > The interface is described in the "TCG Platform Reset Attack
> > Mitigation Specification", chapter 6 "ACPI _DSM Function". According
> > to Laszlo, it's not so easy to implement in OVMF, he suggested to do
> > it in qemu instead.
> >
> > See specification documentation for more details, and next commit for
> > memory clear on reset handling.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/acpi/tpm.c      | 48 ++++++++++++++++++++++++++++++++++++++++++++++
> >  docs/specs/tpm.txt |  2 ++
> >  2 files changed, 50 insertions(+)
> >
> > diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
> > index fee9490306..61da1de97b 100644
> > --- a/hw/acpi/tpm.c
> > +++ b/hw/acpi/tpm.c
> > @@ -53,6 +53,16 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
> >      pprq =3D aml_name("PPRQ");
> >      pprm =3D aml_name("PPRM");
> >
> > +    aml_append(dev,
> > +               aml_operation_region(
> > +                   "TPP3", AML_SYSTEM_MEMORY,
> > +                   aml_int(TPM_PPI_ADDR_BASE +
> > +                           0x15a /* movv, docs/specs/tpm.txt */),
> > +                           0x1
> > ));
> > +    field =3D aml_field("TPP3", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE=
);
> > +    aml_append(field, aml_named_field("MOVV", 8));
> > +    aml_append(dev, field);
> > +
> >      /*
> >       * DerefOf in Windows is broken with SYSTEM_MEMORY.  Use a dynamic
> >       * operation region inside of a method for getting FUNC[op].
> > @@ -395,6 +405,44 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
> >              aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
> >          }
> >          aml_append(method, ifctx);
> > +
> > +        ifctx =3D aml_if(
> > +            aml_equal(uuid,
> > +                      aml_touuid("376054ED-CC13-4675-901C-4756D7F2D45D=
")));
> > +        {
> > +            /* standard DSM query function */
>
> refer to spec chapter here?

Yes, we could add a code comment such as:
/* "TCG Platform Reset Attack Mitigation Specification", chapter 6
"ACPI _DSM Function" */


>
> > +            ifctx2 =3D aml_if(aml_equal(function, zero));
> > +            {
> > +                uint8_t byte_list[1] =3D { 0x03 };
>
> and explain 3 above?

/* functions 1-2 are supported */

>
> > +                aml_append(ifctx2, aml_return(aml_buffer(1
>
> 1 -> sizeof(byte_list)?

ok

>
> > + , byte_list)));
> > +            }
> > +            aml_append(ifctx, ifctx2);
> > +
> > +            /*
> > +             * TCG Platform Reset Attack Mitigation Specification 1.0 =
Ch.6
> > +             *
> > +             * Arg 2 (Integer): Function Index =3D 1
> > +             * Arg 3 (Package): Arguments =3D Package: Type: Integer
> > +             *                  Operation Value of the Request
> > +             * Returns: Type: Integer
> > +             *          0: Success
> > +             *          1: General Failure
> > +             */
> > +            ifctx2 =3D aml_if(aml_equal(function, one));
> > +            {
> > +                aml_append(ifctx2,
> > +                           aml_store(aml_derefof(aml_index(arguments, =
zero)),
> > +                                     op));
> > +                {
> > +                    aml_append(ifctx2, aml_store(op, aml_name("MOVV"))=
);
> > +
> > +                    /* 0: success */
> > +                    aml_append(ifctx2, aml_return(zero));
> > +                }
> > +            }
> > +            aml_append(ifctx, ifctx2);
> > +        }
> > +        aml_append(method, ifctx);
> >      }
> >      aml_append(dev, method);
> >  }
> > diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> > index 424d1511fc..5d8c26b1ad 100644
> > --- a/docs/specs/tpm.txt
> > +++ b/docs/specs/tpm.txt
> > @@ -135,6 +135,8 @@ layout:
> >   +----------+--------+--------+---------------------------------------=
----+
> >   | next_step|   0x1  |  0x159 | Operation to execute after reboot by  =
    |
> >   |          |        |        | firmware. Used by firmware.           =
    |
> > + +----------+--------+--------+---------------------------------------=
----+
> > + | movv     |   0x1  |  0x15a | Memory overwrite variable             =
    |
> >   +----------+--------+--------+---------------------------------------=
----+
> >
> >     The following values are supported for the 'func' field. They corre=
spond
> > --
> > 2.20.1.2.gb21ebb671b
>


--=20
Marc-Andr=C3=A9 Lureau
