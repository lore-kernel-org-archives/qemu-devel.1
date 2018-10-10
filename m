Received: from eggs.gnu.org ([2001:4830:134:3::10]:50808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAFMC-00047Q-E2
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gAFM6-0003mU-Hu
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:20:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46228
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gAFM4-0003lL-MS
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:20:54 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9AEKjcC032648
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:20:51 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2n1fyt9abf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:20:48 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Wed, 10 Oct 2018 08:20:38 -0600
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-6-akrowiak@linux.vnet.ibm.com>
	<b5b11801-256d-dc7b-2a16-ad4b25d9681b@linux.ibm.com>
	<386c2fbc-e859-ef60-5aa8-9c7821355369@de.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 10 Oct 2018 10:20:28 -0400
MIME-Version: 1.0
In-Reply-To: <386c2fbc-e859-ef60-5aa8-9c7821355369@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f8180e55-7425-f2d3-938c-44bb2032bd00@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v10 5/6] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com

On 10/10/2018 08:49 AM, Christian Borntraeger wrote:
> 
> 
> On 10/10/2018 02:37 PM, Pierre Morel wrote:
>> On 09/10/2018 19:52, Tony Krowiak wrote:
> 
>>> +static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
>>> +{
>>> +    GError *gerror;
>>> +    char *symlink, *group_path;
>>> +    int groupid;
>>> +
>>> +    symlink = g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsdev);
>>> +    group_path = g_file_read_link(symlink, &gerror);
>>
>>
>> hum I oversaw this change, it leads to segfault.
> 
> Yes, this was a review feedback from v9 to use the glib function.
>>
>> You must initialize gerror before use.
>> The following patch avoid a segmentation fault:
>>
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 5543406afc..3b8e9ba6dc 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -59,7 +59,7 @@ static void vfio_ap_put_device(VFIOAPDevice *vapdev)
>>
>>   static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
>>   {
>> -    GError *gerror;
>> +    GError *gerror = NULL;
>>       char *symlink, *group_path;
>>       int groupid;
> 
> With that fix, series
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Tony, can you fold that fixup from Pierre into your v11?

It is done.

> 
