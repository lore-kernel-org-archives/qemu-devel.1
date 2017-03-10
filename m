Received: from eggs.gnu.org ([2001:4830:134:3::10]:36186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cmGgL-0001Ak-KA
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cmGgK-00011V-Hy
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:17:53 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cmGgK-00010T-AT
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:17:52 -0500
Received: by mail-wr0-x22a.google.com with SMTP id g10so60918262wrg.2
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 01:17:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170310085917.GF17299@pxdev.xzpeter.org>
References: <1489119213-977-1-git-send-email-peterx@redhat.com>
	<da6200fe-c0ac-00bb-d0b7-dbf3c5a8a21f@redhat.com>
	<20170310085917.GF17299@pxdev.xzpeter.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Mar 2017 10:17:30 +0100
Message-ID: <CAFEAcA9-xxzf-C4j+UPvv9La6pJc+gT2yE1izaej84Dd0SC+2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hostmem: fix reference to uninit mr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On 10 March 2017 at 09:59, Peter Xu <peterx@redhat.com> wrote:
> On Fri, Mar 10, 2017 at 09:33:57AM +0100, Paolo Bonzini wrote:
>>
>>
>> On 10/03/2017 05:13, Peter Xu wrote:
>> > Trying to get memory region size of an uninitialized memory region is
>> > probably not a good idea. Let's just do the alloc no matter what.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>>
>> What is the effect of the bug? The idea was to do the initialization
>> once only (memory_region_size ought to be 0 when the MR is
>> uninitialized; now it is ugly but it made more sense when MemoryRegion
>> was just a C struct and not a QOM object).
>
> It's not really a bug. I just saw it, thought it was something not
> quite right, so posted a patch.

We could reasonably abstract out the test into a function
bool backend_mr_initialized(HostMemoryBackend *backend)
{
    /* We forbid zero-length in file_backend_memory_alloc,
     * so zero always means "we haven't allocated the backend
     * MR yet".
     */
    return memory_region_size(&backend->mr) != 0;
}

and use it in file_backend_memory_alloc(), set_mem_path()
and file_memory_backend_set_share(). That would make the intent
clearer here I think.

thanks
-- PMM
