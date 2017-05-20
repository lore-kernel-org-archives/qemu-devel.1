Received: from eggs.gnu.org ([2001:4830:134:3::10]:49355)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dCDPZ-0001pP-5T
	for qemu-devel@nongnu.org; Sat, 20 May 2017 19:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dCDPW-0005v5-1u
	for qemu-devel@nongnu.org; Sat, 20 May 2017 19:03:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:50875)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dCDPV-0005uD-NY
	for qemu-devel@nongnu.org; Sat, 20 May 2017 19:03:45 -0400
References: <20170513004616.25749-1-n54@gmx.com>
	<87a86crlg0.fsf@dusky.pond.sub.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <a5bcd9dd-feb8-8083-30de-dec8d7139c96@gmx.com>
Date: Sun, 21 May 2017 01:05:31 +0200
MIME-Version: 1.0
In-Reply-To: <87a86crlg0.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Dwsf4GKlrgjQFGA4HXbPNJW352Rl3olhE"
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: Detect and use if there is
 required -lrt linking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Dwsf4GKlrgjQFGA4HXbPNJW352Rl3olhE
From: Kamil Rytarowski <n54@gmx.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Message-ID: <a5bcd9dd-feb8-8083-30de-dec8d7139c96@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: Detect and use if there is
 required -lrt linking
References: <20170513004616.25749-1-n54@gmx.com>
 <87a86crlg0.fsf@dusky.pond.sub.org>
In-Reply-To: <87a86crlg0.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello,

Excuse me for delay, I missed this mail.

Please see in-line.

On 17.05.2017 09:28, Markus Armbruster wrote:
> Kamil Rytarowski <n54@gmx.com> writes:
>=20
>> ivshmem-server makes use of the POSIX shared memory object interfaces.=

>> This library is provided on NetBSD in -lrt (POSIX Real-time Library).
>> Add ./configure check if there is needed -lrt linking for shm_open()
>> and if so use it. Introduce new configure generated variable LIBS_SHML=
IB.
>>
>> This fixes build issue on NetBSD.
>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>> ---
>>  Makefile  |  1 +
>>  configure | 20 ++++++++++++++++++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index 31d41a7eae..3248cb53d7 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -473,6 +473,7 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $=
(COMMON_LDADDS)
>>  	$(call LINK, $^)
>>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>>  	$(call LINK, $^)
>> +ivshmem-server$(EXESUF): LIBS +=3D $(LIBS_SHMLIB)
>> =20
>>  module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-ho=
st.mak
>>  	$(call quiet-command,$(PYTHON) $< $@ \
>> diff --git a/configure b/configure
>> index 7c020c076b..50c3aee746 100755
>> --- a/configure
>> +++ b/configure
>> @@ -179,6 +179,7 @@ audio_pt_int=3D""
>>  audio_win_int=3D""
>>  cc_i386=3Di386-pc-linux-gnu-gcc
>>  libs_qga=3D""
>> +libs_shmlib=3D""
>>  debug_info=3D"yes"
>>  stack_protector=3D""
>> =20
>> @@ -4133,6 +4134,24 @@ elif compile_prog "" "$pthread_lib -lrt" ; then=

>>    libs_qga=3D"$libs_qga -lrt"
>>  fi
>> =20
>> +##########################################
>> +# Do we need librt for shm_open()
>> +cat > $TMPC <<EOF
>> +#include <sys/mman.h>
>> +#include <sys/stat.h>
>> +#include <fcntl.h>
>> +#include <stddef.h>
>> +int main(void) {
>> +  return shm_open(NULL, O_RDWR, 0644);
>> +}
>> +EOF
>> +
>> +if compile_prog "" "" ; then
>> +  :
>> +elif compile_prog "" "-lrt" ; then
>> +  libs_shmlib=3D"$libs_shmlib -lrt"
>> +fi
>> +
>>  if test "$darwin" !=3D "yes" -a "$mingw32" !=3D "yes" -a "$solaris" !=
=3D yes -a \
>>          "$aix" !=3D "yes" -a "$haiku" !=3D "yes" ; then
>>      libs_softmmu=3D"-lutil $libs_softmmu"
>> @@ -5949,6 +5968,7 @@ echo "EXESUF=3D$EXESUF" >> $config_host_mak
>>  echo "DSOSUF=3D$DSOSUF" >> $config_host_mak
>>  echo "LDFLAGS_SHARED=3D$LDFLAGS_SHARED" >> $config_host_mak
>>  echo "LIBS_QGA+=3D$libs_qga" >> $config_host_mak
>> +echo "LIBS_SHMLIB+=3D$libs_shmlib" >> $config_host_mak
>>  echo "TASN1_LIBS=3D$tasn1_libs" >> $config_host_mak
>>  echo "TASN1_CFLAGS=3D$tasn1_cflags" >> $config_host_mak
>>  echo "POD2MAN=3D$POD2MAN" >> $config_host_mak
>=20
> We already have a test for -lrt.

Correct.

>  It looks for timer_create() and
> clock_gettime().


timer_create(2) and clock_settime(2) are in libc on NetBSD.

>  If we need -lrt,

We need it just for shm_open(3).

> we add it to LIBS and to LIBS_QGA.
> The latter because we don't use LIBS for qemu-ga:
>=20
>     qemu-ga$(EXESUF): LIBS =3D $(LIBS_QGA)
>=20
> This patch adds a second test for -lrt, to look for shm_open().  It add=
s
> -lrt to new variable LIBS_SHMLIB, which gets used only for
> ivshmem-server:
>=20
>     ivshmem-server$(EXESUF): LIBS +=3D $(LIBS_SHMLIB)
>=20
> Note that ivshmem-server already uses LIBS.
>=20
> Shouldn't we instead widen the existing test for -lrt to cover
> shm_open()?
>=20

I will prepare patch in the requested way. I don't have preference.

> Can you confirm that the existing test does not add -lrt to LIBS on
> NetBSD?
>=20

config-host.mak:LIBS+=3D-lm -L/usr/pkg/lib -lgthread-2.0 -pthread
-Wl,-R/usr/pkg/lib -lglib-2.0 -lintl   -lz
config-host.mak:LIBS_QGA+=3D-lm -L/usr/pkg/lib -lgthread-2.0 -pthread
-Wl,-R/usr/pkg/lib -lglib-2.0 -lintl

> tests/ivshmem-test.c also calls shm_open().  Does it work on NetBSD?
>=20

Currently it's disabled, as it requires eventfd() (Linux API).


--Dwsf4GKlrgjQFGA4HXbPNJW352Rl3olhE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZIMvGAAoJEEuzCOmwLnZshLUQAMR72kKb01T4Y+67Hf/eM8k1
tiz8l9uyFOp5w5wrTkG1ZYUnP7pQpB4hrx6L+zIGm6ZCkdqrHZa8ACYi5A95u8cg
RUtPOUnc8pLNz5yZUadnDIxSh4Q/OwJecxSQhoG2pDdNZlbHvNRoYw8g+LMkqgFJ
eMItvYViordo9N3mK47P2Kt8q7cv3DIgt9VXB5RadkEY15d6VFfz2gp2YacXGPKv
Q6wC2bJC0K5YLPpP3uBbjx21XZMD12edToMIXlDDFjxV5k7zoUqWMWV1cLVAQkZ6
p6NZh93D6b/DoG1MWABxSISnRaK+361Z4nqN/Ym3uau4dOCx8MstgZs/+ZL3B6wK
QGgAb/MXdsDOuf2QGAWTjGEbr4H1W+g7QqxVFsbR4p/ueqPh24WqX6UF+MZM9Ixl
LV61QuXGN1y5y7FR6bFobqoGk24uR8xo7CoR9J0i9PM9nCPu0zWG0BZRaUAxl+hg
vC5idp1ICOlA0NHpPC1E29z5smmxhym2IjnS+mcjNJ4CBzQyzlJ3hYZ0Bc+ptKH1
Y5ozE2FK0GYkLizSHjWc6EQTHWqIQvpHM7icFxK5zbmuTJxgkh9gGmtzTYDeBli/
v6igZLHPygJ028Defw6iGRYPPp6ItpZwdZfAK0BIs6SMInEG48X2vXUgNV6aYXwz
Jj62Tkzkb7UWjQIkvbxb
=JrfG
-----END PGP SIGNATURE-----

--Dwsf4GKlrgjQFGA4HXbPNJW352Rl3olhE--
