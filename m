Received: from eggs.gnu.org ([2001:4830:134:3::10]:59590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1feDG0-0007nY-N8
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 01:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1feDFv-0002CC-RY
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 01:38:12 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:37433)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1feDFv-00029A-FD
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 01:38:07 -0400
References: <153148521235.87746.14142430397318741182.stgit@lep8c.aus.stglabs.ibm.com>
	<20180714010700.GA2599@umbus.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <eb7a52ea-57ce-46eb-c84e-96b5887d6e71@vivier.eu>
Date: Sat, 14 Jul 2018 07:37:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180714010700.GA2599@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3jvlA0LpMs06QHlH1prNwGdPSYfOAtIG1"
Subject: Re: [Qemu-devel] [PATCH v4] linux-user: ppc64: use the correct
 values for F_*LK64s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3jvlA0LpMs06QHlH1prNwGdPSYfOAtIG1
From: Laurent Vivier <laurent@vivier.eu>
To: David Gibson <david@gibson.dropbear.id.au>,
 Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org
Message-ID: <eb7a52ea-57ce-46eb-c84e-96b5887d6e71@vivier.eu>
Subject: Re: [PATCH v4] linux-user: ppc64: use the correct values for F_*LK64s
References: <153148521235.87746.14142430397318741182.stgit@lep8c.aus.stglabs.ibm.com>
 <20180714010700.GA2599@umbus.fritz.box>
In-Reply-To: <20180714010700.GA2599@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 14/07/2018 =C3=A0 03:07, David Gibson a =C3=A9crit=C2=A0:
> On Fri, Jul 13, 2018 at 07:34:46AM -0500, Shivaprasad G Bhat wrote:
>> Qemu includes the glibc headers for the host defines and target header=
s are
>> part of the qemu source themselves. The glibc has the F_GETLK64, F_SET=
LK64
>> and F_SETLKW64 defined to 12, 13 and 14 for all archs in
>> sysdeps/unix/sysv/linux/bits/fcntl-linux.h. The linux kernel generic
>> definition for F_*LK is 5, 6 & 7 and F_*LK64* is 12,13, and 14 as seen=
 in
>> include/uapi/asm-generic/fcntl.h. On 64bit machine, by default the ker=
nel
>> assumes all F_*LK to 64bit calls and doesnt support use of F_*LK64* as=

>> can be seen in include/linux/fcntl.h in linux source.
>>
>> On x86_64 host, the values for F_*LK64* are set to 5, 6 and 7
>> explicitly in /usr/include/x86_64-linux-gnu/bits/fcntl.h by the glibc.=

>> Whereas, a PPC64 host doesn't have such a definition in
>> /usr/include/powerpc64le-linux-gnu/bits/fcntl.h by the glibc. So,
>> the sources on PPC64 host sees the default value of F_*LK64*
>> as 12, 13 & 14(fcntl-linux.h).
>>
>> Since the 64bit kernel doesnt support 12, 13 & 14; the glibc fcntl sys=
call
>> implementation(__libc_fcntl*(), __fcntl64_nocancel) does the F_*LK64* =
value
>> convertion back to F_*LK* values on PPC64 as seen in
>> sysdeps/unix/sysv/linux/powerpc/powerpc64/sysdep.h with FCNTL_ADJUST_C=
MD()
>> macro. Whereas on x86_64 host the values for F_*LK64* are set to 5, 6 =
and 7
>> and no adjustments are needed.
>>
>> Since qemu doesnt use the glibc fcntl, but makes the safe_syscall* on =
its
>> own, the PPC64 qemu is calling the syscall with 12, 13, and 14(without=

>> adjustment) and they all fail. The fcntl calls to F_GETLK/F_SETLK|W al=
l
>> fail by all pplications run on PPC64 host user emulation.
>>
>> The fix here could be to see why on PPC64 the glibc is still keeping
>> F_*LK64* different from F_*LK and why adjusting them to 5, 6 and 7 bef=
ore
>> the syscall for PPC only. See if we can make the
>> /usr/include/powerpc64le-linux-gnu/bits/fcntl.h to have the values
>> 5, 6 & 7 just like x86_64 and remove the adjustment code in glibc. Tha=
t
>> way, qemu sources see the kernel supported values in glibc headers.
>>
>> OR
>>
>> On PPC64 host, qemu sources see both F_*LK & F_*LK64* as same and set =
to
>> 12, 13 and 14 because __USE_FILE_OFFSET64 is defined in qemu
>> sources(also refer sysdeps/unix/sysv/linux/bits/fcntl-linux.h).
>> Do the value adjustment just like it is done by glibc source by using
>> F_GETLK value of 5. That way, we make the syscalls with the actual
>> supported values in Qemu. The patch is taking this approach.
>>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> I'm not sure if this should go in through my tree or not.

I will take it through my linux-user tree, I have some fixes to send for
the next -rc.

Thanks,
Laurent



--3jvlA0LpMs06QHlH1prNwGdPSYfOAtIG1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzS913cjjpNwuT1Fz8ww4vT8vvjwFAltJjCcACgkQ8ww4vT8v
vjwAKg//YSqW3vCDbnIQhqjKGIRAqc+4u22SPFkm1qfZ+MEBy5BID7Ey5/QCCfWk
emsB7/13spvtkiTX8pHL53pEND5ozkf9mJv9TVOgURdndx73CnRXugXQwurXjJ3/
sLiDtVtP+JAil1mHlrtJQvhcD1ryQp2vPzY/sGnojAGT9xjITGDFQTNu7XkBKb2E
VU+dKeqyGGNcEJxvxQlYOLX0WzBXf3Bpc926E/MSNv+RVqf2vbAyoBhDHV/4YTNy
wj+DMknj2XCfnF0mksRdBDR9KMUxvGS5wV7Y8JpsuudR2Qkve4sw86QI1A1U+kC4
KOAr6AFdPHSDwVkK7VKbEYq2sWjrVMrEloyYX/5ro+OrQ+ypjYVatUYl8JkNTXfU
mfirFtiXtTEI4y8gd2xehSVZgvBN5qlIfrP9F2PI3p5P8cW987rE0FXQHFxXWHGB
fZX1A6KaJS8f4CJ0M2klBdIPYlPjna09XQ+2qCm5Krvagwv7R+fr5sY/Jvtc+hfb
n1ywgy+OBY85ThW+nOWHR9Ul1F287n22ntDQbYJpYlmqxthhoN66GKV1WtZBtS3p
fXgfR68khNDyE5RUGPVljOZLZcnRkNO0Jcn/ntkWFGqAmihl02LII9C64xaTPP2k
6vm1b9TBmh57uW4S7x2FRNL2CY38MTgUSKDz5/Pb2iYOh/G+9vE=
=zN4K
-----END PGP SIGNATURE-----

--3jvlA0LpMs06QHlH1prNwGdPSYfOAtIG1--
