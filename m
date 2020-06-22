Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19662C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7894206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1hu61+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7894206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnIPH-0000QL-Qk
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnIOA-0007IW-0Z
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:05:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49698
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnIO8-0005uQ-51
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592816710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bKwOL50KRik/CawZkBbFc7g5lKF23F2NVueIQNZH9YA=;
 b=g1hu61+CxnRUjGIMOZbgvBkNz1+DYz0HYKVBVQxWWlNLOFiIEwC67ibTwJqVJMIaXrrYnN
 YBfBCpa8TBv92N+6FEMmNrIXaZnNU+Sx+JPC5arM1+WbXSFEJK/hWU9AsAN7akcb853UO8
 k5gSpDF6CqyYYxIZZSgZHDzOge0tuXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-WYJBiooBNX-9lIN9GOXLrg-1; Mon, 22 Jun 2020 05:05:09 -0400
X-MC-Unique: WYJBiooBNX-9lIN9GOXLrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C104D107ACCD;
 Mon, 22 Jun 2020 09:05:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77E2D7C204;
 Mon, 22 Jun 2020 09:05:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6DB9117477; Mon, 22 Jun 2020 11:05:06 +0200 (CEST)
Date: Mon, 22 Jun 2020 11:05:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Geoffrey McRae <geoff@hostfission.com>
Subject: Re: [PATCH 5/6] audio/jack: honour the enable state of the audio
 device
Message-ID: <20200622090506.tmq7a4hig5whrf6c@sirius.home.kraxel.org>
References: <20200613040518.38172-1-geoff@hostfission.com>
 <20200613040518.38172-6-geoff@hostfission.com>
 <20200617124406.7dgne73ttfhgkj3x@sirius.home.kraxel.org>
 <a08a08cc6735d2fb2ba07145befc64c3@hostfission.com>
 <20200619092924.wjvegwpfrpaq6adz@sirius.home.kraxel.org>
 <649d66d244d7fdc8375464f91a7b254c@hostfission.com>
MIME-Version: 1.0
In-Reply-To: <649d66d244d7fdc8375464f91a7b254c@hostfission.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 21, 2020 at 02:06:25PM +1000, Geoffrey McRae wrote:
> 
> > Can you stop the stream without closing the connection?
> 
> Not as far as I can tell, it seems the JACK API doesn't allow for this in a
> way that is useful to us.

What happens if you don't feed data to jack?  The cracking you hear on
reboots etc. sounds like jack might reuses the buffers in that case.

So, maybe you can stop sending data to jack when all buffers are already
filled with silence?

take care,
  Gerd


