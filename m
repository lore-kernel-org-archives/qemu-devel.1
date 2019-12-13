Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E42C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30FE22073D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAwlYFAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FE22073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifibh-0002B2-9e
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 05:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifiZ1-00075j-V0
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifiZ0-0003Ww-U1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:52:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42217
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifiZ0-0003W4-Py
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576234370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwGE0Z6BWevny2p+v8p6kGq3+dllna6us1JYKE6ldNY=;
 b=EAwlYFAGOSNj16/ZMqLAIeFhIw8mZdDAcQuI/cw5Jqm+fcpCLAtpGx+oTk4OyohJpgm/QJ
 BxhOBCDGSWHh2+j1TrK3MNseSx0I8m5cqWTFHruxLOZlyxOr3M/ocxrHZWPrpxlh4nL/ga
 FzwyIKpp6xgiDoUPrvDsZoUOIKXtXmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-7Ga1f-YaNSaYC3p_LqPK2g-1; Fri, 13 Dec 2019 05:52:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FC071005502
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 10:52:48 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF43B5D9C9;
 Fri, 13 Dec 2019 10:52:42 +0000 (UTC)
Date: Fri, 13 Dec 2019 10:52:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] vhost-user-fs: remove "vhostfd" property
Message-ID: <20191213105240.GA7302@work-vm>
References: <20191116112016.14872-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191116112016.14872-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7Ga1f-YaNSaYC3p_LqPK2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> The property doesn't make much sense for a vhost-user device.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Queued for virtiofs

> ---
>  hw/virtio/vhost-user-fs.c         | 1 -
>  include/hw/virtio/vhost-user-fs.h | 1 -
>  2 files changed, 2 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> index f0df7f4746..ca0b7fc9de 100644
> --- a/hw/virtio/vhost-user-fs.c
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -263,7 +263,6 @@ static Property vuf_properties[] =3D {
>      DEFINE_PROP_UINT16("num-request-queues", VHostUserFS,
>                         conf.num_request_queues, 1),
>      DEFINE_PROP_UINT16("queue-size", VHostUserFS, conf.queue_size, 128),
> -    DEFINE_PROP_STRING("vhostfd", VHostUserFS, conf.vhostfd),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-=
user-fs.h
> index 539885b458..9ff1bdb7cf 100644
> --- a/include/hw/virtio/vhost-user-fs.h
> +++ b/include/hw/virtio/vhost-user-fs.h
> @@ -28,7 +28,6 @@ typedef struct {
>      char *tag;
>      uint16_t num_request_queues;
>      uint16_t queue_size;
> -    char *vhostfd;
>  } VHostUserFSConf;
> =20
>  typedef struct {
> --=20
> 2.24.0
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


