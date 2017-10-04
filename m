Received: from eggs.gnu.org ([2001:4830:134:3::10]:39305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzhuN-0006BS-Km
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzhuK-00069J-Fh
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:32:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dzhuK-00068Y-6D
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:32:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94BVS2i094213
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 07:32:02 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dcx4ujee6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 07:32:01 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 12:31:59 +0100
References: <20171004110109.16525-1-pasic@linux.vnet.ibm.com>
	<20171004131035.42ccafe3.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 4 Oct 2017 13:31:56 +0200
MIME-Version: 1.0
In-Reply-To: <20171004131035.42ccafe3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <4ef68b1f-fc34-93b1-8ee8-fa9f6718fed2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/css: fix css migration compat
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>



On 10/04/2017 01:10 PM, Cornelia Huck wrote:
> On Wed,  4 Oct 2017 13:01:09 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Commit e996583eb3 ("s390x/css: activate ChannelSubSys migration",
>> 2017-07-11) was supposed to enable css migration for virtio-ccw
>> machines starting 2.10, but it ended up effectively enabling it
>> only for 2.10 as the registration of the appropriate VMStateDescription
>> happens in ccw_machine_2_10_instance_options which does not get
>> called for machines more recent than 2_10.
>>
>> Let us move the corresponding chunk of code (which conditionally enables
>> the migration based on the value of the corresponding class property) to
>> a ccw_init, which is called for each virtio-ccw machine instance.
> 
> s/a//
> 
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index fafbc6d4fe..3b5dfdb48d 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -313,6 +313,9 @@ static void ccw_init(MachineState *machine)
>>          ret = css_create_css_image(VIRTUAL_CSSID, true);
>>      }
>>      assert(ret == 0);
>> +    if (css_migration_enabled()) {
>> +        css_register_vmstate();
>> +    }
>>  
>>      /* Create VirtIO network adapters */
>>      s390_create_virtio_net(BUS(css_bus), "virtio-net-ccw");
>> @@ -731,9 +734,6 @@ DEFINE_CCW_MACHINE(2_11, "2.11", true);
>>  static void ccw_machine_2_10_instance_options(MachineState *machine)
>>  {
>>      ccw_machine_2_11_instance_options(machine);
>> -    if (css_migration_enabled()) {
>> -        css_register_vmstate();
>> -    }
>>  }
>>  
>>  static void ccw_machine_2_10_class_options(MachineClass *mc)
> 
> Looks sane.
> 
> Out of curiosity: Which machine types did you test migration for?
> 
In context of this patch. I've double checked with gdb that
css_register_vmstate is called for 2.11, 2.10 and that it is not called
for 2.9 and 2.8.

I did not do any actual migrations before sending the patch.  The mean
thing is that the migration between 2.11 and 2.11 does not fail
(necessarily) it's "just" that the stuff described by vmstate_css won't
get migrated (AFAIR that means we get the defaults instead).

Regards,
Halil
