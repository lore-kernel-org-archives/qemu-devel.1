Received: from eggs.gnu.org ([2001:4830:134:3::10]:43906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dD9Lc-0006rh-G0
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dD9LX-0005Jl-KP
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:55:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dD9LX-0005JQ-AD
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:55:31 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4NCnEBA063546
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 08:55:28 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2am8pdeu9k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 08:55:28 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 23 May 2017 06:55:27 -0600
References: <20170518111405.56947-1-pasic@linux.vnet.ibm.com>
	<20170523141821.79db6b2b.cornelia.huck@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 23 May 2017 14:55:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170523141821.79db6b2b.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <23e0910b-a2bc-e571-804d-1c0f033dd1e7@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] s390x/css: catch section mismatch
 on load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On 05/23/2017 02:18 PM, Cornelia Huck wrote:
> On Thu, 18 May 2017 13:14:05 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Prior to the virtio-ccw-2.7 machine (and commit 2a79eb1a), our virtio
>> devices residing under the virtual-css bus do not have qdev_path based
>> migration stream identifiers (because their qdev_path is NULL). The ids
>> are instead generated when the device is registered as a composition of
>> the so called idstr, which takes the vmsd name as its value, and an
>> instance_id, which is which is calculated as a maximal instance_id
>> registered with the same idstr plus one, or zero (if none was registered
>> previously).
>>
>> That means, under certain circumstances, one device might try, and even
>> succeed, to load the state of a different device. This can lead to
>> trouble.
>>
>> Let us fail the migration if the above problem is detected during load.
>>
>> How to reproduce the problem:
>> 1) start qemu-system-s390x making sure you have the following devices
>>    defined on your command line:
>>      -device virtio-rng-ccw,id=rng1,devno=fe.0.0001
>>      -device virtio-rng-ccw,id=rng2,devno=fe.0.0002
>> 2) detach the devices and reattach in reverse order using the monitor:
>>      (qemu) device_del rng1
>>      (qemu) device_del rng2
>>      (qemu) device_add virtio-rng-ccw,id=rng2,devno=fe.0.0002
>>      (qemu) device_add virtio-rng-ccw,id=rng1,devno=fe.0.0001
>> 3) save the state of the vm into a temporary file and quit QEMU:
>>      (qemu) migrate "exec:gzip -c > /tmp/tmp_vmstate.gz"
>>      (qemu) q
>> 4) use your command line from step 1 with
>>      -incoming "exec:gzip -c -d /tmp/tmp_vmstate.gz"
>>    appended to reproduce the problem (while trying to to load the saved vm)
>>
>> CC: qemu-stable@nongnu.org
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> 
> Hum, missed that one for my pull request, sorry.
> 
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Christian, can you please pick for the next set of s390x patches?

applied to my tree, Thanks.
