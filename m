Received: from eggs.gnu.org ([2001:4830:134:3::10]:51699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1cQTHG-0005rK-Mc
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 01:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1cQTHC-0005CA-Pa
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 01:17:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:4487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1cQTHC-0005Bl-C4
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 01:17:50 -0500
References: <cover.1482164622.git.vpalatin@chromium.org>
	<85250fb0450b5b95232b39c82ab310a0632fd23f.1482164622.git.vpalatin@chromium.org>
	<fda5a694-d02f-269e-e155-1822276d74f6@redhat.com>
	<CAP_ceTxAn3tH-P8JjThXXeF7iYv5xFoVOzmjp5h8sHYsYzWTDQ@mail.gmail.com>
	<df2938db-dde1-633c-899d-646d62ec4780@redhat.com>
	<61d18d9c-32f1-983f-c237-3c28d31e2f23@redhat.com>
From: Yu Ning <yu.ning@linux.intel.com>
Message-ID: <7e2bab8d-fcb4-c861-c1b5-f85c5df674b6@linux.intel.com>
Date: Mon, 9 Jan 2017 14:17:43 +0800
MIME-Version: 1.0
In-Reply-To: <61d18d9c-32f1-983f-c237-3c28d31e2f23@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>



On 1/6/2017 5:38, Paolo Bonzini wrote:
>
> On 05/01/2017 15:01, Paolo Bonzini wrote:
>>
>> In fact there is a race anyway:
>>
>>          if (cpu->exit_request) {
>>              ret = 1;
>>              break;
>>          }
>> 					cpu->exit_request
>> 					SuspendThread
>> 					ResumeThread
>>          hax_vcpu_interrupt(env);
>>          qemu_mutex_unlock_iothread();
>>          hax_ret = hax_vcpu_run(vcpu);
>>
>> and the same race is true for QueueUserAPC.  It's rare enough that I
>> guess we can accept the patches with just a FIXME comment, but...  Yu
>> Ning, can you tell us what user_event_pending is for? :)  My hunch is
>> that we should call hax_raise_event after setting cpu->exit_request, like
>>
>> 	hax_raise_event();
>> 	/* write user_event_pending before exit_request */
>> 	smp_wmb();
>> 	cpu->exit_request = 1;
>> 	SuspendThread/ResumeThread
>> 		(or QueueUserAPC)
>>
>> and in the hax thread:
>>
>>          if (cpu->exit_request) {
>> 	    cpu->hax_vcpu->tunnel->user_event_pending = 0;
>>              ret = 1;
>>              break;
>>          }
>>
>>          hax_vcpu_interrupt(env);
>>          qemu_mutex_unlock_iothread();
>>
>> 	/* read exit_request before user_event_pending */
>> 	smp_rmb();
>>          hax_ret = hax_vcpu_run(vcpu);
>>
>> but I would like some more official documentation than my own reverse
>> engineering of the brain of whoever wrote the interface (I have not
>> looked at the HAXM driver binary).

Unfortunately, user_event_pending was introduced in 2011 without proper 
documentation, so I guess even the original author might not have an 
answer now (even if I could find him).  I need more time to analyze the 
HAXM driver code to understand what it's about.  Please feel free to add 
a FIXME for now.

But one thing I've noticed is that the Darwin driver does not test or 
reset this flag properly - it will remain 1 after the first 
hax_raise_event() call.  So removing user_event_pending from the QEMU 
side should not affect Mac.
