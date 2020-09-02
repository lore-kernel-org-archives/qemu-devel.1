Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B607CC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC0B20773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYQjQh0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC0B20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQBw-00087x-OS
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kDQB2-00078W-Uh
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:39:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29397
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kDQAz-0005nX-UT
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599043177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IhxraRn9hGsqdB5F+wJ41T4Ll7/4VHA+N6K4TDZOAko=;
 b=UYQjQh0hx3gxtcHUBK66Yu/yhUxFeA9ldVUujS2i51hewkChFAsFYSvmXdcOcQfLbnU0iu
 3WpkkEuyhAY+N7YD/hABDGZ93IK6eCCoRlubRz9ASHRuXCjGJS8llEH44v4Fy/MVoy+ytR
 nK+bf/9ZcNfki0ded1NxO+2vAyqjJug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-2gYuWEqQNSeCZCWSkjUXlg-1; Wed, 02 Sep 2020 06:39:33 -0400
X-MC-Unique: 2gYuWEqQNSeCZCWSkjUXlg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FB2E801AB1;
 Wed,  2 Sep 2020 10:39:31 +0000 (UTC)
Received: from kaapi (ovpn-112-116.phx2.redhat.com [10.3.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9184805C0;
 Wed,  2 Sep 2020 10:39:26 +0000 (UTC)
Date: Wed, 2 Sep 2020 16:09:23 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 3/3] hw/sd/sdhci: Fix DMA Transfer Block Size field
In-Reply-To: <20200901140411.112150-4-f4bug@amsat.org>
Message-ID: <nycvar.YSQ.7.78.906.2009021519400.2047119@xnncv>
References: <20200901140411.112150-1-f4bug@amsat.org>
 <20200901140411.112150-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-ID: <nycvar.YSQ.7.78.906.2009021521030.2047119@xnncv>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 BOUNDARY="-1463810047-535973660-1599040256=:2047119"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-block@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 1892960@bugs.launchpad.net, bugs-syssec@rub.de,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-535973660-1599040256=:2047119
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <nycvar.YSQ.7.78.906.2009021521031.2047119@xnncv>

+-- On Tue, 1 Sep 2020, Philippe Mathieu-Daudé wrote --+
| The 'Transfer Block Size' field is 12-bit wide.
| See section '2.2.2. Block Size Register (Offset 004h)' in datasheet.
| 
| Buglink: https://bugs.launchpad.net/qemu/+bug/1892960

+ https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Fsdhci_oob_write1

| diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
| index 60f083b84c1..ecbf84e9d3f 100644
| --- a/hw/sd/sdhci.c
| +++ b/hw/sd/sdhci.c
| @@ -1104,7 +1104,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
|          break;
|      case SDHC_BLKSIZE:
|          if (!TRANSFERRING_DATA(s->prnsts)) {
| -            MASKED_WRITE(s->blksize, mask, value);
| +            MASKED_WRITE(s->blksize, mask, extract32(value, 0, 12));
|              MASKED_WRITE(s->blkcnt, mask >> 16, value >> 16);

It helps to fix above issues.

Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-535973660-1599040256=:2047119--


