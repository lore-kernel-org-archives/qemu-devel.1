Received: from eggs.gnu.org ([2001:4830:134:3::10]:42659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dX9wx-0003WE-NM
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dX9wv-0002Nw-3D
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:36:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dX9wu-0002NY-Qa
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:36:49 -0400
From: David Hildenbrand <david@redhat.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
	<1500028867-134709-36-git-send-email-borntraeger@de.ibm.com>
	<344b342f-7aaa-22d8-37b6-c96d2840c20b@redhat.com>
Message-ID: <df91f7df-2db6-648c-3e37-8a6351be53dd@redhat.com>
Date: Mon, 17 Jul 2017 19:36:44 +0200
MIME-Version: 1.0
In-Reply-To: <344b342f-7aaa-22d8-37b6-c96d2840c20b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 35/40] s390x/cpumodel: we are always in
 zarchitecture mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 17.07.2017 19:33, David Hildenbrand wrote:
> On 14.07.2017 12:41, Christian Borntraeger wrote:
>> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
>>
>> In QEMU, a guest VCPU always started in and never was able to leave
>> z/Architecture mode. Now we have an architected way of showing this
>> condition.
>>
>> The SIGP SET ARCHITECTURE instruction is simply rejected. Linux as guest
>> seems to not care about the return value, which is a good thing
>> The new handling is just like already being in z/Architecture mode.
>>
>> We'll not try to fake absence of this facility, but still not indicate
>> the facility in case some strange CPU model turned z/Architecture off
>> completely (which doesn't work either way but let's us see how a
>> guest would react on a lack of this facility).
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/cpu_features.c |  5 +++--
>>  target/s390x/kvm.c          | 38 +++++++++++---------------------------
>>  2 files changed, 14 insertions(+), 29 deletions(-)
>>
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index e5a3f71..fa887d9 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -337,8 +337,9 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>>      int bit_nr;
>>  
>>      if (type == S390_FEAT_TYPE_STFL && test_bit(S390_FEAT_ZARCH, features)) {
>> -        /* z/Architecture is always active if around */
>> -        data[0] |= 0x20;
>> +        /* Features that are always active */
>> +        data[0] |= 0x20;  /* z/Architecture */
>> +        data[17] |= 0x20; /* Configuration-z-architectural-mode */
>>      }
> 
> This also requires changes in TCG , no? (set architecture there is left
> untouched)
> 
> 

Never mind, just realized we do our own block creation in do_stfle....

-- 

Thanks,

David
