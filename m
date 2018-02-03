Received: from eggs.gnu.org ([2001:4830:134:3::10]:49916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei4sT-00062C-7E
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei4sO-00043y-Cv
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:57:37 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:44830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ei4sO-00043V-68
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:57:32 -0500
Received: by mail-pl0-x243.google.com with SMTP id f8so8944280plk.11
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 12:57:31 -0800 (PST)
References: <20180203153935.8056-1-pbonzini@redhat.com>
	<20180203153935.8056-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4f32a406-25cd-e8f7-bd8f-46d62be260b8@linaro.org>
Date: Sat, 3 Feb 2018 12:57:28 -0800
MIME-Version: 1.0
In-Reply-To: <20180203153935.8056-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] coroutine-lock: make
 qemu_co_enter_next thread-safe
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
> qemu_co_queue_next does not need to release and re-acquire the mutex,
> because the queued coroutine does not run immediately.  However, this
> does not hold for qemu_co_enter_next.  Now that qemu_co_queue_wait
> can synchronize (via QemuLockable) with code that is not running in
> coroutine context, it's important that code using qemu_co_enter_next
> can easily use a standardized locking idiom.
> 
> First of all, qemu_co_enter_next must use aio_co_wake to restart the
> coroutine.  Second, the function gains a second argument, a QemuLockable*,
> and the comments of qemu_co_queue_next and qemu_co_queue_restart_all
> are adjusted to clarify the difference.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  fsdev/qemu-fsdev-throttle.c |  4 ++--
>  include/qemu/coroutine.h    | 19 +++++++++++++------
>  util/qemu-coroutine-lock.c  | 10 ++++++++--
>  3 files changed, 23 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
