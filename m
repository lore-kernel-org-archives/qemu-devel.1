Received: from eggs.gnu.org ([2001:4830:134:3::10]:33106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g8Qre-0002E9-6U
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g8Qra-0006Ch-VJ
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:13:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g8Qra-0006C5-Nj
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:13:54 -0400
References: <20180927155538.699-1-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <68699579-01dd-f281-c04b-86bd82f35db8@redhat.com>
Date: Fri, 5 Oct 2018 09:13:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180927155538.699-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/display/qxl: Suppress clang-7 warning
 about misaligned atomic operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, patches@linaro.org

On 9/27/18 10:55 AM, Peter Maydell wrote:

> Newer Spice versions (with Spice commit
> beda5ec7a6848be20c0cac2a9a8ef2a41e8069c1) will fix the bug;
> for older Spice versions, work around it by telling the compiler
> explicitly that the alignment is OK using __builtin_assume_aligned().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/qemu/compiler.h |  9 +++++++++
>   hw/display/qxl.c        | 26 +++++++++++++++++++++++++-
>   2 files changed, 34 insertions(+), 1 deletion(-)
> 

> +#ifdef HAS_ASSUME_ALIGNED
> +#define ALIGNED_UINT32_PTR(P) ((uint32_t *)__builtin_assume_aligned(P, 4))
> +#else
> +#define ALIGNED_UINT32_PTR(P) ((uint32_t *)P)
> +#endif
> +
> +    old_pending = atomic_fetch_or(ALIGNED_UINT32_PTR(&d->ram->int_pending),

The only client of your macro is not impacted, but if you want to be 
technically robust against all future uses of the macro, the fallback is 
underparenthesized, and would be safer as:

#define ALIGNED_UINT32_PTR(P) ((uint32_t *)(P))

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
