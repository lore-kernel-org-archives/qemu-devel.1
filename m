Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874A6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8A3208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+L42qbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8A3208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlRSf-0004jA-KO
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 02:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlRRv-0003fp-Ss
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 02:21:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlRRu-0000fR-2v
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 02:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592374885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W6yhuCQJ5Cw+piugchBocxQ7LhK8dEMY1vOfCln4Ebg=;
 b=V+L42qbJOqX+1kOnDHLvfAeVXRvRJpscHl0cvsH6y6VqSyRk8+X1oBVKu4NYKcw7xlmIy1
 rn33pQ1iEMt9V/UfGfDV2oYG8JMhb+mxnyvdaiFiEQQnMGAvhPOxYFpN4ldCaxmpbobSB2
 Z7eWCOv/uKWhGW0rRiqXubp8WVIf1DA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-Fh_EgZFGPyiucmm_Dkf3Ig-1; Wed, 17 Jun 2020 02:21:23 -0400
X-MC-Unique: Fh_EgZFGPyiucmm_Dkf3Ig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69C99E927;
 Wed, 17 Jun 2020 06:21:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C657512FE;
 Wed, 17 Jun 2020 06:21:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1264216E16; Wed, 17 Jun 2020 08:21:12 +0200 (CEST)
Date: Wed, 17 Jun 2020 08:21:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Accessing the Metal graphics API with OSX as VM client
Message-ID: <20200617062112.kovo37ef7qxahthj@sirius.home.kraxel.org>
References: <74a0626c-182c-2a55-2528-9fbcd3085950@trystan.org>
 <CAFEAcA8MXR9wY5MDxxkk62jHVUR8MXeGUMBDB2hwWgo5bs0MfQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8MXR9wY5MDxxkk62jHVUR8MXeGUMBDB2hwWgo5bs0MfQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
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
Cc: Trystan Larey-Williams <trystan@trystan.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> the default answer is that we're not headed anywhere. I think that
> this is not going to be a loss of functionality because right now we
> don't support GL acceleration on OSX hosts either (because there's
> no virglrenderer there).

vulkan support for virglrenderer is being worked on.  Its far from being
finished though, and I have no clue whenever that actually buys you
something on macos.  Also the implementation will likely depend on some
linux kernel features (specifically dma-bufs for buffer sharing &
mapping), so even if vulkan is available on macos making virglrenderer
work on macos will require non-trivial porting work.

take care,
  Gerd


