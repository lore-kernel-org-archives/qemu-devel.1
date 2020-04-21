Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E9EC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD95C20656
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxfbHmxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD95C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQyTs-0005LH-Pm
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 15:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jQySZ-0003FD-Ar
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jQySN-0001Ea-JW
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:21:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48405
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jQySL-0001DW-Qu
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587496876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tl4+xPAPQK99rHHHFoIFSPor4bRKFcRM/G5PjVvePIQ=;
 b=SxfbHmxt05zU3yvwjmuiIiU/Vz5YjsOJgHuNKVu1NDLQ4lWLgbKfo2yW5t5VCJYv7Wd1De
 rD+D3xlSNDpYwsnYaEZbwpqJAEJvzP0QnfPH5dWJqP81wNlcWa7/RvdnlXtdFdn8uquNdw
 EThPLB12D27oVmKIiNwbqsuHs2dg0D4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-eCABnrZiOLCaI1JEYkqd5w-1; Tue, 21 Apr 2020 15:21:14 -0400
X-MC-Unique: eCABnrZiOLCaI1JEYkqd5w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92CEB107ACC7;
 Tue, 21 Apr 2020 19:21:13 +0000 (UTC)
Received: from work-vm (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 079DD5C1D4;
 Tue, 21 Apr 2020 19:21:08 +0000 (UTC)
Date: Tue, 21 Apr 2020 20:21:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 1/2] migration/xbzrle: replace transferred xbzrle
 bytes with encoded bytes
Message-ID: <20200421192106.GM3029@work-vm>
References: <1587352003-3312-1-git-send-email-wei.w.wang@intel.com>
 <1587352003-3312-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
In-Reply-To: <1587352003-3312-2-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 15:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kevin.tian@intel.com, quintela@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, gloryxiao@tencent.com, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Wang (wei.w.wang@intel.com) wrote:
> Like compressed_size which indicates how many bytes are compressed, we
> need encoded_size to understand how many bytes are encoded with xbzrle
> during migration.
>=20
> Replace the old xbzrle_counter.bytes, instead of adding a new counter,
> because we don't find a usage of xbzrle_counter.bytes currently, which
> includes 3 more bytes of the migration transfer protocol header (in
> addition to the encoding header). The encoded_size will further be used
> to calculate the encoding rate.
>=20
> Signed-off-by: Yi Sun <yi.y.sun@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

Can you explain why these 3 bytes matter?  Certainly the 2 bytes of the
encoded_len are an overhead that's a cost of using XBZRLE; so if you're
trying to figure out whether xbzrle is worth it, then you should include
those 2 bytes in the cost.
That other byte, that holds ENCODING_FLAG_XBZRLE also seems to be pure
oerhead of XBZRLE; so your cost of using XBZRLE really does include
those 3 bytes.

SO to me it makes sense to include the 3 bytes as it currently does.

Dave

> ---
>  migration/migration.c |  2 +-
>  migration/ram.c       | 18 +++++++++---------
>  monitor/hmp-cmds.c    |  4 ++--
>  qapi/migration.json   |  6 +++---
>  4 files changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 187ac0410c..8e7ee0d76b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -926,7 +926,7 @@ static void populate_ram_info(MigrationInfo *info, Mi=
grationState *s)
>          info->has_xbzrle_cache =3D true;
>          info->xbzrle_cache =3D g_malloc0(sizeof(*info->xbzrle_cache));
>          info->xbzrle_cache->cache_size =3D migrate_xbzrle_cache_size();
> -        info->xbzrle_cache->bytes =3D xbzrle_counters.bytes;
> +        info->xbzrle_cache->encoded_size =3D xbzrle_counters.encoded_siz=
e;
>          info->xbzrle_cache->pages =3D xbzrle_counters.pages;
>          info->xbzrle_cache->cache_miss =3D xbzrle_counters.cache_miss;
>          info->xbzrle_cache->cache_miss_rate =3D xbzrle_counters.cache_mi=
ss_rate;
> diff --git a/migration/ram.c b/migration/ram.c
> index 04f13feb2e..bca5878f25 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -677,7 +677,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **c=
urrent_data,
>                              ram_addr_t current_addr, RAMBlock *block,
>                              ram_addr_t offset, bool last_stage)
>  {
> -    int encoded_len =3D 0, bytes_xbzrle;
> +    int encoded_size =3D 0, bytes_xbzrle;
>      uint8_t *prev_cached_page;
> =20
>      if (!cache_is_cached(XBZRLE.cache, current_addr,
> @@ -702,7 +702,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **c=
urrent_data,
>      memcpy(XBZRLE.current_buf, *current_data, TARGET_PAGE_SIZE);
> =20
>      /* XBZRLE encoding (if there is no overflow) */
> -    encoded_len =3D xbzrle_encode_buffer(prev_cached_page, XBZRLE.curren=
t_buf,
> +    encoded_size =3D xbzrle_encode_buffer(prev_cached_page, XBZRLE.curre=
nt_buf,
>                                         TARGET_PAGE_SIZE, XBZRLE.encoded_=
buf,
>                                         TARGET_PAGE_SIZE);
> =20
> @@ -710,7 +710,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **c=
urrent_data,
>       * Update the cache contents, so that it corresponds to the data
>       * sent, in all cases except where we skip the page.
>       */
> -    if (!last_stage && encoded_len !=3D 0) {
> +    if (!last_stage && encoded_size !=3D 0) {
>          memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
>          /*
>           * In the case where we couldn't compress, ensure that the calle=
r
> @@ -720,10 +720,10 @@ static int save_xbzrle_page(RAMState *rs, uint8_t *=
*current_data,
>          *current_data =3D prev_cached_page;
>      }
> =20
> -    if (encoded_len =3D=3D 0) {
> +    if (encoded_size =3D=3D 0) {
>          trace_save_xbzrle_page_skipping();
>          return 0;
> -    } else if (encoded_len =3D=3D -1) {
> +    } else if (encoded_size =3D=3D -1) {
>          trace_save_xbzrle_page_overflow();
>          xbzrle_counters.overflow++;
>          return -1;
> @@ -733,11 +733,11 @@ static int save_xbzrle_page(RAMState *rs, uint8_t *=
*current_data,
>      bytes_xbzrle =3D save_page_header(rs, rs->f, block,
>                                      offset | RAM_SAVE_FLAG_XBZRLE);
>      qemu_put_byte(rs->f, ENCODING_FLAG_XBZRLE);
> -    qemu_put_be16(rs->f, encoded_len);
> -    qemu_put_buffer(rs->f, XBZRLE.encoded_buf, encoded_len);
> -    bytes_xbzrle +=3D encoded_len + 1 + 2;
> +    qemu_put_be16(rs->f, encoded_size);
> +    qemu_put_buffer(rs->f, XBZRLE.encoded_buf, encoded_size);
> +    bytes_xbzrle +=3D encoded_size + 1 + 2;
>      xbzrle_counters.pages++;
> -    xbzrle_counters.bytes +=3D bytes_xbzrle;
> +    xbzrle_counters.encoded_size +=3D encoded_size;
>      ram_counters.transferred +=3D bytes_xbzrle;
> =20
>      return 1;
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 9b94e67879..6d3b35ca64 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -295,8 +295,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdic=
t)
>      if (info->has_xbzrle_cache) {
>          monitor_printf(mon, "cache size: %" PRIu64 " bytes\n",
>                         info->xbzrle_cache->cache_size);
> -        monitor_printf(mon, "xbzrle transferred: %" PRIu64 " kbytes\n",
> -                       info->xbzrle_cache->bytes >> 10);
> +        monitor_printf(mon, "xbzrle encoded size: %" PRIu64 " kbytes\n",
> +                       info->xbzrle_cache->encoded_size >> 10);
>          monitor_printf(mon, "xbzrle pages: %" PRIu64 " pages\n",
>                         info->xbzrle_cache->pages);
>          monitor_printf(mon, "xbzrle cache miss: %" PRIu64 "\n",
> diff --git a/qapi/migration.json b/qapi/migration.json
> index eca2981d0a..bf195ff6ac 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -62,7 +62,7 @@
>  #
>  # @cache-size: XBZRLE cache size
>  #
> -# @bytes: amount of bytes already transferred to the target VM
> +# @encoded_size: amount of bytes encoded
>  #
>  # @pages: amount of pages transferred to the target VM
>  #
> @@ -75,7 +75,7 @@
>  # Since: 1.2
>  ##
>  { 'struct': 'XBZRLECacheStats',
> -  'data': {'cache-size': 'int', 'bytes': 'int', 'pages': 'int',
> +  'data': {'cache-size': 'int', 'encoded_size': 'int', 'pages': 'int',
>             'cache-miss': 'int', 'cache-miss-rate': 'number',
>             'overflow': 'int' } }
> =20
> @@ -333,7 +333,7 @@
>  #          },
>  #          "xbzrle-cache":{
>  #             "cache-size":67108864,
> -#             "bytes":20971520,
> +#             "encoded_size":20971520,
>  #             "pages":2444343,
>  #             "cache-miss":2244,
>  #             "cache-miss-rate":0.123,
> --=20
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


