Received: from eggs.gnu.org ([2001:4830:134:3::10]:52456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1daYh6-00036o-0o
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1daYh2-0004mr-1F
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:38:32 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:37484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1daYh1-0004lu-SZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:38:27 -0400
Received: by mail-io0-x244.google.com with SMTP id c74so3920533iod.4
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 19:38:26 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.86860.1501079288.22738.qemu-devel@nongnu.org>
Date: Wed, 26 Jul 2017 22:38:23 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE3B497E-BA22-463D-A619-162797D96826@gmail.com>
References: <mailman.86860.1501079288.22738.qemu-devel@nongnu.org>
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>, "Daniel P. Berrange" <berrange@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, Programmingkid <programmingkidx@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael	S. Tsirkin" <mst@redhat.com>


> On Jul 26, 2017, at 10:28 AM, qemu-devel-request@nongnu.org wrote:
>=20
> Message: 3
> Date: Wed, 26 Jul 2017 15:30:20 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> To: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>, Phil Dennis-Jordan
> 	<lists@philjordan.eu>, "Daniel P. Berrange" =
<berrange@redhat.com>,
> 	Phil	Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com,
> 	"qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>,
> 	Programmingkid	<programmingkidx@gmail.com>, Richard Henderson
> 	<rth@twiddle.net>, "Michael	S. Tsirkin" <mst@redhat.com>
> Subject: Re: [Qemu-devel] Commit
> 	77af8a2b95b79699de650965d5228772743efe84 breaks Windows 2000 =
support
> Message-ID: <20170726153020.4c20b279@nial.brq.redhat.com>
> Content-Type: text/plain; charset=3DUS-ASCII
>=20
> On Wed, 26 Jul 2017 15:10:40 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>> On 26/07/2017 15:08, Igor Mammedov wrote:
>>> On Tue, 25 Jul 2017 18:23:22 +0200
>>> Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>=20
>>>> On 25/07/2017 18:14, Laszlo Ersek wrote: =20
>>>>>  "No regressions became apparent in tests with a range of Windows
>>>>>   (XP-10)"
>>>>>=20
>>>>> In theory, w2k falls within that range.   =20
>>>>=20
>>>> Nope, Windows 2000 is like NT 5.0, XP is like NT 5.1. :(
>>>>=20
>>>> One possibility is to fix it in SeaBIOS instead: if you get a 2.0 =
FADT
>>>> and an XSDT and no RSDT, it can build an RSDT and a 1.0 FADT =
itself,
>>>> patching the RSDT to point to it.
>>>>=20
>>>> It's a hack, but it's the only place I see to make it "just work".  =
And
>>>> it could be extended nicely in the future.
>>>>=20
>>>> All QEMU would have to do is to provide an XSDT _instead_ of an =
RSDT. =20
>>> I'd support it, however it would break migrated guests with old BIOS
>>> image in RAM on reboot. =20
>>=20
>> Why?  Shouldn't the old ACPI tables get migrated together with the =
old
>> BIOS?  Or are they rebuilt after reset?
> they are rebuild on reset, but I've been wrong
> Looking at SeaBIOS something similar to your suggestion also should =
work,
> if=20
>    RsdpAddr =3D find_acpi_rsdp();
> fails, current SeaBIOS falls back to its own ACPI tables.
>=20
> but it seems that we don't even need to go to that extent,
> all user have to do is to use "-no-acpi" CLI option with QEMU
> for any SeaBIOS to fallback to embedded legacy ACPI tables.
>=20
> Maybe we should just fix wiki
>  http://wiki.qemu.org/Windows2000
> to recommend using '-no-acpi' option when running w2k and
> leave PC machine at rev3 and mention it in release notes.
>=20
> Opinions?

I just tried booting Windows 2000 using '-no-acpi' and ended up in a =
restart loop.
Windows would look like its booting up properly then the screen is =
blanked.
Seabios text would appear on the screen for a fraction of a=20
second then be replaced by the Windows startup screen again. This =
repeats over and
over.
