Received: from eggs.gnu.org ([2001:4830:134:3::10]:45396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dziD8-0006zv-4H
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dziD3-0007p0-3U
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:51:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dziD2-0007nm-QK
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:51:29 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94BnNkv057891
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 07:51:24 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dcwe4nscb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 07:51:23 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 4 Oct 2017 12:51:21 +0100
References: <20171004105751.24655-1-borntraeger@de.ibm.com>
	<20171004105751.24655-3-borntraeger@de.ibm.com>
	<284e46bd-52ac-34d9-81ab-c3b8c364a2ea@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 4 Oct 2017 13:51:18 +0200
MIME-Version: 1.0
In-Reply-To: <284e46bd-52ac-34d9-81ab-c3b8c364a2ea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e09e879f-e118-e129-b73e-3028ea0e9282@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] s390/kvm: make TOD setting failures
 fatal for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>



On 10/04/2017 01:48 PM, Thomas Huth wrote:
> On 04.10.2017 12:57, Christian Borntraeger wrote:
>> From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
>>
>> If we fail to set a proper TOD clock on the target system,  this can
>> already result in some problematic cases. We print several warn messages
>> on source and target in that case.
>>
>> If kvm fails to set a nonzero epoch index, then we must ultimately fail
>> the migration as this will result in a giant time leap backwards. This
>> patch lets the migration fail if we can not set the guest time on the
>> target.
>>
>> On failure the guest will resume normally on the original host machine.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> [split failure change from epoch index change, minor fixups]
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index fafbc6d..b7adb93 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -213,13 +213,10 @@ static int gtod_load(QEMUFile *f, void *opaque, int version_id)
>>  
>>      r = s390_set_clock(&tod_high, &tod_low);
>>      if (r) {
>> -        warn_report("Unable to set guest clock for migration: %s",
>> -                    strerror(-r));
>> -        error_printf("Guest clock will not be restored "
>> -                     "which could cause the guest to hang.");
>> +        error_report("Unable to set KVM guest TOD clock: %s", strerror(-r));
>>      }
>>  
>> -    return 0;
>> +    return r;
>>  }
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> (and I wonder whether we should fail the S390_TOD_CLOCK_VALUE_MISSING
> case with returning an error instead of 0, too?)

Yes. This patch does the minimal thing in "making things fail on error" now that
we have a case where things are guaranteed to be out of sync. One can argue that
we actually should fail migration on the source instead of sending 
S390_TOD_CLOCK_VALUE_MISSING.

If you want to send a patch that make migration fail for more cases I am 
inclined to ack such a thing.
