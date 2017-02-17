Received: from eggs.gnu.org ([2001:4830:134:3::10]:33794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1celrR-0001Ah-5M
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1celrQ-0000zB-0C
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:58:21 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1celrP-0000yT-QN
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 11:58:19 -0500
Received: by mail-wr0-x22e.google.com with SMTP id z61so33249278wrc.1
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 08:58:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7c4d6c25-3b1c-61ec-1eda-6c5e7cee8755@redhat.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<e19aed34-77c2-f588-351d-2daa8a099ae9@redhat.com>
	<CAFEAcA-3TkmaJXpG2RpzBPKmj+JKGK5EBwPvXWkwR=Qkobq-Sg@mail.gmail.com>
	<7c4d6c25-3b1c-61ec-1eda-6c5e7cee8755@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 16:57:58 +0000
Message-ID: <CAFEAcA_3jE9F92F6+p6eDfmPwV2LL=fKV-htfTHpCoCOAgJAMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Chad Joan <chadjoan@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 17 February 2017 at 11:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 17/02/2017 11:18, Peter Maydell wrote:
>> Defining _XOPEN_SOURCE is easy enough, and I think we should
>> do it unconditionally. We should check what effect this has
>> on the BSD hosts though I guess. (You could argue that we
>> should be defining _XOPEN_SOURCE anyway for the benefit of
>> the non-glibc BSD/Solaris/etc platforms.)
>
> Sounds good, then I think we should define it to 700 just like glibc does.

Unfortunately this idea turns out to break OSX compiles,
because on OSX saying _XOPEN_SOURCE=anything disables
all the non-X/Open APIs (which you get by default, and
some of which like mkdtemp we use).

Looking at the manpage for Solaris
https://www.freebsd.org/cgi/man.cgi?query=standards&apropos=0&sektion=0&manpath=SunOS+5.8&format=html
it seems to also go with "_XOPEN_SOURCE means *only* those
functions", though its mechanism for saying "and the other
stuff too" is different (define __EXTENSION__).

So perhaps we'd better stick with "only define this for
Linux hosts".

thanks
-- PMM
