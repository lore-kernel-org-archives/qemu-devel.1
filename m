Received: from eggs.gnu.org ([2001:4830:134:3::10]:45331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9Y88-0006rM-VY
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9Y85-0004CQ-Tt
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:11:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9Y85-0004C0-KM
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:11:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id d2-v6so17014198wro.7
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 09:11:33 -0700 (PDT)
References: <20181008153204.18845-1-david@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181008153204.18845-1-david@redhat.com>
Date: Mon, 08 Oct 2018 17:11:30 +0100
Message-ID: <87va6cmn9p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390x/tcg: always enable AFP for linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>


David Hildenbrand <david@redhat.com> writes:

> linux-user should always enable AFP, otherwise our emulated binary
> might crash once it tries to make use of additional floating-point
> registers or instructions.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Fixes: db0504154e ("s390x/tcg: check for AFP-register, BFP and DFP data e=
xceptions")
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 8ed4823d6e..18ba7f85a5 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -145,6 +145,11 @@ static void s390_cpu_full_reset(CPUState *s)
>      env->cregs[0] =3D CR0_RESET;
>      env->cregs[14] =3D CR14_RESET;
>
> +#if defined(CONFIG_USER_ONLY)
> +    /* user mode should always be allowed to use the full FPU */
> +    env->cregs[0] |=3D CR0_AFP;
> +#endif
> +

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>      /* architectured initial value for Breaking-Event-Address register */
>      env->gbea =3D 1;


--
Alex Benn=C3=A9e
