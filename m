Received: from eggs.gnu.org ([2001:4830:134:3::10]:59102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgnV-0005zn-5b
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgnU-0008Oc-CM
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:25:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzgnU-0008OE-6I
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:25:32 -0400
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-3-cota@braap.org>
	<20180904173734.GA18515@kermit-br-ibm-com>
	<20180904193538.GA30725@flamenco>
	<20180904205631.GB18515@kermit-br-ibm-com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ac6d2e3-7cac-b923-a7ec-57361333da9a@redhat.com>
Date: Tue, 11 Sep 2018 13:25:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180904205631.GB18515@kermit-br-ibm-com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] test-rcu-list: avoid torn accesses to
 n_reclaims and n_nodes_removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 04/09/2018 22:56, Murilo Opsfelder Araujo wrote:
>>> +static inline void count_add(Count *c, long long val)
>>> +{
>>> +#ifdef CONFIG_ATOMIC64
>>> +    atomic_set__nocheck(&c->val, c->val + val);
>>> +#else
>>> +    seqlock_write_begin(&c->sequence);
>>> +    c->val += val;
>>> +    seqlock_write_end(&c->sequence);
>>> +#endif
>>> +}
>>> +
>>> +static inline void count_inc(Count *c)
>>> +{
>>> +    count_add(c, 1);
>>> +}
>> Are these `#ifdef CONFIG_ATOMIC64` required?
>>
>> The bodies of
>>
>>   seqlock_read_begin()
>>   seqlock_read_retry()
>>   seqlock_write_begin()
>>   seqlock_write_end()
>>
>> in include/qemu/seqlock.h make me think that they already use atomic operations.
>> What am I missing?
> atomic_read/set(*foo), as defined in qemu/atomic.h, are as wide as
> foo. The sequence number in a seqlock is an "unsigned", so those
> atomics won't be larger than 32 bits.
> 
> The counts we're dealing with here are 64-bits, so with
> #ifdef CONFIG_ATOMIC64 we ensure that the host can actually
> perform those 64-bit atomic accesses.

Like for patch 1, I'm not sure I like introducing the data races...
While reads inside the seqlock do not need atomics, I think the write
should be atomic in both cases.

Paolo
