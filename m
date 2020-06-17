Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F67C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F54B2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+TK2yyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F54B2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlaTE-0003Vp-PU
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jlaRO-0001Jl-Tw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 11:57:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44400
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jlaRM-0006UB-0G
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 11:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592409446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ww46BwoLqqCnBMVMQNt8X6Zy5nlYLDyqpBdYPnLrbVs=;
 b=K+TK2yyYq//ZmbvV+sMiiY8W32QbwHFiE2FoUzGILw1Yx6Ah7F5KPB0qS+2u8BWSv1MVl7
 cybVekMqOgUEtNSAXic+XpjuVS3oVruv/qcNApdECs3ja+IZiSPe3hZD9b8BZzysDerWXv
 wiDA8P4mRuqySpzUIHbl1KLzVHKHEus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-eBZSwUgdMzSWuo3vCJaJDA-1; Wed, 17 Jun 2020 11:57:24 -0400
X-MC-Unique: eBZSwUgdMzSWuo3vCJaJDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 601D9873403;
 Wed, 17 Jun 2020 15:57:23 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-115-92.ams2.redhat.com
 [10.36.115.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8796F10013D5;
 Wed, 17 Jun 2020 15:57:18 +0000 (UTC)
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
To: Guilherme Piccoli <gpiccoli@canonical.com>
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
 <CAHD1Q_zGu4Q63HjHx3aZKu3wh8NppuP6T4kgnUN3j=-ZDufVZA@mail.gmail.com>
 <b423f4a4-2552-bdc8-7c9f-41f200aef672@redhat.com>
 <CAHD1Q_zmTatErCefeh349sSYsQJUVT3KB+VMDheEgBn5r7QGjA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <084e2640-d71e-d4ec-efdd-3f7947a6b511@redhat.com>
Date: Wed, 17 Jun 2020 17:57:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHD1Q_zmTatErCefeh349sSYsQJUVT3KB+VMDheEgBn5r7QGjA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
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
Cc: Pedro Principeza <pedro.principeza@canonical.com>, ehabkost@redhat.com,
 Dann Frazier <dann.frazier@canonical.com>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/17/20 15:43, Guilherme Piccoli wrote:

> So, the only problem with that refactor you're proposing is the
> retrocompatibility with qemu versions, as I can anticipate cases in
> which newer OVMF runs with older qemu, which does not provide such
> trustworth physbits info.

I don't necessarily see compat issues -- large-BAR PCI device assignment
might simply stop working under those circumstances, because you could
no longer use X-PciMmio64Mb, and the new way wouldn't be supported by
(old) QEMU.

This would indeed be a regression relative to "X-PciMmio64Mb", but
that's exactly why there's an "X" in "X-PciMmio64Mb".

> So, the code may be a bit complex, it'll
> need to take into account this case (probably we could just rely on
> the physbits "detected" by OVMF in such case, limiting PCI64 aperture
> to the current 36-bits, right?).

A "bit complex" is an understatement. The code is already much more
complex than it should be. (And I do think that's an inherent, not
accidental, complexity; it reflects the situation.) Once we have a new
design, we should do the bare minimum to keep such previous usage
functional that's *not* reliant on X-PciMmio64Mb.

Laszlo


