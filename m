Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4766BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4DC2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKorFjuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4DC2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdECa-0008V5-8l
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 10:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdEBI-0007jV-2u
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:34:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42782
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdEBH-0008Gi-3F
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590417258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6xSyCdEJLXbFihD88JarTGqRJAjtlUBbdSP9GkhVFWg=;
 b=HKorFjufLeyy7kNaOBdIhqVSxGogFwQMqKRERw9FmlbtVtGc8gNAM98ORJVikeITSc8cwD
 xVYsNfef6vqzAVq5BD0nBBZYJZiy9A/y2wiYcl3RTMjoHXCrPvqgh4EhWJa31b74VpFHc/
 uc8X5wSlwqYoNePG7seKrjnH3mP00+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-fwsWJYToOmqd5QrGP6h2tg-1; Mon, 25 May 2020 10:34:14 -0400
X-MC-Unique: fwsWJYToOmqd5QrGP6h2tg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 380C9107ACCD;
 Mon, 25 May 2020 14:34:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B68719D7E;
 Mon, 25 May 2020 14:34:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1AA8C113864A; Mon, 25 May 2020 16:34:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v23 18/18] qapi: Add VFIO devices migration stats in
 Migration stats
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-19-git-send-email-kwankhede@nvidia.com>
Date: Mon, 25 May 2020 16:34:04 +0200
In-Reply-To: <1589999088-31477-19-git-send-email-kwankhede@nvidia.com> (Kirti
 Wankhede's message of "Wed, 20 May 2020 23:54:48 +0530")
Message-ID: <875zckdqxv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com, Ken.Xue@amd.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, quintela@redhat.com,
 zhi.a.wang@intel.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kirti Wankhede <kwankhede@nvidia.com> writes:

> Added amount of bytes transferred to the target VM by all VFIO devices
>
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>

QAPI review only.

> diff --git a/qapi/migration.json b/qapi/migration.json
> index d5000558c6c9..acbc42a1efe8 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -146,6 +146,18 @@
>              'active', 'postcopy-active', 'postcopy-paused',
>              'postcopy-recover', 'completed', 'failed', 'colo',
>              'pre-switchover', 'device', 'wait-unplug' ] }
> +##
> +# @VfioStats:
> +#
> +# Detailed VFIO devices migration statistics
> +#
> +# @bytes: amount of bytes transferred to the target VM by VFIO devices
> +#
> +# Since: 5.1
> +#
> +##
> +{ 'struct': 'VfioStats',
> +  'data': {'bytes': 'int' } }

Pardon my ignorance...  What exactly do VFIO devices transfer to the
target VM?  How is that related to MigrationInfo member @ram?

For what it's worth, MigrationStats has

   # @transferred: amount of bytes already transferred to the target VM

Name yours @transferred as well, for consistency?

MigrationStats has much more information, and some of it is pretty
useful to track how migration is doing, in particular whether it
converges, and how fast.  Absent in VfioStats due to "not implemented",
or due to "can't be done"?

Byte counts should use QAPI type 'size'.  Many existing ones don't.
Since MigrationStats uses 'int', I'll let the migration maintainers
decide whether they want 'int' or 'size' here.

>  
>  ##
>  # @MigrationInfo:
> @@ -207,6 +219,10 @@
>  #
>  # @socket-address: Only used for tcp, to know what the real port is (Since 4.0)
>  #
> +# @vfio: @VfioStats containing detailed VFIO devices migration statistics,
> +#        only returned if VFIO device is present, migration is supported by all
> +#         VFIO devices and status is 'active' or 'completed' (since 5.1)
> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationInfo',
> @@ -222,7 +238,8 @@
     'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
              '*disk': 'MigrationStats',
              '*xbzrle-cache': 'XBZRLECacheStats',
              '*total-time': 'int',
              '*expected-downtime': 'int',
              '*downtime': 'int',
              '*setup-time': 'int',
              '*cpu-throttle-percentage': 'int',
              '*error-desc': 'str',
>             '*postcopy-blocktime' : 'uint32',
>             '*postcopy-vcpu-blocktime': ['uint32'],
>             '*compression': 'CompressionStats',
> -           '*socket-address': ['SocketAddress'] } }
> +           '*socket-address': ['SocketAddress'],
> +           '*vfio': 'VfioStats' } }
>  
>  ##
>  # @query-migrate:

If @vfio and @ram are related, add @vfio next to @ram and @disk, please.


