Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC795C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 18:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB95324673
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 18:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/7n5BSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB95324673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4qok-0007cO-Rm
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 13:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j4qo9-00078l-Rl
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j4qo8-0000PV-6D
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:44:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27998
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j4qo8-0000NW-1H
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582224259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8M+ixvzlINUfIxtCpyzZw+dd9KssCKbNOEHJoM40fWk=;
 b=X/7n5BSmLjr/6BnncnahoCyqC9RFp9y6Ooyt71Amr4J9rvBEliqv/ouEE7TfnrH5frVhyR
 OdrLsrY+/Z6u9HdZhOWlu687V98YqL6yyJjh+zN7DpIn5VzkS4wbY6B6otRFchgvOlADbW
 OEhthvrUSLdJ/VGSeudBN0OeTvP3lkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-cbyGJ_gmOJCz-m8GetwWbw-1; Thu, 20 Feb 2020 13:24:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57F4B800D48;
 Thu, 20 Feb 2020 18:24:52 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07B685C114;
 Thu, 20 Feb 2020 18:24:49 +0000 (UTC)
Date: Thu, 20 Feb 2020 18:24:47 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Subject: Re: [PATCH 3/3] COLO: Optimize memory back-up process
Message-ID: <20200220182447.GF2836@work-vm>
References: <20200217012049.22988-1-zhang.zhanghailiang@huawei.com>
 <20200217012049.22988-4-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200217012049.22988-4-zhang.zhanghailiang@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: cbyGJ_gmOJCz-m8GetwWbw-1
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
Cc: danielcho@qnap.com, chen.zhang@intel.com, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Hailiang Zhang (zhang.zhanghailiang@huawei.com) wrote:
> This patch will reduce the downtime of VM for the initial process,
> Privously, we copied all these memory in preparing stage of COLO
> while we need to stop VM, which is a time-consuming process.
> Here we optimize it by a trick, back-up every page while in migration
> process while COLO is enabled, though it affects the speed of the
> migration, but it obviously reduce the downtime of back-up all SVM'S
> memory in COLO preparing stage.
>=20
> Signed-off-by: Hailiang Zhang <zhang.zhanghailiang@huawei.com>

OK, I think this is right, but it took me quite a while to understand,
I think one of the comments below might not be right:

> ---
>  migration/colo.c |  3 +++
>  migration/ram.c  | 35 +++++++++++++++++++++++++++--------
>  migration/ram.h  |  1 +
>  3 files changed, 31 insertions(+), 8 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c
> index d30c6bc4ad..febf010571 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -26,6 +26,7 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/rcu.h"
>  #include "migration/failover.h"
> +#include "migration/ram.h"
>  #ifdef CONFIG_REPLICATION
>  #include "replication.h"
>  #endif
> @@ -906,6 +907,8 @@ void *colo_process_incoming_thread(void *opaque)
>       */
>      qemu_file_set_blocking(mis->from_src_file, true);
> =20
> +    colo_incoming_start_dirty_log();
> +
>      bioc =3D qio_channel_buffer_new(COLO_BUFFER_BASE_SIZE);
>      fb =3D qemu_fopen_channel_input(QIO_CHANNEL(bioc));
>      object_unref(OBJECT(bioc));
> diff --git a/migration/ram.c b/migration/ram.c
> index ed23ed1c7c..24a8aa3527 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2986,7 +2986,6 @@ int colo_init_ram_cache(void)
>                  }
>                  return -errno;
>              }
> -            memcpy(block->colo_cache, block->host, block->used_length);
>          }
>      }
> =20
> @@ -3005,12 +3004,16 @@ int colo_init_ram_cache(void)
>              bitmap_set(block->bmap, 0, pages);
>          }
>      }
> +
> +    return 0;
> +}
> +
> +void colo_incoming_start_dirty_log(void)
> +{
>      ram_state =3D g_new0(RAMState, 1);
>      ram_state->migration_dirty_pages =3D 0;
>      qemu_mutex_init(&ram_state->bitmap_mutex);
>      memory_global_dirty_log_start();
> -
> -    return 0;
>  }
> =20
>  /* It is need to hold the global lock to call this helper */
> @@ -3348,7 +3351,7 @@ static int ram_load_precopy(QEMUFile *f)
> =20
>      while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
>          ram_addr_t addr, total_ram_bytes;
> -        void *host =3D NULL;
> +        void *host =3D NULL, *host_bak =3D NULL;
>          uint8_t ch;
> =20
>          /*
> @@ -3378,13 +3381,26 @@ static int ram_load_precopy(QEMUFile *f)
>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
>                       RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)=
) {
>              RAMBlock *block =3D ram_block_from_stream(f, flags);
> -
>              /*
> -             * After going into COLO, we should load the Page into colo_=
cache.
> +             * After going into COLO, we should load the Page into colo_=
cache
> +             * NOTE: We need to keep a copy of SVM's ram in colo_cache.
> +             * Privously, we copied all these memory in preparing stage =
of COLO
> +             * while we need to stop VM, which is a time-consuming proce=
ss.
> +             * Here we optimize it by a trick, back-up every page while =
in
> +             * migration process while COLO is enabled, though it affect=
s the
> +             * speed of the migration, but it obviously reduce the downt=
ime of
> +             * back-up all SVM'S memory in COLO preparing stage.
>               */
> -            if (migration_incoming_in_colo_state()) {
> +            if (migration_incoming_colo_enabled()) {
>                  host =3D colo_cache_from_block_offset(block, addr);
> -            } else {
> +                /*
> +                 * After going into COLO, load the Page into colo_cache.
> +                 */
> +                if (!migration_incoming_in_colo_state()) {
> +                    host_bak =3D host;
> +                }
> +            }
> +            if (!migration_incoming_in_colo_state()) {
>                  host =3D host_from_ram_block_offset(block, addr);

So this works out as quite complicated:
   a) In normal migration we do the last one and just set:
         host =3D host_from_ram_block_offset(block, addr);
         host_bak =3D NULL

   b) At the start, when colo_enabled, but !in_colo_state
         host =3D colo_cache
         host_bak =3D host
         host =3D host_from_ram_block_offset

   c) in_colo_state
         host =3D colo_cache
         host_bak =3D NULL


(b) is pretty confusing, setting host twice; can't we tidy that up?

Also, that last comment 'After going into COLO' I think is really
  'Before COLO state, copy from ram into cache'

Dave

>              }
>              if (!host) {
> @@ -3506,6 +3522,9 @@ static int ram_load_precopy(QEMUFile *f)
>          if (!ret) {
>              ret =3D qemu_file_get_error(f);
>          }
> +        if (!ret && host_bak && host) {
> +            memcpy(host_bak, host, TARGET_PAGE_SIZE);
> +        }
>      }
> =20
>      ret |=3D wait_for_decompress_done();
> diff --git a/migration/ram.h b/migration/ram.h
> index a553d40751..5ceaff7cb4 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -66,5 +66,6 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock=
 *rb);
>  /* ram cache */
>  int colo_init_ram_cache(void);
>  void colo_release_ram_cache(void);
> +void colo_incoming_start_dirty_log(void);
> =20
>  #endif
> --=20
> 2.21.0
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


