Received: from eggs.gnu.org ([2001:4830:134:3::10]:59881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceITz-00041t-GW
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceITu-0005Xu-KD
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:36:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ceITu-0005XW-Bf
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:36:06 -0500
References: <cover.1487139038.git.ben@skyportsystems.com>
	<678c203f-3768-7e65-6e48-6729473b6ffa@redhat.com>
	<20170215220837-mutt-send-email-mst@kernel.org>
	<e7e9cf57-a5b4-4f2b-36e5-3e08dee70d68@redhat.com>
	<088D760B-A48E-4B79-9177-C63753C306D6@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c45ee0ad-3aff-95b6-9e33-31e9a426bae0@redhat.com>
Date: Thu, 16 Feb 2017 10:36:02 +0100
MIME-Version: 1.0
In-Reply-To: <088D760B-A48E-4B79-9177-C63753C306D6@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/7] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com

On 02/16/17 07:10, Ben Warren wrote:
>=20
>> On Feb 15, 2017, at 12:52 PM, Laszlo Ersek <lersek@redhat.com> wrote:
>>
>> On 02/15/17 21:09, Michael S. Tsirkin wrote:
>>> On Wed, Feb 15, 2017 at 08:47:48PM +0100, Laszlo Ersek wrote:
>>
>> [snip]
>>
>>>> For patches #1, #3, #4 and #5:
>>>>
>>>> Tested-by: Laszlo Ersek <lersek@redhat.com>
>>>>
>>>> I'll soon post the OVMF patches.
>>>>
>>>> Thanks!
>>>> Laszlo
>>>
>>>
>>> How do you feel about Igor's request to change WRITE_POINTER to add
>>> offset in there, so guest can pass in the address of GUID and
>>> not start of table? Would that be a lot of work to add?
>>
>> I think it's doable in practice: simply add a constant from the comman=
d
>> itself, for passing the value back to QEMU, and also for saving the
>> fw_cfg write commend for S3 resume time.
>>
>> But, I disagree with it from a design POV.
>>
>> Igor's point is:
>>
>>> Math complicates QEMU code though and not only QMEMU but AML code as
>>> well.
>>
>> As I understand it, the goal is to push the addition to the firmware
>> (which is "one place"), rather than having to implement it twice in
>> QEMU, i.e., in two places ((a) native QEMU logic, (b) AML generator).
>>
>> Here's my counter-argument:
>>
>> (a) As I mentioned earlier, assume a complex communication structure
>> between the guest OS and QEMU. Currently our shared structure consists
>> of a single field (the GUID), but next time it might contain several f=
ields.
>>
>> For such a multi-field shared structure, QEMU will have to do manual
>> offsetting into the guest RAM anyway, for accessing fields F1, F2, and
>> F3. We will not create three separate WRITE_POINTER commands and let t=
he
>> firmware calculate and return the absolute GPAs of the fields F1, F2 a=
nd
>> F3. Instead, there will be one WRITE_POINTER command, and QEMU will do
>> the offsetting manually, minimally for fields F2 and F3.
>>
>> "src_offset" looks tempting now only because we have a shared structur=
e
>> with only one field, the GUID at offset 40 decimal.
>>
>> (b) Regarding the runtime addition in the AML code:
>>
>> As discussed before, the main reason *now*, for not pointing VGIA (and
>> other named integer objects) with ADD_POINTER commands directly to
>> "meaningful" fields, is that OVMF probes the targets of ADD_POINTER
>> commands for patterns that look like ACPI table headers. And, for the
>> time being, we want to suppress any mis-recognitions by prepending som=
e
>> padding.
>>
>> Igor was right to dislike this, and we agreed that *down the road* we
>> should add allocation flags, or further allocation commands, to suppla=
nt
>> this kind of heuristics in OVMF. But:
>>
>> - we don't have time to do it now, plus
>>
>> - please observe that the runtime addition in AML relates to the
>>  ADD_POINTER and the ALLOCATE commands. It does not relate to
>>  WRITE_POINTER at all.
>>
>>  Whatever we change on WRITE_POINTER will do nothing for suppressing
>>  OVMF's table header probing -- because that is tied to ADD_POINTER
>>  --, therefore WRITE_POINTER tweaks cannot eliminate the "need to add"
>>  in AML.
>>
>>
>> In summary, I think the proposed WRITE_POINTER modification is
>> implementable, but I think it will not pay off, because:
>>
>> (a) for QEMU logic, it will not prove useful as soon as we have a
>> multi-field shared structure (QEMU will have to add field offsets anyw=
ay),
>>
>> (b) and for eliminating the AML addition (which is a consequence of th=
e
>> current ADD_POINTER handling in OVMF), it does nothing.
>>
> OK Laszlo, in v7 (imminent)  I went ahead and implemented this
> src_offset.  If you are truly dead-set against it, it=E2=80=99s not ver=
y hard
> to remove.  To me it seems pretty harmless.

I'd like to hear Igor's opinion about my counter-argument above.

It would be a fair bit of work in OVMF:
- it introduces a new addition which has to be range checked (the sum
  cannot overflow either the pointer object or the size of the
  pointed-to blob),
- if the range check fails, that's a new error condition that needs
  handling,
- in edk2 we document error conditions carefully, so it affects
  documentation too, for the function that processes WRITE_POINTER,
- I'd have to redo all the testing.

After I post the OVMF patches, we can count on about one week of review
time (assuming I don't have to post a v2, that is!). That comes pretty
close to the end of February, which is when I want to do a downstream
OVMF rebase. (I can't do it in March due to a conference, and then it's
too late.) The downstream rebase will take a few days too. I would have
preferred to post the OVMF patches near the beginning of this week.

So, as I said, it is implementable, I'm not "dead-set" against it, but
the price for me to pay is definitely not zero. And, as it stands, I
disagree with the design -- there don't seem to be any general benefits.

I'd like to hear back from Igor. If he convincingly refutes my argument,
I'm game.

Thanks,
Laszlo
