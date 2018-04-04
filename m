Received: from eggs.gnu.org ([2001:4830:134:3::10]:38953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1f3icT-00047Y-Nr
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1f3icQ-0002Qr-J9
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:38:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41046
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1f3icQ-0002Qj-Cb
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:38:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w34DUfBV091019
	for <qemu-devel@nongnu.org>; Wed, 4 Apr 2018 09:38:29 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h4x8h5658-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 09:38:29 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Wed, 4 Apr 2018 09:38:28 -0400
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
	<20180403113619.54ff1e18.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 4 Apr 2018 09:38:21 -0400
MIME-Version: 1.0
In-Reply-To: <20180403113619.54ff1e18.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <8c1287a8-4666-c5d3-fd41-e2a6b1f41e94@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/kvm: handle AP instruction
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 04/03/2018 05:36 AM, Cornelia Huck wrote:
> On Mon, 2 Apr 2018 12:36:27 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 03/26/2018 05:03 AM, Pierre Morel wrote:
>>> On 26/03/2018 10:32, David Hildenbrand wrote:
>>>> On 16.03.2018 00:24, Tony Krowiak wrote:
>>>>> +    /*
>>>>> +     * The Query Configuration Information (QCI) function (fc == 4)
>>>>> does not
>>>>> +     * set a response code in reg 1, so check for that along with the
>>>>> +     * AP feature.
>>>>> +     */
>>>>> +    if ((fc != 4) && s390_has_feat(S390_FEAT_AP)) {
>>>>> +        env->regs[1] = 0x10000;
>>>>> +
>>>>> +        return 0;
>>>>> +    }
>>>> This would imply an operation exception in case fc==4, which sounds very
>>>> wrong.
>>> It depends but I think that the S390_FEAT_AP_QUERY_CONFIG_INFO must be
>>> tested
>>> to know what to answer.
>>> If the feature is there, QCI must be answered correctly.
>> This is an interesting proposition which raises several issues that will
>> need to
>> be addressed. The only time the PQAP(QCI) instruction is intercepted is
>> when:
>> * A vfio-ap device is NOT defined for the guest because the vfio_ap
>> device driver
>>     will set ECA.28 and the PQAP(QCI) instruction will be interpreted
>> * STFLE.12 is set for the guest
>>
>> You say that the QCI must be answered correctly, but what is the correct
>> response?
>> If we return the matrix - i.e., APM, ADM and AQM - configured via the
>> mediated
>> matrix device's sysfs attributes files, then if any APQNs are defined in
>> the matrix,
>> we will have to handle *ALL* AP instructions by executing them on behalf
>> of the
>> guest. I suppose we could return an empty matrix in which case the AP
>> bus will come
>> up without any devices on the guest, but what is the expectation of an
>> admin who
>> deliberately configures the mediated matrix device? Should we forego
>> handling interception
>> of AP instructions and consider a guest configuration that turns on
>> S390_FEAT_AP but
>> does not define a vfio-ap device to be erroneous and terminate starting
>> of the guest?
>> Anybody have any thoughts?
> Hard to really give good advice without access to the documentation, but:
> - If we tell the guest that the feature is available, but it does not
>    get any cards to use, returning an empty matrix makes the most sense
>    to me.
After some thought, I am inclined to agree with this. If the no vfio-ap 
device
is defined for the guest, then anything configured for the mediated matrix
device is not relevant and the guest would therefore have no AP devices.
> - I would not tie starting the guest to the presence of a vfio-ap
>    device. Having the feature available in theory but without any
>    devices actually being usable by the guest does not really sound
>    wrong (can we hotplug this later?)
>
