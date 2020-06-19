Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EBEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7447D206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsGb8IMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7447D206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmDLn-0004OA-NS
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 05:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmDL2-0003Wh-KF
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 05:29:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33267
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmDL0-0005bW-CU
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 05:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592558968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qPGoLG4oItVky73nIFj5LPvMAuxY6dKgN9d6sT0qe/0=;
 b=KsGb8IMZPUfaXoOz3oCtpZPow/yCEfvRTW9nZ0fQgWOuIyZg/sL9Gc6VKboT+ZE3+4v+Tz
 F1ycTLMh+b8kBKVMvJZYboScKMcFpoKDo0df7zLu2c0oIh/vtgcsFGR9CiIa1SqXqc8X1x
 ao7OIMcEkC8HRs4sUHufEL9OStN/TDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-cHw4-03EPJmpyMm4BjuqMA-1; Fri, 19 Jun 2020 05:29:26 -0400
X-MC-Unique: cHw4-03EPJmpyMm4BjuqMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08060835B40;
 Fri, 19 Jun 2020 09:29:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0F795C28E;
 Fri, 19 Jun 2020 09:29:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AFC8316E16; Fri, 19 Jun 2020 11:29:24 +0200 (CEST)
Date: Fri, 19 Jun 2020 11:29:24 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Geoffrey McRae <geoff@hostfission.com>
Subject: Re: [PATCH 5/6] audio/jack: honour the enable state of the audio
 device
Message-ID: <20200619092924.wjvegwpfrpaq6adz@sirius.home.kraxel.org>
References: <20200613040518.38172-1-geoff@hostfission.com>
 <20200613040518.38172-6-geoff@hostfission.com>
 <20200617124406.7dgne73ttfhgkj3x@sirius.home.kraxel.org>
 <a08a08cc6735d2fb2ba07145befc64c3@hostfission.com>
MIME-Version: 1.0
In-Reply-To: <a08a08cc6735d2fb2ba07145befc64c3@hostfission.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
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

  Hi,

> > Hmm, I guess feeding silence into jack needs some cpu cycles?
> > Maybe add a timer to close the jack server connection?  Keep the
> > connection open for re-use for a while, but in case the guest stops
> > playing sound altogether close the jack connection after being unused
> > for a few minutes?
> > 
> > [ Doesn't render the patch invalid, consider it a suggestion for future
> >   improvements ]
> 
> Thanks, I had considered that however there is a usability issue to
> consider. Each time a jack client registers, it removes the client entirely
> and disconnects any custom plumbing that may have been done by the user.

Hmm, ok, that is bad indeed.

Can you stop the stream without closing the connection?

> JACK does not remember this custom routing and as such it's lost until the
> user re-establishes it, or they have some automation set up to do it. While
> this could likely be worked around, it would likely cause more headaches
> then the few CPU cycles lost in a memset.

I'm more concerned about the frequent wakeups to feed the next chunk of
(silence) data to jack.

take care,
  Gerd


