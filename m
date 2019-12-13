Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D157C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894B22465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcNMFPU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894B22465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifmUp-00070Z-PG
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 10:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifmTz-0006Vi-6K
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifmTt-0007jv-1M
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:03:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40802
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifmTs-0007hX-T7
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 10:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576249428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGY7qKX7AQigBv8N2a3MrzcqR+4xPBU4YHCK/lbRjSY=;
 b=AcNMFPU/TDOQK68sU2DGAi6aRr1+ZoD7dteIg8FMSJwK37GRzfdZpJLPsUyA/MF6A7eW4e
 oX9KmTDUYRyogcVeRcJhsHVo7Xb4pwFOkMT9zFKhNHoazJ/R28BqDK/4XmcnVJSj3rPdoK
 7dkC/Peixsxa26JRqEzL+kt3/K1sWZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-nn90rs3NMku3cY7Zu5vxGw-1; Fri, 13 Dec 2019 10:03:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33F2C593A1;
 Fri, 13 Dec 2019 15:03:45 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15C3410013D9;
 Fri, 13 Dec 2019 15:03:43 +0000 (UTC)
Date: Fri, 13 Dec 2019 15:03:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, quintela@redhat.com,
 chen.zhang@intel.com
Subject: Re: [PATCH] colo: fix return without releasing RCU
Message-ID: <20191213150341.GG3713@work-vm>
References: <1576246112-23406-2-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1576246112-23406-2-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: nn90rs3NMku3cY7Zu5vxGw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> Use WITH_RCU_READ_LOCK_GUARD to avoid exiting colo_init_ram_cache
> without releasing RCU.
>=20
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 7dd7f81..8d7c015 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3891,26 +3891,27 @@ int colo_init_ram_cache(void)
>  {
>      RAMBlock *block;
> =20
> -    rcu_read_lock();
> -    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> -        block->colo_cache =3D qemu_anon_ram_alloc(block->used_length,
> -                                                NULL,
> -                                                false);
> -        if (!block->colo_cache) {
> -            error_report("%s: Can't alloc memory for COLO cache of block=
 %s,"
> -                         "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
> -                         block->used_length);
> -            RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> -                if (block->colo_cache) {
> -                    qemu_anon_ram_free(block->colo_cache, block->used_le=
ngth);
> -                    block->colo_cache =3D NULL;
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +            block->colo_cache =3D qemu_anon_ram_alloc(block->used_length=
,
> +                                                    NULL,
> +                                                    false);
> +            if (!block->colo_cache) {
> +                error_report("%s: Can't alloc memory for COLO cache of b=
lock %s,"
> +                             "size 0x" RAM_ADDR_FMT, __func__, block->id=
str,
> +                             block->used_length);
> +                RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> +                    if (block->colo_cache) {
> +                        qemu_anon_ram_free(block->colo_cache, block->use=
d_length);
> +                        block->colo_cache =3D NULL;
> +                    }
>                  }
> +                return -errno;
>              }
> -            return -errno;
> +            memcpy(block->colo_cache, block->host, block->used_length);
>          }
> -        memcpy(block->colo_cache, block->host, block->used_length);
>      }
> -    rcu_read_unlock();
> +
>      /*
>      * Record the dirty pages that sent by PVM, we use this dirty bitmap =
together
>      * with to decide which page in cache should be flushed into SVM's RA=
M. Here
> --=20
> 1.8.3.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


