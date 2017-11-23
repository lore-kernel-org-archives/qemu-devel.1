Received: from eggs.gnu.org ([2001:4830:134:3::10]:56787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eHpph-0000cl-Us
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:38:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eHppb-0008OX-TV
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:38:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eHppb-0008Nc-Ka
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:38:11 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vANBbxtq098845
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 06:38:09 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2educ82grb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 06:38:08 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 23 Nov 2017 11:38:06 -0000
References: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
	<20171108165422.46267-2-pasic@linux.vnet.ibm.com>
	<20171123082003.GJ5859@bjsdjshi@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 23 Nov 2017 12:38:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171123082003.GJ5859@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <af73b3dc-0e9b-07d1-138f-d9b9774d7f90@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/3] s390x/ccs: add ccw-testdev
 emulated device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 11/23/2017 09:20 AM, Dong Jia Shi wrote:
> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-11-08 17:54:20 +0100]:
> 
> Hi Halil,
> 
>> Add a fake device meant for testing the correctness of our css emulation.
>>
>> What we currently have is writing a Fibonacci sequence of uint32_t to the
>> device via ccw write. The write is going to fail if it ain't a Fibonacci
>> and indicate a device exception in scsw together with the proper residual
>> count. With this we can do basic verification of data integrity.
>>
>> Of course lot's of invalid inputs (besides basic data processing) can be
>> tested with that as well.
>>
>> We also have a no-op mode where the device just tells all-good! This
>> could be useful for fuzzing.
>>
>> Usage:
>> 1) fire up a qemu with something like -device ccw-testdev,devno=fe.0.0001
>>    on the command line
>> 2) exercise the device from the guest
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>
>> Introduction
>> ------------
>>
>> While discussing v1 we (more or less) decided a test device for ccw is a
>> good idea. This is an RFC because there are some unresolved technical
>> questions I would like to discuss.
>>
> Regarding to test coverage, this mainly covers the cds_read. 

This series has only a linux module with some texts and is more
of a PoC than the way it should be done. I think I wrote somewhere
about this.

The ccw-testdev being mainly about cds_read is not correct. See
the TIC must have zero count test in patch 3. The cds things only
become relevant if data matters for the test. The ccw-testdev is
about making it possible to check how does the channel subsystem respond
to certain stimuli without actually having to care about a real device.

> What we
> want would be surely more than this. So to extend the coverage, we need
> to design more modes (aka, test cases), right?

Modes and testcases are not the same. See patches 2 and 3. Modes are
mostly for being extensible in a sense of expect the unexpected. I don't
have too may ideas for modes (one more I can think of could be some tee
like proxy for doing whatever kind of assertions/analysis on what some
driver does).  In the previous round we said we want this extensible, and
it make sense.


> 
> If nobody disagrees with the basic idea of this series, I can start a
> review then. ;)
> 
> [...]
> 
