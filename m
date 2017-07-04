Received: from eggs.gnu.org ([2001:4830:134:3::10]:37396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSKLK-0007fY-PX
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSKLK-0002qJ-1u
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:42:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSKLJ-0002pJ-SI
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:42:02 -0400
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-19-git-send-email-pbonzini@redhat.com>
	<0d634c91-df90-3513-b77a-cae63903dfce@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <91a81a52-0520-d55c-bc94-9c768f346867@redhat.com>
Date: Tue, 4 Jul 2017 11:41:56 +0200
MIME-Version: 1.0
In-Reply-To: <0d634c91-df90-3513-b77a-cae63903dfce@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/22] target/i386: split cpu_set_mxcsr()
 and make cpu_set_fpuc() inline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com



On 03/07/2017 22:14, Richard Henderson wrote:
> On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
>> +static inline void cpu_set_mxcsr(CPUX86State *env, uint32_t mxcsr)
>> +{
>> +    env->mxcsr = mxcsr;
>> +    if (tcg_enabled()) {
>> +        tcg_update_mxcsr(env);
> 
> I'd prefer update_mxcsr_status for this new name.
> 
>> +    }
>> +}
>> +
>> +static inline void cpu_set_fpuc(CPUX86State *env, uint16_t fpuc)
>> +{
>> +     env->fpuc = fpuc;
>> +     if (tcg_enabled()) {
>> +        update_fp_status(env);
>> +     }
>> +}
> 
> to match this, and to avoid the implication that it's a function in tcg/.

Good.  Also, the existing place in machine.c that calls update_fp_status
should call update_mxcsr_status as well.

Paolo
