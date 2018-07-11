Received: from eggs.gnu.org ([2001:4830:134:3::10]:59201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdDKB-0003hY-Sq
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 07:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdDK7-0000rE-T2
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 07:30:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:43622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fdDK7-0000qR-EL
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 07:30:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fdDK6-0001Bg-5v
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 11:30:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F0A2C2E80CE
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 11:30:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jul 2018 11:18:48 -0000
From: Max Reitz <1474263@bugs.launchpad.net>
Reply-To: Bug 1474263 <1474263@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150714085742.25422.46124.malonedeb@chaenomeles.canonical.com>
Message-Id: <153130792856.32266.13015234927660429956.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1474263] Re: "Image format was not specified"
 warning should be suppressed for the vvfat (and probably nbd) driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yes, it does appear, you just need to make vvfat rw:

$ qemu-system-x86_64 -drive file.driver=3Dvvfat,file.dir=3Dfoo,file.rw=3Don
vvfat foo chs 1024,16,63
WARNING: Image format was not specified for 'json:{"dir": "foo", "driver": =
"vvfat", "rw": "on"}' and probing guessed raw.
         Automatically detecting the format is dangerous for raw images, wr=
ite operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.

(The warning is not shown with R/O devices because they don=E2=80=99t have =
the
security issue.)

My point hasn=E2=80=99t changed, though,  I fundamentally agree with the po=
ints
in this report, but I don=E2=80=98t think =E2=80=9Cfixing=E2=80=9D this is =
worth it.

For NBD, =E2=80=9Cfixing=E2=80=9D it would mean potentially breaking existi=
ng use cases
(which I still don=E2=80=99t see the point of, but there=E2=80=99s no point=
 in breaking
them just to make a warning disappear).

For vvfat, there are three things: First of all, I don=E2=80=99t like it ve=
ry much, so as I said, I=E2=80=99d rather deprecate it altogether (though t=
his BZ shows we shouldn=E2=80=99t do that).
Secondly, in order for the warning to disappear, a protocol driver would ne=
ed to enforce a certain format on top when probing.  That would require a b=
it of new infrastructure, although I have to admit it wouldn=E2=80=99t be i=
mpossible.
Thirdly, I suppose most people use vvfat with block device options like don=
e in the bug report?  In that case, it is trivial to add a format=3Draw (or=
 driver=3Draw), exactly like the warning suggests.

(Though you can use vvfat with a plain filename, too:

$  qemu-system-x86_64 fat:32:rw:foo
qemu-system-x86_64: warning: FAT32 has not been tested. You are welcome to =
do so!
vvfat foo chs 1024,16,63
WARNING: Image format was not specified for 'json:{"fat-type": 32, "dir": "=
foo", "driver": "vvfat", "floppy": false, "rw": true}' and probing guessed =
raw.
         Automatically detecting the format is dangerous for raw images, wr=
ite operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.

)

So all in all I think this is indeed kind of a bug (at least it=E2=80=99s a
nuisance that could be better), fixing it would not be impossible, but
it=E2=80=99s just very low on at least my priority list (probably somewhere
around =E2=80=9Cimplement bdrv_refresh_filename() for vvfat so you don't ge=
t the
json:{} filenames you can see above=E2=80=9D).

Max

** Changed in: qemu
       Status: Incomplete =3D> Opinion

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1474263

Title:
  "Image format was not specified" warning should be suppressed for the
  vvfat (and probably nbd) driver

Status in QEMU:
  Opinion

Bug description:
  Running

  qemu -drive file.driver=3Dvvfat,file.dir=3D.

  displays

  WARNING: Image format was not specified for 'json:{"dir": ".", "driver": =
"vvfat"}' and probing guessed raw.
           Automatically detecting the format is dangerous for raw images, =
write operations on block 0 will be restricted.
           Specify the 'raw' format explicitly to remove the restrictions.

  However, since "images" provided by the vvfat driver are always raw
  (and the first sector isn't writeable in any case), this warning is
  superfluous and should not be displayed.

  A similar warning is displayed for NBD devices; I suspect it should be
  also disabled for similar reasons, but I'm not sure if serving non-raw
  images is actually a violation of the protocol. qemu-nbd translates
  them to raw images, for what it's worth, even if it may be suppressed
  with -f raw.

  Noticed on 2.3.0; the code that causes this behaviour is still
  apparently present in today's git master
  (f3a1b5068cea303a55e2a21a97e66d057eaae638). Speaking of versions: you
  may want to update the copyright notice that qemu -version displays.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1474263/+subscriptions
