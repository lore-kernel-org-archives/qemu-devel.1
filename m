Received: from eggs.gnu.org ([2001:4830:134:3::10]:46725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE6dL-0002hp-MB
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE6dI-0006b7-Gj
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:13:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dE6dI-0006av-88
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:13:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33BF68048D
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 04:13:47 +0000 (UTC)
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-3-git-send-email-vyasevic@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <63d0500e-5760-42f5-c91c-b30b2f68327e@redhat.com>
Date: Fri, 26 May 2017 12:13:33 +0800
MIME-Version: 1.0
In-Reply-To: <1495649128-10529-3-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/12] migration: Introduce announcement
 timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladislav Yasevich <vyasevic@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com



On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 02:05, Vladislav Yasevich wrote:
> Introdec

Typo.

Thanks

> an annoucement timer structure and initialization to
> be used by for self-annoucement.
>
> Based on the work by Germano Veit Michel <germano@redhat.com>
>
> Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
> ---
>   include/migration/vmstate.h | 13 +++++++++++++
>   migration/savevm.c          | 22 ++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 8489659..a6bf84d 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1057,6 +1057,19 @@ void vmstate_register_ram(struct MemoryRegion *m=
emory, DeviceState *dev);
>   void vmstate_unregister_ram(struct MemoryRegion *memory, DeviceState =
*dev);
>   void vmstate_register_ram_global(struct MemoryRegion *memory);
>  =20
> +typedef struct AnnounceTimer {
> +    QEMUTimer *tm;
> +    AnnounceParameters params;
> +    QEMUClockType type;
> +    int round;
> +} AnnounceTimer;
> +
> +AnnounceTimer *qemu_announce_timer_new(AnnounceParameters *params,
> +                                       QEMUClockType type);
> +AnnounceTimer *qemu_announce_timer_create(AnnounceParameters *params,
> +                                          QEMUClockType type,
> +                                          QEMUTimerCB *cb);
> +
>   static inline
>   int64_t self_announce_delay(int round)
>   {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index cee2837..607b090 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -230,6 +230,28 @@ static void qemu_announce_self_once(void *opaque)
>       }
>   }
>  =20
> +AnnounceTimer *qemu_announce_timer_new(AnnounceParameters *params,
> +                                       QEMUClockType type)
> +{
> +    AnnounceTimer *timer =3D g_new(AnnounceTimer, 1);
> +
> +    timer->params =3D *params;
> +    timer->round =3D params->rounds;
> +    timer->type =3D type;
> +
> +    return timer;
> +}
> +
> +AnnounceTimer *qemu_announce_timer_create(AnnounceParameters *params,
> +                                          QEMUClockType type,
> +                                          QEMUTimerCB *cb)
> +{
> +    AnnounceTimer *timer =3D qemu_announce_timer_new(params, type);
> +
> +    timer->tm =3D timer_new_ms(type, cb, timer);
> +    return timer;
> +}
> +
>   void qemu_announce_self(void)
>   {
>       static QEMUTimer *timer;
