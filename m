Received: from eggs.gnu.org ([2001:4830:134:3::10]:56177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=063091f310=akrowiak@linux.vnet.ibm.com>)
	id 1f32Ug-0006O8-SZ
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 12:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=063091f310=akrowiak@linux.vnet.ibm.com>)
	id 1f32Ue-0007wO-3K
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 12:39:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=063091f310=akrowiak@linux.vnet.ibm.com>)
	id 1f32Ud-0007vR-RK
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 12:39:40 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w32GV2V6029953
	for <qemu-devel@nongnu.org>; Mon, 2 Apr 2018 12:39:38 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h3nqvyfjq-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 12:39:38 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Mon, 2 Apr 2018 12:39:36 -0400
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<bc9bf25d-6bf2-67ec-539b-8a0220f5f1b5@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Mon, 2 Apr 2018 12:39:29 -0400
MIME-Version: 1.0
In-Reply-To: <bc9bf25d-6bf2-67ec-539b-8a0220f5f1b5@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <aec509a0-847a-e86f-2111-8697b54eabcd@linux.vnet.ibm.com>
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 03/26/2018 08:01 AM, Halil Pasic wrote:
>
> On 03/26/2018 11:03 AM, Pierre Morel wrote:
>>>> +int ap_device_handle_pqap(S390CPU *cpu)
>>>> +{
>>>> +    CPUS390XState *env = &cpu->env;
>>>> +    int fc = 4 & (env->regs[0] >> 24);
>>>> +
>>>> +    /*
>>>> +     * The Query Configuration Information (QCI) function (fc == 4) does not
>>>> +     * set a response code in reg 1, so check for that along with the
>>>> +     * AP feature.
>>>> +     */
>>>> +    if ((fc != 4) && s390_has_feat(S390_FEAT_AP)) {
>>>> +        env->regs[1] = 0x10000;
>>>> +
>>>> +        return 0;
>>>> +    }
>>> This would imply an operation exception in case fc==4, which sounds very
>>> wrong.
> Yes, operation exception is a wrong response under the condition
> (fc == 4) && s390_has_feat(S390_FEAT_AP).
See my response to Pierre:
Message ID: <0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
>
> @David:
> FYI Tony is likely to respond after Wednesday as he is on vacation right
> now.
>
>> It depends but I think that the S390_FEAT_AP_QUERY_CONFIG_INFO must be tested
>> to know what to answer.
>> If the feature is there, QCI must be answered correctly.
>>
>> there are also some error situations to handle in all three functions.
>>
> I agree.
>
> Regards,
> Halil
