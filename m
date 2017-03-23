Received: from eggs.gnu.org ([2001:4830:134:3::10]:39530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqzy7-0001SL-7f
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqzy2-0003Ls-BS
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:27:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cqzy2-0003Lo-4m
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:27:42 -0400
References: <CAG48ez1tcz7GGsc5+L3EF140NsW=UyNir=0UpuZZYrBn4ZxrSA@mail.gmail.com>
	<CAFEAcA8-GJxpmppZGF5ygSAL4Y81BdvYKqso-XhjR2pbjMLi+A@mail.gmail.com>
	<CAJhHMCA=rwLqLOPq3kMOz9SpV83yrzkK_K6RfPmuyXMU1pXT7g@mail.gmail.com>
	<CAFEAcA9ZtayLn-bOPL4=2=w0SS_H0-EYO0UpFzXJSvyueGOHMw@mail.gmail.com>
	<CAJhHMCAjG1kfG8-3E8CcWu4V2cWMsR0La6iZ3hq0rbM91+brsA@mail.gmail.com>
	<CAFEAcA-x8CbqVpnaszmdZzLZt6+urxSntdWxLHeFXAOy327OqA@mail.gmail.com>
	<CAJhHMCDfmT_zrnuEBcmoJ+CJV9j8CB79ybehWoMBeh3rd+hA3Q@mail.gmail.com>
	<9f45e912-5fc8-bb99-506e-221f2cb6ac7e@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df57bde4-a33c-54b0-3f5a-3d0e28cdbca7@redhat.com>
Date: Thu, 23 Mar 2017 11:27:38 +0100
MIME-Version: 1.0
In-Reply-To: <9f45e912-5fc8-bb99-506e-221f2cb6ac7e@twiddle.net>
Content-Type: text/plain; charset=utf-8
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
To: Richard Henderson <rth@twiddle.net>, Pranith Kumar <bobby.prani+qemu@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Jann Horn <jannh@google.com>



On 22/03/2017 21:01, Richard Henderson wrote:
>>
>> Ah, OK. Thanks for the explanation. May be we should check the size of
>> the instruction while decoding the prefixes and error out once we
>> exceed the limit. We would not generate any IR code.
> 
> Yes.
> 
> It would not enforce a true limit of 15 bytes, since you can't know that
> until you've done the rest of the decode.  But you'd be able to say that
> no more than 14 prefix + 1 opc + 6 modrm+sib+ofs + 4 immediate = 25
> bytes is used.
>
> Which does fix the bug. 

Yeah, that would work for 2.9 if somebody wants to put together a patch.
 Ensuring that all instruction fetching happens before translation side
effects is a little harder, but perhaps it's also the opportunity to get
rid of s->rip_offset which is a little ugly.

Paolo
