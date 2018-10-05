Received: from eggs.gnu.org ([2001:4830:134:3::10]:49735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8QDy-0003Im-GM
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8QDx-0008AF-LW
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:32:58 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8QDx-00087z-9H
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:32:57 -0400
Received: by mail-oi1-x243.google.com with SMTP id e17-v6so10365380oig.12
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:32:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7e8077c8-9ee8-b06d-2c2b-ea788c5f9e69@redhat.com>
References: <1538744508-17108-1-git-send-email-thuth@redhat.com>
	<1538744508-17108-2-git-send-email-thuth@redhat.com>
	<7e8077c8-9ee8-b06d-2c2b-ea788c5f9e69@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 14:32:35 +0100
Message-ID: <CAFEAcA8i6TkP-nig+XrN2GQNOMmA+O=16EL523XsFT1N2VA=NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] cpu: Provide a proper prototype for
 target_words_bigendian() in a header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

On 5 October 2018 at 14:20, Laszlo Ersek <lersek@redhat.com> wrote:
> On 10/05/18 15:01, Thomas Huth wrote:
>> We've got three places already that provide a prototype for this
>> function in a .c file - that's ugly. Let's provide a proper prototype
>> in a header instead, with a proper description why this function should
>> not be used in most cases.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---

>> +/**
>> + * target_words_bigendian:
>> + * Returns true if the (default) endianness of the target is big endian,
>> + * false otherwise. Note that in target-specifc code, you can use

"specific"

>> + * TARGET_WORDS_BIGENDIAN directly instead. On the other hand, common
>> + * code should normally never need to know about the endianness of the
>> + * target, so please do *not* use this function unless you know very well
>> + * what you are doing!
>> + */
>> +bool target_words_bigendian(void);
>> +
>>  #ifdef NEED_CPU_H
>>
>>  #ifdef CONFIG_SOFTMMU
>> diff --git a/qom/cpu.c b/qom/cpu.c
>> index 92599f3..f774654 100644
>> --- a/qom/cpu.c
>> +++ b/qom/cpu.c
>> @@ -194,7 +194,6 @@ static bool cpu_common_debug_check_watchpoint(CPUState *cpu, CPUWatchpoint *wp)
>>      return true;
>>  }
>>
>> -bool target_words_bigendian(void);
>>  static bool cpu_common_virtio_is_big_endian(CPUState *cpu)
>>  {
>>      return target_words_bigendian();
>>
>
> This makes sense to me. First I wasn't convinced, because I didn't
> immediately get "target-specifc code". However, after looking at the 2nd
> patch, I think I understand better (= the obj-XXX vs. common-obj-XXX
> distinction). I also think that distinction is clear to any practicing
> QEMU developers.

Yes; target-specific code is compiled for each qemu-system-*
executable (and has access to #defines and so on that relate
specifically to that target); common code is built just once
and the same .o linked into each executable.

thanks
-- PMM
