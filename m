Received: from eggs.gnu.org ([2001:4830:134:3::10]:38963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dp9ys-0007S7-8m
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dp9yn-0006iC-Hb
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:17:14 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dp9yn-0006hL-9Z
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:17:09 -0400
Received: by mail-wr0-x236.google.com with SMTP id y15so7239066wrc.2
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 02:17:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <747d805a-98ed-3d36-c4e7-5e6b21b89924@gmx.com>
References: <20170903164952.26760-1-n54@gmx.com>
	<CAFEAcA-wB8JezCNjyU92U83+75C5NccfBHe1G5q-D67H4CMTKA@mail.gmail.com>
	<747d805a-98ed-3d36-c4e7-5e6b21b89924@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 10:16:47 +0100
Message-ID: <CAFEAcA_f55+cJxy2L=PsUX5pE_=0AjqJJ4_spvJRm1D-FKkROg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests: Do not include lutil on SunOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Jonathan Perkin <jperkin@joyent.com>

On 5 September 2017 at 00:46, Kamil Rytarowski <n54@gmx.com> wrote:
> On 04.09.2017 11:32, Peter Maydell wrote:
>> My assumption is that the issue is that Solaris doesn't
>> have a -lutil (it's helpful to quote the linker or
>> compiler error message for this kind of patch to clarify
>> what the failure is that we're trying to fix).
>>
>
> There is no libutil on SmartOS.
>
> I cannot provide any information about the proprietary Solaris here and
> in next questions.

Yes; I was being a bit sloppy referring to all the
forks of opensolaris as 'Solaris' there. Recent news
suggests we don't need to consider support for the
proprietary Solaris...

>> It looks like we use libutil here for openpty, which
>> is used in the test-char test. But the condition we're
>> using in tests/Makefile.include isn't the same as the
>> one we used to decide whether to add -lutil to the
>> emulator binary link line, which is in configure:
>>
>> if test "$darwin" != "yes" -a "$mingw32" != "yes" -a "$solaris" != yes -a \
>>         "$aix" != "yes" -a "$haiku" != "yes" ; then
>>     libs_softmmu="-lutil $libs_softmmu"
>> fi
>>
>> So I think I'd prefer it if we have:
>>  * a configure test for "is openpty() in libutil"
>>  * use that to determine whether to add -lutil to
>>    libs_softmmu and to the libs for tests, rather than
>>    doing OS-specific tests
>>
>
> This looks cleaner. I will go for it.

Thanks. Remember that there are three cases to handle:
 * has openpty, don't need -lutil to get it (OSX is like this I think)
 * has openpty and you need -lutil (Linux)
 * has no openpty at all, use QEMU internal version (smartos)

thanks
-- PMM
