Received: from eggs.gnu.org ([2001:4830:134:3::10]:42584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1f5M5V-0006gy-2x
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 21:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1f5M5R-00015x-7Z
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 21:59:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1f5M5Q-00015V-Uz
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 21:59:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w391s0YM066477
	for <qemu-devel@nongnu.org>; Sun, 8 Apr 2018 21:59:11 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h7j4wndq2-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 08 Apr 2018 21:59:10 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Sun, 8 Apr 2018 21:59:09 -0400
References: <20180404150146.23281-1-stefanha@redhat.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Mon, 9 Apr 2018 09:58:54 +0800
MIME-Version: 1.0
In-Reply-To: <20180404150146.23281-1-stefanha@redhat.com>
Content-Type: text/plain; charset=gbk
Message-Id: <5e62d846-903e-c352-7a70-91214d34204c@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] qemu-iotests: update 185 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



=D4=DA 2018/4/4 23:01, Stefan Hajnoczi =D0=B4=B5=C0:
> Commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce
> vm_shutdown()") added a bdrv_drain_all() call.  As a side-effect of the
> drain operation the block job iterates one more time than before.  The
> 185 output no longer matches and the test is failing now.
>=20
> It may be possible to avoid the superfluous block job iteration, but
> that type of patch is not suitable late in the QEMU 2.12 release cycle.
>=20
> This patch simply updates the 185 output file.  The new behavior is
> correct, just not optimal, so make the test pass again.
>=20
> Fixes: 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce vm_shut=
down()")
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/185     | 10 ++++++----
>  tests/qemu-iotests/185.out | 12 +++++++-----
>  2 files changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
> index f5b47e4c1a..298d88d04e 100755
> --- a/tests/qemu-iotests/185
> +++ b/tests/qemu-iotests/185
> @@ -92,9 +92,8 @@ echo =3D=3D=3D Start commit job and exit qemu =3D=3D=3D
>  echo
>=20
>  # Note that the reference output intentionally includes the 'offset' f=
ield in
> -# BLOCK_JOB_CANCELLED events for all of the following block jobs. They=
 are
> -# predictable and any change in the offsets would hint at a bug in the=
 job
> -# throttling code.
> +# BLOCK_JOB_* events for all of the following block jobs. They are pre=
dictable
> +# and any change in the offsets would hint at a bug in the job throttl=
ing code.
>  #
>  # In order to achieve these predictable offsets, all of the following =
tests
>  # use speed=3D65536. Each job will perform exactly one iteration befor=
e it has
> @@ -102,11 +101,14 @@ echo
>  # command to be received (after receiving the command, the rest runs
>  # synchronously, so jobs can arbitrarily continue or complete).
>  #
> +# Jobs present while QEMU is terminating iterate once more due to
> +# bdrv_drain_all().
> +#
>  # The buffer size for commit and streaming is 512k (waiting for 8 seco=
nds after
>  # the first request), for active commit and mirror it's large enough t=
o cover
>  # the full 4M, and for backup it's the qcow2 cluster size, which we kn=
ow is
>  # 64k. As all of these are at least as large as the speed, we are sure=
 that the
> -# offset doesn't advance after the first iteration before qemu exits.
> +# offset advances exactly twice before qemu exits.
>=20
>  _send_qemu_cmd $h \
>      "{ 'execute': 'block-commit',
Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>

> diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
> index 57eaf8d699..2c4b04de73 100644

[...]
>=20

--=20
Regards
QingFeng Hao
