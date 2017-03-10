Received: from eggs.gnu.org ([2001:4830:134:3::10]:51133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmHRk-0000Gf-Nv
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmHRh-0005cI-KR
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:06:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmHRh-0005cB-FC
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:06:49 -0500
References: <1489119213-977-1-git-send-email-peterx@redhat.com>
	<da6200fe-c0ac-00bb-d0b7-dbf3c5a8a21f@redhat.com>
	<20170310085917.GF17299@pxdev.xzpeter.org>
	<CAFEAcA9-xxzf-C4j+UPvv9La6pJc+gT2yE1izaej84Dd0SC+2g@mail.gmail.com>
	<20170310093638.GG17299@pxdev.xzpeter.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dbd826d7-9053-2688-ce48-74948642f9ca@redhat.com>
Date: Fri, 10 Mar 2017 11:06:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170310093638.GG17299@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hostmem: fix reference to uninit mr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>



On 10/03/2017 10:36, Peter Xu wrote:
> On Fri, Mar 10, 2017 at 10:17:30AM +0100, Peter Maydell wrote:
>> On 10 March 2017 at 09:59, Peter Xu <peterx@redhat.com> wrote:
>>> On Fri, Mar 10, 2017 at 09:33:57AM +0100, Paolo Bonzini wrote:
>>>>
>>>>
>>>> On 10/03/2017 05:13, Peter Xu wrote:
>>>>> Trying to get memory region size of an uninitialized memory region is
>>>>> probably not a good idea. Let's just do the alloc no matter what.
>>>>>
>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>
>>>> What is the effect of the bug? The idea was to do the initialization
>>>> once only (memory_region_size ought to be 0 when the MR is
>>>> uninitialized; now it is ugly but it made more sense when MemoryRegion
>>>> was just a C struct and not a QOM object).
>>>
>>> It's not really a bug. I just saw it, thought it was something not
>>> quite right, so posted a patch.
>>
>> We could reasonably abstract out the test into a function
>> bool backend_mr_initialized(HostMemoryBackend *backend)
>> {
>>     /* We forbid zero-length in file_backend_memory_alloc,
>>      * so zero always means "we haven't allocated the backend
>>      * MR yet".
>>      */
>>     return memory_region_size(&backend->mr) != 0;
>> }
>>
>> and use it in file_backend_memory_alloc(), set_mem_path()
>> and file_memory_backend_set_share(). That would make the intent
>> clearer here I think.
> 
> Agree, maybe use it in hostmem.c as well where capable?
> 
> (Paolo: I wasn't planning to add anything there, but if any of you
>  like me to do this cleanup, I would be glad to :)

Yes, please (to name things more consistently it should be
host_memory_backend_initialized).

Paolo
