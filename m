Received: from eggs.gnu.org ([2001:4830:134:3::10]:52121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gMyND-0002fe-TS
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gMyN0-0002IZ-7b
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:50:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51642
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gMyMw-0001un-Hx
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:50:24 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAEGi6JV049659
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 11:50:17 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nrp86med4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 11:50:17 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Nov 2018 16:50:16 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181113165539.14376-1-danielhb413@gmail.com>
References: <20181113165539.14376-1-danielhb413@gmail.com>
Date: Wed, 14 Nov 2018 10:50:06 -0600
Message-Id: <154221420629.30771.4049415289221436454@sif>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qga: update docs with systemd
 suspend support info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com

Quoting Daniel Henrique Barboza (2018-11-13 10:55:39)
> Commit 067927d62e ("qga: systemd hibernate/suspend/hybrid-sleep
> support") failed to update qapi-schema.json after adding systemd
> hibernate/suspend/hybrid-sleep capabilities to guest-suspend-* QGA
> commands.
> =

> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Thanks, applied to qga tree:
  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/qapi-schema.json | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> =

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index c6725b3ec8..61f66fc461 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -532,12 +532,12 @@
>  #
>  # Suspend guest to disk.
>  #
> -# This command tries to execute the scripts provided by the pm-utils pac=
kage.
> -# If it's not available, the suspend operation will be performed by manu=
ally
> -# writing to a sysfs file.
> +# This command attempts to suspend the guest using three strategies, in =
this
> +# order:
>  #
> -# For the best results it's strongly recommended to have the pm-utils
> -# package installed in the guest.
> +# - systemd hibernate
> +# - pm-utils (via pm-hibernate)
> +# - manual write into sysfs
>  #
>  # This command does NOT return a response on success. There is a high ch=
ance
>  # the command succeeded if the VM exits with a zero exit status or, when
> @@ -560,12 +560,12 @@
>  #
>  # Suspend guest to ram.
>  #
> -# This command tries to execute the scripts provided by the pm-utils pac=
kage.
> -# If it's not available, the suspend operation will be performed by manu=
ally
> -# writing to a sysfs file.
> +# This command attempts to suspend the guest using three strategies, in =
this
> +# order:
>  #
> -# For the best results it's strongly recommended to have the pm-utils
> -# package installed in the guest.
> +# - systemd suspend
> +# - pm-utils (via pm-suspend)
> +# - manual write into sysfs
>  #
>  # IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wake=
up'
>  # command.  Thus, it's *required* to query QEMU for the presence of the
> @@ -592,7 +592,10 @@
>  #
>  # Save guest state to disk and suspend to ram.
>  #
> -# This command requires the pm-utils package to be installed in the gues=
t.
> +# This command attempts to suspend the guest by executing, in this order:
> +#
> +# - systemd hybrid-sleep
> +# - pm-utils (via pm-suspend-hybrid)
>  #
>  # IMPORTANT: guest-suspend-hybrid requires QEMU to support the 'system_w=
akeup'
>  # command.  Thus, it's *required* to query QEMU for the presence of the
> -- =

> 2.19.1
>=20
