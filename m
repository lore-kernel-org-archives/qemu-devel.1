Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E726C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E0F20772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/HbtwZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E0F20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2hS-0006ud-Bk
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jH2eX-0002bi-KQ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jH2eW-0000UF-Ic
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:48:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59275)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jH2eW-0000Tw-Ek
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585129728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TxLNf2yYifu3dFESwhDhAFjemxg54heCW9dPm5VtnQ=;
 b=i/HbtwZNUVvDR0R6iz/uSC6k6LYAWzn92aulojg4RCOUIXRLIL5xm7KqVEC88VcOPvNbkt
 SSrURBbN4XK/NGzszzLPacRjYrEVXwWDm83lKhdkHU+2MdvEeYPetlO/yxkvis5bwT7aMz
 qNnCfObdielmsWuLppxzyDzcE+fkBLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-ajmDLulmMgWOvxsxNjirGQ-1; Wed, 25 Mar 2020 05:48:46 -0400
X-MC-Unique: ajmDLulmMgWOvxsxNjirGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8DB48017CC;
 Wed, 25 Mar 2020 09:48:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 661C360BE0;
 Wed, 25 Mar 2020 09:48:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 557B817535; Wed, 25 Mar 2020 10:48:43 +0100 (CET)
Date: Wed, 25 Mar 2020 10:48:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] hw/usb/xen-usb.c: Pass struct usbback_req* to
 usbback_packet_complete()
Message-ID: <20200325094843.ydpwwqrakfjhm3x5@sirius.home.kraxel.org>
References: <20200323164318.26567-1-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200323164318.26567-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 04:43:18PM +0000, Peter Maydell wrote:
> The function usbback_packet_complete() currently takes a USBPacket*,
> which must be a pointer to the packet field within a struct
> usbback_req; the function uses container_of() to get the struct
> usbback_req* given the USBPacket*.
>=20
> This is unnecessarily confusing (and in particular it confuses the
> Coverity Scan analysis, resulting in the false positive CID 1421919
> where it thinks that we write off the end of the structure). Since
> both callsites already have the pointer to the struct usbback_req,
> just pass that in directly.

Looks sane from usb point of view.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd


