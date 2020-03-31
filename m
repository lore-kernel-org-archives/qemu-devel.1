Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBB4C2D0F2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE6920781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8ArUCnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE6920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIXS-0003P2-PO
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJIQK-0001iv-IC
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJIQF-0001E6-Gc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:03:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54149
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJIQF-0001Dq-B0
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585667003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=acgp/8hO5UArPmrgeVJ48WS3S8E4cqI7wgzYYPeFL68=;
 b=T8ArUCnUt+Y5zvP59KN1SLy0hVQ0Uyl5gRpFKdgmoud5HpivVb96dMV+9Dg/GctxN3As36
 TY1z/zRX/PNH/ksGphxPxzgUDQzYItj5saD5vW9xTC0VtH9okJtR42doonNCp+7z+BxuEQ
 Glv7XfWv0dQRJVGhAxJPR31Ei9P9dHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-tIWDjKiRPAqTwiNExeh3gA-1; Tue, 31 Mar 2020 11:03:21 -0400
X-MC-Unique: tIWDjKiRPAqTwiNExeh3gA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 399F8189F785;
 Tue, 31 Mar 2020 15:03:20 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 366741001B2B;
 Tue, 31 Mar 2020 15:03:19 +0000 (UTC)
Subject: Re: [PATCH v2] migration/throttle: Add cpu-throttle-tailslow
 migration parameter
To: Keqian Zhu <zhukeqian1@huawei.com>, qemu-devel@nongnu.org
References: <20200316042935.28306-1-zhukeqian1@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <144483ff-e10d-e1b5-0c60-609b4da9c217@redhat.com>
Date: Tue, 31 Mar 2020 10:03:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200316042935.28306-1-zhukeqian1@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On 3/15/20 11:29 PM, Keqian Zhu wrote:
> At the tail stage of throttling, the Guest is very sensitive to
> CPU percentage while the @cpu-throttle-increment is excessive
> usually at tail stage.
> 
> If this parameter is true, we will compute the ideal CPU percentage
> used by the Guest, which may exactly makes dirty rate to be dirty
> rate threshold. Then we will choose a smaller throttle increment
> between the one specified by @cpu-throttle-increment and the one
> generated by ideal CPU percentage.
> 
> Therefore, it is compatible to traditional throttling, meanwhile
> the throttle increment won't be excessive at tail stage. This may
> make migration time longer, and is disabled by default.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/qapi/migration.json
> @@ -552,6 +552,21 @@
>   #                          auto-converge detects that migration is not making
>   #                          progress. The default value is 10. (Since 2.7)
>   #
> +# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage
> +#                         At the tail stage of throttling, the Guest is very
> +#                         sensitive to CPU percentage while the @cpu-throttle
> +#                         -increment is excessive usually at tail stage.
> +#                         If this parameter is true, we will compute the ideal
> +#                         CPU percentage used by the Guest, which may exactly
> +#                         makes dirty rate to be dirty rate threshold. Then we

Grammar is off here, but I don't know if you meant "which may exactly 
make the dirty rate match the dirty rate threshold" or something else.

> +#                         will choose a smaller throttle increment between the
> +#                         one specified by @cpu-throttle-increment and the one
> +#                         generated by ideal CPU percentage.
> +#                         Therefore, it is compatible to traditional throttling,
> +#                         meanwhile the throttle increment won't be excessive
> +#                         at tail stage.
> +#                         The default value is false. (Since 5.0)

Is this a bug-fix that must make it into 5.0?  It seems more like a 
feature addition, at which point listing it for 5.1 is probably a better 
idea.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


