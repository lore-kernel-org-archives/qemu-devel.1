Received: from eggs.gnu.org ([2001:4830:134:3::10]:39640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cRg5S-0000AL-TT
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cRg5O-0005cV-70
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:10:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53719
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cRg5O-0005ah-0q
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:10:38 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0CE91Lh052454
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 09:10:36 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27xb1crtjd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 09:10:36 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 12 Jan 2017 07:10:35 -0700
References: <1481767396-187748-1-git-send-email-arei.gonglei@huawei.com>
	<1481767396-187748-2-git-send-email-arei.gonglei@huawei.com>
	<e235caf4-f51c-dccf-4eb7-548d3fa71644@de.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA182B83@DGGEMA505-MBX.china.huawei.com>
	<c4282723-2afb-1764-2431-ef41f7126371@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 12 Jan 2017 15:10:25 +0100
MIME-Version: 1.0
In-Reply-To: <c4282723-2afb-1764-2431-ef41f7126371@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <a8384ff8-ff65-c578-c338-e6d8ebf498c4@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 1/1] crypto: add virtio-crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, "mst@redhat.com" <mst@redhat.com>, Luonengjun <luonengjun@huawei.com>, "Hanweidong (Randy)" <hanweidong@huawei.com>, "Xuquan (Quan Xu)" <xuquan8@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, longpeng <longpeng2@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "Wubin (H)" <wu.wubin@huawei.com>

On 01/10/2017 01:56 PM, Christian Borntraeger wrote:
> On 01/10/2017 01:36 PM, Gonglei (Arei) wrote:
>> Hi,
>>
>>>
>>> On 12/15/2016 03:03 AM, Gonglei wrote:
>>> [...]
>>>> +
>>>> +static struct crypto_alg virtio_crypto_algs[] = { {
>>>> +	.cra_name = "cbc(aes)",
>>>> +	.cra_driver_name = "virtio_crypto_aes_cbc",
>>>> +	.cra_priority = 501,
>>>
>>>
>>> This is still higher than the hardware-accelerators (like intel aesni or the
>>> s390 cpacf functions or the arm hw). aesni and s390/cpacf are supported by the
>>> hardware virtualization and available to the guests. I do not see a way how
>>> virtio
>>> crypto can be faster than that (in the end it might be cpacf/aesni + overhead)
>>> instead it will very likely be slower.
>>> So we should use a number that is higher than software implementations but
>>> lower than the hw ones.
>>>
>>> Just grepping around, the software ones seem be be around 100 and the
>>> hardware
>>> ones around 200-400. So why was 150 not enough?
>>>
>> I didn't find a documentation about how we use the priority, and I assumed
>> people use virtio-crypto will configure hardware accelerators in the
>> host. So I choosed the number which bigger than aesni's priority.
> 
> Yes, but the aesni driver will only bind if there is HW support in the guest.
> And if aesni is available in the guest (or the s390 aes function from cpacf)
> it will always be faster than the same in the host via virtio.So your priority
> should be smaller.


any opinion on this? 
