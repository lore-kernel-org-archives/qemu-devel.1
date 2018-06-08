Received: from eggs.gnu.org ([2001:4830:134:3::10]:48485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1fR5xg-0003JC-2R
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 21:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1fR5xc-0008Ki-Uu
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 21:13:04 -0400
References: <1528378684-14487-1-git-send-email-hejianet@gmail.com>
	<a1e699ce-c6c3-c21f-41eb-5664f52c2b86@redhat.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <e68a81d5-d13f-2cfc-ba52-98abe6768735@gmail.com>
Date: Fri, 8 Jun 2018 09:12:52 +0800
MIME-Version: 1.0
In-Reply-To: <a1e699ce-c6c3-c21f-41eb-5664f52c2b86@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/smmuv3: fix smmu emulation when
 guest smmu is in passthrough mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: jia.he@hxt-semitech.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi Eric

On 6/8/2018 1:06 AM, Auger Eric Wrote:
> Hi Jia,
> 
> On 06/07/2018 03:38 PM, Jia He wrote:
>> There is an exception when I passes iommu.passthrough=1 to guest's
>> kernel boot parameter(host QDF2400 kernel 4.17, guest kernel 4.14).
>> The guest will be hang when booting up.
>>
>> When guest smmu is in passthrough mode, entry.perm will not be assigned
>> to flag in smmuv3_translate. It seems not be correct.
>>
>> After this patch, I have tested in 4 cases and all passed.
>> host smmu on/passthrough + guest smmu on/passthrough
>>
>> Signed-off-by: jia.he@hxt-semitech.com
>> ---
>>  hw/arm/smmuv3.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 42dc521..5c46102 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -560,6 +560,12 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>      }
>>  
>>      ret = smmuv3_decode_config(mr, &cfg, &event);
>> +
>> +    if (cfg.bypassed) {
>> +        ret = 0;
>> +        goto out;
>> +    }
> Thank you for spotting this bug. Yes you're correct: on bypass we
> effectively need to set the IOMMUTLBEntry perm flags.
> 
> Reading the code again I think the error handling logic is really
> confusing and if you don't mind, I suggest I submit a global fix. On
> bypass we should rather have a bypass trace event issued instead of the
> translated one. To me the aborted case is not properly handled either as
> we are going to record an event whereas we shouldn't. In case of
> abort/bypass translation structure decoding should rather return 0 I
> think instead of returning errors. Please let me know if it suits you.
> 
Ok with me

Cheers，
Jia
