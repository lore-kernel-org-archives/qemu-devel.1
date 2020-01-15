Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA24C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE8A20728
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJGA895C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE8A20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irnXe-0002zp-Sz
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 13:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1irnWW-00020t-UR
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1irnWS-00064W-PH
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:36:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54841
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1irnWS-000645-J7
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579113367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J9HP/uWVETLoY8mfSVw7cSa3tM7NzBTlVj3wjMamaeU=;
 b=GJGA895CCR+DzuwjpqMdnfSRATA/sITNOEu979nHptQgUi13LJp9/Ac/pHy6huo6YX/Rud
 Rr7HUywU5xqzmyWOeihYTeuQufl+h4Dab9TH1hkavvAJUQhF7GgTh9dkkVK7Z8CZ/+ntxq
 rtKwFYtYwaccX7JmII70qTPtncdbqCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-Nu0bSEr8MW2v5N75i1f8Lg-1; Wed, 15 Jan 2020 13:36:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89F6F800D48;
 Wed, 15 Jan 2020 18:36:04 +0000 (UTC)
Received: from work-vm (ovpn-117-231.ams2.redhat.com [10.36.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAE6580F7F;
 Wed, 15 Jan 2020 18:36:02 +0000 (UTC)
Date: Wed, 15 Jan 2020 18:36:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 06/12] migration/rdma: Transmit initial package
Message-ID: <20200115183600.GI3811@work-vm>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-7-fengzhimin1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200109045922.904-7-fengzhimin1@huawei.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Nu0bSEr8MW2v5N75i1f8Lg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
> From: fengzhimin <fengzhimin1@huawei.com>
>=20
> Transmit initial package through the multiRDMA channels,
> so that we can identify the main channel and multiRDMA channels.
>=20
> Signed-off-by: fengzhimin <fengzhimin1@huawei.com>

'packet' not 'package'

> ---
>  migration/rdma.c | 114 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 107 insertions(+), 7 deletions(-)
>=20
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 5b780bef36..db75a4372a 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -116,6 +116,16 @@ static uint32_t known_capabilities =3D RDMA_CAPABILI=
TY_PIN_ALL;
> =20
>  #define RDMA_WRID_CHUNK_MASK (~RDMA_WRID_BLOCK_MASK & ~RDMA_WRID_TYPE_MA=
SK)
> =20
> +/* Define magic to distinguish multiRDMA and main RDMA */
> +#define MULTIRDMA_MAGIC 0x11223344U
> +#define MAINRDMA_MAGIC 0x55667788U

Can you explain more about when you use these two - is it 'MAINRDMA' on
the first channel/file and multi on the extra ones???

> +#define ERROR_MAGIC 0xFFFFFFFFU
> +
> +#define MULTIRDMA_VERSION 1
> +#define MAINRDMA_VERSION 1
> +
> +#define UNUSED_ID 0xFFU

Make sure you can't set the number of channels to 256 (or more) then.

>  /*
>   * RDMA migration protocol:
>   * 1. RDMA Writes (data messages, i.e. RAM)
> @@ -167,6 +177,14 @@ enum {
>      RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
>  };
> =20
> +/*
> + * Identify the MultiRDAM channel info
> + */
> +typedef struct {
> +    uint32_t magic;
> +    uint32_t version;
> +    uint8_t id;
> +} __attribute__((packed)) RDMAChannelInit_t;

Since you're using qemu_get/qemu_put on the QEMUFile, don't
bother with packing a struct, just use qemu_get_be32 and qemu_put_be32.

>  /*
>   * Memory and MR structures used to represent an IB Send/Recv work reque=
st.
> @@ -3430,7 +3448,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>          int i;
>          RDMAContext *multi_rdma =3D NULL;
>          thread_count =3D migrate_multiRDMA_channels();
> -        /* create the multi Thread RDMA channels */
> +        /* create the multiRDMA channels */

That should be fixed in the previous patch that created it.

>          for (i =3D 0; i < thread_count; i++) {
>              if (multiRDMA_recv_state->params[i].rdma->cm_id =3D=3D NULL)=
 {
>                  multi_rdma =3D multiRDMA_recv_state->params[i].rdma;
> @@ -4058,6 +4076,48 @@ static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma=
, const char *mode)
>      return rioc->file;
>  }
> =20
> +static RDMAChannelInit_t migration_rdma_recv_initial_packet(QEMUFile *f,
> +                                                            Error **errp=
)
> +{
> +    RDMAChannelInit_t msg;
> +    int thread_count =3D migrate_multiRDMA_channels();
> +    qemu_get_buffer(f, (uint8_t *)&msg, sizeof(msg));
> +    be32_to_cpus(&msg.magic);
> +    be32_to_cpus(&msg.version);
> +
> +    if (msg.magic !=3D MULTIRDMA_MAGIC &&
> +        msg.magic !=3D MAINRDMA_MAGIC) {
> +        error_setg(errp, "multiRDMA: received unrecognized "
> +                   "packet magic %x", msg.magic);
> +        goto err;
> +    }
> +
> +    if (msg.magic =3D=3D MULTIRDMA_MAGIC
> +        && msg.version !=3D MULTIRDMA_VERSION) {
> +        error_setg(errp, "multiRDMA: received packet version "
> +                   "%d expected %d", msg.version, MULTIRDMA_VERSION);
> +        goto err;
> +    }
> +
> +    if (msg.magic =3D=3D MAINRDMA_MAGIC && msg.version !=3D MAINRDMA_VER=
SION) {
> +        error_setg(errp, "multiRDMA: received packet version "
> +                   "%d expected %d", msg.version, MAINRDMA_VERSION);
> +        goto err;
> +    }

It took me a few minutes to see the difference between these two
previous if's the error messages should be different.

> +    if (msg.magic =3D=3D MULTIRDMA_MAGIC && msg.id > thread_count) {
> +        error_setg(errp, "multiRDMA: received channel version %d "
> +                   "expected %d", msg.version, MULTIRDMA_VERSION);

That text seems wrong, since you're checking for the thread count.

> +        goto err;
> +    }
> +
> +    return msg;
> +err:
> +    msg.magic =3D ERROR_MAGIC;
> +    msg.id =3D UNUSED_ID;
> +    return msg;
> +}
> +
>  static void *multiRDMA_recv_thread(void *opaque)
>  {
>      MultiRDMARecvParams *p =3D opaque;
> @@ -4100,13 +4160,34 @@ static void multiRDMA_recv_new_channel(QEMUFile *=
f, int id)
>  static void migration_multiRDMA_process_incoming(QEMUFile *f, RDMAContex=
t *rdma)
>  {
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
> +    Error *local_err =3D NULL;
> +    RDMAChannelInit_t msg =3D migration_rdma_recv_initial_packet(f, &loc=
al_err);

It's probably simpler here to check for
   if (local_err)

   and then you can avoid the need for ERROR_MAGIC.

> +    switch (msg.magic) {
> +    case MAINRDMA_MAGIC:
> +        if (!mis->from_src_file) {
> +            rdma->migration_started_on_destination =3D 1;
> +            migration_incoming_setup(f);
> +            migration_incoming_process();
> +        }
> +        break;
> =20
> -    if (!mis->from_src_file) {
> -        rdma->migration_started_on_destination =3D 1;
> -        migration_incoming_setup(f);
> -        migration_incoming_process();
> -    } else {
> -        multiRDMA_recv_new_channel(f, multiRDMA_recv_state->count);
> +    case MULTIRDMA_MAGIC:
> +        multiRDMA_recv_new_channel(f, msg.id);
> +        break;
> +
> +    case ERROR_MAGIC:
> +    default:
> +        if (local_err) {
> +            MigrationState *s =3D migrate_get_current();
> +            migrate_set_error(s, local_err);
> +            if (s->state =3D=3D MIGRATION_STATUS_SETUP ||
> +                    s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
> +                migrate_set_state(&s->state, s->state,
> +                        MIGRATION_STATUS_FAILED);
> +            }
> +        }
> +        break;
>      }
>  }
> =20
> @@ -4245,10 +4326,26 @@ err:
>      multiRDMA_load_cleanup();
>  }
> =20
> +static void migration_rdma_send_initial_packet(QEMUFile *f, uint8_t id)
> +{
> +    RDMAChannelInit_t msg;
> +
> +    msg.magic =3D cpu_to_be32(id =3D=3D UNUSED_ID ?
> +                            MAINRDMA_MAGIC : MULTIRDMA_MAGIC);
> +    msg.version =3D cpu_to_be32(id =3D=3D UNUSED_ID ?
> +                              MAINRDMA_VERSION : MULTIRDMA_VERSION);
> +    msg.id =3D id;
> +    qemu_put_buffer(f, (uint8_t *)&msg, sizeof(msg));
> +    qemu_fflush(f);
> +}
> +
>  static void *multiRDMA_send_thread(void *opaque)
>  {
>      MultiRDMASendParams *p =3D opaque;
> =20
> +    /* send the multiRDMA channels magic */
> +    migration_rdma_send_initial_packet(p->file, p->id);
> +
>      while (true) {
>          qemu_mutex_lock(&p->mutex);
>          if (p->quit) {
> @@ -4579,6 +4676,9 @@ void rdma_start_outgoing_migration(void *opaque,
>      s->to_dst_file =3D qemu_fopen_rdma(rdma, "wb");
>      /* create multiRDMA channel */
>      if (migrate_use_multiRDMA()) {
> +        /* send the main RDMA channel magic */
> +        migration_rdma_send_initial_packet(s->to_dst_file, UNUSED_ID);
> +
>          if (multiRDMA_save_setup(host_port, errp) !=3D 0) {
>              ERROR(errp, "init multiRDMA channels failure!");
>              goto err;
> --=20
> 2.19.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


