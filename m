Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAF2C282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 15:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932762075B
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 15:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cbA3/Pez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932762075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56287 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUuia-000528-Ph
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 11:05:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hUufl-0003KL-TH
	for qemu-devel@nongnu.org; Sun, 26 May 2019 11:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hUufg-00066l-Ih
	for qemu-devel@nongnu.org; Sun, 26 May 2019 11:02:50 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:55914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hUufZ-0005Rd-Lg; Sun, 26 May 2019 11:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=8kmYVvRVo5948Rwdb8lzmlTbx8wzLYy5VKdsd4pcqBQ=; 
	b=cbA3/PezWHVbHodGUroH7Lv7FIddWLYHOZtLgJkUWn89j2toUe3jI2M5Hhr6xPEpYX6wXE2TH4qvIohXLVQDuzNBpBYF49rrFYVJlPE4chMUEWqcM6R13o0+ptrUnyR/xXew+HszdrCEPZXqbCa1jr/un1j1aYIxD758FcgNq5gOwS2hXdPhUgTtOKn2FBggiGvOKgVakIaj1LsIN4cdAzhCA4XoV1uptle2Lkyq8TUNXkjLOhtzBIoZ95Nf65KhoDly8m9ZIOwTPID96MBbTgmkuzzKOfiouxA1X48zsIqBmFaxnGA92wxROm24cCib04xTVFoEQMBVcsnel8ajRw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hUueu-000487-2W; Sun, 26 May 2019 17:02:00 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hUuet-0003uA-Vy; Sun, 26 May 2019 17:01:59 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
	qemu-block@nongnu.org
In-Reply-To: <f2d129f6-b03f-aaa8-3e7d-fff48ea52233@redhat.com>
References: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
	<f2d129f6-b03f-aaa8-3e7d-fff48ea52233@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Sun, 26 May 2019 17:01:59 +0200
Message-ID: <w51h89hjm3c.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH v14 0/1] qcow2: cluster space preallocation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
	den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 24 May 2019 03:56:21 PM CEST, Max Reitz <mreitz@redhat.com> wrote:
>>     +-----------+-------+------+-------+------+------+
>>     |   file    |    before    |     after    | gain |
>>     +-----------+-------+------+-------+------+------+
>>     |    ssd    |      61.153  |      36.313  |  41% |
>>     |    hdd    |     112.676  |     122.056  |  -8% |
>>     +-----------+--------------+--------------+------+
>
> I=E2=80=99ve done a few more tests, and I=E2=80=99ve seen more slowdown o=
n an HDD.
> (Like 30 % when doing 64 kB requests that are not aligned to
> clusters.)  On the other hand, the SSD gain is generally in the same
> ballpark (38 % when issuing the same kind of requests.)
  [...]
> [1] Hm.  We can probably investigate whether the file is stored on a
> rotational medium or not.  Is there a fundamental reason why this
> patch seems to degrade performance on an HDD but improves it on an
> SSD?  If so, we can probably make a choice based on that.

This is when writing to an unallocated cluster with no existing data on
the backing image, right? Then it's probably because you need 2
operations (write zeros + write data) instead of just one.

Berto

