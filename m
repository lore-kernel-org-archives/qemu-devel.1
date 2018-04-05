Received: from eggs.gnu.org ([2001:4830:134:3::10]:35588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f44z5-0005k8-LW
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f44yz-0000wE-U8
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:31:23 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:34058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f44yz-0000vx-NC
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:31:17 -0400
Received: by mail-qk0-x229.google.com with SMTP id g7so14088241qkm.1
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 06:31:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180405012241.25714-1-f4bug@amsat.org>
	<20180405012241.25714-2-f4bug@amsat.org>
	<CAFEAcA9Qvjo680JX1yQRKLdqTcL1r7V42adaQrVDh3ne=jt8WQ@mail.gmail.com>
	<eabfade9-5ac5-ce1f-8907-96943231c1ec@amsat.org>
	<CAFEAcA81MOAJ5n5b8g2j=JFcH79MVhTzxPdRy2t9BjB92x+mQw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <585f236c-f884-f0c7-f791-cf9111527838@amsat.org>
Date: Thu, 5 Apr 2018 10:31:11 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81MOAJ5n5b8g2j=JFcH79MVhTzxPdRy2t9BjB92x+mQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] memory: Avoid to create tiny RAM
 regions, handled as subpages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, KONRAD Frederic <frederic.konrad@adacore.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 04/05/2018 10:20 AM, Peter Maydell wrote:
> On 5 April 2018 at 13:53, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 04/05/2018 06:27 AM, Peter Maydell wrote:
>>> On 5 April 2018 at 02:22, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>> If an user creates a RAM region smaller than TARGET_PAGE_SIZE,
>>>> this region will be handled as a subpage.
>>>> While the subpage behavior can be noticed by an experienced QEMU
>>>> developper, it might takes hours to a novice to figure it out.
>>>> To save time to novices, do not allow subpage creation via the
>>>> memory_region_init_ram_*() functions.
>>>
>>> This commit message doesn't make it clear to me what actually
>>> goes wrong. Why doesn't the subpage mechanism do the right thing
>>> here?
>>
>> Trying to understand a bit more, I think the problem is "you can not
>> _execute_ from a region smaller than TARGET_PAGE_SIZE", however if this
>> region is used for I/O this is not a problem (the xilinx-pcie.c case).
>>
>> In my case I create a 2K SRAM which contains the exception vectors, but
>> instructions are never fetched because it is handled as I/O.
> 
> Ah, I wondered if it might be that. Yes, you can't execute from
> small lumps of memory at the moment. We might be able in theory
> to fix this for TCG, though I think it's harder to do so for KVM.
> If we end up implementing small-MPU-region support for ARM v7M/v8M
> that will have a similar setup. When RTH and I last discussed that:
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00293.html
> I think the favoured idea was to have a way to say "always take the
> slow path and do an MPU/MMU check". If we also had a mechanism for
> taking the slow path for code execution that would effectively
> also allow execution from subpages, though done only slowly one
> guest insn per TLB. The two use cases aren't exactly the same but
> some of the implementation seems similar enough to do the same way.
> (There's a lot of unresolved detail and irritating corner cases to
> deal with, though.)

Now this makes more sens to me, thanks :)

Luckily in my case I can workaround with a 4K SRAM, but it took me hours
to track this down until Paolo helped me.

Regards,

Phil.
