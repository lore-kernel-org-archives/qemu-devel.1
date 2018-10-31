Received: from eggs.gnu.org ([2001:4830:134:3::10]:40153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHt7V-00044L-6b
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHt7F-0006LX-2H
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:13:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHt7E-0006Kj-QJ
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:13:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id w7-v6so4656136wmc.1
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:13:08 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-24-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-24-cota@braap.org>
Date: Wed, 31 Oct 2018 16:13:05 +0000
Message-ID: <8736sm857y.fsf@linaro.org>
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

> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
<snip>
>
>  static unsigned s390_count_running_cpus(void)
> @@ -340,10 +340,12 @@ unsigned int s390_cpu_halt(S390CPU *cpu)
>      CPUState *cs =3D CPU(cpu);
>      trace_cpu_halt(cs->cpu_index);
>
> -    if (!cs->halted) {
> -        cs->halted =3D 1;
> +    cpu_mutex_lock(cs);
> +    if (!cpu_halted(cs)) {
> +        cpu_halted_set(cs, 1);
>          cs->exception_index =3D EXCP_HLT;
>      }
> +    cpu_mutex_unlock(cs);
>
>      return s390_count_running_cpus();
>  }
> @@ -353,10 +355,12 @@ void s390_cpu_unhalt(S390CPU *cpu)
>      CPUState *cs =3D CPU(cpu);
>      trace_cpu_unhalt(cs->cpu_index);
>
> -    if (cs->halted) {
> -        cs->halted =3D 0;
> +    cpu_mutex_lock(cs);
> +    if (cpu_halted(cs)) {
> +        cpu_halted_set(cs, 0);
>          cs->exception_index =3D -1;
>      }
> +    cpu_mutex_unlock(cs);

I think this locking is superfluous as you already added locking when
you introduced the helper.

<snip>

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
