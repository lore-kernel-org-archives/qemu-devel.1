Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA2EC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3A9205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqQbu5WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3A9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCU4H-000330-Er
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jCTrB-0004yL-8o
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jCTr9-0006Ny-ME
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:51:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54977
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jCTr9-0006Nm-HJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584042659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sM3V81NorV8Abha2mqO/c4ZJqJDaVb87L+jRguYIsRk=;
 b=FqQbu5WOGupwdyFynvaEwFY4aC+6LQ/YFKsuuuykz7EbfqEQ6DsRz81IXRgZwmhOmifo/S
 8dgsr3ly6972wPo440swjrN2iWq0UrFw0zFJG+SY0rbbzlKkIHA04aBDw0XG5MWlctSP4D
 /IaJAo7YfvxhbcziYx4s6i1XoEr2h48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-bKZtvXnSNxWRYmHw_z-cPw-1; Thu, 12 Mar 2020 15:50:57 -0400
X-MC-Unique: bKZtvXnSNxWRYmHw_z-cPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E233C8017DF;
 Thu, 12 Mar 2020 19:50:55 +0000 (UTC)
Received: from work-vm (ovpn-116-106.ams2.redhat.com [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B52A68F375;
 Thu, 12 Mar 2020 19:50:54 +0000 (UTC)
Date: Thu, 12 Mar 2020 19:50:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Subject: Re: [PATCH V2 7/8] COLO: Migrate dirty pages during the gap of
 checkpointing
Message-ID: <20200312195052.GP3211@work-vm>
References: <20200224065414.36524-1-zhang.zhanghailiang@huawei.com>
 <20200224065414.36524-8-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200224065414.36524-8-zhang.zhanghailiang@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: danielcho@qnap.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> We can migrate some dirty pages during the gap of checkpointing,
> by this way, we can reduce the amount of ram migrated during checkpointin=
g.
>=20
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>  migration/colo.c       | 73 ++++++++++++++++++++++++++++++++++++++++--
>  migration/migration.h  |  1 +
>  migration/trace-events |  1 +
>  qapi/migration.json    |  4 ++-
>  4 files changed, 75 insertions(+), 4 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c
> index 44942c4e23..c36d94072f 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -47,6 +47,13 @@ static COLOMode last_colo_mode;
> =20
>  #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
> =20
> +#define DEFAULT_RAM_PENDING_CHECK 1000
> +
> +/* should be calculated by bandwidth and max downtime ? */
> +#define THRESHOLD_PENDING_SIZE (100 * 1024 * 1024UL)

In the last version I asked to change these two values to parameters.

Dave

> +static int checkpoint_request;
> +
>  bool migration_in_colo_state(void)
>  {
>      MigrationState *s =3D migrate_get_current();
> @@ -517,6 +524,20 @@ static void colo_compare_notify_checkpoint(Notifier =
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
> @@ -572,6 +593,8 @@ static void colo_process_checkpoint(MigrationState *s=
)
> =20
>      timer_mod(s->colo_delay_timer,
>              current_time + s->parameters.x_checkpoint_delay);
> +    timer_mod(s->pending_ram_check_timer,
> +        current_time + DEFAULT_RAM_PENDING_CHECK);
> =20
>      while (s->state =3D=3D MIGRATION_STATUS_COLO) {
>          if (failover_get_state() !=3D FAILOVER_STATUS_NONE) {
> @@ -584,9 +607,30 @@ static void colo_process_checkpoint(MigrationState *=
s)
>          if (s->state !=3D MIGRATION_STATUS_COLO) {
>              goto out;
>          }
> -        ret =3D colo_do_checkpoint_transaction(s, bioc, fb);
> -        if (ret < 0) {
> -            goto out;
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
> +                ret =3D qemu_file_get_error(s->to_dst_file);
> +                if (ret < 0) {
> +                    error_setg_errno(&local_err, -ret,
> +                        "Failed to send dirty pages backgroud");
> +                    goto out;
> +                }
> +            }
>          }
>      }
> =20
> @@ -627,6 +671,8 @@ out:
>      colo_compare_unregister_notifier(&packets_compare_notifier);
>      timer_del(s->colo_delay_timer);
>      timer_free(s->colo_delay_timer);
> +    timer_del(s->pending_ram_check_timer);
> +    timer_free(s->pending_ram_check_timer);
>      qemu_sem_destroy(&s->colo_checkpoint_sem);
> =20
>      /*
> @@ -644,6 +690,7 @@ void colo_checkpoint_notify(void *opaque)
>      MigrationState *s =3D opaque;
>      int64_t next_notify_time;
> =20
> +    atomic_inc(&checkpoint_request);
>      qemu_sem_post(&s->colo_checkpoint_sem);
>      s->colo_checkpoint_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
>      next_notify_time =3D s->colo_checkpoint_time +
> @@ -651,6 +698,19 @@ void colo_checkpoint_notify(void *opaque)
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
> @@ -658,6 +718,8 @@ void migrate_start_colo_process(MigrationState *s)
>      s->colo_delay_timer =3D  timer_new_ms(QEMU_CLOCK_HOST,
>                                  colo_checkpoint_notify, s);
> =20
> +    s->pending_ram_check_timer =3D timer_new_ms(QEMU_CLOCK_HOST,
> +                                colo_pending_ram_check_notify, s);
>      qemu_sem_init(&s->colo_exit_sem, 0);
>      migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_COLO);
> @@ -806,6 +868,11 @@ static void colo_wait_handle_message(MigrationIncomi=
ngState *mis,
>      case COLO_MESSAGE_CHECKPOINT_REQUEST:
>          colo_incoming_process_checkpoint(mis, fb, bioc, errp);
>          break;
> +    case COLO_MESSAGE_MIGRATE_RAM_BACKGROUND:
> +        if (qemu_loadvm_state_main(mis->from_src_file, mis) < 0) {
> +            error_setg(errp, "Load ram background failed");
> +        }
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
> index 52f3429969..73445f1978 100644
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


