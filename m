Received: from eggs.gnu.org ([2001:4830:134:3::10]:36837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fziM2-0007xu-TK
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fziD9-0002W4-BL
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:56:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fziD9-0002Vi-59
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:56:07 -0400
References: <20180910232752.31565-1-cota@braap.org>
	<20180910232752.31565-9-cota@braap.org>
	<9ef6906f-7fbc-1b41-b5f3-3fd5c9a87e5b@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <23bf97d3-d2af-24ea-17e2-9186453dc4de@redhat.com>
Date: Tue, 11 Sep 2018 14:55:58 +0200
MIME-Version: 1.0
In-Reply-To: <9ef6906f-7fbc-1b41-b5f3-3fd5c9a87e5b@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/12] cpus: always call seqlock_write
 in cpu_update_icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

On 11/09/2018 14:53, Richard Henderson wrote:
>>  
>> -#ifndef CONFIG_ATOMIC64
>>      seqlock_write_lock(&timers_state.vm_clock_seqlock,
>>                         &timers_state.vm_clock_lock);
>> -#endif
>>      atomic_set__nocheck(&timers_state.qemu_icount,
>>                          timers_state.qemu_icount + executed);
>> -#ifndef CONFIG_ATOMIC64
>>      seqlock_write_unlock(&timers_state.vm_clock_seqlock,
>>                           &timers_state.vm_clock_lock);
>> -#endif
> I don't understand this.  Surely you either want atomic64_set,
> or an actual atomic64_add, but no extra lock when CONFIG_ATOMIC64.

Even though writes of qemu_icount can safely race with reads in
qemu_icount_raw, qemu_icount is also read by icount_adjust, which runs
in the I/O thread.  Therefore, writes do need protection of the
vm_clock_lock; for simplicity Emilio's patch protects it with both
seqlock+spinlock, which we already do for hosts that lack 64-bit atomics.

The bug actually predated the introduction of vm_clock_lock;
cpu_update_icount would have needed the BQL before the spinlock was
introduced.

The above could have been a commit message, by the way. :)

Paolo
