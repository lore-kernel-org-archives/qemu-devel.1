Received: from eggs.gnu.org ([209.51.188.92]:58963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtdnd-0000bT-LJ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtdnc-00044i-IT
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:32:57 -0500
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-10-david@redhat.com>
	<43fda672-487e-fef9-17c8-ce0657f27dbe@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <86c01eb1-5423-cd47-1173-747a4708cf87@redhat.com>
Date: Tue, 12 Feb 2019 20:32:47 +0100
MIME-Version: 1.0
In-Reply-To: <43fda672-487e-fef9-17c8-ce0657f27dbe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 08/15] s390x/tcg: Handle SET FPC AND
 LOAD FPC 3-bit BFP rounding modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 12.02.19 20:07, Richard Henderson wrote:
> On 2/12/19 3:03 AM, David Hildenbrand wrote:
>> We already forward the 3 bits correctly in the translation functions. We
>> also have to handle them properly and check for specification
>> exceptions.
>>
>> Setting an invalid rounding mode (BFP only, all DFP rounding modes)
>> results in a specification exception. Setting unassigned bits in the
>> fpc, results in a specification exception.
>>
>> This fixes LOAD FPC (AND SIGNAL), SET FPC (AND SIGNAL). Also for,
>> SET BFP ROUNDING MODE, 3-bit rounding mode is now explicitly checked.
>>
>> Notes:
>> 1. Use "float_round_to_zero" for now to handle "Round to prepare for
>>    shorter precision". Looking at the PoP "Summary of Rounding and Range
>>    Actions" for BFP. They differ when it comes to tiny values.
>> 2. TCG_CALL_NO_WG is required for sfpc handler, as we now inject
>>    exceptions.
>>
>> We won't be modeling abscence of the "floating-point extension facility"
>> for now, not necessary as most take the facility for granted without
>> checking.
>>
>> z14 PoP, 9-23, "LOAD FPC"
>>     When the floating-point extension facility is
>>     installed, bits 29-31 of the second operand must
>>     specify a valid BFP rounding mode and bits 6-7,
>>     14-15, 24, and 28 must be zero; otherwise, a
>>     specification exception is recognized.
> 
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> +    /*
>> +     * FIXME: we actually want something like round_to_odd, but that does not
>> +     * support all data types yet.
>> +     */
>> +    float_round_to_zero,
> 
> Yes, you want round_to_odd.  I suppose that's not valid for float128 right now?

roundAndPackFloat64()

as well as

roundAndPackFloat128()

support it.

It's not implemented for round_canonical(), round_to_int(),
roundAndPackInt32(), roundAndPackInt64(), roundAndPackUint64(),
roundAndPackFloat32() (and roundAndPackFloatx80()).

I assume at least 32bit is missing. I can't judge if the other functions
are relevant (x80 clearly not).

> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
