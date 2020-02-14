Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFFEC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AD024670
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1dxJQTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AD024670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2cum-00058s-MT
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j2coX-0003DE-DM
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j2coT-0003x5-UB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:23:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40001
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j2coS-0003sD-Ca
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581693807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zbxrFMvBSiHELqD0xeS6LRadciMWNOcqkAbekl8j5O0=;
 b=e1dxJQTbOVfC7k1lSZTEMxekPm4+vaUvQF4SQXmnQXuEVG+hK1K/fvS1HqnZw4LJSY13JR
 XQLq2J+hy2ZptUVsAImr1b/5TxFeFiNAfEQ885eFFh1oLo6i7udkfeZOAxYzWOr6IkmMxv
 2Q3JNM5v3dc/Peu4DBrHidBzCDE4suo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-Ei_vScfaOxKukvVCO7_RBw-1; Fri, 14 Feb 2020 10:23:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 355CB100550E;
 Fri, 14 Feb 2020 15:23:23 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34BA11001B3F;
 Fri, 14 Feb 2020 15:23:18 +0000 (UTC)
Date: Fri, 14 Feb 2020 15:23:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v6 5/8] multifd: Add zlib compression multifd support
Message-ID: <20200214152315.GJ3283@work-vm>
References: <20200213211709.59065-1-quintela@redhat.com>
 <20200213211709.59065-6-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200213211709.59065-6-quintela@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Ei_vScfaOxKukvVCO7_RBw-1
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/core/qdev-properties.c    |   2 +-
>  migration/Makefile.objs      |   1 +
>  migration/multifd-zlib.c     | 325 +++++++++++++++++++++++++++++++++++
>  migration/multifd.c          |   6 +
>  migration/multifd.h          |   4 +
>  qapi/migration.json          |   3 +-
>  tests/qtest/migration-test.c |   6 +
>  7 files changed, 345 insertions(+), 2 deletions(-)
>  create mode 100644 migration/multifd-zlib.c
>=20
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index fa7edac020..db2a7abfb2 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -645,7 +645,7 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
>  const PropertyInfo qdev_prop_multifd_compression =3D {
>      .name =3D "MultiFDCompression",
>      .description =3D "multifd_compression values, "
> -                   "none",
> +                   "none/zlib",
>      .enum_table =3D &MultiFDCompression_lookup,
>      .get =3D get_enum,
>      .set =3D set_enum,
> diff --git a/migration/Makefile.objs b/migration/Makefile.objs
> index d3623d5f9b..0308caa5c5 100644
> --- a/migration/Makefile.objs
> +++ b/migration/Makefile.objs
> @@ -8,6 +8,7 @@ common-obj-y +=3D xbzrle.o postcopy-ram.o
>  common-obj-y +=3D qjson.o
>  common-obj-y +=3D block-dirty-bitmap.o
>  common-obj-y +=3D multifd.o
> +common-obj-y +=3D multifd-zlib.o
> =20
>  common-obj-$(CONFIG_RDMA) +=3D rdma.o
> =20
> diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> new file mode 100644
> index 0000000000..ab4ba75d75
> --- /dev/null
> +++ b/migration/multifd-zlib.c
> @@ -0,0 +1,325 @@
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
> +#include <zlib.h>
> +#include "qemu/rcu.h"
> +#include "exec/target_page.h"
> +#include "qapi/error.h"
> +#include "migration.h"
> +#include "trace.h"
> +#include "multifd.h"
> +
> +struct zlib_data {
> +    /* stream for compression */
> +    z_stream zs;
> +    /* compressed buffer */
> +    uint8_t *zbuff;
> +    /* size of compressed buffer */
> +    uint32_t zbuff_len;
> +};
> +
> +/* Multifd zlib compression */
> +
> +/**
> + * zlib_send_setup: setup send side
> + *
> + * Setup each channel with zlib compression.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size(=
);
> +    struct zlib_data *z =3D g_malloc0(sizeof(struct zlib_data));
> +    z_stream *zs =3D &z->zs;
> +
> +    zs->zalloc =3D Z_NULL;
> +    zs->zfree =3D Z_NULL;
> +    zs->opaque =3D Z_NULL;
> +    if (deflateInit(zs, migrate_multifd_zlib_level()) !=3D Z_OK) {
> +        g_free(z);
> +        error_setg(errp, "multifd %d: deflate init failed", p->id);
> +        return -1;
> +    }
> +    /* We will never have more than page_count pages */
> +    z->zbuff_len =3D page_count * qemu_target_page_size();
> +    z->zbuff_len *=3D 2;
> +    z->zbuff =3D g_try_malloc(z->zbuff_len);
> +    if (!z->zbuff) {
> +        deflateEnd(&z->zs);
> +        g_free(z);
> +        error_setg(errp, "multifd %d: out of memory for zbuff", p->id);
> +        return -1;
> +    }
> +    p->data =3D z;
> +    return 0;
> +}
> +
> +/**
> + * zlib_send_cleanup: cleanup send side
> + *
> + * Close the channel and return memory.
> + *
> + * @p: Params for the channel that we are using
> + */
> +static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
> +{
> +    struct zlib_data *z =3D p->data;
> +
> +    deflateEnd(&z->zs);
> +    g_free(z->zbuff);
> +    z->zbuff =3D NULL;
> +    g_free(p->data);
> +    p->data =3D NULL;
> +}
> +
> +/**
> + * zlib_send_prepare: prepare date to be able to send
> + *
> + * Create a compressed buffer with all the pages that we are going to
> + * send.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + */
> +static int zlib_send_prepare(MultiFDSendParams *p, uint32_t used, Error =
**errp)
> +{
> +    struct iovec *iov =3D p->pages->iov;
> +    struct zlib_data *z =3D p->data;
> +    z_stream *zs =3D &z->zs;
> +    uint32_t out_size =3D 0;
> +    int ret;
> +    uint32_t i;
> +
> +    for (i =3D 0; i < used; i++) {
> +        uint32_t available =3D z->zbuff_len - out_size;
> +        int flush =3D Z_NO_FLUSH;
> +
> +        if (i =3D=3D used - 1) {
> +            flush =3D Z_SYNC_FLUSH;
> +        }
> +
> +        zs->avail_in =3D iov[i].iov_len;
> +        zs->next_in =3D iov[i].iov_base;
> +
> +        zs->avail_out =3D available;
> +        zs->next_out =3D z->zbuff + out_size;
> +
> +        /*
> +         * Welcome to deflate semantics
> +         *
> +         * We need to loop while:
> +         * - return is Z_OK
> +         * - there are stuff to be compressed
> +         * - there are output space free
> +         */
> +        do {
> +            ret =3D deflate(zs, flush);
> +        } while (ret =3D=3D Z_OK && zs->avail_in && zs->avail_out);
> +        if (ret =3D=3D Z_OK && zs->avail_in) {
> +            error_setg(errp, "multifd %d: deflate failed to compress all=
 input",
> +                       p->id);
> +            return -1;
> +        }
> +        if (ret !=3D Z_OK) {
> +            error_setg(errp, "multifd %d: deflate returned %d instead of=
 Z_OK",
> +                       p->id, ret);
> +            return -1;
> +        }
> +        out_size +=3D available - zs->avail_out;
> +    }
> +    p->next_packet_size =3D out_size;
> +    p->flags |=3D MULTIFD_FLAG_ZLIB;
> +
> +    return 0;
> +}
> +
> +/**
> + * zlib_send_write: do the actual write of the data
> + *
> + * Do the actual write of the comprresed buffer.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @used: number of pages used
> + * @errp: pointer to an error
> + */
> +static int zlib_send_write(MultiFDSendParams *p, uint32_t used, Error **=
errp)
> +{
> +    struct zlib_data *z =3D p->data;
> +
> +    return qio_channel_write_all(p->c, (void *)z->zbuff, p->next_packet_=
size,
> +                                 errp);
> +}
> +
> +/**
> + * zlib_recv_setup: setup receive side
> + *
> + * Create the compressed channel and buffer.
> + *
> + * Returns 0 for success or -1 for error
> + *
> + * @p: Params for the channel that we are using
> + * @errp: pointer to an error
> + */
> +static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size(=
);
> +    struct zlib_data *z =3D g_malloc0(sizeof(struct zlib_data));
> +    z_stream *zs =3D &z->zs;
> +
> +    p->data =3D z;
> +    zs->zalloc =3D Z_NULL;
> +    zs->zfree =3D Z_NULL;
> +    zs->opaque =3D Z_NULL;
> +    zs->avail_in =3D 0;
> +    zs->next_in =3D Z_NULL;
> +    if (inflateInit(zs) !=3D Z_OK) {
> +        error_setg(errp, "multifd %d: inflate init failed", p->id);
> +        return -1;
> +    }
> +    /* We will never have more than page_count pages */
> +    z->zbuff_len =3D page_count * qemu_target_page_size();
> +    /* We know compression "could" use more space */
> +    z->zbuff_len *=3D 2;
> +    z->zbuff =3D g_try_malloc(z->zbuff_len);
> +    if (!z->zbuff) {
> +        inflateEnd(zs);
> +        error_setg(errp, "multifd %d: out of memory for zbuff", p->id);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +/**
> + * zlib_recv_cleanup: setup receive side
> + *
> + * For no compression this function does nothing.
> + *
> + * @p: Params for the channel that we are using
> + */
> +static void zlib_recv_cleanup(MultiFDRecvParams *p)
> +{
> +    struct zlib_data *z =3D p->data;
> +
> +    inflateEnd(&z->zs);
> +    g_free(z->zbuff);
> +    z->zbuff =3D NULL;
> +    g_free(p->data);
> +    p->data =3D NULL;
> +}
> +
> +/**
> + * zlib_recv_pages: read the data from the channel into actual pages
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
> +static int zlib_recv_pages(MultiFDRecvParams *p, uint32_t used, Error **=
errp)
> +{
> +    struct zlib_data *z =3D p->data;
> +    z_stream *zs =3D &z->zs;
> +    uint32_t in_size =3D p->next_packet_size;
> +    /* we measure the change of total_out */
> +    uint32_t out_size =3D zs->total_out;
> +    uint32_t expected_size =3D used * qemu_target_page_size();
> +    uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> +    int ret;
> +    int i;
> +
> +    if (flags !=3D MULTIFD_FLAG_ZLIB) {
> +        error_setg(errp, "multifd %d: flags received %x flags expected %=
x",
> +                   p->id, flags, MULTIFD_FLAG_ZLIB);
> +        return -1;
> +    }
> +    ret =3D qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp);
> +
> +    if (ret !=3D 0) {
> +        return ret;
> +    }
> +
> +    zs->avail_in =3D in_size;
> +    zs->next_in =3D z->zbuff;
> +
> +    for (i =3D 0; i < used; i++) {
> +        struct iovec *iov =3D &p->pages->iov[i];
> +        int flush =3D Z_NO_FLUSH;
> +        unsigned long start =3D zs->total_out;
> +
> +        if (i =3D=3D used - 1) {
> +            flush =3D Z_SYNC_FLUSH;
> +        }
> +
> +        zs->avail_out =3D iov->iov_len;
> +        zs->next_out =3D iov->iov_base;
> +
> +        /*
> +         * Welcome to inflate semantics
> +         *
> +         * We need to loop while:
> +         * - return is Z_OK
> +         * - there are input available
> +         * - we haven't completed a full page
> +         */
> +        do {
> +            ret =3D inflate(zs, flush);
> +        } while (ret =3D=3D Z_OK && zs->avail_in
> +                             && (zs->total_out - start) < iov->iov_len);
> +        if (ret =3D=3D Z_OK && (zs->total_out - start) < iov->iov_len) {
> +            error_setg(errp, "multifd %d: inflate generated too few outp=
ut",
> +                       p->id);
> +            return -1;
> +        }
> +        if (ret !=3D Z_OK) {
> +            error_setg(errp, "multifd %d: inflate returned %d instead of=
 Z_OK",
> +                       p->id, ret);
> +            return -1;
> +        }
> +    }
> +    out_size =3D zs->total_out - out_size;
> +    if (out_size !=3D expected_size) {
> +        error_setg(errp, "multifd %d: packet size received %d size expec=
ted %d",
> +                   p->id, out_size, expected_size);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static MultiFDMethods multifd_zlib_ops =3D {
> +    .send_setup =3D zlib_send_setup,
> +    .send_cleanup =3D zlib_send_cleanup,
> +    .send_prepare =3D zlib_send_prepare,
> +    .send_write =3D zlib_send_write,
> +    .recv_setup =3D zlib_recv_setup,
> +    .recv_cleanup =3D zlib_recv_cleanup,
> +    .recv_pages =3D zlib_recv_pages
> +};
> +
> +static void multifd_zlib_register(void)
> +{
> +    multifd_register_ops(MULTIFD_COMPRESSION_ZLIB, &multifd_zlib_ops);
> +}
> +
> +migration_init(multifd_zlib_register);
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 97433e5135..cb6a4a3ab8 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -166,6 +166,12 @@ static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSI=
ON__MAX] =3D {
>      [MULTIFD_COMPRESSION_NONE] =3D &multifd_nocomp_ops,
>  };
> =20
> +void multifd_register_ops(int method, MultiFDMethods *ops)
> +{
> +    assert(0 < method && method < MULTIFD_COMPRESSION__MAX);
> +    multifd_ops[method] =3D ops;
> +}
> +
>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **err=
p)
>  {
>      MultiFDInit_t msg =3D {};
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 54075ffa7d..c6dad7b990 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -23,12 +23,14 @@ void multifd_recv_sync_main(void);
>  void multifd_send_sync_main(QEMUFile *f);
>  int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t offset);
> =20
> +/* Multifd Compression flags */
>  #define MULTIFD_FLAG_SYNC (1 << 0)
> =20
>  /* We reserve 3 bits for compression methods */
>  #define MULTIFD_FLAG_COMPRESSION_MASK (7 << 1)
>  /* we need to be compatible. Before compression value was 0 */
>  #define MULTIFD_FLAG_NOCOMP (0 << 1)
> +#define MULTIFD_FLAG_ZLIB (1 << 1)
> =20
>  /* This value needs to be a multiple of qemu_target_page_size() */
>  #define MULTIFD_PACKET_SIZE (512 * 1024)
> @@ -161,5 +163,7 @@ typedef struct {
>      int (*recv_pages)(MultiFDRecvParams *p, uint32_t used, Error **errp)=
;
>  } MultiFDMethods;
> =20
> +void multifd_register_ops(int method, MultiFDMethods *ops);
> +
>  #endif
> =20
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 0845d926f2..860609231b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -494,12 +494,13 @@
>  # An enumeration of multifd compression methods.
>  #
>  # @none: no compression.
> +# @zlib: use zlib compression method.
>  #
>  # Since: 5.0
>  #
>  ##
>  { 'enum': 'MultiFDCompression',
> -  'data': [ 'none' ] }
> +  'data': [ 'none', 'zlib' ] }
> =20
>  ##
>  # @MigrationParameter:
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index f84c157285..90c26e879f 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1323,6 +1323,11 @@ static void test_multifd_tcp_none(void)
>      test_multifd_tcp("none");
>  }
> =20
> +static void test_multifd_tcp_zlib(void)
> +{
> +    test_multifd_tcp("zlib");
> +}
> +
>  /*
>   * This test does:
>   *  source               target
> @@ -1486,6 +1491,7 @@ int main(int argc, char **argv)
>      qtest_add_func("/migration/auto_converge", test_migrate_auto_converg=
e);
>      qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none)=
;
>      qtest_add_func("/migration/multifd/tcp/cancel", test_multifd_tcp_can=
cel);
> +    qtest_add_func("/migration/multifd/tcp/zlib", test_multifd_tcp_zlib)=
;
> =20
>      ret =3D g_test_run();
> =20
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


