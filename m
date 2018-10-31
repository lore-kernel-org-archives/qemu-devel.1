Received: from eggs.gnu.org ([2001:4830:134:3::10]:57575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtnh-0008IE-NA
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtnd-0002LD-KY
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:01 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtnd-0002Kv-9y
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:56:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id y140-v6so39659wmd.0
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:56:57 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-24-cota@braap.org>
	<8736sm857y.fsf@linaro.org> <20181031163846.GC15881@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181031163846.GC15881@flamenco>
Date: Wed, 31 Oct 2018 16:56:54 +0000
Message-ID: <87wopy5a21.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 24/71] s390x: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> On Wed, Oct 31, 2018 at 16:13:05 +0000, Alex Benn=C3=A9e wrote:
>> > @@ -353,10 +355,12 @@ void s390_cpu_unhalt(S390CPU *cpu)
>> >      CPUState *cs =3D CPU(cpu);
>> >      trace_cpu_unhalt(cs->cpu_index);
>> >
>> > -    if (cs->halted) {
>> > -        cs->halted =3D 0;
>> > +    cpu_mutex_lock(cs);
>> > +    if (cpu_halted(cs)) {
>> > +        cpu_halted_set(cs, 0);
>> >          cs->exception_index =3D -1;
>> >      }
>> > +    cpu_mutex_unlock(cs);
>>
>> I think this locking is superfluous as you already added locking when
>> you introduced the helper.
>
> It gives a small perf gain, since it avoids locking & unlocking twice
> in a row (cpu_halted and cpu_halted_set both take the lock if needed).

Maybe a one line comment then above the first lock:

  /* lock outside cpu_halted(_set) to avoid bouncing */

Or some such.....

>
>> Otherwise:
>>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Thanks!
>
> 		Emilio


--
Alex Benn=C3=A9e
