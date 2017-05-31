Received: from eggs.gnu.org ([2001:4830:134:3::10]:42563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1dG6Ji-000188-OM
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1dG6Jf-0003lN-KV
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:17:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1dG6Jf-0003iM-A9
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:17:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4VGFVDb096506
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 12:17:43 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2at0xprt99-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 12:17:43 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Wed, 31 May 2017 17:17:41 +0100
Date: Wed, 31 May 2017 18:17:37 +0200
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <20170531150933.10156-3-alex.bennee@linaro.org>
References: <20170531150933.10156-1-alex.bennee@linaro.org>
	<20170531150933.10156-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170531181737.230cbded@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: pbonzini@redhat.com, doug16k@gmail.com, qemu-devel@nongnu.org

On Wed, 31 May 2017 16:09:33 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> The thread-id of 0 means any CPU but we then ignore the fact we find
> the first_cpu in this case who can have an index of 0. Instead of
> bailing out just test if we have managed to match up thread-id to a
> CPU.
>=20
> Otherwise you get:
>   gdb_handle_packet: command=3D'vCont;C04:0;c'
>   put_packet: reply=3D'E22'
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  gdbstub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index a249846954..29c9ed3002 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -934,8 +934,8 @@ static int gdb_handle_vcont(GDBState *s, const
> char *p)
>               * CPU first, and only then we can use its index.
>               */
>              cpu =3D find_cpu(idx);
> -            /* invalid CPU/thread specified */
> -            if (!idx || !cpu) {
> +            /* invalid thread specified, cpu not found. */
> +            if (!cpu) {
>                  res =3D -EINVAL;
>                  goto out;
>              }

This is strange. cpu_index() is defined as:

static inline int cpu_index(CPUState *cpu)
{
#if defined(CONFIG_USER_ONLY)
    return cpu->host_tid;
#else
    return cpu->cpu_index + 1;
#endif
}

therefore it shouldn't return 0 under any circumstance, and
find_cpu(idx) should also fail if idx =3D=3D 0, because internally it also
uses cpu_index()

on the other hand, you say that the patch does fix the problem for you,
which really confuses me.



(probably) completely unrelatedly, this:

res =3D qemu_strtoul(p + 1, &p, 16, &tmp);

should be like this instead:

res =3D qemu_strtoul(p, &p, 16, &tmp);

but this shouldn't impact you in any way.
