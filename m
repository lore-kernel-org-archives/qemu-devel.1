Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071B9C3403A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75AE206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGM+QLas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75AE206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42m3-0003q1-W5
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j42dx-0008Dg-6g
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j42dw-0005EZ-7y
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:10:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38807
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j42dw-0005ET-42
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582031427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QnBBehWhU4pKRH3ZOWPqu38xiPcgxsMvgD+QN0pvvFo=;
 b=gGM+QLasyQObvtwJspr/Zl5lK1RQmXGkeeC5Kclx4JInV5dRo7zx8GeR8AYOKHN+dfikQL
 qH4H4aW4ZU59IntF8I02EtpzH5O+3MiY2kGmei589AB/XWURzRxcHTJX4HPQB52+RmCQzD
 G5Yz5oIGrw5Lac+nxjJRSiqlbYaVQFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-GAZAdzUdOia5XzVQL4JGeg-1; Tue, 18 Feb 2020 08:10:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EED513F6;
 Tue, 18 Feb 2020 13:10:23 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2DCE5DA76;
 Tue, 18 Feb 2020 13:10:22 +0000 (UTC)
Subject: Re: [PATCH v3 20/33] block: Switch child_format users to child_of_bds
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-21-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9333de5a-35c0-619b-3f8f-ea743fc2e033@redhat.com>
Date: Tue, 18 Feb 2020 07:10:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218124242.584644-21-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: GAZAdzUdOia5XzVQL4JGeg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 6:42 AM, Max Reitz wrote:
> Both users (quorum and blkverify) use child_format for
> not-really-filtered children, so the appropriate BdrvChildRole in both
> cases is DATA.  (Note that this will cause bdrv_inherited_options() to
> force-allow format probing.)
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/blkverify.c | 4 ++--
>   block/quorum.c    | 6 ++++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


