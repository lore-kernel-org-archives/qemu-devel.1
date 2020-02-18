Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB74C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14C8206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6VjcoC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14C8206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42hS-0005ZM-44
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j42Zc-0001Eq-11
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j42Za-0003XO-Pe
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:05:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30623
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j42Za-0003Wi-LO
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582031157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVMPRxtMzmEDKU7cW6BwX/HohxlnHYsLMq8UCFg2seg=;
 b=d6VjcoC9TdIvTQaKfH38qGVBjA8Lzm+KdWtAr8+rKWsEuQxEfbfEaalomL6dvF/D3xw+QY
 OKazkyTUQ4RIUxRdgi+2oMatY0n59HodZfPO2dRPDqjFAcONSDgYOj/TOO5yeSYSAcfCTe
 OU2ZhzGv8i9XDTy3H9VCfjM+BwJqJrQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-vuT8RaWIPJenZ4HTdV1c7A-1; Tue, 18 Feb 2020 08:05:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39AB0800D48;
 Tue, 18 Feb 2020 13:05:08 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAC1226571;
 Tue, 18 Feb 2020 13:05:07 +0000 (UTC)
Subject: Re: [PATCH v3 03/33] block: Add BdrvChildRole and BdrvChildRoleBits
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <676389c2-6ff4-97c6-506a-20aa2d2bbfe4@redhat.com>
Date: Tue, 18 Feb 2020 07:05:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218124242.584644-4-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: vuT8RaWIPJenZ4HTdV1c7A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
> This mask will supplement BdrvChildClass when it comes to what role (or
> combination of roles) a child takes for its parent.  It consists of
> BdrvChildRoleBits values (which is an enum).
> 
> Because empty enums are not allowed, let us just start with it filled.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block.h | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)

> +
> +/* Mask of BdrvChildRoleBits values */
> +typedef unsigned int BdrvChildRole;
> +

I like how it turned out (both the additional comments earlier on, and 
the typedef for documentation purposes).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


