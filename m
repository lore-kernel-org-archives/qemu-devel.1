Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB9FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDC7206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6un1xED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDC7206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg8vc-0004a9-BJ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jg8tI-0002x5-S0
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:31:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22598
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jg8tI-0002jh-7A
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591111907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awLLXdYXD2IkaMRoqORxIbUGgzvSlKtZ8FXWS2uStrE=;
 b=Y6un1xEDGgyKb/MVvGgNeCLeYf+T7wLVY+QcKGyD1pqxVnCJ/XjYZuh1YXqyFyVlOfgtmg
 FOW1L036A13+F76tvWWlVEzDlZI24dEMjGl/ZA7vmCcDvB1ZO+sixIrqyv2mKimCuJaWZr
 4VMBUGFTst3KzvATc+sXGAzGzdSKbjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-fCQzZmLFPBSvKWGI8wb3Lw-1; Tue, 02 Jun 2020 11:31:43 -0400
X-MC-Unique: fCQzZmLFPBSvKWGI8wb3Lw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F6011007270;
 Tue,  2 Jun 2020 15:31:42 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-75.ams2.redhat.com [10.36.113.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 792596062D;
 Tue,  2 Jun 2020 15:31:35 +0000 (UTC)
Date: Tue, 2 Jun 2020 17:31:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v6 00/20] nvme: small fixes, refactoring and cleanups
Message-ID: <20200602153134.GJ5940@linux.fritz.box>
References: <20200514044611.734782-1-its@irrelevant.dk>
MIME-Version: 1.0
In-Reply-To: <20200514044611.734782-1-its@irrelevant.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.05.2020 um 06:45 hat Klaus Jensen geschrieben:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Changes since v5
> ~~~~~~~~~~~~~~~~
> * Prefixed all patches with "hw/block/nvme" to avoid confusion with the
>   nvme block driver.
> 
> * Added patch two patches:
> 
>     hw/block/nvme: fix pin-based interrupt behavior
>     hw/block/nvme: allow use of any valid msix vector
> 
>   These were previously posted separately, but I'm including them in this
>   series since I didnt get any response on the separate series anyway.
> 
> * Fixed Maxim's email in the R-b on "hw/block/nvme: refactor
>   nvme_addr_read"

Thanks, applied to the block branch.

Kevin


