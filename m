Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD67C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1882082F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mhczqsjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1882082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6FW6-0001Bq-Vd
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 10:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j6FVT-0000hn-4o
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j6FVP-0002oF-6M
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:18:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33074
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j6FVP-0002o3-2r
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582557526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFztqGY2CevBtmiD+XRqm8dBwJ4JvKgmdhuBREi2X3E=;
 b=Mhczqsjn2c/BU01dNiFSpvE5gjFI1bi4XDkULEJuCkJTlvTjLKSRJXzcsCIYkLIJjZuRj8
 WeUycG+P/7UBjRHainP8t3xlAbjpFXUeQrHuTHHBCoBrNg24+LBgzhsBCutCArv3x82TIj
 0GUcWFM7spxVGNdkNhYf2o8C7sdOOAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-ir-LB0GVN7yCLyXH33Zgkw-1; Mon, 24 Feb 2020 10:18:44 -0500
X-MC-Unique: ir-LB0GVN7yCLyXH33Zgkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF37C100550E;
 Mon, 24 Feb 2020 15:18:42 +0000 (UTC)
Received: from [10.3.116.90] (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19F8286810;
 Mon, 24 Feb 2020 15:18:42 +0000 (UTC)
Subject: Re: [PATCH V2 7/8] COLO: Migrate dirty pages during the gap of
 checkpointing
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org
References: <20200224065414.36524-1-zhang.zhanghailiang@huawei.com>
 <20200224065414.36524-8-zhang.zhanghailiang@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6b161824-9765-5c7c-39a0-580b0c65879c@redhat.com>
Date: Mon, 24 Feb 2020 09:18:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224065414.36524-8-zhang.zhanghailiang@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: danielcho@qnap.com, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 12:54 AM, zhanghailiang wrote:
> We can migrate some dirty pages during the gap of checkpointing,
> by this way, we can reduce the amount of ram migrated during checkpointing.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---

> +++ b/qapi/migration.json
> @@ -977,12 +977,14 @@
>   #
>   # @vmstate-loaded: VM's state has been loaded by SVM.
>   #
> +# @migrate-ram-background: Send some dirty pages during the gap of COLO checkpoint

Missing a '(since 5.0)' tag.

> +#
>   # Since: 2.8
>   ##
>   { 'enum': 'COLOMessage',
>     'data': [ 'checkpoint-ready', 'checkpoint-request', 'checkpoint-reply',
>               'vmstate-send', 'vmstate-size', 'vmstate-received',
> -            'vmstate-loaded' ] }
> +            'vmstate-loaded', 'migrate-ram-background' ] }
>   
>   ##
>   # @COLOMode:
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


