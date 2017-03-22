Received: from eggs.gnu.org ([2001:4830:134:3::10]:49774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqi56-0005Gm-6W
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqi55-0001N1-AC
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:21:48 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqi55-0001Mm-3s
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:21:47 -0400
Received: by mail-wm0-x230.google.com with SMTP id t189so41090512wmt.1
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 08:21:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJhHMCAjG1kfG8-3E8CcWu4V2cWMsR0La6iZ3hq0rbM91+brsA@mail.gmail.com>
References: <CAG48ez1tcz7GGsc5+L3EF140NsW=UyNir=0UpuZZYrBn4ZxrSA@mail.gmail.com>
	<CAFEAcA8-GJxpmppZGF5ygSAL4Y81BdvYKqso-XhjR2pbjMLi+A@mail.gmail.com>
	<CAJhHMCA=rwLqLOPq3kMOz9SpV83yrzkK_K6RfPmuyXMU1pXT7g@mail.gmail.com>
	<CAFEAcA9ZtayLn-bOPL4=2=w0SS_H0-EYO0UpFzXJSvyueGOHMw@mail.gmail.com>
	<CAJhHMCAjG1kfG8-3E8CcWu4V2cWMsR0La6iZ3hq0rbM91+brsA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Mar 2017 15:21:25 +0000
Message-ID: <CAFEAcA-x8CbqVpnaszmdZzLZt6+urxSntdWxLHeFXAOy327OqA@mail.gmail.com>
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
To: Pranith Kumar <bobby.prani+qemu@gmail.com>
Cc: Jann Horn <jannh@google.com>, Qemu Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 22 March 2017 at 15:14, Pranith Kumar <bobby.prani+qemu@gmail.com> wrote:
> On Wed, Mar 22, 2017 at 11:04 AM, Peter Maydell
> <peter.maydell@linaro.org> wrote:
>> This doesn't look right because it means we'll check
>> only after we've emitted all the code to do the
>> instruction operation, so the effect will be
>> "execute instruction, then take illegal-opcode
>> exception".

> The pc is restored to original address (s->pc = pc_start), so the
> exception will overwrite the generated illegal instruction and will be
> executed first.

s->pc is the guest PC -- moving that backwards will
not do anything about the generated TCG IR that's
already been written. You'd need to rewind the
write pointer in the IR stream, which there is
no support for doing AFAIK.

thanks
-- PMM
