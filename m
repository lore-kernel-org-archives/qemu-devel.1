Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3FFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E41C2067B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtRrt8PH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E41C2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc9ZF-00053M-Kc
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 10:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kc9Xl-0003kw-NT
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:57:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kc9Xj-0007Lf-12
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604937438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rsqlf/2ud6nucZoiA+9KvuPqnPtrrVtfXVJddjAaUMA=;
 b=BtRrt8PHAtoXuyGgKRq4ArELcCy5jzbSJQF5txAQYGr+xa7f+7WmLRAqmQgt9aC5nWJQk6
 P1K5u+DT8StEEjakuUmWKH2jMCalEpFimydEFYdSRL3j4yVMIDQguZvj/m6aFy3rlJNWJi
 oCK9MQNrOnivuBb3LB7Kn0sJ/zHhCNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-0bJt-B54Nhy9HoMW8-z5ow-1; Mon, 09 Nov 2020 10:57:15 -0500
X-MC-Unique: 0bJt-B54Nhy9HoMW8-z5ow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6273E188C153;
 Mon,  9 Nov 2020 15:57:14 +0000 (UTC)
Received: from [10.3.112.154] (ovpn-112-154.phx2.redhat.com [10.3.112.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E626C5577A;
 Mon,  9 Nov 2020 15:57:13 +0000 (UTC)
Subject: Re: [RFC PATCH 1/6] migration: Add multi-thread compress method
To: Zeyu Jin <jinzeyu@huawei.com>, quintela@redhat.com, dgilbert@redhat.com
References: <20201109090850.2424-1-jinzeyu@huawei.com>
 <20201109090850.2424-2-jinzeyu@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <91524faf-9a68-8f9c-dd87-16718d8782a1@redhat.com>
Date: Mon, 9 Nov 2020 09:57:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109090850.2424-2-jinzeyu@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ying Fang <fangying1@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 3:08 AM, Zeyu Jin wrote:
> A multi-thread compress method parameter is added to hold the method we
> are going to use. By default the 'zlib' method is used to maintain the
> compatibility as before.
> 
> Signed-off-by: Zeyu Jin <jinzeyu@huawei.com>
> Signed-off-by: Ying Fang <fangying1@huawei.com>
> ---

Focusing on just the UI:

> +++ b/qapi/migration.json
> @@ -525,6 +525,19 @@
>    'data': [ 'none', 'zlib',
>              { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>  
> +##
> +# @CompressMethod:
> +#
> +# An enumeration of multi-thread compression methods.
> +#
> +# @zlib: use zlib compression method.
> +#
> +# Since: 5.0

This will have to be Since: 6.0, as it has missed feature freeze for 5.2.

> +#
> +##
> +{ 'enum': 'CompressMethod',
> +  'data': [ 'zlib' ] }
> +
>  ##
>  # @BitmapMigrationBitmapAlias:
>  #
> @@ -599,6 +612,9 @@
>  #                      compression, so set the decompress-threads to the number about 1/4
>  #                      of compress-threads is adequate.
>  #
> +# @compress-method: Set compression method to use in multi-thread compression.
> +#                   Defaults to none. (Since 5.0)

Looks like it will be a recurring issue in the series, so I'll quit
pointing it out.

CompressMethod above does not have a 'none' option, so how can it
default to none?  Did you forget an enum option?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


