Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BFCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 23:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDDA20780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 23:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QaNDRk6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDDA20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr8HK-0002OS-UP
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 19:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jr8Gi-0001nP-EW; Thu, 02 Jul 2020 19:05:24 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jr8Gf-00022h-Te; Thu, 02 Jul 2020 19:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=aucVfnEq9E2dvg8jdKxxIzQRjTXiTpQHON+8vkz2mRg=; 
 b=QaNDRk6ykmxxHGlJUFS5pgfETiksUugKYPtimSbSToyJWHk66pTKQrJdAL6FcVTqjtUElspATMuISFUpIayPfJXrBrFIvea52jZ50zM7yVJeeHoWayqf7e8J2/GmWpEu4aBteZOO4aM5hkAWoCLfYWtlz2TCGWb67T3ScrmrsEpZbkUGIt5mTw6aQ9F/KFFQwANoL53YdhWOD0dMJO0CoTtGrgaWLhZ0BONw2/gTOTPfu4CLsW26/2hSBsayuIZRjiJveLaOL95kYQAaM8LQLl9vmVo3ji9KsO3VqczA9YxvBPph0vDJwN73+bp0UVsXRGGur3d5PX4MkDnXvkqnGA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jr8GY-0000Yn-IF; Fri, 03 Jul 2020 01:05:14 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jr8GY-0005Df-3T; Fri, 03 Jul 2020 01:05:14 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v9 30/34] qcow2: Add prealloc field to QCowL2Meta
In-Reply-To: <a053de54-93f7-8f13-be5e-6f5d276a7d3d@redhat.com>
References: <cover.1593342067.git.berto@igalia.com>
 <0dd88b3b4d3e90b28267267d7686cf5350d9dea0.1593342067.git.berto@igalia.com>
 <cadd98f7-1fc4-3a54-5999-b988cc79e618@redhat.com>
 <687f5402-2316-e06a-2fd1-37375a4fa119@redhat.com>
 <a053de54-93f7-8f13-be5e-6f5d276a7d3d@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 03 Jul 2020 01:05:14 +0200
Message-ID: <w511rlttt5h.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 18:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 02 Jul 2020 05:09:47 PM CEST, Max Reitz wrote:
>> Without a backing file, there is no read required - writing to an
>> unallocated subcluster within a preallocated cluster merely has to
>> provide zeros to the rest of the write.=C2=A0 And depending on whether we
>> can intelligently guarantee that the underlying protocol already
>> reads as zeroes when preallocated, we even have an optimization where
>> even that is not necessary.=C2=A0 We can still lump it in the "COW"
>> terminology, in that our write is more complex than merely writing in
>> place, but it isn't a true copy-on-write operation as there is
>> nothing to be copied.
>
> The term =E2=80=9CCOW=E2=80=9D specifically in the qcow2 driver also refe=
rs to having
> to write zeroes to an area that isn=E2=80=99t written to by the guest as =
part
> of the process of having to allocate a (sub)cluster.

The question is valid: if the space for the clusters is allocated but
the subclusters are not marked as such then any partial write request
will need to fill the rest with zeroes (in practice handle_alloc_space()
can do that efficiently but that's another question).

If there is a backing file then there's no other alternative because we
do need to copy the data from the backing file.

If there is no backing file perhaps we could allocate all subclusters as
well. I suppose we can detect that scenario at that point in the code (I
haven't checked) and I don't know what would happen if one later
attaches a backing file on runtime using the command-line options.

But what I would argue is that I don't see the benefit of using extended
L2 entries on an preallocated image with no backing file: other than
having twice as much L2 metadata what would be the use? The point of
subclusters is that they make allocation more efficient, but if the
image is already fully allocated then they give you nothing.

Berto

