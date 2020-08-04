Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E454C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6525B208A9
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnkfK0RN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6525B208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2zpQ-00062h-Kj
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k2zoJ-0004qm-4M
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:29:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k2zoH-0000uR-8v
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596558544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50ZUBLPST+3i5wygg0weizcuIiMaGtqj7F17czEE2Ko=;
 b=YnkfK0RNomf1Xhh0OXWZ6xHALxhrHsa5+p25u+DP5p9yp/vUnAAIhYMwMz6qSq3e7rhwKv
 vKfI9jbuK6w4+c7RODZZAHqPoVcTcwi879exYAyZv3AAUh2U0WMtx0Z8EuQ8qdunQwtyCR
 ZyPuSk1MzO/pgLu2ib1VyYax7z+smww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-t6hJJWrEN86hdj-t2Joyiw-1; Tue, 04 Aug 2020 12:28:05 -0400
X-MC-Unique: t6hJJWrEN86hdj-t2Joyiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5678258;
 Tue,  4 Aug 2020 16:28:04 +0000 (UTC)
Received: from [10.3.113.202] (ovpn-113-202.phx2.redhat.com [10.3.113.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF93388D6F;
 Tue,  4 Aug 2020 16:28:03 +0000 (UTC)
Subject: Re: [RFC PATCH 8/8] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 dgilbert@redhat.com
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <1595646669-109310-9-git-send-email-zhengchuan@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b413e8ac-fc4f-aa76-c1d4-332343122302@redhat.com>
Date: Tue, 4 Aug 2020 11:28:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595646669-109310-9-git-send-email-zhengchuan@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, linyilu@huawei.com, qemu-devel@nongnu.org,
 alex.chen@huawei.com, ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 10:11 PM, Chuan Zheng wrote:
> From: Zheng Chuan <zhengchuan@huawei.com>
> 
> Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called
> by libvirt api.
> 
> Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
> ---

> +++ b/qapi/migration.json
> @@ -1621,3 +1621,27 @@
>   ##
>   { 'event': 'UNPLUG_PRIMARY',
>     'data': { 'device-id': 'str' } }
> +
> +##
> +# @cal_dirty_rate:

New QMP commands should be named favoring '-' over '_'; also, it doesn't 
hurt to spell it out:

calculate-dirty-rate

> +#
> +# start calculating dirty rate for vm
> +#
> +# @value: time for sample dirty pages

In what unit?

> +#
> +# Since: 5.1

We've missed 5.1; this will need to be updated to 5.2.

> +#
> +# Example:
> +#   {"command": "cal_dirty_rate", "data": {"value": 1} }
> +#
> +##
> +{ 'command': 'cal_dirty_rate', 'data': {'value': 'int64'} }
> +
> +##
> +# @get_dirty_rate:

get-dirty-rate, except that we tend to use 'query-' as the prefix for 
commands that read values.

> +#
> +# get dirty rate for vm
> +#
> +# Since: 5.1

5.2

What units is the rate expressed in?


> +##
> +{ 'command': 'get_dirty_rate', 'returns': 'int64' }
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index cffae27..ecd294b 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -10,7 +10,8 @@
>           'query-migrate-cache-size',
>           'query-tpm-models',
>           'query-tpm-types',
> -        'ringbuf-read' ],
> +        'ringbuf-read',
> +        'get_dirty_rate' ],
>       'name-case-whitelist': [
>           'ACPISlotType',             # DIMM, visible through query-acpi-ospm-status
>           'CpuInfoMIPS',              # PC, visible through query-cpu
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


