Received: from eggs.gnu.org ([2001:4830:134:3::10]:44494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dnMy2-0001yN-Tb
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dnMxy-00014J-0Z
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:44:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dnMxx-000149-O1
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:44:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7VAieGP126266
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 06:44:52 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cpa7d05dd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 06:44:51 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 31 Aug 2017 11:43:51 +0100
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170831120407.447b0206.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 31 Aug 2017 12:43:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170831120407.447b0206.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <cb13f501-5555-b618-cac0-9c984bd6df1e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/9]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 08/31/2017 12:04 PM, Cornelia Huck wrote:
> On Wed, 30 Aug 2017 18:36:00 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> This series has a character of a refactoring, as the initial motivation
>> was improving readability and reducing complexity.
> 
> But you reduced the cover letter subject too much ;)

Noticed that after sending. The plan was to copy paste
it form the internal version, but I'm no good at copy-pasting.

> 
>>
>> Despite of the original intent the tree first patches buxfixes, and
>> according to Dong Jia the patch-set also has a functional value: for ccw
>> pass-through, he is planing to pass-through the instruction completion
>> information (cc or interruption condition) from the kernel, and this
>> patch set can pretty much be seen as a preparation for that.
> 
> I think the first one (with the precedence fixed as well) is pretty
> uncontroversial, and I'd be happy to queue an updated version.
> 

I will send it as a stand-alone patch (probably today).

>>
>> The basic idea is: tell how to handle an unusual conditon where it's
>> identified, instead of mapping it to an errno (more or less arbitrarily),
>> then possibly mapping these errnos around, to finally (mentally) map the
>> errno back to the condition and take appropriate action. 
>>
>> At the end of the series we also have 125 lines of code less to maintain,
>> and the executable got a bit smaller too.
> 
> I agree with the basic direction, but I think this needs more hashing
> out.
> 

I'm sure we will sort the details out.

>>
>> Halil Pasic (9):
>>   s390x/css: fix cc handling for XSCH
>>   s390x: fix invalid use of cc 1 for SSCH
>>   s390x/css: be more consistent if broken beyond repair
>>   s390x: refactor error handling for SSCH and RSCH
>>   s390x: refactor error handling for XSCH handler
>>   s390x: refactor error handling for CSCH handler
>>   s390x: refactor error handling for HSCH handler
>>   s390x: refactor error handling for MSCH handler
>>   s390x: factor out common ioinst handler logic
>>
>>  hw/s390x/css.c              | 158 ++++++++++++--------------------------
>>  hw/s390x/s390-ccw.c         |   8 +-
>>  hw/vfio/ccw.c               |  32 ++++++--
>>  include/hw/s390x/css.h      |  38 +++++++---
>>  include/hw/s390x/s390-ccw.h |   2 +-
>>  target/s390x/ioinst.c       | 181 ++++++++++----------------------------------
>>  6 files changed, 147 insertions(+), 272 deletions(-)
>>
> 
