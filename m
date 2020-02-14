Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC143C3B1A1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA9E246A1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CoKq7pdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA9E246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2dtG-00080L-Qy
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 11:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j2dsW-000776-0P
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j2dsU-0001nb-Dl
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:31:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39145
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j2dsU-0001mb-7N
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581697901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFNutcjPdntpiMg0MocLuR6v3R2cWmVBHps5TV4jwOg=;
 b=CoKq7pdG4CHLrsYisuOkLtkrV6et59QzyI4CMjFxDRStVofZi7/IiLSEBJ7vYuqW3c9ydA
 r6B7+9RIso4vYuKQgM8lG9IFcZoITB/N0Jt7TU12eE1EAhFRg/h/jV83Y6PTODjFLET1ih
 2P8fZhiZe/kGEIG7SRR/WdPRXFCmrHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-Mp2NKZnvPrGgSfxbmFZ39g-1; Fri, 14 Feb 2020 11:31:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A33F1005514;
 Fri, 14 Feb 2020 16:31:36 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A96D060BEF;
 Fri, 14 Feb 2020 16:31:33 +0000 (UTC)
Date: Fri, 14 Feb 2020 16:31:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 06/14] migration/rdma: Transmit initial packet
Message-ID: <20200214163131.GL3283@work-vm>
References: <20200213093755.370-1-fengzhimin1@huawei.com>
 <20200213093755.370-7-fengzhimin1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200213093755.370-7-fengzhimin1@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Mp2NKZnvPrGgSfxbmFZ39g-1
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, jemmy858585@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zhimin Feng (fengzhimin1@huawei.com) wrote:
> Transmit initial packet through the multifd RDMA channels,
> so that we can identify the multifd channels.
>=20
> Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
> ---
>  migration/multifd.c | 33 +++++++++++++++++++++------------
>  migration/rdma.c    |  2 ++
>  2 files changed, 23 insertions(+), 12 deletions(-)
>=20
> diff --git a/migration/multifd.c b/migration/multifd.c
> index acdfd3d5b3..a57d7a2eab 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -483,6 +483,13 @@ void multifd_send_sync_main(QEMUFile *f)
>  static void *multifd_rdma_send_thread(void *opaque)
>  {
>      MultiFDSendParams *p =3D opaque;
> +    Error *local_err =3D NULL;
> +
> +    trace_multifd_send_thread_start(p->id);
> +
> +    if (multifd_send_initial_packet(p, &local_err) < 0) {
> +        goto out;
> +    }
> =20
>      while (true) {
>          qemu_mutex_lock(&p->mutex);
> @@ -494,6 +501,12 @@ static void *multifd_rdma_send_thread(void *opaque)
>          qemu_sem_wait(&p->sem);
>      }
> =20
> +out:
> +    if (local_err) {
> +        trace_multifd_send_error(p->id);
> +        multifd_send_terminate_threads(local_err);
> +    }
> +
>      qemu_mutex_lock(&p->mutex);
>      p->running =3D false;
>      qemu_mutex_unlock(&p->mutex);
> @@ -964,18 +977,14 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Erro=
r **errp)
>      Error *local_err =3D NULL;
>      int id;
> =20
> -    if (migrate_use_rdma()) {
> -        id =3D multifd_recv_state->count;
> -    } else {
> -        id =3D multifd_recv_initial_packet(ioc, &local_err);
> -        if (id < 0) {
> -            multifd_recv_terminate_threads(local_err);
> -            error_propagate_prepend(errp, local_err,
> -                    "failed to receive packet"
> -                    " via multifd channel %d: ",
> -                    atomic_read(&multifd_recv_state->count));
> -            return false;
> -        }
> +    id =3D multifd_recv_initial_packet(ioc, &local_err);
> +    if (id < 0) {
> +        multifd_recv_terminate_threads(local_err);
> +        error_propagate_prepend(errp, local_err,
> +                "failed to receive packet"
> +                " via multifd channel %d: ",
> +                atomic_read(&multifd_recv_state->count));
> +        return false;

I'm confused; hasn't that just undone part of patch 5 ?

Dave

>      }
> =20
>      trace_multifd_recv_new_channel(id);
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 48615fcaad..2f1e69197f 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -4003,6 +4003,8 @@ int multifd_channel_rdma_connect(void *opaque)
>          goto out;
>      }
> =20
> +    p->c =3D QIO_CHANNEL(getQIOChannel(p->file));
> +
>  out:
>      if (local_err) {
>          trace_multifd_send_error(p->id);
> --=20
> 2.19.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


