Received: from eggs.gnu.org ([2001:4830:134:3::10]:60372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecDRt-0000jV-EY
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecDRq-0007uD-Bt
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:53:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecDRq-0007td-2z
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:53:54 -0500
References: <20180115143156.GO6646@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E776B5@SHSMSX101.ccr.corp.intel.com>
	<20180116115113.GA627@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E79545@SHSMSX101.ccr.corp.intel.com>
	<20180118024232.GT627@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E7A61F@SHSMSX101.ccr.corp.intel.com>
	<20180118132415.GU627@localhost.localdomain>
	<c67f0021-0ca0-413b-bb84-3ff54dd791de@redhat.com>
	<20180118143744.GY627@localhost.localdomain>
	<12d650bf-8fd7-49f5-2c96-869393263899@redhat.com>
	<20180118165244.GZ627@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9b4fc8d2-c2fe-9b80-4dbc-02ea0d447b31@redhat.com>
Date: Thu, 18 Jan 2018 17:53:37 +0100
MIME-Version: 1.0
In-Reply-To: <20180118165244.GZ627@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND v1 1/2] i386: Add Intel Processor
 Trace feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Kang, Luwei" <luwei.kang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>

On 18/01/2018 17:52, Eduardo Habkost wrote:
> On Thu, Jan 18, 2018 at 03:44:49PM +0100, Paolo Bonzini wrote:
>> On 18/01/2018 15:37, Eduardo Habkost wrote:
>>> On Thu, Jan 18, 2018 at 02:39:57PM +0100, Paolo Bonzini wrote:
>>>> On 18/01/2018 14:24, Eduardo Habkost wrote:
>>>>> However, if there's a simple way to make it possible to migrate
>>>>> between hosts with different CPUID[14h] data, it would be even
>>>>> better.  With the current KVM intel-pt implementation, what
>>>>> happens if the CPUID[14h] data seen by the guest doesn't match
>>>>> exactly the CPUID[14h] leaves from the host?
>>>>
>>>> Some bits in there can be treated as CPU features (e.g. EBX bit 0 "CR3
>>>> filtering support").  Probably we should handle these in KVM right now.
>>>> KVM needs to compute a mask of valid 1 bits for IA32_RTIT_CTL based on
>>>> CPUID, and apply it when the MSR is written.
>>>
>>> Does this mean QEMU can't set CPUID values that won't match the
>>> host with the existing implementation, or this won't matter for
>>> well-behaved guests that don't try to set reserved bits on the
>>> MSRs?
>>
>> All the features could be handled exactly like regular feature bits.  If
>> QEMU sets them incorrectly and "enforce" is not used, bad things happen
>> but it's the user's fault.
> 
> Oh, I mean setting the bit to 0 when it's 1 on the host (if it's
> 0 on the host, QEMU would never set it anyway).  Is it safe to do
> it with the current KVM intel-pt implementation?

It's not, but it's (very) easy to fix.

Paolo

> 
>>
>>>
>>>>                                               It also needs to whitelist
>>>> bits like we do for other feature words.  These include:
>>>>
>>>> - CPUID[EAX=14h,ECX=0].EBX
>>>>
>>>> - CPUID[EAX=14h,ECX=0].ECX except bit 31
>>>>
>>>> - CPUID[EAX=14h,ECX=1].EAX bits 16:31 (if CPUID[EAX=14h,ECX=0].EBX[3]=1)
>>>>
>>>> - CPUID[EAX=14h,ECX=1].EBX (if CPUID[EAX=14h,ECX=0].EBX[1]=1)
>>>
>>> What do you mean by whitelist?
>>
>> KVM needs to tell QEMU the bits it knows about.
> 
> So KVM isn't currently doing it on GET_SUPPORTED_CPUID?  Oops.
> 
> 
>>
>>>> Others, currently only CPUID[EAX=14h,ECX=0].ECX[31] must match, there is
>>>> no way to emulate the "wrong" value.
>>>
>>> In this case we could make it configurable but require the host
>>> and guest value to always match.
>>>
>>> This might be an obstacle to enabling intel-pt by default
>>> (because it could make VMs not migratable to newer hosts), but
>>> may allow the feature to be configured in a predictable
>>> way.
>>
>> Yeah, but consider that virtualized PT anyway would only be enabled on
>> Ice Lake processors.  It's a few years away anyway!
>>
>>>> Others, currently only CPUID[EAX=14h,ECX=1].EAX[2:0] are numeric values,
>>>> and it's possible to emulate a lower value than the one in the processor.
>>>
>>> This could be handled by QEMU.  There's no requirement that all
>>> GET_SUPPORTED_CPUID values should be validated by simple bit
>>> masking.
>>
>> Good!
>>
>> Paolo
> 
