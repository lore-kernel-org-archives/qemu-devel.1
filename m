Received: from eggs.gnu.org ([2001:4830:134:3::10]:34602)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dDBYE-0001zd-Bc
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dDBYB-0006Dv-4Q
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:16:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:52368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dDBYA-0006Dc-NH
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:16:43 -0400
References: <20170513004616.25749-1-n54@gmx.com>
	<87a86crlg0.fsf@dusky.pond.sub.org>
	<a5bcd9dd-feb8-8083-30de-dec8d7139c96@gmx.com>
	<874lwd5rsx.fsf@dusky.pond.sub.org>
	<688e36b3-6707-c4e5-4f0c-3c7a5d0fa390@gmx.com>
	<87fufwjfqw.fsf@dusky.pond.sub.org>
	<93d4d9ae-ed35-e610-7343-8f0ef9e7efab@gmx.com>
	<87tw4by5kj.fsf@dusky.pond.sub.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <63271d29-0b55-dd7d-bcd6-ce0e7fe2cbbf@gmx.com>
Date: Tue, 23 May 2017 17:08:13 +0200
MIME-Version: 1.0
In-Reply-To: <87tw4by5kj.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w5KWb5IjnSRJrUJhPSeP6kigTNlAaLlaS"
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
--w5KWb5IjnSRJrUJhPSeP6kigTNlAaLlaS
From: Kamil Rytarowski <n54@gmx.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Message-ID: <63271d29-0b55-dd7d-bcd6-ce0e7fe2cbbf@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: Detect and use if there is
 required -lrt linking
References: <20170513004616.25749-1-n54@gmx.com>
 <87a86crlg0.fsf@dusky.pond.sub.org>
 <a5bcd9dd-feb8-8083-30de-dec8d7139c96@gmx.com>
 <874lwd5rsx.fsf@dusky.pond.sub.org>
 <688e36b3-6707-c4e5-4f0c-3c7a5d0fa390@gmx.com>
 <87fufwjfqw.fsf@dusky.pond.sub.org>
 <93d4d9ae-ed35-e610-7343-8f0ef9e7efab@gmx.com>
 <87tw4by5kj.fsf@dusky.pond.sub.org>
In-Reply-To: <87tw4by5kj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 23.05.2017 17:07, Markus Armbruster wrote:
> Kamil Rytarowski <n54@gmx.com> writes:
>=20
>> On 23.05.2017 07:37, Markus Armbruster wrote:
>>> Kamil Rytarowski <n54@gmx.com> writes:
>>>
>>>> On 22.05.2017 08:28, Markus Armbruster wrote:
>>>>> Kamil Rytarowski <n54@gmx.com> writes:
>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> Excuse me for delay, I missed this mail.
>>>>>
>>>>> No problem.
>>>>>
>>>>>> Please see in-line.
>>>>>>
>>>>>> On 17.05.2017 09:28, Markus Armbruster wrote:
>>>>>>> Kamil Rytarowski <n54@gmx.com> writes:
>>>>>>>
>>>>>>>> ivshmem-server makes use of the POSIX shared memory object inter=
faces.
>>>>>>>> This library is provided on NetBSD in -lrt (POSIX Real-time Libr=
ary).
>>>>>>>> Add ./configure check if there is needed -lrt linking for shm_op=
en()
>>>>>>>> and if so use it. Introduce new configure generated variable LIB=
S_SHMLIB.
>>>>>>>>
>>>>>>>> This fixes build issue on NetBSD.
>>>>>>>>
>>>>>>>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>>>>>>>> ---
>>>>>>>>  Makefile  |  1 +
>>>>>>>>  configure | 20 ++++++++++++++++++++
>>>>>>>>  2 files changed, 21 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/Makefile b/Makefile
>>>>>>>> index 31d41a7eae..3248cb53d7 100644
>>>>>>>> --- a/Makefile
>>>>>>>> +++ b/Makefile
>>>>>>>> @@ -473,6 +473,7 @@ ivshmem-client$(EXESUF): $(ivshmem-client-ob=
j-y) $(COMMON_LDADDS)
>>>>>>>>  	$(call LINK, $^)
>>>>>>>>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADD=
S)
>>>>>>>>  	$(call LINK, $^)
>>>>>>>> +ivshmem-server$(EXESUF): LIBS +=3D $(LIBS_SHMLIB)
>>>>>>>> =20
>>>>>>>>  module_block.h: $(SRC_PATH)/scripts/modules/module_block.py con=
fig-host.mak
>>>>>>>>  	$(call quiet-command,$(PYTHON) $< $@ \
>>>>>>>> diff --git a/configure b/configure
>>>>>>>> index 7c020c076b..50c3aee746 100755
>>>>>>>> --- a/configure
>>>>>>>> +++ b/configure
>>>>>>>> @@ -179,6 +179,7 @@ audio_pt_int=3D""
>>>>>>>>  audio_win_int=3D""
>>>>>>>>  cc_i386=3Di386-pc-linux-gnu-gcc
>>>>>>>>  libs_qga=3D""
>>>>>>>> +libs_shmlib=3D""
>>>>>>>>  debug_info=3D"yes"
>>>>>>>>  stack_protector=3D""
>>>>>>>> =20
>>>>>>>> @@ -4133,6 +4134,24 @@ elif compile_prog "" "$pthread_lib -lrt" =
; then
>>>>>>>>    libs_qga=3D"$libs_qga -lrt"
>>>>>>>>  fi
>>>>>>>> =20
>>>>>>>> +##########################################
>>>>>>>> +# Do we need librt for shm_open()
>>>>>>>> +cat > $TMPC <<EOF
>>>>>>>> +#include <sys/mman.h>
>>>>>>>> +#include <sys/stat.h>
>>>>>>>> +#include <fcntl.h>
>>>>>>>> +#include <stddef.h>
>>>>>>>> +int main(void) {
>>>>>>>> +  return shm_open(NULL, O_RDWR, 0644);
>>>>>>>> +}
>>>>>>>> +EOF
>>>>>>>> +
>>>>>>>> +if compile_prog "" "" ; then
>>>>>>>> +  :
>>>>>>>> +elif compile_prog "" "-lrt" ; then
>>>>>>>> +  libs_shmlib=3D"$libs_shmlib -lrt"
>>>>>>>> +fi
>>>>>>>> +
>>>>>>>>  if test "$darwin" !=3D "yes" -a "$mingw32" !=3D "yes" -a "$sola=
ris" !=3D yes -a \
>>>>>>>>          "$aix" !=3D "yes" -a "$haiku" !=3D "yes" ; then
>>>>>>>>      libs_softmmu=3D"-lutil $libs_softmmu"
>>>>>>>> @@ -5949,6 +5968,7 @@ echo "EXESUF=3D$EXESUF" >> $config_host_ma=
k
>>>>>>>>  echo "DSOSUF=3D$DSOSUF" >> $config_host_mak
>>>>>>>>  echo "LDFLAGS_SHARED=3D$LDFLAGS_SHARED" >> $config_host_mak
>>>>>>>>  echo "LIBS_QGA+=3D$libs_qga" >> $config_host_mak
>>>>>>>> +echo "LIBS_SHMLIB+=3D$libs_shmlib" >> $config_host_mak
>>>>>>>>  echo "TASN1_LIBS=3D$tasn1_libs" >> $config_host_mak
>>>>>>>>  echo "TASN1_CFLAGS=3D$tasn1_cflags" >> $config_host_mak
>>>>>>>>  echo "POD2MAN=3D$POD2MAN" >> $config_host_mak
>>>>>>>
>>>>>>> We already have a test for -lrt.
>>>>>>
>>>>>> Correct.
>>>>>>
>>>>>>>  It looks for timer_create() and
>>>>>>> clock_gettime().
>>>>>>
>>>>>>
>>>>>> timer_create(2) and clock_settime(2) are in libc on NetBSD.
>>>>>>
>>>>>>>  If we need -lrt,
>>>>>>
>>>>>> We need it just for shm_open(3).
>>>>>>
>>>>>>> we add it to LIBS and to LIBS_QGA.
>>>>>>> The latter because we don't use LIBS for qemu-ga:
>>>>>>>
>>>>>>>     qemu-ga$(EXESUF): LIBS =3D $(LIBS_QGA)
>>>>>>>
>>>>>>> This patch adds a second test for -lrt, to look for shm_open().  =
It adds
>>>>>>> -lrt to new variable LIBS_SHMLIB, which gets used only for
>>>>>>> ivshmem-server:
>>>>>>>
>>>>>>>     ivshmem-server$(EXESUF): LIBS +=3D $(LIBS_SHMLIB)
>>>>>>>
>>>>>>> Note that ivshmem-server already uses LIBS.
>>>>>>>
>>>>>>> Shouldn't we instead widen the existing test for -lrt to cover
>>>>>>> shm_open()?
>>>>>>>
>>>>>>
>>>>>> I will prepare patch in the requested way. I don't have preference=
=2E
>>>>>>
>>>>>>> Can you confirm that the existing test does not add -lrt to LIBS =
on
>>>>>>> NetBSD?
>>>>>>>
>>>>>>
>>>>>> config-host.mak:LIBS+=3D-lm -L/usr/pkg/lib -lgthread-2.0 -pthread
>>>>>> -Wl,-R/usr/pkg/lib -lglib-2.0 -lintl   -lz
>>>>>> config-host.mak:LIBS_QGA+=3D-lm -L/usr/pkg/lib -lgthread-2.0 -pthr=
ead
>>>>>> -Wl,-R/usr/pkg/lib -lglib-2.0 -lintl
>>>>>>
>>>>>>> tests/ivshmem-test.c also calls shm_open().  Does it work on NetB=
SD?
>>>>>>>
>>>>>>
>>>>>> Currently it's disabled, as it requires eventfd() (Linux API).
>>>>>
>>>>> You're right.
>>>>>
>>>>> So is the ivshmem device.  Hmm.  Why would anyone want ivshmem-serv=
er on
>>>>> NetBSD?  Its purpose is connecting ivshmem-doorbell devices.  Could=
 we
>>>>> simply add the obvious CONFIG_IVSHMEM dependence to
>>>>> contrib/ivshmem-*/Makefile.objs?
>>>>>
>>>>
>>>> In general I would like to get feature parity on NetBSD, there is no=

>>>> reason to blacklist this feature for !Linux hosts. However short ter=
m
>>>
>>> Feature parity is a worthy goal, but compiling ivshmem-server without=

>>> ivshmem-doorbell doesn't gets you a feature, it gets you a binary you=

>>> can't use for its intended purpose :)
>>>
>>
>> $ qemu-system-x86_64 -device ? 2>&1 |grep ivsh
>> name "ivshmem", bus PCI, desc "Inter-VM shared memory (legacy)"
>> name "ivshmem-doorbell", bus PCI, desc "Inter-VM shared memory"
>> name "ivshmem-plain", bus PCI, desc "Inter-VM shared memory"
>>
>> This will need definitely more work. We can disable ivshmem and hide t=
he
>> problem, but it will be unveiled in future again and we will be back t=
o
>> this discussion.
>>
>> Also people can use NetBSD libc on Linux and share the same issue.
>=20
> CONFIG_IVSHMEM defaults to CONFIG_EVENTFD.  If you compile with a
> toolchain that doesn't provide eventfd(), configure should deselect
> CONFIG_EVENTFD and thus CONFIG_IVSHMEM automatically.
>=20
> Having contrib/ivshmem* depend on CONFIG_IVSHMEM makes total sense.
> Looking forward to your patch.
>=20
> [...]
>=20

OK, I will prepare this way the needed patch.


--w5KWb5IjnSRJrUJhPSeP6kigTNlAaLlaS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJFBmAAoJEEuzCOmwLnZs+7IQAL2voTnwqpqCo+s55Uh+Lg4t
8sKj++cu1Xohhp9geIhnXQJiFHOjCYObjm6EWeFdMfE0Iml43csTX+/6j36DHqxK
cbqDl8smC0NCb/Tx5m7MKcQ+DVaD64M/MCc2wo/cwiI2XptbMW4NZIY7u0Qxu3nH
04mMJ154e5GubVCu4YmtxkTpz9cxdtLHa38XPJQn5qhYBVnFNgJPp7euQtFrOAXF
g9rZSvulJqROfmNhiY2LW98QHMS2puWYvE8BPpXu64RmP7MXoYdBr6TLdpcgq/9+
h8mRk19Ehr43RhbueMDJ683NfFwFpgTjpACR5ZC8MpOwcep1GJFb+cnTKhvULIbv
qYOWGBdgusNPT2jVB79TDlcUixrpfZA6zKIqp50vTtpRZb6EFjz/WjyffDi6aOQa
+c+IP1iYrHOjHzCOHM9yOSxbCMMJ/r+LDvYQCLCEK4Xr3FOjzBrQct5/iDLp3IJ0
JPTi1m+e70dlf1Y9ODL8ERT3/l8hCxsVlBeGAOJFkCSwGuaAizYNa5Jpclu3Q5zw
kimUaKzAxbO/C6COCYFsEa98WEZ2s+Hc8dpCBerOHt1bC7YLyqE5jouTSBcaJ6fM
DCerTvNQYtZ3Q2QPpf1+Vctvk8nuXCYVssuEQ8RQS6SuXKAb0fvDae1QIRO7eaIa
oiPYYxEXT9FTgXLBrIVC
=lmlY
-----END PGP SIGNATURE-----

--w5KWb5IjnSRJrUJhPSeP6kigTNlAaLlaS--
