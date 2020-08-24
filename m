Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73F7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2BE2074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B62FqhST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2BE2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kACJN-0007UP-JI
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 09:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kACIo-0006vT-SJ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kACIm-0000W9-9S
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598274858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1rVJFM+XkTm1ZxHzu0Il4PwyRAQq0xUUylyhH5MUi0Y=;
 b=B62FqhSTeg4UKcYGOuxGFzflkFBb/GgCuKE2h0/WAIllP8lVbPEqGx528rMdlmNoTEIXpL
 T6kIT9p4bLfrOPFLvNm5Ey17cDv6kTnoxNsZw3QUFjfUVkzIjPUbuP0EHTtvyCcBadsfns
 il6YN/SXmSczZX03AJA6t+cB63BJe6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-8qDgJ35RNDKQxK4Hx-KgZQ-1; Mon, 24 Aug 2020 09:14:16 -0400
X-MC-Unique: 8qDgJ35RNDKQxK4Hx-KgZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23946640C0;
 Mon, 24 Aug 2020 13:14:15 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB08B7E69E;
 Mon, 24 Aug 2020 13:14:13 +0000 (UTC)
Date: Mon, 24 Aug 2020 15:14:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v7 41/47] block: Leave BDS.backing_file constant
Message-ID: <20200824131412.GA10708@linux.fritz.box>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-42-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625152215.941773-42-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 04:38:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
> Parts of the block layer treat BDS.backing_file as if it were whatever
> the image header says (i.e., if it is a relative path, it is relative to
> the overlay), other parts treat it like a cache for
> bs->backing->bs->filename (relative paths are relative to the CWD).
> Considering bs->backing->bs->filename exists, let us make it mean the
> former.
> 
> Among other things, this now allows the user to specify a base when
> using qemu-img to commit an image file in a directory that is not the
> CWD (assuming, everything uses relative filenames).
> 
> Before this patch:
> 
> $ ./qemu-img create -f qcow2 foo/bot.qcow2 1M
> $ ./qemu-img create -f qcow2 -b bot.qcow2 foo/mid.qcow2
> $ ./qemu-img create -f qcow2 -b mid.qcow2 foo/top.qcow2
> $ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
> qemu-img: Did not find 'mid.qcow2' in the backing chain of 'foo/top.qcow2'
> $ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
> qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'
> $ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
> qemu-img: Did not find '[...]/foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'
> 
> After this patch:
> 
> $ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
> Image committed.
> $ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
> qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'
> $ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
> Image committed.
> 
> With this change, bdrv_find_backing_image() must look at whether the
> user has overridden a BDS's backing file.  If so, it can no longer use
> bs->backing_file, but must instead compare the given filename against
> the backing node's filename directly.
> 
> Note that this changes the QAPI output for a node's backing_file.  We
> had very inconsistent output there (sometimes what the image header
> said, sometimes the actual filename of the backing image).  This
> inconsistent output was effectively useless, so we have to decide one
> way or the other.  Considering that bs->backing_file usually at runtime
> contained the path to the image relative to qemu's CWD (or absolute),
> this patch changes QAPI's backing_file to always report the
> bs->backing->bs->filename from now on.  If you want to receive the image
> header information, you have to refer to full-backing-filename.
> 
> This necessitates a change to iotest 228.  The interesting information
> it really wanted is the image header, and it can get that now, but it
> has to use full-backing-filename instead of backing_file.  Because of
> this patch's changes to bs->backing_file's behavior, we also need some
> reference output changes.
> 
> Along with the changes to bs->backing_file, stop updating
> BDS.backing_format in bdrv_backing_attach() as well.  In order not to
> change our externally visible behavior (incompatibly), we have to let
> bdrv_query_image_info() try to get the image format from bs->backing if
> bs->backing_format is unset.  (The QAPI schema describes
> backing-filename-format as "the format of the backing file", so it is
> not necessarily what the image header says, but just the format of the
> file referenced by backing-filename (if known).)

Why is it okay to change backing-filename incompatibly, but not
backing-filename-format? I would find it much more consistent if
ImageInfo reported the value from the header in both fields, and
BlockDeviceInfo reported the values actually in use.

The QAPI schema described ImageInfo as "Information about a QEMU image
file" and runtime state really isn't information about an image file.

If you want to know the probed image format, you can still look at
backing-image.format. I don't think this change is much different from
what you described above for BlockDeviceInfo.backing_file.

> iotest 245 changes in behavior: With the backing node no longer
> overriding the parent node's backing_file string, you can now omit the
> @backing option when reopening a node with neither a default nor a
> current backing file even if it used to have a backing node at some
> point.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Kevin


