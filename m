Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84AAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9DB2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ptn5UpYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9DB2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0j3a-00065o-0u
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 06:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0j2y-0005az-22
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:10:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0j2w-0007wb-HM
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596017450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTwA86jxFWRLsqgY9r7L3tocABvLyNGv8Y2Ww8jHxc8=;
 b=Ptn5UpYLQthHkNgPgov4/bRIeMudnxmzHDhVFcZGMUgtUx0o2r4/0fHfB9oCYe0q0Ud68s
 5AxZsFb0w5Oj+c9Zpx0Kg8LwckQ/1sLK3GMlmWk33lmTf0sCp7CYlvmDyMPVD8XJz694RW
 stpYl8t2t3DQ57w8Ye8kqJPqcRL6HPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-hi9BhViKN1qPoLRrW-atTg-1; Wed, 29 Jul 2020 06:10:46 -0400
X-MC-Unique: hi9BhViKN1qPoLRrW-atTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62464800685;
 Wed, 29 Jul 2020 10:10:44 +0000 (UTC)
Received: from gondolin (ovpn-113-17.ams2.redhat.com [10.36.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E5E28A162;
 Wed, 29 Jul 2020 10:10:42 +0000 (UTC)
Date: Wed, 29 Jul 2020 12:10:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.2 0/6] Continue booting in case the first device
 is not bootable
Message-ID: <20200729121039.1a044564.cohuck@redhat.com>
In-Reply-To: <20200728183734.7838-1-thuth@redhat.com>
References: <20200728183734.7838-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.74; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 03:32:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 20:37:28 +0200
Thomas Huth <thuth@redhat.com> wrote:

> If the user did not specify a "bootindex" property, the s390-ccw bios
> tries to find a bootable device on its own. Unfortunately, it alwasy
> stops at the very first device that it can find, no matter whether it's
> bootable or not. That causes some weird behavior, for example while
> 
>  qemu-system-s390x -hda bootable.qcow2
> 
> boots perfectly fine, the bios refuses to work if you just specify
> a virtio-scsi controller in front of it:
> 
>  qemu-system-s390x -device virtio-scsi -hda bootable.qcow2
> 
> Since this is quite uncomfortable and confusing for the users, and
> all major firmwares on other architectures correctly boot in such
> cases, too, let's also try to teach the s390-ccw bios how to boot
> in such cases.

I think this makes sense: If you IPL an LPAR or a z/VM guest, you are
always required to explicitly specify a device to load from (at least
as far as I remember). For QEMU, we have decided to allow starting
without an explicitly specified boot device as well, so we have already
deviated from the other s390 procedures. Let's just make that case
behave the same as everywhere else.

> 
> For this, we have to get rid of the various panic()s and IPL_assert()
> statements at the "low-level" function and let the main code handle
> the decision instead whether a boot from a device should fail or not,
> so that the main code can continue searching in case it wants to.
> 
>  Thomas
> 
> Thomas Huth (6):
>   pc-bios/s390-ccw/Makefile: Compile with -std=gnu99, -fwrapv and
>     -fno-common
>   pc-bios/s390-ccw: Move ipl-related code from main() into a separate
>     function
>   pc-bios/s390-ccw: Move the inner logic of find_subch() to a separate
>     function
>   pc-bios/s390-ccw: Do not bail out early if not finding a SCSI disk
>   pc-bios/s390-ccw: Scan through all boot devices if none has been
>     specified
>   pc-bios/s390-ccw: Allow booting in case the first virtio-blk disk is
>     bad
> 
>  pc-bios/s390-ccw/Makefile        |   7 +-
>  pc-bios/s390-ccw/bootmap.c       |  34 ++++--
>  pc-bios/s390-ccw/main.c          | 172 +++++++++++++++++++------------
>  pc-bios/s390-ccw/s390-ccw.h      |   2 +-
>  pc-bios/s390-ccw/virtio-blkdev.c |   7 +-
>  pc-bios/s390-ccw/virtio-scsi.c   |  25 +++--
>  pc-bios/s390-ccw/virtio-scsi.h   |   2 +-
>  7 files changed, 157 insertions(+), 92 deletions(-)
> 


