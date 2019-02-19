Received: from eggs.gnu.org ([209.51.188.92]:45345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw2NK-0004D9-7d
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw2NI-0006sv-Ow
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:11:42 -0500
References: <1550058881-16351-1-git-send-email-thuth@redhat.com>
	<3374c532-c885-d26e-2d34-0454943c3905@redhat.com>
	<28c77705-33c2-f10b-9dae-331bc15c9596@redhat.com>
	<20190219075333.GA4727@localhost.localdomain>
	<d7a55ce9-a83c-12fe-fd16-d45dff67630a@redhat.com>
	<20190219093716.GF4727@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6d9d1a3c-7310-3134-ea5c-a03d451b8982@redhat.com>
Date: Tue, 19 Feb 2019 11:11:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190219093716.GF4727@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Failing iotests in CI (was: Add a gitlab-ci file
 for Continuous Integration testing on Gitlab)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, berrange@redhat.com

On 19/02/2019 10.37, Kevin Wolf wrote:
> Am 19.02.2019 um 10:04 hat Thomas Huth geschrieben:
>> On 19/02/2019 08.53, Kevin Wolf wrote:
[...]
>>> Which are the cases that fail for you with '--disable-tcg'?
>>
>> These tests are failing: 087 169 188 232 235 238
>=20
> Hm, 087 and 232 just do something like:
>=20
>     $QEMU_PROG -nodefaults -machine accel=3Dqtest -nographic \
>                -qmp stdio -serial none \
>                ...some -drive and -object options...
>=20
> This should be fine with --disable-tcg, I think?
>=20
> 169 runs a VM, but I don't see anything that makes it use TCG.
>=20
> 188 doesn't even run QEMU at all, it's only qemu-io. I don't see how
> this could be possibly related to --disable-tcg.

087 and 188 obviously simply lack a check for the required crypto support=
.


Output of 087:

087                [08:33:55] [08:33:56] - output mismatch (see 087.out.b=
ad)
--- /builds/huth/qemu/tests/qemu-iotests/087.out	2019-02-19 08:23:54.0000=
00000 +0000
+++ /builds/huth/qemu/tests/qemu-iotests/087.out.bad	2019-02-19 08:33:56.=
000000000 +0000
@@ -46,12 +46,13 @@
=20
 =3D=3D=3D Encrypted image LUKS =3D=3D=3D
=20
+qemu-img: TEST_DIR/t.IMGFMT: No crypto library supporting PBKDF in this =
build: Function not implemented
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encrypt.fo=
rmat=3Dluks encrypt.key-secret=3Dsec0
 Testing:
 QMP_VERSION
 {"return": {}}
 {"return": {}}
-{"return": {}}
+{"error": {"class": "GenericError", "desc": "No encryption in image head=
er, but options specified format 'luks'"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}


And the output of 188:

188                [08:34:53] [08:34:54] - output mismatch (see 188.out.b=
ad)
--- /builds/huth/qemu/tests/qemu-iotests/188.out	2019-02-19 08:23:54.0000=
00000 +0000
+++ /builds/huth/qemu/tests/qemu-iotests/188.out.bad	2019-02-19 08:34:54.=
000000000 +0000
@@ -1,4 +1,5 @@
 QA output created by 188
+qemu-img: TEST_DIR/t.IMGFMT: No crypto library supporting PBKDF in this =
build: Function not implemented
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 encrypt.for=
mat=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
=20
 =3D=3D reading whole image =3D=3D
@@ -14,5 +15,6 @@
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 =3D=3D verify open failure with wrong password =3D=3D
-can't open: Invalid password, cannot unlock any keyslot
+read 16777216/16777216 bytes at offset 0
+16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done


169 got killed via abort():

169                [08:34:39] [08:34:46] [failed, exit status 1] - output=
 mismatch (see 169.out.bad)
--- /builds/huth/qemu/tests/qemu-iotests/169.out	2019-02-19 08:23:54.0000=
00000 +0000
+++ /builds/huth/qemu/tests/qemu-iotests/169.out.bad	2019-02-19 08:34:46.=
000000000 +0000
@@ -1,5 +1,29 @@
-....................
+WARNING:qemu:qemu received signal 6: /builds/huth/qemu/tests/qemu-iotest=
s/../../x86_64-softmmu/qemu-system-x86_64 -chardev socket,id=3Dmon,path=3D=
/tmp/qemu-iotests-quick-25045/tmpGQOExQ/qemua-13044-monitor.sock -mon cha=
rdev=3Dmon,mode=3Dcontrol -display none -vga none -qtest unix:path=3D/tmp=
/qemu-iotests-quick-25045/qemua-13044-qtest.sock -machine accel=3Dqtest -=
nodefaults -machine accel=3Dqtest -drive if=3Dvirtio,id=3Ddrive0,file=3D/=
tmp/qemu-iotests-quick-25045/disk_a,format=3Dqcow2,cache=3Dwriteback
[...]

No clue why.


232 is also strange, no idea what is going on here:

232                [08:38:53] [08:38:56] - output mismatch (see 232.out.b=
ad)
--- /builds/huth/qemu/tests/qemu-iotests/232.out	2019-02-19 08:23:54.0000=
00000 +0000
+++ /builds/huth/qemu/tests/qemu-iotests/232.out.bad	2019-02-19 08:38:56.=
000000000 +0000
@@ -21,13 +21,13 @@
 NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
 NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
=20
-QEMU_PROG: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone,read-=
only=3Doff,auto-read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Perm=
ission denied
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-
-QEMU_PROG: -drive driver=3Dfile,file=3DTEST_DIR/t.IMGFMT,if=3Dnone,auto-=
read-only=3Doff: Could not open 'TEST_DIR/t.IMGFMT': Permission denied
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
-NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)
+NODE_NAME: TEST_DIR/t.IMGFMT (file)

>> 235 and 238 apparently try to use accel=3Dkvm, so they likely should n=
ot
>> be in the "quick" group.
>=20
> Yes, I agree.
>=20
> Or maybe we should check again why they need kvm at all, in theory they
> shouldn't. They are throttling tests, so the obvious reason seems to be
> that they need a running clock. Using -M qtest and advancing the clock
> manually could do the trick then (and would even be more reliable).
>=20
>> The other tests seem to fail for different reasons, see:
>>
>>  https://gitlab.com/huth/qemu/-/jobs/163680780
>>
>> Some of them apparently need encryption to be enabled (as already
>> mentioned by Cleber in his patch) - thus should they really be in the
>> quick check, too? Or could they at least check whether QEMU has been
>> built with encryption?
>=20
> The correct solution would be that they detect the situation
> automatically and skip the test by calling _notrun.
>=20
> I'm not sure how to detect if a given QEMU binary supports encryption,
> but Dan might know.
>=20
>> By the way, 235 and 238 also fail on my normal laptop with RHEL7:
>>
>> 235 2s ...        [07:29:31] [07:29:31] [failed, exit status 1] - outp=
ut
>> mismatch (see 235.out.bad)
>> --- /home/thuth/devel/qemu/tests/qemu-iotests/235.out	2019-02-19
>> 07:14:45.000000000 +0100
>> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/235.out.bad	2019-02-=
19
>> 07:29:31.000000000 +0100
>> @@ -1,3 +1,14 @@
>> -{"return": {}}
>> -{"return": {}}
>> -{"return": {}}
>> +Traceback (most recent call last):
>> +  File "235", line 56, in <module>
>> +    vm.launch()
>> +  File
>> "/home/thuth/devel/qemu/tests/qemu-iotests/../../scripts/qemu.py", lin=
e
>> 303, in launch
>> +    self._launch()
>> +  File
>> "/home/thuth/devel/qemu/tests/qemu-iotests/../../scripts/qemu.py", lin=
e
>> 329, in _launch
>> +    self._post_launch()
>> +  File
>> "/home/thuth/devel/qemu/tests/qemu-iotests/../../scripts/qemu.py", lin=
e
>> 274, in _post_launch
>> +    self._qmp.accept()
>> +  File
>> "/home/thuth/devel/qemu/tests/qemu-iotests/../../scripts/qmp/qmp.py",
>> line 157, in accept
>> +    return self.__negotiate_capabilities()
>> +  File
>> "/home/thuth/devel/qemu/tests/qemu-iotests/../../scripts/qmp/qmp.py",
>> line 73, in __negotiate_capabilities
>> +    raise QMPConnectError
>> +qmp.qmp.QMPConnectError
>> 236 0s ...        [07:29:31] [07:29:31]
>> 237                [07:29:31] [07:29:31] [not run]
>>         237 -- not suitable for this image format: qcow2
>> 238                [07:29:31] [07:29:31] [failed, exit status 1] -
>> output mismatch (see 238.out.bad)
>> --- /home/thuth/devel/qemu/tests/qemu-iotests/238.out	2019-02-19
>> 07:17:39.000000000 +0100
>> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/238.out.bad	2019-02-=
19
>> 07:29:31.000000000 +0100
>> @@ -1,6 +1,14 @@
>> -{"return": {}}
>> -{"return": {}}
>> -{"return": {}}
>> -{"return": {}}
>> -{"return": {}}
>> -{"return": {}}
>> +Traceback (most recent call last):
>> +  File "238", line 37, in <module>
>> +    vm.launch()
>> +  File
>> "/home/thuth/devel/qemu/tests/qemu-iotests/../../scripts/qemu.py", lin=
e
>> 303, in launch
>> +    self._launch()
>> +  File
>> "/home/thuth/devel/qemu/tests/qemu-iotests/../../scripts/qemu.py", lin=
e
>> 329, in _launch
>> +    self._post_launch()
>> +  File
>> "/home/thuth/devel/qemu/tests/qemu-iotests/../../scripts/qemu.py", lin=
e
>> 274, in _post_launch
>> +    self._qmp.accept()
>> +  File
>> "/home/thuth/devel/qemu/tests/qemu-iotests/../../scripts/qmp/qmp.py",
>> line 157, in accept
>> +    return self.__negotiate_capabilities()
>> +  File
>> "/home/thuth/devel/qemu/tests/qemu-iotests/../../scripts/qmp/qmp.py",
>> line 73, in __negotiate_capabilities
>> +    raise QMPConnectError
>> +qmp.qmp.QMPConnectError
>>
>> Any ideas what might be going on here?
>=20
> I think it's most likely that QEMU just prints an error message on
> startup and exits.
Right, I finally found the issue:

qemu-system-x86_64: -machine accel=3Dkvm: No accelerator found

I apparently compiled my QEMU with --disable-kvm at one point in time and
forgot to enable it later again. =3D=3D> These tests should really check =
whether
KVM is available in QEMU before they blindly use this feature.

 Thomas
