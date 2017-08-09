Received: from eggs.gnu.org ([2001:4830:134:3::10]:54498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dfQzb-000692-C7
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dfQzW-0005Ef-8I
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:25:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dfQzV-0005Cx-Vx
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:25:42 -0400
References: <20170721125609.11117-1-david@redhat.com>
	<20170721125609.11117-6-david@redhat.com>
	<20170809150105.66c970c0.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9ea9555d-5210-d574-0ddf-40ae6739a862@redhat.com>
Date: Wed, 9 Aug 2017 15:25:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170809150105.66c970c0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/6] target/s390x: add basic MSA features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com


>> @@ -792,6 +792,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
>>          S390_FEAT_STFLE,
>>          S390_FEAT_EXTENDED_IMMEDIATE,
>>          S390_FEAT_EXTENDED_TRANSLATION_2,
>> +        S390_FEAT_MSA,
>>          S390_FEAT_EXTENDED_TRANSLATION_3,
>>          S390_FEAT_LONG_DISPLACEMENT,
>>          S390_FEAT_LONG_DISPLACEMENT_FAST,
>> @@ -808,6 +809,9 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
>>          S390_FEAT_STFLE_49,
>>          S390_FEAT_LOCAL_TLB_CLEARING,
>>          S390_FEAT_STFLE_53,
>> +        S390_FEAT_MSA_EXT_5,
>> +        S390_FEAT_MSA_EXT_3,
>> +        S390_FEAT_MSA_EXT_4,
> 
> I first thought that this looks weird, but it is the actual sequence of
> the facility bits (probably the bit for MSA_EXT_5 has been reused?)

Probably, or they had it reserved for something else. Another reason
could be the non-hypervisor managed vs. hypervisor managed stuff (didn't
check the facility bit numbers, but this could be a reason).

[...]
> 
> A comment which subfunction this is might be helpful.

Indeed.

/* query subfunction */

> 
>> +        for (i = 0; i < 16; i++) {
>> +            param_addr = wrap_address(env, env->regs[1] + i);
> 
> This does not compile for me (after massaging the Makefile above), as
> wrap_address does not seem to be exported... can you do a respin,
> please?
> 

Contained in patch nr4 in this series. But I'm planning to do a respin
(most likely introducing internal.h).

>> +            cpu_stb_data_ra(env, param_addr, subfunc[i], ra);
>> +        }
>> +        break;
>> +    default:
>> +        /* we don't implement any other subfunction yet */
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    return 0;
>> +}

Thanks!

-- 

Thanks,

David
