Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA4AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B242073E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyAnnAc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B242073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnQBm-0001P7-Hv
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 13:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnQB6-0000jl-3v
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:24:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26321
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnQB4-0005hy-Cz
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592846652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HS4Ywyy0Hf5KYZzJQwPN6OVQXyJ7FLlaV5UQhOZI700=;
 b=YyAnnAc9MRx76jNfz84K67DEkgZrBuSZu3wV6ugIxod2TM2Qgm/IxXSbVg1cmR2Zga/Eki
 GFFKPxCa/K9GuHsTCoscb2Dh8CTeRIqnySIDzSL22aouJVI9n8fImIfE73+cGmmHpRhzws
 9SH0q2VFXf50bEX3L9WgdyhWkTRdrkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288--siz_-zLOVGoQZpDLmD5JQ-1; Mon, 22 Jun 2020 13:23:56 -0400
X-MC-Unique: -siz_-zLOVGoQZpDLmD5JQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68F6B464;
 Mon, 22 Jun 2020 17:23:55 +0000 (UTC)
Received: from [10.3.114.4] (ovpn-114-4.phx2.redhat.com [10.3.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0CA87C1FE;
 Mon, 22 Jun 2020 17:23:51 +0000 (UTC)
Subject: Re: [PATCH v1 1/1] migration/colo.c: migrate dirty ram pages before
 colo checkpoint
To: Derek Su <dereksu@qnap.com>, qemu-devel@nongnu.org
References: <20200621021004.5559-1-dereksu@qnap.com>
 <20200621021004.5559-2-dereksu@qnap.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1c13571b-f980-138c-0e22-a36f49bb2ca8@redhat.com>
Date: Mon, 22 Jun 2020 12:23:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200621021004.5559-2-dereksu@qnap.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: zhang.zhanghailiang@huawei.com, chyang@qnap.com, quintela@redhat.com,
 dgilbert@redhat.com, ctcheng@qnap.com, jwsu1986@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/20 9:10 PM, Derek Su wrote:
> To reduce the guest's downtime during checkpoint, migrate dirty
> ram pages as many as possible before colo checkpoint.
> 
> If the iteration count reaches COLO_RAM_MIGRATE_ITERATION_MAX or
> ram pending size is lower than 'x-colo-migrate-ram-threshold',
> stop the ram migration and colo checkpoint.
> 
> Signed-off-by: Derek Su <dereksu@qnap.com>
> ---
>   migration/colo.c       | 79 ++++++++++++++++++++++++++++++++++++++++++
>   migration/migration.c  | 20 +++++++++++
>   migration/trace-events |  2 ++
>   monitor/hmp-cmds.c     |  8 +++++
>   qapi/migration.json    | 18 ++++++++--
>   5 files changed, 125 insertions(+), 2 deletions(-)

Focusing just on UI,


> +++ b/qapi/migration.json
> @@ -600,6 +600,9 @@
>   # @x-checkpoint-delay: The delay time (in ms) between two COLO checkpoints in
>   #                      periodic mode. (Since 2.8)
>   #
> +# @x-colo-migrate-ram-threshold: the threshold (in bytes) of the COLO ram migration's

Long line, please wrap prior to 80 columns.

> +#                                pending size before COLO checkpoint. (Since 5.0)

s/5.0/5.1/

> +#
>   # @block-incremental: Affects how much storage is migrated when the
>   #                     block migration capability is enabled.  When false, the entire
>   #                     storage backing chain is migrated into a flattened image at
> @@ -651,7 +654,8 @@
>              'cpu-throttle-initial', 'cpu-throttle-increment',
>              'cpu-throttle-tailslow',
>              'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> -           'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
> +           'downtime-limit', 'x-checkpoint-delay',
> +           'x-colo-migrate-ram-threshold', 'block-incremental',
>              'multifd-channels',
>              'xbzrle-cache-size', 'max-postcopy-bandwidth',
>              'max-cpu-throttle', 'multifd-compression',
> @@ -740,6 +744,9 @@
>   #
>   # @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
>   #
> +# @x-colo-migrate-ram-threshold: the threshold in bytes of the COLO ram migration's
> +#                                pending size before COLO checkpoint. (Since 5.0)
> +#

Ditto.


> @@ -1116,12 +1128,14 @@
>   #
>   # @vmstate-loaded: VM's state has been loaded by SVM.
>   #
> +# @migrate-ram: Send dirty pages as many as possible before COLO checkpoint.
> +#

Missing a notation that migrate-ram is since 5.1.

>   # Since: 2.8
>   ##
>   { 'enum': 'COLOMessage',
>     'data': [ 'checkpoint-ready', 'checkpoint-request', 'checkpoint-reply',
>               'vmstate-send', 'vmstate-size', 'vmstate-received',
> -            'vmstate-loaded' ] }
> +            'vmstate-loaded', 'migrate-ram' ] }
>   
>   ##
>   # @COLOMode:
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


