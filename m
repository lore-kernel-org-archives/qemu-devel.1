Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BD7C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 20:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A4A222C3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 20:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8elG9tA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A4A222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irot2-0006zy-Vv
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 15:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1irokI-0001cp-LJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1irokE-0007AS-8C
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:54:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38476
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1irokE-0007A8-2r
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579118065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BvGd84JFW0WAaFH0CMmrtYBvCuDoUjxnRK30ACHAi0Q=;
 b=A8elG9tAbLFElyTkVdGf6b1J3KtU7Q7cxeXm4oN4kUkkoYEDo091ltlnBTMPxIkeNTq8YC
 d4ahZE8EHP433NWM9IyBeO7m89NYWs72WyPTTf7Na+Gu2vfWoXD1fF9La5xGpdmxyTWDUc
 UilQcGwl4iGFOEJ74gwY0TU3IoHEhc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-fA0exs2rPIWoNLWpWpud1A-1; Wed, 15 Jan 2020 14:54:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4A87800D41;
 Wed, 15 Jan 2020 19:54:22 +0000 (UTC)
Received: from work-vm (ovpn-117-231.ams2.redhat.com [10.36.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3C9460BE0;
 Wed, 15 Jan 2020 19:54:20 +0000 (UTC)
Date: Wed, 15 Jan 2020 19:54:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 05/12] migration/rdma: Create the multiRDMA channels
Message-ID: <20200115195417.GK3811@work-vm>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-6-fengzhimin1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200109045922.904-6-fengzhimin1@huawei.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: fA0exs2rPIWoNLWpWpud1A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> From: fengzhimin <fengzhimin1@huawei.com>
>=20
> In both sides. We still don't transmit anything through them,
> and we only build the RDMA connections.
>=20
> Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
> ---
>  migration/rdma.c | 253 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 223 insertions(+), 30 deletions(-)
>=20
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 992e5abfed..5b780bef36 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -403,6 +403,10 @@ typedef struct {
>      char *name;
>      /* channel thread id */
>      QemuThread thread;
> +    /* RDMAContext channel */
> +    RDMAContext *rdma;
> +    /* communication channel */
> +    QEMUFile *file;
>      /* sem where to wait for more work */
>      QemuSemaphore sem;
>      /* this mutex protects the following parameters */
> @@ -429,6 +433,10 @@ typedef struct {
>      char *name;
>      /* channel thread id */
>      QemuThread thread;
> +    /* RDMAContext channel */
> +    RDMAContext *rdma;
> +    /* communication channel */
> +    QEMUFile *file;
>      /* sem where to wait for more work */
>      QemuSemaphore sem;
>      /* this mutex protects the following parameters */
> @@ -3417,6 +3425,27 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>          qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migr=
ation,
>                              NULL,
>                              (void *)(intptr_t)rdma->return_path);
> +    } else if (migrate_use_multiRDMA()) {
> +        int thread_count;
> +        int i;
> +        RDMAContext *multi_rdma =3D NULL;
> +        thread_count =3D migrate_multiRDMA_channels();
> +        /* create the multi Thread RDMA channels */
> +        for (i =3D 0; i < thread_count; i++) {
> +            if (multiRDMA_recv_state->params[i].rdma->cm_id =3D=3D NULL)=
 {
> +                multi_rdma =3D multiRDMA_recv_state->params[i].rdma;
> +                break;
> +            }
> +        }
> +
> +        if (multi_rdma) {
> +            qemu_set_fd_handler(rdma->channel->fd,
> +                                rdma_accept_incoming_migration,
> +                                NULL, (void *)(intptr_t)multi_rdma);
> +        } else {
> +            qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
> +                                NULL, rdma);
> +        }
>      } else {
>          qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
>                              NULL, rdma);
> @@ -4029,6 +4058,58 @@ static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma=
, const char *mode)
>      return rioc->file;
>  }
> =20
> +static void *multiRDMA_recv_thread(void *opaque)
> +{
> +    MultiRDMARecvParams *p =3D opaque;
> +
> +    while (true) {
> +        qemu_mutex_lock(&p->mutex);
> +        if (p->quit) {
> +            qemu_mutex_unlock(&p->mutex);
> +            break;
> +        }
> +        qemu_mutex_unlock(&p->mutex);
> +        qemu_sem_wait(&p->sem);
> +    }
> +
> +    qemu_mutex_lock(&p->mutex);
> +    p->running =3D false;
> +    qemu_mutex_unlock(&p->mutex);
> +
> +    return NULL;
> +}
> +
> +static void multiRDMA_recv_new_channel(QEMUFile *f, int id)
> +{
> +    MultiRDMARecvParams *p;
> +    Error *local_err =3D NULL;
> +
> +    p =3D &multiRDMA_recv_state->params[id];
> +    if (p->file !=3D NULL) {
> +        error_setg(&local_err,
> +                   "multiRDMA: received id '%d' already setup'", id);
> +        return ;
> +    }
> +    p->file =3D f;
> +
> +    qemu_thread_create(&p->thread, p->name, multiRDMA_recv_thread, p,
> +                       QEMU_THREAD_JOINABLE);
> +    atomic_inc(&multiRDMA_recv_state->count);
> +}
> +
> +static void migration_multiRDMA_process_incoming(QEMUFile *f, RDMAContex=
t *rdma)
> +{
> +    MigrationIncomingState *mis =3D migration_incoming_get_current();
> +
> +    if (!mis->from_src_file) {
> +        rdma->migration_started_on_destination =3D 1;
> +        migration_incoming_setup(f);
> +        migration_incoming_process();
> +    } else {
> +        multiRDMA_recv_new_channel(f, multiRDMA_recv_state->count);
> +    }
> +}
> +
>  static void rdma_accept_incoming_migration(void *opaque)
>  {
>      RDMAContext *rdma =3D opaque;
> @@ -4057,29 +4138,13 @@ static void rdma_accept_incoming_migration(void *=
opaque)
>          return;
>      }
> =20
> -    rdma->migration_started_on_destination =3D 1;
> -    migration_fd_process_incoming(f);
> -}
> -
> -static void *multiRDMA_recv_thread(void *opaque)
> -{
> -    MultiRDMARecvParams *p =3D opaque;
> -
> -    while (true) {
> -        qemu_mutex_lock(&p->mutex);
> -        if (p->quit) {
> -            qemu_mutex_unlock(&p->mutex);
> -            break;
> -        }
> -        qemu_mutex_unlock(&p->mutex);
> -        qemu_sem_wait(&p->sem);
> +    if (migrate_use_multiRDMA()) {
> +        /* build the multiRDMA channels */
> +        migration_multiRDMA_process_incoming(f, rdma);
> +    } else {
> +        rdma->migration_started_on_destination =3D 1;
> +        migration_fd_process_incoming(f);
>      }
> -
> -    qemu_mutex_lock(&p->mutex);
> -    p->running =3D false;
> -    qemu_mutex_unlock(&p->mutex);
> -
> -    return NULL;
>  }
> =20
>  static int multiRDMA_load_setup(const char *host_port, RDMAContext *rdma=
,
> @@ -4087,6 +4152,7 @@ static int multiRDMA_load_setup(const char *host_po=
rt, RDMAContext *rdma,
>  {
>      uint8_t i;
>      int thread_count;
> +    int idx;
> =20
>      thread_count =3D migrate_multiRDMA_channels();
>      if (multiRDMA_recv_state =3D=3D NULL) {
> @@ -4099,15 +4165,21 @@ static int multiRDMA_load_setup(const char *host_=
port, RDMAContext *rdma,
>          for (i =3D 0; i < thread_count; i++) {
>              MultiRDMARecvParams *p =3D &multiRDMA_recv_state->params[i];
> =20
> +            p->rdma =3D qemu_rdma_data_init(host_port, errp);
> +            for (idx =3D 0; idx < RDMA_WRID_MAX; idx++) {
> +                p->rdma->wr_data[idx].control_len =3D 0;
> +                p->rdma->wr_data[idx].control_curr =3D NULL;
> +            }
> +            /* the CM channel and CM id is shared */
> +            p->rdma->channel =3D rdma->channel;
> +            p->rdma->listen_id =3D rdma->listen_id;
> +
>              qemu_mutex_init(&p->mutex);
>              qemu_sem_init(&p->sem, 0);
>              p->quit =3D false;
>              p->id =3D i;
>              p->running =3D true;
>              p->name =3D g_strdup_printf("multiRDMARecv_%d", i);
> -            qemu_thread_create(&p->thread, p->name, multiRDMA_recv_threa=
d,
> -                               p, QEMU_THREAD_JOINABLE);
> -            atomic_inc(&multiRDMA_recv_state->count);
>          }
>      }
> =20
> @@ -4155,6 +4227,7 @@ void rdma_start_incoming_migration(const char *host=
_port, Error **errp)
>          qemu_rdma_return_path_dest_init(rdma_return_path, rdma);
>      }
> =20
> +    /* initialize the RDMAContext for multiRDMA */
>      if (migrate_use_multiRDMA()) {
>          if (multiRDMA_load_setup(host_port, rdma, &local_err) !=3D 0) {
>              ERROR(errp, "init multiRDMA failure!");
> @@ -4193,10 +4266,29 @@ static void *multiRDMA_send_thread(void *opaque)
>      return NULL;
>  }
> =20
> +static void multiRDMA_send_new_channel(QEMUFile *f, int id)
> +{
> +    MultiRDMASendParams *p;
> +    Error *local_err =3D NULL;
> +
> +    p =3D &multiRDMA_send_state->params[id];
> +    if (p->file !=3D NULL) {
> +        error_setg(&local_err,
> +                   "multiRDMA: send id '%d' already setup'", id);
> +        return ;
> +    }
> +    p->file =3D f;
> +
> +    qemu_thread_create(&p->thread, p->name, multiRDMA_send_thread,
> +                       p, QEMU_THREAD_JOINABLE);
> +    atomic_inc(&multiRDMA_send_state->count);
> +}
> +
>  static int multiRDMA_save_setup(const char *host_port, Error **errp)
>  {
>      int thread_count;
>      uint8_t i;
> +    int ret;
> =20
>      thread_count =3D migrate_multiRDMA_channels();
>      multiRDMA_send_state =3D g_malloc0(sizeof(*multiRDMA_send_state));
> @@ -4207,6 +4299,27 @@ static int multiRDMA_save_setup(const char *host_p=
ort, Error **errp)
> =20
>      for (i =3D 0; i < thread_count; i++) {
>          MultiRDMASendParams *p =3D &multiRDMA_send_state->params[i];
> +        QEMUFile *f =3D NULL;
> +
> +        p->rdma =3D qemu_rdma_data_init(host_port, errp);
> +        if (p->rdma =3D=3D NULL) {
> +            ERROR(errp, "init RDMA data failure for multi channel %d!", =
i);
> +            goto err;
> +        }
> +
> +        ret =3D qemu_rdma_source_init(p->rdma, migrate_use_rdma_pin_all(=
), errp);
> +        if (ret) {
> +            ERROR(errp, "init RDMA source failure for multi channel %d!"=
, i);
> +            goto err;
> +        }
> +
> +        ret =3D qemu_rdma_connect(p->rdma, errp);
> +        if (ret) {
> +            ERROR(errp, "connect multi channel %d failure!", i);
> +            goto err;
> +        }
> +
> +        f =3D qemu_fopen_rdma(multiRDMA_send_state->params[i].rdma, "wb"=
);
>          qemu_mutex_init(&p->mutex);
>          qemu_sem_init(&p->sem, 0);
>          p->quit =3D false;
> @@ -4214,12 +4327,20 @@ static int multiRDMA_save_setup(const char *host_=
port, Error **errp)
>          p->running =3D true;
>          p->name =3D g_strdup_printf("multiRDMASend_%d", i);
> =20
> -        qemu_thread_create(&p->thread, p->name, multiRDMA_send_thread, p=
,
> -                           QEMU_THREAD_JOINABLE);
> -        atomic_inc(&multiRDMA_send_state->count);
> +        multiRDMA_send_new_channel(f, i);
>      }
> =20
>      return 0;
> +
> +err:
> +    for (i =3D 0; i < thread_count; i++) {
> +        g_free(multiRDMA_send_state->params[i].rdma);
> +    }
> +
> +    g_free(multiRDMA_send_state->params);
> +    g_free(multiRDMA_send_state);
> +
> +    return -1;

This err path doesn't look enough - don't you have to do the equivalent
of qemu_rdma_cleanup for each channel that did succesfully connect,
and then also the one that's failed (perhaps after the first step)?

>  }
> =20
>  static void multiRDMA_send_terminate_threads(void)
> @@ -4268,6 +4389,8 @@ int multiRDMA_save_cleanup(void)
>          qemu_sem_destroy(&p->sem);
>          g_free(p->name);
>          p->name =3D NULL;
> +        qemu_rdma_cleanup(multiRDMA_send_state->params[i].rdma);
> +        g_free(multiRDMA_send_state->params[i].rdma);
>      }
> =20
>      qemu_sem_destroy(&multiRDMA_send_state->sem_sync);
> @@ -4292,6 +4415,71 @@ static void multiRDMA_recv_terminate_threads(void)
>      }
>  }
> =20
> +static void qemu_multiRDMA_load_cleanup(RDMAContext *rdma)
> +{
> +    int idx;
> +
> +    if (rdma->cm_id && rdma->connected) {
> +        if ((rdma->error_state ||
> +             migrate_get_current()->state =3D=3D MIGRATION_STATUS_CANCEL=
LING) &&
> +            !rdma->received_error) {
> +            RDMAControlHeader head =3D { .len =3D 0,
> +                                       .type =3D RDMA_CONTROL_ERROR,
> +                                       .repeat =3D 1,
> +                                     };
> +            error_report("Early error. Sending error.");
> +            qemu_rdma_post_send_control(rdma, NULL, &head);
> +        }
> +
> +        rdma_disconnect(rdma->cm_id);
> +        trace_qemu_rdma_cleanup_disconnect();
> +        rdma->connected =3D false;
> +    }
> +
> +    g_free(rdma->dest_blocks);
> +    rdma->dest_blocks =3D NULL;
> +
> +    for (idx =3D 0; idx < RDMA_WRID_MAX; idx++) {
> +        if (rdma->wr_data[idx].control_mr) {
> +            rdma->total_registrations--;
> +            ibv_dereg_mr(rdma->wr_data[idx].control_mr);
> +        }
> +        rdma->wr_data[idx].control_mr =3D NULL;
> +    }
> +
> +    if (rdma->local_ram_blocks.block) {
> +        while (rdma->local_ram_blocks.nb_blocks) {
> +            rdma_delete_block(rdma, &rdma->local_ram_blocks.block[0]);
> +        }
> +    }
> +
> +    if (rdma->qp) {
> +        rdma_destroy_qp(rdma->cm_id);
> +        rdma->qp =3D NULL;
> +    }
> +    if (rdma->cq) {
> +        ibv_destroy_cq(rdma->cq);
> +        rdma->cq =3D NULL;
> +    }
> +    if (rdma->comp_channel) {
> +        ibv_destroy_comp_channel(rdma->comp_channel);
> +        rdma->comp_channel =3D NULL;
> +    }
> +    if (rdma->pd) {
> +        ibv_dealloc_pd(rdma->pd);
> +        rdma->pd =3D NULL;
> +    }
> +    if (rdma->cm_id) {
> +        rdma_destroy_id(rdma->cm_id);
> +        rdma->cm_id =3D NULL;
> +    }
> +
> +    rdma->listen_id =3D NULL;
> +    rdma->channel =3D NULL;
> +    g_free(rdma->host);
> +    rdma->host =3D NULL;
> +}
> +
>  int multiRDMA_load_cleanup(void)
>  {
>      int i;
> @@ -4323,6 +4511,8 @@ int multiRDMA_load_cleanup(void)
>          qemu_sem_destroy(&p->sem);
>          g_free(p->name);
>          p->name =3D NULL;
> +        qemu_multiRDMA_load_cleanup(multiRDMA_recv_state->params[i].rdma=
);
> +        g_free(multiRDMA_recv_state->params[i].rdma);
>      }
> =20
>      qemu_sem_destroy(&multiRDMA_recv_state->sem_sync);
> @@ -4386,15 +4576,18 @@ void rdma_start_outgoing_migration(void *opaque,
> =20
>      trace_rdma_start_outgoing_migration_after_rdma_connect();
> =20
> +    s->to_dst_file =3D qemu_fopen_rdma(rdma, "wb");
> +    /* create multiRDMA channel */
>      if (migrate_use_multiRDMA()) {
>          if (multiRDMA_save_setup(host_port, errp) !=3D 0) {
>              ERROR(errp, "init multiRDMA channels failure!");
>              goto err;
>          }
> +        migrate_fd_connect(s, NULL);
> +    } else {
> +        migrate_fd_connect(s, NULL);
>      }

If that's on both sides of the 'if' then it should move to here.

> -    s->to_dst_file =3D qemu_fopen_rdma(rdma, "wb");
> -    migrate_fd_connect(s, NULL);
>      return;
>  err:
>      g_free(rdma);
> --=20
> 2.19.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


