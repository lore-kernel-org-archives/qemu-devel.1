Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE4CC35666
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 20:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6BD20578
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 20:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkBrARwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6BD20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Ee0-0004jg-V5
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 15:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j5Ecq-0003GO-M0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 15:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j5Ecp-0007t8-78
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 15:10:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27192
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j5Ecp-0007s8-1n
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 15:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582315813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50xmr0NTYwSScksm8gVD6PFXJnTyYt5MVFSBX9ZvBbY=;
 b=FkBrARwvCfF32rDOI9WUXRg2g1yMWa6KCGje65HKnpE4rc07WTPHgMwhljP4fGc5XEqx4y
 Cx5VmDk1J8NIm+RXCLANcjSyxJGpE2xPmMgTGWIjhkG09sniLBUIOLBMMnoLoM+X9Qu8aS
 0jOPRpxY2IW8SKP+DLEW7ZS0/E2kIoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-9f5JfNYmMjSWhaHa6SLUFQ-1; Fri, 21 Feb 2020 15:10:05 -0500
X-MC-Unique: 9f5JfNYmMjSWhaHa6SLUFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AAE2800D48;
 Fri, 21 Feb 2020 20:10:04 +0000 (UTC)
Received: from [10.3.116.90] (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8226B9182B;
 Fri, 21 Feb 2020 20:10:03 +0000 (UTC)
Subject: Re: [PATCH] migration/throttle: Add throttle-trig-thres migration
 parameter
To: Keqian Zhu <zhukeqian1@huawei.com>, qemu-devel@nongnu.org
References: <20200221025727.63808-1-zhukeqian1@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2db47b97-729f-4ccb-dab2-585771acc2fe@redhat.com>
Date: Fri, 21 Feb 2020 08:14:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221025727.63808-1-zhukeqian1@huawei.com>
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
Cc: wanghaibin.wang@huawei.com, qemu-arm@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/20/20 8:57 PM, Keqian Zhu wrote:
> Currently, if the bytes_dirty_period is more than the 50% of
> bytes_xfer_period, we start or increase throttling.
> 
> If we make this percentage higher, then we can tolerate higher
> dirty rate during migration, which means less impact on guest.
> The side effect of higher percentage is longer migration time.
> 
> We can configure this parameter to switch between migration time
> firt or guest performance first. The default value is 50.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/qapi/migration.json
> @@ -524,6 +524,10 @@
>   #                      compression, so set the decompress-threads to the number about 1/4
>   #                      of compress-threads is adequate.
>   #
> +# @throttle-trig-thres: The ratio of bytes_dirty_period and bytes_xfer_period to
> +#                       trigger throttling. It is expressed as percentage. The
> +#                       default value is 50. (Since 5.0)
> +#

Abbreviating feels odd; can you please spell this out as 
throttle-trigger-threshold?

Can the threshold exceed 100%?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


