Received: from eggs.gnu.org ([2001:4830:134:3::10]:56046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvmQf-00034J-DI
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvmQZ-0002VJ-Sd
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:01:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvmQZ-0002VC-MF
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:00:55 -0400
References: <20170405132503.32125-1-alex.bennee@linaro.org>
	<20170405132503.32125-10-alex.bennee@linaro.org>
	<3f66fd3e-c66c-c4aa-ed6f-eee1ba34a932@redhat.com>
	<87shlmapog.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <af20fa6b-1aff-bc7d-4073-19c5f6faf984@redhat.com>
Date: Wed, 5 Apr 2017 17:00:49 +0200
MIME-Version: 1.0
In-Reply-To: <87shlmapog.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: dovgaluk@ispras.ru, rth@twiddle.net, peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>



On 05/04/2017 16:34, Alex Benn=C3=A9e wrote:
>> On 05/04/2017 15:25, Alex Benn=C3=A9e wrote:
>>> +{
>>> +    int64_t executed =3D cpu_get_icount_executed(cpu);
>>> +    cpu->icount_budget -=3D executed;
>>> +    atomic_add(&timers_state.qemu_icount, executed);
>>> +}
>> Since there's only one writer, it's also okay to do
>>
>> 	atomic_set(&timers_state.qemu_icount,
>> 		   atomic_read(&timers_state.qemu_icount) + executed);
>>
>> (also not just faster, but also simpler to turn into TCG code if we do
>> the update in gen_io_start).
>
> OK fair enough. Annoyingly I've just noticed this breaks for 32 bit
> hosts because we might not have CONFIG_ATOMIC64. What's the best
> approach? #ifdef and handwave?

For 2.9 yes... For 2.10 I'm going to add a "Stat64" type that can
compute max or add of 63-bit values, and blocks on the read side if a
doubleword change is in progress.

Paolo
