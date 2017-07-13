Received: from eggs.gnu.org ([2001:4830:134:3::10]:37465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVlSZ-0005FW-1g
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVlSX-0007br-Qs
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:15:42 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVlSX-0007bJ-ED
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:15:41 -0400
Received: by mail-wr0-x22a.google.com with SMTP id y28so7075873wrd.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 14:15:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cd8f1049-b975-06d8-528b-9d1c3c4bc0fb@redhat.com>
References: <CAFEAcA9A0fBB+QE68O7aea+c6SXPaVK4+7B8DJoYE27qshtrcQ@mail.gmail.com>
	<cd8f1049-b975-06d8-528b-9d1c3c4bc0fb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 22:15:19 +0100
Message-ID: <CAFEAcA97q+WAzP=QhOc4EU05t9sqGJnpYGxuoOyg0R9QgQo-yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] tests/Makefile.include non-portable use of $RANDOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 13 July 2017 at 21:16, Eric Blake <eblake@redhat.com> wrote:
> On 07/13/2017 12:32 PM, Peter Maydell wrote:
>> On NetBSD the shell complains:
>> # echo $((RANDOM % 255 + 1))
>> -sh: arith: syntax error: "RANDOM % 255 + 1"
>>
>> and so 'make check' doesn't work.
>>
>> Any suggestions for something more portable?
>
> Yes; echo $(( ${RANDOM:-0} % 255 + 1))
>
> should reliably give you 1, even on current BSD /bin/sh, regardless of
> whether BSD adds $RANDOM support in the future.
>
>> https://unix.stackexchange.com/questions/140750/generate-random-numbers-in-specific-range
>> suggests
>>   awk 'BEGIN{srand(); print int(1+rand()*256)}'
>> and of course there are similar things possible with perl et al.
>
> But why bother. MALLOC_PERTURB_ only makes sense on glibc systems, so
> picking a non-random value is no worse on non-glibc systems.

"has glibc" != "has bash as /bin/sh". In particular most
of my build-test systems run ubuntu and will have dash
for /bin/sh.

On the other hand the :-0 trick is simple and probably
good enough.

thanks
-- PMM
