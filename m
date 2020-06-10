Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0C1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE89220656
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 19:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R77HDR0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE89220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj6Ae-000156-51
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 15:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jj64T-0004bs-A2
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 15:07:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46097
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jj64R-0006cw-RC
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 15:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591816047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDiCdl//gw1cS4yee9E6Qb88Rq3/BV3mdiFaIoMvRJw=;
 b=R77HDR0zjqCFStYLR8rnLUthQqWvaZm9DzfG9Kg2fhOXeOANooCvxzHC1XNjADeT72c45G
 51APmV6zxy/7EpMapttlIlxzVczLngSt275xIEFq8d3MPgwxt/nbTk36TH/6CNA/3riZTo
 81vT06j9VFmaSUQ/gzMAMMdRbedEwSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-jrQih3MeMMyGWXBoc6MYTw-1; Wed, 10 Jun 2020 15:07:25 -0400
X-MC-Unique: jrQih3MeMMyGWXBoc6MYTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F69F8014D9;
 Wed, 10 Jun 2020 19:07:24 +0000 (UTC)
Received: from work-vm (ovpn-114-209.ams2.redhat.com [10.36.114.209])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 251AE19C71;
 Wed, 10 Jun 2020 19:07:22 +0000 (UTC)
Date: Wed, 10 Jun 2020 20:07:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] migration: fix xbzrle encoding rate calculation
Message-ID: <20200610190720.GI2718@work-vm>
References: <1591577607-13998-1-git-send-email-wei.w.wang@intel.com>
 <d859347e-ef56-46a2-ece5-e8bcd6753f0b@linaro.org>
MIME-Version: 1.0
In-Reply-To: <d859347e-ef56-46a2-ece5-e8bcd6753f0b@linaro.org>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: yi.y.sun@intel.com, Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Richard Henderson (richard.henderson@linaro.org) wrote:
> On 6/7/20 5:53 PM, Wei Wang wrote:
> > It's reported an error of implicit conversion from "unsigned long" to
> > "double" when compiling with Clang 10. Simply make the encoding rate 0
> > when the encoded_size is 0.
> > 
> > Fixes: e460a4b1a4
> > Reported-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > ---
> >  migration/ram.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Queuing to a clang 10 fixes branch.

Thanks

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Dave


> 
> 
> r~
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


