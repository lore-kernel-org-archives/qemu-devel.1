Received: from eggs.gnu.org ([209.51.188.92]:60246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gjitI-0001De-EV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gjitH-0005aT-Bz
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:57:48 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gjitF-0004iC-9r
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:57:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20190116105719euoutp0245be4b66a3f298fe0e6b92f0000aea74~6TvWtSocH2274622746euoutp02g
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 10:57:19 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Message-ID: <51d6d83e-94ab-f0d3-df5d-41702c13a972@samsung.com>
Date: Wed, 16 Jan 2019 13:57:07 +0300
MIME-Version: 1.0
In-Reply-To: <20190105024350.GO4157@habkost.net>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135045eucas1p1e259cacbab5e715f7845b9beee22f882@eucas1p1.samsung.com>
	<20181127135030.1671-2-i.maximets@samsung.com>
	<20181210171845.4f132e25@Igors-MacBook-Pro.local>
	<61558042-beba-3a2a-b3de-c39faf8cc078@samsung.com>
	<20181211164823.6d048a83@redhat.com>
	<20190105024350.GO4157@habkost.net>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hostmem-memfd: disable for systems
 wihtout sealing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

So, can we have any conclusion about this patch and the series?

Best regards, Ilya Maximets.

On 05.01.2019 5:43, Eduardo Habkost wrote:
> On Tue, Dec 11, 2018 at 04:48:23PM +0100, Igor Mammedov wrote:
>> On Tue, 11 Dec 2018 13:29:19 +0300
>> Ilya Maximets <i.maximets@samsung.com> wrote:
>>
>> CCing libvirt folk for an opinion
>>
>>> On 10.12.2018 19:18, Igor Mammedov wrote:
>>>> On Tue, 27 Nov 2018 16:50:27 +0300
>>>> Ilya Maximets <i.maximets@samsung.com> wrote:
>>>>
>>>> s/wihtout/without/ in subj
>>>>   
>>>>> If seals are not supported, memfd_create() will fail.
>>>>> Furthermore, there is no way to disable it in this case because
>>>>> '.seal' property is not registered.
>>>>>
>>>>> This issue leads to vhost-user-test failures on RHEL 7.2:
>>>>>
>>>>>   qemu-system-x86_64: -object memory-backend-memfd,id=mem,size=2M,: \
>>>>>                       failed to create memfd: Invalid argument
>>>>>
>>>>> and actually breaks the feature on such systems.
>>>>>
>>>>> Let's restrict memfd backend to systems with sealing support.
>>>>>
>> [...]
>>>>> @@ -177,7 +175,7 @@ static const TypeInfo memfd_backend_info = {
>>>>>  
>>>>>  static void register_types(void)
>>>>>  {
>>>>> -    if (qemu_memfd_check(0)) {
>>>>> +    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
>>>>>          type_register_static(&memfd_backend_info);  
>>>> that would either lead to not clear error that type doesn't exist.
>>>> it could be better to report sensible error from memfd_backend_memory_alloc() if
>>>> the feature is required but not supported by host   
>>>
>>> I'm not sure, but this could break the libvirt capability discovering.
>>>
>>> Current patch changes behaviour probably only for RHEL/CentOS 7.2.
>>> All other systems are not affected. Do you think that we need to
>>> change behaviour on all the systems?
>> you are changing behavior anyways, so when users start getting
>> on some of 'All other systems' start getting 'type doesn't exist'
>> error, they won't have a clue what's wrong. In case where we are
>> fixing broken defaults, shouldn't we at least do it the way that
>> would inform user about misconfiguration.
>>
>> But I'm not insisting since memfd is fairly new, it might be fine
>> for device to just disappear.
> 
> (Sorry for taking so long to reply on this series.  I couldn't
> review the code yet.)
> 
> I'd like to make the QOM type hierarchy static, and not depend on
> any runtime host capability checks.  But this is not a new
> problem in the code, so I don't think it should block this
> series.
> 
