Received: from eggs.gnu.org ([209.51.188.92]:49687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goUq6-0005zd-KY
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goUa2-0000I8-RJ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:41:45 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goUZy-0000HC-Sx
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 09:41:38 -0500
Received: by mail-oi1-x241.google.com with SMTP id r62so16346921oie.1
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 06:41:28 -0800 (PST)
References: <20190128174241.5860-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3da1b20c-5168-d32c-1ea8-f6a05212da7c@linaro.org>
Date: Tue, 29 Jan 2019 06:41:11 -0800
MIME-Version: 1.0
In-Reply-To: <20190128174241.5860-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] exec.c: Don't reallocate IOMMUNotifiers
 that are in use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 1/28/19 9:42 AM, Peter Maydell wrote:
> The tcg_register_iommu_notifier() code has a GArray of
> TCGIOMMUNotifier structs which it has registered by passing
> memory_region_register_iommu_notifier() a pointer to the embedded
> IOMMUNotifier field. Unfortunately, if we need to enlarge the
> array via g_array_set_size() this can cause a realloc(), which
> invalidates the pointer that memory_region_register_iommu_notifier()
> put into the MemoryRegion's iommu_notify list. This can result
> in segfaults.
> 
> Switch the GArray to holding pointers to the TCGIOMMUNotifier
> structs, so that we can individually allocate and free them.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 1f871c5e6b0f30644a60a ("exec.c: Handle IOMMUs in address_space_translate_for_iotlb()")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't know why I've suddenly started running into this; possibly
> it's because of a recent Ubuntu upgrade and so a newer glibc.
> ---
>  exec.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

It is odd that we have not seen this before...


r~
