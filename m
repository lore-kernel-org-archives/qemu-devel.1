Received: from eggs.gnu.org ([2001:4830:134:3::10]:43497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVNk3-0006KC-LP
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVNjy-0003u8-OJ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:56:11 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:33771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVNjy-0003tm-Jr
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:56:06 -0400
Received: by mail-qk0-x22a.google.com with SMTP id a66so20094740qkb.0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 12:56:06 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <fc0ca76b-ecee-1f38-166b-4dcd8d7dcd00@redhat.com>
	<20170711182351.22956-1-rth@twiddle.net>
	<9fbef29b-9a42-91a9-eda5-47e2a397963f@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <947b3410-4e07-68b5-3a06-309df127769c@twiddle.net>
Date: Wed, 12 Jul 2017 09:55:59 -1000
MIME-Version: 1.0
In-Reply-To: <9fbef29b-9a42-91a9-eda5-47e2a397963f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3.5 2/8] target/s390x: Implement CONVERT
 UNICODE insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 07/11/2017 08:46 PM, Thomas Huth wrote:
>> +        s1 = cpu_ldub_data_ra(env, addr + 1, ra);
>> +        s2 = cpu_ldub_data_ra(env, addr + 2, ra);
>> +        c = s0 & 0x0f;
>> +        c = (c << 6) | (s1 & 0x3f);
>> +        c = (c << 6) | (s2 & 0x3f);
>> +        /* Fold the byte-by-byte range descriptions in the PoO into
>> +           tests against the complete value.  It disallows encodings
>> +           that could be smaller, and the UTF-16 surrogates.  */
>> +        if (enh_check
>> +            && ((s1 & 0xc0) != 0x80
>> +                || (s2 & 0xc0) != 0x80
>> +                || c < 0x1000
>> +                || (c >= 0xd800 && c <= 0xdfff))) {
>> +            return 2;
>> +        }
>> +    } else if (s0 <= (enh_check ? 0xf4 : 0xf7)) {
>> +        /* four byte character */
>> +        l = 4;
>> +        if (ilen < 4) {
>> +            return 0;
>> +        }
>> +        s1 = cpu_ldub_data_ra(env, addr + 1, ra);
>> +        s2 = cpu_ldub_data_ra(env, addr + 2, ra);
>> +        s3 = cpu_ldub_data_ra(env, addr + 3, ra);
>> +        c = s0 & 0x0f;
> I think you could also use 0x07 instead of 0x0f here. Shouldn't matter
> much due to the s0 <= 0xf7 check above, though.
> 

You're right that it doesn't matter due to the check, but fixed anyway.  It 
makes the pattern wrt 2, 3, and 4 byte encodings more apparent.


r~
