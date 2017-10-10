Received: from eggs.gnu.org ([2001:4830:134:3::10]:53917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1veU-0002AU-PN
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1veQ-0007om-NT
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:36:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e1veQ-0007oF-Eh
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:36:54 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AETVtX143940
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:36:48 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgurrr8h3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:36:47 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 15:36:44 +0100
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-4-pasic@linux.vnet.ibm.com>
	<20171010150733.444aa2fe.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:36:41 +0200
MIME-Version: 1.0
In-Reply-To: <20171010150733.444aa2fe.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <aed45050-fd0e-4a81-679c-c59c23d75a98@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/8] s390x: improve error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 10/10/2017 03:07 PM, Cornelia Huck wrote:
> On Wed,  4 Oct 2017 17:41:39 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Simplify the error handling of the SSCH and RSCH handler avoiding
>> arbitrary and cryptic error codes being used to tell how the instruction
>> is supposed to end.  Let the code detecting the condition tell how it's
>> to be handled in a less ambiguous way.  It's best to handle SSCH and RSCH
>> in one go as the emulation of the two shares a lot of code.
>>
>> For passthrough this change isn't pure refactoring, but changes the
>> way kernel reported EFAULT is handled. After clarifying the kernel
>> interface we decided that EFAULT shall be mapped to unit exception.
>> Same goes for unexpected error codes.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>
>> AFAIR we decided in the previous round to rather do transformation
>> and fixing in one patch than touch stuff twice. Hence this patch
>> ain't pure transformation any more.
>> ---
>>  hw/s390x/css.c              | 83 +++++++++++++--------------------------------
>>  hw/s390x/s390-ccw.c         | 11 +++---
>>  hw/vfio/ccw.c               | 30 ++++++++++++----
>>  include/hw/s390x/css.h      | 24 +++++++++----
>>  include/hw/s390x/s390-ccw.h |  2 +-
>>  target/s390x/ioinst.c       | 53 ++++-------------------------
>>  6 files changed, 77 insertions(+), 126 deletions(-)
> 
> After browsing through this patch, I think the change will work just as
> well if you use e.g. #defines instead of the structure, won't it?
> 

Sure. We just loose type safety. For example if someone ever should try to
propagate a normal errno via return do_something() the compiler won't
catch it we effectively use int for both.
