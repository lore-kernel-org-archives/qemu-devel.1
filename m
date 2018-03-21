Received: from eggs.gnu.org ([2001:4830:134:3::10]:42222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyggo-0007Cz-9l
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyggn-0003Uq-HK
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:34:14 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:42296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyggn-0003Tx-CU
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:34:13 -0400
Received: by mail-oi0-x234.google.com with SMTP id c18-v6so4830706oiy.9
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 09:34:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50d30ea4-2abf-e1e7-ca3b-e686313b07e0@redhat.com>
References: <1521229281-73637-1-git-send-email-mjc@sifive.com>
	<1521229281-73637-11-git-send-email-mjc@sifive.com>
	<34ebe3f6-3ae6-cd7f-ab52-727119666632@redhat.com>
	<CAHNT7NsjiXpLOAii3sWv9rGe0h-+xAwwuO5srNPNxX+sxi9Udg@mail.gmail.com>
	<50d30ea4-2abf-e1e7-ca3b-e686313b07e0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Mar 2018 16:33:51 +0000
Message-ID: <CAFEAcA9vfmcBv8AoHPo11ENcdjQ0WViY=0roAwoW3i8nAEGKNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 10/24] RISC-V: Hold rcu_read_lock when
 accessing memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Clark <mjc@sifive.com>, Stefan O'Rear <sorear2@gmail.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 21 March 2018 at 13:55, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 19/03/2018 22:07, Michael Clark wrote:
>> We need to use atomic_cmpxchg
>> in the PTE update to detect the case where the PTE has changed between
>> reading it and updating the accessed dirty bits.
>
> Yes, this makes sense.  In fact having such a function (more precisely
> address_space_atomic_cmpxchg) would be useful for x86 too.  Right now
> x86 is wrong in not using cmpxchg.

Yeah, this is a known missing feature in our APIs for memory
accesses (it only starts to matter with MTTCG, really). We
ought to have functions that guarantee that they do the
access as a single 32/64 bit load/store, as well as
having atomic support. PPC and Arm TLB walk code will need
these. For the moment we just ignore the possibility of
races here, but for the 2.13 timeframe we really ought to
design a solution to this properly.

thanks
-- PMM
