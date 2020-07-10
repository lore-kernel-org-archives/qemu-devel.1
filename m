Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281CEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D95207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoP80r/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D95207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtonE-0007w7-9Q
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jtomZ-0007R8-VQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:53:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44287
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jtomY-000840-Di
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594371201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dLxikNgm9ACkGQ9wQp1UwLj1fNXJJ8dRD22amB13vrw=;
 b=GoP80r/z8BibcikBATOh55CfvctqKyvLN8W3z/4n6C67X+AWAXJTMFLuLzB00m282T6hOM
 2YURD1v6ocwrImagbPTJc15OUsK3IosEJQIvV3cS/feda2jYt8IGi+Dbdrkwz0WJ3MApyu
 kCjf3r+ZX6ZXvdr1Jt+XJHnaUou3OD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-UXQ3d8X-N2a1JggT3fnTPw-1; Fri, 10 Jul 2020 04:53:19 -0400
X-MC-Unique: UXQ3d8X-N2a1JggT3fnTPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C672C1B18BC2;
 Fri, 10 Jul 2020 08:53:18 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-57.ams2.redhat.com [10.36.114.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3BBD6FECF;
 Fri, 10 Jul 2020 08:53:17 +0000 (UTC)
Date: Fri, 10 Jul 2020 10:53:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] block: Avoid stale pointer dereference in
 blk_get_aio_context()
Message-ID: <20200710085316.GB6641@linux.fritz.box>
References: <159430264541.389456.11925072456012783045.stgit@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <159430264541.389456.11925072456012783045.stgit@bahia.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.07.2020 um 15:50 hat Greg Kurz geschrieben:
> It is possible for blk_remove_bs() to race with blk_drain_all(), causing
> the latter to dereference a stale blk->root pointer:
> 
> 
>   blk_remove_bs(blk)
>    bdrv_root_unref_child(blk->root)
>     child_bs = blk->root->bs
>     bdrv_detach_child(blk->root)
>      ...
>      g_free(blk->root) <============== blk->root becomes stale
>     bdrv_unref(child_bs) <============ yield at some point
> 
> A blk_drain_all() can be triggered by some guest action in the
> meantime, eg. on POWER, SLOF might disable bus mastering on
> a virtio-scsi-pci device:
> 
>   virtio_write_config()
>    virtio_pci_stop_ioeventfd()
>     virtio_bus_stop_ioeventfd()
>      virtio_scsi_dataplane_stop()
>       blk_drain_all()
>        blk_get_aio_context()
>        bs = blk->root ? blk->root->bs : NULL
>             ^^^^^^^^^
>               stale
> 
> Then, depending on one's luck, QEMU either crashes with SEGV or
> hits the assertion in blk_get_aio_context().
> 
> blk->root is set by blk_insert_bs() which calls bdrv_root_attach_child()
> first. The blk_remove_bs() function should rollback the changes made
> by blk_insert_bs() in the opposite order (or it should be documented
> somewhere why this isn't the case). Clear blk->root before calling
> bdrv_root_unref_child() in blk_remove_bs().
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Thanks, applied to the block branch.

Kevin


