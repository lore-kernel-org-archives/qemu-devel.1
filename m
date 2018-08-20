Received: from eggs.gnu.org ([2001:4830:134:3::10]:43613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frm19-0000Fm-KL
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frm16-0005s3-Uh
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:22:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1frm16-0005rY-NG
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:22:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id m27-v6so7082747wrf.3
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 08:22:52 -0700 (PDT)
References: <CA++5wji8hmxezOz=ccBR_hxWXNc-CjAahBKDeMrXewyAsONmJg@mail.gmail.com>
	<CAFEAcA_dzS=b4sd_=qr0ihd0ofWZLM4pF33gU4ygtJb-tHxbUg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1f762d0-3337-5e04-5747-720c2b97ea92@redhat.com>
Date: Mon, 20 Aug 2018 17:22:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_dzS=b4sd_=qr0ihd0ofWZLM4pF33gU4ygtJb-tHxbUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-discuss] Handling signal of Qemu thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Probir Roy <roy@probir.info>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-discuss <qemu-discuss@nongnu.org>

On 20/08/2018 15:06, Peter Maydell wrote:
>  * SIG_IPI is one of the signals for specific CPU threads; so
>    it is blocked in the iothread, and enabled in CPU threads
>  * kvm_eat_signals() is specifically to handle SIG_IPI, and
>    affects no other signal -- if the kernel returned control
>    to QEMU because of a pending signal on this CPU thread,
>    we must make sure we've processed all the SIG_IPIs before
>    we continue

Also, recent kernel versions do not need to "eat" the SIG_IPI anymore.

More precisely, on older versions, SIG_IPI was temporarily unblocked
during the KVM_RUN ioctl but never delivered to the CPU thread;
therefore, kvm_eat_signal() had to remove the signal from the queue via
the sigtimedwait system call.  This was slow, especially for very large
virtual machines, due to spinlock contention in the kernel.

On newer versions, QEMU can process the SIG_IPI synchronously in the CPU
thread and set a flag that KVM_RUN reads (cpu->kvm_run->immediate_exit).
 On those new versions, the signal is never blocked and kvm_eat_signal()
does not do sigtimedwait anymore, it just resets
cpu->kvm_run->immediate_exit back to zero.

Thanks,

Paolo
