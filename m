Received: from eggs.gnu.org ([2001:4830:134:3::10]:37670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duyGH-00089v-F9
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duyGD-0004Di-JD
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:59:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1duyGD-0004CT-Da
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:59:09 -0400
References: <20170911022839.23231-1-f4bug@amsat.org>
	<1c72c0c6-bd29-5228-d4ad-b26b11afa712@linaro.org>
	<CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
	<cff16e31-4be0-9665-62d7-88a12b6d0b56@weilnetz.de>
	<15608989-cb43-a522-9a7d-b57b3a393155@weilnetz.de>
	<abc99a4a-1386-2757-e605-f10d0afe6b3e@redhat.com>
	<2a90999d-6f79-cbd4-aaba-a6cd425980c6@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <125b2e2a-290e-568a-0e33-d40150220912@redhat.com>
Date: Thu, 21 Sep 2017 11:59:04 +0200
MIME-Version: 1.0
In-Reply-To: <2a90999d-6f79-cbd4-aaba-a6cd425980c6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: do not use ldst label (never
 implemented)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 12.09.2017 17:13, Paolo Bonzini wrote:
> On 12/09/2017 16:56, Thomas Huth wrote:
>> The problem is that the SLOF firmware just performs very badly with TC=
G
>> (it's fine on real hardware). It executes a lot of Forth code, and the
>> Forth interpreter uses things like computed gotos or other tricks that
>> basically prevent proper JIT operation here. I've done quite a bit of
>> optimizations in SLOF in the past already, but I've got hardly any ide=
as
>> left how to fix that further.
>=20
> Two ideas for QEMU based on a quick "perf record" test:
>=20
> - 25% of the time is spent in cpu_exec.  PPC doesn't use
> tcg_gen_lookup_and_goto_ptr.

I just realized that Richard recently already posted a patch for this:

https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg07124.html

I've applied it locally, and indeed, it speeds up a simple test with
-prom-env by factor two. Before the change:

$ time ppc64-softmmu/qemu-system-ppc64 -nographic -vga none -prom-env
'use-nvramrc?=3Dtrue' -prom-env 'nvramrc=3Dpower-off'
[...]
real	0m28.784s
user	0m28.700s
sys	0m0.031s

After the change:

$ time ppc64-softmmu/qemu-system-ppc64 -nographic -vga none -prom-env
'use-nvramrc?=3Dtrue' -prom-env 'nvramrc=3Dpower-off'
[...]
real	0m13.953s
user	0m13.904s
sys	0m0.046s

That's impressive! Richard, may I ask what's the current state of this?
Do you plan to merge this soon, or are there still issues (like the ones
that Paolo mentioned)?

However, I only see that speed-up with the normal x86 backend. I've also
tried it with TCI, but I hardly saw any improvements there ... is there
still something missing in the TCI backend that is required for the
tcg_gen_lookup_and_goto_ptr feature?

 Thomas
