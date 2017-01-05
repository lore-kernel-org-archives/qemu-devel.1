Received: from eggs.gnu.org ([2001:4830:134:3::10]:53029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cPFjb-0003U2-GB
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cPFjY-0000az-Cc
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:38:07 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:32969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cPFjY-0000ap-5X
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:38:04 -0500
Received: by mail-wm0-x241.google.com with SMTP id u144so593451wmu.0
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 13:38:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <cover.1482164622.git.vpalatin@chromium.org>
	<85250fb0450b5b95232b39c82ab310a0632fd23f.1482164622.git.vpalatin@chromium.org>
	<fda5a694-d02f-269e-e155-1822276d74f6@redhat.com>
	<CAP_ceTxAn3tH-P8JjThXXeF7iYv5xFoVOzmjp5h8sHYsYzWTDQ@mail.gmail.com>
	<df2938db-dde1-633c-899d-646d62ec4780@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <61d18d9c-32f1-983f-c237-3c28d31e2f23@redhat.com>
Date: Thu, 5 Jan 2017 22:38:00 +0100
MIME-Version: 1.0
In-Reply-To: <df2938db-dde1-633c-899d-646d62ec4780@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Vincent Palatin <vpalatin@chromium.org>
Cc: Yu Ning <yu.ning@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>



On 05/01/2017 15:01, Paolo Bonzini wrote:
> 
> 
> On 05/01/2017 14:50, Vincent Palatin wrote:
>> Sorry I missed it.
>> I move it to qemu_cpu_kick() as asked in the Darwin patch.
>>
>>> Apart from the above change, can you check if there are some less
>>> heavyeight methods to force an exit?  I can think of QueueUserAPC with
>>> an empty pfnAPC here, and SleepEx(0, TRUE) in qemu_hax_cpu_thread_fn
>>> before qemu_wait_io_event_common.
>>
>> Actually I don't know a good test case to verify such a change, any advice ?

In fact there is a race anyway:

        if (cpu->exit_request) {
            ret = 1;
            break;
        }
					cpu->exit_request
					SuspendThread
					ResumeThread
        hax_vcpu_interrupt(env);
        qemu_mutex_unlock_iothread();
        hax_ret = hax_vcpu_run(vcpu);

and the same race is true for QueueUserAPC.  It's rare enough that I
guess we can accept the patches with just a FIXME comment, but...  Yu
Ning, can you tell us what user_event_pending is for? :)  My hunch is
that we should call hax_raise_event after setting cpu->exit_request, like

	hax_raise_event();
	/* write user_event_pending before exit_request */
	smp_wmb();
	cpu->exit_request = 1;
	SuspendThread/ResumeThread
		(or QueueUserAPC)

and in the hax thread:

        if (cpu->exit_request) {
	    cpu->hax_vcpu->tunnel->user_event_pending = 0;
            ret = 1;
            break;
        }

        hax_vcpu_interrupt(env);
        qemu_mutex_unlock_iothread();

	/* read exit_request before user_event_pending */
	smp_rmb();
        hax_ret = hax_vcpu_run(vcpu);

but I would like some more official documentation than my own reverse
engineering of the brain of whoever wrote the interface (I have not
looked at the HAXM driver binary).

Paolo
