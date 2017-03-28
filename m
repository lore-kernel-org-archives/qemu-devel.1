Received: from eggs.gnu.org ([2001:4830:134:3::10]:44298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csrss-00065E-B9
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csrsr-0002ly-Ki
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:14:06 -0400
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
	<87o9x3pzxe.fsf@linaro.org>
	<alpine.BSF.2.20.1703141829440.39248@zero.eik.bme.hu>
	<95e306ce-8b80-f3c7-c374-85def4f549ff@redhat.com>
	<878to5psky.fsf@linaro.org>
	<5d39e125-e0cf-5ecf-3564-9a6a5b3b0bb6@redhat.com>
	<1489678462.15659.112.camel@redhat.com>
	<4fa44363-76fe-d33c-249c-b1af88f09f9f@redhat.com>
	<1490708459.4704.101.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c070493c-173d-9b7b-86f3-19655f65be69@redhat.com>
Date: Tue, 28 Mar 2017 16:13:59 +0200
MIME-Version: 1.0
In-Reply-To: <1490708459.4704.101.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] qemu-system-ppc video artifacts since
 "tcg: drop global lock during TCG code execution"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: jan.kiszka@siemens.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>, cota@braap.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, bobby.prani@gmail.com, fred.konrad@greensocs.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, rth@twiddle.net



On 28/03/2017 15:40, Gerd Hoffmann wrote:
>   Hi,
> 
>>> Well, not *that* simple.  vga checks the dirty bitmap with scanline
>>> granularity, like that:
>>>
>>>   foreach (scanline) {
>>>      if (get_dirty(scanline))
>>>         update_scanline()
>>>   }
>>>   reset_dirty(framebuffer)
>>>
>>> I suspect simply transforming that to
>>>
>>>   foreach (scanline) {
>>>      if (test_and_clear_dirty(scanline))
>>>        update_scanline()
>>>   }
>>>
>>> is not going to fly due to page tracking working with page granularity.
>>> With two subsequent scanlines within one page the second scanline will
>>> never be updated because updating first clears the dirty bit of the
>>> page ...
> 
>> You're right; an alternative is to copy the dirty bitmap to a local one
>> and clear the global one (the dirty bitmap for an 8 MB full HD frame
>> buffer is just 256 bytes).  With the right API to abstract the job, it
>> should be relatively easy to fix all adapters.
> 
> Started looking into this.  So I guess you are thinking about a variant
> of memory_region_test_and_clear_dirty and/or
> cpu_physical_memory_test_and_clear_dirty
> which returns a bitmap instead of a bool?  Plus some helper function
> which use the returned bitmap to figure whenever a specific scanline has
> been touched or not?

Yes, exactly.

Paolo
