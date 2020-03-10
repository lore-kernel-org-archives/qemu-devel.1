Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13575C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 05:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01752071B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 05:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/NHAy7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01752071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBXuE-0003NK-0I
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 01:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBXtP-0002vl-IX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 01:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBXtN-0006FR-Ru
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 01:57:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBXtN-0006Dk-Me
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 01:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583819843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iEFxqM8MmwOJFBBQ58mM8eo+ho69WiWu78RhWnIf0jA=;
 b=b/NHAy7+AQ5AUSnk2jA5IyL9/wB+wDgnME5T8clVwd0Waz7rBFOvTlXmOmu3v3dE1rspWZ
 X4cQ7WD4XV2hX9Hz6qYVYsnSW40FBKyBrkjfIugo1PXc8P0ZBnKCySYoKgRbEw0LBsyc/Y
 DOLdYXFRJNPN2g/QFEl6jEWbYeg41M8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-s4MK1UMkPWmzAVTLBPpjxQ-1; Tue, 10 Mar 2020 01:57:19 -0400
X-MC-Unique: s4MK1UMkPWmzAVTLBPpjxQ-1
Received: by mail-qt1-f199.google.com with SMTP id o10so8424583qtk.22
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 22:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/GNrOM4n1QSNxh0O1Ia2NcFPeiAJqNbkLgkAcyxedno=;
 b=KkJUZTxL42syDAM7RQ0cFN6icAVNzjkWlCQpKjGjCv0YIiX/GH/HcTMc5dHOOoZLHY
 8u2R39WNV9Uaj5L4dqAa1FaWhezrz/kyg92l6R54FO84NRFFNlET4CJxpXnDAdqLgMhY
 MmUwjMp5XRkWdCfYjD7wVLUnCpC7fl7sG+YjtP128jwsuiAzvUiJa72omM6SMLlADLSG
 3A1owFfkjqFej6BVsjprCjwCn009AgKjDehiWskwtyUYahjO7yPEbGz5cd/y5qaFpFgv
 ECIaZT6Z+PZXzPj87Xx6uxzQHVGt/9KU/KbwgGVKvp3NHZR10kJCWtk2Z4wtPgFrybOs
 8Wfg==
X-Gm-Message-State: ANhLgQ104zxYOb4pZVTqDKTH6hsQJBpn6tlglMGo0Y5EnulDV6azFpvC
 Jv+IBwoUJFYm3qT74IWOSL1u8CA+eDcbU7dvT2i2mPGChFZMjn487Cej9H2Cq2hWc0dNpZwz8wz
 haj6hWZJ8afDOkk4=
X-Received: by 2002:ac8:1194:: with SMTP id d20mr17578263qtj.243.1583819839392; 
 Mon, 09 Mar 2020 22:57:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtecnum9AsZmfqULcoyFRUFwNeX/xoSj2CogTX+Cjz4QUjak5OmNYdl+uvgw63nMnz1iccUdg==
X-Received: by 2002:ac8:1194:: with SMTP id d20mr17578242qtj.243.1583819839020; 
 Mon, 09 Mar 2020 22:57:19 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id i28sm24422870qtc.57.2020.03.09.22.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 22:57:17 -0700 (PDT)
Date: Tue, 10 Mar 2020 01:57:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH RESEND 2/3] vhost: fix a null pointer reference of
 vhost_log
Message-ID: <20200310014623-mutt-send-email-mst@kernel.org>
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-3-longpeng2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200224064219.1434-3-longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: weifuqiang@huawei.com, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, arei.gonglei@huawei.com,
 huangzhichao@huawei.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 02:42:18PM +0800, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
>=20
> vhost_log_alloc() may fails and returned pointer of log is null.
> However there're two places derefernce the return pointer without
> check.
>=20
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---
>  hw/virtio/vhost.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 9edfadc..c7ad6e5 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -219,6 +219,10 @@ static struct vhost_log *vhost_log_get(uint64_t size=
, bool share)
> =20
>      if (!log || log->size !=3D size) {
>          log =3D vhost_log_alloc(size, share);
> +        if (!log) {
> +            return NULL;
> +        }
> +
>          if (share) {
>              vhost_log_shm =3D log;
>          } else {
> @@ -270,10 +274,17 @@ static bool vhost_dev_log_is_shared(struct vhost_de=
v *dev)
> =20
>  static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t =
size)
>  {
> -    struct vhost_log *log =3D vhost_log_get(size, vhost_dev_log_is_share=
d(dev));
> -    uint64_t log_base =3D (uintptr_t)log->log;
> +    struct vhost_log *log;
> +    uint64_t log_base;
>      int r;
> =20
> +    log =3D vhost_log_get(size, vhost_dev_log_is_shared(dev));
> +    if (!log) {
> +        return;
> +    }
> +

I'm not sure silently failing like this is safe. Callers assume
log can be resized. What can be done? I suspect not much
beside exiting ...
Speaking of which, lots of other failures in log resizing
path seem to be silently ignored.
I guess we should propagate them, and fix callers to check
the return code?



