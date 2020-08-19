Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782E9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D60207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzScYvVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D60207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8H8p-0001N6-Fx
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8H7g-00007D-P9
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:58:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8H7f-0007yM-9l
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597816734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=01o/KrWRaTGErtRVC+S2s8I4OfIEuw4mB2s0t60oAaU=;
 b=ZzScYvVKLcp8Gj36zTFcjIpn51hTDCCDe63Oj7+1xgwUr12H4c6LD5XnczUjOoq5KVo/fg
 vxf/FWMIvOqx05XHlSqxXg2ZwnRHoBi44d5u57ocqHCISSaXqvOq4Lhcqlc+05mmIZbv0F
 CeXul85bKcPeqh06DmHe6mCgFtLF8Rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-_gYbr4hQPPy1MCtxz0lqVA-1; Wed, 19 Aug 2020 01:58:52 -0400
X-MC-Unique: _gYbr4hQPPy1MCtxz0lqVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3CC0100CEC9;
 Wed, 19 Aug 2020 05:58:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A0AA19931;
 Wed, 19 Aug 2020 05:58:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A49A631E21; Wed, 19 Aug 2020 07:58:50 +0200 (CEST)
Date: Wed, 19 Aug 2020 07:58:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Geoffrey McRae <geoff@hostfission.com>
Subject: Re: [PATCH v2] audio/jack: fix use after free segfault
Message-ID: <20200819055850.quyyszu36ckbczzw@sirius.home.kraxel.org>
References: <20200819010741.91DAE3A0788@moya.office.hostfission.com>
 <20200819050445.qlhafh2kwh5rt2jh@sirius.home.kraxel.org>
 <9a87a1208b126b2fe882c34a41ebbb18@hostfission.com>
 <5f01ceace88ae5ba515debf57f99e87a@hostfission.com>
MIME-Version: 1.0
In-Reply-To: <5f01ceace88ae5ba515debf57f99e87a@hostfission.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > > schedule a bottom half calling qjack_client_fini()
> > 
> > Does QEMU have such a mechanism for doing this?
> 
> There could also be a possible race here if `jack_client_connect` is called
> before the scheduled shutdown takes place.

You can cancel a scheduled bottom half, and checking ->state on connect
should tell you whenever this is needed or not.  I think you can even
just cancel unconditionally (when not scheduled the cancel is a nop).

HTH,
  Gerd


