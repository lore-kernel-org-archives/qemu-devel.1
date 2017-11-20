Received: from eggs.gnu.org ([2001:4830:134:3::10]:37072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eGn3L-0003k7-Bj
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eGn3I-0003Ww-9Q
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:28:03 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1511184421-23535-1-git-send-email-peter.maydell@linaro.org>
	<1511184421-23535-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1aaf0a6f-c38b-d80d-b09a-1a54545c7660@twiddle.net>
Date: Mon, 20 Nov 2017 15:27:44 +0100
MIME-Version: 1.0
In-Reply-To: <1511184421-23535-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/2] accel/tcg: Handle atomic
 accesses to notdirty memory correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stuart Monteith <stuart.monteith@linaro.org>

On 11/20/2017 02:27 PM, Peter Maydell wrote:
> -    return (void *)((uintptr_t)addr + tlbe->addend);
> +    hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
> +
> +    memory_notdirty_write_prepare(ndi, ENV_GET_CPU(env), addr,
> +                                  qemu_ram_addr_from_host_nofail(hostaddr),
> +                                  1 << s_bits);

These calls should be conditional on TLB_NOTDIRTY being set.
We certainly don't need to do anything like taking a lock otherwise.

Perhaps an extra bool in NDI, like

  ndi->active = false;
  if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
      ndi->active = true;
      memory_notdirty_write_prepare(ndi, ...);
  }

and

#define ATOMIC_MMU_CLEANUP \
do { \
  if (unlikely(ndi->active)) { \
     memory_notdirty_write_complete(ndi); \
  } \
} while (0)


r~
