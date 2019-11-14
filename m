Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8391C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 07:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776FE206D6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 07:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdI+m2Ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776FE206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV9Rq-00014T-HA
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 02:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iV9Qv-0000eg-AN
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 02:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iV9Qt-0006kF-En
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 02:20:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iV9Qt-0006jc-87
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 02:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573716046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2aqG6ZcaRAAd6rZfR/jhCbJ2UlHGr/voXyuCQNtmqE=;
 b=AdI+m2BaV7mVxQF2cdzEbCHLv1OU+rq3axD9DDmlwRSoPo8sVZyqaVkotbaXkDJ1SsZJ68
 906SXkZnC9Tu0n/aYuo629tBxXwpZEoFaXRQwHFkWyFG+MJAbgHufdi2H2/Y1diIsSm9/h
 2ZRbS4Ju9Emx/mjAq/qv3R7gDWR+O6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-kiLC0Ok2P1SOZR9MjfpRMg-1; Thu, 14 Nov 2019 02:20:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9B94801E76;
 Thu, 14 Nov 2019 07:20:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 648C8691BE;
 Thu, 14 Nov 2019 07:20:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9221F17535; Thu, 14 Nov 2019 08:20:42 +0100 (CET)
Date: Thu, 14 Nov 2019 08:20:42 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sam Eiderman <sameid@google.com>
Subject: Re: [SeaBIOS] Re: [PATCH] ahci: zero-initialize port struct
Message-ID: <20191114072042.wuo572evuw4hyh3l@sirius.home.kraxel.org>
References: <20191113091809.31365-1-kraxel@redhat.com>
 <84d3a1aa-bbb2-d831-0abc-fe1169f8a860@redhat.com>
 <20191113140057.2ocwfa3rqqfkbg3r@sirius.home.kraxel.org>
 <CAFr6bUn5W2-w3z4Ty9XD7mh+=kxVq2rQJ3ZUz5nXA13ZdxQtsg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFr6bUn5W2-w3z4Ty9XD7mh+=kxVq2rQJ3ZUz5nXA13ZdxQtsg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: kiLC0Ok2P1SOZR9MjfpRMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, seabios@seabios.org,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 13, 2019 at 05:03:58PM +0200, Sam Eiderman wrote:
> Hi,
>=20
> Does this fix a bug that actually happened?

Yes, "make check-qtest" may fail.  It's kind of random though.

> I just noticed that in my lchs patches I assumed that lchs struct is
> zeroed out in all devices (not only ahci):

ahci was the only one not zeroing out the struct (yes, I've reviewed
them all).

> Also Gerd it seems that my lchs patches were not committed in the
> latest submitted version (v4)!!!

Whoops.  Can you sent a patch seabios/master ... v4 please?

IIRC there didn't change much, mostly the parser function, so that
should be alot less churn than a full revert + v4 reapply.

thanks,
  Gerd


