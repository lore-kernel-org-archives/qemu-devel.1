Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122EEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDABC20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpJBDoe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDABC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19Sy-0003YQ-3s
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1k19Rq-00024s-GS
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:22:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58236
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1k19Rp-0005xJ-1O
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596118935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pyYlmII1mTRH4uHQuv25eu9MzRPnRzMgsh4S0kIY7G4=;
 b=ZpJBDoe0OVXPi6Pf4zEveEaKy7ecCv8lDOQ3faRQEkZjCnzvdSzGYaLMO3dqc/GAHUtA1m
 syb5M2v/HuDKhHn2gIs/3GvQhC+f4Tbt3g27qmLjBtB4acTXN4JQjvM3TFVLfwYJniP8SY
 jPJB4Q+YI72sJzumLVr8iV3H5CmC2PY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-1Xdx2EQuOiu4SOG_r3c8bg-1; Thu, 30 Jul 2020 10:22:08 -0400
X-MC-Unique: 1Xdx2EQuOiu4SOG_r3c8bg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFA1780352A;
 Thu, 30 Jul 2020 14:22:05 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B37BB1C6;
 Thu, 30 Jul 2020 14:22:03 +0000 (UTC)
Date: Thu, 30 Jul 2020 16:22:00 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 1/2] qcow2: Release read-only bitmaps when inactivated
Message-ID: <20200730142200.GC2101@angien.pipo.sk>
References: <20200730120234.49288-1-mreitz@redhat.com>
 <20200730120234.49288-2-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200730120234.49288-2-mreitz@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 14:02:33 +0200, Max Reitz wrote:
> During migration, we release all bitmaps after storing them on disk, as
> long as they are (1) stored on disk, (2) not read-only, and (3)
> consistent.
> 
> (2) seems arbitrary, though.  The reason we do not release them is
> because we do not write them, as there is no need to; and then we just
> forget about all bitmaps that we have not written to the file.  However,
> read-only persistent bitmaps are still in the file and in sync with
> their in-memory representation, so we may as well release them just like
> any R/W bitmap that we have updated.
> 
> It leads to actual problems, too: After migration, letting the source
> continue may result in an error if there were any bitmaps on read-only
> nodes (such as backing images), because those have not been released by
> bdrv_inactive_all(), but bdrv_invalidate_cache_all() attempts to reload
> them (which fails, because they are still present in memory).
> 

I've tested it with same commands as I've used before and now the 'cont'
succeeds and also the bitmaps after the cont call are loaded and active
at least according to 'query-named-block-nodes'

Tested-by: Peter Krempa <pkrempa@redhat.com>


