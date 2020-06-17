Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB306C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C822098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6d8Z1mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C822098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlXQx-00047l-UM
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 08:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlXQN-0003hh-QT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:44:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlXQL-0004w9-TK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592397853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=70E46UBTU2IjHJeSA7UMtFO2qjX3gcTTvjmwnlDRSxg=;
 b=i6d8Z1mtAAQwIAUHQLvTy7QWW+eFzMCpl30EhJOGt16LM7tu9mGZy8aLJOn+2EaYsIfMOx
 WkdCVvWQ5Itu+1A5Epq0WsRFg9O3KbVHQ3ptd0icth+XY7kFoNR3AOIlUoqxqS76d/kjJK
 oC2peIM+ECX7OwD1TuAdsleoPx0ANmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-0uc-pkdGOvm47OUp5QPDoA-1; Wed, 17 Jun 2020 08:44:09 -0400
X-MC-Unique: 0uc-pkdGOvm47OUp5QPDoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88DC581EE5C;
 Wed, 17 Jun 2020 12:44:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18BFC60BE2;
 Wed, 17 Jun 2020 12:44:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BDE9116E16; Wed, 17 Jun 2020 14:44:06 +0200 (CEST)
Date: Wed, 17 Jun 2020 14:44:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Geoffrey McRae <geoff@hostfission.com>
Subject: Re: [PATCH 5/6] audio/jack: honour the enable state of the audio
 device
Message-ID: <20200617124406.7dgne73ttfhgkj3x@sirius.home.kraxel.org>
References: <20200613040518.38172-1-geoff@hostfission.com>
 <20200613040518.38172-6-geoff@hostfission.com>
MIME-Version: 1.0
In-Reply-To: <20200613040518.38172-6-geoff@hostfission.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
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

On Sat, Jun 13, 2020 at 02:05:17PM +1000, Geoffrey McRae wrote:
> When the guest closes the audio device we must start dropping input
> samples from JACK and zeroing the output buffer samples. Failure to do
> so causes sound artifacts during operations such as guest OS reboot, and
> causes a hang of the input pipeline breaking it until QEMU is restated.
> 
> Closing and reconnecting to JACK was tested during these enable/disable
> calls which works well for Linux guests, however Windows re-opens the
> audio hardware repeatedly even when doing simple tasks like playing a
> system sounds. As such it was decided it is better to feed silence to
> JACK while the device is disabled.

Hmm, I guess feeding silence into jack needs some cpu cycles?
Maybe add a timer to close the jack server connection?  Keep the
connection open for re-use for a while, but in case the guest stops
playing sound altogether close the jack connection after being unused
for a few minutes?

[ Doesn't render the patch invalid, consider it a suggestion for future
  improvements ]

take care,
  Gerd


