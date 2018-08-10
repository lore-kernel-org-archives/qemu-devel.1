Received: from eggs.gnu.org ([2001:4830:134:3::10]:33680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1foDHr-00025M-Fa
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1foDHo-0004ar-Df
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:41:27 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:46680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1foDHo-0004Zn-3Q
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:41:24 -0400
References: <20180810185321.20017-1-laurent@vivier.eu>
	<20180810185321.20017-2-laurent@vivier.eu>
	<c000bae3-1986-1062-0dbc-a8d2feb0820e@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8e73a927-9e25-a1c8-1d7b-233a8bff26f0@vivier.eu>
Date: Fri, 10 Aug 2018 21:40:32 +0200
MIME-Version: 1.0
In-Reply-To: <c000bae3-1986-1062-0dbc-a8d2feb0820e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: fix 32bit g2h()/h2g()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>

Le 10/08/2018 à 21:30, Richard Henderson a écrit :
> On 08/10/2018 11:53 AM, Laurent Vivier wrote:
>> sparc32plus has 64bit long type but only 32bit virtual address space.
>>
>> For instance, "apt-get upgrade" failed because of a mmap()/msync()
>> sequence.
>>
>> mmap() returned 0xff252000 but msync() used g2h(0xffffffffff252000)
>> to find the host address. The "(target_ulong)" in g2h() doesn't fix the
>> address because it is 64bit long.
>>
>> This patch introduces a "target_ptr" that is set to uint32_t
>> if the virtual address space is addressed using 32bit in the linux-user
>> case. It stays set to target_ulong with softmmu case.
> 
> I would prefer the name "abi_ptr", since the full 64-bits of target_ulong are
> still used for any actual dereferences.

I can, I have no preference for that.

The abi_XXX types have an alignment attribute, while the target_XXX
don't. Do you think I should add it to the abi_ptr type?

Thanks,
Laurent
