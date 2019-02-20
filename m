Received: from eggs.gnu.org ([209.51.188.92]:55880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gwNlX-0002HT-2V
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gwNlU-0000NJ-Vb
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:02:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gwNlR-0000Cm-4R
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:02:03 -0500
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
	<ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
	<BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
	<87ftsl2clg.fsf@dusky.pond.sub.org>
	<91720BD9-D5A6-4457-BC99-D2132550BEDA@oberlin.edu>
	<87ef84z4v6.fsf@dusky.pond.sub.org>
	<62E7EC09-CB88-4802-9D28-45B06C020614@oberlin.edu>
	<87imxfssq1.fsf@dusky.pond.sub.org>
	<E3178A67-9CFC-4CD5-921F-4EE5CCB46F62@oberlin.edu>
	<87y36boe78.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <fdec6838-6051-427d-6192-f68a76171915@redhat.com>
Date: Wed, 20 Feb 2019 09:55:30 +0100
MIME-Version: 1.0
In-Reply-To: <87y36boe78.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org

On 02/19/19 18:55, Markus Armbruster wrote:
> Stephen Checkoway <stephen.checkoway@oberlin.edu> writes:
>=20
>>> On Feb 19, 2019, at 10:28, Markus Armbruster <armbru@redhat.com> wrot=
e:
>>>
>>> My terminology might be confused...
>>>
>>> Let me backtrack a bit an explain my use case.  On physical PCs, the
>>> single flash chip is commonly configured to have a read-only part and=
 a
>>> read/write part.  The read-only part holds UEFI code, and the read-wr=
ite
>>> part holds its persistent state.
>>>
>>> Since our virtual flash chips lack this feature, our virtual PCs have
>>> *two* of them: one configured read-only, and one configured read/writ=
e.
>>> Cleaning that up would be nice.
>>>
>>> The comment "It does not implement software data protection as found =
in
>>> many real chips" in both pflash_cfi0*.c might be referring to this
>>> missing feature.
>>
>> I understand now, thank you for explaining. I noticed the comments abo=
ut software data protection in the code, but I didn't investigate.
>>
>> >From a quick look at <https://www.cypress.com/file/195291/download> T=
able 27 on page 8, I see there are at least 4 different protection modes.=
 I think the most common one (based on my reading of a handful of data sh=
eets for flash chips) is the high voltage one. Essentially, there are sec=
tor groups that can be locked/unlocked using high voltage. It seems easy =
enough to model this by configuring sectors as locked and refusing to era=
se or program them.
>>
>> Software command locking would probably involve implementing a few add=
itional commands.
>>
>> I'm not sure what the others are.
>>
>> Which locking method do you need?
>=20
> L=C3=A1szl=C3=B3, Philippe, what would you prefer to work with in OVMF?

I would strongly prefer if the guest-side view wouldn't change at all.

IOW, I don't have any useful input on extensions to the current command
set; what matters to me is that OVMF please not be forced to make use of
the new commands (and that the privilege differences wrt. SMM remain
functional). We've avoided version lock-in between OVMF and QEMU for a
great long time now, thanks to the ACPI linker/loader; I wouldn't like
to see version dependencies reintroduced in other areas.

Thanks
Laszlo
