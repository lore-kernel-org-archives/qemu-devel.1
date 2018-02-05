Received: from eggs.gnu.org ([2001:4830:134:3::10]:39254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eihub-0005nF-9I
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:38:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eihuW-0007xb-Lk
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:38:25 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180203153935.8056-1-pbonzini@redhat.com>
	<20180203153935.8056-3-pbonzini@redhat.com>
	<2e6460d8-115a-9cbc-c77d-655a9e843abc@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf76eb21-b426-326c-3583-953b3128c395@redhat.com>
Date: Mon, 5 Feb 2018 15:38:10 +0100
MIME-Version: 1.0
In-Reply-To: <2e6460d8-115a-9cbc-c77d-655a9e843abc@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

On 03/02/2018 21:44, Richard Henderson wrote:
> On 02/03/2018 07:39 AM, Paolo Bonzini wrote:
>> +/* This function gives an error if an invalid, non-NULL pointer type is passed
>> + * to QEMU_MAKE_LOCKABLE.  For optimized builds, we can rely on dead-code elimination
>> + * from the compiler, and give the errors already at link time.
>> + */
>> +#ifdef __OPTIMIZE__
>> +void unknown_lock_type(void *);
>> +#else
>> +static inline void unknown_lock_type(void *unused)
>> +{
>> +    abort();
>> +}
> 
> Since you're using __builtin_choose_expr, I'm surprised you would need to test
> __OPTIMZE__.  The nature of the builtin is such that it *must* eliminate the
> other branch; otherwise the types don't even match up.

__builtin_choose_expr works fine.  However we also have

	return x ? __builtin_choose_expr(..., unknown_lock_type) : NULL;

and if "x" is NULL then its type is a void*, and the LHS will refer to
unknown_lock_type.  I was expecting __always_inline__ to be enough to
avoid this, but apparently this is not the case.

Paolo

> It might be worth using __attribute__((error("message"))) on the function too.
> 
> Otherwise,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 
