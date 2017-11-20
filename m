Received: from eggs.gnu.org ([2001:4830:134:3::10]:46652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eGmCx-00066j-AI
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eGmCt-00011B-Ck
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:33:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eGmCs-00010D-RB
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:33:51 -0500
References: <8726068c-1112-eaea-5315-ec17ae37ae33@huawei.com>
	<878tf1xgff.fsf@linaro.org>
	<CAFEAcA9pg-yRfNJg5uFqU=pve9ypboisB5jo3piZ+ffLVy2xwQ@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <56804ea7-8bd1-ffe7-6b9b-986460b2560d@huawei.com>
Date: Mon, 20 Nov 2017 21:32:34 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9pg-yRfNJg5uFqU=pve9ypboisB5jo3piZ+ffLVy2xwQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [question] mask SIGBUS in qemu main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Wuquanming <wuquanming@huawei.com>, Huangshaoyu <huangshaoyu@huawei.com>

On 2017/11/20 21:00, Peter Maydell wrote:
> On 20 November 2017 at 12:50, Alex Bennée <alex.bennee@linaro.org> wrote:
>> What exactly do you expect the main thread to do with a SIGBUS signal?
> 
> For KVM, we (can) use SIGBUS for handling machine check exceptions:
> see qemu_init_sigbus() in cpus.c, where we use prctl(PR_MCE_KILL)
> to ask the host kernel to send us a SIGBUS if the memory used
> by the VM has memory corruption detected by the hardwar. This
> then lets us inform the guest (see kvm_mce_inject() in target/i386).
> (This will probably be coming to Arm KVM at some point, as part
> of the RAS extension support. See various threads in kvmarm list.)

thanks, yes, indeed.

when the RAS is enabled, if a guest memory address is corruption, host will unmap the stage2 mapping and try to find a Qemu thread to
deliver the SIGBUS signal[1]. when Qemu receive the signal, it will try to do some recovery for guest.
such as kvm_mce_inject() in target/i386.

In host kernel[1], if the flag  set MF_ACTION_REQUIRED, host will find current vcpu thread to deliver SIGBUS with si_code BUS_MCEERR_AR
Otherwise it will  find Qemu main thread to deliver the SIGBUS with si_code BUS_MCEERR_AO
For this case, Qemu will block this SIGBUS and this signal will be always pending.

For the KVM[2], it does not matter, because KVM will choose the current vcpu thread to deliver SIGBUS, not the main Qemu thread.


[1]
static int kill_proc(struct task_struct *t, unsigned long addr, int trapno,
                        unsigned long pfn, struct page *page, int flags)
	..................
        if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
                si.si_code = BUS_MCEERR_AR;
                ret = force_sig_info(SIGBUS, &si, current);
        } else {
                /*
                 * Don't use force here, it's convenient if the signal
                 * can be temporarily blocked.
                 * This could cause a loop when the user sets SIGBUS
                 * to SIG_IGN, but hopefully no one will do that?
                 */
                si.si_code = BUS_MCEERR_AO;
                ret = send_sig_info(SIGBUS, &si, t);  /* synchronous? */
        }
}


[2]
static void kvm_send_hwpoison_signal(unsigned long address,
                                     struct vm_area_struct *vma)
{
        siginfo_t info;

        info.si_signo   = SIGBUS;
        info.si_errno   = 0;
        info.si_code    = BUS_MCEERR_AR;
        info.si_addr    = (void __user *)address;

        if (is_vm_hugetlb_page(vma))
                info.si_addr_lsb = huge_page_shift(hstate_vma(vma));
        else
                info.si_addr_lsb = PAGE_SHIFT;

        send_sig_info(SIGBUS, &info, current);
}

> 
> Because asynchronous signals are a pain to deal with, for the
> main thread we handle all our signals via signalfd(), which is
> why the main thread shows SIGBUS as blocked. The main thread
> will pick the signal up via the fd at some point. For KVM vcpu
> threads, the signal arrives asynchronously. See sigbus_handler()
> in cpus.c.

thanks Pether's explanation.
yes, you are right.

> 
> thanks
> -- PMM
> 
> 
