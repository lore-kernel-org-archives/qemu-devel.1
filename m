Received: from eggs.gnu.org ([2001:4830:134:3::10]:38666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVdmG-0006PT-NR
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVdmF-0004pF-Do
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:08:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fVdmF-0004om-8H
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:08:03 -0400
Date: Wed, 20 Jun 2018 17:08:00 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180620170330-mutt-send-email-mst@kernel.org>
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180515121433.6112-4-marcandre.lureau@redhat.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, May 15, 2018 at 02:14:32PM +0200, Marc-Andr=E9 Lureau wrote:
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>=20
> The TPM Physical Presence interface consists of an ACPI part, a shared
> memory part, and code in the firmware. Users can send messages to the
> firmware by writing a code into the shared memory through invoking the
> ACPI code. When a reboot happens, the firmware looks for the code and
> acts on it by sending sequences of commands to the TPM.
>=20
> This patch adds the ACPI code. It is similar to the one in EDK2 but doe=
sn't
> assume that SMIs are necessary to use. It uses a similar datastructure =
for
> the shared memory as EDK2 does so that EDK2 and SeaBIOS could both make=
 use
> of it. I extended the shared memory data structure with an array of 256
> bytes, one for each code that could be implemented. The array contains
> flags describing the individual codes. This decouples the ACPI implemen=
tation
> from the firmware implementation.
>=20
> The underlying TCG specification is accessible from the following page.
>=20
> https://trustedcomputinggroup.org/tcg-physical-presence-interface-speci=
fication/
>=20
> This patch implements version 1.30.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>=20
> ---
>=20
> v4 (Marc-Andr=E9):
>  - replace 'DerefOf (FUNC [N])' with a function, to fix Windows ACPI
>     handling.
>  - replace 'return Package (..) {} ' with scoped variables, to fix
>    Windows ACPI handling.
>=20
> v3:
>  - add support for PPI to CRB
>  - split up OperationRegion TPPI into two parts, one containing
>    the registers (TPP1) and the other one the flags (TPP2); switched
>    the order of the flags versus registers in the code
>  - adapted ACPI code to small changes to the array of flags where
>    previous flag 0 was removed and now shifting right wasn't always
>    necessary anymore
>=20
> v2:
>  - get rid of FAIL variable; function 5 was using it and always
>    returns 0; the value is related to the ACPI function call not
>    a possible failure of the TPM function call.
>  - extend shared memory data structure with per-opcode entries
>    holding flags and use those flags to determine what to return
>    to caller
>  - implement interface version 1.3
> ---
>  include/hw/acpi/tpm.h |  21 +++
>  hw/i386/acpi-build.c  | 294 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 314 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index f79d68a77a..fc53f08827 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -196,4 +196,25 @@ REG32(CRB_DATA_BUFFER, 0x80)
>  #define TPM_PPI_VERSION_NONE        0
>  #define TPM_PPI_VERSION_1_30        1
> =20
> +struct tpm_ppi {

The name violate the coding style.


> +    uint8_t  func[256];      /* 0x000: per TPM function implementation=
 flags;
> +                                       set by BIOS */
> +/* whether function is blocked by BIOS settings; bits 0, 1, 2 */
> +#define TPM_PPI_FUNC_NOT_IMPLEMENTED     (0 << 0)
> +#define TPM_PPI_FUNC_BIOS_ONLY           (1 << 0)
> +#define TPM_PPI_FUNC_BLOCKED             (2 << 0)
> +#define TPM_PPI_FUNC_ALLOWED_USR_REQ     (3 << 0)
> +#define TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 0)
> +#define TPM_PPI_FUNC_MASK                (7 << 0)
> +    uint8_t ppin;            /* 0x100 : set by BIOS */

Are you sure it's right? Below ints will all end up misaligned ...

> +    uint32_t ppip;           /* 0x101 : set by ACPI; not used */
> +    uint32_t pprp;           /* 0x105 : response from TPM; set by BIOS=
 */
> +    uint32_t pprq;           /* 0x109 : opcode; set by ACPI */
> +    uint32_t pprm;           /* 0x10d : parameter for opcode; set by A=
CPI */
> +    uint32_t lppr;           /* 0x111 : last opcode; set by BIOS */
> +    uint32_t fret;           /* 0x115 : set by ACPI; not used */
> +    uint8_t res1[0x40];      /* 0x119 : reserved for future use */
> +    uint8_t next_step;       /* 0x159 : next step after reboot; set by=
 BIOS */
> +} QEMU_PACKED;
> +
>  #endif /* HW_ACPI_TPM_H */

Igor could you pls take a quick look at the rest?

--=20
MST
