Received: from eggs.gnu.org ([2001:4830:134:3::10]:48088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1csSLZ-0004JO-J9
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1csSLW-0002YR-Hi
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:58:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1csSLW-0002YE-90
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:57:58 -0400
Date: Mon, 27 Mar 2017 11:57:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170327105751.GA26900@stefanha-x1.localdomain>
References: <1490609953-5076-1-git-send-email-tejaswinipoluri3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <1490609953-5076-1-git-send-email-tejaswinipoluri3@gmail.com>
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5B=5BRFC=5D=5BBugfix=3Aisapc_lapic_state?=
 =?utf-8?q?=5D=5D_Bugfix=3A_isapc=3Aapic=5Fstate_=3FStart_QEMU_with_=22qem?=
 =?utf-8?q?u-system-x86=5F64_-nographic_-M_isapc_-serial_none_-monitor_std?=
 =?utf-8?q?io=22_=3Fand_enter_=22info_lapic=22_at_the_monitor_prompt_?=
 =?utf-8?q?=E2=87=92_Segmentation_fault?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tejaswini <tejaswinipoluri3@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2017 at 03:49:13PM +0530, Tejaswini wrote:

Thanks for the patch!

Please CC the maintainers of target/i386/helper.c:

  $ scripts/get_maintainer.pl -f target/i386/helper.c
  Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86)
  Richard Henderson <rth@twiddle.net> (maintainer:X86)
  Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)

Please shorten the subject line:

  [[RFC][Bugfix:isapc lapic state]] Bugfix: isapc:apic_state ?Start QEMU wi=
th "qemu-system-x86_64 -nographic -M isapc -serial none -monitor stdio" ?an=
d enter "info lapic" at the monitor prompt =E2=87=92 Segmentation fault

I suggest:

  [PATCH] target-i386: fix "info lapic" segfault on isapc

The commit message (subject line) should be a short summary of the
patch.  Typically this is below 80 or even 72 characters.  Details go in
the commit description (email body before '---'), which can be
arbitrarily long.  Please move the command-line for reproducing the
segmentation fault into the commit description.

Please don't add extra tags to the Subject line unless you're sure they
are commonly used in QEMU (e.g. "[Bugfix:isapc lapic state]] Bugfix:
isapc:apic_state").

> From: Tejaswini Poluri <tejaswinipoluri3@gmail.com>
>=20
> 	The error occurs for only isapc machine type as it doesn't have apic sta=
te
> 	The cpu->apic_state of isapc is NULL. Hence added null pointer check in
> 	x86_cpu_dump_local_apic_state()

Please remove the indentation.

>=20
> Signed-off-by: Tejaswini Poluri <tejaswinipoluri3@gmail.com>
> ---
>  target/i386/helper.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index e2af340..1a8e3dd 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -327,7 +327,10 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, FIL=
E *f,
>      X86CPU *cpu =3D X86_CPU(cs);
>      APICCommonState *s =3D APIC_COMMON(cpu->apic_state);
>      uint32_t *lvt =3D s->lvt;
> -
> +    if (!s) {
> +        cpu_fprintf(f, "apic state not available\n");
> +        return;
> +    }

Did you test this code?

The dereference one line above will still cause a segfault:

  uint32_t *lvt =3D s->lvt;  <--- s is NULL!

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY2PAvAAoJEJykq7OBq3PIUHMH/i04XlMLXENecTuFfHS35VK9
FDfAM2f8OpJ8IhwDOb8Zjhb9LtLLXhQtulHJlfToJtDLNaCMN2S9iYKlQy5HEkAx
Kq1i9oQVHwrMeGzkKKnRG4Bw+7st3agEpgTHXYXStn60tLVVV4CQqDO0h69mQWcd
/b9tUlFFrl+/5sqZUu+DCAXaJAl/MHMO0qXaogVceHhV7UN5DSvPGctu1+ZFYiOZ
s1hUua54utpj7X4/dlMaBjZ7uLtlEUMd3i1d9UVYQ1T2jm6yy1CTCoPlv+ezG5Lo
TRosw/+na+Q+uPcCy74rTv1zyy+PRfqDzumqY4on+pHhEX8Ia+9NpyviY1hH0kQ=
=2WXx
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
