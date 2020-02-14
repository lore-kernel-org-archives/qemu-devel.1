Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AEEC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0DE20873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihNZhTqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0DE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Xxr-0000TW-2t
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 05:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j2Xx9-000827-Fl
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j2Xx7-0001Ok-6E
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:12:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j2Xx6-0001MG-Vy
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581675123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXifr+DpLVK/gjzCTqHDX9jJFO8eLwY12LZyfUCARUA=;
 b=ihNZhTqRE9D+1rRoLts6c6l77vMv9dm8GIZsvh27lWXxJklWBep/WpfSeTV0rfAwXSiZwg
 incRB/+0qV1C08GuVrXnxdCj5mPPI+nh2wBeG01wD7RczvWqt6RwC/g5mPMgoGz769DUpj
 TqbVmi5lEPfLsW34ueGbScFL1WuA8VU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-WQZMp9c_NxysCnQyIMj6Dg-1; Fri, 14 Feb 2020 05:12:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E633100550E;
 Fri, 14 Feb 2020 10:12:00 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3DA05C115;
 Fri, 14 Feb 2020 10:11:54 +0000 (UTC)
Date: Fri, 14 Feb 2020 10:11:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v6 3/8] multifd: Make no compression operations into its
 own structure
Message-ID: <20200214101152.GA3283@work-vm>
References: <20200213211709.59065-1-quintela@redhat.com>
 <20200213211709.59065-4-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200213211709.59065-4-quintela@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WQZMp9c_NxysCnQyIMj6Dg-1
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> It will be used later.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>=20
> ---
>=20
> No comp value needs to be zero.
> ---
>  migration/migration.c |   9 ++
>  migration/migration.h |   1 +
>  migration/multifd.c   | 185 ++++++++++++++++++++++++++++++++++++++++--
>  migration/multifd.h   |  26 ++++++
>  migration/ram.c       |   1 +
>  5 files changed, 214 insertions(+), 8 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index bc744d1734..eb7b0a2df0 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2245,6 +2245,15 @@ int migrate_multifd_channels(void)
>      return s->parameters.multifd_channels;
>  }
> =20
> +MultiFDCompression migrate_multifd_compression(void)
> +{
> +    MigrationState *s;
> +
> +    s =3D migrate_get_current();
> +
> +    return s->parameters.multifd_compression;
> +}
> +
>  int migrate_use_xbzrle(void)
>  {
>      MigrationState *s;
> diff --git a/migration/migration.h b/migration/migration.h
> index 8473ddfc88..59fea02482 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -300,6 +300,7 @@ bool migrate_auto_converge(void);
>  bool migrate_use_multifd(void);
>  bool migrate_pause_before_switchover(void);
>  int migrate_multifd_channels(void);
> +MultiFDCompression migrate_multifd_compression(void);
> =20
>  int migrate_use_xbzrle(void);
>  int64_t migrate_xbzrle_cache_size(void);
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b3e8ae9bcc..97433e5135 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -38,6 +38,134 @@ typedef struct {
>      uint64_t unused2[4];    /* Reserved for future use */
>  } __attribute__((packed)) MultiFDInit_t;
> =20
> +/* Multifd without compression */
> +
> +/**
> + * nocomp_send_setup: setup send side
> + *
> + * For no compression this function does nothing.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    return 0;
> +}
> +
> +/**
> + * nocomp_send_cleanup: cleanup send side
> + *
> + * For no compression this function does nothing.
> + *
> + * @p: Params for the channel that we are using
> + */
> +static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
> +{
> +    return;
> +}
> +
> +/**
> + * nocomp_send_prepare: prepare date to be able to send
> + *
> + * For no compression we just have to calculate the size of the
> + * packet.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + * @errp: pointer to an error
> + */
> +static int nocomp_send_prepare(MultiFDSendParams *p, uint32_t used,
> +                               Error **errp)
> +{
> +    p->next_packet_size =3D used * qemu_target_page_size();
> +    p->flags |=3D MULTIFD_FLAG_NOCOMP;
> +    return 0;
> +}
> +
> +/**
> + * nocomp_send_write: do the actual write of the data
> + *
> + * For no compression we just have to write the data.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + * @errp: pointer to an error
> + */
> +static int nocomp_send_write(MultiFDSendParams *p, uint32_t used, Error =
**errp)
> +{
> +    return qio_channel_writev_all(p->c, p->pages->iov, used, errp);
> +}
> +
> +/**
> + * nocomp_recv_setup: setup receive side
> + *
> + * For no compression this function does nothing.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    return 0;
> +}
> +
> +/**
> + * nocomp_recv_cleanup: setup receive side
> + *
> + * For no compression this function does nothing.
> + *
> + * @p: Params for the channel that we are using
> + */
> +static void nocomp_recv_cleanup(MultiFDRecvParams *p)
> +{
> +}
> +
> +/**
> + * nocomp_recv_pages: read the data from the channel into actual pages
> + *
> + * For no compression we just need to read things into the correct place=
.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + * @errp: pointer to an error
> + */
> +static int nocomp_recv_pages(MultiFDRecvParams *p, uint32_t used, Error =
**errp)
> +{
> +    uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> +
> +    if (flags !=3D MULTIFD_FLAG_NOCOMP) {
> +        error_setg(errp, "multifd %d: flags received %x flags expected %=
x",
> +                   p->id, flags, MULTIFD_FLAG_NOCOMP);
> +        return -1;
> +    }
> +    return qio_channel_readv_all(p->c, p->pages->iov, used, errp);
> +}
> +
> +static MultiFDMethods multifd_nocomp_ops =3D {
> +    .send_setup =3D nocomp_send_setup,
> +    .send_cleanup =3D nocomp_send_cleanup,
> +    .send_prepare =3D nocomp_send_prepare,
> +    .send_write =3D nocomp_send_write,
> +    .recv_setup =3D nocomp_recv_setup,
> +    .recv_cleanup =3D nocomp_recv_cleanup,
> +    .recv_pages =3D nocomp_recv_pages
> +};
> +
> +static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] =3D {
> +    [MULTIFD_COMPRESSION_NONE] =3D &multifd_nocomp_ops,
> +};
> +
>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **err=
p)
>  {
>      MultiFDInit_t msg =3D {};
> @@ -246,6 +374,8 @@ struct {
>       * We will use atomic operations.  Only valid values are 0 and 1.
>       */
>      int exiting;
> +    /* multifd ops */
> +    MultiFDMethods *ops;
>  } *multifd_send_state;
> =20
>  /*
> @@ -397,6 +527,7 @@ void multifd_save_cleanup(void)
>      }
>      for (i =3D 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p =3D &multifd_send_state->params[i];
> +        Error *local_err =3D NULL;
> =20
>          socket_send_channel_destroy(p->c);
>          p->c =3D NULL;
> @@ -410,6 +541,10 @@ void multifd_save_cleanup(void)
>          p->packet_len =3D 0;
>          g_free(p->packet);
>          p->packet =3D NULL;
> +        multifd_send_state->ops->send_cleanup(p, &local_err);
> +        if (local_err) {
> +            migrate_set_error(migrate_get_current(), local_err);
> +        }
>      }
>      qemu_sem_destroy(&multifd_send_state->channels_ready);
>      g_free(multifd_send_state->params);
> @@ -494,7 +629,14 @@ static void *multifd_send_thread(void *opaque)
>              uint64_t packet_num =3D p->packet_num;
>              flags =3D p->flags;
> =20
> -            p->next_packet_size =3D used * qemu_target_page_size();
> +            if (used) {
> +                ret =3D multifd_send_state->ops->send_prepare(p, used,
> +                                                            &local_err);
> +                if (ret !=3D 0) {
> +                    qemu_mutex_unlock(&p->mutex);
> +                    break;
> +                }
> +            }
>              multifd_send_fill_packet(p);
>              p->flags =3D 0;
>              p->num_packets++;
> @@ -513,8 +655,7 @@ static void *multifd_send_thread(void *opaque)
>              }
> =20
>              if (used) {
> -                ret =3D qio_channel_writev_all(p->c, p->pages->iov,
> -                                             used, &local_err);
> +                ret =3D multifd_send_state->ops->send_write(p, used, &lo=
cal_err);
>                  if (ret !=3D 0) {
>                      break;
>                  }
> @@ -604,6 +745,7 @@ int multifd_save_setup(Error **errp)
>      multifd_send_state->pages =3D multifd_pages_init(page_count);
>      qemu_sem_init(&multifd_send_state->channels_ready, 0);
>      atomic_set(&multifd_send_state->exiting, 0);
> +    multifd_send_state->ops =3D multifd_ops[migrate_multifd_compression(=
)];
> =20
>      for (i =3D 0; i < thread_count; i++) {
>          MultiFDSendParams *p =3D &multifd_send_state->params[i];
> @@ -623,6 +765,18 @@ int multifd_save_setup(Error **errp)
>          p->name =3D g_strdup_printf("multifdsend_%d", i);
>          socket_send_channel_create(multifd_new_send_channel_async, p);
>      }
> +
> +    for (i =3D 0; i < thread_count; i++) {
> +        MultiFDSendParams *p =3D &multifd_send_state->params[i];
> +        Error *local_err =3D NULL;
> +        int ret;
> +
> +        ret =3D multifd_send_state->ops->send_setup(p, &local_err);
> +        if (ret) {
> +            error_propagate(errp, local_err);
> +            return ret;
> +        }
> +    }
>      return 0;
>  }
> =20
> @@ -634,6 +788,8 @@ struct {
>      QemuSemaphore sem_sync;
>      /* global number of generated multifd packets */
>      uint64_t packet_num;
> +    /* multifd ops */
> +    MultiFDMethods *ops;
>  } *multifd_recv_state;
> =20
>  static void multifd_recv_terminate_threads(Error *err)
> @@ -673,7 +829,6 @@ static void multifd_recv_terminate_threads(Error *err=
)
>  int multifd_load_cleanup(Error **errp)
>  {
>      int i;
> -    int ret =3D 0;
> =20
>      if (!migrate_use_multifd()) {
>          return 0;
> @@ -706,6 +861,7 @@ int multifd_load_cleanup(Error **errp)
>          p->packet_len =3D 0;
>          g_free(p->packet);
>          p->packet =3D NULL;
> +        multifd_recv_state->ops->recv_cleanup(p);
>      }
>      qemu_sem_destroy(&multifd_recv_state->sem_sync);
>      g_free(multifd_recv_state->params);
> @@ -713,7 +869,7 @@ int multifd_load_cleanup(Error **errp)
>      g_free(multifd_recv_state);
>      multifd_recv_state =3D NULL;
> =20
> -    return ret;
> +    return 0;
>  }
> =20
>  void multifd_recv_sync_main(void)
> @@ -778,6 +934,8 @@ static void *multifd_recv_thread(void *opaque)
> =20
>          used =3D p->pages->used;
>          flags =3D p->flags;
> +        /* recv methods don't know how to handle the SYNC flag */
> +        p->flags &=3D ~MULTIFD_FLAG_SYNC;
>          trace_multifd_recv(p->id, p->packet_num, used, flags,
>                             p->next_packet_size);
>          p->num_packets++;
> @@ -785,8 +943,7 @@ static void *multifd_recv_thread(void *opaque)
>          qemu_mutex_unlock(&p->mutex);
> =20
>          if (used) {
> -            ret =3D qio_channel_readv_all(p->c, p->pages->iov,
> -                                        used, &local_err);
> +            ret =3D multifd_recv_state->ops->recv_pages(p, used, &local_=
err);
>              if (ret !=3D 0) {
>                  break;
>              }
> @@ -825,6 +982,7 @@ int multifd_load_setup(Error **errp)
>      multifd_recv_state->params =3D g_new0(MultiFDRecvParams, thread_coun=
t);
>      atomic_set(&multifd_recv_state->count, 0);
>      qemu_sem_init(&multifd_recv_state->sem_sync, 0);
> +    multifd_recv_state->ops =3D multifd_ops[migrate_multifd_compression(=
)];
> =20
>      for (i =3D 0; i < thread_count; i++) {
>          MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
> @@ -839,6 +997,18 @@ int multifd_load_setup(Error **errp)
>          p->packet =3D g_malloc0(p->packet_len);
>          p->name =3D g_strdup_printf("multifdrecv_%d", i);
>      }
> +
> +    for (i =3D 0; i < thread_count; i++) {
> +        MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
> +        Error *local_err =3D NULL;
> +        int ret;
> +
> +        ret =3D multifd_recv_state->ops->recv_setup(p, &local_err);
> +        if (ret) {
> +            error_propagate(errp, local_err);
> +            return ret;
> +        }
> +    }
>      return 0;
>  }
> =20
> @@ -896,4 +1066,3 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Error=
 **errp)
>      return atomic_read(&multifd_recv_state->count) =3D=3D
>             migrate_multifd_channels();
>  }
> -
> diff --git a/migration/multifd.h b/migration/multifd.h
> index d8b0205977..54075ffa7d 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -25,6 +25,11 @@ int multifd_queue_page(QEMUFile *f, RAMBlock *block, r=
am_addr_t offset);
> =20
>  #define MULTIFD_FLAG_SYNC (1 << 0)
> =20
> +/* We reserve 3 bits for compression methods */
> +#define MULTIFD_FLAG_COMPRESSION_MASK (7 << 1)
> +/* we need to be compatible. Before compression value was 0 */
> +#define MULTIFD_FLAG_NOCOMP (0 << 1)
> +
>  /* This value needs to be a multiple of qemu_target_page_size() */
>  #define MULTIFD_PACKET_SIZE (512 * 1024)
> =20
> @@ -96,6 +101,8 @@ typedef struct {
>      uint64_t num_pages;
>      /* syncs main thread and channels */
>      QemuSemaphore sem_sync;
> +    /* used for compression methods */
> +    void *data;
>  }  MultiFDSendParams;
> =20
>  typedef struct {
> @@ -133,7 +140,26 @@ typedef struct {
>      uint64_t num_pages;
>      /* syncs main thread and channels */
>      QemuSemaphore sem_sync;
> +    /* used for de-compression methods */
> +    void *data;
>  } MultiFDRecvParams;
> =20
> +typedef struct {
> +    /* Setup for sending side */
> +    int (*send_setup)(MultiFDSendParams *p, Error **errp);
> +    /* Cleanup for sending side */
> +    void (*send_cleanup)(MultiFDSendParams *p, Error **errp);
> +    /* Prepare the send packet */
> +    int (*send_prepare)(MultiFDSendParams *p, uint32_t used, Error **err=
p);
> +    /* Write the send packet */
> +    int (*send_write)(MultiFDSendParams *p, uint32_t used, Error **errp)=
;
> +    /* Setup for receiving side */
> +    int (*recv_setup)(MultiFDRecvParams *p, Error **errp);
> +    /* Cleanup for receiving side */
> +    void (*recv_cleanup)(MultiFDRecvParams *p);
> +    /* Read all pages */
> +    int (*recv_pages)(MultiFDRecvParams *p, uint32_t used, Error **errp)=
;
> +} MultiFDMethods;
> +
>  #endif
> =20
> diff --git a/migration/ram.c b/migration/ram.c
> index ed23ed1c7c..73a141bb60 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -43,6 +43,7 @@
>  #include "page_cache.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-types-migration.h"
>  #include "qapi/qapi-events-migration.h"
>  #include "qapi/qmp/qerror.h"
>  #include "trace.h"
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


