Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A8DC18DF4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F0D206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZYbkgG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F0D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4USF-0000Yd-Co
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 13:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j4URW-00006U-7r
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 13:51:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j4URT-0004kW-T8
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 13:51:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20493
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j4URT-0004jK-Nh
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 13:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582138287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FhJWHXxbHNBxcg1HCKdX4Mhza/nB6l7pNJIIv3q9RQU=;
 b=DZYbkgG3xGaI9bc4pM0iYF4wjDGHQYcA9Dx/Yb+xI7emsP9WbUcuCTOGPcexeKcTC7EtiI
 +7OBejBvFOfNOTJLoEqDA7e5VDeENpaHkt2MrBIfA+WY7J8DOHI9kjV5cDTGYT+EjYYs4N
 Iav99IKK8c7tgqZytbDk8LVPQFYEqkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-Kn8hNWH4PQyFXpWic577Hg-1; Wed, 19 Feb 2020 13:51:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B5FA107ACC9;
 Wed, 19 Feb 2020 18:51:22 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 969898B740;
 Wed, 19 Feb 2020 18:51:20 +0000 (UTC)
Date: Wed, 19 Feb 2020 18:51:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Subject: Re: [PATCH 2/3] COLO: Migrate dirty pages during the gap of
 checkpointing
Message-ID: <20200219185117.GJ3089@work-vm>
References: <20200217012049.22988-1-zhang.zhanghailiang@huawei.com>
 <20200217012049.22988-3-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200217012049.22988-3-zhang.zhanghailiang@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Kn8hNWH4PQyFXpWic577Hg-1
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
Cc: danielcho@qnap.com, chen.zhang@intel.com, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Hailiang Zhang (zhang.zhanghailiang@huawei.com) wrote:
> We can migrate some dirty pages during the gap of checkpointing,
> by this way, we can reduce the amount of ram migrated during checkpointin=
g.
>=20
> Signed-off-by: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
> ---
>  migration/colo.c       | 69 +++++++++++++++++++++++++++++++++++++++---
>  migration/migration.h  |  1 +
>  migration/trace-events |  1 +
>  qapi/migration.json    |  4 ++-
>  4 files changed, 70 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c
> index 93c5a452fb..d30c6bc4ad 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -46,6 +46,13 @@ static COLOMode last_colo_mode;
> =20
>  #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
> =20
> +#define DEFAULT_RAM_PENDING_CHECK 1000
> +
> +/* should be calculated by bandwidth and max downtime ? */
> +#define THRESHOLD_PENDING_SIZE (100 * 1024 * 1024UL)

Turn both of these magic constants into parameters.

> +static int checkpoint_request;
> +
>  bool migration_in_colo_state(void)
>  {
>      MigrationState *s =3D migrate_get_current();
> @@ -516,6 +523,20 @@ static void colo_compare_notify_checkpoint(Notifier =
*notifier, void *data)
>      colo_checkpoint_notify(data);
>  }
> =20
> +static bool colo_need_migrate_ram_background(MigrationState *s)
> +{
> +    uint64_t pending_size, pend_pre, pend_compat, pend_post;
> +    int64_t max_size =3D THRESHOLD_PENDING_SIZE;
> +
> +    qemu_savevm_state_pending(s->to_dst_file, max_size, &pend_pre,
> +                              &pend_compat, &pend_post);
> +    pending_size =3D pend_pre + pend_compat + pend_post;
> +
> +    trace_colo_need_migrate_ram_background(pending_size);
> +    return (pending_size >=3D max_size);
> +}
> +
> +
>  static void colo_process_checkpoint(MigrationState *s)
>  {
>      QIOChannelBuffer *bioc;
> @@ -571,6 +592,8 @@ static void colo_process_checkpoint(MigrationState *s=
)
> =20
>      timer_mod(s->colo_delay_timer,
>              current_time + s->parameters.x_checkpoint_delay);
> +    timer_mod(s->pending_ram_check_timer,
> +        current_time + DEFAULT_RAM_PENDING_CHECK);

What happens if the iterate takes a while and this triggers in the
middle of the iterate?

>      while (s->state =3D=3D MIGRATION_STATUS_COLO) {
>          if (failover_get_state() !=3D FAILOVER_STATUS_NONE) {
> @@ -583,10 +606,25 @@ static void colo_process_checkpoint(MigrationState =
*s)
>          if (s->state !=3D MIGRATION_STATUS_COLO) {
>              goto out;
>          }
> -        ret =3D colo_do_checkpoint_transaction(s, bioc, fb);
> -        if (ret < 0) {
> -            goto out;
> -        }
> +        if (atomic_xchg(&checkpoint_request, 0)) {
> +            /* start a colo checkpoint */
> +            ret =3D colo_do_checkpoint_transaction(s, bioc, fb);
> +            if (ret < 0) {
> +                goto out;
> +            }
> +        } else {
> +            if (colo_need_migrate_ram_background(s)) {
> +                colo_send_message(s->to_dst_file,
> +                                  COLO_MESSAGE_MIGRATE_RAM_BACKGROUND,
> +                                  &local_err);
> +                if (local_err) {
> +                    goto out;
> +                }
> +
> +                qemu_savevm_state_iterate(s->to_dst_file, false);
> +                qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);

Maybe you should do a qemu_file_get_error(..) at this point to check
it's OK.

> +            }
> +         }
>      }
> =20
>  out:
> @@ -626,6 +664,8 @@ out:
>      colo_compare_unregister_notifier(&packets_compare_notifier);
>      timer_del(s->colo_delay_timer);
>      timer_free(s->colo_delay_timer);
> +    timer_del(s->pending_ram_check_timer);
> +    timer_free(s->pending_ram_check_timer);
>      qemu_sem_destroy(&s->colo_checkpoint_sem);
> =20
>      /*
> @@ -643,6 +683,7 @@ void colo_checkpoint_notify(void *opaque)
>      MigrationState *s =3D opaque;
>      int64_t next_notify_time;
> =20
> +    atomic_inc(&checkpoint_request);

Can you explain what you've changed about this atomic in this patch,
I don't quite see what you're doing.

>      qemu_sem_post(&s->colo_checkpoint_sem);
>      s->colo_checkpoint_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
>      next_notify_time =3D s->colo_checkpoint_time +
> @@ -650,6 +691,19 @@ void colo_checkpoint_notify(void *opaque)
>      timer_mod(s->colo_delay_timer, next_notify_time);
>  }
> =20
> +static void colo_pending_ram_check_notify(void *opaque)
> +{
> +    int64_t next_notify_time;
> +    MigrationState *s =3D opaque;
> +
> +    if (migration_in_colo_state()) {
> +        next_notify_time =3D DEFAULT_RAM_PENDING_CHECK +
> +                           qemu_clock_get_ms(QEMU_CLOCK_HOST);
> +        timer_mod(s->pending_ram_check_timer, next_notify_time);
> +        qemu_sem_post(&s->colo_checkpoint_sem);
> +    }
> +}
> +
>  void migrate_start_colo_process(MigrationState *s)
>  {
>      qemu_mutex_unlock_iothread();
> @@ -657,6 +711,8 @@ void migrate_start_colo_process(MigrationState *s)
>      s->colo_delay_timer =3D  timer_new_ms(QEMU_CLOCK_HOST,
>                                  colo_checkpoint_notify, s);
> =20
> +    s->pending_ram_check_timer =3D timer_new_ms(QEMU_CLOCK_HOST,
> +                                colo_pending_ram_check_notify, s);
>      qemu_sem_init(&s->colo_exit_sem, 0);
>      migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_COLO);
> @@ -805,6 +861,11 @@ static void colo_wait_handle_message(MigrationIncomi=
ngState *mis,
>      case COLO_MESSAGE_CHECKPOINT_REQUEST:
>          colo_incoming_process_checkpoint(mis, fb, bioc, errp);
>          break;
> +    case COLO_MESSAGE_MIGRATE_RAM_BACKGROUND:
> +        if (qemu_loadvm_state_main(mis->from_src_file, mis) < 0) {
> +            error_setg(errp, "Load ram background failed");
> +        }

OK, that's a little dangerou, in that it relies on the source being good
and only sending iterative data;  stuff would break badly if it actually
sent you devices.

> +        break;
>      default:
>          error_setg(errp, "Got unknown COLO message: %d", msg);
>          break;
> diff --git a/migration/migration.h b/migration/migration.h
> index 8473ddfc88..5355259789 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -219,6 +219,7 @@ struct MigrationState
>      QemuSemaphore colo_checkpoint_sem;
>      int64_t colo_checkpoint_time;
>      QEMUTimer *colo_delay_timer;
> +    QEMUTimer *pending_ram_check_timer;
> =20
>      /* The first error that has occurred.
>         We used the mutex to be able to return the 1st error message */
> diff --git a/migration/trace-events b/migration/trace-events
> index 4ab0a503d2..f2ed0c8645 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -295,6 +295,7 @@ migration_tls_incoming_handshake_complete(void) ""
>  colo_vm_state_change(const char *old, const char *new) "Change '%s' =3D>=
 '%s'"
>  colo_send_message(const char *msg) "Send '%s' message"
>  colo_receive_message(const char *msg) "Receive '%s' message"
> +colo_need_migrate_ram_background(uint64_t pending_size) "Pending 0x%" PR=
Ix64 " dirty ram"
> =20
>  # colo-failover.c
>  colo_failover_set_state(const char *new_state) "new state %s"
> diff --git a/qapi/migration.json b/qapi/migration.json
> index b7348d0c8b..ff7a4f18b0 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -977,12 +977,14 @@
>  #
>  # @vmstate-loaded: VM's state has been loaded by SVM.
>  #
> +# @migrate-ram-background: Send some dirty pages during the gap of COLO =
checkpoint
> +#
>  # Since: 2.8
>  ##
>  { 'enum': 'COLOMessage',
>    'data': [ 'checkpoint-ready', 'checkpoint-request', 'checkpoint-reply'=
,
>              'vmstate-send', 'vmstate-size', 'vmstate-received',
> -            'vmstate-loaded' ] }
> +            'vmstate-loaded', 'migrate-ram-background' ] }
> =20
>  ##
>  # @COLOMode:
> --=20
> 2.21.0
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


