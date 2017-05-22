Received: from eggs.gnu.org ([2001:4830:134:3::10]:49564)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dCqbM-0006Ix-W7
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dCqbA-0006Vz-Fp
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:54:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:61924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dCqbA-0006R2-3G
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:54:24 -0400
References: <20170513004616.25749-1-n54@gmx.com>
	<87a86crlg0.fsf@dusky.pond.sub.org>
	<a5bcd9dd-feb8-8083-30de-dec8d7139c96@gmx.com>
	<874lwd5rsx.fsf@dusky.pond.sub.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <688e36b3-6707-c4e5-4f0c-3c7a5d0fa390@gmx.com>
Date: Mon, 22 May 2017 18:46:01 +0200
MIME-Version: 1.0
In-Reply-To: <874lwd5rsx.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vNcvOfTaf8RTckg4VNXrAtohhLxMVVL7o"
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
--vNcvOfTaf8RTckg4VNXrAtohhLxMVVL7o
From: Kamil Rytarowski <n54@gmx.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Message-ID: <688e36b3-6707-c4e5-4f0c-3c7a5d0fa390@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: Detect and use if there is
 required -lrt linking
References: <20170513004616.25749-1-n54@gmx.com>
 <87a86crlg0.fsf@dusky.pond.sub.org>
 <a5bcd9dd-feb8-8083-30de-dec8d7139c96@gmx.com>
 <874lwd5rsx.fsf@dusky.pond.sub.org>
In-Reply-To: <874lwd5rsx.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 22.05.2017 08:28, Markus Armbruster wrote:
> Kamil Rytarowski <n54@gmx.com> writes:
>=20
>> Hello,
>>
>> Excuse me for delay, I missed this mail.
>=20
> No problem.
>=20
>> Please see in-line.
>>
>> On 17.05.2017 09:28, Markus Armbruster wrote:
>>> Kamil Rytarowski <n54@gmx.com> writes:
>>>
>>>> ivshmem-server makes use of the POSIX shared memory object interface=
s.
>>>> This library is provided on NetBSD in -lrt (POSIX Real-time Library)=
=2E
>>>> Add ./configure check if there is needed -lrt linking for shm_open()=

>>>> and if so use it. Introduce new configure generated variable LIBS_SH=
MLIB.
>>>>
>>>> This fixes build issue on NetBSD.
>>>>
>>>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>>>> ---
>>>>  Makefile  |  1 +
>>>>  configure | 20 ++++++++++++++++++++
>>>>  2 files changed, 21 insertions(+)
>>>>
>>>> diff --git a/Makefile b/Makefile
>>>> index 31d41a7eae..3248cb53d7 100644
>>>> --- a/Makefile
>>>> +++ b/Makefile
>>>> @@ -473,6 +473,7 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y)=
 $(COMMON_LDADDS)
>>>>  	$(call LINK, $^)
>>>>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>>>>  	$(call LINK, $^)
>>>> +ivshmem-server$(EXESUF): LIBS +=3D $(LIBS_SHMLIB)
>>>> =20
>>>>  module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-=
host.mak
>>>>  	$(call quiet-command,$(PYTHON) $< $@ \
>>>> diff --git a/configure b/configure
>>>> index 7c020c076b..50c3aee746 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -179,6 +179,7 @@ audio_pt_int=3D""
>>>>  audio_win_int=3D""
>>>>  cc_i386=3Di386-pc-linux-gnu-gcc
>>>>  libs_qga=3D""
>>>> +libs_shmlib=3D""
>>>>  debug_info=3D"yes"
>>>>  stack_protector=3D""
>>>> =20
>>>> @@ -4133,6 +4134,24 @@ elif compile_prog "" "$pthread_lib -lrt" ; th=
en
>>>>    libs_qga=3D"$libs_qga -lrt"
>>>>  fi
>>>> =20
>>>> +##########################################
>>>> +# Do we need librt for shm_open()
>>>> +cat > $TMPC <<EOF
>>>> +#include <sys/mman.h>
>>>> +#include <sys/stat.h>
>>>> +#include <fcntl.h>
>>>> +#include <stddef.h>
>>>> +int main(void) {
>>>> +  return shm_open(NULL, O_RDWR, 0644);
>>>> +}
>>>> +EOF
>>>> +
>>>> +if compile_prog "" "" ; then
>>>> +  :
>>>> +elif compile_prog "" "-lrt" ; then
>>>> +  libs_shmlib=3D"$libs_shmlib -lrt"
>>>> +fi
>>>> +
>>>>  if test "$darwin" !=3D "yes" -a "$mingw32" !=3D "yes" -a "$solaris"=
 !=3D yes -a \
>>>>          "$aix" !=3D "yes" -a "$haiku" !=3D "yes" ; then
>>>>      libs_softmmu=3D"-lutil $libs_softmmu"
>>>> @@ -5949,6 +5968,7 @@ echo "EXESUF=3D$EXESUF" >> $config_host_mak
>>>>  echo "DSOSUF=3D$DSOSUF" >> $config_host_mak
>>>>  echo "LDFLAGS_SHARED=3D$LDFLAGS_SHARED" >> $config_host_mak
>>>>  echo "LIBS_QGA+=3D$libs_qga" >> $config_host_mak
>>>> +echo "LIBS_SHMLIB+=3D$libs_shmlib" >> $config_host_mak
>>>>  echo "TASN1_LIBS=3D$tasn1_libs" >> $config_host_mak
>>>>  echo "TASN1_CFLAGS=3D$tasn1_cflags" >> $config_host_mak
>>>>  echo "POD2MAN=3D$POD2MAN" >> $config_host_mak
>>>
>>> We already have a test for -lrt.
>>
>> Correct.
>>
>>>  It looks for timer_create() and
>>> clock_gettime().
>>
>>
>> timer_create(2) and clock_settime(2) are in libc on NetBSD.
>>
>>>  If we need -lrt,
>>
>> We need it just for shm_open(3).
>>
>>> we add it to LIBS and to LIBS_QGA.
>>> The latter because we don't use LIBS for qemu-ga:
>>>
>>>     qemu-ga$(EXESUF): LIBS =3D $(LIBS_QGA)
>>>
>>> This patch adds a second test for -lrt, to look for shm_open().  It a=
dds
>>> -lrt to new variable LIBS_SHMLIB, which gets used only for
>>> ivshmem-server:
>>>
>>>     ivshmem-server$(EXESUF): LIBS +=3D $(LIBS_SHMLIB)
>>>
>>> Note that ivshmem-server already uses LIBS.
>>>
>>> Shouldn't we instead widen the existing test for -lrt to cover
>>> shm_open()?
>>>
>>
>> I will prepare patch in the requested way. I don't have preference.
>>
>>> Can you confirm that the existing test does not add -lrt to LIBS on
>>> NetBSD?
>>>
>>
>> config-host.mak:LIBS+=3D-lm -L/usr/pkg/lib -lgthread-2.0 -pthread
>> -Wl,-R/usr/pkg/lib -lglib-2.0 -lintl   -lz
>> config-host.mak:LIBS_QGA+=3D-lm -L/usr/pkg/lib -lgthread-2.0 -pthread
>> -Wl,-R/usr/pkg/lib -lglib-2.0 -lintl
>>
>>> tests/ivshmem-test.c also calls shm_open().  Does it work on NetBSD?
>>>
>>
>> Currently it's disabled, as it requires eventfd() (Linux API).
>=20
> You're right.
>=20
> So is the ivshmem device.  Hmm.  Why would anyone want ivshmem-server o=
n
> NetBSD?  Its purpose is connecting ivshmem-doorbell devices.  Could we
> simply add the obvious CONFIG_IVSHMEM dependence to
> contrib/ivshmem-*/Makefile.objs?
>=20

In general I would like to get feature parity on NetBSD, there is no
reason to blacklist this feature for !Linux hosts. However short term
there are higher priorities, to fix build of pristine sources
(ivshmem-server is blocking here, not that I'm right now working on its
correctness on the NetBSD host) and run test suite.

I wanted to avoid overlinking, that would be caused by adding -lrt.
Adding dedicated -lrt check for shm_open(3) made sense to me, but I will
go the requested route.


--vNcvOfTaf8RTckg4VNXrAtohhLxMVVL7o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZIxXKAAoJEEuzCOmwLnZsf0MP/2P4P9hMZEKAoqG4xlPKimAu
0FVXBUQk+S/yDpO55iVAiBDO4c4x2RHOutWlHUUgPEIXyO0CoHJloHQcNkqfJkt3
3cwWDTfo4y/SUsvfAeiFPtOcHkVDXQ17TzQb/x5J/tb62RBgE+oAZZ8DPI7M6zhD
0QcQV/0BQf5G3Xdni+9VcRBxxbQpkAk8637n5zYHs6SGTbSzy0ReMHmsQ2tZZF4m
tsqXthBKZqm8M+inSoImWv+stshNilEYpevdlE8D5TnaIk1jSalbddRujfWWgTKl
208dv7tDmm0Ej9IPggn91pxd2xEzmYIpnP0f2K2gT69/ZpHUs4aaIx+9+W6JXt/2
rimB0u5Ric7r8MZje9Upc6C9IdOxJTMH5CsuBNEobXKgskmpMU9L6rSUNhQp7siE
I6mSt9KARfekwcdkVIjpG0zQaHImMelx7dpz89TrTF5XjBUbJ909K3q1T3pMBUox
2AWVlhBFulb42TGT/neszropwsv50RJGem1YuB7NxQPl6H+8xBjHqhTBJbm9T193
xqE79gWl27iw3LCW0ub0RiO1V6l3zN0xsgn+03XqxZsfKy24sn2gOh406DrFNpGw
YWC8n8SNSknuxDfvERcLFvxgEZbQpk26kxvIA+j1M4cUxUredT5mGA5FZjM5nJZC
OHeCdcvC0LwJDwvSsjmr
=+eYe
-----END PGP SIGNATURE-----

--vNcvOfTaf8RTckg4VNXrAtohhLxMVVL7o--
