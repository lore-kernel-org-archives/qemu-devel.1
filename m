Received: from eggs.gnu.org ([2001:4830:134:3::10]:48969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvKAP-00063E-JV
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 04:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvKAM-0003F9-GL
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 04:50:21 -0400
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:35747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cvKAM-0003E3-8E
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 04:50:18 -0400
Received: by mail-lf0-x22e.google.com with SMTP id j90so88519589lfk.2
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 01:50:18 -0700 (PDT)
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<e6b326dd-fbc6-250d-26a2-4483db009b7d@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <e6b326dd-fbc6-250d-26a2-4483db009b7d@redhat.com>
Date: Tue, 04 Apr 2017 09:50:16 +0100
Message-ID: <877f30blpz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/9] MTTCG and record/replay fixes
 for rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: dovgaluk@ispras.ru, rth@twiddle.net, peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/04/2017 14:45, Alex Bennée wrote:
>>   cpus: check cpu->running in cpu_get_icount_raw()
>>
>>   I'm not sure the race happens and once outside of cpu->running the
>>   icount counters should be zero. However it seems a sensible
>>   precaution.
>
> Yeah, I think this is unnecessary with patch 7's new assertions.

I can drop the patch.

>> I think the cpus: patches should probably go into the next
>> pull-request while we see if we can come up with a better final
>> solution for fixing record/replay. However given how long this
>> regression has run during the release candidate process I wanted to
>> update everyone on the current status and get feedback ASAP.
>
> I agree.  I'm not sure exactly how the final race happens, but if it
> causes divergence it would be caught later by the record/replay
> mechanism, I think.

It's odd because everything should be sequenced by the BQL. The
main-loop holds the BQL while writing out checkpoints and everything
that can trigger output to the replay stream should be under BQL as
well:

  - VIRTUAL timers in the outer loop
  - MMIO triggered events (block, char, audio)
  - Interrupt processing

In fact I wonder if replay_mutex could just be dropped and the BQL used
to protect all of this stuff.

I'll have to experiment with some asserts to see if this is every not
the case.

--
Alex Bennée
