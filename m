Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C44DC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399B324673
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMkvS46J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399B324673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOBV-0006LV-5x
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jBO7g-0002gF-45
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jBO7f-0006y3-18
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:31:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34752
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jBO7e-0006xl-T4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583782290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qb2HK7gD8vvo+qp9kV5xiYDLPRJ1CLCmIXVZJ+d7YY=;
 b=aMkvS46JMDteedYtj9Uo12eZDrF+39aksvghMSH+R+37QA3n6Ew/0HsmCSYuKPoZ7NfV9b
 nXhu3gZAyUCyZut8pphm17GAMc6Z3r6AhjeGzZnWQHuGPHDV8I2BkIEuho550eUT/dQNWU
 +gzSyMXCO+sk9Kd8O9NU6FXg+v0aZ1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-k8DUW0oSNuOisN3EX_Cxnw-1; Mon, 09 Mar 2020 15:31:29 -0400
X-MC-Unique: k8DUW0oSNuOisN3EX_Cxnw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE15813E2;
 Mon,  9 Mar 2020 19:31:27 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93E5A73879;
 Mon,  9 Mar 2020 19:31:27 +0000 (UTC)
Subject: Re: [PATCH v10 02/10] qemu-binfmt-conf.sh: enforce safe tests
To: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org
References: <20200309191200.GA60@669c1c222ef4>
 <20200309191924.GB65@669c1c222ef4>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <abab5dde-a93c-46d0-a28f-b4cf952c3ac5@redhat.com>
Date: Mon, 9 Mar 2020 14:31:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309191924.GB65@669c1c222ef4>
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 2:19 PM, Unai Martinez-Corral wrote:
> All the tests are prefixed with 'x', in order to avoid risky comparisons
> (i.e. a user deliberately trying to provoke a syntax error).
> 
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   scripts/qemu-binfmt-conf.sh | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


