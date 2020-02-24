Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EC0C35641
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 04:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D319206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 04:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D319206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j655b-0008EB-HP
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 23:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j654v-0007mz-LT
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 23:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j654t-0004ue-SI
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 23:10:45 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2449 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1j654t-0004t3-A3
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 23:10:43 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 8862CA2AB6E9EC2E0841;
 Mon, 24 Feb 2020 12:10:38 +0800 (CST)
Received: from dggeme708-chm.china.huawei.com (10.1.199.104) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 24 Feb 2020 12:10:38 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme708-chm.china.huawei.com (10.1.199.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 24 Feb 2020 12:10:37 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Mon, 24 Feb 2020 12:10:37 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: RE: [PATCH 3/3] COLO: Optimize memory back-up process
Thread-Topic: [PATCH 3/3] COLO: Optimize memory back-up process
Thread-Index: AQHV5TCV+wMf+byK4kaFhKpkDIuDMagj5ZKAgAXfx4A=
Date: Mon, 24 Feb 2020 04:10:37 +0000
Message-ID: <f0d2519fb1a04301a102cd3e8d2bba30@huawei.com>
References: <20200217012049.22988-1-zhang.zhanghailiang@huawei.com>
 <20200217012049.22988-4-zhang.zhanghailiang@huawei.com>
 <20200220182447.GF2836@work-vm>
In-Reply-To: <20200220182447.GF2836@work-vm>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.214.142]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.187
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
Cc: "danielcho@qnap.com" <danielcho@qnap.com>,
 "chen.zhang@intel.com" <chen.zhang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Dave,

> -----Original Message-----
> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> Sent: Friday, February 21, 2020 2:25 AM
> To: Zhanghailiang <zhang.zhanghailiang@huawei.com>
> Cc: qemu-devel@nongnu.org; quintela@redhat.com; chen.zhang@intel.com;
> danielcho@qnap.com
> Subject: Re: [PATCH 3/3] COLO: Optimize memory back-up process
>=20
> * Hailiang Zhang (zhang.zhanghailiang@huawei.com) wrote:
> > This patch will reduce the downtime of VM for the initial process,
> > Privously, we copied all these memory in preparing stage of COLO
> > while we need to stop VM, which is a time-consuming process.
> > Here we optimize it by a trick, back-up every page while in migration
> > process while COLO is enabled, though it affects the speed of the
> > migration, but it obviously reduce the downtime of back-up all SVM'S
> > memory in COLO preparing stage.
> >
> > Signed-off-by: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
>=20
> OK, I think this is right, but it took me quite a while to understand,
> I think one of the comments below might not be right:
>=20

> > ---
> >  migration/colo.c |  3 +++
> >  migration/ram.c  | 35 +++++++++++++++++++++++++++--------
> >  migration/ram.h  |  1 +
> >  3 files changed, 31 insertions(+), 8 deletions(-)
> >
> > diff --git a/migration/colo.c b/migration/colo.c
> > index d30c6bc4ad..febf010571 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -26,6 +26,7 @@
> >  #include "qemu/main-loop.h"
> >  #include "qemu/rcu.h"
> >  #include "migration/failover.h"
> > +#include "migration/ram.h"
> >  #ifdef CONFIG_REPLICATION
> >  #include "replication.h"
> >  #endif
> > @@ -906,6 +907,8 @@ void *colo_process_incoming_thread(void
> *opaque)
> >       */
> >      qemu_file_set_blocking(mis->from_src_file, true);
> >
> > +    colo_incoming_start_dirty_log();
> > +
> >      bioc =3D qio_channel_buffer_new(COLO_BUFFER_BASE_SIZE);
> >      fb =3D qemu_fopen_channel_input(QIO_CHANNEL(bioc));
> >      object_unref(OBJECT(bioc));
> > diff --git a/migration/ram.c b/migration/ram.c
> > index ed23ed1c7c..24a8aa3527 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2986,7 +2986,6 @@ int colo_init_ram_cache(void)
> >                  }
> >                  return -errno;
> >              }
> > -            memcpy(block->colo_cache, block->host,
> block->used_length);
> >          }
> >      }
> >
> > @@ -3005,12 +3004,16 @@ int colo_init_ram_cache(void)
> >              bitmap_set(block->bmap, 0, pages);
> >          }
> >      }
> > +
> > +    return 0;
> > +}
> > +
> > +void colo_incoming_start_dirty_log(void)
> > +{
> >      ram_state =3D g_new0(RAMState, 1);
> >      ram_state->migration_dirty_pages =3D 0;
> >      qemu_mutex_init(&ram_state->bitmap_mutex);
> >      memory_global_dirty_log_start();
> > -
> > -    return 0;
> >  }
> >
> >  /* It is need to hold the global lock to call this helper */
> > @@ -3348,7 +3351,7 @@ static int ram_load_precopy(QEMUFile *f)
> >
> >      while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
> >          ram_addr_t addr, total_ram_bytes;
> > -        void *host =3D NULL;
> > +        void *host =3D NULL, *host_bak =3D NULL;
> >          uint8_t ch;
> >
> >          /*
> > @@ -3378,13 +3381,26 @@ static int ram_load_precopy(QEMUFile *f)
> >          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
> >                       RAM_SAVE_FLAG_COMPRESS_PAGE |
> RAM_SAVE_FLAG_XBZRLE)) {
> >              RAMBlock *block =3D ram_block_from_stream(f, flags);
> > -
> >              /*
> > -             * After going into COLO, we should load the Page into
> colo_cache.
> > +             * After going into COLO, we should load the Page into
> colo_cache
> > +             * NOTE: We need to keep a copy of SVM's ram in
> colo_cache.
> > +             * Privously, we copied all these memory in preparing stag=
e
> of COLO
> > +             * while we need to stop VM, which is a time-consuming
> process.
> > +             * Here we optimize it by a trick, back-up every page whil=
e
> in
> > +             * migration process while COLO is enabled, though it
> affects the
> > +             * speed of the migration, but it obviously reduce the
> downtime of
> > +             * back-up all SVM'S memory in COLO preparing stage.
> >               */
> > -            if (migration_incoming_in_colo_state()) {
> > +            if (migration_incoming_colo_enabled()) {
> >                  host =3D colo_cache_from_block_offset(block, addr);
> > -            } else {
> > +                /*
> > +                 * After going into COLO, load the Page into
> colo_cache.
> > +                 */
> > +                if (!migration_incoming_in_colo_state()) {
> > +                    host_bak =3D host;
> > +                }
> > +            }
> > +            if (!migration_incoming_in_colo_state()) {
> >                  host =3D host_from_ram_block_offset(block, addr);
>=20
> So this works out as quite complicated:
>    a) In normal migration we do the last one and just set:
>          host =3D host_from_ram_block_offset(block, addr);
>          host_bak =3D NULL
>=20
>    b) At the start, when colo_enabled, but !in_colo_state
>          host =3D colo_cache
>          host_bak =3D host
>          host =3D host_from_ram_block_offset
>=20
>    c) in_colo_state
>          host =3D colo_cache
>          host_bak =3D NULL
>=20
>=20
> (b) is pretty confusing, setting host twice; can't we tidy that up?
>=20
> Also, that last comment 'After going into COLO' I think is really
>   'Before COLO state, copy from ram into cache'
>=20

The code logic here is not good, I have fixed this in V2 like this :)

+            host =3D host_from_ram_block_offset(block, addr);
             /*
-             * After going into COLO, we should load the Page into colo_ca=
che.
+             * After going into COLO stage, we should not load the page
+             * into SVM's memory diretly, we put them into colo_cache firs=
tly.
+             * NOTE: We need to keep a copy of SVM's ram in colo_cache.
+             * Privously, we copied all these memory in preparing stage of=
 COLO
+             * while we need to stop VM, which is a time-consuming process=
.
+             * Here we optimize it by a trick, back-up every page while in
+             * migration process while COLO is enabled, though it affects =
the
+             * speed of the migration, but it obviously reduce the downtim=
e of
+             * back-up all SVM'S memory in COLO preparing stage.
              */
-            if (migration_incoming_in_colo_state()) {
-                host =3D colo_cache_from_block_offset(block, addr);
-            } else {
-                host =3D host_from_ram_block_offset(block, addr);
+            if (migration_incoming_colo_enabled()) {
+                if (migration_incoming_in_colo_state()) {
+                    /* In COLO stage, put all pages into cache temporarily=
 */
+                    host =3D colo_cache_from_block_offset(block, addr);
+                } else {
+                   /*
+                    * In migration stage but before COLO stage,
+                    * Put all pages into both cache and SVM's memory.
+                    */
+                    host_bak =3D colo_cache_from_block_offset(block, addr)=
;
+                }


Thanks,
Hailiang

> Dave
>=20
> >              }
> >              if (!host) {
> > @@ -3506,6 +3522,9 @@ static int ram_load_precopy(QEMUFile *f)
> >          if (!ret) {
> >              ret =3D qemu_file_get_error(f);
> >          }
> > +        if (!ret && host_bak && host) {
> > +            memcpy(host_bak, host, TARGET_PAGE_SIZE);
> > +        }
> >      }
> >
> >      ret |=3D wait_for_decompress_done();
> > diff --git a/migration/ram.h b/migration/ram.h
> > index a553d40751..5ceaff7cb4 100644
> > --- a/migration/ram.h
> > +++ b/migration/ram.h
> > @@ -66,5 +66,6 @@ int ram_dirty_bitmap_reload(MigrationState *s,
> RAMBlock *rb);
> >  /* ram cache */
> >  int colo_init_ram_cache(void);
> >  void colo_release_ram_cache(void);
> > +void colo_incoming_start_dirty_log(void);
> >
> >  #endif
> > --
> > 2.21.0
> >
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


