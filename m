Received: from eggs.gnu.org ([2001:4830:134:3::10]:47894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cqj9f-0002wW-UN
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cqj9a-0005v3-4k
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:30:35 -0400
Received: from mail-yw0-x232.google.com ([2607:f8b0:4002:c05::232]:34209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cqj9a-0005uw-0t
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:30:30 -0400
Received: by mail-yw0-x232.google.com with SMTP id p77so130935028ywg.1
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 09:30:29 -0700 (PDT)
MIME-Version: 1.0
Sender: bobby.prani@gmail.com
In-Reply-To: <CAFEAcA-x8CbqVpnaszmdZzLZt6+urxSntdWxLHeFXAOy327OqA@mail.gmail.com>
References: <CAG48ez1tcz7GGsc5+L3EF140NsW=UyNir=0UpuZZYrBn4ZxrSA@mail.gmail.com>
	<CAFEAcA8-GJxpmppZGF5ygSAL4Y81BdvYKqso-XhjR2pbjMLi+A@mail.gmail.com>
	<CAJhHMCA=rwLqLOPq3kMOz9SpV83yrzkK_K6RfPmuyXMU1pXT7g@mail.gmail.com>
	<CAFEAcA9ZtayLn-bOPL4=2=w0SS_H0-EYO0UpFzXJSvyueGOHMw@mail.gmail.com>
	<CAJhHMCAjG1kfG8-3E8CcWu4V2cWMsR0La6iZ3hq0rbM91+brsA@mail.gmail.com>
	<CAFEAcA-x8CbqVpnaszmdZzLZt6+urxSntdWxLHeFXAOy327OqA@mail.gmail.com>
From: Pranith Kumar <bobby.prani+qemu@gmail.com>
Date: Wed, 22 Mar 2017 12:29:58 -0400
Message-ID: <CAJhHMCDfmT_zrnuEBcmoJ+CJV9j8CB79ybehWoMBeh3rd+hA3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [BUG] user-to-root privesc inside VM via bad
 translation caching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jann Horn <jannh@google.com>, Qemu Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Wed, Mar 22, 2017 at 11:21 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 22 March 2017 at 15:14, Pranith Kumar <bobby.prani+qemu@gmail.com> wrote:
>> On Wed, Mar 22, 2017 at 11:04 AM, Peter Maydell
>> <peter.maydell@linaro.org> wrote:
>>> This doesn't look right because it means we'll check
>>> only after we've emitted all the code to do the
>>> instruction operation, so the effect will be
>>> "execute instruction, then take illegal-opcode
>>> exception".
>
>> The pc is restored to original address (s->pc = pc_start), so the
>> exception will overwrite the generated illegal instruction and will be
>> executed first.
>
> s->pc is the guest PC -- moving that backwards will
> not do anything about the generated TCG IR that's
> already been written. You'd need to rewind the
> write pointer in the IR stream, which there is
> no support for doing AFAIK.

Ah, OK. Thanks for the explanation. May be we should check the size of
the instruction while decoding the prefixes and error out once we
exceed the limit. We would not generate any IR code.

--
Pranith
