Received: from eggs.gnu.org ([2001:4830:134:3::10]:59520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fWMJ2-0005sd-67
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fWMIy-0002t2-93
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:40:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35564 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fWMIy-0002s0-3Q
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:40:48 -0400
Date: Fri, 22 Jun 2018 15:40:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180622154044.75982643@redhat.com>
In-Reply-To: <CAJ+F1CLHtrx0hC9AUQ_JvvGGMx5D-X6=hy3A1c+MC0P-5Q3QAg@mail.gmail.com>
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-4-marcandre.lureau@redhat.com>
	<20180621145405.197d5106@redhat.com>
	<CAJ+F1CKFq5=Afoqg8YZGw-TO8vJqTPwjpW_UAMh6G8LPp4ZztA@mail.gmail.com>
	<20180621162333.293f1a2c@redhat.com>
	<CAJ+F1CLHtrx0hC9AUQ_JvvGGMx5D-X6=hy3A1c+MC0P-5Q3QAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] acpi: build TPM Physical Presence
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 21 Jun 2018 19:10:38 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Thu, Jun 21, 2018 at 4:23 PM, Igor Mammedov <imammedo@redhat.com> wrot=
e:
> > On Thu, 21 Jun 2018 15:21:02 +0200
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> > =20
> >> Hi
> >>
> >> On Thu, Jun 21, 2018 at 2:54 PM, Igor Mammedov <imammedo@redhat.com> w=
rote: =20
> >> > On Tue, 15 May 2018 14:14:32 +0200
> >> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> >> > =20
> >> >> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >> >>
> >> >> The TPM Physical Presence interface consists of an ACPI part, a sha=
red
> >> >> memory part, and code in the firmware. Users can send messages to t=
he
> >> >> firmware by writing a code into the shared memory through invoking =
the
> >> >> ACPI code. When a reboot happens, the firmware looks for the code a=
nd
> >> >> acts on it by sending sequences of commands to the TPM.
> >> >>
> >> >> This patch adds the ACPI code. It is similar to the one in EDK2 but=
 doesn't
> >> >> assume that SMIs are necessary to use. It uses a similar datastruct=
ure for
> >> >> the shared memory as EDK2 does so that EDK2 and SeaBIOS could both =
make use
> >> >> of it. I extended the shared memory data structure with an array of=
 256
> >> >> bytes, one for each code that could be implemented. The array conta=
ins
> >> >> flags describing the individual codes. This decouples the ACPI impl=
ementation
> >> >> from the firmware implementation.
> >> >>
> >> >> The underlying TCG specification is accessible from the following p=
age.
> >> >>
> >> >> https://trustedcomputinggroup.org/tcg-physical-presence-interface-s=
pecification/
> >> >>
> >> >> This patch implements version 1.30.
> >> >>
> >> >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >> >>
> >> >> ---
> >> >>
> >> >> v4 (Marc-Andr=C3=A9):
> >> >>  - replace 'DerefOf (FUNC [N])' with a function, to fix Windows ACPI
> >> >>     handling.
> >> >>  - replace 'return Package (..) {} ' with scoped variables, to fix
> >> >>    Windows ACPI handling.
> >> >>
> >> >> v3:
> >> >>  - add support for PPI to CRB
> >> >>  - split up OperationRegion TPPI into two parts, one containing
> >> >>    the registers (TPP1) and the other one the flags (TPP2); switched
> >> >>    the order of the flags versus registers in the code
> >> >>  - adapted ACPI code to small changes to the array of flags where
> >> >>    previous flag 0 was removed and now shifting right wasn't always
> >> >>    necessary anymore
> >> >>
> >> >> v2:
> >> >>  - get rid of FAIL variable; function 5 was using it and always
> >> >>    returns 0; the value is related to the ACPI function call not
> >> >>    a possible failure of the TPM function call.
> >> >>  - extend shared memory data structure with per-opcode entries
> >> >>    holding flags and use those flags to determine what to return
> >> >>    to caller
> >> >>  - implement interface version 1.3
> >> >> ---
> >> >>  include/hw/acpi/tpm.h |  21 +++
> >> >>  hw/i386/acpi-build.c  | 294 ++++++++++++++++++++++++++++++++++++++=
+++-
> >> >>  2 files changed, 314 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> >> >> index f79d68a77a..fc53f08827 100644
> >> >> --- a/include/hw/acpi/tpm.h
> >> >> +++ b/include/hw/acpi/tpm.h
> >> >> @@ -196,4 +196,25 @@ REG32(CRB_DATA_BUFFER, 0x80)
> >> >>  #define TPM_PPI_VERSION_NONE        0
> >> >>  #define TPM_PPI_VERSION_1_30        1
> >> >>
> >> >> +struct tpm_ppi {
> >> >> +    uint8_t  func[256];      /* 0x000: per TPM function implementa=
tion flags;
> >> >> +                                       set by BIOS */
> >> >> +/* whether function is blocked by BIOS settings; bits 0, 1, 2 */
> >> >> +#define TPM_PPI_FUNC_NOT_IMPLEMENTED     (0 << 0)
> >> >> +#define TPM_PPI_FUNC_BIOS_ONLY           (1 << 0)
> >> >> +#define TPM_PPI_FUNC_BLOCKED             (2 << 0)
> >> >> +#define TPM_PPI_FUNC_ALLOWED_USR_REQ     (3 << 0)
> >> >> +#define TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 0)
> >> >> +#define TPM_PPI_FUNC_MASK                (7 << 0)
> >> >> +    uint8_t ppin;            /* 0x100 : set by BIOS */
> >> >> +    uint32_t ppip;           /* 0x101 : set by ACPI; not used */
> >> >> +    uint32_t pprp;           /* 0x105 : response from TPM; set by =
BIOS */
> >> >> +    uint32_t pprq;           /* 0x109 : opcode; set by ACPI */
> >> >> +    uint32_t pprm;           /* 0x10d : parameter for opcode; set =
by ACPI */
> >> >> +    uint32_t lppr;           /* 0x111 : last opcode; set by BIOS */
> >> >> +    uint32_t fret;           /* 0x115 : set by ACPI; not used */
> >> >> +    uint8_t res1[0x40];      /* 0x119 : reserved for future use */
> >> >> +    uint8_t next_step;       /* 0x159 : next step after reboot; se=
t by BIOS */
> >> >> +} QEMU_PACKED; =20
> >> > is this structure plant to be used for accessing data from within QE=
MU
> >> > or it is just used for convenience of calculating offsets/sizes for =
AML?
> >> >
> >> > =20
> >>
> >> For convenience (and it can be useful for debugging). =20
> > we are gradually getting rid of usage "struct foo" in ACPI code
> > (i.e. when I have time to convert old struct based approach
> > to build_append_int() table based format).
> > and for new code I usually require ACPI parts be struct less
> > (if there is no previous struct baggage to back it up).
> > =20
>=20
> The tpm_ppi struct is not an ACPI table, it's a fixed memory region /
> layout to exchange between guest/os and firmware.
it's interface between ACPI and firmware and it's used in ACPI
parts of code (mainly as means to document layout). I wouldn't care
much if it were buried inside of TPM code, but it's used mainly as
dummy struct for documenting and by ACPI parts of code for an implicit
sizing math, for that I'd like you to use spec/constants like any
other new ACPI code does.
So lets keep things consistent here at least for ACPI parts that
I maintain.

=20
> > Hence my request to drop dummy struct and document layout
> > properly in related spec doc (that's where FW should look for
> > documentation and not into struct definition somewhere in
> > the header). So I'd strongly prefer it be done this way. =20
>=20
> There is not much more than the field description for me ;). Stefan,
> would you like to develop the structure usage?
You should use table format to document ACPI interface in spec
(ex: docs/specs/acpi_mem_hotplug.txt) at least for consistence sake.
I don't care that firmware side uses C code as documentation as
it's up whatever maintainers prefer over there.
=20
[...]
