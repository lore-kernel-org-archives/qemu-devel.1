Received: from eggs.gnu.org ([209.51.188.92]:42591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hK4AH-0006nb-3Z
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hK4AG-0006W3-3q
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:57:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hK4AF-0006Ti-5T
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:57:31 -0400
References: <20190420100056.116305-1-liq3ea@163.com>
	<20190420100056.116305-4-liq3ea@163.com>
	<a27cd912-4f58-55ac-1aae-e4999fa3d84d@redhat.com>
	<CAKXe6SJZWs7HtXutX6W3saDhaNDtVPMQEh2+s+9XiM3TtZqLdQ@mail.gmail.com>
	<20190425081519.n4leez6sz2wlvpla@sirius.home.kraxel.org>
	<CAKXe6SKvkJxauOPmBMS+CDPq9NS0qKpydkyOAuS7mHVrA8JVbQ@mail.gmail.com>
	<d773a58b-e33c-fa66-5afc-05bdc85efa53@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <15755c32-3b64-c72d-894b-5a8d55c49873@redhat.com>
Date: Fri, 26 Apr 2019 18:57:21 +0200
MIME-Version: 1.0
In-Reply-To: <d773a58b-e33c-fa66-5afc-05bdc85efa53@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] tests: fw_cfg: add reboot_timeout test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Li Qiang <liq3ea@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

On 04/25/19 12:23, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/25/19 10:29 AM, Li Qiang wrote:
>>
>>
>> Gerd Hoffmann <kraxel@redhat.com <mailto:kraxel@redhat.com>> =E4=BA=8E=
2019=E5=B9=B44=E6=9C=88
>> 25=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:15=E5=86=99=E9=81=93=
=EF=BC=9A
>>
>>     On Wed, Apr 24, 2019 at 09:16:56AM +0800, Li Qiang wrote:
>>     > Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>> =E4=BA=8E=
2019=E5=B9=B44
>>     =E6=9C=8824=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:29=E5=86=
=99=E9=81=93=EF=BC=9A
>>     >
>>     > > Is this endianess-safe? Or do you need to byteswap
>>     reboot_timeout if the
>>     > > host and guest endianess does not match?
>>     >
>>     > Good question!
>>     >
>>     > IIUC, the qemu fw_cfg store the 'file' entry data just in byte s=
tream.
>>
>>     No.=C2=A0 Integers are defined to be little endian.=C2=A0 See fw_c=
fg_add_i64() for
>>     example, there is an explicit cpu_to_le64() call for that.
>>
>>
>>
>> Yes, for the fw_cfg 'integer' entry it is stored as little endian.
>> But for the fw_cfg 'file' entry interpred as an integer, there is no
>> specify the endianess.
>=20
> I agree with Li, the endianess of 'reboot-timeout' is not clear.
>=20
> From docs/specs/fw_cfg.txt:
>=20
>   =3D=3D=3D All Other Data Items =3D=3D=3D
>=20
>   Please consult the QEMU source for the most up-to-date
>   and authoritative list of selector keys and their respective
>   items' purpose, format and writeability.
>=20
> So checking the git history, this code was introduced in commit
> ac05f3492421, very similar to commit 3d3b8303c6f8 for the
> 'boot-menu-wait' entry, which explicitely use little-endian, so I think
> it is safe to consider it little-endian and add a comment about its
> endianess (referring the previous commits in the patch description).

OVMF consumes "boot-menu-wait", so that one must remain LE.

OVMF doesn't consume "reboot-timeout", so I can't really comment on it.
I guess, if a named fw_cfg file that already exists doesn't explicitly
define the endiannesses of its integer fields, err for safety and opt
for LE.

For new fw_cfg files with integers in them, choose the endianness
explicitly and document it.

Thanks
Laszlo
