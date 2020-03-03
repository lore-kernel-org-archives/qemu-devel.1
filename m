Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C48C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFF720838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkZtExGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFF720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j95Fq-00061A-JN
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1j95Ev-0004YZ-4K
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1j95Es-0007ee-PM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:57:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54002
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1j95Es-0007d9-LV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583233046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGU+zEJ/Y1w990smmVftsMJ33GKV+sdk4pp95QGT9Pw=;
 b=VkZtExGlMAxcsufJAQD8SMHhkdNCLyO1FUcqghIq9gFAiNAtiIUN8mugbIFjHbu3G5gEd8
 iBjP7CciwxKDHMjYSgz71QBxUWa4sVjy+umNEk8dr2JXSno+1rz1hZHAUTohEX5mxcHQNM
 cD6xEnLJQ/uVKEq9vQlSy8d5jOJoINY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-rDn9YB-yOem3sWzQVmMAvA-1; Tue, 03 Mar 2020 05:57:24 -0500
X-MC-Unique: rDn9YB-yOem3sWzQVmMAvA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F9521005510;
 Tue,  3 Mar 2020 10:57:23 +0000 (UTC)
Received: from kaapi (ovpn-116-177.sin2.redhat.com [10.67.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37ADC8C09A;
 Tue,  3 Mar 2020 10:57:19 +0000 (UTC)
Date: Tue, 3 Mar 2020 16:27:05 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] net: tulip: check frame size and r/w data length
In-Reply-To: <e63fe1bb-e77f-1813-6cc7-9763c82c1046@redhat.com>
Message-ID: <nycvar.YSQ.7.76.2003031620020.5086@xnncv>
References: <20200217113804.341836-1-ppandit@redhat.com>
 <e63fe1bb-e77f-1813-6cc7-9763c82c1046@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Mon, 24 Feb 2020, Jason Wang wrote --+
| > +        if (s->rx_frame_len + len >=3D sizeof(s->rx_frame)) {
| > +            return;
| > +        }
| What's the goal of this checking?

  To avoid potential OOB access while in pci_dma_write().

| >           pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
| >               (s->rx_frame_size - s->rx_frame_len), len);
|
| > +    if (size < 14 || size > sizeof(s->rx_frame) - 4
| > +        || s->rx_frame_len || tulip_rx_stopped(s)) {
| >           return 0;
| It's better to move those checks in .can_receive().

  I tried to move these checks to .can_recieve, but tulip_receive()
is called from tulip_receive_nc() and tulip_tx() and the 'size' check could
not be moved to can_receive().

| > +        } else if (s->tx_frame_len < sizeof(s->tx_frame)) {
| Should we use <=3D here?

  Done.
=20
| > +    if (s->tx_frame_len + len1 >=3D sizeof(s->tx_frame)) {
| > +        return;
| > +    }
| I think it's better to add a return value here to make sure caller
| tulip_xmit_list_update() can exit the loop early

  Done.
=20
| One more thing.
| It looks to me there could be a user trigger-able infinite loop in
| tun_list_update() through always set TDES0_OWN in its descriptors?

  Yes, defined TULIP_DESC_MAX=3D128 to restrict loop iterations to 128=20
descriptors to avoid potential infinite loop.
  -> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/net/ethernet/dec/tulip/tulip.h#n319

Sent patch v3 with above changes; Sorry about the delay.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


