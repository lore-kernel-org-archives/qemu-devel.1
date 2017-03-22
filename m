Received: from eggs.gnu.org ([2001:4830:134:3::10]:57858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cqni7-00055W-Io
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 17:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cqni3-0001t1-Ks
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 17:22:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cqni3-0001sf-Bv
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 17:22:23 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2MLIWFw124361
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:22:21 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vp3nt4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:22:20 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 22 Mar 2017 15:22:19 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170322204844.446-4-f4bug@amsat.org>
References: <20170322204844.446-1-f4bug@amsat.org>
	<20170322204844.446-4-f4bug@amsat.org>
Date: Wed, 22 Mar 2017 16:22:10 -0500
Message-Id: <149021773050.3910.449421368071627004@loki>
Subject: Re: [Qemu-devel] [PATCH RESEND 3/3] qga: fix compiler warnings
 (clang 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Quoting Philippe Mathieu-Daud=C3=A9 (2017-03-22 15:48:44)
> static code analyzer complain:
> =

> qga/commands-posix.c:2127:9: warning: Null pointer passed as an argument =
to a 'nonnull' parameter
>         closedir(dp);
>         ^~~~~~~~~~~~
> =

> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/commands-posix.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> =

> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 73d93eb5ce..8028141534 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2122,9 +2122,11 @@ static void transfer_memory_block(GuestMemoryBlock=
 *mem_blk, bool sys2memblk,
>           * we think this VM does not support online/offline memory block,
>           * any other solution?
>           */
> -        if (!dp && errno =3D=3D ENOENT) {
> -            result->response =3D
> -                GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
> +        if (!dp) {
> +            if (errno =3D=3D ENOENT) {
> +                result->response =3D
> +                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPO=
RTED;
> +            }
>              goto out1;
>          }

I think this should be:

    if (!dp) {
        if (errno =3D=3D ENOENT) {
            result->response =3D
                GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
        } else {
            result->response =3D
                GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
        }
        goto out1;
    }

otherwise we might set result->error_code while still indicating
success for the operation. That wasn't handled properly before your
patch either, it's just more apparent now.

>          closedir(dp);
> -- =

> 2.11.0
>=20
