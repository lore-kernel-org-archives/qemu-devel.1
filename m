Received: from eggs.gnu.org ([2001:4830:134:3::10]:46491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecVQg-0003oN-Tg
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecVQd-0000lu-OL
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:05:54 -0500
Received: from mail.ispras.ru ([83.149.199.45]:48670)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecVQd-0000kl-Gy
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:05:51 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180119084235.7100.98318.stgit@pasha-VirtualBox>
	<20180119084417.7100.69568.stgit@pasha-VirtualBox>
	<aca12788-c119-3046-ee8f-e7b3d4cc59bb@redhat.com>
In-Reply-To: <aca12788-c119-3046-ee8f-e7b3d4cc59bb@redhat.com>
Date: Fri, 19 Jan 2018 15:05:55 +0300
Message-ID: <002a01d3911d$dc13ca80$943b5f80$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v4 13/23] cpus: only take BQL for
 sleeping threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 19/01/2018 09:44, Pavel Dovgalyuk wrote:
> >      while (all_cpu_threads_idle()) {
> > +        qemu_mutex_lock_iothread();
> >          stop_tcg_kick_timer();
> >          qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
> > +        qemu_mutex_unlock_iothread();
> >      }
> 
> cpu_has_work cannot be called outside BQL yet.  You first need to access
> cpu->interrupt_request with atomics.
> 
> In general, testing the condition outside the mutex is a very dangerous
> pattern (and I'm usually the one who enjoys dangerous patterns).

It means, that I'll have to fix all the has_work function to avoid races,
because x86_cpu_has_work may have them?

static bool x86_cpu_has_work(CPUState *cs)
{
    X86CPU *cpu = X86_CPU(cs);
    CPUX86State *env = &cpu->env;

    return ((cs->interrupt_request & (CPU_INTERRUPT_HARD |
                                      CPU_INTERRUPT_POLL)) &&
            (env->eflags & IF_MASK)) ||
           (cs->interrupt_request & (CPU_INTERRUPT_NMI |
                                     CPU_INTERRUPT_INIT |
                                     CPU_INTERRUPT_SIPI |
                                     CPU_INTERRUPT_MCE)) ||
           ((cs->interrupt_request & CPU_INTERRUPT_SMI) &&
            !(env->hflags & HF_SMM_MASK));
}

Pavel Dovgalyuk
