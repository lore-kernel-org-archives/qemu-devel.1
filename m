Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010B6C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A0920791
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAuiugUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A0920791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9Qk-0007bj-51
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kL9Kp-000316-Id
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kL9Kn-0007mE-O4
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600885060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GdeNhs0VCwbHiZF8fhTlJOES9pLyXVsRnjwTEqoOvSU=;
 b=eAuiugUEUI8x8NRZnkGhX6kAQsabAItXFpcvY4/hwJivkAQMbrBwNIJJxKNK0gK+/da7cU
 eN88xgcUJJWucIjDbW87pbH75Efm7nqmlnNHctIIBuMqufgOFMbWyyBTtmIfj0/3sRc48u
 VpvmLv4DTfTF8ceSv2gWz9ycLbCbOso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-ICEgTRN-O9KYvG-oWMGLdg-1; Wed, 23 Sep 2020 14:17:36 -0400
X-MC-Unique: ICEgTRN-O9KYvG-oWMGLdg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80894186DD32;
 Wed, 23 Sep 2020 18:17:34 +0000 (UTC)
Received: from [10.3.114.2] (ovpn-114-2.phx2.redhat.com [10.3.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8DDA78823;
 Wed, 23 Sep 2020 18:17:33 +0000 (UTC)
Subject: Re: [PATCH v10 11/12] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 dgilbert@redhat.com, berrange@redhat.com
References: <1600237327-33618-1-git-send-email-zhengchuan@huawei.com>
 <1600237327-33618-12-git-send-email-zhengchuan@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1c8647f5-62d4-bda6-df12-a60c6d0fc4db@redhat.com>
Date: Wed, 23 Sep 2020 13:17:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600237327-33618-12-git-send-email-zhengchuan@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: alex.chen@huawei.com, liq3ea@gmail.com, zhang.zhanghailiang@huawei.com,
 xiexiangyou@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 1:22 AM, Chuan Zheng wrote:
> Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> ---

> +++ b/qapi/migration.json
> @@ -1737,3 +1737,53 @@
>   ##
>   { 'enum': 'DirtyRateStatus',
>     'data': [ 'unstarted', 'measuring', 'measured'] }
> +
> +##
> +# @DirtyRateInfo:
> +#
> +# Information about current dirty page rate of vm.
> +#
> +# @dirty-rate: @dirtyrate describing the dirty page rate of vm
> +#          in units of MB/s.
> +#          If this field return '-1', it means querying is not
> +#          start or not complete.

Grammar:

it means querying has not yet started or completed.

Should this field instead be optional, and omitted for those cases?  In 
which case, I'd suggest:

...in units of MB/s, present only when querying the rate has completed.

> +#
> +# @status: status containing dirtyrate query status includes
> +#          'unstarted' or 'measuring' or 'measured'
> +#
> +# @start-time: start time in units of second for calculation
> +#
> +# @calc-time: time in units of second for sample dirty pages
> +#
> +# Since: 5.2
> +#
> +##
> +{ 'struct': 'DirtyRateInfo',
> +  'data': {'dirty-rate': 'int64',
> +           'status': 'DirtyRateStatus',
> +           'start-time': 'int64',
> +           'calc-time': 'int64'} }
> +
> +##
> +# @calc-dirty-rate:
> +#
> +# start calculating dirty page rate for vm
> +#
> +# @calc-time: time in units of second for sample dirty pages
> +#
> +# Since: 5.2
> +#
> +# Example:
> +#   {"command": "calc-dirty-rate", "data": {"calc-time": 1} }
> +#
> +##
> +{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64'} }
> +
> +##
> +# @query-dirty-rate:
> +#
> +# query dirty page rate in units of MB/s for vm
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


