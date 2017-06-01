Received: from eggs.gnu.org ([2001:4830:134:3::10]:36298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1dGSRE-0001Hs-KX
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1dGSR9-0002aw-NY
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:55:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36277
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1dGSR9-0002aJ-Gw
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:54:59 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51Frg6M061853
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 11:54:58 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2atm3qe9ur-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 11:54:58 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Thu, 1 Jun 2017 16:54:56 +0100
Date: Thu, 1 Jun 2017 17:54:53 +0200
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <20170601144915.20778-5-alex.bennee@linaro.org>
References: <20170601144915.20778-1-alex.bennee@linaro.org>
	<20170601144915.20778-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170601175453.74eb4ab0@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] gdbstub: don't fail on vCont; C04:0;
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

On Thu,  1 Jun 2017 15:49:15 +0100
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
> The actual reason for gdb sending vCont;C04:0;c was fixed in a
> previous commit where we ensure the first_cpu's tid is correctly
> reported to gdb however we should still behave correctly next time it
> does send 0.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> ---
> v2
>   - used Greg's less convoluted suggestion
>   - expand commit message
> ---
>  gdbstub.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index 45a3a0b16b..6b1e72e9f7 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -937,23 +937,16 @@ static int gdb_handle_vcont(GDBState *s, const
> char *p) if (res) {
>                  goto out;
>              }
> -            idx =3D tmp;
> +
>              /* 0 means any thread, so we pick the first valid CPU */
> -            if (!idx) {
> -                idx =3D cpu_gdb_index(first_cpu);
> -            }
> +            cpu =3D tmp ? find_cpu(tmp) : first_cpu;
>=20
> -            /*
> -             * If we are in user mode, the thread specified is
> actually a
> -             * thread id, and not an index. We need to find the
> actual
> -             * CPU first, and only then we can use its index.
> -             */
> -            cpu =3D find_cpu(idx);
>              /* invalid CPU/thread specified */
> -            if (!idx || !cpu) {
> +            if (!cpu) {
>                  res =3D -EINVAL;
>                  goto out;
>              }
> +
>              /* only use if no previous match occourred */
>              if (newstates[cpu->cpu_index] =3D=3D 1) {
>                  newstates[cpu->cpu_index] =3D cur_action;


Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
