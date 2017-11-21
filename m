Received: from eggs.gnu.org ([2001:4830:134:3::10]:48169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eH9WX-0001c9-Sl
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eH9WU-000214-PN
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:27:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eH9WU-00020D-GV
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:27:38 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vALEOUOV011774
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 09:27:33 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ecm2170tr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 09:27:32 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 21 Nov 2017 14:27:30 -0000
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 21 Nov 2017 15:27:28 +0100
MIME-Version: 1.0
In-Reply-To: <20171121144457.60adb0c3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f8a837b8-8886-2446-ac7d-02db9b376945@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 11/21/2017 02:44 PM, Cornelia Huck wrote:
> On Tue, 21 Nov 2017 12:18:25 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
> Subject: s/unresrict/unrestrict/
> 
>> The default css 0xFE is currently restricted to virtual subchannel
>> devices. The hope when the decision was made was, that non-virtual
>> subchannel devices will come around when guest can exploit multiple
>> channel subsystems. Since the guests generally don't do, the pain
>> of the partitioned (cssid) namespace outweighs the gain.
>>
>> Let us remove the corresponding restrictions (virtual devices
>> can be put only in 0xFE and non-virtual devices in any css except
>> the 0xFE), and inform management software property on all ccw
>> devices.
> 
> I do not really like dropping the restrictions while still keeping the


> default cssid as 0xfe. Putting virtual devices into css 0 seems
> completely fine, but putting non-virtual devices into css 0xfe still
> feels a bit wrong. What about:

I see no fundamental reason to not allow any device everywhere. And yes,
if we would start today, we would not use fe but 0. But we already have 
code outside (libvirt), we have exisiting guest xmls and we have documentation
outside and we have  communicated that via  a lot of channels. So if we want
to stay compatible we should really keep css 0xfe as the default css (that
is seen as css 0 anyway for non-mcss-e guests).

The nice thing with Halils approach is that it will continue to work
if future guests enable MCSS-E and it is the most minimal change by just
lifting a restriction in terms of flexibility. 

> 
> - Add a property to specify the default cssid. Compat machines use a
>   default cssid of 0xfe.
> - Default to a cssid of 0.
> - (optional) Warn when putting a non-virtual device into css 0xfe,
>   unless it is the default css.
