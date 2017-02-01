Received: from eggs.gnu.org ([2001:4830:134:3::10]:49622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cZ4YL-0002CH-Fv
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cZ4YH-0001pI-J2
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:43:05 -0500
References: <587D4171.6@linux.intel.com> <587D4329.5020702@linux.intel.com>
	<20170130235210.GA4681@tungsten.ozlabs.ibm.com>
	<CAFEAcA-FPmqw0pt7kT=eHR_osfFbZNhrDdGAb87VxUWD_XXSNw@mail.gmail.com>
	<20170201223023.GC13219@umbus.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2f15af5f-b16c-2a36-7354-6357ea48505e@vivier.eu>
Date: Thu, 2 Feb 2017 00:42:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170201223023.GC13219@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uucaoB1C3NVrDaTSDR8lQc1CnKpeDCuNW"
Subject: Re: [Qemu-devel] [Qemu-ppc]  qemu-pcc 2.8.0 linux-user segfaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>, Sam Bobroff <sam.bobroff@au1.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uucaoB1C3NVrDaTSDR8lQc1CnKpeDCuNW
From: Laurent Vivier <laurent@vivier.eu>
To: David Gibson <david@gibson.dropbear.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>,
 Sam Bobroff <sam.bobroff@au1.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <2f15af5f-b16c-2a36-7354-6357ea48505e@vivier.eu>
Subject: Re: [Qemu-ppc] [Qemu-devel] qemu-pcc 2.8.0 linux-user segfaults
References: <587D4171.6@linux.intel.com> <587D4329.5020702@linux.intel.com>
 <20170130235210.GA4681@tungsten.ozlabs.ibm.com>
 <CAFEAcA-FPmqw0pt7kT=eHR_osfFbZNhrDdGAb87VxUWD_XXSNw@mail.gmail.com>
 <20170201223023.GC13219@umbus.fritz.box>
In-Reply-To: <20170201223023.GC13219@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 01/02/2017 =C3=A0 23:30, David Gibson a =C3=A9crit :
> On Wed, Feb 01, 2017 at 03:25:05PM +0000, Peter Maydell wrote:
>> On 30 January 2017 at 23:52, Sam Bobroff <sam.bobroff@au1.ibm.com> wro=
te:
>>>> On 01/16/2017 03:56 PM, An=C3=ADbal Lim=C3=B3n wrote:
>>>>> I'm trying to upgrade qemu to 2.8.0 in Openembedded-core and segfau=
lts
>>>>> in qemu-ppc when is executing:
>>
>>> I've recently encountered a similar problem and I've posted a fix. If=

>>> you'd like to try it, it's here:
>>>
>>> https://lists.gnu.org/archive/html/qemu-ppc/2017-01/msg00413.html
>>
>> Hmm, I missed that patch (it doesn't seem to have made it
>> to the qemu-devel list), but it isn't correct, I'm afraid.
>> In the patch for handling TARGET_USER_ESIGRETURN you must
>> not change the nip register, because we will have just
>> set it from the signal context that the guest provided
>> to the sigreturn syscall. (The patch as it stands will
>> cause us to reexecute an instruction after return from
>> a signal handler, which isn't going to go very well).

I think commit bd6fefe has already made the change in
target-ppc/excp_helper.c:

     case POWERPC_EXCP_SYSCALL:   /* System call exception
     */
         dump_syscall(env);
         lev =3D env->error_code;

+        /* We need to correct the NIP which in this case is supposed
+         * to point to the next instruction
+         */
+        env->nip +=3D 4;
+
         /* "PAPR mode" built-in hypercall emulation */
         if ((lev =3D=3D 1) && cpu_ppc_hypercall) {
             cpu_ppc_hypercall(cpu);

And target/ppc/translate.c:

#if defined(CONFIG_USER_ONLY)
#define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL_USER
#else
#define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL
#endif

So I guess the fix should be only to revert the
POWERPC_EXCP_SYSCALL_USER change of bd6fefe with:

@@ -2001,9 +2001,9 @@ void cpu_loop(CPUPPCState *env)
                              env->gpr[5], env->gpr[6], env->gpr[7],
                              env->gpr[8], 0, 0);
             if (ret =3D=3D -TARGET_ERESTARTSYS) {
+                env->nip -=3D 4;
                 break;
             }
-            env->nip +=3D 4;
             if (ret =3D=3D (target_ulong)(-TARGET_QEMU_ESIGRETURN)) {
                 /* Returning from a successful sigreturn syscall.
                    Avoid corrupting register state.  */

Not sure anyway...

Laurent





--uucaoB1C3NVrDaTSDR8lQc1CnKpeDCuNW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYknJlAAoJEPMMOL0/L748FUsQAJqN1p1W38GVWzy86AHsPJqA
9Qht9mjX7g96UhnzSQR63y9fKvod6XmPB7LVo2FVhef3/q46Ypi8PDLmuDuofVKi
fDwr5gcejLFhMglebVVKAlOuxqQulqB2DHAs4Hrh5/01yk1qY9cIGEGSi8SJ4fE9
VE8F8FT1SrUmeIz2GdowwmCwA9Es6mevFBuccNjgN1sxUqmh0DvAdyq+VBd4c5PJ
XvIjqZ428Ma+AlxXksT1/vFUvbSEAzMLjNCkIAhik2OSkENLiPHjM9tToRvhl3TT
0vztA7U5hp6hQRDJI+Wy6cIc1YiQYFL5YrCvtZe3MX5twNSbCXNFpNL909CweViR
ata26Y2gnu+aiYsTbnqN13Xs29q+1QgsOVGGEuxwqEhaPrQ9QI9K1eSpSPm7YrtM
+yaOXvZmakSYa9MBihOYWpm8mq70IJtS3wHuZdaHNsuETf4Z52XI5qBI/p72vptP
7eY/oUyx9aWkX9IsfS9An30Xlw/TGQvygPXyO6HZzXC0MT7MJFNWlojZxr++Imk7
IG/2eQhWNe9eCl2p0PDfnfjjMck50IhdsbZg+X+Swc+nEc61gV9h/B3gSzbuWfaT
eSdDy0UXqLX8Y71vnWsxkPXJ1uthEWFMd67w7qjDz0aZ/mweaLyepAjwjG4Zg2Uu
DAumZF7dRMJCLI+GJB+z
=uWma
-----END PGP SIGNATURE-----

--uucaoB1C3NVrDaTSDR8lQc1CnKpeDCuNW--
