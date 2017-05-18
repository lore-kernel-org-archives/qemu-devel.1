Received: from eggs.gnu.org ([2001:4830:134:3::10]:51817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dBHCD-0007xF-4v
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dBHCC-0007kN-7l
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:54:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dBHCB-0007k8-WD
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:54:08 -0400
References: <1495035337-13337-1-git-send-email-thuth@redhat.com>
	<20170517162642.ebmrhawmfdde5vsz@aurel32.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <871c5d88-66ec-b421-5c0b-7704b5379ae3@redhat.com>
Date: Thu, 18 May 2017 10:54:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170517162642.ebmrhawmfdde5vsz@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] target/s390x/cpu_models: Set some
 additional feature bits for the "qemu" CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, mmarek@suse.com, mbenes@suse.cz

On 17.05.2017 18:26, Aurelien Jarno wrote:
> On 2017-05-17 17:35, Thomas Huth wrote:
>> Currently we only present the plain z900 feature bits to the guest,
>> but QEMU already emulates some additional features (but not all of
>> the next CPU generation, so we can not use the next CPU level as
>> default yet). Since newer Linux kernels are checking the feature bits
>> and refuse to work if a required feature is missing, we should present
>> as much of the supported features as possible when we are running
>> with the default "qemu" CPU.
>> This patch now adds the "stfle", "extended immediate" and "stckf"
>> facility bits to the "qemu" CPU, which are already supported facilities.
>> It is unfortunately still not enough to run e.g. recent Fedora kernels,
>> but at least it's a first step into the right direction.
> 
> This indeed looks like a step in a good direction. At least it makes the
> recently added STFLE emulation useful :-).
> 
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  target/s390x/cpu_models.c | 29 ++++++++++++++++++++++++++---
>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index 8d27363..18789ab 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -658,6 +658,24 @@ static void check_compatibility(const S390CPUModel *max_model,
>>                    "available in the configuration: ");
>>  }
>>  
>> +/**
>> + * The base TCG CPU model "qemu" is based on the z900. However, we already
>> + * can also emulate some additional features of later CPU generations, so
>> + * we add these additional feature bits here.
>> + */
>> +static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
>> +{
>> +    int i, feats[] = {
>> +        S390_FEAT_STFLE,
>> +        S390_FEAT_EXTENDED_IMMEDIATE,
>> +        S390_FEAT_STORE_CLOCK_FAST
> 
> According to my list, QEMU also fully implements the following
> facilities:
> 
> S390_FEAT_LONG_DISPLACEMENT
> S390_FEAT_GENERAL_INSTRUCTIONS_EXT
> S390_FEAT_EXECUTE_EXT
> S390_FEAT_STFLE_45
> 

If S390_FEAT_LONG_DISPLACEMENT is supported, so is
S390_FEAT_LONG_DISPLACEMENT_FAST (because TCG obvious has high
performance ;) )

-- 

Thanks,

David
