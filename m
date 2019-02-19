Received: from eggs.gnu.org ([209.51.188.92]:33739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw7KU-0005HU-RK
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw7KR-0005U3-Dc
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:29:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gw7KQ-0004y3-UE
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:29:03 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
	<ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
	<BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
	<87ftsl2clg.fsf@dusky.pond.sub.org>
	<91720BD9-D5A6-4457-BC99-D2132550BEDA@oberlin.edu>
	<87ef84z4v6.fsf@dusky.pond.sub.org>
	<62E7EC09-CB88-4802-9D28-45B06C020614@oberlin.edu>
Date: Tue, 19 Feb 2019 16:28:22 +0100
In-Reply-To: <62E7EC09-CB88-4802-9D28-45B06C020614@oberlin.edu> (Stephen
	Checkoway's message of "Tue, 19 Feb 2019 09:42:21 -0500")
Message-ID: <87imxfssq1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Stephen Checkoway <stephen.checkoway@oberlin.edu> writes:

> On Feb 19, 2019, at 01:09, Markus Armbruster <armbru@redhat.com> wrote:
>
>> Stephen Checkoway <stephen.checkoway@oberlin.edu> writes:
>> 
>>> On Feb 18, 2019, at 13:08, Markus Armbruster <armbru@redhat.com> wrote:
>>> 
>>>> Any chance you could do multiple region support, too?
>>> 
>>> Can you point me at the data sheet for a flash chip with multiple region support? For my purposes, I only need the features I mentioned, but if it's a simple change, I'll consider it.
>> 
>> I'm not familiar with CFI pflash, but I can operate a search engine.
>> Have a look at page 27 and 56 of
>> 
>> https://media.digikey.com/pdf/Data%20Sheets/Intel%20PDFs/28F160C3,320C3,640C3,800C3%20(x16).pdf
>> 
>> and tell us whether it's helpful.
>
> That's a flash chip that uses the Intel command set (pflash_cfi01.c in
> qemu), I'm only touching the AMD command set (pflash_cfi02.c). Also
> those pages seem to be about block locking, not multiple regions.
>
> I'm not entirely sure what you meant by multiple regions. If you meant
> blocks* having different sizes (usually in the top or bottom of the
> flash as boot blocks), then I've implemented that (the nonuniform
> sectors* I mentioned in my first email).
>
> * Some flash chips differentiate between sectors and blocks. E.g., the
> flash chip used by hw/arm/musicpal.c
> <http://ww1.microchip.com/downloads/en/DeviceDoc/SST39VF6401B-SST39VF6402B-64-Mbit-x16-Multi-Purpose-Flash-Plus-Data-Sheet-DS20005008C.pdf>
> has sectors and blocks with separate erase commands. Qemu treats these
> the same and does not support separate erase commands.

My terminology might be confused...

Let me backtrack a bit an explain my use case.  On physical PCs, the
single flash chip is commonly configured to have a read-only part and a
read/write part.  The read-only part holds UEFI code, and the read-write
part holds its persistent state.

Since our virtual flash chips lack this feature, our virtual PCs have
*two* of them: one configured read-only, and one configured read/write.
Cleaning that up would be nice.

The comment "It does not implement software data protection as found in
many real chips" in both pflash_cfi0*.c might be referring to this
missing feature.

>> I think a test would be quite welcome even if it only tests what's
>> testable now with reasonable effort.
>
> I used Thomas Huth's suggestion for testing the autoselect, CFI,
> sector erase, chip erase, programming, and reset commands. I'll see
> how much I can test.

Sounds good!
