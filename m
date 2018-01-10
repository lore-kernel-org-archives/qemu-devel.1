Received: from eggs.gnu.org ([2001:4830:134:3::10]:42064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZLAq-00038B-V1
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZLAq-0006kG-1T
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:32:28 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:42986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZLAp-0006iL-Ot
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:32:27 -0500
Received: by mail-ot0-x243.google.com with SMTP id s3so2704072otc.9
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 10:32:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <029858e0-c6e5-939d-d79e-c7ad7e5069a1@linaro.org>
References: <20180110134846.12940.99993.stgit@pasha-VirtualBox>
	<029858e0-c6e5-939d-d79e-c7ad7e5069a1@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Jan 2018 18:32:05 +0000
Message-ID: <CAFEAcA9ZMZyhV_MLvdpKD74895rXJ4cw3sX1sMHYJASe2h3LMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] cpu: flush TB cache when loading VMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, maria.klimushenkova@ispras.ru, Pavel Dovgalyuk <dovgaluk@ispras.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 10 January 2018 at 17:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 01/10/2018 05:48 AM, Pavel Dovgalyuk wrote:
>> Flushing TB cache is required because TBs key in the cache may match
>> different code which existed in the previous state.
>>
>> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>> Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
>> ---
>>  exec.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/exec.c b/exec.c
>> index 4722e52..ff31e71 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -622,6 +622,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
>>         version_id is increased. */
>>      cpu->interrupt_request &= ~0x01;
>>      tlb_flush(cpu);
>> +    tb_flush(cpu);
>
> I'm not necessarily objecting, but what do you mean by "may match different code"?
>
> What this patch suggests is that the inputs to the computation of TB->FLAGS are
> different for some unspecified reason.  Without further explanation, to me this
> suggests a bug in vmstate save/restore.

Yeah, this looks a little fishy. If there's code in the TB cache
which would be wrong for the freshly-reset (or whatever)
CPU after a VM state load, then it could just as easily
be wrong for a 2nd CPU in an SMP config.

I used to think it was OK to have the generated code bake
in some information that wasn't in tb_flags as long as you
then did a tb_flush when that information changed, but
I realized I was wrong about that (because of the SMP issue).

git grep suggests we do still have a few places in targets
that are calling tb_flush(), but I think we should try to
fix those.

thanks
-- PMM
