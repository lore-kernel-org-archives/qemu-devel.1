Received: from eggs.gnu.org ([2001:4830:134:3::10]:56857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1ap1-0004AC-Km
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1ap0-0006uR-Gx
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:50:11 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1ap0-0006tc-93
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:50:10 -0400
Received: by mail-wr0-x22c.google.com with SMTP id z109so57331155wrb.1
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 08:50:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170421151005.GA5101@aperevalov-ubuntu>
References: <CGME20170414131739eucas1p1ea9a6adcdbe8cfe45ac1ff582d28d873@eucas1p1.samsung.com>
	<1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<1492175840-5021-3-git-send-email-a.perevalov@samsung.com>
	<CAFEAcA9ve6APJtoHrqmzOTMcmu0KAFqdJ9bfyfTX7wjJD7eULQ@mail.gmail.com>
	<20170421151005.GA5101@aperevalov-ubuntu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Apr 2017 16:49:47 +0100
Message-ID: <CAFEAcA9WPO+=jCFfOod=dnP0k9-H=d7Jb3KVm69E95WoMwyVrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 2/6] util: introduce glib-helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey <a.perevalov@samsung.com>
Cc: i.maximets@samsung.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 21 April 2017 at 16:10, Alexey <a.perevalov@samsung.com> wrote:
> Hello, thank you for so  detailed comment,
>
> On Fri, Apr 21, 2017 at 11:27:55AM +0100, Peter Maydell wrote:

>> Can we have a proper doc comment format comment, please,
>> since this is now a function available to all of QEMU?
>>
>> > +gint g_int_cmp64(gconstpointer a, gconstpointer b,
>> > +        gpointer __attribute__((unused)) user_data);
>>
>> What is this actually for? Looking at the original uses
>> I can tell that this is a GCompareDataFunc function, but
>> the comment should tell me that.
> I looked at another functions comments in QEMU, I didn't find
> some common style, and decided keep it as is. Maybe I omitted some
> best practice here.

See include/qemu/bitops.h for an example of the comment style.
More important than just the style is that the comment
should clearly explain the purpose of the function in detail.

Certainly many of our existing functions are poorly documented,
but we're trying to raise the bar gradually here.

> yes, it was copy pasted,
> right now, after mingw build check I think to use intptr_t as a type
> for comparision in this function or even keep gpointer and merge these two
> functions into _direct_.
> I saw intptr_t is widely used in QEMU.
>
> The intent of this function was a comparator for case when client code
> want to keep integers in pointer field. xen_disk.c uses UINT32 so it
> wasn't a problem, but migration uses 64 address (kernel provides it in
> __u64, long long), so on 32 platform it's a problem.

Code which tries to put a genuinely 64 bit value into a pointer
is buggy and needs to be fixed. I'm not clear if that is the
case here, or if the ABI from the kernel guarantees that the
value is really a pointer type and fits in uintptr_t / gpointer.

I don't think we need more than one of these functions.

>> This is also missing the copyright line.
> Yes, maybe it was better for me to ask before send.
> I found in util files with reference to GNU GPL, version 2, like
> in this file, also I found that
>
>  * This library is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU Lesser General Public
>  * License as published by the Free Software Foundation; either
>  * version 2 of the License, or (at your option) any later version.
>
> So I just copied copyright reference from glib-compat.h.

Yes, that's the license statement, which is fine. What is
missing is the copyright line, which in glib-compat.h looks
like:
 Copyright IBM, Corp. 2013

For code you write, you want either your personal or (more likely)
a Samsung copyright line -- check with your company about what
their preferred form is.

thanks
-- PMM
