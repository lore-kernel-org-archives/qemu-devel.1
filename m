Received: from eggs.gnu.org ([2001:4830:134:3::10]:44264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1eyddt-0006Uh-Be
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1eyddp-0001Dl-BW
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:19:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1eyddp-0001DQ-63
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:18:57 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20180320173500.32065-1-vkuznets@redhat.com>
	<20180320173500.32065-3-vkuznets@redhat.com>
	<20180321121001.GD14983@rkaganb.sw.ru>
Date: Wed, 21 Mar 2018 14:18:54 +0100
In-Reply-To: <20180321121001.GD14983@rkaganb.sw.ru> (Roman Kagan's message of
	"Wed, 21 Mar 2018 15:10:01 +0300")
Message-ID: <87bmfh7eip.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/2] i386/kvm: lower requirements for
 Hyper-V frequency MSRs exposure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Tue, Mar 20, 2018 at 06:35:00PM +0100, Vitaly Kuznetsov wrote:
>> Requiring tsc_is_stable_and_known() is too restrictive: even without INVTCS
>> nested Hyper-V-on-KVM enables TSC pages for its guests e.g. when
>> Reenlightenment MSRs are present. Presence of frequency MSRs doesn't mean
>> these frequencies are stable, it just means they're available for reading.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  target/i386/kvm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 7d9f9ca0b1..74fc3d3b2c 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -651,7 +651,7 @@ static int hyperv_handle_properties(CPUState *cs)
>>          env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
>>          env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
>>  
>> -        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
>> +        if (has_msr_hv_frequencies && env->tsc_khz) {
>>              env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
>>              env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
>>          }
>
> I suggest that we add a corresponding cpu property here, too.  The guest
> may legitimately rely on these msrs when it sees the support in CPUID,
> and migrating from a kernel with the feature supported (4.14+) to an
> older one will make it crash.
>

This can be arranged, but what happens to people who use these features
today? Assuming they also passed 'invtsc' they have stable TSC page
clocksource already (when Hyper-V role is enabled) but when we start
requesting a new 'hv_frequency' cpu property they'll suddenly lose what
they have...

-- 
  Vitaly
