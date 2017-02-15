Received: from eggs.gnu.org ([2001:4830:134:3::10]:56898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ce6ZT-0001gq-1d
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 15:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ce6ZP-0001WJ-56
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 15:53:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ce6ZO-0001W7-SW
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 15:52:59 -0500
References: <cover.1487139038.git.ben@skyportsystems.com>
	<678c203f-3768-7e65-6e48-6729473b6ffa@redhat.com>
	<20170215220837-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e7e9cf57-a5b4-4f2b-36e5-3e08dee70d68@redhat.com>
Date: Wed, 15 Feb 2017 21:52:55 +0100
MIME-Version: 1.0
In-Reply-To: <20170215220837-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 0/7] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: ben@skyportsystems.com, qemu-devel@nongnu.org, imammedo@redhat.com

On 02/15/17 21:09, Michael S. Tsirkin wrote:
> On Wed, Feb 15, 2017 at 08:47:48PM +0100, Laszlo Ersek wrote:

[snip]

>> For patches #1, #3, #4 and #5:
>>
>> Tested-by: Laszlo Ersek <lersek@redhat.com>
>>
>> I'll soon post the OVMF patches.
>>
>> Thanks!
>> Laszlo
> 
> 
> How do you feel about Igor's request to change WRITE_POINTER to add
> offset in there, so guest can pass in the address of GUID and
> not start of table? Would that be a lot of work to add?

I think it's doable in practice: simply add a constant from the command
itself, for passing the value back to QEMU, and also for saving the
fw_cfg write commend for S3 resume time.

But, I disagree with it from a design POV.

Igor's point is:

> Math complicates QEMU code though and not only QMEMU but AML code as
> well.

As I understand it, the goal is to push the addition to the firmware
(which is "one place"), rather than having to implement it twice in
QEMU, i.e., in two places ((a) native QEMU logic, (b) AML generator).

Here's my counter-argument:

(a) As I mentioned earlier, assume a complex communication structure
between the guest OS and QEMU. Currently our shared structure consists
of a single field (the GUID), but next time it might contain several fields.

For such a multi-field shared structure, QEMU will have to do manual
offsetting into the guest RAM anyway, for accessing fields F1, F2, and
F3. We will not create three separate WRITE_POINTER commands and let the
firmware calculate and return the absolute GPAs of the fields F1, F2 and
F3. Instead, there will be one WRITE_POINTER command, and QEMU will do
the offsetting manually, minimally for fields F2 and F3.

"src_offset" looks tempting now only because we have a shared structure
with only one field, the GUID at offset 40 decimal.

(b) Regarding the runtime addition in the AML code:

As discussed before, the main reason *now*, for not pointing VGIA (and
other named integer objects) with ADD_POINTER commands directly to
"meaningful" fields, is that OVMF probes the targets of ADD_POINTER
commands for patterns that look like ACPI table headers. And, for the
time being, we want to suppress any mis-recognitions by prepending some
padding.

Igor was right to dislike this, and we agreed that *down the road* we
should add allocation flags, or further allocation commands, to supplant
this kind of heuristics in OVMF. But:

- we don't have time to do it now, plus

- please observe that the runtime addition in AML relates to the
  ADD_POINTER and the ALLOCATE commands. It does not relate to
  WRITE_POINTER at all.

  Whatever we change on WRITE_POINTER will do nothing for suppressing
  OVMF's table header probing -- because that is tied to ADD_POINTER
  --, therefore WRITE_POINTER tweaks cannot eliminate the "need to add"
  in AML.


In summary, I think the proposed WRITE_POINTER modification is
implementable, but I think it will not pay off, because:

(a) for QEMU logic, it will not prove useful as soon as we have a
multi-field shared structure (QEMU will have to add field offsets anyway),

(b) and for eliminating the AML addition (which is a consequence of the
current ADD_POINTER handling in OVMF), it does nothing.

Thanks
Laszlo
