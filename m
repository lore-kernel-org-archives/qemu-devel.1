Received: from eggs.gnu.org ([2001:4830:134:3::10]:47132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ey5P6-0000Kt-TQ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ey5P4-0001lo-N7
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:45:28 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ey5P4-0001l0-Fo
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:45:26 -0400
Received: by mail-pf0-x241.google.com with SMTP id y186so7758194pfb.2
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 17:45:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180319113544.704-1-laurent@vivier.eu>
	<20180319113544.704-3-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f32a5fc8-5483-797c-bb6d-508c43e2c13c@twiddle.net>
Date: Tue, 20 Mar 2018 08:45:21 +0800
MIME-Version: 1.0
In-Reply-To: <20180319113544.704-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] target/m68k: add a mechanism to
 automatically free TCGv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 03/19/2018 07:35 PM, Laurent Vivier wrote:
> SRC_EA() and gen_extend() can return either a temporary
> TCGv or a memory allocated one. Mark them when they are
> allocated, and free them automatically at end of the
> instruction translation.
> 
> We want to free locally allocated TCGv to avoid
> overflow in sequence like:
> 
>   0xc00ae406:  movel %fp@(-132),%fp@(-268)
>   0xc00ae40c:  movel %fp@(-128),%fp@(-264)
>   0xc00ae412:  movel %fp@(-20),%fp@(-212)
>   0xc00ae418:  movel %fp@(-16),%fp@(-208)
>   0xc00ae41e:  movel %fp@(-60),%fp@(-220)
>   0xc00ae424:  movel %fp@(-56),%fp@(-216)
>   0xc00ae42a:  movel %fp@(-124),%fp@(-252)
>   0xc00ae430:  movel %fp@(-120),%fp@(-248)
>   0xc00ae436:  movel %fp@(-12),%fp@(-260)
>   0xc00ae43c:  movel %fp@(-8),%fp@(-256)
>   0xc00ae442:  movel %fp@(-52),%fp@(-276)
>   0xc00ae448:  movel %fp@(-48),%fp@(-272)
>   ...
> 
> That can fill a lot of TCGv entries in a sequence,
> especially since 15fa08f845 ("tcg: Dynamically allocate TCGOps")
> we have no limit to fill the TCGOps cache and we can fill
> the entire TCG variables array and overflow it.
> 
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 56 +++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 43 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
