Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463C3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B45207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKTID9Zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B45207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jayMa-0005wI-7m
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 05:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jayLr-0005Iw-TY
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:15:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31315
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jayLq-00033S-FV
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589879753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZqdLpLz+y4m53DrgqUU/4tBg3Uy8s+Rjs7H2JFxIvuw=;
 b=BKTID9ZqbeAll6Ja0psPfpbYy8hUSkTc+U96FPbt57t5nK01fD8WqCGbvnbQzI0HeTGswL
 76zICeMPlejqMPmjgMwo5sNwl0+X3CVrZjdUWn66/mXUskhos+CksNs5T/RvWsr9wKSKwP
 hu+C/TSPpzZw1OGB4xOsKsDZEpJ61mE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-MYvF2OjAO_itDW-dblgPng-1; Tue, 19 May 2020 05:15:49 -0400
X-MC-Unique: MYvF2OjAO_itDW-dblgPng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27DEA107ACCD;
 Tue, 19 May 2020 09:15:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-199.ams2.redhat.com [10.36.113.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59AF282A1C;
 Tue, 19 May 2020 09:15:46 +0000 (UTC)
Date: Tue, 19 May 2020 11:15:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: Migration with ``drive-mirror`` + NBD will let quorum qcow2
 image become larger
Message-ID: <20200519091544.GD7652@linux.fritz.box>
References: <3b1bbe79-088c-2e65-178f-074ac0f72ec6@intel.com>
MIME-Version: 1.0
In-Reply-To: <3b1bbe79-088c-2e65-178f-074ac0f72ec6@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
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
Cc: John Snow <jsnow@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.05.2020 um 10:32 hat Tao Xu geschrieben:
> Hi,
> 
> I am using ``drive-mirror`` + NBD for live storage migration. But I find
> that if I use a qcow2 image(virtual size: 10 GiB, disk size: 1.8 GiB) as a
> child of quorum, then the destination image become larger(virtual size: 10
> GiB, disk size: 10 GiB). However if I use a qcow2 image directly, then the
> destination image(virtual size: 10 GiB, disk size: 1.8 GiB) will be equal to
> the source.
> 
> So I am wondering if my usage is wrong or it is expected with
> quorum+drive-mirror?

This seems to be because the quorum block driver doesn't implement the
.bdrv_co_block_status interface, so the mirror block job can't know that
some blocks are unallocated/zeroed, but will copy everything.

I'm not sure if quorum can even implement this interface because the
allocation status in different quorum children may differ and voting
might not make sense. But maybe it could return a limited set of flags
at least so that the mirror job can get the BDRV_BLOCK_ZERO information
if the quorum children agree on it.

tl;dr: With quorum + drive-mirror it is currently expected.

Kevin


