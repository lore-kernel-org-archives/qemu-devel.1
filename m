Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACB7CA9ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 14:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984F1218BA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 14:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="L16+myHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984F1218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRcyL-00044F-OU
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 09:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iRcxJ-0003WS-FG
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iRcxI-00058W-1y
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:03:41 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:39356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iRcxA-000571-Qo; Mon, 04 Nov 2019 09:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=hlU0GI0ceqrqvNb9x5p/73IzZp5/Tq++NO+SMooFq3Y=; 
 b=L16+myHlCbfZgPza23Hdi7s1L4YADoHkFoRV7pRVTWEi7e1gDBni6CfwlQBN/Ktar+LezyI2X99wPlOFHkVPJHywfdZnErkqcfro1ZaUerWNAoLd/VjOgqb9Tu9mtVsF7gbUERv8f7rnVte3BEvykIKFC3JLJ0lr8v6YL10/tcdN/sQPIx9Fws7hPNkH3pylsZBpjExaAHALcuIZWHdUAhp68jXZ5LgUzcVa2k7mjo4bM9q9/+cpuxaLZvlyGGo+HfmHwRXsjvtcwmJL/GDMtXSjMBgjYSg3Lcv8ZkQeMxZWQNCBdYwdWetVTzVvivp5eZ32UskNnedawIt6FsDrgQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iRcx4-0007MM-SY; Mon, 04 Nov 2019 15:03:26 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iRcx4-0007jM-Pc; Mon, 04 Nov 2019 15:03:26 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block\@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
In-Reply-To: <0f75cbcf-e6c7-c74c-972b-22e7760a8b5c@redhat.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <02291bca-67d2-ed30-ac34-17641afbe397@virtuozzo.com>
 <d1b43c24-a443-dd19-6814-11eec43e943a@virtuozzo.com>
 <0f75cbcf-e6c7-c74c-972b-22e7760a8b5c@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 04 Nov 2019 15:03:26 +0100
Message-ID: <w51r22nspqp.fsf@maestria.local.igalia.com>
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

On Fri 25 Oct 2019 04:19:30 PM CEST, Max Reitz wrote:
>>> So, it's obvious that c8bb23cbdbe32f5c326 is significant for 1M
>>> cluster-size, even on rotational disk, which means that previous
>>> assumption about calling handle_alloc_space() only for ssd is wrong,
>>> we need smarter heuristics..
>>>
>>> So, I'd prefer (1) or (2).
>
> OK.  I wonder whether that problem would go away with Berto=E2=80=99s sub=
cluster
> series, though.

Catching up with this now. I was told about this last week at the KVM
Forum, but if the problems comes with the use of fallocate() and XFS,
the I don't think subclusters will solve it.

handle_alloc_space() is used to fill a cluster with zeroes when there's
COW, and that happens the same with subclusters, just at the subcluster
level instead of course.

What can happen, if the subcluster size matches the filesystem block
size, is that there's no need for any COW and therefore the bug is never
triggered. But that's not quite the same as a fix :-)

> Maybe make a decision based both on the ratio of data size to COW area
> length (only invoke handle_alloc_space() under a certain threshold),
> and the absolute COW area length (always invoke it above a certain
> threshold, unless the ratio doesn=E2=80=99t allow it)?

Maybe combining that with the smaller clusters/subclusters can work
around the problem. The maximum subcluster size is 64KB (for a 2MB
cluster).

Berto

