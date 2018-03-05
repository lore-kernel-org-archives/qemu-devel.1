Received: from eggs.gnu.org ([2001:4830:134:3::10]:39520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1esoA2-0000n7-ML
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eso9z-0001V2-Hh
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:20:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50072
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eso9z-0001UD-4S
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:20:03 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w25BJFQc163371
	for <qemu-devel@nongnu.org>; Mon, 5 Mar 2018 06:20:02 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gh4s00c47-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 06:20:01 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 5 Mar 2018 11:19:59 -0000
References: <1519731154-3127-1-git-send-email-thuth@redhat.com>
	<20180305112344.42000020.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 5 Mar 2018 12:19:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180305112344.42000020.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9a1ff92b-fb7b-6de5-dfda-5062e6a7674b@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Add the possibility to specify
 the netboot image on the command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>



On 03/05/2018 11:23 AM, Cornelia Huck wrote:
> On Tue, 27 Feb 2018 12:32:34 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The file name of the netboot binary is currently hard-coded to
>> "s390-netboot.img", without a possibility for the user to select
>> an alternative firmware image here. That's unfortunate, especially
>> since the basics are already there: The filename is a property of
>> the s390-ipl device. So we just have to add a check whether the user
>> already provided the property and only set the default if the string
>> is still empty. Now it is possible to select a different firmware
>> image with "-global s390-ipl.netboot_fw=/path/to/s390-netboot.img".
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 4abbe89..7b3fb5f 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -254,8 +254,10 @@ static void s390_init_ipl_dev(const char *kernel_filename,
>>      }
>>      qdev_prop_set_string(dev, "cmdline", kernel_cmdline);
>>      qdev_prop_set_string(dev, "firmware", firmware);
>> -    qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
>>      qdev_prop_set_bit(dev, "enforce_bios", enforce_bios);
>> +    if (!strlen(object_property_get_str(new, "netboot_fw", &error_abort))) {
>> +        qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
>> +    }
>>      object_property_add_child(qdev_get_machine(), TYPE_S390_IPL,
>>                                new, NULL);
>>      object_unref(new);
> 
> So, any objections to me merging this? I think this makes sense for
> Thomas' use case.

Fine with me.
