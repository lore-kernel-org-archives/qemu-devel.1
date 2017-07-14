Received: from eggs.gnu.org ([2001:4830:134:3::10]:44235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoNN-0006zs-EY
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoNK-0001gf-9k
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:22:33 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVoNK-0001g6-4s
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:22:30 -0400
Received: by mail-qt0-x241.google.com with SMTP id m54so8190273qtb.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:22:30 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170713215137.5307-1-ricardo.ribalda@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5de5659c-21ab-7b5b-1247-2d03aa134ef0@twiddle.net>
Date: Thu, 13 Jul 2017 14:22:25 -1000
MIME-Version: 1.0
In-Reply-To: <20170713215137.5307-1-ricardo.ribalda@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: Fix ANDN (bmi)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com

On 07/13/2017 11:51 AM, Ricardo Ribalda Delgado wrote:
> Operands on ANDN are swapped.
> 
> Tested with the following function:
> 
> long test_andn(long v1, long v2){
> 	return (~v1 & v2);
> }
> 
> Compiled with:
> 
> gcc kk.c -mbmi -O3 -Wall
> 
> 0000000000000910 <test_andn>:
>   910:c4 e2 c0 f2 c6       	andn   %rsi,%rdi,%rax
>   915:c3                   	retq
>   916:66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
>   91d:00 00 00
> 
> and
> 
> gcc kk.c -march=native -O3 -Wall
> 
> 0000000000000930 <test_andn>:
>   930:   48 f7 d7                not    %rdi
>   933:   48 89 f8                mov    %rdi,%rax
>   936:   48 21 f0                and    %rsi,%rax
>   939:   c3                      retq
>   93a:   66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
> 
> The test showed than -mbmi version behaved differently than the
> -march native version.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Thanks, applied to my i386 tcg queue.


r~
