Received: from eggs.gnu.org ([2001:4830:134:3::10]:47046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g9YD4-0000BO-Jg
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g9YD1-0002K1-Gv
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:16:42 -0400
Date: Mon, 8 Oct 2018 18:16:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181008181634.2d18e015.cohuck@redhat.com>
In-Reply-To: <20181008153204.18845-1-david@redhat.com>
References: <20181008153204.18845-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>

On Mon,  8 Oct 2018 17:32:04 +0200
David Hildenbrand <david@redhat.com> wrote:

> linux-user should always enable AFP, otherwise our emulated binary
> might crash once it tries to make use of additional floating-point
> registers or instructions.
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Fixes: db0504154e ("s390x/tcg: check for AFP-register, BFP and DFP data e=
xceptions")
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 8ed4823d6e..18ba7f85a5 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -145,6 +145,11 @@ static void s390_cpu_full_reset(CPUState *s)
>      env->cregs[0] =3D CR0_RESET;
>      env->cregs[14] =3D CR14_RESET;
> =20
> +#if defined(CONFIG_USER_ONLY)
> +    /* user mode should always be allowed to use the full FPU */
> +    env->cregs[0] |=3D CR0_AFP;
> +#endif
> +
>      /* architectured initial value for Breaking-Event-Address register */
>      env->gbea =3D 1;
> =20

In case this is applied directly:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com>
