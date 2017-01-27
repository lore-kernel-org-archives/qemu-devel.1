Received: from eggs.gnu.org ([2001:4830:134:3::10]:43849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1cXCvZ-00015G-P2
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:15:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1cXCvY-0003EH-Ti
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:15:21 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrew.smirnov@gmail.com>)
	id 1cXCvY-0003E5-Om
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:15:20 -0500
Received: by mail-qt0-x242.google.com with SMTP id h53so11936828qth.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 12:15:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9sQ4W2SMUgoNYLnG-NiHCaf+fsKe+A-yqQt64+iYst0A@mail.gmail.com>
References: <20170127183131.6868-1-andrew.smirnov@gmail.com>
	<CAFEAcA9sQ4W2SMUgoNYLnG-NiHCaf+fsKe+A-yqQt64+iYst0A@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 27 Jan 2017 12:15:19 -0800
Message-ID: <CAHQ1cqHWqyQFD4mEq-Go7HNAH3WCpHZZKr-LZMnir-hWpKuz_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] util/path: Always translate
 /etc/ld.so.cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jan 27, 2017 at 10:53 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 27 January 2017 at 18:31, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>> Always translate /etc/ld.so.cache to point somwhere inside of guest's
>> filesystem tree pointed to by 'prefix'. This prevents guest's libc from
>> reading /etc/ld.so.cache of the host and potentialy failing. One of the
>> manifestation of the problem could be easily reproduced by executing and
>> simple application compiled for PowerPC on a x86 host using
>> linux-use/qemu-ppc emulation.
>>
>> Anything as simple as:
>>
>>          qemu-ppc -L <prefix> <prefix>/bin/ls
>>
>> should trigger the problem.
>>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> Have you tested that this doesn't cause execution inside a chroot
> to behave wrongly (in a chroot, the host fs /etc/ld.so.cache is
> definitely the one you want to use) ?

No, I have not. I'll go back and do more homework. Just to make sure
that my assumptions are correct, I consider "qemu-ppc -L<foo>" and
"chroot <foo> qemu-ppc" to be the only use-cases supported, and
"chroot <foo> qemu-ppc -L <bar>" is not something that is expected to
work correctly. Is that a correct assumption to make?

>
> (glibc really ought to fix their ld.so.cache reading bugs.)
>

I agree. I am planning on taking a look at the glibc side of things to
see if there's a simple way to fix the problem there, but in the
meantime I thought it would be good to float this patch and get some
feedback.

Cheers!

Andrey Smirnov
