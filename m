Received: from eggs.gnu.org ([2001:4830:134:3::10]:42465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gH6nt-0004HD-Sv
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gH6nn-00017H-QN
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:37:57 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:38829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gH6nn-00015x-JM
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:37:51 -0400
Received: by mail-wm1-f49.google.com with SMTP id l2-v6so2275141wmh.3
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 05:37:51 -0700 (PDT)
References: <CAFEAcA-=Wqxp1GOtBOZpck9J-LUgDhthP5u9PQuT-2fGdz9mwQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a649936a-dccd-cb60-7225-a497ffdcaa7f@redhat.com>
Date: Mon, 29 Oct 2018 13:37:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-=Wqxp1GOtBOZpck9J-LUgDhthP5u9PQuT-2fGdz9mwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] a64 simd decode in handle_vec_simd_shli()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

On 29/10/18 13:06, Peter Maydell wrote:
> Hi; Coverity is complaining (in CID 1396476) about a problem in the
> handle_vec_simd_shli() function, where we might dereference sli_op[]
> with a size that's greater than 3. It thinks size might be > 3 because
> we do a check
>       if (size > 3 && !is_q) {
>           unallocated_encoding(s);
>           return;
>       }
> suggesting that we could have is_q and size > 3.
> 
> I'm having difficulty figuring out where this check has come from;
> it doesn't seem to match up with the pseudocode and in any case
> I don't think size can ever be > 3. We calculate:
> 
>      int size = 32 - clz32(immh) - 1;
> where immh is a 4 bit field which we know cannot be all-zeroes.
> So the clz32() return must be in {28,29,30,31} and the resulting
> size is in {0,1,2,3}, so the check above can't ever fire.

Clang was emitting the same warning in 
memory_region_oldmmio_read_accessor() before you remove it:

     tmp = mr->ops->old_mmio.read[ctz32(size)](mr->opaque, addr);

> Am I missing something? As far as I can see we should simply delete
> the can't-happen condition, which will probably satisfy coverity.
> 
> thanks
> -- PMM
> 
