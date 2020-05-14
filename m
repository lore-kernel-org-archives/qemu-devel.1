Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A36C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074DD20722
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGJ+xMNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074DD20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZD1I-0004qx-8J
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZCyF-0000tT-Qb
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:28:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24202
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZCyF-0004oQ-2W
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589459294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W1xUEYTfE6rvtRtBPS1Yw//kTrmiDal2NvUYPSHp7G8=;
 b=JGJ+xMNJveWna7iT4/81Uo4oZ+9uBmKX/d1jOk+Nh2qKoF9Qa14V8aCQcYSkeEQq8dGAEV
 gErp681+cRiTBntIN3CANJD1izSm4FS4bpx4f42LFmQFnPZQbe1QtaLB8wdbgrEENjouw9
 1lIZFdy8NTsIW1ZNoK+V3ELCBvWxCbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-K76mtzBVNAyhTaLDw7pyyg-1; Thu, 14 May 2020 08:28:11 -0400
X-MC-Unique: K76mtzBVNAyhTaLDw7pyyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCB6A835B58;
 Thu, 14 May 2020 12:28:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 836CE6E50B;
 Thu, 14 May 2020 12:28:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8981B9DAD; Thu, 14 May 2020 14:28:08 +0200 (CEST)
Date: Thu, 14 May 2020 14:28:08 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v2] ui/sdl2: fix segment fault caused by null pointer
 dereference
Message-ID: <20200514122808.55plccwalnxay2jg@sirius.home.kraxel.org>
References: <20200427132412.17909-1-changbin.du@gmail.com>
 <20200508134424.dg44xm7lt4ahqftn@mail.google.com>
MIME-Version: 1.0
In-Reply-To: <20200508134424.dg44xm7lt4ahqftn@mail.google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Fri, May 08, 2020 at 09:44:24PM +0800, Changbin Du wrote:
> hello, is this ready to merge now?
> 
> On Mon, Apr 27, 2020 at 09:24:12PM +0800, Changbin Du wrote:
> > I found SDL_GetWindowFromID() sometimes return NULL when I start qemu via
> > ssh forwarding even the window has been crated already. I am not sure
> > whether this is a bug of SDL, but we'd better check it carefully.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>

Added to ui queue now.

thanks,
  Gerd


