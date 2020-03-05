Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B563C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F0020732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgbJhiKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F0020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rTs-0003Rm-LX
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1j9rQx-0005C5-IG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1j9rQw-0005NZ-C6
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:25:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1j9rQw-0005MU-7T
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583418305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6yj0eboud6+o9YoABF1tA5EkPKXsi/SEr1m1TuT1ss=;
 b=FgbJhiKZEPAlTA0PPgES7q/HOtNcc7iLBMc4GZMqx9DP310fTAbrYS2WhK0R+YkzMI8Ids
 7lPM7pyUVn8I/aOqwRE10wtlUy6ZeRlYKupPbWgvD2xSq0OqSnbiiYGrPXvwqOV5NGYrbw
 KAV9LEk0RrZzEdwkr1lGHUJXHo6O4rU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-K72vRQ44N5iqKfsyoDfEeQ-1; Thu, 05 Mar 2020 09:24:51 -0500
X-MC-Unique: K72vRQ44N5iqKfsyoDfEeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E23611902EA8;
 Thu,  5 Mar 2020 14:24:50 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E024C5C221;
 Thu,  5 Mar 2020 14:24:49 +0000 (UTC)
Date: Thu, 5 Mar 2020 15:24:47 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/4] block: Relax restrictions for blockdev-snapshot
Message-ID: <20200305142447.GH1320660@angien.pipo.sk>
References: <20200305125100.386-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200305125100.386-1-kwolf@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 13:50:56 +0100, Kevin Wolf wrote:
> This series allows libvirt to fix a regression that its switch from
> drive-mirror to blockdev-mirror caused: It currently requires that the
> backing chain of the target image is already available when the mirror
> operation is started.
>=20
> In reality, the backing chain may only be copied while the operation is
> in progress, so the backing file of the target image needs to stay
> disabled until the operation completes and should be attached only at
> that point. Without this series, we don't have a supported API to attach
> the backing file at that later point.
>=20
> Kevin Wolf (4):
>   block: Make bdrv_get_cumulative_perm() public
>   block: Relax restrictions for blockdev-snapshot
>   iotests: Fix run_job() with use_log=3DFalse
>   iotests: Test mirror with temporarily disabled target backing file

I've modified the libvirt code I have to try this. It works as expected
without iothreads, but I get the following error when iothread is used:

 error: internal error: unable to execute QEMU command 'transaction': Canno=
t change iothread of active block backend

I've tested it also with your Aio context patches for blockdev-reopen
applied and also added a feature flag for blockdev-snapshot

 https://gitlab.com/pipo.sk/qemu/-/commits/kevin-snapshot-blockcopy

I can post the feature patch if you want after I clean it up or perhaps
suggest a better name or wording for it.

The libvirt code is a subset of

 https://www.redhat.com/archives/libvir-list/2020-February/msg01125.html

with the blockdev-reopen bits removed and replaced by blockdev-snapshot.

You can have a look at the libvirt impl here:

 https://gitlab.com/pipo.sk/libvirt/-/commits/block-copy-reopen-snapshot

I'll post it for review if it's clear that iothreads can be supported
using this approach.


