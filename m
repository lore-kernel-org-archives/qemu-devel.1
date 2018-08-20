Received: from eggs.gnu.org ([2001:4830:134:3::10]:59736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1frfel-000350-Nz
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1frfek-0008Te-QG
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:35:23 -0400
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234]:38002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1frfek-0008TH-Ke
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:35:22 -0400
Received: by mail-io0-x234.google.com with SMTP id y3-v6so7524682ioc.5
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 01:35:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180817140129.GI2459@work-vm>
References: <1533562177-16447-1-git-send-email-lidongchen@tencent.com>
	<1533562177-16447-10-git-send-email-lidongchen@tencent.com>
	<20180817140129.GI2459@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 20 Aug 2018 16:35:21 +0800
Message-ID: <CAOGPPbcYpwyFNW=kBMgCMf9J-gPDXQfHWX5WJK8xxBLoOmVqag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 09/11] migration: poll the cm event for
 destination qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: zhang.zhanghailiang@huawei.com, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Lidong Chen <lidongchen@tencent.com>

On Fri, Aug 17, 2018 at 10:01 PM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Lidong Chen (jemmy858585@gmail.com) wrote:
>> The destination qemu only poll the comp_channel->fd in
>> qemu_rdma_wait_comp_channel. But when source qemu disconnnect
>> the rdma connection, the destination qemu should be notified.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>
> OK, this could do with an update to the migration_incoming_co comment in
> migration.h, since previously it was only used by colo; if we merge this
> first please post a patch to update the comment.

How about?

/* The coroutine we should enter back for incoming migration */
Coroutine *migration_incoming_co;

>
> Other than that, I think I'm OK:
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> ---
>>  migration/migration.c |  3 ++-
>>  migration/rdma.c      | 32 +++++++++++++++++++++++++++++++-
>>  2 files changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index df0c2cf..f7d6e26 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -389,6 +389,7 @@ static void process_incoming_migration_co(void *opaque)
>>      int ret;
>>
>>      assert(mis->from_src_file);
>> +    mis->migration_incoming_co = qemu_coroutine_self();
>>      mis->largest_page_size = qemu_ram_pagesize_largest();
>>      postcopy_state_set(POSTCOPY_INCOMING_NONE);
>>      migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
>> @@ -418,7 +419,6 @@ static void process_incoming_migration_co(void *opaque)
>>
>>      /* we get COLO info, and know if we are in COLO mode */
>>      if (!ret && migration_incoming_enable_colo()) {
>> -        mis->migration_incoming_co = qemu_coroutine_self();
>>          qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
>>               colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
>>          mis->have_colo_incoming_thread = true;
>> @@ -442,6 +442,7 @@ static void process_incoming_migration_co(void *opaque)
>>      }
>>      mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
>>      qemu_bh_schedule(mis->bh);
>> +    mis->migration_incoming_co = NULL;
>>  }
>>
>>  static void migration_incoming_setup(QEMUFile *f)
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 1affc46..ae07515 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -3226,6 +3226,35 @@ err:
>>
>>  static void rdma_accept_incoming_migration(void *opaque);
>>
>> +static void rdma_cm_poll_handler(void *opaque)
>> +{
>> +    RDMAContext *rdma = opaque;
>> +    int ret;
>> +    struct rdma_cm_event *cm_event;
>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>> +
>> +    ret = rdma_get_cm_event(rdma->channel, &cm_event);
>> +    if (ret) {
>> +        error_report("get_cm_event failed %d", errno);
>> +        return;
>> +    }
>> +    rdma_ack_cm_event(cm_event);
>> +
>> +    if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
>> +        cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
>> +        error_report("receive cm event, cm event is %d", cm_event->event);
>> +        rdma->error_state = -EPIPE;
>> +        if (rdma->return_path) {
>> +            rdma->return_path->error_state = -EPIPE;
>> +        }
>> +
>> +        if (mis->migration_incoming_co) {
>> +            qemu_coroutine_enter(mis->migration_incoming_co);
>> +        }
>> +        return;
>> +    }
>> +}
>> +
>>  static int qemu_rdma_accept(RDMAContext *rdma)
>>  {
>>      RDMACapabilities cap;
>> @@ -3326,7 +3355,8 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>>                              NULL,
>>                              (void *)(intptr_t)rdma->return_path);
>>      } else {
>> -        qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
>> +        qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
>> +                            NULL, rdma);
>>      }
>>
>>      ret = rdma_accept(rdma->cm_id, &conn_param);
>> --
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
