Received: from eggs.gnu.org ([2001:4830:134:3::10]:40379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVYJ4-0004h7-9s
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVYJ1-0003aW-3i
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:13:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVYJ0-0003ZS-Pv
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:12:59 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6D796I0138294
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:12:57 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3qb5b3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:12:57 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 03:12:56 -0400
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-9-git-send-email-borntraeger@de.ibm.com>
	<20170712170713.1f5cf6b2@dhcp-192-215.str.redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 09:12:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170712170713.1f5cf6b2@dhcp-192-215.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <e44ca276-3318-1a18-9075-8edd6305c69c@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 08/11] s390x/flic: introduce
 modify_ais_mode callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Fei Li <sherrylf@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

On 07/12/2017 05:07 PM, Cornelia Huck wrote:
>> +
>> +    switch (mode) {
>> +    case SIC_IRQ_MODE_ALL:
>> +        flic->simm &= ~AIS_MODE_MASK(isc);
>> +        flic->nimm &= ~AIS_MODE_MASK(isc);
>> +        break;
>> +    case SIC_IRQ_MODE_SINGLE:
>> +        flic->simm |= AIS_MODE_MASK(isc);
>> +        flic->nimm &= ~AIS_MODE_MASK(isc);
> 
> Can we have some documentation about the meaning of simm/nimm in qemu?
> The one from the patch description of the respective kernel patch would
> be fine.

Do you want to have that description as part of the patch description or
somewhere in the docs folder or somewhere in the code?


> 
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>
> 
> (...)
> 
>> @@ -406,6 +427,7 @@ typedef struct KVMS390FLICStateClass {
>>  
>>  static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
>>  {
>> +    S390FLICState *fs = S390_FLIC_COMMON(dev);
>>      KVMS390FLICState *flic_state = KVM_S390_FLIC(dev);
>>      struct kvm_create_device cd = {0};
>>      struct kvm_device_attr test_attr = {0};
>> @@ -438,6 +460,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
>>      flic_state->clear_io_supported = !ioctl(flic_state->fd,
>>                                              KVM_HAS_DEVICE_ATTR, test_attr);
>>  
>> +    fs->ais_supported = false;
> 
> The patch actually enabling this for kvm is in the next batch of
> patches, I assume?


yes, will hopefully come today.
