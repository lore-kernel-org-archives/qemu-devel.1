Received: from eggs.gnu.org ([2001:4830:134:3::10]:35159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaOu-0003Ip-J9
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dwaOq-0003yw-PX
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dwaOq-0003xA-Hj
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:54:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8PKsSIo005081
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:54:40 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d74nbpfcp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:54:39 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 25 Sep 2017 14:54:39 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170918202529.28379-1-el13635@mail.ntua.gr>
References: <20170918202529.28379-1-el13635@mail.ntua.gr>
Date: Mon, 25 Sep 2017 15:51:30 -0500
Message-Id: <150637269011.26688.11842359275790780322@sif>
Subject: Re: [Qemu-devel] [PATCH] block/throttle-groups.c: allocate
 RestartData on the heap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

Quoting Manos Pitsidianakis (2017-09-18 15:25:29)
> RestartData is the opaque data of the throttle_group_restart_queue_entry
> coroutine. By being stack allocated, it isn't available anymore if
> aio_co_enter schedules the coroutine with a bottom halve and runs after
> throttle_group_restart_queue returns.
> =

> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

FYI: this patch has been tagged for stable 2.10.1, but is not yet
upstream. Patch freeze for 2.10.1 is September 27th.

> ---
>  block/throttle-groups.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> =

> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 6ba992c8d7..b291a88481 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -403,17 +403,19 @@ static void coroutine_fn throttle_group_restart_que=
ue_entry(void *opaque)
>          schedule_next_request(tgm, is_write);
>          qemu_mutex_unlock(&tg->lock);
>      }
> +
> +    g_free(data);
>  }
> =

>  static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool =
is_write)
>  {
>      Coroutine *co;
> -    RestartData rd =3D {
> -        .tgm =3D tgm,
> -        .is_write =3D is_write
> -    };
> +    RestartData *rd =3D g_new0(RestartData, 1);
> =

> -    co =3D qemu_coroutine_create(throttle_group_restart_queue_entry, &rd=
);
> +    rd->tgm =3D tgm;
> +    rd->is_write =3D is_write;
> +
> +    co =3D qemu_coroutine_create(throttle_group_restart_queue_entry, rd);
>      aio_co_enter(tgm->aio_context, co);
>  }
> =

> -- =

> 2.11.0
> =

>=20
