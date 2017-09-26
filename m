Received: from eggs.gnu.org ([2001:4830:134:3::10]:54290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dwnMo-0006KE-9E
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dwnMl-0007Ms-0K
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:45:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dwnMk-0007L7-Ex
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:45:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8QAigDJ052540
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 06:45:22 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d7jgx3h1t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 06:45:21 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 26 Sep 2017 11:45:15 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
	[9.149.105.58])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v8QAjCWh21299430
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 10:45:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFE4C4C04A
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 11:41:28 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C64774C044
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 11:41:28 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.152.224.207])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 11:41:28 +0100 (BST)
References: <20170921180841.24490-1-pasic@linux.vnet.ibm.com>
	<20170926121800.1e9e1ac1.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 26 Sep 2017 12:45:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170926121800.1e9e1ac1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <bce18b05-2f0c-b032-36e4-23dd8558e826@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/5] add CCW indirect data access support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



On 09/26/2017 12:18 PM, Cornelia Huck wrote:
> On Thu, 21 Sep 2017 20:08:36 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Abstract
>> --------
>>
>> The objective of this series is introducing CCW IDA (indirect data
>> access) support to our virtual channel subsystem implementation. Briefly
>> CCW IDA can be thought of as a kind of a scatter gather support for a
>> single CCW. If certain flags are set, the cda is to be interpreted as an
>> address to a list which in turn holds further addresses designating the
>> actual data.  Thus the scheme which we are currently using for accessing
>> CCW payload does not work in general case. Currently there is no
>> immediate need for proper IDA handling (no use case), but since it IDA is
>> a non-optional part of the architecture, the only way towards AR
>> compliance is actually implementing IDA.
>>
>> The focus of this patch set is introducing IDA support. There seems to be
>> a potential for further  improvements based on the introduced
>> infrastructure, but such improvements are intended to be discusses
>> separately and realized as patches on top of this series.
> 
> Hm, do you have a list of what you want to do as follow-on patches?
> (Checking return codes, ...)
> 
> It's easy to lose track of all this :)
> 

These are the stuff I had in mind:
* handling errors (aka. checking error codes) in virtio-ccw
* using residual count
* converting 3270 (patches already sent)

And then some related stuff is the error reporting and handling
rework for the IO instruction handlers and for the ccw interpretation
emulation (later affects CcwDataStream).

There is probably a lot of potential for making things prettier
in virtio-ccw.c too -- I've done some experiments but ended up changing
too many things at the same time.

Btw, do we still have open issues with this series?

Regards,
Halil


 
