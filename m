Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC47C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951B7217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4bwHXUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951B7217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ZRj-0001xx-OZ
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 06:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j2ZQt-0001T0-Dj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j2ZQs-0000w9-EQ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:46:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38266
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j2ZQs-0000v0-BZ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581680813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxMX0UpvUTdAOsL+LgluIHhV1v8PCiN4B847b3lrIMU=;
 b=E4bwHXUzIALrmvrHZe6T32VcdLoV0j5L9HIKroxnK3IxmChv5IBJv97kuxSUODPjW5Vi15
 sXp6qkPkoWclA7gVW9oPpH3glJrSQtdgMacmkilUCGX1ZXw0ReLY9F6V4cUR5DlkPIJ/Da
 fjrhyb8S/zx2Wo1UBSjW5uQGdTzjNlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-fjWVyNt2OC-M0X9KDyw6lA-1; Fri, 14 Feb 2020 06:46:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2D5C8018A5;
 Fri, 14 Feb 2020 11:46:43 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0DB260BFB;
 Fri, 14 Feb 2020 11:46:42 +0000 (UTC)
Subject: Re: [PATCH] migration/throttle: Make throttle slower at tail stage
To: Keqian Zhu <zhukeqian1@huawei.com>, qemu-devel@nongnu.org
References: <20200214032700.25011-1-zhukeqian1@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d46149e5-8d8f-d3b8-91ec-145c102cffb7@redhat.com>
Date: Fri, 14 Feb 2020 05:46:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214032700.25011-1-zhukeqian1@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: fjWVyNt2OC-M0X9KDyw6lA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 2/13/20 9:27 PM, Keqian Zhu wrote:
> At the tail stage of throttle, VM is very sensitive to
> CPU percentage. We just throttle 30% of remaining CPU
> when throttle is more than 80 percentage.
> 
> This doesn't conflict with cpu_throttle_increment.
> 
> This may make migration time longer, and is disabled
> by default.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>

> +++ b/qapi/migration.json
> @@ -532,6 +532,12 @@
>   #                          auto-converge detects that migration is not making
>   #                          progress. The default value is 10. (Since 2.7)
>   #
> +# @cpu-throttle-tailslow: Make throttle slower at tail stage
> +#                         At the tail stage of throttle, VM is very sensitive to
> +#                         CPU percentage. We just throttle 30% of remaining CPU
> +#                         when throttle is more than 80 percentage. The default
> +#                         value is false. (Since 4.1)

The next release is 5.0, not 4.1.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


