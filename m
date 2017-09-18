Received: from eggs.gnu.org ([2001:4830:134:3::10]:53154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1du0LS-00006g-NY
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1du0LN-0002El-Ar
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:00:34 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:57098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1du0LN-0002EO-2x
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:00:29 -0400
Received: by mail-wr0-x234.google.com with SMTP id r74so1166688wrb.13
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 11:00:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fb54f008-2913-3cd2-df95-41b1fcf3f2ee@redhat.com>
References: <20170916010330.10435-1-jsnow@redhat.com>
	<CAFEAcA8un6eescSDzd+P+jqEGuGkuQXgfjm+1=CPOydg6WQSnQ@mail.gmail.com>
	<fb54f008-2913-3cd2-df95-41b1fcf3f2ee@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2017 19:00:07 +0100
Message-ID: <CAFEAcA9=syrPXD5cAq_EHWre_NniO1kZiWVAQXMDEnRuk=20ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 September 2017 at 18:55, John Snow <jsnow@redhat.com> wrote:
> On 09/16/2017 10:34 AM, Peter Maydell wrote:
>> Hi; I'm afraid this doesn't build with clang:
>>
>> /home/petmay01/linaro/qemu-for-merges/hw/ide/core.c:70:15: error:
>> comparison of unsigned enum expression >= 0 is always true
>> [-Werror,-Wtautological-compare]
>>     if (enval >= 0 && enval < IDE_DMA__COUNT) {
>>         ~~~~~ ^  ~
>> 1 error generated.
>>
>> (It's impdef whether an enum with all positive values is
>> a signed type or unsigned type, so just deleting the
>> comparison against 0 would also be wrong...)

> Huh, impdef in the general case, but is it undefined for gnu99? I'm
> wondering why Clang can be so certain about this comparison being
> useless. Is this a Clang "bug"?

My guess is that clang as an implementation picks unsigned
in this case, that it then effectively lowers all the enums
to just being integer arithmetic, and then the warning pass
coming along later doesn't know that the unsigned thing it's
comparing is an enum.

I think you could argue that it would at least be helpful
if clang didn't warn about comparisons that only happen
to be useless for this particular platform/impdef choice
but are useful for the same code compiled with a different
compiler.

thanks
-- PMM
