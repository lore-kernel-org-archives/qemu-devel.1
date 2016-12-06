Received: from eggs.gnu.org ([2001:4830:134:3::10]:48252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cECcb-0003zd-Oj
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cECcU-0007iz-0B
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:05:13 -0500
References: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
	<1480974406-29345-6-git-send-email-eric.auger@redhat.com>
	<20161206092925.mk4gwx7jbomzxsfz@kamzik.brq.redhat.com>
	<b7ba4a79-0a8d-3520-ba19-1afd6f2de4c1@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <aed4d5a3-a423-0e0f-654f-5969378efd9a@redhat.com>
Date: Tue, 6 Dec 2016 11:04:48 +0100
MIME-Version: 1.0
In-Reply-To: <b7ba4a79-0a8d-3520-ba19-1afd6f2de4c1@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [kvm-unit-tests RFC 05/15] arm/arm64: GICv3: add
 cpu count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andre Przywara <andre.przywara@arm.com>, Andrew Jones <drjones@redhat.com>
Cc: eric.auger.pro@gmail.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org, marc.zyngier@arm.com, christoffer.dall@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org, peter.maydell@linaro.org

Hi Andre, Drew,

On 06/12/2016 10:32, Andre Przywara wrote:
> Hi,
> 
> On 06/12/16 09:29, Andrew Jones wrote:
>> On Mon, Dec 05, 2016 at 10:46:36PM +0100, Eric Auger wrote:
>>> Add a new cpu_count field in gicv3_data indicating the
>>> number of redistributors. This will be useful for enumeration
>>> of their resources such as LPI pending tables.
>>
>> I'm fine with the additional state, but just curious, will it
>> ever be possible for gicv3.cpu_count != nr_cpus?
> 
> If not you are in trouble, so that should in fact be one test.
> 
> Which brings me to my comment ...
> 
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>>  lib/arm/asm/gic-v3.h | 1 +
>>>  lib/arm/gic-v3.c     | 2 ++
>>>  2 files changed, 3 insertions(+)
>>>
>>> diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
>>> index ed330af..039b7c2 100644
>>> --- a/lib/arm/asm/gic-v3.h
>>> +++ b/lib/arm/asm/gic-v3.h
>>> @@ -58,6 +58,7 @@ struct gicv3_data {
>>>  	void *dist_base;
>>>  	void *redist_base[NR_CPUS];
>>>  	unsigned int irq_nr;
>>> +	unsigned int cpu_count;
> 
> Should that be called "nr_redists" or the like?
> Since this is what it counts in the code below.
> Later we can then compare this with nr_cpus to check for a match.

I fully agree with you suggestion.

Thanks

Eric
> 
> Cheers,
> Andre.
> 
>>>  };
>>>  extern struct gicv3_data gicv3_data;
>>>  
>>> diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
>>> index 6246221..9921f4d 100644
>>> --- a/lib/arm/gic-v3.c
>>> +++ b/lib/arm/gic-v3.c
>>> @@ -12,12 +12,14 @@ void gicv3_set_redist_base(size_t stride)
>>>  	void *ptr = gicv3_data.redist_base[0];
>>>  	u64 typer;
>>>  
>>> +	gicv3_data.cpu_count = 0;
>>>  	do {
>>>  		typer = gicv3_read_typer(ptr + GICR_TYPER);
>>>  		if ((typer >> 32) == aff) {
>>>  			gicv3_redist_base() = ptr;
>>>  			return;
>>>  		}
>>> +		gicv3_data.cpu_count++;
>>>  		ptr += stride; /* skip RD_base, SGI_base, etc. */
>>>  	} while (!(typer & GICR_TYPER_LAST));
>>>  
>>> -- 
>>> 2.5.5
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
