Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA31BC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE5620706
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pJGFW+ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE5620706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVHJ6-0008VU-PI
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 10:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iVHHy-0007wX-TG
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iVHHw-0007xK-Te
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:44:06 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:33326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iVHHv-0007uO-2N; Thu, 14 Nov 2019 10:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=/TA+1OZSyrVvwfU1kVcR+CNd/jT+P1MYiRE09Ufcz+A=; 
 b=pJGFW+ov7XLx0iFCxsinDY9WImvIxdLRa/Bk//g+EWCwYR3q5pgCm12sJh28YLFOZ8Pe+IrAcuEP6nVz0T9AkyIJqXpQH+TU7LvJ28JdQBflhl8Bm2sOPZ5w7nz9xkIRpD24jNkl8n93v7k7P7CGXdA8S41GhDwHc728KUimeoFnDh2prqsHAp2joWbbU0ZwBauW9zmH5dFcbTrt+6GZasXUmsIFAjIrWIoijW9I54Kv3JbOpPN1wcYafhJyWcgYwalx2/q7E3mniFnyDbtcRyFBUHT7aOD1dyDe3TlgJ+xLYwGJV1tr1iRUN08ce35J7L7wHpmhat0nNSkLyQzSJQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iVHHr-0006DN-Iu; Thu, 14 Nov 2019 16:43:59 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iVHHr-0006DZ-Fq; Thu, 14 Nov 2019 16:43:59 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 18/26] qcow2: Add subcluster support to
 expand_zero_clusters_in_l1()
In-Reply-To: <23b7a28a-22e2-25f5-3b08-438bf86e48ba@redhat.com>
References: <cover.1572125022.git.berto@igalia.com>
 <f99f051139f84a4d34bc52696aa2c2b125d5c3fd.1572125022.git.berto@igalia.com>
 <23b7a28a-22e2-25f5-3b08-438bf86e48ba@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 14 Nov 2019 16:43:59 +0100
Message-ID: <w51pnhuea4g.fsf@maestria.local.igalia.com>
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
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 05 Nov 2019 12:05:02 PM CET, Max Reitz wrote:
>> @@ -2102,6 +2103,7 @@ static int expand_zero_clusters_in_l1(BlockDriverS=
tate *bs, uint64_t *l1_table,
>>                  } else {
>>                      set_l2_entry(s, l2_slice, j, offset);
>>                  }
>> +                set_l2_bitmap(s, l2_slice, j, QCOW_L2_BITMAP_ALL_ALLOC);
>>                  l2_dirty =3D true;
>>              }
>
> Technically this isn=E2=80=99t needed because this function is only called
> when downgrading v3 to v2 images (which can=E2=80=99t have subclusters), =
but
> of course it won=E2=80=99t hurt.

Right, but we need to change the function anyway to either do this or
assert that there are no subclusters. I prefer to do this because it's
trivial but I won't oppose if someone prefers the alternative.

Berto

