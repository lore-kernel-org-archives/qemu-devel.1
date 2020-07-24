Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC1EC433EC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D997C20674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwnLZwkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D997C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyPj-0004a2-5A
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyyOx-0003nb-Hv
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:10:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42495
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyyOv-0000zt-UZ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595599816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLu2u95l315t5wuCcq+JNgOxunhA10CcQxyv/NyzXaM=;
 b=JwnLZwkh3bw3MCyDxIPdEL4ekhcGCRpTb8Fh0b+qu/9HqZpNPsacBsqaGzcvLKOf+ioT94
 9k3LaN7KlUvGPz+JCDaXFXzl/xDsrCsEipm7mttGbCRdkrJ2KdjoWomtrGC5RiRlBH4Amp
 kNWpGKm6ZthxwyXq/R+/6O7HlxB9pEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-JwpyAh66MsW6cF0eWJEYZA-1; Fri, 24 Jul 2020 10:10:05 -0400
X-MC-Unique: JwpyAh66MsW6cF0eWJEYZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6984A80046D;
 Fri, 24 Jul 2020 14:10:04 +0000 (UTC)
Received: from [10.3.112.130] (ovpn-112-130.phx2.redhat.com [10.3.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28B625D9E2;
 Fri, 24 Jul 2020 14:10:01 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] block: switch to use qemu_open/qemu_create for
 improved errors
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200724132510.3250311-1-berrange@redhat.com>
 <20200724132510.3250311-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <18b793fa-bb7f-f2a2-62de-f6b396f5e93f@redhat.com>
Date: Fri, 24 Jul 2020 09:10:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724132510.3250311-5-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:44:00
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 8:25 AM, Daniel P. Berrangé wrote:
> Currently at startup if using cache=none on a filesystem lacking
> O_DIRECT such as tmpfs, at startup QEMU prints
> 
> qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: file system may not support O_DIRECT
> qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: Could not open '/tmp/foo.img': Invalid argument

Are we trying to get this in 5.1?

> 
> while at QMP level the hint is missing, so QEMU reports just
> 
>    "error": {
>        "class": "GenericError",
>        "desc": "Could not open '/tmp/foo.img': Invalid argument"
>    }
> 
> which is close to useless for the end user trying to figure out what
> they did wrong.
> 
> With this change at startup QEMU prints
> 
> qemu-system-x86_64: -drive file=/tmp/foo.img,cache=none: Unable to open '/tmp/foo.img' flags 0x4000: filesystem does not support O_DIRECT
> 
> while at the QMP level QEMU reports a massively more informative
> 
>    "error": {
>       "class": "GenericError",
>       "desc": "Unable to open '/tmp/foo.img' flags 0x4002: filesystem does not support O_DIRECT"
>    }
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

> @@ -3335,7 +3331,7 @@ static bool setup_cdrom(char *bsd_path, Error **errp)
>       for (index = 0; index < num_of_test_partitions; index++) {
>           snprintf(test_partition, sizeof(test_partition), "%ss%d", bsd_path,
>                    index);
> -        fd = qemu_open_old(test_partition, O_RDONLY | O_BINARY | O_LARGEFILE);
> +        fd = qemu_open(test_partition, O_RDONLY | O_BINARY | O_LARGEFILE, NULL);

Should qemu_open() always be setting O_BINARY|O_LARGEFILE, without us 
having to worry about them at each caller?  But that's a separate cleanup.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


