Received: from eggs.gnu.org ([2001:4830:134:3::10]:53958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cg8IF-0007X0-RV
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cg8IB-0008Tj-QW
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:07:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cg8IB-0008TV-GT
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:07:35 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1LB6vUk021950
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 06:07:34 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28rm0194t2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 06:07:33 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 21 Feb 2017 11:07:31 -0000
References: <20170216121140.9061-1-pasic@linux.vnet.ibm.com>
	<20170216121140.9061-5-pasic@linux.vnet.ibm.com>
	<20170221104945.GC2377@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 12:07:28 +0100
MIME-Version: 1.0
In-Reply-To: <20170221104945.GC2377@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <7e2a4544-21a9-36ed-0af5-503261d2619b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] tests/test-vmstate.c: test array of
 ptr with null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>



On 02/21/2017 11:49 AM, Dr. David Alan Gilbert wrote:
>> +static void test_arr_ptr_str_0_save(void)
>> +{
>> +    TestStructTriv ar[AR_SIZE] = {{.i = 0}, {.i = 1}, {.i = 2}, {.i = 3} };
>> +    TestArrayOfPtrToStuct sample = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
>> +    uint8_t wire_sample[] = {
>> +        0x00, 0x00, 0x00, 0x00,
>> +        VMS_NULLPTR_MARKER,
>> +        0x00, 0x00, 0x00, 0x02,
>> +        0x00, 0x00, 0x00, 0x03,
>> +        QEMU_VM_EOF
>> +    };
>> +
>> +    save_vmstate(&vmsd_arps, &sample);
>> +    compare_vmstate(wire_sample, sizeof(wire_sample));
>> +}
>> +
>> +static void test_arr_ptr_str_0_load(void)
>> +{
>> +    TestStructTriv ar_gt[AR_SIZE] = {{.i = 0}, {.i = 0}, {.i = 2}, {.i = 3} };
>> +    TestStructTriv ar[AR_SIZE] = {};
>> +    TestArrayOfPtrToStuct obj = {.ar = {&ar[0], NULL, &ar[2], &ar[3]} };
>> +    int idx;
>> +    uint8_t wire_sample[] = {
>> +        0x00, 0x00, 0x00, 0x00,
>> +        VMS_NULLPTR_MARKER,
>> +        0x00, 0x00, 0x00, 0x02,
>> +        0x00, 0x00, 0x00, 0x03,
>> +        QEMU_VM_EOF
>> +    };
> If possible; it would be better if you could share the wire_sample, and ar_gt between
> the two functions rather than copying them.
> 
> Dave
> 

Certainly possible. I did it this way because I prefer
unit tests as self contained as possible, but consistent
style is also important.

Will factor wire_sample out for the next version.

Cheers,
Halil
