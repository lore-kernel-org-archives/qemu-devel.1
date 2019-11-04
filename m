Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CA2CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9CA204FD
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JPsW3/BO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9CA204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRe2O-0001rH-LG
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 10:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iRe1h-0001Iq-RA
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iRe1g-0002JS-OJ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:12:17 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:45875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iRe1d-0002II-Fg; Mon, 04 Nov 2019 10:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=UEclHnHy1qw4fVSKCIRNjbtjqRpxu0mDGF6eFAGnqDk=; 
 b=JPsW3/BOI83wKeMFD+lhQ6qXR119sdCMGHQFqkE3trRuTawv32ITPjH22YlKCaByFUXEH9ETRqITHoNtTondpTfsdpatkeeYed0Zt/OkmrqJ4Uz5VI89i752A2GRmAOcVEz0Zqh/qpDefNnokXRP1yjKFMwYI2Axz2CKpe88OCoy7iQy5u0nuXWKRPP9MNdMga8+AI/lgGwuo5N88MfWebRZhoRAmzAdU7gSQI8l/sUz7xnhHF8HFQw4E4hx4T6gckzPV70DckHb/K/bdPf2kLsET4gtI15E0qt/OKmdmuIcV3zIOsTNM7eoFG+gbfYDHVWLRObvIARtjEzVVO+dLQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iRe1Z-0004iy-0L; Mon, 04 Nov 2019 16:12:09 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iRe1Y-0000F8-TT; Mon, 04 Nov 2019 16:12:08 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block\@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
In-Reply-To: <7ed9b8f0-2d8c-7bac-185e-9a1dd68fcce8@redhat.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <02291bca-67d2-ed30-ac34-17641afbe397@virtuozzo.com>
 <d1b43c24-a443-dd19-6814-11eec43e943a@virtuozzo.com>
 <0f75cbcf-e6c7-c74c-972b-22e7760a8b5c@redhat.com>
 <w51r22nspqp.fsf@maestria.local.igalia.com>
 <7ed9b8f0-2d8c-7bac-185e-9a1dd68fcce8@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 04 Nov 2019 16:12:08 +0100
Message-ID: <w51mudbsmk7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 04 Nov 2019 03:25:12 PM CET, Max Reitz wrote:
>>>>> So, it's obvious that c8bb23cbdbe32f5c326 is significant for 1M
>>>>> cluster-size, even on rotational disk, which means that previous
>>>>> assumption about calling handle_alloc_space() only for ssd is wrong,
>>>>> we need smarter heuristics..
>>>>>
>>>>> So, I'd prefer (1) or (2).
>>>
>>> OK.  I wonder whether that problem would go away with Berto=E2=80=99s s=
ubcluster
>>> series, though.
>>=20
>> Catching up with this now. I was told about this last week at the KVM
>> Forum, but if the problems comes with the use of fallocate() and XFS,
>> the I don't think subclusters will solve it.
>>=20
>> handle_alloc_space() is used to fill a cluster with zeroes when there's
>> COW, and that happens the same with subclusters, just at the subcluster
>> level instead of course.
>>=20
>> What can happen, if the subcluster size matches the filesystem block
>> size, is that there's no need for any COW and therefore the bug is never
>> triggered. But that's not quite the same as a fix :-)
>
> No, what I meant was that the original problem that led to c8bb23cbdbe
> would go away.

Ah, right. Not quite, according to my numbers:

|--------------+----------------+-----------------+-------------|
| Cluster size | subclusters=3Don | subclusters=3Doff | fallocate() |
|--------------+----------------+-----------------+-------------|
|       256 KB |     10182 IOPS |        966 IOPS |  14007 IOPS |
|       512 KB |      7919 IOPS |        563 IOPS |  13442 IOPS |
|      1024 KB |      5050 IOPS |        465 IOPS |  13887 IOPS |
|      2048 KB |      2465 IOPS |        271 IOPS |  13885 IOPS |
|--------------+----------------+-----------------+-------------|

There's obviously no backing image, and only the last column uses
handle_alloc_space() / fallocate().

Berto

