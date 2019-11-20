Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086EFC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C931722419
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aX4p3vup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C931722419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOgm-0007iJ-Nf
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iXOU7-0000Tg-Dx
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:49:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iXOU5-000559-0R
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:49:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57823
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iXOU4-0004xE-F0
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574250556;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7zL4BWYa1kSA5bSg/wi1aR7CmPuK6fmUFk3vyoIfJ0=;
 b=aX4p3vup3ugSNg4UX9Ow1ZKtWq+Xz87fKAcPGWY0wvVhkOr81HVkAalmJct7ocfSEf7h2B
 9Vu6Tlut0trYPONjN6KbMD9BKwRNm0/qK4DEku9ZeGuL3Ow80aiF00bLxenE5hml7u8xLF
 d/qdS0349i7XlSeM1zZEhtYJaEosRwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-K8ZsKewIM7apsVCHFjqSDA-1; Wed, 20 Nov 2019 06:49:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EBEC18C35B6
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 11:49:13 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ED6760BB2;
 Wed, 20 Nov 2019 11:48:58 +0000 (UTC)
Date: Wed, 20 Nov 2019 11:48:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] vhost-user-input: use free(elem) instead of g_free(elem)
Message-ID: <20191120114856.GG2785116@redhat.com>
References: <20191119111626.112206-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191119111626.112206-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: K8ZsKewIM7apsVCHFjqSDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 11:16:26AM +0000, Stefan Hajnoczi wrote:
> The virtqueue element returned by vu_queue_pop() is allocated using
> malloc(3) by virtqueue_alloc_element().  Use the matching free(3)
> function instead of glib's g_free().

Just as an FYI, since glib 2.46  g_malloc is hardcoded to use the
system allocator, so it is now guaranteed that g_malloc/malloc
and g_free/free are safely interchangable. I recently got this
clarified in the glib docs:

  https://gitlab.gnome.org/GNOME/glib/merge_requests/1099//diffs

QEMU mandates 2.48 so we are now safe in that regard

For readability/sanity sake I'd still suggest matching functions
but it is not a functional danger any more. Even when it was a
risk, that risk only arose if you called GLib's API for installing
a custom allocator callback which QEMU never did, so it was always
a non-issue.

Where this is most helpful is in exchanging allocated data with
3rd party libraries that don't use glib. We no longer have to
worry about dup'ing memory going in/out libraries not using
glib's allocators.

>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  contrib/vhost-user-input/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/m=
ain.c
> index 449fd2171a..ef4b7769f2 100644
> --- a/contrib/vhost-user-input/main.c
> +++ b/contrib/vhost-user-input/main.c
> @@ -77,7 +77,7 @@ static void vi_input_send(VuInput *vi, struct virtio_in=
put_event *event)
>          len =3D iov_from_buf(elem->in_sg, elem->in_num,
>                             0, &vi->queue[i].event, sizeof(virtio_input_e=
vent));
>          vu_queue_push(dev, vq, elem, len);
> -        g_free(elem);
> +        free(elem);
>      }
> =20
>      vu_queue_notify(&vi->dev.parent, vq);
> @@ -153,7 +153,7 @@ static void vi_handle_sts(VuDev *dev, int qidx)
>                           0, &event, sizeof(event));
>          vi_handle_status(vi, &event);
>          vu_queue_push(dev, vq, elem, len);
> -        g_free(elem);
> +        free(elem);
>      }
> =20
>      vu_queue_notify(&vi->dev.parent, vq);
> --=20
> 2.23.0
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


