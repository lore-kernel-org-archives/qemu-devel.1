Received: from eggs.gnu.org ([2001:4830:134:3::10]:47415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cxkUE-0007uG-RE
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cxkUB-0006im-N9
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:20:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39667
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cxkUB-0006iJ-Gu
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:20:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3B1Im8c024681
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 21:20:45 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29r99u8pmj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 21:20:45 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 10 Apr 2017 21:20:44 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170407222016.15308-4-f4bug@amsat.org>
References: <20170407222016.15308-1-f4bug@amsat.org>
	<20170407222016.15308-4-f4bug@amsat.org>
Date: Mon, 10 Apr 2017 20:01:49 -0500
Message-Id: <149187250944.15312.1935478125335549576@loki>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] qga: fix compiler warnings (clang 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Quoting Philippe Mathieu-Daud=C3=A9 (2017-04-07 17:20:15)
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

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  qga/commands-posix.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> =

> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 915df9ed90..fc45102a1e 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2124,9 +2124,11 @@ static void transfer_memory_block(GuestMemoryBlock=
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
>          closedir(dp);
> -- =

> 2.11.0
>=20
