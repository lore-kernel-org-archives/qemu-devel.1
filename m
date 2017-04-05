Received: from eggs.gnu.org ([2001:4830:134:3::10]:47372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvm1E-0005Fr-8d
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvm1A-0007Zk-7z
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:34:44 -0400
Received: from mail-lf0-x230.google.com ([2a00:1450:4010:c07::230]:33102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cvm1A-0007ZR-0A
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:34:40 -0400
Received: by mail-lf0-x230.google.com with SMTP id h125so10033696lfe.0
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 07:34:39 -0700 (PDT)
References: <20170405132503.32125-1-alex.bennee@linaro.org>
	<20170405132503.32125-10-alex.bennee@linaro.org>
	<3f66fd3e-c66c-c4aa-ed6f-eee1ba34a932@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <3f66fd3e-c66c-c4aa-ed6f-eee1ba34a932@redhat.com>
Date: Wed, 05 Apr 2017 15:34:39 +0100
Message-ID: <87shlmapog.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/12] cpus: introduce cpu_update_icount
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: dovgaluk@ispras.ru, rth@twiddle.net, peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/04/2017 15:25, Alex Bennée wrote:
>> +{
>> +    int64_t executed = cpu_get_icount_executed(cpu);
>> +    cpu->icount_budget -= executed;
>> +    atomic_add(&timers_state.qemu_icount, executed);
>> +}
>
> Since there's only one writer, it's also okay to do
>
> 	atomic_set(&timers_state.qemu_icount,
> 		   atomic_read(&timers_state.qemu_icount) + executed);
>
> (also not just faster, but also simpler to turn into TCG code if we do
> the update in gen_io_start).

OK fair enough. Annoyingly I've just noticed this breaks for 32 bit
hosts because we might not have CONFIG_ATOMIC64. What's the best
approach? #ifdef and handwave?

--
Alex Bennée
