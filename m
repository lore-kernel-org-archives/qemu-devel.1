Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2CBC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633AA20659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDAEHVKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633AA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1bkW-0002uA-K8
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j1bjR-0002Rg-CX
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j1bjO-0002uG-1H
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:02:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j1bjN-0002pp-Ns
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581451320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S20V1lEnTldTtEyq6vXbGRjC7G/unLAELyDBI+cN6pQ=;
 b=QDAEHVKuQl2TZjCEJNsYkGmH602seQfMVTG087EVy3b0f+0zkHvRPc3dN8XGR7yzcU7NxR
 Ckq45XHB2BKH47rNWWyXtWgXT+/yxVHQrj7cAjjc3Wn1sOkPv/BkeSZMJkuN1Uf2OuU2xW
 xB7OVwfvQeVRWsCuAhB6V4tl+fnT9Yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-ncF0Bu4POKGXyPFU2DqTBQ-1; Tue, 11 Feb 2020 15:01:57 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 719DBDB6A
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 20:01:56 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E6746055B;
 Tue, 11 Feb 2020 20:01:53 +0000 (UTC)
Date: Tue, 11 Feb 2020 20:01:51 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v5 8/8] multifd: Add zstd compression multifd support
Message-ID: <20200211200151.GJ2751@work-vm>
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-9-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200129115655.10414-9-quintela@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ncF0Bu4POKGXyPFU2DqTBQ-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/core/qdev-properties.c    |   2 +-
>  migration/Makefile.objs      |   1 +
>  migration/migration.c        |   9 +
>  migration/migration.h        |   1 +
>  migration/multifd-zstd.c     | 337 +++++++++++++++++++++++++++++++++++
>  migration/multifd.h          |   2 +-
>  migration/ram.c              |   1 -
>  qapi/migration.json          |   4 +-
>  tests/qtest/migration-test.c |  10 ++
>  9 files changed, 363 insertions(+), 4 deletions(-)
>  create mode 100644 migration/multifd-zstd.c
>=20
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index bf88a50cdf..9440ca78c3 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -645,7 +645,7 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
>  const PropertyInfo qdev_prop_multifd_method =3D {
>      .name =3D "MultiFDMethod",
>      .description =3D "multifd_method values, "
> -                   "none/zlib",
> +                   "none/zlib/zstd",
>      .enum_table =3D &MultiFDMethod_lookup,
>      .get =3D get_enum,
>      .set =3D set_enum,
> diff --git a/migration/Makefile.objs b/migration/Makefile.objs
> index 0308caa5c5..0fc619e380 100644
> --- a/migration/Makefile.objs
> +++ b/migration/Makefile.objs
> @@ -9,6 +9,7 @@ common-obj-y +=3D qjson.o
>  common-obj-y +=3D block-dirty-bitmap.o
>  common-obj-y +=3D multifd.o
>  common-obj-y +=3D multifd-zlib.o
> +common-obj-$(CONFIG_ZSTD) +=3D multifd-zstd.o
> =20
>  common-obj-$(CONFIG_RDMA) +=3D rdma.o
> =20
> diff --git a/migration/migration.c b/migration/migration.c
> index b690500545..aff081128c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2285,6 +2285,15 @@ int migrate_multifd_zlib_level(void)
>      return s->parameters.multifd_zlib_level;
>  }
> =20
> +int migrate_multifd_zstd_level(void)
> +{
> +    MigrationState *s;
> +
> +    s =3D migrate_get_current();
> +
> +    return s->parameters.multifd_zstd_level;
> +}
> +
>  int migrate_use_xbzrle(void)
>  {
>      MigrationState *s;
> diff --git a/migration/migration.h b/migration/migration.h
> index 95e9c196ff..2eb72aee0a 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -302,6 +302,7 @@ bool migrate_pause_before_switchover(void);
>  int migrate_multifd_channels(void);
>  MultiFDMethod migrate_multifd_method(void);
>  int migrate_multifd_zlib_level(void);
> +int migrate_multifd_zstd_level(void);
> =20
>  int migrate_use_xbzrle(void);
>  int64_t migrate_xbzrle_cache_size(void);
> diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> new file mode 100644
> index 0000000000..6383a8a898
> --- /dev/null
> +++ b/migration/multifd-zstd.c
> @@ -0,0 +1,337 @@
> +/*
> + * Multifd zlib compression implementation
> + *
> + * Copyright (c) 2020 Red Hat Inc
> + *
> + * Authors:
> + *  Juan Quintela <quintela@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <zstd.h>
> +#include "qemu/rcu.h"
> +#include "exec/target_page.h"
> +#include "qapi/error.h"
> +#include "migration.h"
> +#include "trace.h"
> +#include "multifd.h"
> +
> +struct zstd_data {
> +    /* stream for compression */
> +    ZSTD_CStream *zcs;
> +    /* stream for decompression */
> +    ZSTD_DStream *zds;
> +    /* buffers */
> +    ZSTD_inBuffer in;
> +    ZSTD_outBuffer out;
> +    /* compressed buffer */
> +    uint8_t *zbuff;
> +    /* size of compressed buffer */
> +    uint32_t zbuff_len;
> +};
> +
> +/* Multifd zstd compression */
> +
> +/**
> + * zstd_send_setup: setup send side
> + *
> + * Setup each channel with zstd compression.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size(=
);
> +    struct zstd_data *z =3D g_new0(struct zstd_data, 1);
> +    int res;
> +
> +    p->data =3D z;
> +    z->zcs =3D ZSTD_createCStream();
> +    if (!z->zcs) {
> +        g_free(z);
> +        error_setg(errp, "multifd %d: zstd createCStream failed", p->id)=
;
> +        return -1;
> +    }
> +
> +    res =3D ZSTD_initCStream(z->zcs, migrate_multifd_zstd_level());
> +    if (ZSTD_isError(res)) {
> +        ZSTD_freeCStream(z->zcs);
> +        g_free(z);
> +        error_setg(errp, "multifd %d: initCStream failed", p->id);

It might be useful to print 'res' here - you seem to decode it on the
receive side.

> +        return -1;
> +    }
> +    /* We will never have more than page_count pages */
> +    z->zbuff_len =3D page_count * qemu_target_page_size();
> +    z->zbuff_len *=3D 2;
> +    z->zbuff =3D g_try_malloc(z->zbuff_len);
> +    if (!z->zbuff) {
> +        ZSTD_freeCStream(z->zcs);
> +        g_free(z);
> +        error_setg(errp, "multifd %d: out of memory for zbuff", p->id);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +/**
> + * zstd_send_cleanup: cleanup send side
> + *
> + * Close the channel and return memory.
> + *
> + * @p: Params for the channel that we are using
> + */
> +static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
> +{
> +    struct zstd_data *z =3D p->data;
> +
> +    ZSTD_freeCStream(z->zcs);
> +    z->zcs =3D NULL;
> +    g_free(z->zbuff);
> +    z->zbuff =3D NULL;
> +    g_free(p->data);
> +    p->data =3D NULL;
> +}
> +
> +/**
> + * zstd_send_prepare: prepare date to be able to send
> + *
> + * Create a compressed buffer with all the pages that we are going to
> + * send.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + */
> +static int zstd_send_prepare(MultiFDSendParams *p, uint32_t used, Error =
**errp)
> +{
> +    struct iovec *iov =3D p->pages->iov;
> +    struct zstd_data *z =3D p->data;
> +    int ret;
> +    uint32_t i;
> +
> +    z->out.dst =3D z->zbuff;
> +    z->out.size =3D z->zbuff_len;
> +    z->out.pos =3D 0;
> +
> +    for (i =3D 0; i < used; i++) {
> +        ZSTD_EndDirective flush =3D ZSTD_e_continue;
> +
> +        if (i =3D=3D used - 1) {
> +            flush =3D ZSTD_e_flush;
> +        }
> +        z->in.src =3D iov[i].iov_base;
> +        z->in.size =3D iov[i].iov_len;
> +        z->in.pos =3D 0;
> +
> +        /*
> +         * Welcome to compressStream2 semantics
> +         *
> +         * We need to loop while:
> +         * - return is > 0
> +         * - there is input available
> +         * - there is output space free
> +         */
> +        do {
> +            ret =3D ZSTD_compressStream2(z->zcs, &z->out, &z->in, flush)=
;
> +        } while (ret > 0 && (z->in.size - z->in.pos > 0)
> +                         && (z->out.size - z->out.pos > 0));
> +        if (ret > 0 && (z->in.size - z->in.pos > 0)) {
> +            error_setg(errp, "multifd %d: compressStream buffer too smal=
l",
> +                       p->id);
> +            return -1;
> +        }
> +        if (ZSTD_isError(ret)) {
> +            error_setg(errp, "multifd %d: compressStream error %s",
> +                       p->id, ZSTD_getErrorName(ret));
> +            return -1;
> +        }
> +    }
> +    p->next_packet_size =3D z->out.pos;
> +    p->flags |=3D MULTIFD_FLAG_ZSTD;
> +
> +    return 0;
> +}
> +
> +/**
> + * zstd_send_write: do the actual write of the data
> + *
> + * Do the actual write of the comprresed buffer.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + * @errp: pointer to an error
> + */
> +static int zstd_send_write(MultiFDSendParams *p, uint32_t used, Error **=
errp)
> +{
> +    struct zstd_data *z =3D p->data;
> +
> +    return qio_channel_write_all(p->c, (void *)z->zbuff, p->next_packet_=
size,
> +                                 errp);
> +}
> +
> +/**
> + * zstd_recv_setup: setup receive side
> + *
> + * Create the compressed channel and buffer.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size(=
);
> +    struct zstd_data *z =3D g_new0(struct zstd_data, 1);
> +    int res;
> +
> +    p->data =3D z;
> +    z->zds =3D ZSTD_createDStream();
> +    if (!z->zds) {
> +        g_free(z);
> +        error_setg(errp, "multifd %d: zstd createDStream failed", p->id)=
;
> +        return -1;
> +    }
> +
> +    res =3D ZSTD_initDStream(z->zds);
> +    if (ZSTD_isError(res)) {
> +        ZSTD_freeDStream(z->zds);
> +        g_free(z);
> +        error_setg(errp, "multifd %d: initDStream failed", p->id);
> +        return -1;
> +    }
> +
> +    /* We will never have more than page_count pages */
> +    z->zbuff_len =3D page_count * qemu_target_page_size();
> +    /* We know compression "could" use more space */
> +    z->zbuff_len *=3D 2;
> +    z->zbuff =3D g_try_malloc(z->zbuff_len);
> +    if (!z->zbuff) {
> +        ZSTD_freeDStream(z->zds);
> +        g_free(z);
> +        error_setg(errp, "multifd %d: out of memory for zbuff", p->id);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +/**
> + * zstd_recv_cleanup: setup receive side
> + *
> + * For no compression this function does nothing.
> + *
> + * @p: Params for the channel that we are using
> + */
> +static void zstd_recv_cleanup(MultiFDRecvParams *p)
> +{
> +    struct zstd_data *z =3D p->data;
> +
> +    ZSTD_freeDStream(z->zds);
> +    z->zds =3D NULL;
> +    g_free(z->zbuff);
> +    z->zbuff =3D NULL;
> +    g_free(p->data);
> +    p->data =3D NULL;
> +}
> +
> +/**
> + * zstd_recv_pages: read the data from the channel into actual pages
> + *
> + * Read the compressed buffer, and uncompress it into the actual
> + * pages.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + * @errp: pointer to an error
> + */
> +static int zstd_recv_pages(MultiFDRecvParams *p, uint32_t used, Error **=
errp)
> +{
> +    uint32_t in_size =3D p->next_packet_size;
> +    uint32_t out_size =3D 0;
> +    uint32_t expected_size =3D used * qemu_target_page_size();
> +    uint32_t flags =3D p->flags & MULTIFD_FLAG_METHOD_MASK;
> +    struct zstd_data *z =3D p->data;
> +    int ret;
> +    int i;
> +
> +    if (flags !=3D MULTIFD_FLAG_ZSTD) {
> +        error_setg(errp, "multifd %d: flags received %x flags expected %=
x",
> +                   p->id, flags, MULTIFD_FLAG_ZSTD);
> +        return -1;
> +    }
> +    ret =3D qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp);
> +
> +    if (ret !=3D 0) {
> +        return ret;
> +    }
> +
> +    z->in.src =3D z->zbuff;
> +    z->in.size =3D in_size;
> +    z->in.pos =3D 0;
> +
> +    for (i =3D 0; i < used; i++) {
> +        struct iovec *iov =3D &p->pages->iov[i];
> +
> +        z->out.dst =3D iov->iov_base;
> +        z->out.size =3D iov->iov_len;
> +        z->out.pos =3D 0;
> +
> +        /*
> +         * Welcome to decompressStream semantics
> +         *
> +         * We need to loop while:
> +         * - return is > 0
> +         * - there is input available
> +         * - we haven't put out a full page
> +         */
> +        do {
> +            ret =3D ZSTD_decompressStream(z->zds, &z->out, &z->in);
> +        } while (ret > 0 && (z->in.size - z->in.pos > 0)
> +                         && (z->out.pos < iov->iov_len));
> +        if (ret > 0 && (z->out.pos < iov->iov_len)) {
> +            error_setg(errp, "multifd %d: decompressStream buffer too sm=
all",
> +                       p->id);
> +            return -1;
> +        }
> +        if (ZSTD_isError(ret)) {
> +            error_setg(errp, "multifd %d: decompressStream returned %s",
> +                       p->id, ZSTD_getErrorName(ret));
> +            return ret;
> +        }
> +        out_size +=3D z->out.pos;
> +    }
> +    if (out_size !=3D expected_size) {
> +        error_setg(errp, "multifd %d: packet size received %d size expec=
ted %d",
> +                   p->id, out_size, expected_size);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static MultiFDMethods multifd_zstd_ops =3D {
> +    .send_setup =3D zstd_send_setup,
> +    .send_cleanup =3D zstd_send_cleanup,
> +    .send_prepare =3D zstd_send_prepare,
> +    .send_write =3D zstd_send_write,
> +    .recv_setup =3D zstd_recv_setup,
> +    .recv_cleanup =3D zstd_recv_cleanup,
> +    .recv_pages =3D zstd_recv_pages
> +};
> +
> +static void multifd_zstd_register(void)
> +{
> +    multifd_register_ops(MULTIFD_METHOD_ZSTD, &multifd_zstd_ops);
> +}
> +
> +migration_init(multifd_zstd_register);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 3fa5132f1d..621db316c1 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -30,6 +30,7 @@ int multifd_queue_page(QEMUFile *f, RAMBlock *block, ra=
m_addr_t offset);
>  #define MULTIFD_FLAG_METHOD_MASK (7 << 1)
>  #define MULTIFD_FLAG_NOCOMP (1 << 1)
>  #define MULTIFD_FLAG_ZLIB (2 << 1)
> +#define MULTIFD_FLAG_ZSTD (3 << 1)
> =20
>  /* This value needs to be a multiple of qemu_target_page_size() */
>  #define MULTIFD_PACKET_SIZE (512 * 1024)
> @@ -163,6 +164,5 @@ typedef struct {
>  } MultiFDMethods;
> =20
>  void multifd_register_ops(int method, MultiFDMethods *ops);
> -

Oddment.

>  #endif
> =20
> diff --git a/migration/ram.c b/migration/ram.c
> index 73a141bb60..0ef68798d2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -28,7 +28,6 @@
> =20
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include <zlib.h>
>  #include "qemu/cutils.h"
>  #include "qemu/bitops.h"
>  #include "qemu/bitmap.h"
> diff --git a/qapi/migration.json b/qapi/migration.json
> index bb5cb6b4f4..8ccec7fa79 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -495,12 +495,14 @@
>  #
>  # @none: no compression.
>  # @zlib: use zlib compression method.
> +# @zstd: use zstd compression method.
>  #
>  # Since: 5.0
>  #
>  ##
>  { 'enum': 'MultiFDMethod',
> -  'data': [ 'none', 'zlib' ] }
> +  'data': [ 'none', 'zlib',
> +            { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
> =20
>  ##
>  # @MigrationParameter:
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 8effed205d..ec9be28bc9 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1318,6 +1318,13 @@ static void test_multifd_tcp_zlib(void)
>      test_multifd_tcp("zlib");
>  }
> =20
> +#ifdef CONFIG_ZSTD
> +static void test_multifd_tcp_zstd(void)
> +{
> +    test_multifd_tcp("zstd");
> +}
> +#endif
> +
>  /*
>   * This test does:
>   *  source               target
> @@ -1481,6 +1488,9 @@ int main(int argc, char **argv)
>      qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none)=
;
>      qtest_add_func("/migration/multifd/tcp/cancel", test_multifd_tcp_can=
cel);
>      qtest_add_func("/migration/multifd/tcp/zlib", test_multifd_tcp_zlib)=
;
> +#ifdef CONFIG_ZSTD
> +    qtest_add_func("/migration/multifd/tcp/zstd", test_multifd_tcp_zstd)=
;
> +#endif
> =20
>      ret =3D g_test_run();
> =20
> --=20
> 2.24.1
>=20

Minor comments above; but other than those it looks OK to me, but I've
not used zstd before:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


