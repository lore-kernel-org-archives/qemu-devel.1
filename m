Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7772C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810832078E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IdYnP41G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810832078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbSt-0003Ji-J0
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jVbRw-0002Md-DV; Mon, 04 May 2020 09:48:00 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:38462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jVbRu-000282-Q3; Mon, 04 May 2020 09:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=syWocxnvaYQM5jzIK65at3mK0WUaB2XPURH7sMlH+nk=; 
 b=IdYnP41GakBQITwiTQyaJeelEZGkfL1h+9USzLPNPOpun/UmiFpLlASGcnVcXklE5OPy4IFPBah2DwEFWcvQ7JJd967qnLw6qsDrjGo8aWG3Qfhob0pUVcKrtCSW15C1+KW+e0Lr1diLI6UffEzbLTN7HJHfoye4SVlkQ5JDs20jHwE2iFjcjLedz3RBK3lJzknzMRsRMhkmEUPGS/m5qujajME/p5tIbjnWXfZok0TE01JhBvecmjI07BXssx0vgwQcAiVo3z7mNYVzKuK2XJaUUn5ggJY4XeQa/fLQy8G6Pkp8jaa/0Ud3Lmw68z6lCGqImFwyqDkcEzhxVgCzcA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jVbRX-0002Z3-RM; Mon, 04 May 2020 15:47:35 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jVbRX-0002px-Hi; Mon, 04 May 2020 15:47:35 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] qcow2: Avoid integer wraparound in qcow2_co_truncate()
In-Reply-To: <101fcf8e-0352-9151-f25a-c8a38aa079ed@redhat.com>
References: <20200501131525.6745-1-berto@igalia.com>
 <5ba91898-9d3b-d55d-c360-83cca41d88f4@redhat.com>
 <101fcf8e-0352-9151-f25a-c8a38aa079ed@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 04 May 2020 15:47:35 +0200
Message-ID: <w515zdbizgo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 09:47:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 01 May 2020 08:48:31 PM CEST, Eric Blake wrote:
> Since your reproducer triggers assertion failure, I suggest doing this
> instead:

>>> +++ b/block/qcow2.c
>>> @@ -4234,6 +4234,9 @@ static int coroutine_fn=20
>>> qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((flags & BDRV_REQ_ZERO_WRITE) && off=
set > old_length) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t zero_st=
art =3D QEMU_ALIGN_UP(old_length,=20
>>> s->cluster_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* zero_start should not be=
 after the new end of the image */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zero_start =3D MIN(zero_sta=
rt, offset);
>>> +
>
> Drop this hunk (leave zero_start unchanged), and instead...
>
>>=20
>> So, using your numbers, pre-patch, we have zero_start =3D 0x90000 (0x820=
00=20
>> rounded up to 0x10000 alignment).=C2=A0 post-patch, the new MIN() lowers=
 it=20
>> back to 0x8dc00 (the new size), which is unaligned.
>>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Use zero=
 clusters as much as we can. qcow2_cluster_zeroize()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * requires=
 a cluster-aligned start. The end may be=20
>>> unaligned if it is
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * at the end of the im=
age (which it is here).
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qcow2_cluster_zeroiz=
e(bs, zero_start, offset -=20
>> zero_start, 0);
>
> ...patch _this_ call to compute 'QEMU_ALIGN_UP(offset, s->cluster_size)=20
> - zero_start' for the length.

That would work, but then we would be writing zeroes beyond the end of
the image (but still within the last cluster).

The other solution is to keep my hunk and call qcow2_cluster_zeroize()
only when offset > zero_start.

Berto

