Received: from eggs.gnu.org ([2001:4830:134:3::10]:37355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHtKL-0006xD-Sm
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHtKI-0004wR-Jh
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:17:37 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cHtKI-0004uj-C1
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:17:34 -0500
Received: by mail-wm0-x22e.google.com with SMTP id g23so35100743wme.1
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 06:17:32 -0800 (PST)
References: <CAH47eN3AVo-4CWN8XHhVz5F811Dc-iS8pVmW+4EW_1mvbpVgpA@mail.gmail.com>
	<6970101a-5eff-9f77-86ec-c142937c1000@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <6970101a-5eff-9f77-86ec-c142937c1000@redhat.com>
Date: Fri, 16 Dec 2016 14:17:30 +0000
Message-ID: <87twa4rm9x.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Making TCG configurable in system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Alvise Rigo <a.rigo@virtualopensystems.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, chao.p.peng@linux.intel.com


Laurent Vivier <lvivier@redhat.com> writes:

> On 14/12/2016 20:30, Alvise Rigo wrote:
>> Hi all,
>>
>> I am looking at the possibility to add a new QEMU configuration option
>> to make TCG optional (in qemu-system-*). What I am exploring is a way
>> to exclude any of the TCG code not needed by KVM from the QEMU binary.
>> There has been a previous attempt in the past from Paolo Bonzini,
>> namely https://github.com/bonzini/qemu/tree/disable-tcg, that
>> eventually was not upstreamed. I was looking into this work mainly,
>> mostly to understand if the same approach can be respinned and used to
>> support all the QEMU's targets. Any input on this is welcome.
>>
>> I was also wondering if an approach could be based on the recent patch
>> series that allows to use the TCG frontend as a library --
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg415514.html.
>> Making qemu-user and qemu-system users of such a library might help in
>> having TCG optional. Obviously this solution introduces many other
>> challenges and I'm not even sure if it's actually viable.
>
> To have a library has also another interest: testing.
>
> For the moment RISU is doing a great job but it needs to be able to
> start a client (the apprentice) in a chroot. So it requires a "viable"
> TCG implementation.

FWIW you have to use a chroot. risu is simple enough to build statically
which is what I do.

That said I'd love to be able to add some test cases into "make check"
which could build a sequence of TCGops and then test things like
constant folding and other optimisations where being done correctly. I
don' know if this needs a library or just the ability to initialise the
TCG functions without everything else in a qtest binary.

> If we would have a library we could directly link the "apprentice" with
> the library and it will inject the code to test directly (without
> chroot) in the TCG engine. Moreover, I think we could use single-step
> instead of trap to synchronize master and apprentice.

Please also see the record/playback patches recently posted on the list:

  https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg01265.html

>
> We had something like that to test 680x0 [1], but the main program was
> written in C++ compiling some parts of QEMU inside, and I failed to
> recompile it last time I tried (I use RISU now).
>
> Thanks,
> Laurent
> [1] https://github.com/vivier/m68k-tester


--
Alex Bennée
