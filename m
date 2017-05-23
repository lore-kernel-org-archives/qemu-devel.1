Received: from eggs.gnu.org ([2001:4830:134:3::10]:49559)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dDB0m-0002fH-2P
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dDB0i-0004Ci-Ox
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:42:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:61380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dDB0i-0004CG-Cu
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:42:08 -0400
References: <20170513004616.25749-1-n54@gmx.com>
	<87a86crlg0.fsf@dusky.pond.sub.org>
	<a5bcd9dd-feb8-8083-30de-dec8d7139c96@gmx.com>
	<874lwd5rsx.fsf@dusky.pond.sub.org>
	<688e36b3-6707-c4e5-4f0c-3c7a5d0fa390@gmx.com>
	<87fufwjfqw.fsf@dusky.pond.sub.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <93d4d9ae-ed35-e610-7343-8f0ef9e7efab@gmx.com>
Date: Tue, 23 May 2017 16:33:39 +0200
MIME-Version: 1.0
In-Reply-To: <87fufwjfqw.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7xvKgowkSXOJivihAUm1PTbdsGJK85xxB"
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
--7xvKgowkSXOJivihAUm1PTbdsGJK85xxB
From: Kamil Rytarowski <n54@gmx.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Message-ID: <93d4d9ae-ed35-e610-7343-8f0ef9e7efab@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: Detect and use if there is
 required -lrt linking
References: <20170513004616.25749-1-n54@gmx.com>
 <87a86crlg0.fsf@dusky.pond.sub.org>
 <a5bcd9dd-feb8-8083-30de-dec8d7139c96@gmx.com>
 <874lwd5rsx.fsf@dusky.pond.sub.org>
 <688e36b3-6707-c4e5-4f0c-3c7a5d0fa390@gmx.com>
 <87fufwjfqw.fsf@dusky.pond.sub.org>
In-Reply-To: <87fufwjfqw.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 23.05.2017 07:37, Markus Armbruster wrote:
> Kamil Rytarowski <n54@gmx.com> writes:
>=20
>> On 22.05.2017 08:28, Markus Armbruster wrote:
>>> Kamil Rytarowski <n54@gmx.com> writes:
>>>
>>>> Hello,
>>>>
>>>> Excuse me for delay, I missed this mail.
>>>
>>> No problem.
>>>
>>>> Please see in-line.
>>>>
>>>> On 17.05.2017 09:28, Markus Armbruster wrote:
>>>>> Kamil Rytarowski <n54@gmx.com> writes:
>>>>>
>>>>>> ivshmem-server makes use of the POSIX shared memory object interfa=
ces.
>>>>>> This library is provided on NetBSD in -lrt (POSIX Real-time Librar=
y).
>>>>>> Add ./configure check if there is needed -lrt linking for shm_open=
()
>>>>>> and if so use it. Introduce new configure generated variable LIBS_=
SHMLIB.
>>>>>>
>>>>>> This fixes build issue on NetBSD.
>>>>>>
>>>>>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>>>>>> ---
>>>>>>  Makefile  |  1 +
>>>>>>  configure | 20 ++++++++++++++++++++
>>>>>>  2 files changed, 21 insertions(+)
>>>>>>
>>>>>> diff --git a/Makefile b/Makefile
>>>>>> index 31d41a7eae..3248cb53d7 100644
>>>>>> --- a/Makefile
>>>>>> +++ b/Makefile
>>>>>> @@ -473,6 +473,7 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-=
y) $(COMMON_LDADDS)
>>>>>>  	$(call LINK, $^)
>>>>>>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)=

>>>>>>  	$(call LINK, $^)
>>>>>> +ivshmem-server$(EXESUF): LIBS +=3D $(LIBS_SHMLIB)
>>>>>> =20
>>>>>>  module_block.h: $(SRC_PATH)/scripts/modules/module_block.py confi=
g-host.mak
>>>>>>  	$(call quiet-command,$(PYTHON) $< $@ \
>>>>>> diff --git a/configure b/configure
>>>>>> index 7c020c076b..50c3aee746 100755
>>>>>> --- a/configure
>>>>>> +++ b/configure
>>>>>> @@ -179,6 +179,7 @@ audio_pt_int=3D""
>>>>>>  audio_win_int=3D""
>>>>>>  cc_i386=3Di386-pc-linux-gnu-gcc
>>>>>>  libs_qga=3D""
>>>>>> +libs_shmlib=3D""
>>>>>>  debug_info=3D"yes"
>>>>>>  stack_protector=3D""
>>>>>> =20
>>>>>> @@ -4133,6 +4134,24 @@ elif compile_prog "" "$pthread_lib -lrt" ; =
then
>>>>>>    libs_qga=3D"$libs_qga -lrt"
>>>>>>  fi
>>>>>> =20
>>>>>> +##########################################
>>>>>> +# Do we need librt for shm_open()
>>>>>> +cat > $TMPC <<EOF
>>>>>> +#include <sys/mman.h>
>>>>>> +#include <sys/stat.h>
>>>>>> +#include <fcntl.h>
>>>>>> +#include <stddef.h>
>>>>>> +int main(void) {
>>>>>> +  return shm_open(NULL, O_RDWR, 0644);
>>>>>> +}
>>>>>> +EOF
>>>>>> +
>>>>>> +if compile_prog "" "" ; then
>>>>>> +  :
>>>>>> +elif compile_prog "" "-lrt" ; then
>>>>>> +  libs_shmlib=3D"$libs_shmlib -lrt"
>>>>>> +fi
>>>>>> +
>>>>>>  if test "$darwin" !=3D "yes" -a "$mingw32" !=3D "yes" -a "$solari=
s" !=3D yes -a \
>>>>>>          "$aix" !=3D "yes" -a "$haiku" !=3D "yes" ; then
>>>>>>      libs_softmmu=3D"-lutil $libs_softmmu"
>>>>>> @@ -5949,6 +5968,7 @@ echo "EXESUF=3D$EXESUF" >> $config_host_mak
>>>>>>  echo "DSOSUF=3D$DSOSUF" >> $config_host_mak
>>>>>>  echo "LDFLAGS_SHARED=3D$LDFLAGS_SHARED" >> $config_host_mak
>>>>>>  echo "LIBS_QGA+=3D$libs_qga" >> $config_host_mak
>>>>>> +echo "LIBS_SHMLIB+=3D$libs_shmlib" >> $config_host_mak
>>>>>>  echo "TASN1_LIBS=3D$tasn1_libs" >> $config_host_mak
>>>>>>  echo "TASN1_CFLAGS=3D$tasn1_cflags" >> $config_host_mak
>>>>>>  echo "POD2MAN=3D$POD2MAN" >> $config_host_mak
>>>>>
>>>>> We already have a test for -lrt.
>>>>
>>>> Correct.
>>>>
>>>>>  It looks for timer_create() and
>>>>> clock_gettime().
>>>>
>>>>
>>>> timer_create(2) and clock_settime(2) are in libc on NetBSD.
>>>>
>>>>>  If we need -lrt,
>>>>
>>>> We need it just for shm_open(3).
>>>>
>>>>> we add it to LIBS and to LIBS_QGA.
>>>>> The latter because we don't use LIBS for qemu-ga:
>>>>>
>>>>>     qemu-ga$(EXESUF): LIBS =3D $(LIBS_QGA)
>>>>>
>>>>> This patch adds a second test for -lrt, to look for shm_open().  It=
 adds
>>>>> -lrt to new variable LIBS_SHMLIB, which gets used only for
>>>>> ivshmem-server:
>>>>>
>>>>>     ivshmem-server$(EXESUF): LIBS +=3D $(LIBS_SHMLIB)
>>>>>
>>>>> Note that ivshmem-server already uses LIBS.
>>>>>
>>>>> Shouldn't we instead widen the existing test for -lrt to cover
>>>>> shm_open()?
>>>>>
>>>>
>>>> I will prepare patch in the requested way. I don't have preference.
>>>>
>>>>> Can you confirm that the existing test does not add -lrt to LIBS on=

>>>>> NetBSD?
>>>>>
>>>>
>>>> config-host.mak:LIBS+=3D-lm -L/usr/pkg/lib -lgthread-2.0 -pthread
>>>> -Wl,-R/usr/pkg/lib -lglib-2.0 -lintl   -lz
>>>> config-host.mak:LIBS_QGA+=3D-lm -L/usr/pkg/lib -lgthread-2.0 -pthrea=
d
>>>> -Wl,-R/usr/pkg/lib -lglib-2.0 -lintl
>>>>
>>>>> tests/ivshmem-test.c also calls shm_open().  Does it work on NetBSD=
?
>>>>>
>>>>
>>>> Currently it's disabled, as it requires eventfd() (Linux API).
>>>
>>> You're right.
>>>
>>> So is the ivshmem device.  Hmm.  Why would anyone want ivshmem-server=
 on
>>> NetBSD?  Its purpose is connecting ivshmem-doorbell devices.  Could w=
e
>>> simply add the obvious CONFIG_IVSHMEM dependence to
>>> contrib/ivshmem-*/Makefile.objs?
>>>
>>
>> In general I would like to get feature parity on NetBSD, there is no
>> reason to blacklist this feature for !Linux hosts. However short term
>=20
> Feature parity is a worthy goal, but compiling ivshmem-server without
> ivshmem-doorbell doesn't gets you a feature, it gets you a binary you
> can't use for its intended purpose :)
>=20

$ qemu-system-x86_64 -device ? 2>&1 |grep ivsh
name "ivshmem", bus PCI, desc "Inter-VM shared memory (legacy)"
name "ivshmem-doorbell", bus PCI, desc "Inter-VM shared memory"
name "ivshmem-plain", bus PCI, desc "Inter-VM shared memory"

This will need definitely more work. We can disable ivshmem and hide the
problem, but it will be unveiled in future again and we will be back to
this discussion.

Also people can use NetBSD libc on Linux and share the same issue.

>> there are higher priorities, to fix build of pristine sources
>> (ivshmem-server is blocking here, not that I'm right now working on it=
s
>> correctness on the NetBSD host) and run test suite.
>=20
> Your priorities make sense.
>=20
>> I wanted to avoid overlinking, that would be caused by adding -lrt.
>> Adding dedicated -lrt check for shm_open(3) made sense to me, but I wi=
ll
>> go the requested route.
>=20
> Avoiding overlinking makes sense, too.
>=20



--7xvKgowkSXOJivihAUm1PTbdsGJK85xxB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJEhLAAoJEEuzCOmwLnZscnoP/jgc9XOEWH2CSxo2dALazNZA
G9RpwygV+ag9i/664Ni+Mz9U2DMffpCzmgX1uiBQjmsgb7H9qy9NJL1byUaEn6RD
uNgUZPEggUkUfnhM3dBvy1BNQJz7Xy7Co+vd9FBr9X9FSSEholQBUh0GDm30Zukl
oDcAPPjF3xBC4DMkW6wVgronwGShovM20q003PZBVJuN7mOt+0o9vj+YK/YNmfS4
ITUdUsCqB+k05uumjpRuU+8wSUvKemw59NauI6SYF+7bUmgxy0IGahFGq9fBgZd5
2Wy3DgdeGaB2+6yV7i1BozlK+liX1BgvJdaE6sh3Lax5B/q6ymrOj91vZzeuqjgr
NTDqr+PYhVkv36E572q1HTZnvVm13VQ4YVumrOubpsP6A4m8h3QLegwYGpfUMv4+
V3weu8TkVw2jtWm7m4UlXfkLbTB70HvB2Wizhbamg0biksG14onBSEkLBAIiAkyd
3yelBD0xDmdkqZ9PpMPkfB4UCeJDFdteVMzCLTNWSIgLmJvuTRpsBc0D/2btQ8u8
EpCuEGaeDgM+HmD73HGkTcHeA3HTKEAmy2Zxt3WjtfjHMQXcyMmSEBagjjewBf9x
1/oGD/zNPteV3HzggahboGP+akkb/nYw4z1y9cI3LAOryXsuSdRzo4lDBA3RliYt
hBM4xT4RsC2hsq3+QhrX
=ztfj
-----END PGP SIGNATURE-----

--7xvKgowkSXOJivihAUm1PTbdsGJK85xxB--
