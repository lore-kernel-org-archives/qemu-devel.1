Received: from eggs.gnu.org ([2001:4830:134:3::10]:37302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZwMW-0007am-OD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZwMS-0000Ny-MR
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:47:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44780 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fZwMS-0000Nn-GN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:47:12 -0400
References: <20180617084025.29198-1-doug16k@gmail.com>
	<CAEfK_47iCSHfoBmdF_qG8W=mNTtp8Unt32Vg5twBdF+VJi6fEw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34f7878d-496e-71a4-440a-951c3fb82a44@redhat.com>
Date: Mon, 2 Jul 2018 12:47:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAEfK_47iCSHfoBmdF_qG8W=mNTtp8Unt32Vg5twBdF+VJi6fEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i386/monitor.c: make addresses canonical
 for "info mem" and "info tlb"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 01/07/2018 20:57, Doug Gale wrote:
>=20
>=20
> On Sun, Jun 17, 2018 at 4:40 AM, Doug Gale <doug16k@gmail.com
> <mailto:doug16k@gmail.com>> wrote:
>=20
>     Correct the output of the "info mem" and "info tlb" monitor command=
s to
>     correctly show canonical addresses.
>=20
>     In 48-bit addressing mode, the upper 16 bits of linear addresses ar=
e
>     equal to bit 47. In 57-bit addressing mode (LA57), the upper 7 bits=
 of
>     linear addresses are equal to bit 56.
>=20
>     Signed-off-by: Doug Gale <doug16k@gmail.com <mailto:doug16k@gmail.c=
om>>
>     ---
>     =C2=A0target/i386/monitor.c | 76 +++++++++++++++++++++++++---------=
---------
>     =C2=A01 file changed, 44 insertions(+), 32 deletions(-)
>=20
>     diff --git a/target/i386/monitor.c b/target/i386/monitor.c
>     index a890b3c2ab..99c97a63e2 100644
>     --- a/target/i386/monitor.c
>     +++ b/target/i386/monitor.c
>     @@ -35,21 +35,28 @@
>     =C2=A0#include "sev_i386.h"
>     =C2=A0#include "qapi/qapi-commands-misc.h"
>=20
>     -
>     -static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr=
,
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 hwaddr pte, hwaddr mask)
>     +/* Perform linear address sign extension */
>     +static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
>     =C2=A0{
>     =C2=A0#ifdef TARGET_X86_64
>     =C2=A0 =C2=A0 =C2=A0if (env->cr[4] & CR4_LA57_MASK) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (addr & (1ULL << 56)) {
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr |=3D -1LL << 57;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr |=3D (hwaddr)-(1LL =
<< 57);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (addr & (1ULL << 47)) {
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr |=3D -1LL << 48;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr |=3D (hwaddr)-(1LL =
<< 48);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0#endif
>     +=C2=A0 =C2=A0 return addr;
>     +}
>     +
>     +static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr=
,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 hwaddr pte, hwaddr mask)
>     +{
>     +=C2=A0 =C2=A0 addr =3D addr_canonical(env, addr);
>     +
>     =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, TARGET_FMT_plx ": " TARGET_=
FMT_plx
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 " %c%c%c%c%c%c%c%c%c\n",
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 addr,
>     @@ -243,8 +250,8 @@ void hmp_info_tlb(Monitor *mon, const QDict *qd=
ict)
>     =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0}
>=20
>     -static void mem_print(Monitor *mon, hwaddr *pstart,
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int *plast_prot,
>     +static void mem_print(Monitor *mon, CPUArchState *env,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 hwaddr *pstart, int *plast_prot,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0hwaddr end, int prot)
>     =C2=A0{
>     =C2=A0 =C2=A0 =C2=A0int prot1;
>     @@ -253,7 +260,9 @@ static void mem_print(Monitor *mon, hwaddr *pst=
art,
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (*pstart !=3D -1) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon,=
 TARGET_FMT_plx "-" TARGET_FMT_plx " "
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TARGET_FMT_plx " %c%c%c\n",
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*pstart, end, end - *pstart,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr_canonical(env, *pstart),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr_canonical(env, end),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr_canonical(env, end - *pstart),
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot1 & PG_USER_MASK ? 'u' : '-',
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 'r',
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prot1 & PG_RW_MASK ? 'w' : '-');
>     @@ -283,7 +292,7 @@ static void mem_info_32(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pde & PG_PRESENT_MASK) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((pde & PG_PSE_M=
ASK) && (env->cr[4] & CR4_PSE_MASK)) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot =
=3D pde & (PG_USER_MASK | PG_RW_MASK |
>     PG_PRESENT_MASK);
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(=
mon, &start, &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(=
mon, env, &start, &last_prot, end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for(l=
2 =3D 0; l2 < 1024; l2++) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cpu_physical_memory_read((pde & ~0xfff) + l2 *
>     4, &pte, 4);
>     @@ -295,16 +304,16 @@ static void mem_info_32(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0prot =3D 0;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mem_print(mon, &start, &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mem_print(mon, env, &start, &last_prot, end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot =3D 0;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon, &start, &=
last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon, env, &sta=
rt, &last_prot, end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0/* Flush last range */
>     -=C2=A0 =C2=A0 mem_print(mon, &start, &last_prot, (hwaddr)1 << 32, =
0);
>     +=C2=A0 =C2=A0 mem_print(mon, env, &start, &last_prot, (hwaddr)1 <<=
 32, 0);
>     =C2=A0}
>=20
>     =C2=A0static void mem_info_pae32(Monitor *mon, CPUArchState *env)
>     @@ -332,7 +341,7 @@ static void mem_info_pae32(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (pde & PG_PSE_MASK) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0prot =3D pde & (PG_USER_MASK | PG_RW_MASK |
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PG_=
PRESENT_MASK);
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 mem_print(mon, &start, &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 mem_print(mon, env, &start, &last_prot,
>     end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0pt_addr =3D pde & 0x3fffffffff000ULL;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0for (l3 =3D 0; l3 < 512; l3++) {
>     @@ -345,21 +354,21 @@ static void mem_info_pae32(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot =3D 0;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon, &start, &last_prot, end,
>     prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon, env, &start, &last_prot,
>     end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} els=
e {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0prot =3D 0;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mem_print(mon, &start, &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mem_print(mon, env, &start, &last_prot, end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot =3D 0;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon, &start, &=
last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon, env, &sta=
rt, &last_prot, end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0/* Flush last range */
>     -=C2=A0 =C2=A0 mem_print(mon, &start, &last_prot, (hwaddr)1 << 32, =
0);
>     +=C2=A0 =C2=A0 mem_print(mon, env, &start, &last_prot, (hwaddr)1 <<=
 32, 0);
>     =C2=A0}
>=20
>=20
>     @@ -389,7 +398,7 @@ static void mem_info_la48(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0prot =3D pdpe & (PG_USER_MASK | PG_RW_MASK |
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PG=
_PRESENT_MASK);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0prot &=3D pml4e;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 mem_print(mon, &start, &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 mem_print(mon, env, &start, &last_prot,
>     end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0pd_addr =3D pdpe & 0x3fffffffff000ULL;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0for (l3 =3D 0; l3 < 512; l3++) {
>     @@ -401,7 +410,8 @@ static void mem_info_la48(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot =3D p=
de & (PG_USER_MASK |
>     PG_RW_MASK |
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PG_PRESENT_MASK);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot &=3D =
pml4e & pdpe;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon=
, &start,
>     &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon=
, env, &start,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &last_prot, end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pt_addr =3D=
 pde & 0x3fffffffff000ULL;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (l4 =3D=
 0; l4 < 512; l4++) {
>     @@ -418,27 +428,29 @@ static void mem_info_la48(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0prot =3D 0;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 mem_print(mon, &start,
>     &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 mem_print(mon, env, &start,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &last_prot, end,
>     prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot =3D 0;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon, &start, &las=
t_prot,
>     end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon, env, &start,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &last_prot, end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} els=
e {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0prot =3D 0;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mem_print(mon, &start, &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mem_print(mon, env, &start, &last_prot, end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot =3D 0;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon, &start, &=
last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon, env, &sta=
rt, &last_prot, end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0/* Flush last range */
>     -=C2=A0 =C2=A0 mem_print(mon, &start, &last_prot, (hwaddr)1 << 48, =
0);
>     +=C2=A0 =C2=A0 mem_print(mon, env, &start, &last_prot, (hwaddr)1 <<=
 48, 0);
>     =C2=A0}
>=20
>     =C2=A0static void mem_info_la57(Monitor *mon, CPUArchState *env)
>     @@ -457,7 +469,7 @@ static void mem_info_la57(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end =3D l0 << 48;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(pml5e & PG_PRESENT_MASK)) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot =3D 0;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon, &start, &=
last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(mon, env, &sta=
rt, &last_prot, end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=20
>     @@ -468,7 +480,7 @@ static void mem_info_la57(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end =3D (l0 << 48) =
+ (l1 << 39);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(pml4e & PG_PR=
ESENT_MASK)) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot =
=3D 0;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(=
mon, &start, &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_print(=
mon, env, &start, &last_prot, end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0conti=
nue;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=20
>     @@ -479,7 +491,7 @@ static void mem_info_la57(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end =3D=
 (l0 << 48) + (l1 << 39) + (l2 << 30);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p=
dpe & PG_PRESENT_MASK) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0prot =3D 0;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mem_print(mon, &start, &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mem_print(mon, env, &start, &last_prot, end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0continue;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=20
>     @@ -487,7 +499,7 @@ static void mem_info_la57(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0prot =3D pdpe & (PG_USER_MASK | PG_RW_MASK |
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PG_PRESENT_MASK);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0prot &=3D pml5e & pml4e;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mem_print(mon, &start, &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mem_print(mon, env, &start, &last_prot, end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0continue;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=20
>     @@ -498,7 +510,7 @@ static void mem_info_la57(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0end =3D (l0 << 48) + (l1 << 39) + (l2 << 30) +
>     (l3 << 21);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (pde & PG_PRESENT_MASK) {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0prot =3D 0;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 mem_print(mon, &start, &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 mem_print(mon, env, &start, &last_prot,
>     end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0continue;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}
>=20
>     @@ -506,7 +518,7 @@ static void mem_info_la57(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0prot =3D pde & (PG_USER_MASK | PG_RW_MASK |
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PG_PRESENT_MASK);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0prot &=3D pml5e & pml4e & pdpe;
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 mem_print(mon, &start, &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 mem_print(mon, env, &start, &last_prot,
>     end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0continue;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}
>=20
>     @@ -523,14 +535,14 @@ static void mem_info_la57(Monitor *mon,
>     CPUArchState *env)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0} else {
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prot =3D 0;
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 mem_print(mon, &start, &last_prot, end, prot);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 mem_print(mon, env, &start, &last_prot,
>     end, prot);
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0}
>     =C2=A0 =C2=A0 =C2=A0/* Flush last range */
>     -=C2=A0 =C2=A0 mem_print(mon, &start, &last_prot, (hwaddr)1 << 57, =
0);
>     +=C2=A0 =C2=A0 mem_print(mon, env, &start, &last_prot, (hwaddr)1 <<=
 57, 0);
>     =C2=A0}
>     =C2=A0#endif /* TARGET_X86_64 */
>     =C2=A0
>     --=20
>     2.17.1
>=20
>=20
> =E2=80=8BPing.=E2=80=8B
>=20

Queued, thanks and sorry for the wait.

Paolo
