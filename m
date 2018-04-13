Received: from eggs.gnu.org ([2001:4830:134:3::10]:46844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f6y37-000116-VV
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f6y32-0004Bj-VR
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:43:29 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:53793)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f6y32-0004Aq-Lv
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:43:24 -0400
References: <20180413111245.28627.3415.stgit@pasha-VirtualBox>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8d351a47-11fb-330e-b389-3dd430559226@vivier.eu>
Date: Fri, 13 Apr 2018 14:43:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180413111245.28627.3415.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] m68: fix exception stack frame for 68000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru

Le 13/04/2018 à 13:12, Pavel Dovgalyuk a écrit :
> 68000 CPUs do not save format in the exception stack frame.
> This patch adds feature checking to prevent format saving for 68000.
> m68k_ret() already includes this modification, this patch fixes
> the exception processing function too.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  target/m68k/op_helper.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 3a7f7f2..e367133 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -301,8 +301,11 @@ static inline void do_stack_frame(CPUM68KState *env, uint32_t *sp,
>          cpu_stl_kernel(env, *sp, addr);
>          break;
>      }
> -    *sp -= 2;
> -    cpu_stw_kernel(env, *sp, (format << 12) + (cs->exception_index << 2));
> +    if (m68k_feature(env, M68K_FEATURE_QUAD_MULDIV)) {
> +        /*  all except 68000 */
> +        *sp -= 2;
> +        cpu_stw_kernel(env, *sp, (format << 12) + (cs->exception_index << 2));
> +    }
>      *sp -= 4;
>      cpu_stl_kernel(env, *sp, retaddr);
>      *sp -= 2;
> 

To be the exact counterpart of m68k_rte(), I think you should include
the "switch () { }" into the "if () { }".

Thanks,
Laurent
