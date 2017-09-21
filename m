Received: from eggs.gnu.org ([2001:4830:134:3::10]:46310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dv0kZ-0008W0-JQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dv0kW-0004rL-8Q
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:38:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dv0kW-0004qU-2r
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:38:36 -0400
References: <20170920153016.3858-1-david@redhat.com>
	<20170921102318.1d7784f1.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a81059c3-4f26-5175-ce58-8312fb3f5115@redhat.com>
Date: Thu, 21 Sep 2017 14:38:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170921102318.1d7784f1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Implement basic MSA functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 21.09.2017 10:23, Cornelia Huck wrote:
> On Wed, 20 Sep 2017 17:30:13 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Some leftover from "target/s390x: tcg improvments + MSA functions".
>>
>> Implement all basic MSA (cpacf/crypto) instructions <= z13. Only provide
>> the query subfunction (to query available subfunctions), no actual
>> de/encryption yet. Good enough to unlock the STFL bits.
>>
>> I have written kvm-unit-tests for MSA functions and for SPM/IPM. Will
>> send them out soon. I use the following cpu model to test with an upstream
>> kernel compiled for z10:
>>
>> ... -cpu qemu,mvcos=on,stfle=on,ldisp=on,ldisphp=on,\
>>               eimm=on,stckf=on,csst=on,csst2=on,ginste=on,\
>>               exrl=on,msa-base=on,msa3-base=on,msa4-base=on,msa5-base=on ...
>>
>> Available on: https://github.com/davidhildenbrand/qemu.git s390x-msa
> 
> I used the following cpu model:
> 
> -cpu qemu,eimm=on,ldisp=on,stckf=on,msa-base=on,msa3-base=on,msa4-base=on,msa5-base=on
> 
> and got
> 
> qemu-system-s390x: warning: 'msa5-base' requires 'kimd-sha-512'.
> qemu-system-s390x: warning: 'msa5-base' requires 'klmd-sha-512'.
> 

Yes, I am aware of that and it is on my todo list. Shouldn't matter for
now as it is completely optional and not enabled as default.

> (It works anyway.)
> 
> However,
> 
> -cpu qemu,eimm=on,ldisp=on,stckf=on,msa-base=on,msa3-base=on,msa4-base=on,msa5-base=on,kimd-sha-512=on
> 
> gives
> 
> qemu-system-s390x: can't apply global qemu-s390-cpu.kimd-sha-512=on: Feature 'kimd-sha-512' is not available for CPU model 'z900', it was introduced with later models.
> 
> which is a bit confusing.

Due to the way we hack up the qemu cpu model, allowing to set features
that are theoretically not possible (just to have some way of enabling
them before we can change the qemu model to something never).

> 
> So I'm wondering whether providing msa5-base without the providing the
> algorithms above is sane - or whether it is just enough to satisfy some
> kernels.
> 
> [Double-checking the various dependencies looks impossible without
> access to IBM doc, anyway - I just hope you got it right back then :)]
> 

We can take care of that later (if at all relevant).

-- 

Thanks,

David
