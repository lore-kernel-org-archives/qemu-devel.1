Received: from eggs.gnu.org ([2001:4830:134:3::10]:35246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e5XTY-00048w-Be
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e5XTT-0000ph-Ck
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:36:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36544
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e5XTT-0000pC-6P
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:36:31 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9KDYfIe086410
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 09:36:27 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dqdtd5g5r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 09:36:26 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 20 Oct 2017 14:36:25 +0100
References: <87y3oqugm7.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171005121115.GD3946746@orkuz.home>
	<87y3ok7n2n.fsf@marc-ibm.boeblingen.de.ibm.com>
	<20171012120714.GA314661@orkuz.home>
	<87mv4m6pp5.fsf@marc-ibm.boeblingen.de.ibm.com>
	<0aab6dae-a926-c106-9bc5-68561a9bef5c@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 20 Oct 2017 15:36:20 +0200
MIME-Version: 1.0
In-Reply-To: <0aab6dae-a926-c106-9bc5-68561a9bef5c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0dae2b6c-9164-efc7-5c67-0e4aa5eb4a21@de.ibm.com>
Subject: Re: [Qemu-devel] [libvirt] Question about the host-model CPU mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, libvir-list@redhat.com, qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>



On 10/20/2017 03:16 PM, David Hildenbrand wrote:
> 
>> Hi all,
>>
>> we recently encountered the problem that the 'host-model' [1] has to be
>> related to the machine type of a domain. We have following problem:
>>
>>    Let's assume we've a z13 system with a QEMU 2.9 and we define a
>>    domain using the default s390-virtio-ccw machine together with the
>>    host-model CPU mode [1]. The definition will have the machine
>>    expanded to s390-virtio-ccw-2.9 but retain the host-model CPU mode
>>    in the domain definition. In a next step we upgrade to QEMU 2.10
>>    (first version to recognize z14). Everything is still fine, even
>>    though the machine runs in 2.9 compatibility mode. Finally we
>>    upgrade to a z14. As a consequence it is not possible to start the
>>    domain anymore as the machine type doesn't support our CPU host
>>    model (which is expanded at start time of the domain).
> 
> Actually, what is the cause of that problem? I assume it is the gs
> feature (gs_allowed)?
> 
> We should really avoid such things (..._allowed) for CPU model features
> in the future and clue all new such stuff to cpumodel_allowed.

Yes, starting a guest with
   <os>
    <type arch='s390x' machine='s390-ccw-virtio-2.9'>hvm</type>
  </os>
  <cpu mode='host-model'/>

results in

qemu-system-s390x: Some features requested in the CPU model are not available in the configuration: gs 

Tying it to cpumodel_allowed would not help, migration-wise though.
libvirt would still transform

   <os>
    <type arch='s390x' machine='s390-ccw-virtio-2.9'>hvm</type>
  </os>
  <cpu mode='host-model'/>


into 
-cpu z14-base,aen=on,cmmnt=on,aefsi=on,mepoch=on,msa8=on,msa7=on,msa6=on,msa5=on,msa4=on, \
msa3=on,msa2=on,msa1=on,sthyi=on,edat=on,ri=on,edat2=on,vx=on,ipter=on,vxeh=on,vxpd=on, \
esop=on,iep=on,cte=on,ais=on,gs=on,zpci=on,sea_esop2=on,te=on,cmm=on
                             ^^^^^
because cpu model is certainly there. Now the guest would start but migration would
later fail because what we create now would never have been possible with 2.9.

If libvirt could get information from QEMU depending on the machine version, this would
make it work. But of course this has other issues.

Christian
