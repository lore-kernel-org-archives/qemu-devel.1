Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F2AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 05:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DA82072E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 05:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTGL88zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DA82072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgiUL-0006bh-NO
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 01:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgiTP-0005iz-Bf
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 01:31:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55486
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgiTN-0002ub-Sb
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 01:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591248683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xFAeiLNfXGQdrXmbB16hrRglUKkluIpJ9g77MK+GvAU=;
 b=FTGL88zytU8XMHLhLCo0gg/9HW70kC39Kjn/qW4VJKb3YVH4AxJuGF9s3j7CNEhHc+TxPF
 r/TWBrzYO8lbzQuakkq94JAFHyL1kSALmFUUy7rVbjV7DLhSxnMMaXyGtaLv/LFrgiDT+/
 yyptVLpc0PkQ4FSJSRAtHRGgVB0OVuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-FvoG8yAWOOSD2zu188WOEg-1; Thu, 04 Jun 2020 01:31:22 -0400
X-MC-Unique: FvoG8yAWOOSD2zu188WOEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 020F1100A614;
 Thu,  4 Jun 2020 05:31:21 +0000 (UTC)
Received: from kaapi (ovpn-116-200.sin2.redhat.com [10.67.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C459589289;
 Thu,  4 Jun 2020 05:31:11 +0000 (UTC)
Date: Thu, 4 Jun 2020 11:01:09 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] pci: ensure configuration access is within bounds
In-Reply-To: <alpine.BSF.2.22.395.2006040006520.56892@zero.eik.bme.hu>
Message-ID: <nycvar.YSQ.7.77.849.2006041039380.62159@xnncv>
References: <20200603202251.1199170-1-ppandit@redhat.com>
 <20200603202251.1199170-3-ppandit@redhat.com>
 <alpine.BSF.2.22.395.2006040006520.56892@zero.eik.bme.hu>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
 Yi Ren <c4tren@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Ren Ding <rding@gatech.edu>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Thu, 4 Jun 2020, BALATON Zoltan wrote --+
| On Thu, 4 Jun 2020, P J P wrote:
| > +    assert(address + len <= pci_config_size(d));
| 
| Does this allow guest now to crash QEMU?

Yes, possible. Such crash (assert failure) can be a regular bug, as reading 
PCI configuration is likely a privileged operation inside guest.

| If this is considered to be an error now to call this function with wrong 
| parameters did you check other callers?

No, I haven't checked all other cases.

| Would it be better to not crash just log invalid access and either fix up 
| parameters or return some garbage like 0?

* Earlier patch v1 did the same, returned 0.

* Assert(3) may help to fix current and future incorrect usage of the call.

@mst ...?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


