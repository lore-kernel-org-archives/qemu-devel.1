Received: from eggs.gnu.org ([2001:4830:134:3::10]:50579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1eKoi7-0003JL-Q2
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1eKohz-0001c5-Ol
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:02:43 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:37731)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prasad.singamsetty@oracle.com>)
	id 1eKohz-0001YY-FO
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:02:39 -0500
References: <20171114231350.286025-1-prasad.singamsetty@oracle.com>
	<20171114231350.286025-3-prasad.singamsetty@oracle.com>
	<20171128193156-mutt-send-email-mst@kernel.org>
	<cdbe8732-88fa-512e-481b-250abc18bf92@oracle.com>
	<20171130032551.GA18017@xz-mi>
	<367bb386-2885-2ea2-b766-d5bde2c79bcf@oracle.com>
	<20171130205443-mutt-send-email-mst@kernel.org>
	<fb9c086b-2b95-d09e-1c3f-d2274a347de6@oracle.com>
	<20171201044338.GB2712@xz-mi>
From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Message-ID: <736c9e99-0d17-6122-0460-805148567e9d@oracle.com>
Date: Fri, 1 Dec 2017 09:02:30 -0800
MIME-Version: 1.0
In-Reply-To: <20171201044338.GB2712@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] intel-iommu: Extend address width
 to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, ehabkost@redhat.com, konrad.wilk@oracle.com, qemu-devel@nongnu.org, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net



On 11/30/2017 8:43 PM, Peter Xu wrote:
> On Thu, Nov 30, 2017 at 11:12:48AM -0800, Prasad Singamsetty wrote:
>>
>>
>> On 11/30/2017 10:56 AM, Michael S. Tsirkin wrote:
>>> On Thu, Nov 30, 2017 at 10:33:50AM -0800, Prasad Singamsetty wrote:
>>>>
>>>>
>>>> On 11/29/2017 7:25 PM, Peter Xu wrote:
>>>>> On Wed, Nov 29, 2017 at 01:05:22PM -0800, Prasad Singamsetty wrote:
>>>>>> Thanks Michael. Some comments below.
>>>>>>
>>>>>> On 11/28/2017 9:32 AM, Michael S. Tsirkin wrote:
>>>>>>> On Tue, Nov 14, 2017 at 06:13:50PM -0500, prasad.singamsetty@oracle.com wrote:
>>>>>>>> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
>>>>>>>>
>>>>>>>> The current implementation of Intel IOMMU code only supports 39 bits
>>>>>>>> iova address width. This patch provides a new parameter (x-aw-bits)
>>>>>>>> for intel-iommu to extend its address width to 48 bits but keeping the
>>>>>>>> default the same (39 bits). The reason for not changing the default
>>>>>>>> is to avoid potential compatibility problems
>>>>>>>
>>>>>>> You can change the default, just make it 39 for existing machine types.
>>>>>>
>>>>>> I think introducing a new machine type is not appropriate as this
>>>>>> is an implementation limitation for the existing machine type.
>>>>>> Currently q35 is the only machine type that supports intel-iommu.
>>>>>> And we want to retain the current default behavior for q35 to avoid
>>>>>> any new issues with live migration.
>>>>>
>>>>> I guess "existing machine type" means e.g. pc-q35-2.11 and older ones,
>>>>> rather than creating another machine type in parallel with q35.  So we
>>>>> can set 48 bits as default on upcoming pc-q35-2.12 machines, while
>>>>> keep the 39 bits on the old ones.
>>>>>
>>>>> Please refer to include/hw/compat.h.
>>>>
>>>> Thanks Peter, for the clarification and pointer to this. I am still
>>>> new to this but learning on how this works or how this is used in
>>>> use cases like Live Migration.
> 
> You can refer to similar commit, like 048a2e8869.
> 
> But, I think I was wrong - you should better do the addition to
> include/hw/i386/pc.h (see e.g. PC_COMPAT_2_10) rather than compat.h,
> since Intel vIOMMU is only used for PC machines.

Thanks, Peter. That sounds good. We can add the compatibility
default value to PC_COMPAT_2_11. How does it work for older
machine types like PC_COMPAT_2_10 and older?

> 
> And... you may also need to create that PC_COMPAT_2_11 macro after
> 2.11 is released.  For that you can refer to a6fd5b0e050a.
> 
> Anyway, I think this "set default" work can be postponed after recent
> release, which can be a separate work besides current series.

OK. To be clear, are you suggesting that we can change the default
value to 48 bits as a separate patch and not include it with the
current patch set?

> 
>>>>
>>>> Are you suggesting that we change the default to 48 bits in the
>>>> next release (2.12)?
>>>>
>>>> User need to specify an older machine type  (pc-q35-2.11 or older)
>>>> to get the old default value of 39 bits. This still requires the
>>>> patch I proposed to support compatibility for older releases
>>>> except the introduction of the new property (x-aw-bits).
>>>
>>> Yes. If you see a reason for users to limit it to 39 bits,
>>> we can make it a supported property (not starting
>>> with x-). If it's only for live migration, we can
>>> use a non-supported property (with x-).
>> I think it is only for Live Migration case, we need to
>> support the old default value of 39 bits.
>>
>> Do you see any need to keep a non-supported property?
>> It may be useful for developers.
> 
> IMHO if it's for developers x-* would be good enough.  Thanks,
> 

Sounds good.

Thanks.
--Prasad
