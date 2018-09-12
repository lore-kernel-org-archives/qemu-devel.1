Received: from eggs.gnu.org ([2001:4830:134:3::10]:46083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g09Gd-0002vt-UZ
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g09GW-0005nB-6k
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:49:28 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g09GU-0005lu-9c
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:49:24 -0400
Received: by mail-pf1-x441.google.com with SMTP id u24-v6so1358692pfn.13
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 10:49:19 -0700 (PDT)
References: <1536701379-106032-1-git-send-email-sandra@codesourcery.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <618b095d-d3fd-4cbb-f2ba-37e0f4902f28@linaro.org>
Date: Wed, 12 Sep 2018 10:49:16 -0700
MIME-Version: 1.0
In-Reply-To: <1536701379-106032-1-git-send-email-sandra@codesourcery.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Fix breakpoints in nios2 user-mode
 emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandra Loosemore <sandra@codesourcery.com>, qemu-devel@nongnu.org
Cc: marex@denx.de, crwulff@gmail.com, alex.bennee@linaro.org

On 09/11/2018 02:29 PM, Sandra Loosemore wrote:
> Without this patch, QEMU exits immediately when it execution stops at
> a breakpoint, instead of reporting it to GDB.
> 
> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
> ---
>  linux-user/nios2/cpu_loop.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
> index dac7a06..a5ae37f 100644
> --- a/linux-user/nios2/cpu_loop.c
> +++ b/linux-user/nios2/cpu_loop.c
> @@ -71,6 +71,9 @@ void cpu_loop(CPUNios2State *env)
>                  gdbsig = TARGET_SIGTRAP;
>                  break;
>              }
> +        case EXCP_DEBUG:
> +            gdbsig = TARGET_SIGTRAP;
> +            break;

This really isn't complete.  You set gdbsig from odd places instead of using
queue_signal; you fail to honor the return value from gdb_handlesig.

But I suppose those should be separate patches, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
