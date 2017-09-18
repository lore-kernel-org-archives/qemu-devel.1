Received: from eggs.gnu.org ([2001:4830:134:3::10]:57436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1du0Zl-0005HK-0K
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1du0Zj-0001M3-R1
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:15:20 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:48190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1du0Zj-0001KP-JW
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:15:19 -0400
Received: by mail-wm0-x234.google.com with SMTP id r68so5051761wmg.3
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 11:15:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9=syrPXD5cAq_EHWre_NniO1kZiWVAQXMDEnRuk=20ew@mail.gmail.com>
References: <20170916010330.10435-1-jsnow@redhat.com>
	<CAFEAcA8un6eescSDzd+P+jqEGuGkuQXgfjm+1=CPOydg6WQSnQ@mail.gmail.com>
	<fb54f008-2913-3cd2-df95-41b1fcf3f2ee@redhat.com>
	<CAFEAcA9=syrPXD5cAq_EHWre_NniO1kZiWVAQXMDEnRuk=20ew@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2017 19:14:57 +0100
Message-ID: <CAFEAcA9XgboiDD3SYsaJLRVMr=onckWU3VN-3ogd4DwH5fV3zw@mail.gmail.com>
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

On 18 September 2017 at 19:00, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 18 September 2017 at 18:55, John Snow <jsnow@redhat.com> wrote:
>> On 09/16/2017 10:34 AM, Peter Maydell wrote:
>>> Hi; I'm afraid this doesn't build with clang:
>>>
>>> /home/petmay01/linaro/qemu-for-merges/hw/ide/core.c:70:15: error:
>>> comparison of unsigned enum expression >= 0 is always true
>>> [-Werror,-Wtautological-compare]
>>>     if (enval >= 0 && enval < IDE_DMA__COUNT) {
>>>         ~~~~~ ^  ~
>>> 1 error generated


> I think you could argue that it would at least be helpful
> if clang didn't warn about comparisons that only happen
> to be useless for this particular platform/impdef choice
> but are useful for the same code compiled with a different
> compiler.

A bit of googling and some experimentation reveals that
clang deliberately suppresses this warning in the special
case of comparing against an enum value which happens to
be zero (but not for literal constant zero!). So this will
be fine:
   if (enval >= IDE_DMA_READ && enval < IDE_DMA__COUNT)

(or more sensibly you'd want to define an enum constant
for IDE_DMA__FIRST or something rather than relying on
READ being 0.)

(found here:
http://clang-developers.42468.n3.nabble.com/Possibly-invalid-enum-tautology-warning-td3233140.html
)

thanks
-- PMM
