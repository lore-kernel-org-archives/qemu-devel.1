Received: from eggs.gnu.org ([2001:4830:134:3::10]:33057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ds9ae-0005k8-RX
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ds9aZ-0001rt-UE
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:28:36 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:46876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ds9aZ-0001rV-NI
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:28:31 -0400
Received: by mail-pf0-x229.google.com with SMTP id e199so789018pfh.3
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 08:28:31 -0700 (PDT)
References: <20170912162513.21694-1-richard.henderson@linaro.org>
	<20170912162513.21694-8-richard.henderson@linaro.org>
	<d1f97f10-921e-1c50-9407-2007b1cbe169@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4262b16c-fd18-b551-a510-30833df414ad@linaro.org>
Date: Wed, 13 Sep 2017 08:28:28 -0700
MIME-Version: 1.0
In-Reply-To: <d1f97f10-921e-1c50-9407-2007b1cbe169@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/16] target/arm: Align vector registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

On 09/12/2017 11:50 AM, Philippe Mathieu-Daudé wrote:
>>
>> -        float64 regs[64];
>> +        float64 regs[64] __attribute__((aligned(16)));
> 
> I understand this should be aligned to the biggest vector register the host
> support, i.e. for AVX-512 this would be QEMU_ALIGNED(64), is it correct?

No.

Alignment of 16 is sufficient for "older" vector extensions, like altivec,
which require alignment in load/store insns.  But (so far at least) newer
vector extensions with larger vector sizes (AVX2, AVX512, ARM SVE) handle
unaligned load/store operations just fine.

Which means we need not require excessive alignment within the cpu struct.

The rule for this is documented in tcg/tcg-op-gvec.h, iirc.


r~
