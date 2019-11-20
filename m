Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7FDC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71FE22477
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QRLWEskM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71FE22477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOrs-0002Xg-TM
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iXOl0-0003N7-4p
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iXOku-0002DG-Sw
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:06:49 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:59358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iXOku-0001mL-8s; Wed, 20 Nov 2019 07:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date;
 bh=flWOy6ZChyrVs55xNxIg8bD/jLXSHTlmtrRtlV17dxc=; 
 b=QRLWEskMgWNzl9OotikSFs2GXg+pjBt/nQhM2k4tPLeOxOoHc7o10iS6aupTnZgtWCMnSJetRNa8y4/SXo0cPUlYiUE0xz+8EtG4RasFyxsGUoUB5ek+hVTL2dzcchmdJONMsflu1QHzZ3P/q6o3KWNGXybIs70VcZ54akMF/Spamx0VE6WSEXq+bsBsao67nNKYBZhEk0B4W3I3Q0JBiZS1oUJUOn7OV+oE7S6N6QnwyWQ/XTTxTuJgZ2lYHm2Wbt8fMdb6K6Zz4ozDZcmSWzQerEK13PCuqBgIDG4feuEY8dKuMTTqGtLXvd3qCPyTGe4AERFZ9DnJRAWATFA5dw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iXOkc-0007I2-1I; Wed, 20 Nov 2019 13:06:26 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iXOkb-0007pY-V1; Wed, 20 Nov 2019 13:06:25 +0100
Date: Wed, 20 Nov 2019 13:06:25 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: qcow2 preallocation and backing files
Message-ID: <20191120120625.GA25497@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

as we discussed yesterday on IRC there's an inconsistency in the way
qcow2 preallocation works.

Let's create an image and fill it with data:

   $ qemu-img create -f raw base.img 1M
   $ qemu-io -f raw -c 'write -P 0xFF 0 1M' base.img

Now QEMU won't let us create a new image backed by base.img using
preallocation:

   $ qemu-img create -f qcow2 -b base.img -o preallocation=metadata active.img
   qemu-img: active.img: Backing file and preallocation cannot be used at the same time

The reason is that once a cluster is preallocated (i.e. it has a valid
L2 entry pointing to a host offset) the guest won't see the contents
of the backing file, so those options conflict with each other.

It is possible however to create an image that is smaller than
the backing file and then resize it using preallocation. In this
case qemu-img will happily accept any --preallocation option, with
different results from the guest's point of view:

   # This reads as 0xFF (the data comes from base.img)
   $ qemu-img create -f qcow2 -b base.img active.img 512K

   # The second half of the image also reads as 0xFF
   $ qemu-img resize --preallocation=off active.img 1M

   # Here the second half reads as zeroes
   $ qemu-img resize --preallocation=metadata active.img 1M

Apart from "qemu-img resize", the QMP block-resize command can also
extend an image like this, although it always uses PREALLOC_MODE_OFF
and the user cannot change that.

It does not seem right that the guest-visible data changes depending
on the preallocation mode. This could be solved by returning an error
when (backing_bs(blk_bs(blk)) && prealloc != PREALLOC_MODE_OFF) on
img_resize().

The important question is however: what behavior is the right one?
Should growing an image that was smaller than the backing file return
zeroes, or data from the backing file? I would opt for the latter, for
simplicity and consistency with the current behavior of block-resize,
although it was pointed out that this could be a security problem (I'm
not sure that I agree with that, but we can discuss it).

This also has a consequence on how preallocation should be implemented
for images with subclusters. Extended L2 entries allow us to allocate
a cluster but leave each one of its subclusters unallocated. That
would allow us to have a cluster that is simultaneously allocated but
whose data is read from the backing file. But it's up to us to decide
if that's what we should do when resizing an image.

Berto

