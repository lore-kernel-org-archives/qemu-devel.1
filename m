Received: from eggs.gnu.org ([2001:4830:134:3::10]:37148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVFU0-0006u8-Bz
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVFTx-0008V7-27
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:07:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57797
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dVFTw-0008UD-SQ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:07:00 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CB3m3M195485
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 07:07:00 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bncj5dq89-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 07:07:00 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 12 Jul 2017 12:06:58 +0100
References: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
	<0cb95894-bd35-2814-f7ff-1c9b3fcb533b@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 12 Jul 2017 13:06:52 +0200
MIME-Version: 1.0
In-Reply-To: <0cb95894-bd35-2814-f7ff-1c9b3fcb533b@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <b8637af6-63b8-0fcc-c13f-f96237a4c6bf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] migration: s390x css migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org



On 07/12/2017 10:01 AM, Christian Borntraeger wrote:
> On 07/11/2017 04:54 PM, Halil Pasic wrote:
>> Like for v2 the scope of this patch series is now limited to decoupling
>> channel subsystem migration from the migration of virtio-ccw proxies.
>>
>> There wasn't a whole lot of criticism regarding v2, so very little
>> changed since then. All issues identified in the previous round were
>> addressed as agreed upon. I hope this series is now good for 2.10.
>>
>> @Dave You helped me quite a lot with these, thanks a lot! I could not
>> find any r-b's or similar form you so if you would like to take the
>> well deserved credit for your work...
>>
>> v2 --> v3:
>> * rebased onto current master, since 's390x: vmstatify config migration
>>   for virtio-ccw' is already there we don't need it here any more
>> * added ack's and r-b'
>> * got rid of loads of nits (thanks Connie and Thomas)
>> * added explanation why certain members are not migrated
>>
>> v1 --> v2:
>> * Split out the vmystatify virtio-ccw part, reorganize
>> * Use WITH_TMP instead of one-shot VMStateInfo's
>>
>> Halil Pasic (6):
>>   s390x: add helper get_machine_class
>>   s390x: add css_migration_enabled to machine class
>>   s390x/css: add missing css state conditionally
>>   s390x/css: add ORB to SubchDev
>>   s390x/css: activate ChannelSubSys migration
>>   s390x/css: use SubchDev.orb
>>
>>  hw/intc/s390_flic.c                |  20 ++++++
>>  hw/s390x/css.c                     | 144 +++++++++++++++++++++++++++++++++----
>>  hw/s390x/s390-virtio-ccw.c         |  58 +++++++++------
>>  include/hw/s390x/css.h             |  11 ++-
>>  include/hw/s390x/s390-virtio-ccw.h |   7 ++
>>  5 files changed, 199 insertions(+), 41 deletions(-)
> 
> Can you clarify what test you have done regarding compatibility migrations to 2.9 and earlier?
> 

Hi Christian!

Again the same. I was migrating a guests with just some virtio-blk devices
between my new qemu (with this patch set on top of master) and itself with
default machine. And then between qemu with machine virtio-ccw-2.5 and a
2.5 binary with machine virtio-ccw-2.5 (2.5 the binary is some old
"internal driver"). The old and the new binary where tested in both (source
and target) roles. I've verified that the disks are still working after
migration.

Given the nature of the changes I didn't do a great number of repeated tests,
as was doing all the migrations within the same host via HMP command.

If one has an appropriate automated setup (I don't) I would welcome some
more testing (and be happy to add a Tested-by), but I don't think it is
strictly necessary.

Regards,
Halil
