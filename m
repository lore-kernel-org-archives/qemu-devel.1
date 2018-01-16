Received: from eggs.gnu.org ([2001:4830:134:3::10]:55968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebHge-0007NE-KN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:13:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebHgb-0002j8-Fi
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:13:20 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ebHgb-0002im-9o
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:13:17 -0500
Received: by mail-pg0-f67.google.com with SMTP id w17so2988786pgv.6
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:13:17 -0800 (PST)
From: Fam Zheng <fzheng@redhat.com>
References: <20180115220822.10156-1-pbonzini@redhat.com>
Message-ID: <35d5a516-3848-2389-43ce-3deab16cf8e7@redhat.com>
Date: Tue, 16 Jan 2018 11:13:04 +0800
MIME-Version: 1.0
In-Reply-To: <20180115220822.10156-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/4] coroutine-lock: polymorphic CoQueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org



On 01/16/2018 06:08 AM, Paolo Bonzini wrote:
> There are cases in which a queued coroutine must be restarted from
> non-coroutine context (with qemu_co_enter_next).  In this cases,
> qemu_co_enter_next also needs to be thread-safe, but it cannot use a
> CoMutex and so cannot qemu_co_queue_wait.  This happens in curl (which
> right now is rolling its own list of Coroutines) and will happen in
> Fam's NVMe driver as well.
>
> This series extracts the idea of a polymorphic lockable object
> from my "scoped lock guard" proposal, and applies it to CoQueue.
> The implementation of QemuLockable is similar to C11 _Generic, but
> redone using the preprocessor and GCC builtins for compatibility.
>
> In general, while a bit on the esoteric side, the functionality used
> to emulate _Generic is fairly old in GCC, and the builtins are already
> used by include/qemu/atomic.h; the series was tested with Fedora 27 (boot
> Damn Small Linux via http) and CentOS 6 (compiled only).

Reviewed-by: Fam Zheng <famz@redhat.com>
