Received: from eggs.gnu.org ([2001:4830:134:3::10]:55959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZZtX-0000ut-TX
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZZtT-0007oS-J4
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:15:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZZtT-0007Vo-DJ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:15:31 -0500
References: <20180110134846.12940.99993.stgit@pasha-VirtualBox>
	<029858e0-c6e5-939d-d79e-c7ad7e5069a1@linaro.org>
	<CAFEAcA9ZMZyhV_MLvdpKD74895rXJ4cw3sX1sMHYJASe2h3LMw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b5273c61-3db0-c171-4b92-c273def5feb7@redhat.com>
Date: Thu, 11 Jan 2018 11:15:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ZMZyhV_MLvdpKD74895rXJ4cw3sX1sMHYJASe2h3LMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cpu: flush TB cache when loading VMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, maria.klimushenkova@ispras.ru, Pavel Dovgalyuk <dovgaluk@ispras.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 10/01/2018 19:32, Peter Maydell wrote:
> On 10 January 2018 at 17:49, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 01/10/2018 05:48 AM, Pavel Dovgalyuk wrote:
>>> Flushing TB cache is required because TBs key in the cache may match
>>> different code which existed in the previous state.
>>>
>>> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>>> Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
>>> ---
>>>  exec.c |    1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/exec.c b/exec.c
>>> index 4722e52..ff31e71 100644
>>> --- a/exec.c
>>> +++ b/exec.c
>>> @@ -622,6 +622,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
>>>         version_id is increased. */
>>>      cpu->interrupt_request &= ~0x01;
>>>      tlb_flush(cpu);
>>> +    tb_flush(cpu);
>>
>> I'm not necessarily objecting, but what do you mean by "may match different code"?
>>
>> What this patch suggests is that the inputs to the computation of TB->FLAGS are
>> different for some unspecified reason.  Without further explanation, to me this
>> suggests a bug in vmstate save/restore.
> 
> Yeah, this looks a little fishy. If there's code in the TB cache
> which would be wrong for the freshly-reset (or whatever)
> CPU after a VM state load, then it could just as easily
> be wrong for a 2nd CPU in an SMP config.

RAM contents are memcpy'd blindly during loadvm.  I think that's what
requires a tb_flush.

Paolo
