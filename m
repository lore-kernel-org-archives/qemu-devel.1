Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB56C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 13:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14CF2073B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 13:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaAD5aFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14CF2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJdQD-0004Ww-O0
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 09:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jJdPM-0003Pm-1W
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jJdPK-0003po-6n
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:27:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27504
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jJdPK-0003pN-33
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585747669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ni71YiFDJuPenSfHSGoeA9VeWWMym47rH7T1ZZ2OrWM=;
 b=iaAD5aFxaIvVI602ROaK9n2J6M/vtBXH+dntGfvD9v8kDrlei9ySgYs62ezdzzVzhU4ye5
 2FkYa8AtCkPu0N8pNqR0kFRUYgehKGuzuOfEWh6MQ1fP1PgaRkAoQM2KKzYDvJybyWL9H6
 ePxazVUrkbuWaV/gCmfftKe9iCalOws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-6NnEcXrrPROj0cLjB2gthg-1; Wed, 01 Apr 2020 09:27:45 -0400
X-MC-Unique: 6NnEcXrrPROj0cLjB2gthg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F28F813F6;
 Wed,  1 Apr 2020 13:27:43 +0000 (UTC)
Received: from work-vm (ovpn-115-201.ams2.redhat.com [10.36.115.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03EF1DA101;
 Wed,  1 Apr 2020 13:27:37 +0000 (UTC)
Date: Wed, 1 Apr 2020 14:27:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Simran Singhal <singhalsimran0@gmail.com>
Subject: Re: [PATCH] Compress lines for immediate return
Message-ID: <20200401132735.GC52559@work-vm>
References: <20200401121101.GA26994@simran-Inspiron-5558>
MIME-Version: 1.0
In-Reply-To: <20200401121101.GA26994@simran-Inspiron-5558>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Simran Singhal (singhalsimran0@gmail.com) wrote:
> Compress two lines into a single line if immediate return statement is fo=
und.
>=20
> It also remove variables progress, val, data, ret and sock
> as they are no longer needed.
>=20
> Remove space between function "mixer_load" and '(' to fix the
> checkpatch.pl error:-
> ERROR: space prohibited between function name and open parenthesis '('
>=20
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
>  block/file-posix.c      | 3 +--
>  block/nfs.c             | 3 +--
>  block/nvme.c            | 4 +---
>  block/vhdx.c            | 3 +--
>  hw/audio/ac97.c         | 4 +---
>  hw/audio/adlib.c        | 5 +----
>  hw/display/cirrus_vga.c | 4 +---
>  migration/ram.c         | 4 +---
>  ui/gtk.c                | 3 +--
>  util/qemu-sockets.c     | 5 +----
>  10 files changed, 10 insertions(+), 28 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 7e19bbff5f..dc01f0d4d3 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1627,8 +1627,7 @@ static int handle_aiocb_write_zeroes_unmap(void *op=
aque)
> =20
>      /* If we couldn't manage to unmap while guaranteed that the area rea=
ds as
>       * all-zero afterwards, just write zeroes without unmapping */
> -    ret =3D handle_aiocb_write_zeroes(aiocb);
> -    return ret;
> +    return handle_aiocb_write_zeroes(aiocb);
>  }
> =20
>  #ifndef HAVE_COPY_FILE_RANGE
> diff --git a/block/nfs.c b/block/nfs.c
> index cc2413d5ab..100f15bd1f 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -623,8 +623,7 @@ static int nfs_file_open(BlockDriverState *bs, QDict =
*options, int flags,
>      }
> =20
>      bs->total_sectors =3D ret;
> -    ret =3D 0;
> -    return ret;
> +    return 0;
>  }
> =20
>  static QemuOptsList nfs_create_opts =3D {
> diff --git a/block/nvme.c b/block/nvme.c
> index 7b7c0cc5d6..eb2f54dd9d 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -575,11 +575,9 @@ static bool nvme_poll_cb(void *opaque)
>  {
>      EventNotifier *e =3D opaque;
>      BDRVNVMeState *s =3D container_of(e, BDRVNVMeState, irq_notifier);
> -    bool progress =3D false;
> =20
>      trace_nvme_poll_cb(s);
> -    progress =3D nvme_poll_queues(s);
> -    return progress;
> +    return nvme_poll_queues(s);
>  }
> =20
>  static int nvme_init(BlockDriverState *bs, const char *device, int names=
pace,
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 33e57cd656..2c0e7ee44d 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -411,8 +411,7 @@ int vhdx_update_headers(BlockDriverState *bs, BDRVVHD=
XState *s,
>      if (ret < 0) {
>          return ret;
>      }
> -    ret =3D vhdx_update_header(bs, s, generate_data_write_guid, log_guid=
);
> -    return ret;
> +    return vhdx_update_header(bs, s, generate_data_write_guid, log_guid)=
;
>  }
> =20
>  /* opens the specified header block from the VHDX file header section */
> diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> index 1ec87feec0..8a9b9924c4 100644
> --- a/hw/audio/ac97.c
> +++ b/hw/audio/ac97.c
> @@ -573,11 +573,9 @@ static uint32_t nam_readb (void *opaque, uint32_t ad=
dr)
>  static uint32_t nam_readw (void *opaque, uint32_t addr)
>  {
>      AC97LinkState *s =3D opaque;
> -    uint32_t val =3D ~0U;
>      uint32_t index =3D addr;
>      s->cas =3D 0;
> -    val =3D mixer_load (s, index);
> -    return val;
> +    return mixer_load(s, index);
>  }
> =20
>  static uint32_t nam_readl (void *opaque, uint32_t addr)
> diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> index d6c1fb0586..7c3b67dcfb 100644
> --- a/hw/audio/adlib.c
> +++ b/hw/audio/adlib.c
> @@ -120,13 +120,10 @@ static void adlib_write(void *opaque, uint32_t npor=
t, uint32_t val)
>  static uint32_t adlib_read(void *opaque, uint32_t nport)
>  {
>      AdlibState *s =3D opaque;
> -    uint8_t data;
>      int a =3D nport & 3;
> =20
>      adlib_kill_timers (s);
> -    data =3D OPLRead (s->opl, a);
> -
> -    return data;
> +    return OPLRead (s->opl, a);
>  }
> =20
>  static void timer_handler (void *opaque, int c, double interval_Sec)
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 0d391e1300..1f29731ffe 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -2411,12 +2411,10 @@ static uint64_t cirrus_linear_bitblt_read(void *o=
paque,
>                                            unsigned size)
>  {
>      CirrusVGAState *s =3D opaque;
> -    uint32_t ret;
> =20
>      /* XXX handle bitblt */
>      (void)s;
> -    ret =3D 0xff;
> -    return ret;
> +    return 0xff;
>  }
> =20
>  static void cirrus_linear_bitblt_write(void *opaque,
> diff --git a/migration/ram.c b/migration/ram.c
> index 04f13feb2e..06cba88632 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2135,9 +2135,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState=
 *ms)
>      }
>      trace_ram_postcopy_send_discard_bitmap();
> =20
> -    ret =3D postcopy_each_ram_send_discard(ms);
> -
> -    return ret;
> +    return postcopy_each_ram_send_discard(ms);
>  }
> =20

For migration

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(If you rework this patch for another reason you could move the 'int ret' d=
own into the
loop as int ret =3D ....   but it's not important)



>  /**
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 030b251c61..83f2f5d49b 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1650,8 +1650,7 @@ static GSList *gd_vc_menu_init(GtkDisplayState *s, =
VirtualConsole *vc,
>                       G_CALLBACK(gd_menu_switch_vc), s);
>      gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), vc->menu_item);
> =20
> -    group =3D gtk_radio_menu_item_get_group(GTK_RADIO_MENU_ITEM(vc->menu=
_item));
> -    return group;
> +    return gtk_radio_menu_item_get_group(GTK_RADIO_MENU_ITEM(vc->menu_it=
em));
>  }
> =20
>  #if defined(CONFIG_VTE)
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index bcc06d0e01..86c48b9fa5 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -765,15 +765,12 @@ static int vsock_connect_addr(const struct sockaddr=
_vm *svm, Error **errp)
>  static int vsock_connect_saddr(VsockSocketAddress *vaddr, Error **errp)
>  {
>      struct sockaddr_vm svm;
> -    int sock =3D -1;
> =20
>      if (!vsock_parse_vaddr_to_sockaddr(vaddr, &svm, errp)) {
>          return -1;
>      }
> =20
> -    sock =3D vsock_connect_addr(&svm, errp);
> -
> -    return sock;
> +    return vsock_connect_addr(&svm, errp);
>  }
> =20
>  static int vsock_listen_saddr(VsockSocketAddress *vaddr,
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


