Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDBCC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B08206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBHEaW05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B08206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgqED-0001Df-OQ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jgqDX-0000Gy-66
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:47:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55404
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jgqDW-00087Q-7r
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591278452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xELz4FTUptSgDa2akUNMYdCBT5cnitKGu8hW+k/NUiU=;
 b=OBHEaW05ayjRlozz7Y48r62PLMZ0+WgfvoHtftvfjZBRPjLDMtJB5tEnvjVeHTduV9eH8Y
 e1fpk1y1GO/6PSZolI+qOzAr3upFFdQznVBUKgY0m1f3VvWwYwe9KR2g701/JlW5P2wHmo
 w/j/15vioIf5agMwOFIY6qtiSWfdXhw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-4f78I-x4OPaMP_7VFT7j4A-1; Thu, 04 Jun 2020 09:47:30 -0400
X-MC-Unique: 4f78I-x4OPaMP_7VFT7j4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 576121005512;
 Thu,  4 Jun 2020 13:47:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0437E10013C3;
 Thu,  4 Jun 2020 13:47:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0071916E16; Thu,  4 Jun 2020 15:47:27 +0200 (CEST)
Date: Thu, 4 Jun 2020 15:47:27 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v3] ati-vga: check mm_index before recursive call
 (CVE-2020-13800)
Message-ID: <20200604134727.h7z6lfqvlawofpfi@sirius.home.kraxel.org>
References: <20200604090830.33885-1-ppandit@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200604090830.33885-1-ppandit@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:14:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Ren Ding <rding@gatech.edu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> +        } else if (s->regs.mm_index > MM_DATA + 3) {
>              val = ati_mm_read(s, s->regs.mm_index + addr - MM_DATA, size);

MM_INDEX is 0
MM_DATA  is 4
"normal" registers start at 8.

So we want allow indirect access for offset 8 and above and deny offsets
0-7.  mm_index is interpreted with an offset, see "- MM_DATA" in the
call above.

Not clear to me why this offset is 4, that doesn't make sense to me.
I'd expect either no offset or offset being 8.  BALATON, can you
double-check that with the specs?

Assuming offset 4 is correct we must require mm_index being larger than
MM_DATA + MM_DATA + 3 ( == 11) to compensate for the offset.

take care,
  Gerd


