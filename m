Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AD3C56201
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A90B206CB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJDa2tsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A90B206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNCU-00046e-LH
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kaNA6-0001q0-EF
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:05:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kaNA3-0004yA-5l
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604513129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFSz4ic3aay5Qek8uAg3YL657H/Fm78lPuiy8WbAisw=;
 b=dJDa2tsri7cd/dSIeOr6mWYjabdOCQSHCMROD1mntjsUzcTTUvStrwpd4Ef4l9MBBainzB
 8lI2ACLt6AKvI6M+rUl/JqcIauHOr2urtChFT6WFO38u3bbzPMsvJV6ZD8BnNBaIizPqY8
 8lU0+znx95bOKPhsSHQPrTSywpyuEqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-AH4p6X60PlK1THnU6uRrvw-1; Wed, 04 Nov 2020 13:05:25 -0500
X-MC-Unique: AH4p6X60PlK1THnU6uRrvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC45E1007464;
 Wed,  4 Nov 2020 18:05:23 +0000 (UTC)
Received: from starship (unknown [10.35.207.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3675E5B4B8;
 Wed,  4 Nov 2020 18:05:16 +0000 (UTC)
Message-ID: <054f240a70f83c6faf9fe48f6674158c5cb21235.camel@redhat.com>
Subject: Re: [PATCH 0/5] SCSI: fix transfer limits for SCSI passthrough
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 04 Nov 2020 20:05:15 +0200
In-Reply-To: <160451212210.17446.5025535715832636959@66eaa9a8a123>
References: <160451212210.17446.5025535715832636959@66eaa9a8a123>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, ronniesahlberg@gmail.com,
 qemu-block@nongnu.org, pl@kamp.de, tom.ty89@gmail.com, stefanha@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-11-04 at 09:48 -0800, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20201104173217.417538-1-mlevitsk@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20201104173217.417538-1-mlevitsk@redhat.com
> Subject: [PATCH 0/5] SCSI: fix transfer limits for SCSI passthrough
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>    b1266b6..3c8c36c  master     -> master
>  - [tag update]      patchew/20201104160021.2342108-1-ehabkost@redhat.com -> patchew/20201104160021.2342108-1-ehabkost@redhat.com
>  * [new tag]         patchew/20201104173217.417538-1-mlevitsk@redhat.com -> patchew/20201104173217.417538-1-mlevitsk@redhat.com
> Switched to a new branch 'test'
> bde6371 block/scsi: correctly emulate the VPD block limits page
> c4180d6 block: use blk_get_max_ioctl_transfer for SCSI passthrough
> 9ff7edc block: add max_ioctl_transfer to BlockLimits
> dd2f1f7 file-posix: add sg_get_max_segments that actually works with sg
> f9ad940 file-posix: split hdev_refresh_limits from raw_refresh_limits
> 
> === OUTPUT BEGIN ===
> 1/5 Checking commit f9ad9400e011 (file-posix: split hdev_refresh_limits from raw_refresh_limits)
> 2/5 Checking commit dd2f1f77a5d2 (file-posix: add sg_get_max_segments that actually works with sg)
> 3/5 Checking commit 9ff7edc31002 (block: add max_ioctl_transfer to BlockLimits)
> 4/5 Checking commit c4180d6accff (block: use blk_get_max_ioctl_transfer for SCSI passthrough)
> 5/5 Checking commit bde637139536 (block/scsi: correctly emulate the VPD block limits page)
> ERROR: braces {} are necessary for all arms of this statement
> #51: FILE: hw/scsi/scsi-generic.c:196:
> +            if (page_idx >= r->buflen)
Sorry about that. Triple checked this code for correctness,
but didn't run checkpatch on the last revision :-(

Best regards,
	Maxim Levitsky

> [...]
> 
> total: 1 errors, 0 warnings, 53 lines checked
> 
> Patch 5/5 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20201104173217.417538-1-mlevitsk@redhat.com/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com



