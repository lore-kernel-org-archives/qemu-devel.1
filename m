Received: from eggs.gnu.org ([2001:4830:134:3::10]:51956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fME7x-0000bb-B8
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fME7s-0006bx-Gg
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:55:33 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fME7s-0006bI-2X
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:55:28 -0400
Received: by mail-qk0-x242.google.com with SMTP id p186-v6so4279947qkd.1
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:55:27 -0700 (PDT)
References: <20180525132755.21839-1-peter.maydell@linaro.org>
	<20180525132755.21839-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d37b2ff8-bb7e-bc2a-c9b8-133854c05d99@linaro.org>
Date: Fri, 25 May 2018 07:55:21 -0700
MIME-Version: 1.0
In-Reply-To: <20180525132755.21839-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] scripts/update-linux-headers: Handle
 __aligned_u64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, patches@linaro.org

On 05/25/2018 06:27 AM, Peter Maydell wrote:
> We'll currently replace any 'u64' with a 'uint64_t' including when
> it's embedded in an '__aligned_u64', creating a '__aligned_uint64_t'
> which doesn't exist. We need to instead expand out the kernel's
> definition of __aligned_u64:
>    #define __aligned_u64 __u64 __attribute__((aligned(8)))
> before we convert the __u64 to uint64_t.

Wow.  I did not believe that would work.  I expected that you'd need to define
a typedef, or somehow sort the attribute after the identifier to which it applies.

However

typedef unsigned long uint64_t;
uint64_t __attribute__((aligned(16))) a;
struct bar { uint64_t __attribute__((aligned(16))) foo; } b;

produces the expected alignments with both gcc(8) and clang(6).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
