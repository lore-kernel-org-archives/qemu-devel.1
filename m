Received: from eggs.gnu.org ([2001:4830:134:3::10]:52774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cQdDR-0000rI-Ac
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cQdDQ-0001ar-Hm
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:54:37 -0500
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:33656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vpalatin@google.com>) id 1cQdDQ-0001Zx-Cp
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:54:36 -0500
Received: by mail-io0-x22f.google.com with SMTP id v96so84559741ioi.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 08:54:34 -0800 (PST)
MIME-Version: 1.0
Sender: vpalatin@google.com
In-Reply-To: <459d4c70-aaa7-0d4d-e6c2-5a439243e481@redhat.com>
References: <cover.1482164622.git.vpalatin@chromium.org>
	<85250fb0450b5b95232b39c82ab310a0632fd23f.1482164622.git.vpalatin@chromium.org>
	<fda5a694-d02f-269e-e155-1822276d74f6@redhat.com>
	<CAP_ceTxAn3tH-P8JjThXXeF7iYv5xFoVOzmjp5h8sHYsYzWTDQ@mail.gmail.com>
	<df2938db-dde1-633c-899d-646d62ec4780@redhat.com>
	<61d18d9c-32f1-983f-c237-3c28d31e2f23@redhat.com>
	<CAP_ceTx+SXzZeg1BrF9ibAEm6MvBma+aMseMzLMcrQV_JjeOXg@mail.gmail.com>
	<459d4c70-aaa7-0d4d-e6c2-5a439243e481@redhat.com>
From: Vincent Palatin <vpalatin@chromium.org>
Date: Mon, 9 Jan 2017 17:54:13 +0100
Message-ID: <CAP_ceTw7bh0S-GMxXrE1xPxZOYp_XLhGUi4c7DcQ8Azc0S7Tcg@mail.gmail.com>
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

On Mon, Jan 9, 2017 at 2:03 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 06/01/2017 15:08, Vincent Palatin wrote:
>>>>>> Apart from the above change, can you check if there are some less
>>>>>> heavyeight methods to force an exit?  I can think of QueueUserAPC with
>>>>>> an empty pfnAPC here, and SleepEx(0, TRUE) in qemu_hax_cpu_thread_fn
>>>>>> before qemu_wait_io_event_common.
>>>>> Actually I don't know a good test case to verify such a change, any advice ?
>>> In fact there is a race anyway:
>> Thanks for the detailed examples and thoughts.
>> The timing/benchmarking code might actually need some kind of per-vcpu
>> time storage, but that's a detail.
>> I have experimented with it and so far, I have mainly generated random
>> numbers ...
>> I have yet to find a use-case where the current code (with
>> SuspendThread/ResumeThread) yields a better latency than just nothing
>> instead :(
>
> :)  Does QueueUserAPC generate better latency?


The same kind of random numbers so far.

By the way I have added  the THREAD_SET_CONTEXT  flag to the
OpenThread call in qemu_thread_get_handle() function, as I was getting
ACCESS_DENIED on the QueueUserApc call. Probably not terribly harmful.
I will publish the v6 series with this and continue my benchmarking quest.

>
> Windows delivers the scheduler tick to the first physical CPU.  Try
> pinning QEMU away from the first CPU.

Ok interesting, I will give it a try.

-- 
Vincent
