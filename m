Received: from eggs.gnu.org ([2001:4830:134:3::10]:35154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaOu-0003Im-Ha
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaOq-0003yN-Ix
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dwaOq-0003xB-9s
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8PKsSXT005105
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:54:38 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d74nbpfb1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:54:38 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 25 Sep 2017 14:54:37 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170919155025.4098-1-stefanha@redhat.com>
References: <20170919155025.4098-1-stefanha@redhat.com>
Date: Mon, 25 Sep 2017 15:50:59 -0500
Message-Id: <150637265937.26688.11132282314885025503@sif>
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: update
 tg->any_timer_armed[] on detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>, Max Reitz <mreitz@redhat.com>

Quoting Stefan Hajnoczi (2017-09-19 10:50:25)
> Clear tg->any_timer_armed[] when throttling timers are destroy during
> AioContext attach/detach.  Failure to do so causes throttling to hang
> because we believe the timer is already scheduled!
> =

> The following was broken at least since QEMU 2.10.0 with -drive
> iops=3D100:
> =

>   $ dd if=3D/dev/zero of=3D/dev/vdb oflag=3Ddirect count=3D1000
>   (qemu) stop
>   (qemu) cont
>   ...I/O is stuck...
> =

> Reported-by: Yongxue Hong <yhong@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

FYI: this patch has been tagged for stable 2.10.1, but is not yet
upstream. Patch freeze for 2.10.1 is September 27th.

> ---
>  block/throttle-groups.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> =

> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 6ba992c8d7..2bfd03faa0 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -592,7 +592,20 @@ void throttle_group_attach_aio_context(ThrottleGroup=
Member *tgm,
>  void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
>  {
>      ThrottleTimers *tt =3D &tgm->throttle_timers;
> +    ThrottleGroup *tg =3D container_of(tgm->throttle_state, ThrottleGrou=
p, ts);
> +
>      throttle_timers_detach_aio_context(tt);
> +
> +    /* Forget about these timers, they have been destroyed */
> +    qemu_mutex_lock(&tg->lock);
> +    if (tg->tokens[0] =3D=3D tgm) {
> +        tg->any_timer_armed[0] =3D false;
> +    }
> +    if (tg->tokens[1] =3D=3D tgm) {
> +        tg->any_timer_armed[1] =3D false;
> +    }
> +    qemu_mutex_unlock(&tg->lock);
> +
>      tgm->aio_context =3D NULL;
>  }
> =

> -- =

> 2.13.5
> =

>=20
