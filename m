Received: from eggs.gnu.org ([2001:4830:134:3::10]:38090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fXkBB-0004th-Rw
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fXkBA-00022A-UO
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:22:29 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fXkBA-00021w-L1
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:22:28 -0400
Received: by mail-wm0-x243.google.com with SMTP id w137-v6so1041612wmw.1
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 02:22:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621163335.19010217@redhat.com>
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-5-marcandre.lureau@redhat.com>
	<20180621150203.2c985ed2@redhat.com>
	<CAJ+F1CJHraqeM2q5G-ooVfp771r_K4g=osJG=J6PTH4aV0BprQ@mail.gmail.com>
	<20180621163335.19010217@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Jun 2018 11:22:26 +0200
Message-ID: <CAJ+F1C+pYQ-7e-8KqNNwRb4Jtq_HmZUowtiGPjFWV7AE3JL_TA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jun 21, 2018 at 4:33 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Thu, 21 Jun 2018 15:24:44 +0200
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>
>> Hi
>>
>> On Thu, Jun 21, 2018 at 3:02 PM, Igor Mammedov <imammedo@redhat.com> wro=
te:
>> > On Tue, 15 May 2018 14:14:33 +0200
>> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>> >
>> >> This allows to pass the last failing test from the Windows HLK TPM 2.=
0
>> >> TCG PPI 1.3 tests.
>> >>
>> >> The interface is described in the "TCG Platform Reset Attack
>> >> Mitigation Specification", chapter 6 "ACPI _DSM Function". Whether or
>> >> not we should have a real implementation remains an open question to =
me.
>> > might it cause security issues?
>>
>> Good question. If the guest assumes success of this operation perhaps.
>> I'll check the spec.
>>
>> > What are implications of faking it and how hard it's to implement thin=
g
>> > per spec?
>>
>> Laszlo answerd that in "[Qemu-devel] investigating TPM for
>> OVMF-on-QEMU"  2f2b) TCG Memory Clear Interface
> I get that it's optional, but we probably shouldn't advertise/fake
> feature if it's not supported.

As said in the commit message, the objective was to pass the Windows
HLK test. If we don't want to advertize a fake interface, I am fine
droping this patch. We'll have to revisit with Laszlo the work needed
in the firmware to support it.

>
>>
>> >
>> >
>> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >> ---
>> >>  hw/i386/acpi-build.c | 9 +++++++++
>> >>  1 file changed, 9 insertions(+)
>> >>
>> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> >> index 95be4f0710..392a1e50bd 100644
>> >> --- a/hw/i386/acpi-build.c
>> >> +++ b/hw/i386/acpi-build.c
>> >> @@ -2072,6 +2072,15 @@ build_tpm_ppi(Aml *dev)
>> >>              aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
>> >>          }
>> >>          aml_append(method, ifctx);
>> >> +
>> >> +       /* dummy MOR Memory Clear for the sake of WLK PPI test */
>> >> +        ifctx =3D aml_if(
>> >> +            aml_equal(aml_arg(0),
>> >> +                      aml_touuid("376054ED-CC13-4675-901C-4756D7F2D4=
5D")));
>> >> +        {
>> >> +            aml_append(ifctx, aml_return(aml_int(0)));
>> >> +        }
>> >> +        aml_append(method, ifctx);
>> >>      }
>> >>      aml_append(dev, method);
>> >>  }
>> >
>> >
>>
>>
>>
>



--=20
Marc-Andr=C3=A9 Lureau
