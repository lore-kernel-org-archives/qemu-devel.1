Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8EAC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6FC320736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+qEf7R9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FC320736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRa4J-0007kB-PO
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 07:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRa3f-000753-D2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRa3b-0005CM-HM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:30:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52692
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jRa3b-0005CE-42
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587641413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxkJgCEfnvWzjFF6LVcxR3Ih9nwBOCrZtz3NbxqGPzY=;
 b=A+qEf7R9OukUl8Gk/6eHRC9S6Pt5Q1ieCcsnNc1bMhNEWnb/SqBn47QF8E521wRv5RaXgY
 HB2dVYKgXKZxxiLsg0j7MboA9nbaCvXBLAGQFQQi4YMvhujwa1NbTu9+pPCD04KFhjoVNF
 NNKeSgc4FTgYTQaTslQ0faKDGnsWTHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-m1z9iNjsNxiHqPPZ2_-Uyg-1; Thu, 23 Apr 2020 07:30:11 -0400
X-MC-Unique: m1z9iNjsNxiHqPPZ2_-Uyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A1CF108BD0A;
 Thu, 23 Apr 2020 11:30:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DE4460F8D;
 Thu, 23 Apr 2020 11:30:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 42E421753B; Thu, 23 Apr 2020 13:30:03 +0200 (CEST)
Date: Thu, 23 Apr 2020 13:30:03 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Subject: Re: [PATCH] virtio-vga: fix virtio-vga bar ordering
Message-ID: <20200423113003.ba3cze6kpq2umdo6@sirius.home.kraxel.org>
References: <20200421214853.14412-1-anthoine.bourgeois@gmail.com>
 <20200422104657.4fnzkp66l2c2m2cw@sirius.home.kraxel.org>
 <20200422220257.GA17009@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200422220257.GA17009@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> Just a question, why didn't we choose the virtio-vga order to avoid
> shuffling from the beginning? Vga came after and we keep the
> compatibility ?

Well, transitional virtio devices need bar 0 for legacy virtio
compatibility (io bar), so using bar 1 for msix makes sense in that
case.

virtio-vga is new enough that it supports modern only so it doesn't need
to worry about legacy virtio compatibility.  It does have to worry about
vga compatibility though.  Therefore it uses a bar layout different from
anyone else ...

cheers,
  Gerd


