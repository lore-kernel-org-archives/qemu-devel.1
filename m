Received: from eggs.gnu.org ([2001:4830:134:3::10]:45678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dkcXC-00033V-SK
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtparkr@gmail.com>) id 1dkcXB-0007X7-TV
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:45:54 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:32778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mtparkr@gmail.com>) id 1dkcXB-0007Wv-P3
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:45:53 -0400
Received: by mail-yw0-x242.google.com with SMTP id u133so427341ywc.0
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 13:45:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-R4LoCXxqPKfnN_PuFD-W7+vSbjqsE7f17BEsGJoSfHQ@mail.gmail.com>
References: <20170821211320.7026-1-mtparkr@gmail.com>
	<CAFEAcA-R4LoCXxqPKfnN_PuFD-W7+vSbjqsE7f17BEsGJoSfHQ@mail.gmail.com>
From: Matt Parker <mtparkr@gmail.com>
Date: Wed, 23 Aug 2017 21:45:52 +0100
Message-ID: <CAOOZdTgoOj2_N7RQ5UB+5JV22Nhknt7k2MecGCCX2Kqb7edeuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] audio: intel-hda: do not use old_mmio
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 22 August 2017 at 09:44, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 21 August 2017 at 22:13, Matt Parker <mtparkr@gmail.com> wrote:
>> intel-hda is still using the old_mmio accessors for io.
>> This updates the device to use .read and .write accessors instead.
>
> Hi; thanks for this patch.
>
> It looks like you forgot to provide your Signed-off-by: line;
> we can't accept patches without one, I'm afraid.
>
>> ---
>>  hw/audio/intel-hda.c | 56 +++++++++-------------------------------------------
>>  1 file changed, 9 insertions(+), 47 deletions(-)
>>
>> diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
>> index 06acc98f7b..c0f002f744 100644
>> --- a/hw/audio/intel-hda.c
>> +++ b/hw/audio/intel-hda.c
>> @@ -1043,66 +1043,28 @@ static void intel_hda_regs_reset(IntelHDAState *d)
>>
>>  /* --------------------------------------------------------------------- */
>>
>> -static void intel_hda_mmio_writeb(void *opaque, hwaddr addr, uint32_t val)
>> +static void intel_hda_mmio_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>>  {
>>      IntelHDAState *d = opaque;
>>      const IntelHDAReg *reg = intel_hda_reg_find(d, addr);
>>
>> -    intel_hda_reg_write(d, reg, val, 0xff);
>> +    intel_hda_reg_write(d, reg, val, (1UL << (size * 8)) - 1);
>
> If size is 4 and 'unsigned long' is 32 bits (which it usually
> is) then this will shift off the end of the value, which is
> undefined behaviour.
>
> You could fix that by using '1ULL' instead of '1UL', but
> I'd suggest using MAKE_64BIT_MASK(0, size * 8) for this.
> (that macro is in "qemu/bitops.h", which you'll probably need
> to add a #include for.) Using the macro makes the intent a bit
> clearer and means nobody has to think about whether the bit
> shifting is doing what it's supposed to.
>
> I recommend putting a newline in the prototype to keep
> it below 80 lines and please the checkpatch script, too.
>
Thanks for the suggestions. I'll have a look into bitops.h and make
sure to run the checkpatch script before submitting any future
patches.

Matt
