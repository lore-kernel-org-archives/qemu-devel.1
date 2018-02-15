Received: from eggs.gnu.org ([2001:4830:134:3::10]:43624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1emOoZ-0005W5-9f
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1emOoV-0004u5-Ca
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:03:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53702
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1emOoV-0004ty-7T
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:03:23 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1FIt5dP037158
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:03:22 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g5dujx2s4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:03:21 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 15 Feb 2018 12:03:21 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180209013542.24516-1-chen_han_xiao@126.com>
References: <20180209013542.24516-1-chen_han_xiao@126.com>
Date: Thu, 15 Feb 2018 12:41:25 -0600
Message-Id: <151872008505.15399.14198607718964730192@sif>
Subject: Re: [Qemu-devel] [Resend][PATCH] qga: unset frozen state if no
 mount points are frozen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>
Cc: qemu-devel@nongnu.org

Quoting Chen Hanxiao (2018-02-08 19:35:42)
> From: Chen Hanxiao <chenhanxiao@gmail.com>
> =

> If we set mountpoints to qmp_guest_fsfreeze_freeze_list,
> we may got nothing to freeze as all mountpoints are
> not valid.
> Call ga_unset_frozen in this senario.
> =

> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> ---
> Rebase on master
> =

>  qga/commands-posix.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> =

> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index e809e382eb..9fd51f1d7a 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1273,6 +1273,12 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mo=
untpoints,
>      }
> =

>      free_fs_mount_list(&mounts);
> +    /* We may not issue any FIFREEZE here when had mountpoints.
> +     * Just unset ga_state here and ready for the next call.
> +     */
> +    if (has_mountpoints && i =3D=3D 0) {
> +        ga_unset_frozen(ga_state);
> +    }

It seems odd to special-case has_mountpoints. Wouldn't:

  if (i =3D=3D 0) {
    ...
  }

be more consistent? Then management could infer i=3D=3D0 leaves qga in
unfrozen state. Otherwise I'd rather just stick with expecting a
gratuitous unfreeze() since it requires less special-casing on the
management/ side.

And if we do change this, we'd probably want to update
qga/qapi-schema.json to reflect the behavior. I.e.:

##
# @guest-fsfreeze-freeze:
#
# Sync and freeze all freezable, local guest filesystems. If this
# command succeeded, you may call @guest-fsfreeze-thaw later to
# unfreeze.
...
# Returns: Number of file systems currently frozen. On error, all filesyste=
ms
-# will be thawed.
+# will be thawed. If no filesystems are frozen as a result of this call,
+# then @guest-fsfreeze-status will remain "thawed" and calling
+# @guest-fsfreeze-thaw is not necessary.


>      return i;
> =

>  error:
> -- =

> 2.14.3
>=20
