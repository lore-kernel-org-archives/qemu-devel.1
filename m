Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ACEC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF2920CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDdOaLs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF2920CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSmF-0008NI-La
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42270 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jQSku-0006zL-LM
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:30:21 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jQSkt-0007Jg-N1
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:30:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jQSkt-0007Il-8i
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587375018;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFHTuEtmnxWm9amjanotYZpATqfmz3SnM9J1vnaNilM=;
 b=SDdOaLs9UlHHC0L+VdsEuFXzS4B5dnP5QTADx6fsSqawHEQAYsUcg+4TEIduQOGrZ7eqaZ
 WfBOI/esJm0XS/zWjFNPu2qWhbE7027f9zVrT8XqoTjwN8cI45fXeumKeIUkbDtNAO2WP5
 qjSD5Tt3joKVWuiipbiY+1Qw0ZLyrq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-yjSB-0njNiyTOyYkC31SvA-1; Mon, 20 Apr 2020 05:30:16 -0400
X-MC-Unique: yjSB-0njNiyTOyYkC31SvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEE6618FE862;
 Mon, 20 Apr 2020 09:30:14 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72CC111A1FB;
 Mon, 20 Apr 2020 09:30:09 +0000 (UTC)
Date: Mon, 20 Apr 2020 10:30:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 2/2] migration/xbzrle: add encoding rate
Message-ID: <20200420093006.GI346737@redhat.com>
References: <1587352003-3312-1-git-send-email-wei.w.wang@intel.com>
 <1587352003-3312-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
In-Reply-To: <1587352003-3312-3-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:18
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: kevin.tian@intel.com, quintela@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, dgilbert@redhat.com, gloryxiao@tencent.com,
 yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 20, 2020 at 11:06:43AM +0800, Wei Wang wrote:
> Users may need to check the xbzrle encoding rate to know if the guest
> memory is xbzrle encoding-friendly, and dynamically turn off the
> encoding if the encoding rate is low.
>=20
> Signed-off-by: Yi Sun <yi.y.sun@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  migration/migration.c |  1 +
>  migration/ram.c       | 31 +++++++++++++++++++++++++++++--
>  monitor/hmp-cmds.c    |  2 ++
>  qapi/migration.json   |  5 ++++-
>  slirp                 |  2 +-
>  5 files changed, 37 insertions(+), 4 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 8e7ee0d76b..84a556a4ac 100644
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
> index bca5878f25..c87c38ec80 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -327,6 +327,10 @@ struct RAMState {
>      uint64_t num_dirty_pages_period;
>      /* xbzrle misses since the beginning of the period */
>      uint64_t xbzrle_cache_miss_prev;
> +    /* Amount of xbzrle pages since the beginning of the period */
> +    uint64_t xbzrle_pages_prev;
> +    /* Amount of encoded bytes since the beginning of the period */
> +    uint64_t encoded_size_prev;
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
> @@ -736,7 +752,6 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **c=
urrent_data,
>      qemu_put_be16(rs->f, encoded_size);
>      qemu_put_buffer(rs->f, XBZRLE.encoded_buf, encoded_size);
>      bytes_xbzrle +=3D encoded_size + 1 + 2;
> -    xbzrle_counters.pages++;
>      xbzrle_counters.encoded_size +=3D encoded_size;
>      ram_counters.transferred +=3D bytes_xbzrle;
> =20
> @@ -859,7 +874,7 @@ uint64_t ram_get_total_transferred_pages(void)
>  static void migration_update_rates(RAMState *rs, int64_t end_time)
>  {
>      uint64_t page_count =3D rs->target_page_count - rs->target_page_coun=
t_prev;
> -    double compressed_size;
> +    double compressed_size, encoded_size, unencoded_size;
> =20
>      /* calculate period counters */
>      ram_counters.dirty_pages_rate =3D rs->num_dirty_pages_period * 1000
> @@ -873,6 +888,18 @@ static void migration_update_rates(RAMState *rs, int=
64_t end_time)
>          xbzrle_counters.cache_miss_rate =3D (double)(xbzrle_counters.cac=
he_miss -
>              rs->xbzrle_cache_miss_prev) / page_count;
>          rs->xbzrle_cache_miss_prev =3D xbzrle_counters.cache_miss;
> +        unencoded_size =3D (xbzrle_counters.pages - rs->xbzrle_pages_pre=
v) *
> +                         TARGET_PAGE_SIZE;
> +        encoded_size =3D xbzrle_counters.encoded_size - rs->encoded_size=
_prev;
> +        if (xbzrle_counters.pages =3D=3D rs->xbzrle_pages_prev) {
> +            xbzrle_counters.encoding_rate =3D 0;
> +        } else if (!encoded_size) {
> +            xbzrle_counters.encoding_rate =3D UINT64_MAX;
> +        } else {
> +            xbzrle_counters.encoding_rate =3D unencoded_size / encoded_s=
ize;
> +        }
> +        rs->xbzrle_pages_prev =3D xbzrle_counters.pages;
> +        rs->encoded_size_prev =3D xbzrle_counters.encoded_size;
>      }
> =20
>      if (migrate_use_compression()) {
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 6d3b35ca64..07f41e582f 100644
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
> index bf195ff6ac..ee4513c565 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -70,6 +70,8 @@
>  #
>  # @cache-miss-rate: rate of cache miss (since 2.1)
>  #
> +# @encoding-rate: rate of cache miss
> +#
>  # @overflow: number of overflows
>  #
>  # Since: 1.2
> @@ -77,7 +79,7 @@
>  { 'struct': 'XBZRLECacheStats',
>    'data': {'cache-size': 'int', 'encoded_size': 'int', 'pages': 'int',
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
> diff --git a/slirp b/slirp
> index 55ab21c9a3..126c04acba 160000
> --- a/slirp
> +++ b/slirp
> @@ -1 +1 @@
> -Subproject commit 55ab21c9a36852915b81f1b41ebaf3b6509dd8ba
> +Subproject commit 126c04acbabd7ad32c2b018fe10dfac2a3bc1210

Accidental inclusion of submodule changes

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


