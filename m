Received: from eggs.gnu.org ([2001:4830:134:3::10]:50945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7UFc-0005nx-Uj
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 18:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7UFZ-0005Tf-IL
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 18:34:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7UFZ-0005TN-9U
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 18:34:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PMXN5p033477
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 18:34:08 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2du0k27dtg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 18:34:08 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 18:34:07 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20171017064142.4519-1-chen_han_xiao@126.com>
References: <20171017064142.4519-1-chen_han_xiao@126.com>
Date: Wed, 25 Oct 2017 17:33:52 -0500
Message-Id: <150897083249.17721.1016197639694178384@sif>
Subject: Re: [Qemu-devel] [Resend][PATCH] qga-win: don't hang if vss hold
 writes timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>, qemu-devel@nongnu.org
Cc: Tomoki Sekiyama <tomoki.sekiyama@gmail.com>

Quoting Chen Hanxiao (2017-10-17 01:41:42)
> From: Chen Hanxiao <chenhanxiao@gmail.com>
> =

> When VM is in a heavy IO, if the command "guest-fsfreeze-freeze"
> is executed, VSS may timeout when trying to hold writes.
> =

> Inside guest, Event ID 12298(VSS_ERROR_HOLD_WRITES_TIMEOUT)
> is logged in the Event Viewer.
> =

> At that time, if we call AbortBackup, qga may hang forever.
> =

> This patch will solve this issue.
> =

> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Cc: Tomoki Sekiyama <tomoki.sekiyama@gmail.com>
> =

> Reviewed-by: Tomoki Sekiyama <tomoki.sekiyama@gmail.com>
> Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>

Thanks, applied to QGA tree:

  https://github.com/mdroth/qemu/commits/qga

Unless I missed another thread though, I don't think Tomoki gave it
an actual Reviewed-by, just a "looks good", so I've removed it from
the patch. (A "looks good" is certainly helpful, particularly in this
case, but actual Signed-off-by/Tested-by/Reviewed-by tags should
only be added if they were explicitly provided by the person in
question since they imply some level of accountability if something
goes wrong. Less formal tags like Suggested-by/Reported-by/etc are
generally okay though).

> ---
>  qga/vss-win32/requester.cpp | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> =

> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 301762d8b1..3d9c9716c0 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -419,6 +419,16 @@ void requester_freeze(int *num_vols, ErrorSet *errse=
t)
>              break;
>          }
>      }
> +
> +    if (wait_status =3D=3D WAIT_TIMEOUT) {
> +        err_set(errset, E_FAIL,
> +                "timeout when try to receive Frozen event from VSS provi=
der");
> +        /* If we are here, VSS had timeout.
> +         * Don't call AbortBackup, just return directly.
> +         */
> +        goto out1;
> +    }
> +
>      if (wait_status !=3D WAIT_OBJECT_0) {
>          err_set(errset, E_FAIL,
>                  "couldn't receive Frozen event from VSS provider");
> @@ -432,6 +442,8 @@ out:
>      if (vss_ctx.pVssbc) {
>          vss_ctx.pVssbc->AbortBackup();
>      }
> +
> +out1:
>      requester_cleanup();
>      CoUninitialize();
>  }
> -- =

> 2.13.5
>=20
