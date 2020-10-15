Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111C9C43467
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E9D21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tayxt2MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E9D21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT1xn-0001ga-6f
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 08:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT1wl-00019B-T7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT1wg-0004aP-Cu
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602763281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRrD5EBy87hrHyMArOhZ8Cg2Fqja5X0bd8Cyd/fumM8=;
 b=Tayxt2MFZLTHGcDo+DR5H3HmbZckg3veOOZaUJoCPhVuDKl1mSDosQH1EKvxDFTCHTzIDF
 dYpoOpGDL1FY84+Fa5sTRZ9ocCbh4biL5IWeL0w4dcdngYF9lPx7Yfou6ASlmx+qdxofD3
 BgaC2Lp1obi8ROZALEX2BBUudMdY6WE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-5dO-novxOpm_KGzHFDA_Rg-1; Thu, 15 Oct 2020 08:01:07 -0400
X-MC-Unique: 5dO-novxOpm_KGzHFDA_Rg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78129106B349;
 Thu, 15 Oct 2020 12:01:04 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 692201992F;
 Thu, 15 Oct 2020 12:01:03 +0000 (UTC)
Date: Thu, 15 Oct 2020 14:01:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 00/20] block/export: Allow exporting BDSs via FUSE
Message-ID: <20201015120101.GG4610@merkur.fritz.box>
References: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922104932.46384-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:
> Based-on: <20200907182011.521007-1-kwolf@redhat.com>
>           (“block/export: Add infrastructure and QAPI for block exports”)
> 
> (Though its patch 16 needs a s/= \&blk_exp_nbd/= drv/ on top.)
> 
> v1: https://lists.nongnu.org/archive/html/qemu-block/2019-12/msg00451.html
> 
> Branch: https://github.com/XanClic/qemu.git fuse-exports-v2
> Branch: https://git.xanclic.moe/XanClic/qemu.git fuse-exports-v2
> 
> 
> Hi,
> 
> Ever since I found out that you can mount FUSE filesystems on regular
> files (not just directories), I had the idea of adding FUSE block
> exports to qemu where you can export block nodes as raw images.  The
> best thing is that you’d be able to mount an image on itself, so
> whatever format it may be in, qemu lets it appear as a raw image (and
> you can then use regular tools like dd on it).
> 
> The performance is quite bad so far, but we can always try to improve it
> if the need arises.  For now I consider it mostly a cute feature to get
> easy access to the raw contents of image files in any format (without
> requiring root rights).
> 
> In this version (as opposed to v1 linked above), I integrated the FUSE
> export code into Kevin’s proposed common infrastructure for block
> exports.

Patches 5-16, 19 and 20:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


