Received: from eggs.gnu.org ([2001:4830:134:3::10]:46762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGn6T-0000T5-Hn
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGn6P-0001ox-Ld
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:59:01 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGn6P-0001oH-FM
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:58:57 -0400
Received: by mail-wr0-x230.google.com with SMTP id q97so7452367wrb.2
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 06:58:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-yPTxSB90zUg2Mn6s=HdXshWyZ9z7HrF+6+3hD6manoA@mail.gmail.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<e19aed34-77c2-f588-351d-2daa8a099ae9@redhat.com>
	<CAFEAcA-3TkmaJXpG2RpzBPKmj+JKGK5EBwPvXWkwR=Qkobq-Sg@mail.gmail.com>
	<7c4d6c25-3b1c-61ec-1eda-6c5e7cee8755@redhat.com>
	<CAFEAcA_3jE9F92F6+p6eDfmPwV2LL=fKV-htfTHpCoCOAgJAMg@mail.gmail.com>
	<oc60j5$ceq$1@blaine.gmane.org>
	<CAFEAcA-yPTxSB90zUg2Mn6s=HdXshWyZ9z7HrF+6+3hD6manoA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2017 14:58:35 +0100
Message-ID: <CAFEAcA_2K+T=NP7qDK5hWxTrZ34Kzee+3DK7eenK0=bnS8nh1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Rainer_M=C3=BCller?= <raimue@codingfarm.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 April 2017 at 19:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 6 April 2017 at 19:15, Rainer M=C3=BCller <raimue@codingfarm.de> wrote=
:
>> A bit late to this thread, but the original problem was also reported
>> for Mac OS X with --enable-curses in MacPorts. The build fails with the
>> same symptoms as in the original report.
>>
>> https://trac.macports.org/ticket/53929
>>
>> As you identified, the problem is that ncurses expects the define
>> _XOPEN_SOURCE >=3D 500 to enable the wide-char function declarations.
>>
>> The solution to retain access to non-standard API on Mac OS X would be
>> to also define _DARWIN_C_SOURCE which enables extensions.
>
> Thanks for the report. I have a feeling that fixing this bug
> got lost somewhere -- there was a long thread about it but I
> don't think an actual patch ever came out of it :-(

I've got back to looking at this, and it turns out that the
situation is a complete mess. In particular, on OSX if you
define _XOPEN_SOURCE=3D600 then it causes _POSIX_C_SOURCE to be
set such that the getpagesize() prototype is not provided, and
even if you set _DARWIN_C_SOURCE this does not override that.

Similarly, on FreeBSD if you define _XOPEN_SOURCE then it
doesn't provide any APIs that aren't in that standard and there
is no provided mechanism at all to say "and also the FreeBSD
APIs" please.

My conclusion from this is that we must not set _XOPEN_SOURCE,
but instead have to tell ncurses directly that we definitely
want the widechar prototypes, by defining NCURSES_WIDECHAR.
Since ncurses 20111030 this is sufficient I think; if you're
still using an older ncurses then you'll need to upgrade it
(older ncurses ignore NCURSES_WIDECHAR and only pay attention
to _XOPEN_SOURCE_EXTENDED, etc).

thanks
-- PMM
