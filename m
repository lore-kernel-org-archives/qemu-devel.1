Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06A3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808F0204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCR7n+fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808F0204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxtB-00021g-Jy
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jaxsO-0001Md-Bf
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:45:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jaxsM-0003LV-Cx
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589877925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=saB14H7j5F0jGoQTdgQMwRAPHYpZJH5ZxTL3pMArJYQ=;
 b=MCR7n+fz4gbCrhOoQCdCYJ5BwjRh852PiSO+jyf5K0MYCMXenC0PLL5pwQxHGSxC2QsB7Y
 4pg4mbvdrf/tslmA8dZxHq+XbxUC16Ssm9HgGk45x8vGsPkCSOungxH2B+3FsU2gnoE9eA
 vDSN/zElL9QtlPorgKWmwLRsu8jlC+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-lNq2d9vbPvOeVOj7Br5Ejg-1; Tue, 19 May 2020 04:45:21 -0400
X-MC-Unique: lNq2d9vbPvOeVOj7Br5Ejg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74BD11B18BC6;
 Tue, 19 May 2020 08:45:20 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-199.ams2.redhat.com [10.36.113.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63FDF82A3A;
 Tue, 19 May 2020 08:45:19 +0000 (UTC)
Date: Tue, 19 May 2020 10:45:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] hw/ide: Make IDEDMAOps handlers take a const IDEDMA
 pointer
Message-ID: <20200519084518.GB7652@linux.fritz.box>
References: <20200512194917.15807-1-philmd@redhat.com>
 <01f5f413-d1d0-43cb-65cc-9f7bd1e59893@redhat.com>
 <20200515084817.GA93011@linux.fritz.box>
 <928e787e-6242-b39e-0aff-8c06f33c9e8d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <928e787e-6242-b39e-0aff-8c06f33c9e8d@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.05.2020 um 20:26 hat John Snow geschrieben:
> 
> 
> On 5/15/20 4:48 AM, Kevin Wolf wrote:
> > Am 14.05.2020 um 22:21 hat John Snow geschrieben:
> >>
> >>
> >> On 5/12/20 3:49 PM, Philippe Mathieu-Daudé wrote:
> >>> Handlers don't need to modify the IDEDMA structure.
> >>> Make it const.
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> >>
> >> I'll trust your judgment. As long as it still compiles and passes
> >> qtests, I'm happy if you're happy.
> >>
> >> Acked-by: John Snow <jsnow@redhat.com>
> > 
> > Does this mean you assume someone else will merge it? If that
> > someone is me, please let me know.
> > 
> > Kevin
> > 
> 
> I think I had thought this was part of a larger set, and didn't
> realize it wasn't.
> 
> Yes, if you could please stage this for inclusion, that would be
> helpful.

No problem, applied to the block branch.

Kevin


