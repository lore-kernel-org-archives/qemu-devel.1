Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D082C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2890B206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTULF9BZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2890B206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXov-0008C2-9B
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52472 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQXoC-0007Jr-5B
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:54:04 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQXoB-0004jJ-Jh
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:54:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jQXoB-0004gR-6Q
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587394442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHla7/0fqJN0xvAHmbJzMdg9/slOHDcGCRxkml7MEyg=;
 b=TTULF9BZjomGuNvXCj952U7jQa7lw+G/rml8M9Y5/SKTp3IB3AFH52+t9HPVKIR+h5U5+R
 PWLHBnP0A+QpgRpyIfJHvGykISv6M1eWTxuIbsih8oZ5BdvFUHxTjVqegJCUM214FFPP7Y
 jvchryd9T5izzfGm6ZtPkA2GJNeHR3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-TCr0QfBmNSWAm1-FWmce4w-1; Mon, 20 Apr 2020 10:54:00 -0400
X-MC-Unique: TCr0QfBmNSWAm1-FWmce4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41762805744;
 Mon, 20 Apr 2020 14:53:59 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AE6D120AFD;
 Mon, 20 Apr 2020 14:53:55 +0000 (UTC)
Subject: Re: [PATCH v1 2/2] migration/xbzrle: add encoding rate
To: Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com
References: <1587352003-3312-1-git-send-email-wei.w.wang@intel.com>
 <1587352003-3312-3-git-send-email-wei.w.wang@intel.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c291eede-8187-5f95-7939-3bdcf4a832e2@redhat.com>
Date: Mon, 20 Apr 2020 09:53:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587352003-3312-3-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 09:01:45
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
Cc: gloryxiao@tencent.com, kevin.tian@intel.com, yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/19/20 10:06 PM, Wei Wang wrote:
> Users may need to check the xbzrle encoding rate to know if the guest
> memory is xbzrle encoding-friendly, and dynamically turn off the
> encoding if the encoding rate is low.
> 
> Signed-off-by: Yi Sun <yi.y.sun@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---

In addition to Dan's review comments,

> +++ b/qapi/migration.json
> @@ -70,6 +70,8 @@
>   #
>   # @cache-miss-rate: rate of cache miss (since 2.1)
>   #
> +# @encoding-rate: rate of cache miss

This is missing a '(since 5.1)' tag.

> +#
>   # @overflow: number of overflows
>   #
>   # Since: 1.2
> @@ -77,7 +79,7 @@
>   { 'struct': 'XBZRLECacheStats',
>     'data': {'cache-size': 'int', 'encoded_size': 'int', 'pages': 'int',
>              'cache-miss': 'int', 'cache-miss-rate': 'number',
> -           'overflow': 'int' } }
> +           'encoding-rate': 'number', 'overflow': 'int' } }
>   
>   ##
>   # @CompressionStats:
> @@ -337,6 +339,7 @@
>   #             "pages":2444343,
>   #             "cache-miss":2244,
>   #             "cache-miss-rate":0.123,
> +#             "encoding-rate":80.1,
>   #             "overflow":34434
>   #          }
>   #       }
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


