Received: from eggs.gnu.org ([2001:4830:134:3::10]:45157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4BXp-0006AN-92
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 16:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4BXl-0004wJ-82
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 16:31:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f4BXl-0004wA-0x
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 16:31:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id b127so8926152wmf.5
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 13:31:36 -0700 (PDT)
References: <20180328133152.24623-1-lvivier@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1316796c-49c7-2156-b277-6b6b886d06a6@redhat.com>
Date: Thu, 5 Apr 2018 22:31:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180328133152.24623-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: fix 16-byte vector operations
 detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Miroslav Rezanina <mrezanin@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 28/03/2018 15:31, Laurent Vivier wrote:
> configure tries to detect if the compiler
> supports 16-byte vector operations.
> 
> As stated in the comment of the detection
> program, there is a problem with the system
> compiler on GCC on Centos 7.
> 
> This program doesn't actually detect the problem
> with GCC on RHEL7 on PPC64LE (Red Hat 4.8.5-28).
> 
> This patch updates the test to look more like
> it is in QEMU helpers, and now detects the problem.
> 
> The error reported is:
> 
>   CC      ppc64-softmmu/accel/tcg/tcg-runtime-gvec.o
>   ..//accel/tcg/tcg-runtime-gvec.c: In function ‘helper_gvec_shl8i’:
>   ../accel/tcg/tcg-runtime-gvec.c:558:26: internal compiler error: in emit_move_insn, at expr.c:3495
>            *(vec8 *)(d + i) = *(vec8 *)(a + i) << shift;
>                             ^
> Fixes: db43267 "tcg: Add generic vector expanders"
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  configure | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/configure b/configure
> index 4d0e92c96c..a2301dd0dc 100755
> --- a/configure
> +++ b/configure
> @@ -5054,6 +5054,14 @@ static S2 c2;
>  static S4 c4;
>  static S8 c8;
>  static int i;
> +void helper(void *d, void *a, int shift, int i);
> +void helper(void *d, void *a, int shift, int i)
> +{
> +  *(U1 *)(d + i) = *(U1 *)(a + i) << shift;
> +  *(U2 *)(d + i) = *(U2 *)(a + i) << shift;
> +  *(U4 *)(d + i) = *(U4 *)(a + i) << shift;
> +  *(U8 *)(d + i) = *(U8 *)(a + i) << shift;
> +}
>  int main(void)
>  {
>    a1 += b1; a2 += b2; a4 += b4; a8 += b8;
> 

Queued, thanks.

Paolo
