Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026BDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32072065C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdCMIzt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32072065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZXix-0000LM-VQ
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 06:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZXiM-0008Ac-NH
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:37:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40322
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZXiL-0001eg-EA
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589539031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FX1GHP5D9r4xtf5csN6fsIjyjqgYwGI0JxfSvlIOxps=;
 b=FdCMIzt8rFkOYcydg3mFwKIHHdnAsVoDFpRbcXM1mm7NYHCfeS7UEiF6emNgDt925Y1A3k
 zqTD5YrSRW0cm6xl0XNWmbo/GAaXsky4r7twgJSTasADgndvcG/CRIajdkM1kHAlXU+XZJ
 brxhCHeN4oaeXmgHtzOF3RwZqgwnpmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-l6PdUEoCNASZdMq1b8zUiA-1; Fri, 15 May 2020 06:36:44 -0400
X-MC-Unique: l6PdUEoCNASZdMq1b8zUiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBF6A464;
 Fri, 15 May 2020 10:36:43 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-110.ams2.redhat.com [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12522341E3;
 Fri, 15 May 2020 10:36:42 +0000 (UTC)
Date: Fri, 15 May 2020 12:36:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
Message-ID: <20200515103641.GG93011@linux.fritz.box>
References: <20200429141126.85159-1-mreitz@redhat.com>
 <20200514130800.GF5518@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200514130800.GF5518@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.05.2020 um 15:08 hat Kevin Wolf geschrieben:
> Am 29.04.2020 um 16:11 hat Max Reitz geschrieben:
> > v1: https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg01245.html
> > 
> > Branch: https://github.com/XanClic/qemu.git fix-bdrv_make_empty-v2
> > Branch: https://git.xanclic.moe/XanClic/qemu.git fix-bdrv_make_empty-v2
> > 
> > Based-on: <20200428192648.749066-1-eblake@redhat.com>
> >           (“qcow2: Allow resize of images with internal snapshots”)
> > 
> > Hi,
> > 
> > As described in v1’s cover letter (linked above), this series ensures
> > that all calls to BlockDriver.bdrv_make_empty() go through a wrapper
> > bdrv_make_empty() function that ensures the caller does have the
> > necessary permissions.
> 
> Thanks, fixed up the test output in patch 4 and applied to the block
> branch.

Hmm, replication is doing criminal things and this results in:

test-replication: block.c:6899: bdrv_make_empty: Assertion `c->perm & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED)' failed.

Not your bug, but it breaks 'make check', so it needs to be fixed before
I can send a pull request. I'll see what I can do...

Kevin


