Received: from eggs.gnu.org ([2001:4830:134:3::10]:47831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1d2d6c-0007mH-2j
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1d2d6Y-0003HW-5D
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:28:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1d2d6X-0003HC-SB
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:28:34 -0400
References: <cover.1487286467.git.ben@skyportsystems.com>
	<5353279f68be14c63f049bc34902675290e45b1d.1487286467.git.ben@skyportsystems.com>
	<20170220154909.4a88bfed@nial.brq.redhat.com>
	<CAJ+F1CJ+KcBuhM8KEJtntELaZetciDWpmw9Rc00bWNFnAwJg4g@mail.gmail.com>
	<B6E1C323-080B-4E53-8104-DFDBACE72A64@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8eda513b-6a35-7d0c-e121-0f4d9f7bd436@redhat.com>
Date: Mon, 24 Apr 2017 14:28:27 +0200
MIME-Version: 1.0
In-Reply-To: <B6E1C323-080B-4E53-8104-DFDBACE72A64@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 7/8] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com

On 04/21/17 19:59, Ben Warren wrote:
> Hi,
>=20
>> On Apr 21, 2017, at 3:14 AM, Marc-Andr=C3=A9 Lureau <marcandre.lureau@=
gmail.com> wrote:
>>
>> Hi,
>>
>> Was this patch intentionally dropped from the series?
>>
>=20
> Good question.  I thought the whole patch series was pulled in, but it =
looks like this one was not.  I guess we=E2=80=99ll see what Michael has =
to say.

Unfortunately, the patch was lost due to a race condition in maintenance.

(1) The VMGENID unit test, added in this patch, can only succeed if the
SeaBIOS binary bundled with QEMU contains VMGENID patches as well. When
this v8 patch series was originally posted (Feb 16th), the SeaBIOS
binary bundled with QEMU wasn't ready for this patch. So the patch was
delayed / postponed.

(2) For that reason, Michael sent the PULL req with the *rest* of the
patches, on March 1st:

http://mid.mail-archive.com/1488435591-17882-1-git-send-email-mst@redhat.=
com

(3) Gerd updated the SeaBIOS binary meanwhile, to a revision that
contained Ben's matching bios patches:

$ git log v2.8.0..v2.9.0 -- pc-bios/bios.bin

commit 8779fccbef0c2e97fd6564ddf9f1df9fc724f2f0
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Tue Feb 28 09:52:32 2017 +0100

    seabios: update to 1.10.2 release

    git shortlog rel-1.10.1..rel-1.10.2
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    Ben Warren (5):
          QEMU DMA: Add DMA write capability
          romfile-loader: Switch to using named structs
          QEMU fw_cfg: Add command to write back address of file
          QEMU fw_cfg: Add functions for accessing files by key
          QEMU fw_cfg: Write fw_cfg back on S3 resume

    Kevin O'Connor (1):
          ps2port: Disable keyboard/mouse prior to resetting ps2 controll=
er

    Ladi Prosek (1):
          ahci: Set upper 32-bit registers to zero

    Paul Menzel (1):
          vgasrc: Increase debug level

    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

(4) In the end, the BIOS update commit, and the VMGENID v8 commits, are
*not* in an ancestor/descandant relationship either way -- they are
siblings:

  $ git-contains 42697d88de6b 8779fccbef0c
  42697d88de6b [42697d88de6b MAINTAINERS: Add VM Generation ID entries]
  NEITHER CONTAINS NOR IS CONTAINED BY
  8779fccbef0c [8779fccbef0c seabios: update to 1.10.2 release]

And then the patch missed v2.9.0.


I suggest to repost the patch now, and then maybe include it in 2.9.1
stable.

Thanks
Laszlo
