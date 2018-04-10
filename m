Received: from eggs.gnu.org ([2001:4830:134:3::10]:51160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5s0b-0000C5-UN
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5s0W-0001KU-8L
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:04:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35206 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f5s0W-0001KK-3B
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:04:16 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
	<6bfdae78-909f-e7ad-b0f0-25f76dfd81f7@redhat.com>
	<20180410055914.3ak6niwxjkpph26u@sirius.home.kraxel.org>
	<52191fc3-e4d1-e780-47a1-311df2a2f99e@redhat.com>
	<20180410095131.ynii6t3om753vl2t@sirius.home.kraxel.org>
	<20180410095500.GK5155@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f5635db3-4dbe-d1b5-1f2b-ffcb66f17243@redhat.com>
Date: Tue, 10 Apr 2018 14:04:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180410095500.GK5155@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 04/10/18 11:55, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Apr 10, 2018 at 11:51:31AM +0200, Gerd Hoffmann wrote:
>>>> Hmm, I'm wondering whenever it is useful to model things this way.  =
It's
>>>> not like you can actually configure things for -bios seabios.rom or
>>>> -kernel uboot.elf.  Only pflash allows to actually configure things,=
 and
>>>> there are not that many useful combinations.  The code needs
>>>> Read+Execute.  Allowing Write could be useful in theory, to allow th=
e
>>>> guest doing firmware updates.  But I think nobody actually does that=
, so
>>>> in practice it is fixed.  The varstore can have different permission=
s,
>>>> but it's only two useful combinations.  Either allow access
>>>> unconditionally, or allow access in secure contect (aka smm) only.
>>>
>>> (I hope I understand your point right:)
>>>
>>> I'm also fine if we simply define a fixed (but extensible) set of
>>> mapping methods, basically a new enum type, that simply tells libvirt=
d
>>> what this firmware *is*. IOW, directly reference a mapping method we
>>> know libvirt implements, rather than give vague hints.
>>>
>>> This could repurpose SystemFirmwareType, but it should become more
>>> detailed. I'm thinking like:
>>> - ovmf: split files without requiring SMM
>>> - ovmf_smm: split files with SMM requirement
>>> - seabios: exactly that
>>> - ... other things others suggest.
>>
>> I wouldn't name them by firmware, that is misleading.  Basically we ha=
ve
>> three cases:
>>
>>   (1) single firmware image (seabios, OVMF.fd, ...).
>>   (2) split firmware image (OVMF_{CODE,VARS}.fd), where vars can be
>>       writable unconditinally.
>>   (3) split firmware image, where access to vars should be restricted
>>       to smm mode.
>>
>> (2) + (3) requires pflash.  (1) works with both pflash and -bios.
>=20
> A big chunk of the data in the schema looks specific to the pflash
> case, but this is not expressed except in the docs. Most of the time
> with QAPI when we have data that is only relevant in certain types,
> we use a discriminated union to describe it. It feels like a unioon
> approach could be better suited to this

I used a discriminated union specifically for pflash options in RFCv0,
which I didn't post. I felt that it wasn't flexible enough. :)

Laszlo
