Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E3FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB5E20702
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFu1qENS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB5E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqNGC-0006Xl-UU
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqNFK-0005od-LX
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 16:52:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30554
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqNFI-00042X-1W
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 16:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593550366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V56K+a8mq8ksqdgM7uZyQi18ArqwScpjTLYuCQ0IBXY=;
 b=cFu1qENS/zXtSOPP3YPxQb9xTD5Gq0VJV1jCkZ+xbPlNEeEGjMxJ6KyldPh7qgUWt4c2Kc
 lIU1YYBu7rQSKzAHATdNRVRL7OoSMtIvQygZp2m1uFXScwefW6EYZ7fTUQWZFAY+9OI5h1
 783mjf6L9V0U02+Mmboq/59mEI2FgcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-R3Ro1a5dOOeXtIS0OQ5Ttg-1; Tue, 30 Jun 2020 16:52:43 -0400
X-MC-Unique: R3Ro1a5dOOeXtIS0OQ5Ttg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 053BD805EEE;
 Tue, 30 Jun 2020 20:52:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9A9B19C79;
 Tue, 30 Jun 2020 20:52:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DF2BC16E16; Tue, 30 Jun 2020 22:52:38 +0200 (CEST)
Date: Tue, 30 Jun 2020 22:52:38 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v4] sm501: Fix and optimize overlap check
Message-ID: <20200630205238.rwzs7rlr4l2qjsmw@sirius.home.kraxel.org>
References: <f0b64bf047e343f8b2e91baeccb4753bc26b17cc.1592686588.git.balaton@eik.bme.hu>
 <20200624164737.A941374633D@zero.eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <20200624164737.A941374633D@zero.eik.bme.hu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 06:42:18PM +0200, BALATON Zoltan wrote:
> When doing reverse blit we need to check if source and dest overlap
> but it is not trivial due to possible different base and pitch of
> source and dest. Do rectangle overlap if base and pitch match,
> otherwise just check if memory area containing the rects overlaps so
> rects could possibly overlap.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> This version fixes overlap check according to Peter's suggestion, only
> resending this patch as v4, others still valid from v3. Let me know if
> you want the whole series resent instead.

Queued up now,  Last patch in a series is easy to replace.

thanks,
  Gerd


