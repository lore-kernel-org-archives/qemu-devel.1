Received: from eggs.gnu.org ([2001:4830:134:3::10]:35258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUT4O-0003KU-K1
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUT4I-0006qA-1B
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:02:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gUT4H-0006ct-KM
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 04:02:05 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB58xAw6095707
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 04:02:04 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p69gpwtf7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 04:02:03 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 5 Dec 2018 09:02:00 -0000
References: <20181203165810.14509-1-kwolf@redhat.com>
	<20181203165810.14509-3-kwolf@redhat.com>
	<dc86835f-65d9-cada-dc9b-1f2c708521f9@de.ibm.com>
	<75f7e3cc-bd46-c743-84ab-cd68bcb1dcfb@de.ibm.com>
	<d0966d94-87d4-0f25-f2e0-846a1d338be7@de.ibm.com>
	<20181205084614.GA4018@dhcp-200-186.str.redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 5 Dec 2018 10:01:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181205084614.GA4018@dhcp-200-186.str.redhat.com>
Content-Language: en-US
Message-Id: <30858ce0-5b4b-c3c4-b846-6a214670f8d2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL 2/2] iotests: simple mirror
 test with kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: peter.maydell@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>



On 05.12.2018 09:46, Kevin Wolf wrote:
> Am 05.12.2018 um 09:23 hat Christian Borntraeger geschrieben:
>>>>> +# prepare source image
>>>>> +qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=metadata', disk,
>>>>> +                str(size))
>>>>> +
>>>>> +vm = QEMUMachine(iotests.qemu_prog)
>>>>> +vm.add_args('-machine', 'pc,accel=kvm')
>>
>> This (pc) clearly does not work on other architectures.
>> In addition to that, I also need to add -no-shutdown on s390 (see 068 for a similar case)
> 
> Leaving out pc definitely makes sense, and the bug still reproduces for
> me without it.
> 
> I don't understand the -no-shutdown, though. Already for 068, neither
> the code nor the commit message when it was added explain why this is
> needed.
> 
> Can you turn this into a proper patch and add a comment why -no-shutdown
> is needed?

I already sent this patch. The reason is that there is no BIOS in a classical sense
on s390x. If no bootable image (external kernel or from disk) is found, the small boot
bios loads a disabled wait PSW. The default action for that is then shutdown.
