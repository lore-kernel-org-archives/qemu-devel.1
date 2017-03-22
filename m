Received: from eggs.gnu.org ([2001:4830:134:3::10]:37728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cqmRj-0001ll-Hh
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 16:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cqmRg-000362-Ip
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 16:01:27 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cqmRg-00035F-Ew
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 16:01:24 -0400
Received: by mail-qt0-x243.google.com with SMTP id r45so26699168qte.0
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 13:01:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAG48ez1tcz7GGsc5+L3EF140NsW=UyNir=0UpuZZYrBn4ZxrSA@mail.gmail.com>
	<CAFEAcA8-GJxpmppZGF5ygSAL4Y81BdvYKqso-XhjR2pbjMLi+A@mail.gmail.com>
	<CAJhHMCA=rwLqLOPq3kMOz9SpV83yrzkK_K6RfPmuyXMU1pXT7g@mail.gmail.com>
	<CAFEAcA9ZtayLn-bOPL4=2=w0SS_H0-EYO0UpFzXJSvyueGOHMw@mail.gmail.com>
	<CAJhHMCAjG1kfG8-3E8CcWu4V2cWMsR0La6iZ3hq0rbM91+brsA@mail.gmail.com>
	<CAFEAcA-x8CbqVpnaszmdZzLZt6+urxSntdWxLHeFXAOy327OqA@mail.gmail.com>
	<CAJhHMCDfmT_zrnuEBcmoJ+CJV9j8CB79ybehWoMBeh3rd+hA3Q@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9f45e912-5fc8-bb99-506e-221f2cb6ac7e@twiddle.net>
Date: Thu, 23 Mar 2017 06:01:17 +1000
MIME-Version: 1.0
In-Reply-To: <CAJhHMCDfmT_zrnuEBcmoJ+CJV9j8CB79ybehWoMBeh3rd+hA3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Pranith Kumar <bobby.prani+qemu@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Jann Horn <jannh@google.com>

On 03/23/2017 02:29 AM, Pranith Kumar wrote:
> On Wed, Mar 22, 2017 at 11:21 AM, Peter Maydell
> <peter.maydell@linaro.org> wrote:
>> On 22 March 2017 at 15:14, Pranith Kumar <bobby.prani+qemu@gmail.com> wrote:
>>> On Wed, Mar 22, 2017 at 11:04 AM, Peter Maydell
>>> <peter.maydell@linaro.org> wrote:
>>>> This doesn't look right because it means we'll check
>>>> only after we've emitted all the code to do the
>>>> instruction operation, so the effect will be
>>>> "execute instruction, then take illegal-opcode
>>>> exception".
>>
>>> The pc is restored to original address (s->pc = pc_start), so the
>>> exception will overwrite the generated illegal instruction and will be
>>> executed first.
>>
>> s->pc is the guest PC -- moving that backwards will
>> not do anything about the generated TCG IR that's
>> already been written. You'd need to rewind the
>> write pointer in the IR stream, which there is
>> no support for doing AFAIK.
>
> Ah, OK. Thanks for the explanation. May be we should check the size of
> the instruction while decoding the prefixes and error out once we
> exceed the limit. We would not generate any IR code.

Yes.

It would not enforce a true limit of 15 bytes, since you can't know that until 
you've done the rest of the decode.  But you'd be able to say that no more than 
14 prefix + 1 opc + 6 modrm+sib+ofs + 4 immediate = 25 bytes is used.

Which does fix the bug.


r~
