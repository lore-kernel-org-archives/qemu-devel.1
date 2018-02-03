Received: from eggs.gnu.org ([2001:4830:134:3::10]:48078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei4fk-0007Yi-4n
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei4fh-0004SN-30
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:44:28 -0500
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:35113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ei4fg-0004Qy-SH
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:44:25 -0500
Received: by mail-pf0-x236.google.com with SMTP id t12so19179534pfg.2
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 12:44:24 -0800 (PST)
References: <20180203153935.8056-1-pbonzini@redhat.com>
	<20180203153935.8056-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2e6460d8-115a-9cbc-c77d-655a9e843abc@linaro.org>
Date: Sat, 3 Feb 2018 12:44:20 -0800
MIME-Version: 1.0
In-Reply-To: <20180203153935.8056-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] lockable: add QemuLockable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

On 02/03/2018 07:39 AM, Paolo Bonzini wrote:
> +/* This function gives an error if an invalid, non-NULL pointer type is passed
> + * to QEMU_MAKE_LOCKABLE.  For optimized builds, we can rely on dead-code elimination
> + * from the compiler, and give the errors already at link time.
> + */
> +#ifdef __OPTIMIZE__
> +void unknown_lock_type(void *);
> +#else
> +static inline void unknown_lock_type(void *unused)
> +{
> +    abort();
> +}

Since you're using __builtin_choose_expr, I'm surprised you would need to test
__OPTIMZE__.  The nature of the builtin is such that it *must* eliminate the
other branch; otherwise the types don't even match up.

It might be worth using __attribute__((error("message"))) on the function too.

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
