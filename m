Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17A1C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA16A20784
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FN7eHgOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA16A20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU54P-0002sW-VO
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jU53U-0002PD-Jb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jU53T-00082X-OR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:00:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60791
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jU53T-000824-4L
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588237222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUA9+aUdcBFeh59b6/dL5pSUcswMzgKsUk7IDBiorss=;
 b=FN7eHgOSOIbMisFR8ERTCXj+c5WZxmd5dMnDUtP0hAFzuRtUrZPpOQSa+YdnMFdkQq5D2l
 NH91rNIYY78Jofc67/sez/kzlNQfje7bNs4oVwWwR2I2bhX8MlWKaTpzBNXzuzWniH3Mf+
 UNbi93QkI43p9EIWy07ZJ0X0rF2wo7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-NYQoPixcOpOILM6t9aQQSw-1; Thu, 30 Apr 2020 05:00:20 -0400
X-MC-Unique: NYQoPixcOpOILM6t9aQQSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D9698015CB;
 Thu, 30 Apr 2020 09:00:19 +0000 (UTC)
Received: from work-vm (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 730BA5C1BE;
 Thu, 30 Apr 2020 09:00:12 +0000 (UTC)
Date: Thu, 30 Apr 2020 10:00:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v3] migration/xbzrle: add encoding rate
Message-ID: <20200430090009.GD2874@work-vm>
References: <1588208375-19556-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
In-Reply-To: <1588208375-19556-1-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kevin.tian@intel.com, quintela@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, gloryxiao@tencent.com, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Wang (wei.w.wang@intel.com) wrote:
> Users may need to check the xbzrle encoding rate to know if the guest
> memory is xbzrle encoding-friendly, and dynamically turn off the
> encoding if the encoding rate is low.
>=20
> Signed-off-by: Yi Sun <yi.y.sun@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c |  1 +
>  migration/ram.c       | 39 +++++++++++++++++++++++++++++++++++++--
>  monitor/hmp-cmds.c    |  2 ++
>  qapi/migration.json   |  5 ++++-
>  4 files changed, 44 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 187ac0410c..e40421353c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -930,6 +930,7 @@ static void populate_ram_info(MigrationInfo *info, Mi=
grationState *s)
>          info->xbzrle_cache->pages =3D xbzrle_counters.pages;
>          info->xbzrle_cache->cache_miss =3D xbzrle_counters.cache_miss;
>          info->xbzrle_cache->cache_miss_rate =3D xbzrle_counters.cache_mi=
ss_rate;
> +        info->xbzrle_cache->encoding_rate =3D xbzrle_counters.encoding_r=
ate;
>          info->xbzrle_cache->overflow =3D xbzrle_counters.overflow;
>      }
> =20
> diff --git a/migration/ram.c b/migration/ram.c
> index 04f13feb2e..41b75a0a0f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -327,6 +327,10 @@ struct RAMState {
>      uint64_t num_dirty_pages_period;
>      /* xbzrle misses since the beginning of the period */
>      uint64_t xbzrle_cache_miss_prev;
> +    /* Amount of xbzrle pages since the beginning of the period */
> +    uint64_t xbzrle_pages_prev;
> +    /* Amount of xbzrle encoded bytes since the beginning of the period =
*/
> +    uint64_t xbzrle_bytes_prev;
> =20
>      /* compression statistics since the beginning of the period */
>      /* amount of count that no free thread to compress data */
> @@ -696,6 +700,18 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **=
current_data,
>          return -1;
>      }
> =20
> +    /*
> +     * Reaching here means the page has hit the xbzrle cache, no matter =
what
> +     * encoding result it is (normal encoding, overflow or skipping the =
page),
> +     * count the page as encoded. This is used to caculate the encoding =
rate.
> +     *
> +     * Example: 2 pages (8KB) being encoded, first page encoding generat=
es 2KB,
> +     * 2nd page turns out to be skipped (i.e. no new bytes written to th=
e
> +     * page), the overall encoding rate will be 8KB / 2KB =3D 4, which h=
as the
> +     * skipped page included. In this way, the encoding rate can tell if=
 the
> +     * guest page is good for xbzrle encoding.
> +     */
> +    xbzrle_counters.pages++;
>      prev_cached_page =3D get_cached_data(XBZRLE.cache, current_addr);
> =20
>      /* save current buffer into memory */
> @@ -726,6 +742,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **c=
urrent_data,
>      } else if (encoded_len =3D=3D -1) {
>          trace_save_xbzrle_page_overflow();
>          xbzrle_counters.overflow++;
> +        xbzrle_counters.bytes +=3D TARGET_PAGE_SIZE;
>          return -1;
>      }
> =20
> @@ -736,8 +753,12 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **=
current_data,
>      qemu_put_be16(rs->f, encoded_len);
>      qemu_put_buffer(rs->f, XBZRLE.encoded_buf, encoded_len);
>      bytes_xbzrle +=3D encoded_len + 1 + 2;
> -    xbzrle_counters.pages++;
> -    xbzrle_counters.bytes +=3D bytes_xbzrle;
> +    /*
> +     * Like compressed_size (please see update_compress_thread_counts),
> +     * the xbzrle encoded bytes don't count the 8 byte header with
> +     * RAM_SAVE_FLAG_CONTINUE.
> +     */
> +    xbzrle_counters.bytes +=3D bytes_xbzrle - 8;
>      ram_counters.transferred +=3D bytes_xbzrle;
> =20
>      return 1;
> @@ -870,9 +891,23 @@ static void migration_update_rates(RAMState *rs, int=
64_t end_time)
>      }
> =20
>      if (migrate_use_xbzrle()) {
> +        double encoded_size, unencoded_size;
> +
>          xbzrle_counters.cache_miss_rate =3D (double)(xbzrle_counters.cac=
he_miss -
>              rs->xbzrle_cache_miss_prev) / page_count;
>          rs->xbzrle_cache_miss_prev =3D xbzrle_counters.cache_miss;
> +        unencoded_size =3D (xbzrle_counters.pages - rs->xbzrle_pages_pre=
v) *
> +                         TARGET_PAGE_SIZE;
> +        encoded_size =3D xbzrle_counters.bytes - rs->xbzrle_bytes_prev;
> +        if (xbzrle_counters.pages =3D=3D rs->xbzrle_pages_prev) {
> +            xbzrle_counters.encoding_rate =3D 0;
> +        } else if (!encoded_size) {
> +            xbzrle_counters.encoding_rate =3D UINT64_MAX;
> +        } else {
> +            xbzrle_counters.encoding_rate =3D unencoded_size / encoded_s=
ize;
> +        }
> +        rs->xbzrle_pages_prev =3D xbzrle_counters.pages;
> +        rs->xbzrle_bytes_prev =3D xbzrle_counters.bytes;
>      }
> =20
>      if (migrate_use_compression()) {
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 9b94e67879..c2a3a667ae 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -303,6 +303,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdic=
t)
>                         info->xbzrle_cache->cache_miss);
>          monitor_printf(mon, "xbzrle cache miss rate: %0.2f\n",
>                         info->xbzrle_cache->cache_miss_rate);
> +        monitor_printf(mon, "xbzrle encoding rate: %0.2f\n",
> +                       info->xbzrle_cache->encoding_rate);
>          monitor_printf(mon, "xbzrle overflow: %" PRIu64 "\n",
>                         info->xbzrle_cache->overflow);
>      }
> diff --git a/qapi/migration.json b/qapi/migration.json
> index eca2981d0a..358e40226d 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -70,6 +70,8 @@
>  #
>  # @cache-miss-rate: rate of cache miss (since 2.1)
>  #
> +# @encoding-rate: rate of encoded bytes (since 5.1)
> +#
>  # @overflow: number of overflows
>  #
>  # Since: 1.2
> @@ -77,7 +79,7 @@
>  { 'struct': 'XBZRLECacheStats',
>    'data': {'cache-size': 'int', 'bytes': 'int', 'pages': 'int',
>             'cache-miss': 'int', 'cache-miss-rate': 'number',
> -           'overflow': 'int' } }
> +           'encoding-rate': 'number', 'overflow': 'int' } }
> =20
>  ##
>  # @CompressionStats:
> @@ -337,6 +339,7 @@
>  #             "pages":2444343,
>  #             "cache-miss":2244,
>  #             "cache-miss-rate":0.123,
> +#             "encoding-rate":80.1,
>  #             "overflow":34434
>  #          }
>  #       }
> --=20
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


