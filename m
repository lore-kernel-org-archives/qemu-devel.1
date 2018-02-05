Received: from eggs.gnu.org ([2001:4830:134:3::10]:35518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eicC9-0003Dq-Gv
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 03:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eicC6-00038N-Hi
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 03:32:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eicC6-00037Y-8W
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 03:32:06 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w158TFMd046970
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 03:32:05 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fxkqhgcxx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 03:32:04 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 5 Feb 2018 08:31:59 -0000
References: <20180202143746.204851-1-borntraeger@de.ibm.com>
	<20180202143746.204851-2-borntraeger@de.ibm.com>
	<3242e804-e38d-d989-0f98-46b8eeb21e36@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 5 Feb 2018 09:31:55 +0100
MIME-Version: 1.0
In-Reply-To: <3242e804-e38d-d989-0f98-46b8eeb21e36@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <1cc22b78-f3d7-eee6-6a62-0533451dba7e@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

patchew complained, so something like this on top


diff --git a/qapi/run-state.json b/qapi/run-state.json
index a93f6fea5c..a148088252 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -328,21 +328,19 @@
 ##
 { 'enum': 'GuestPanicInformationType',
   'data': [ 'hyper-v', 's390' ] }
 
 ##
 # @GuestPanicInformation:
 #
 # Information about a guest panic
 #
-# @hyper-v: hyper-v guest panic information
-#
-# @s390: s390 guest panic information (Since: 2.12)
+# @type: Crash type that defines the hypervisor specific information
 #
 # Since: 2.9
 ##
 {'union': 'GuestPanicInformation',
  'base': {'type': 'GuestPanicInformationType'},
  'discriminator': 'type',
  'data': { 'hyper-v': 'GuestPanicInformationHyperV',
            's390': 'GuestPanicInformationS390' } }
 

seems to fix it.

On 02/02/2018 03:51 PM, Eric Blake wrote:
> On 02/02/2018 08:37 AM, Christian Borntraeger wrote:
>> This patch is the s390 implementation of guest crash information,
>> similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
>> property") and the related commits. We will detect several crash
>> reasons, with the "disabled wait" being the most important one, since
>> this is used by all s390 guests as a "panic like" notification.
>>
>> Demonstrate these ways with examples as follows.
>>
>>   1. crash-information QOM property;
> 
>>
>> Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  qapi/run-state.json   | 29 ++++++++++++++++++++++++--
> 
> QAPI changes look reasonable; I'll leave the review of the
> target-specific code to those more familiar with the target.
> 
