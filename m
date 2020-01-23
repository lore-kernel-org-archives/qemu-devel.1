Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6FFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BAC21569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8RkUZ+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BAC21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudy9-0007jr-VQ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iubVM-0005KK-Hi
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iubVG-0001f2-Sl
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:22:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52870
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iubVG-0001eW-Ix
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579782150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6j2AWOqxBbn0FuqH/IIYdlcTph8BnRAMYSPaT2R0Vd8=;
 b=g8RkUZ+Rna+hi+3lfONn3O3WZ1rINbwlETebraoDsoiPIN9dwVH7Rzi/zpQ7PbMJuYzgCT
 J38LgrGhA0GJh0a7kOL2bdaO7VwyDLZvFx1Z6fAHUz8Ek/dnne9ehm6rNkEVLkQvQDqunl
 0Vsho28DsW6wDKK52X8MXIFNR9tKPD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-J9Qfx6FqMIy_1hhhj7M0KA-1; Thu, 23 Jan 2020 07:22:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE30DDBE6;
 Thu, 23 Jan 2020 12:22:26 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BA7F86CCC;
 Thu, 23 Jan 2020 12:22:24 +0000 (UTC)
Date: Thu, 23 Jan 2020 12:22:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>, xiaoguangrong@tencent.com,
 liang.z.li@intel.com, richardw.yang@linux.intel.com
Subject: Re: [RFC] migration: Remove old compression code
Message-ID: <20200123122221.GE2698@work-vm>
References: <20200123121628.37539-1-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123121628.37539-1-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: J9Qfx6FqMIy_1hhhj7M0KA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> Hi

Lets cc in some people who have previously contributed to the existing
compression code.

> There are several problems with the old compression code:
> * it compress one page at a time (i.e. 4KB)
>=20
> * it has to copy all the page to the compression thread, the
>   compression thread compress it, it copies back the compressed data
>   to the main thread and it sends it there (equivalent for decompress).
>=20
> * It is really slow (both the setup of it, and the compression of each pa=
ge)
>=20
> You can see that in the previous series, I added compression to multifd, =
its advantages are:
> * We compress "chunks" of 128 pages at a time
> * We don't copy anything, we just compress everything that is sent throug=
h the channel
> * We don't send data over the main channel, so we have less overhead
> * I added zstd support, that
>   o  Compress much more
>   o  It is way faster
>=20
> * Using the migration-test values (best option for compressors, as we
>   only change one byte on each page):
>   * zstd is around the same latency than no compression (i.e. it takes th=
e same time)
>   * zlib needs 2500 bytes to send 128 pages compressed (remember 1
>     byte changed in each page, rest are zeros)
>   * zstd needs 52 bytes for the same packets (yes, I checked several
>     times, it appears that its use of dictionaries is good here)
>=20
> This is an RFC, you will ask why?
> There are several questions:
> * How to proceed to remove this?
>    - Deprecate it into the future?
>      Has the advantage that customers can continue using it.
>      But it is not so stable to use it.
>    - Remove it now?
>      Has the advantage of much less code, but ....
> * Statistics:
>   Several of the statistics are already only printed when compression is
>   being used. My understanding is that we ase safe removing this ones.
> * But whan about the migration_parameters?  Should we leave them
>   alone, and just don't care about them? Should we remove them?
> * What to do with migration.json changes?  I will apprecciate comments he=
re.
>=20
> Thanks, Juan.
>=20
> PD.  You can see from the previous series that putting compression on
>      top of multifd + splitting the code in different files + making it o=
ptional:
>      around 1040 new lines of code.
>      Removing this ~ 960 lines of code.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/core/machine.c     |   1 -
>  migration/migration.c | 112 --------
>  migration/migration.h |  11 -
>  migration/qemu-file.c |  77 -----
>  migration/qemu-file.h |   3 -
>  migration/ram.c       | 650 +-----------------------------------------
>  migration/ram.h       |   1 -
>  monitor/hmp-cmds.c    |  37 ---
>  qapi/migration.json   |  79 +----
>  9 files changed, 9 insertions(+), 962 deletions(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 3e288bfceb..2424662f5e 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -76,7 +76,6 @@ GlobalProperty hw_compat_3_0[] =3D {};
>  const size_t hw_compat_3_0_len =3D G_N_ELEMENTS(hw_compat_3_0);
> =20
>  GlobalProperty hw_compat_2_12[] =3D {
> -    { "migration", "decompress-error-check", "off" },
>      { "hda-audio", "use-timer", "false" },
>      { "cirrus-vga", "global-vmstate", "true" },
>      { "VGA", "global-vmstate", "true" },
> diff --git a/migration/migration.c b/migration/migration.c
> index f0d5ade1df..fad5c4faf4 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -70,11 +70,6 @@
>  #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
>  #define MAX_MIGRATE_DOWNTIME (MAX_MIGRATE_DOWNTIME_SECONDS * 1000)
> =20
> -/* Default compression thread count */
> -#define DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT 8
> -/* Default decompression thread count, usually decompression is at
> - * least 4 times as fast as compression.*/
> -#define DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT 2
>  /*0: means nocompress, 1: best speed, ... 9: best compress ratio */
>  #define DEFAULT_MIGRATE_COMPRESS_LEVEL 1
>  /* Define default autoconverge cpu throttle migration parameters */
> @@ -773,12 +768,6 @@ MigrationParameters *qmp_query_migrate_parameters(Er=
ror **errp)
>      params =3D g_malloc0(sizeof(*params));
>      params->has_compress_level =3D true;
>      params->compress_level =3D s->parameters.compress_level;
> -    params->has_compress_threads =3D true;
> -    params->compress_threads =3D s->parameters.compress_threads;
> -    params->has_compress_wait_thread =3D true;
> -    params->compress_wait_thread =3D s->parameters.compress_wait_thread;
> -    params->has_decompress_threads =3D true;
> -    params->decompress_threads =3D s->parameters.decompress_threads;
>      params->has_cpu_throttle_initial =3D true;
>      params->cpu_throttle_initial =3D s->parameters.cpu_throttle_initial;
>      params->has_cpu_throttle_increment =3D true;
> @@ -926,18 +915,6 @@ static void populate_ram_info(MigrationInfo *info, M=
igrationState *s)
>          info->xbzrle_cache->overflow =3D xbzrle_counters.overflow;
>      }
> =20
> -    if (migrate_use_compression()) {
> -        info->has_compression =3D true;
> -        info->compression =3D g_malloc0(sizeof(*info->compression));
> -        info->compression->pages =3D compression_counters.pages;
> -        info->compression->busy =3D compression_counters.busy;
> -        info->compression->busy_rate =3D compression_counters.busy_rate;
> -        info->compression->compressed_size =3D
> -                                    compression_counters.compressed_size=
;
> -        info->compression->compression_rate =3D
> -                                    compression_counters.compression_rat=
e;
> -    }
> -
>      if (cpu_throttle_active()) {
>          info->has_cpu_throttle_percentage =3D true;
>          info->cpu_throttle_percentage =3D cpu_throttle_get_percentage();
> @@ -1153,20 +1130,6 @@ static bool migrate_params_check(MigrationParamete=
rs *params, Error **errp)
>          return false;
>      }
> =20
> -    if (params->has_compress_threads && (params->compress_threads < 1)) =
{
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "compress_threads",
> -                   "is invalid, it should be in the range of 1 to 255");
> -        return false;
> -    }
> -
> -    if (params->has_decompress_threads && (params->decompress_threads < =
1)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "decompress_threads",
> -                   "is invalid, it should be in the range of 1 to 255");
> -        return false;
> -    }
> -
>      if (params->has_cpu_throttle_initial &&
>          (params->cpu_throttle_initial < 1 ||
>           params->cpu_throttle_initial > 99)) {
> @@ -1276,18 +1239,6 @@ static void migrate_params_test_apply(MigrateSetPa=
rameters *params,
>          dest->compress_level =3D params->compress_level;
>      }
> =20
> -    if (params->has_compress_threads) {
> -        dest->compress_threads =3D params->compress_threads;
> -    }
> -
> -    if (params->has_compress_wait_thread) {
> -        dest->compress_wait_thread =3D params->compress_wait_thread;
> -    }
> -
> -    if (params->has_decompress_threads) {
> -        dest->decompress_threads =3D params->decompress_threads;
> -    }
> -
>      if (params->has_cpu_throttle_initial) {
>          dest->cpu_throttle_initial =3D params->cpu_throttle_initial;
>      }
> @@ -1360,18 +1311,6 @@ static void migrate_params_apply(MigrateSetParamet=
ers *params, Error **errp)
>          s->parameters.compress_level =3D params->compress_level;
>      }
> =20
> -    if (params->has_compress_threads) {
> -        s->parameters.compress_threads =3D params->compress_threads;
> -    }
> -
> -    if (params->has_compress_wait_thread) {
> -        s->parameters.compress_wait_thread =3D params->compress_wait_thr=
ead;
> -    }
> -
> -    if (params->has_decompress_threads) {
> -        s->parameters.decompress_threads =3D params->decompress_threads;
> -    }
> -
>      if (params->has_cpu_throttle_initial) {
>          s->parameters.cpu_throttle_initial =3D params->cpu_throttle_init=
ial;
>      }
> @@ -2142,15 +2081,6 @@ bool migrate_postcopy_blocktime(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTI=
ME];
>  }
> =20
> -bool migrate_use_compression(void)
> -{
> -    MigrationState *s;
> -
> -    s =3D migrate_get_current();
> -
> -    return s->enabled_capabilities[MIGRATION_CAPABILITY_COMPRESS];
> -}
> -
>  int migrate_compress_level(void)
>  {
>      MigrationState *s;
> @@ -2160,33 +2090,6 @@ int migrate_compress_level(void)
>      return s->parameters.compress_level;
>  }
> =20
> -int migrate_compress_threads(void)
> -{
> -    MigrationState *s;
> -
> -    s =3D migrate_get_current();
> -
> -    return s->parameters.compress_threads;
> -}
> -
> -int migrate_compress_wait_thread(void)
> -{
> -    MigrationState *s;
> -
> -    s =3D migrate_get_current();
> -
> -    return s->parameters.compress_wait_thread;
> -}
> -
> -int migrate_decompress_threads(void)
> -{
> -    MigrationState *s;
> -
> -    s =3D migrate_get_current();
> -
> -    return s->parameters.decompress_threads;
> -}
> -
>  bool migrate_dirty_bitmaps(void)
>  {
>      MigrationState *s;
> @@ -3489,8 +3392,6 @@ void migration_global_dump(Monitor *mon)
>                     ms->send_configuration ? "on" : "off");
>      monitor_printf(mon, "send-section-footer: %s\n",
>                     ms->send_section_footer ? "on" : "off");
> -    monitor_printf(mon, "decompress-error-check: %s\n",
> -                   ms->decompress_error_check ? "on" : "off");
>      monitor_printf(mon, "clear-bitmap-shift: %u\n",
>                     ms->clear_bitmap_shift);
>  }
> @@ -3505,8 +3406,6 @@ static Property migration_properties[] =3D {
>                       send_configuration, true),
>      DEFINE_PROP_BOOL("send-section-footer", MigrationState,
>                       send_section_footer, true),
> -    DEFINE_PROP_BOOL("decompress-error-check", MigrationState,
> -                      decompress_error_check, true),
>      DEFINE_PROP_UINT8("x-clear-bitmap-shift", MigrationState,
>                        clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
> =20
> @@ -3514,14 +3413,6 @@ static Property migration_properties[] =3D {
>      DEFINE_PROP_UINT8("x-compress-level", MigrationState,
>                        parameters.compress_level,
>                        DEFAULT_MIGRATE_COMPRESS_LEVEL),
> -    DEFINE_PROP_UINT8("x-compress-threads", MigrationState,
> -                      parameters.compress_threads,
> -                      DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT),
> -    DEFINE_PROP_BOOL("x-compress-wait-thread", MigrationState,
> -                      parameters.compress_wait_thread, true),
> -    DEFINE_PROP_UINT8("x-decompress-threads", MigrationState,
> -                      parameters.decompress_threads,
> -                      DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT),
>      DEFINE_PROP_UINT8("x-cpu-throttle-initial", MigrationState,
>                        parameters.cpu_throttle_initial,
>                        DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL),
> @@ -3569,7 +3460,6 @@ static Property migration_properties[] =3D {
>      DEFINE_PROP_MIG_CAP("x-rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_=
ALL),
>      DEFINE_PROP_MIG_CAP("x-auto-converge", MIGRATION_CAPABILITY_AUTO_CON=
VERGE),
>      DEFINE_PROP_MIG_CAP("x-zero-blocks", MIGRATION_CAPABILITY_ZERO_BLOCK=
S),
> -    DEFINE_PROP_MIG_CAP("x-compress", MIGRATION_CAPABILITY_COMPRESS),
>      DEFINE_PROP_MIG_CAP("x-events", MIGRATION_CAPABILITY_EVENTS),
>      DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_=
RAM),
>      DEFINE_PROP_MIG_CAP("x-colo", MIGRATION_CAPABILITY_X_COLO),
> @@ -3623,8 +3513,6 @@ static void migration_instance_init(Object *obj)
> =20
>      /* Set has_* up only for parameter checks */
>      params->has_compress_level =3D true;
> -    params->has_compress_threads =3D true;
> -    params->has_decompress_threads =3D true;
>      params->has_cpu_throttle_initial =3D true;
>      params->has_cpu_throttle_increment =3D true;
>      params->has_max_bandwidth =3D true;
> diff --git a/migration/migration.h b/migration/migration.h
> index 3b0b413a93..21ef1838d2 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -244,13 +244,6 @@ struct MigrationState
>      /* Needed by postcopy-pause state */
>      QemuSemaphore postcopy_pause_sem;
>      QemuSemaphore postcopy_pause_rp_sem;
> -    /*
> -     * Whether we abort the migration if decompression errors are
> -     * detected at the destination. It is left at false for qemu
> -     * older than 3.0, since only newer qemu sends streams that
> -     * do not trigger spurious decompression errors.
> -     */
> -    bool decompress_error_check;
> =20
>      /*
>       * This decides the size of guest memory chunk that will be used
> @@ -313,11 +306,7 @@ bool migrate_use_return_path(void);
> =20
>  uint64_t ram_get_total_transferred_pages(void);
> =20
> -bool migrate_use_compression(void);
>  int migrate_compress_level(void);
> -int migrate_compress_threads(void);
> -int migrate_compress_wait_thread(void);
> -int migrate_decompress_threads(void);
>  bool migrate_use_events(void);
>  bool migrate_postcopy_blocktime(void);
> =20
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index bbb2b63927..1f14744f22 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -737,83 +737,6 @@ uint64_t qemu_get_be64(QEMUFile *f)
>      return v;
>  }
> =20
> -/* return the size after compression, or negative value on error */
> -static int qemu_compress_data(z_stream *stream, uint8_t *dest, size_t de=
st_len,
> -                              const uint8_t *source, size_t source_len)
> -{
> -    int err;
> -
> -    err =3D deflateReset(stream);
> -    if (err !=3D Z_OK) {
> -        return -1;
> -    }
> -
> -    stream->avail_in =3D source_len;
> -    stream->next_in =3D (uint8_t *)source;
> -    stream->avail_out =3D dest_len;
> -    stream->next_out =3D dest;
> -
> -    err =3D deflate(stream, Z_FINISH);
> -    if (err !=3D Z_STREAM_END) {
> -        return -1;
> -    }
> -
> -    return stream->next_out - dest;
> -}
> -
> -/* Compress size bytes of data start at p and store the compressed
> - * data to the buffer of f.
> - *
> - * When f is not writable, return -1 if f has no space to save the
> - * compressed data.
> - * When f is wirtable and it has no space to save the compressed data,
> - * do fflush first, if f still has no space to save the compressed
> - * data, return -1.
> - */
> -ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
> -                                  const uint8_t *p, size_t size)
> -{
> -    ssize_t blen =3D IO_BUF_SIZE - f->buf_index - sizeof(int32_t);
> -
> -    if (blen < compressBound(size)) {
> -        if (!qemu_file_is_writable(f)) {
> -            return -1;
> -        }
> -        qemu_fflush(f);
> -        blen =3D IO_BUF_SIZE - sizeof(int32_t);
> -        if (blen < compressBound(size)) {
> -            return -1;
> -        }
> -    }
> -
> -    blen =3D qemu_compress_data(stream, f->buf + f->buf_index + sizeof(i=
nt32_t),
> -                              blen, p, size);
> -    if (blen < 0) {
> -        return -1;
> -    }
> -
> -    qemu_put_be32(f, blen);
> -    add_buf_to_iovec(f, blen);
> -    return blen + sizeof(int32_t);
> -}
> -
> -/* Put the data in the buffer of f_src to the buffer of f_des, and
> - * then reset the buf_index of f_src to 0.
> - */
> -
> -int qemu_put_qemu_file(QEMUFile *f_des, QEMUFile *f_src)
> -{
> -    int len =3D 0;
> -
> -    if (f_src->buf_index > 0) {
> -        len =3D f_src->buf_index;
> -        qemu_put_buffer(f_des, f_src->buf, f_src->buf_index);
> -        f_src->buf_index =3D 0;
> -        f_src->iovcnt =3D 0;
> -    }
> -    return len;
> -}
> -
>  /*
>   * Get a string whose length is determined by a single preceding byte
>   * A preallocated 256 byte buffer must be passed in.
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index a9b6d6ccb7..dd0161fbdc 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -138,9 +138,6 @@ bool qemu_file_is_writable(QEMUFile *f);
> =20
>  size_t qemu_peek_buffer(QEMUFile *f, uint8_t **buf, size_t size, size_t =
offset);
>  size_t qemu_get_buffer_in_place(QEMUFile *f, uint8_t **buf, size_t size)=
;
> -ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
> -                                  const uint8_t *p, size_t size);
> -int qemu_put_qemu_file(QEMUFile *f_des, QEMUFile *f_src);
> =20
>  /*
>   * Note that you can only peek continuous bytes from where the current p=
ointer
> diff --git a/migration/ram.c b/migration/ram.c
> index 0ef68798d2..557dbb104b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -73,7 +73,7 @@
>  #define RAM_SAVE_FLAG_CONTINUE 0x20
>  #define RAM_SAVE_FLAG_XBZRLE   0x40
>  /* 0x80 is reserved in migration.h start with 0x100 next */
> -#define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
> +/* 0x100 was RAM_SAVE_FLAG_COMPRESS_PAGE */
> =20
>  static inline bool is_zero_range(uint8_t *p, uint64_t size)
>  {
> @@ -327,15 +327,6 @@ struct RAMState {
>      uint64_t num_dirty_pages_period;
>      /* xbzrle misses since the beginning of the period */
>      uint64_t xbzrle_cache_miss_prev;
> -
> -    /* compression statistics since the beginning of the period */
> -    /* amount of count that no free thread to compress data */
> -    uint64_t compress_thread_busy_prev;
> -    /* amount bytes after compression */
> -    uint64_t compressed_size_prev;
> -    /* amount of compressed pages */
> -    uint64_t compress_pages_prev;
> -
>      /* total handled target pages at the beginning of period */
>      uint64_t target_page_count_prev;
>      /* total handled target pages since start */
> @@ -408,172 +399,6 @@ struct PageSearchStatus {
>  };
>  typedef struct PageSearchStatus PageSearchStatus;
> =20
> -CompressionStats compression_counters;
> -
> -struct CompressParam {
> -    bool done;
> -    bool quit;
> -    bool zero_page;
> -    QEMUFile *file;
> -    QemuMutex mutex;
> -    QemuCond cond;
> -    RAMBlock *block;
> -    ram_addr_t offset;
> -
> -    /* internally used fields */
> -    z_stream stream;
> -    uint8_t *originbuf;
> -};
> -typedef struct CompressParam CompressParam;
> -
> -struct DecompressParam {
> -    bool done;
> -    bool quit;
> -    QemuMutex mutex;
> -    QemuCond cond;
> -    void *des;
> -    uint8_t *compbuf;
> -    int len;
> -    z_stream stream;
> -};
> -typedef struct DecompressParam DecompressParam;
> -
> -static CompressParam *comp_param;
> -static QemuThread *compress_threads;
> -/* comp_done_cond is used to wake up the migration thread when
> - * one of the compression threads has finished the compression.
> - * comp_done_lock is used to co-work with comp_done_cond.
> - */
> -static QemuMutex comp_done_lock;
> -static QemuCond comp_done_cond;
> -/* The empty QEMUFileOps will be used by file in CompressParam */
> -static const QEMUFileOps empty_ops =3D { };
> -
> -static QEMUFile *decomp_file;
> -static DecompressParam *decomp_param;
> -static QemuThread *decompress_threads;
> -static QemuMutex decomp_done_lock;
> -static QemuCond decomp_done_cond;
> -
> -static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock=
 *block,
> -                                 ram_addr_t offset, uint8_t *source_buf)=
;
> -
> -static void *do_data_compress(void *opaque)
> -{
> -    CompressParam *param =3D opaque;
> -    RAMBlock *block;
> -    ram_addr_t offset;
> -    bool zero_page;
> -
> -    qemu_mutex_lock(&param->mutex);
> -    while (!param->quit) {
> -        if (param->block) {
> -            block =3D param->block;
> -            offset =3D param->offset;
> -            param->block =3D NULL;
> -            qemu_mutex_unlock(&param->mutex);
> -
> -            zero_page =3D do_compress_ram_page(param->file, &param->stre=
am,
> -                                             block, offset, param->origi=
nbuf);
> -
> -            qemu_mutex_lock(&comp_done_lock);
> -            param->done =3D true;
> -            param->zero_page =3D zero_page;
> -            qemu_cond_signal(&comp_done_cond);
> -            qemu_mutex_unlock(&comp_done_lock);
> -
> -            qemu_mutex_lock(&param->mutex);
> -        } else {
> -            qemu_cond_wait(&param->cond, &param->mutex);
> -        }
> -    }
> -    qemu_mutex_unlock(&param->mutex);
> -
> -    return NULL;
> -}
> -
> -static void compress_threads_save_cleanup(void)
> -{
> -    int i, thread_count;
> -
> -    if (!migrate_use_compression() || !comp_param) {
> -        return;
> -    }
> -
> -    thread_count =3D migrate_compress_threads();
> -    for (i =3D 0; i < thread_count; i++) {
> -        /*
> -         * we use it as a indicator which shows if the thread is
> -         * properly init'd or not
> -         */
> -        if (!comp_param[i].file) {
> -            break;
> -        }
> -
> -        qemu_mutex_lock(&comp_param[i].mutex);
> -        comp_param[i].quit =3D true;
> -        qemu_cond_signal(&comp_param[i].cond);
> -        qemu_mutex_unlock(&comp_param[i].mutex);
> -
> -        qemu_thread_join(compress_threads + i);
> -        qemu_mutex_destroy(&comp_param[i].mutex);
> -        qemu_cond_destroy(&comp_param[i].cond);
> -        deflateEnd(&comp_param[i].stream);
> -        g_free(comp_param[i].originbuf);
> -        qemu_fclose(comp_param[i].file);
> -        comp_param[i].file =3D NULL;
> -    }
> -    qemu_mutex_destroy(&comp_done_lock);
> -    qemu_cond_destroy(&comp_done_cond);
> -    g_free(compress_threads);
> -    g_free(comp_param);
> -    compress_threads =3D NULL;
> -    comp_param =3D NULL;
> -}
> -
> -static int compress_threads_save_setup(void)
> -{
> -    int i, thread_count;
> -
> -    if (!migrate_use_compression()) {
> -        return 0;
> -    }
> -    thread_count =3D migrate_compress_threads();
> -    compress_threads =3D g_new0(QemuThread, thread_count);
> -    comp_param =3D g_new0(CompressParam, thread_count);
> -    qemu_cond_init(&comp_done_cond);
> -    qemu_mutex_init(&comp_done_lock);
> -    for (i =3D 0; i < thread_count; i++) {
> -        comp_param[i].originbuf =3D g_try_malloc(TARGET_PAGE_SIZE);
> -        if (!comp_param[i].originbuf) {
> -            goto exit;
> -        }
> -
> -        if (deflateInit(&comp_param[i].stream,
> -                        migrate_compress_level()) !=3D Z_OK) {
> -            g_free(comp_param[i].originbuf);
> -            goto exit;
> -        }
> -
> -        /* comp_param[i].file is just used as a dummy buffer to save dat=
a,
> -         * set its ops to empty.
> -         */
> -        comp_param[i].file =3D qemu_fopen_ops(NULL, &empty_ops);
> -        comp_param[i].done =3D true;
> -        comp_param[i].quit =3D false;
> -        qemu_mutex_init(&comp_param[i].mutex);
> -        qemu_cond_init(&comp_param[i].cond);
> -        qemu_thread_create(compress_threads + i, "compress",
> -                           do_data_compress, comp_param + i,
> -                           QEMU_THREAD_JOINABLE);
> -    }
> -    return 0;
> -
> -exit:
> -    compress_threads_save_cleanup();
> -    return -1;
> -}
> -
>  /**
>   * save_page_header: write page header to wire
>   *
> @@ -853,13 +678,12 @@ uint64_t ram_pagesize_summary(void)
>  uint64_t ram_get_total_transferred_pages(void)
>  {
>      return  ram_counters.normal + ram_counters.duplicate +
> -                compression_counters.pages + xbzrle_counters.pages;
> +            xbzrle_counters.pages;
>  }
> =20
>  static void migration_update_rates(RAMState *rs, int64_t end_time)
>  {
>      uint64_t page_count =3D rs->target_page_count - rs->target_page_coun=
t_prev;
> -    double compressed_size;
> =20
>      /* calculate period counters */
>      ram_counters.dirty_pages_rate =3D rs->num_dirty_pages_period * 1000
> @@ -874,26 +698,6 @@ static void migration_update_rates(RAMState *rs, int=
64_t end_time)
>              rs->xbzrle_cache_miss_prev) / page_count;
>          rs->xbzrle_cache_miss_prev =3D xbzrle_counters.cache_miss;
>      }
> -
> -    if (migrate_use_compression()) {
> -        compression_counters.busy_rate =3D (double)(compression_counters=
.busy -
> -            rs->compress_thread_busy_prev) / page_count;
> -        rs->compress_thread_busy_prev =3D compression_counters.busy;
> -
> -        compressed_size =3D compression_counters.compressed_size -
> -                          rs->compressed_size_prev;
> -        if (compressed_size) {
> -            double uncompressed_size =3D (compression_counters.pages -
> -                                    rs->compress_pages_prev) * TARGET_PA=
GE_SIZE;
> -
> -            /* Compression-Ratio =3D Uncompressed-size / Compressed-size=
 */
> -            compression_counters.compression_rate =3D
> -                                        uncompressed_size / compressed_s=
ize;
> -
> -            rs->compress_pages_prev =3D compression_counters.pages;
> -            rs->compressed_size_prev =3D compression_counters.compressed=
_size;
> -        }
> -    }
>  }
> =20
>  static void migration_bitmap_sync(RAMState *rs)
> @@ -1161,131 +965,6 @@ static int ram_save_multifd_page(RAMState *rs, RAM=
Block *block,
>      return 1;
>  }
> =20
> -static bool do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock=
 *block,
> -                                 ram_addr_t offset, uint8_t *source_buf)
> -{
> -    RAMState *rs =3D ram_state;
> -    uint8_t *p =3D block->host + (offset & TARGET_PAGE_MASK);
> -    bool zero_page =3D false;
> -    int ret;
> -
> -    if (save_zero_page_to_file(rs, f, block, offset)) {
> -        zero_page =3D true;
> -        goto exit;
> -    }
> -
> -    save_page_header(rs, f, block, offset | RAM_SAVE_FLAG_COMPRESS_PAGE)=
;
> -
> -    /*
> -     * copy it to a internal buffer to avoid it being modified by VM
> -     * so that we can catch up the error during compression and
> -     * decompression
> -     */
> -    memcpy(source_buf, p, TARGET_PAGE_SIZE);
> -    ret =3D qemu_put_compression_data(f, stream, source_buf, TARGET_PAGE=
_SIZE);
> -    if (ret < 0) {
> -        qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
> -        error_report("compressed data failed!");
> -        return false;
> -    }
> -
> -exit:
> -    ram_release_pages(block->idstr, offset & TARGET_PAGE_MASK, 1);
> -    return zero_page;
> -}
> -
> -static void
> -update_compress_thread_counts(const CompressParam *param, int bytes_xmit=
)
> -{
> -    ram_counters.transferred +=3D bytes_xmit;
> -
> -    if (param->zero_page) {
> -        ram_counters.duplicate++;
> -        return;
> -    }
> -
> -    /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
> -    compression_counters.compressed_size +=3D bytes_xmit - 8;
> -    compression_counters.pages++;
> -}
> -
> -static bool save_page_use_compression(RAMState *rs);
> -
> -static void flush_compressed_data(RAMState *rs)
> -{
> -    int idx, len, thread_count;
> -
> -    if (!save_page_use_compression(rs)) {
> -        return;
> -    }
> -    thread_count =3D migrate_compress_threads();
> -
> -    qemu_mutex_lock(&comp_done_lock);
> -    for (idx =3D 0; idx < thread_count; idx++) {
> -        while (!comp_param[idx].done) {
> -            qemu_cond_wait(&comp_done_cond, &comp_done_lock);
> -        }
> -    }
> -    qemu_mutex_unlock(&comp_done_lock);
> -
> -    for (idx =3D 0; idx < thread_count; idx++) {
> -        qemu_mutex_lock(&comp_param[idx].mutex);
> -        if (!comp_param[idx].quit) {
> -            len =3D qemu_put_qemu_file(rs->f, comp_param[idx].file);
> -            /*
> -             * it's safe to fetch zero_page without holding comp_done_lo=
ck
> -             * as there is no further request submitted to the thread,
> -             * i.e, the thread should be waiting for a request at this p=
oint.
> -             */
> -            update_compress_thread_counts(&comp_param[idx], len);
> -        }
> -        qemu_mutex_unlock(&comp_param[idx].mutex);
> -    }
> -}
> -
> -static inline void set_compress_params(CompressParam *param, RAMBlock *b=
lock,
> -                                       ram_addr_t offset)
> -{
> -    param->block =3D block;
> -    param->offset =3D offset;
> -}
> -
> -static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block=
,
> -                                           ram_addr_t offset)
> -{
> -    int idx, thread_count, bytes_xmit =3D -1, pages =3D -1;
> -    bool wait =3D migrate_compress_wait_thread();
> -
> -    thread_count =3D migrate_compress_threads();
> -    qemu_mutex_lock(&comp_done_lock);
> -retry:
> -    for (idx =3D 0; idx < thread_count; idx++) {
> -        if (comp_param[idx].done) {
> -            comp_param[idx].done =3D false;
> -            bytes_xmit =3D qemu_put_qemu_file(rs->f, comp_param[idx].fil=
e);
> -            qemu_mutex_lock(&comp_param[idx].mutex);
> -            set_compress_params(&comp_param[idx], block, offset);
> -            qemu_cond_signal(&comp_param[idx].cond);
> -            qemu_mutex_unlock(&comp_param[idx].mutex);
> -            pages =3D 1;
> -            update_compress_thread_counts(&comp_param[idx], bytes_xmit);
> -            break;
> -        }
> -    }
> -
> -    /*
> -     * wait for the free thread if the user specifies 'compress-wait-thr=
ead',
> -     * otherwise we will post the page out in the main thread as normal =
page.
> -     */
> -    if (pages < 0 && wait) {
> -        qemu_cond_wait(&comp_done_cond, &comp_done_lock);
> -        goto retry;
> -    }
> -    qemu_mutex_unlock(&comp_done_lock);
> -
> -    return pages;
> -}
> -
>  /**
>   * find_dirty_block: find the next dirty page and update any state
>   * associated with the search process.
> @@ -1314,17 +993,6 @@ static bool find_dirty_block(RAMState *rs, PageSear=
chStatus *pss, bool *again)
>          pss->page =3D 0;
>          pss->block =3D QLIST_NEXT_RCU(pss->block, next);
>          if (!pss->block) {
> -            /*
> -             * If memory migration starts over, we will meet a dirtied p=
age
> -             * which may still exists in compression threads's ring, so =
we
> -             * should flush the compressed data to make sure the new pag=
e
> -             * is not overwritten by the old one in the destination.
> -             *
> -             * Also If xbzrle is on, stop using the data compression at =
this
> -             * point. In theory, xbzrle can do better than compression.
> -             */
> -            flush_compressed_data(rs);
> -
>              /* Hit the end of the list */
>              pss->block =3D QLIST_FIRST_RCU(&ram_list.blocks);
>              /* Flag that we've looped */
> @@ -1535,58 +1203,6 @@ int ram_save_queue_pages(const char *rbname, ram_a=
ddr_t start, ram_addr_t len)
>      return 0;
>  }
> =20
> -static bool save_page_use_compression(RAMState *rs)
> -{
> -    if (!migrate_use_compression()) {
> -        return false;
> -    }
> -
> -    /*
> -     * If xbzrle is on, stop using the data compression after first
> -     * round of migration even if compression is enabled. In theory,
> -     * xbzrle can do better than compression.
> -     */
> -    if (rs->ram_bulk_stage || !migrate_use_xbzrle()) {
> -        return true;
> -    }
> -
> -    return false;
> -}
> -
> -/*
> - * try to compress the page before posting it out, return true if the pa=
ge
> - * has been properly handled by compression, otherwise needs other
> - * paths to handle it
> - */
> -static bool save_compress_page(RAMState *rs, RAMBlock *block, ram_addr_t=
 offset)
> -{
> -    if (!save_page_use_compression(rs)) {
> -        return false;
> -    }
> -
> -    /*
> -     * When starting the process of a new block, the first page of
> -     * the block should be sent out before other pages in the same
> -     * block, and all the pages in last block should have been sent
> -     * out, keeping this order is important, because the 'cont' flag
> -     * is used to avoid resending the block name.
> -     *
> -     * We post the fist page as normal page as compression will take
> -     * much CPU resource.
> -     */
> -    if (block !=3D rs->last_sent_block) {
> -        flush_compressed_data(rs);
> -        return false;
> -    }
> -
> -    if (compress_page_with_multi_thread(rs, block, offset) > 0) {
> -        return true;
> -    }
> -
> -    compression_counters.busy++;
> -    return false;
> -}
> -
>  /**
>   * ram_save_target_page: save one target page
>   *
> @@ -1607,16 +1223,12 @@ static int ram_save_target_page(RAMState *rs, Pag=
eSearchStatus *pss,
>          return res;
>      }
> =20
> -    if (save_compress_page(rs, block, offset)) {
> -        return 1;
> -    }
> -
>      res =3D save_zero_page(rs, block, offset);
>      if (res > 0) {
>          /* Must let xbzrle know, otherwise a previous (now 0'd) cached
>           * page would be stale
>           */
> -        if (!save_page_use_compression(rs)) {
> +        if (migrate_use_xbzrle()) {
>              XBZRLE_cache_lock();
>              xbzrle_cache_zero_page(rs, block->offset + offset);
>              XBZRLE_cache_unlock();
> @@ -1631,7 +1243,7 @@ static int ram_save_target_page(RAMState *rs, PageS=
earchStatus *pss,
>       *    before sending the compressed page
>       * 2. In postcopy as one whole host page should be placed
>       */
> -    if (!save_page_use_compression(rs) && migrate_use_multifd()
> +    if (!migrate_use_xbzrle() && migrate_use_multifd()
>          && !migration_in_postcopy()) {
>          return ram_save_multifd_page(rs, block, offset);
>      }
> @@ -1841,7 +1453,6 @@ static void ram_save_cleanup(void *opaque)
>      }
> =20
>      xbzrle_cleanup();
> -    compress_threads_save_cleanup();
>      ram_state_cleanup(rsp);
>  }
> =20
> @@ -2418,14 +2029,9 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e)
>      RAMState **rsp =3D opaque;
>      RAMBlock *block;
> =20
> -    if (compress_threads_save_setup()) {
> -        return -1;
> -    }
> -
>      /* migration has already setup the bitmap, reuse it. */
>      if (!migration_in_colo_state()) {
>          if (ram_init_all(rsp) !=3D 0) {
> -            compress_threads_save_cleanup();
>              return -1;
>          }
>      }
> @@ -2516,14 +2122,6 @@ static int ram_save_iterate(QEMUFile *f, void *opa=
que)
> =20
>              rs->target_page_count +=3D pages;
> =20
> -            /*
> -             * During postcopy, it is necessary to make sure one whole h=
ost
> -             * page is sent in one chunk.
> -             */
> -            if (migrate_postcopy_ram()) {
> -                flush_compressed_data(rs);
> -            }
> -
>              /*
>               * we want to check in the 1st loop, just in case it was the=
 1st
>               * time and we had to sync the dirty bitmap.
> @@ -2605,7 +2203,6 @@ static int ram_save_complete(QEMUFile *f, void *opa=
que)
>              }
>          }
> =20
> -        flush_compressed_data(rs);
>          ram_control_after_iterate(f, RAM_CONTROL_FINISH);
>      }
> =20
> @@ -2773,193 +2370,6 @@ void ram_handle_compressed(void *host, uint8_t ch=
, uint64_t size)
>      }
>  }
> =20
> -/* return the size after decompression, or negative value on error */
> -static int
> -qemu_uncompress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
> -                     const uint8_t *source, size_t source_len)
> -{
> -    int err;
> -
> -    err =3D inflateReset(stream);
> -    if (err !=3D Z_OK) {
> -        return -1;
> -    }
> -
> -    stream->avail_in =3D source_len;
> -    stream->next_in =3D (uint8_t *)source;
> -    stream->avail_out =3D dest_len;
> -    stream->next_out =3D dest;
> -
> -    err =3D inflate(stream, Z_NO_FLUSH);
> -    if (err !=3D Z_STREAM_END) {
> -        return -1;
> -    }
> -
> -    return stream->total_out;
> -}
> -
> -static void *do_data_decompress(void *opaque)
> -{
> -    DecompressParam *param =3D opaque;
> -    unsigned long pagesize;
> -    uint8_t *des;
> -    int len, ret;
> -
> -    qemu_mutex_lock(&param->mutex);
> -    while (!param->quit) {
> -        if (param->des) {
> -            des =3D param->des;
> -            len =3D param->len;
> -            param->des =3D 0;
> -            qemu_mutex_unlock(&param->mutex);
> -
> -            pagesize =3D TARGET_PAGE_SIZE;
> -
> -            ret =3D qemu_uncompress_data(&param->stream, des, pagesize,
> -                                       param->compbuf, len);
> -            if (ret < 0 && migrate_get_current()->decompress_error_check=
) {
> -                error_report("decompress data failed");
> -                qemu_file_set_error(decomp_file, ret);
> -            }
> -
> -            qemu_mutex_lock(&decomp_done_lock);
> -            param->done =3D true;
> -            qemu_cond_signal(&decomp_done_cond);
> -            qemu_mutex_unlock(&decomp_done_lock);
> -
> -            qemu_mutex_lock(&param->mutex);
> -        } else {
> -            qemu_cond_wait(&param->cond, &param->mutex);
> -        }
> -    }
> -    qemu_mutex_unlock(&param->mutex);
> -
> -    return NULL;
> -}
> -
> -static int wait_for_decompress_done(void)
> -{
> -    int idx, thread_count;
> -
> -    if (!migrate_use_compression()) {
> -        return 0;
> -    }
> -
> -    thread_count =3D migrate_decompress_threads();
> -    qemu_mutex_lock(&decomp_done_lock);
> -    for (idx =3D 0; idx < thread_count; idx++) {
> -        while (!decomp_param[idx].done) {
> -            qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
> -        }
> -    }
> -    qemu_mutex_unlock(&decomp_done_lock);
> -    return qemu_file_get_error(decomp_file);
> -}
> -
> -static void compress_threads_load_cleanup(void)
> -{
> -    int i, thread_count;
> -
> -    if (!migrate_use_compression()) {
> -        return;
> -    }
> -    thread_count =3D migrate_decompress_threads();
> -    for (i =3D 0; i < thread_count; i++) {
> -        /*
> -         * we use it as a indicator which shows if the thread is
> -         * properly init'd or not
> -         */
> -        if (!decomp_param[i].compbuf) {
> -            break;
> -        }
> -
> -        qemu_mutex_lock(&decomp_param[i].mutex);
> -        decomp_param[i].quit =3D true;
> -        qemu_cond_signal(&decomp_param[i].cond);
> -        qemu_mutex_unlock(&decomp_param[i].mutex);
> -    }
> -    for (i =3D 0; i < thread_count; i++) {
> -        if (!decomp_param[i].compbuf) {
> -            break;
> -        }
> -
> -        qemu_thread_join(decompress_threads + i);
> -        qemu_mutex_destroy(&decomp_param[i].mutex);
> -        qemu_cond_destroy(&decomp_param[i].cond);
> -        inflateEnd(&decomp_param[i].stream);
> -        g_free(decomp_param[i].compbuf);
> -        decomp_param[i].compbuf =3D NULL;
> -    }
> -    g_free(decompress_threads);
> -    g_free(decomp_param);
> -    decompress_threads =3D NULL;
> -    decomp_param =3D NULL;
> -    decomp_file =3D NULL;
> -}
> -
> -static int compress_threads_load_setup(QEMUFile *f)
> -{
> -    int i, thread_count;
> -
> -    if (!migrate_use_compression()) {
> -        return 0;
> -    }
> -
> -    thread_count =3D migrate_decompress_threads();
> -    decompress_threads =3D g_new0(QemuThread, thread_count);
> -    decomp_param =3D g_new0(DecompressParam, thread_count);
> -    qemu_mutex_init(&decomp_done_lock);
> -    qemu_cond_init(&decomp_done_cond);
> -    decomp_file =3D f;
> -    for (i =3D 0; i < thread_count; i++) {
> -        if (inflateInit(&decomp_param[i].stream) !=3D Z_OK) {
> -            goto exit;
> -        }
> -
> -        decomp_param[i].compbuf =3D g_malloc0(compressBound(TARGET_PAGE_=
SIZE));
> -        qemu_mutex_init(&decomp_param[i].mutex);
> -        qemu_cond_init(&decomp_param[i].cond);
> -        decomp_param[i].done =3D true;
> -        decomp_param[i].quit =3D false;
> -        qemu_thread_create(decompress_threads + i, "decompress",
> -                           do_data_decompress, decomp_param + i,
> -                           QEMU_THREAD_JOINABLE);
> -    }
> -    return 0;
> -exit:
> -    compress_threads_load_cleanup();
> -    return -1;
> -}
> -
> -static void decompress_data_with_multi_threads(QEMUFile *f,
> -                                               void *host, int len)
> -{
> -    int idx, thread_count;
> -
> -    thread_count =3D migrate_decompress_threads();
> -    qemu_mutex_lock(&decomp_done_lock);
> -    while (true) {
> -        for (idx =3D 0; idx < thread_count; idx++) {
> -            if (decomp_param[idx].done) {
> -                decomp_param[idx].done =3D false;
> -                qemu_mutex_lock(&decomp_param[idx].mutex);
> -                qemu_get_buffer(f, decomp_param[idx].compbuf, len);
> -                decomp_param[idx].des =3D host;
> -                decomp_param[idx].len =3D len;
> -                qemu_cond_signal(&decomp_param[idx].cond);
> -                qemu_mutex_unlock(&decomp_param[idx].mutex);
> -                break;
> -            }
> -        }
> -        if (idx < thread_count) {
> -            break;
> -        } else {
> -            qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
> -        }
> -    }
> -    qemu_mutex_unlock(&decomp_done_lock);
> -}
> -
>  /*
>   * colo cache: this is for secondary VM, we cache the whole
>   * memory of the secondary VM, it is need to hold the global lock
> @@ -3047,10 +2457,6 @@ void colo_release_ram_cache(void)
>   */
>  static int ram_load_setup(QEMUFile *f, void *opaque)
>  {
> -    if (compress_threads_load_setup(f)) {
> -        return -1;
> -    }
> -
>      xbzrle_load_setup();
>      ramblock_recv_map_init();
> =20
> @@ -3066,7 +2472,6 @@ static int ram_load_cleanup(void *opaque)
>      }
> =20
>      xbzrle_load_cleanup();
> -    compress_threads_load_cleanup();
> =20
>      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>          g_free(rb->receivedmap);
> @@ -3121,7 +2526,6 @@ static int ram_load_postcopy(QEMUFile *f)
>          void *place_source =3D NULL;
>          RAMBlock *block =3D NULL;
>          uint8_t ch;
> -        int len;
> =20
>          addr =3D qemu_get_be64(f);
> =20
> @@ -3139,8 +2543,7 @@ static int ram_load_postcopy(QEMUFile *f)
> =20
>          trace_ram_load_postcopy_loop((uint64_t)addr, flags);
>          place_needed =3D false;
> -        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
> -                     RAM_SAVE_FLAG_COMPRESS_PAGE)) {
> +        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE)) {
>              block =3D ram_block_from_stream(f, flags);
> =20
>              host =3D host_from_ram_block_offset(block, addr);
> @@ -3223,17 +2626,6 @@ static int ram_load_postcopy(QEMUFile *f)
>                                           TARGET_PAGE_SIZE);
>              }
>              break;
> -        case RAM_SAVE_FLAG_COMPRESS_PAGE:
> -            all_zero =3D false;
> -            len =3D qemu_get_be32(f);
> -            if (len < 0 || len > compressBound(TARGET_PAGE_SIZE)) {
> -                error_report("Invalid compressed data length: %d", len);
> -                ret =3D -EINVAL;
> -                break;
> -            }
> -            decompress_data_with_multi_threads(f, page_buffer, len);
> -            break;
> -
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
>              multifd_recv_sync_main();
> @@ -3245,11 +2637,6 @@ static int ram_load_postcopy(QEMUFile *f)
>              break;
>          }
> =20
> -        /* Got the whole host page, wait for decompress before placing. =
*/
> -        if (place_needed) {
> -            ret |=3D wait_for_decompress_done();
> -        }
> -
>          /* Detect for any possible file errors */
>          if (!ret && qemu_file_get_error(f)) {
>              ret =3D qemu_file_get_error(f);
> @@ -3339,12 +2726,9 @@ static void colo_flush_ram_cache(void)
>   */
>  static int ram_load_precopy(QEMUFile *f)
>  {
> -    int flags =3D 0, ret =3D 0, invalid_flags =3D 0, len =3D 0, i =3D 0;
> +    int flags =3D 0, ret =3D 0, len =3D 0, i =3D 0;
>      /* ADVISE is earlier, it shows the source has the postcopy capabilit=
y on */
>      bool postcopy_advised =3D postcopy_is_advised();
> -    if (!migrate_use_compression()) {
> -        invalid_flags |=3D RAM_SAVE_FLAG_COMPRESS_PAGE;
> -    }
> =20
>      while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
>          ram_addr_t addr, total_ram_bytes;
> @@ -3366,17 +2750,8 @@ static int ram_load_precopy(QEMUFile *f)
>          flags =3D addr & ~TARGET_PAGE_MASK;
>          addr &=3D TARGET_PAGE_MASK;
> =20
> -        if (flags & invalid_flags) {
> -            if (flags & invalid_flags & RAM_SAVE_FLAG_COMPRESS_PAGE) {
> -                error_report("Received an unexpected compressed page");
> -            }
> -
> -            ret =3D -EINVAL;
> -            break;
> -        }
> -
>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
> -                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)=
) {
> +                     RAM_SAVE_FLAG_XBZRLE)) {
>              RAMBlock *block =3D ram_block_from_stream(f, flags);
> =20
>              /*
> @@ -3472,16 +2847,6 @@ static int ram_load_precopy(QEMUFile *f)
>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>              break;
> =20
> -        case RAM_SAVE_FLAG_COMPRESS_PAGE:
> -            len =3D qemu_get_be32(f);
> -            if (len < 0 || len > compressBound(TARGET_PAGE_SIZE)) {
> -                error_report("Invalid compressed data length: %d", len);
> -                ret =3D -EINVAL;
> -                break;
> -            }
> -            decompress_data_with_multi_threads(f, host, len);
> -            break;
> -
>          case RAM_SAVE_FLAG_XBZRLE:
>              if (load_xbzrle(f, addr, host) < 0) {
>                  error_report("Failed to decompress XBZRLE page at "
> @@ -3508,7 +2873,6 @@ static int ram_load_precopy(QEMUFile *f)
>          }
>      }
> =20
> -    ret |=3D wait_for_decompress_done();
>      return ret;
>  }
> =20
> diff --git a/migration/ram.h b/migration/ram.h
> index a553d40751..638e74e499 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -35,7 +35,6 @@
> =20
>  extern MigrationStats ram_counters;
>  extern XBZRLECacheStats xbzrle_counters;
> -extern CompressionStats compression_counters;
> =20
>  int xbzrle_cache_resize(int64_t new_size, Error **errp);
>  uint64_t ram_bytes_remaining(void);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index ba75a609a7..185572f1ed 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -309,19 +309,6 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdi=
ct)
>                         info->xbzrle_cache->overflow);
>      }
> =20
> -    if (info->has_compression) {
> -        monitor_printf(mon, "compression pages: %" PRIu64 " pages\n",
> -                       info->compression->pages);
> -        monitor_printf(mon, "compression busy: %" PRIu64 "\n",
> -                       info->compression->busy);
> -        monitor_printf(mon, "compression busy rate: %0.2f\n",
> -                       info->compression->busy_rate);
> -        monitor_printf(mon, "compressed size: %" PRIu64 "\n",
> -                       info->compression->compressed_size);
> -        monitor_printf(mon, "compression rate: %0.2f\n",
> -                       info->compression->compression_rate);
> -    }
> -
>      if (info->has_cpu_throttle_percentage) {
>          monitor_printf(mon, "cpu throttle percentage: %" PRIu64 "\n",
>                         info->cpu_throttle_percentage);
> @@ -397,18 +384,6 @@ void hmp_info_migrate_parameters(Monitor *mon, const=
 QDict *qdict)
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_LEVEL),
>              params->compress_level);
> -        assert(params->has_compress_threads);
> -        monitor_printf(mon, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_THREADS)=
,
> -            params->compress_threads);
> -        assert(params->has_compress_wait_thread);
> -        monitor_printf(mon, "%s: %s\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_WAIT_THR=
EAD),
> -            params->compress_wait_thread ? "on" : "off");
> -        assert(params->has_decompress_threads);
> -        monitor_printf(mon, "%s: %u\n",
> -            MigrationParameter_str(MIGRATION_PARAMETER_DECOMPRESS_THREAD=
S),
> -            params->decompress_threads);
>          assert(params->has_cpu_throttle_initial);
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INIT=
IAL),
> @@ -1756,18 +1731,6 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
>          p->has_compress_level =3D true;
>          visit_type_int(v, param, &p->compress_level, &err);
>          break;
> -    case MIGRATION_PARAMETER_COMPRESS_THREADS:
> -        p->has_compress_threads =3D true;
> -        visit_type_int(v, param, &p->compress_threads, &err);
> -        break;
> -    case MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD:
> -        p->has_compress_wait_thread =3D true;
> -        visit_type_bool(v, param, &p->compress_wait_thread, &err);
> -        break;
> -    case MIGRATION_PARAMETER_DECOMPRESS_THREADS:
> -        p->has_decompress_threads =3D true;
> -        visit_type_int(v, param, &p->decompress_threads, &err);
> -        break;
>      case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
>          p->has_cpu_throttle_initial =3D true;
>          visit_type_int(v, param, &p->cpu_throttle_initial, &err);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 65db85970e..5477d4d20b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -79,27 +79,6 @@
>             'cache-miss': 'int', 'cache-miss-rate': 'number',
>             'overflow': 'int' } }
> =20
> -##
> -# @CompressionStats:
> -#
> -# Detailed migration compression statistics
> -#
> -# @pages: amount of pages compressed and transferred to the target VM
> -#
> -# @busy: count of times that no free thread was available to compress da=
ta
> -#
> -# @busy-rate: rate of thread busy
> -#
> -# @compressed-size: amount of bytes after compression
> -#
> -# @compression-rate: rate of compressed size
> -#
> -# Since: 3.1
> -##
> -{ 'struct': 'CompressionStats',
> -  'data': {'pages': 'int', 'busy': 'int', 'busy-rate': 'number',
> -=09   'compressed-size': 'int', 'compression-rate': 'number' } }
> -
>  ##
>  # @MigrationStatus:
>  #
> @@ -200,9 +179,6 @@
>  #           only present when the postcopy-blocktime migration capabilit=
y
>  #           is enabled. (Since 3.0)
>  #
> -# @compression: migration compression statistics, only returned if compr=
ession
> -#           feature is on and status is 'active' or 'completed' (Since 3=
.1)
> -#
>  # @socket-address: Only used for tcp, to know what the real port is (Sin=
ce 4.0)
>  #
>  # Since: 0.14.0
> @@ -219,7 +195,6 @@
>             '*error-desc': 'str',
>             '*postcopy-blocktime' : 'uint32',
>             '*postcopy-vcpu-blocktime': ['uint32'],
> -           '*compression': 'CompressionStats',
>             '*socket-address': ['SocketAddress'] } }
> =20
>  ##
> @@ -364,14 +339,6 @@
>  #          to enable the capability on the source VM. The feature is dis=
abled by
>  #          default. (since 1.6)
>  #
> -# @compress: Use multiple compression threads to accelerate live migrati=
on.
> -#          This feature can help to reduce the migration traffic, by sen=
ding
> -#          compressed pages. Please note that if compress and xbzrle are=
 both
> -#          on, compress only takes effect in the ram bulk stage, after t=
hat,
> -#          it will be disabled and only xbzrle takes effect, this can he=
lp to
> -#          minimize migration traffic. The feature is disabled by defaul=
t.
> -#          (since 2.4 )
> -#
>  # @events: generate events for each migration state change
>  #          (since 2.4 )
>  #
> @@ -425,7 +392,7 @@
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> -           'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'=
,
> +           'events', 'postcopy-ram', 'x-colo', 'release-ram',
>             'block', 'return-path', 'pause-before-switchover', 'multifd',
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
>             'x-ignore-shared', 'validate-uuid' ] }
> @@ -479,7 +446,6 @@
>  #       {"state": false, "capability": "rdma-pin-all"},
>  #       {"state": false, "capability": "auto-converge"},
>  #       {"state": false, "capability": "zero-blocks"},
> -#       {"state": false, "capability": "compress"},
>  #       {"state": true, "capability": "events"},
>  #       {"state": false, "capability": "postcopy-ram"},
>  #       {"state": false, "capability": "x-colo"}
> @@ -523,20 +489,6 @@
>  #          no compression, 1 means the best compression speed, and 9 mea=
ns best
>  #          compression ratio which will consume more CPU.
>  #
> -# @compress-threads: Set compression thread count to be used in live mig=
ration,
> -#          the compression thread count is an integer between 1 and 255.
> -#
> -# @compress-wait-thread: Controls behavior when all compression threads =
are
> -#                        currently busy. If true (default), wait for a f=
ree
> -#                        compression thread to become available; otherwi=
se,
> -#                        send the page uncompressed. (Since 3.1)
> -#
> -# @decompress-threads: Set decompression thread count to be used in live
> -#          migration, the decompression thread count is an integer betwe=
en 1
> -#          and 255. Usually, decompression is at least 4 times as fast a=
s
> -#          compression, so set the decompress-threads to the number abou=
t 1/4
> -#          of compress-threads is adequate.
> -#
>  # @cpu-throttle-initial: Initial percentage of time guest cpus are throt=
tled
>  #                        when migration auto-converge is activated. The
>  #                        default value is 20. (Since 2.7)
> @@ -607,8 +559,7 @@
>  { 'enum': 'MigrationParameter',
>    'data': ['announce-initial', 'announce-max',
>             'announce-rounds', 'announce-step',
> -           'compress-level', 'compress-threads', 'decompress-threads',
> -           'compress-wait-thread',
> +           'compress-level',
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
>             'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
> @@ -633,15 +584,6 @@
>  #
>  # @compress-level: compression level
>  #
> -# @compress-threads: compression thread count
> -#
> -# @compress-wait-thread: Controls behavior when all compression threads =
are
> -#                        currently busy. If true (default), wait for a f=
ree
> -#                        compression thread to become available; otherwi=
se,
> -#                        send the page uncompressed. (Since 3.1)
> -#
> -# @decompress-threads: decompression thread count
> -#
>  # @cpu-throttle-initial: Initial percentage of time guest cpus are
>  #                        throttled when migration auto-converge is activ=
ated.
>  #                        The default value is 20. (Since 2.7)
> @@ -717,9 +659,6 @@
>              '*announce-rounds': 'size',
>              '*announce-step': 'size',
>              '*compress-level': 'int',
> -            '*compress-threads': 'int',
> -            '*compress-wait-thread': 'bool',
> -            '*decompress-threads': 'int',
>              '*cpu-throttle-initial': 'int',
>              '*cpu-throttle-increment': 'int',
>              '*tls-creds': 'StrOrNull',
> @@ -770,15 +709,6 @@
>  #
>  # @compress-level: compression level
>  #
> -# @compress-threads: compression thread count
> -#
> -# @compress-wait-thread: Controls behavior when all compression threads =
are
> -#                        currently busy. If true (default), wait for a f=
ree
> -#                        compression thread to become available; otherwi=
se,
> -#                        send the page uncompressed. (Since 3.1)
> -#
> -# @decompress-threads: decompression thread count
> -#
>  # @cpu-throttle-initial: Initial percentage of time guest cpus are
>  #                        throttled when migration auto-converge is activ=
ated.
>  #                        (Since 2.7)
> @@ -854,9 +784,6 @@
>              '*announce-rounds': 'size',
>              '*announce-step': 'size',
>              '*compress-level': 'uint8',
> -            '*compress-threads': 'uint8',
> -            '*compress-wait-thread': 'bool',
> -            '*decompress-threads': 'uint8',
>              '*cpu-throttle-initial': 'uint8',
>              '*cpu-throttle-increment': 'uint8',
>              '*tls-creds': 'str',
> @@ -885,9 +812,7 @@
>  #
>  # -> { "execute": "query-migrate-parameters" }
>  # <- { "return": {
> -#          "decompress-threads": 2,
>  #          "cpu-throttle-increment": 10,
> -#          "compress-threads": 8,
>  #          "compress-level": 1,
>  #          "cpu-throttle-initial": 20,
>  #          "max-bandwidth": 33554432,
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


