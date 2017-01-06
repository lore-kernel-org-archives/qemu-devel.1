Received: from eggs.gnu.org ([2001:4830:134:3::10]:49188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cPVCW-0005AZ-BH
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 09:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cPVCV-0006yj-C0
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 09:09:00 -0500
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:36729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vpalatin@google.com>) id 1cPVCV-0006yL-6J
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 09:08:59 -0500
Received: by mail-io0-x231.google.com with SMTP id p127so57153949iop.3
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 06:08:57 -0800 (PST)
MIME-Version: 1.0
Sender: vpalatin@google.com
In-Reply-To: <61d18d9c-32f1-983f-c237-3c28d31e2f23@redhat.com>
References: <cover.1482164622.git.vpalatin@chromium.org>
	<85250fb0450b5b95232b39c82ab310a0632fd23f.1482164622.git.vpalatin@chromium.org>
	<fda5a694-d02f-269e-e155-1822276d74f6@redhat.com>
	<CAP_ceTxAn3tH-P8JjThXXeF7iYv5xFoVOzmjp5h8sHYsYzWTDQ@mail.gmail.com>
	<df2938db-dde1-633c-899d-646d62ec4780@redhat.com>
	<61d18d9c-32f1-983f-c237-3c28d31e2f23@redhat.com>
From: Vincent Palatin <vpalatin@chromium.org>
Date: Fri, 6 Jan 2017 15:08:27 +0100
Message-ID: <CAP_ceTx+SXzZeg1BrF9ibAEm6MvBma+aMseMzLMcrQV_JjeOXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v5 3/4] Plumb the HAXM-based hardware
 acceleration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yu Ning <yu.ning@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Jan 5, 2017 at 10:38 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 05/01/2017 15:01, Paolo Bonzini wrote:
>>
>>
>> On 05/01/2017 14:50, Vincent Palatin wrote:
>>> Sorry I missed it.
>>> I move it to qemu_cpu_kick() as asked in the Darwin patch.
>>>
>>>> Apart from the above change, can you check if there are some less
>>>> heavyeight methods to force an exit?  I can think of QueueUserAPC with
>>>> an empty pfnAPC here, and SleepEx(0, TRUE) in qemu_hax_cpu_thread_fn
>>>> before qemu_wait_io_event_common.
>>>
>>> Actually I don't know a good test case to verify such a change, any advice ?
>
> In fact there is a race anyway:

Thanks for the detailed examples and thoughts.
The timing/benchmarking code might actually need some kind of per-vcpu
time storage, but that's a detail.
I have experimented with it and so far, I have mainly generated random
numbers ...
I have yet to find a use-case where the current code (with
SuspendThread/ResumeThread) yields a better latency than just nothing
instead :(



>
>         if (cpu->exit_request) {
>             ret = 1;
>             break;
>         }
>                                         cpu->exit_request
>                                         SuspendThread
>                                         ResumeThread
>         hax_vcpu_interrupt(env);
>         qemu_mutex_unlock_iothread();
>         hax_ret = hax_vcpu_run(vcpu);
>
> and the same race is true for QueueUserAPC.  It's rare enough that I
> guess we can accept the patches with just a FIXME comment, but...  Yu
> Ning, can you tell us what user_event_pending is for? :)  My hunch is
> that we should call hax_raise_event after setting cpu->exit_request, like
>
>         hax_raise_event();
>         /* write user_event_pending before exit_request */
>         smp_wmb();
>         cpu->exit_request = 1;
>         SuspendThread/ResumeThread
>                 (or QueueUserAPC)
>
> and in the hax thread:
>
>         if (cpu->exit_request) {
>             cpu->hax_vcpu->tunnel->user_event_pending = 0;
>             ret = 1;
>             break;
>         }
>
>         hax_vcpu_interrupt(env);
>         qemu_mutex_unlock_iothread();
>
>         /* read exit_request before user_event_pending */
>         smp_rmb();
>         hax_ret = hax_vcpu_run(vcpu);
>
> but I would like some more official documentation than my own reverse
> engineering of the brain of whoever wrote the interface (I have not
> looked at the HAXM driver binary).
>
> Paolo
