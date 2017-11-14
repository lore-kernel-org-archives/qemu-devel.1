Received: from eggs.gnu.org ([2001:4830:134:3::10]:58176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eEe08-0008Gj-Sg
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eEe05-0001LE-Kl
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:23:52 -0500
References: <1509033294-4945-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1509033294-4945-5-git-send-email-akrowiak@linux.vnet.ibm.com>
	<20171114161138.6e9822c6.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4422c84d-2bb2-2fea-601c-0b9ccfaf27f2@redhat.com>
Date: Tue, 14 Nov 2017 17:23:39 +0100
MIME-Version: 1.0
In-Reply-To: <20171114161138.6e9822c6.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 4/5] s390x/cpumodel: enable AP facilities for
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org

On 14.11.2017 16:11, Cornelia Huck wrote:
> On Thu, 26 Oct 2017 11:54:53 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> Sets up the following STFLE bits to enable the specified AP
>> facilities for the guest VM:
>> 	* STFLE.12: Enables the AP Query Configuration Information
>>                     facility. The AP bus running in the guest uses
>>                     the information returned from this instruction
>>                     to configure AP adapters and domains for the
>>                     guest machine.
>> 	* STFLE.15: Enables the AP Special Command facility. The AP
>>                     bus running in the guest sets the T bit in
>>                     register 0 for the PQAP(TAPQ) instruction when
>>                     scanning for AP devices if this facility is
>>                     installed.
>>
>> These facilities are required in order for the AP bus running on
>> the KVM guest to function properly.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>  target/s390x/cpu_features.c     |    2 ++
>>  target/s390x/cpu_features_def.h |    2 ++
>>  target/s390x/gen-features.c     |    4 ++++
>>  3 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index 31a4676..63f002c 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -36,8 +36,10 @@ static const S390FeatDef s390_features[] = {
>>      FEAT_INIT("srs", S390_FEAT_TYPE_STFL, 9, "Sense-running-status facility"),
>>      FEAT_INIT("csske", S390_FEAT_TYPE_STFL, 10, "Conditional-SSKE facility"),
>>      FEAT_INIT("ctop", S390_FEAT_TYPE_STFL, 11, "Configuration-topology facility"),
>> +    FEAT_INIT("apqci", S390_FEAT_TYPE_STFL, 12, "Query Adjunct Processor Configuration facility"),
>>      FEAT_INIT("ipter", S390_FEAT_TYPE_STFL, 13, "IPTE-range facility"),
>>      FEAT_INIT("nonqks", S390_FEAT_TYPE_STFL, 14, "Nonquiescing key-setting facility"),
>> +    FEAT_INIT("apsc", S390_FEAT_TYPE_STFL, 15, "Adjunct Processor Special Command facility"),
> 
> Are there any interdependencies for those feature bits?

And just as a side node, CPU features should only be exposed once
migration support is fully in place (and usually bound to the flag for
compat handling).

(haven't had time yet to have a closer look, so just as a general comment)


-- 

Thanks,

David / dhildenb
