Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2E3C33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D978B214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XBiJ5PtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D978B214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMja-0001GL-Rl
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1irMiI-00080g-GD
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1irMiE-0001BV-6D
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:58:34 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:52889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1irMiB-0001B0-UF; Tue, 14 Jan 2020 08:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=a9fjg3MM6VegbyHPvApFP0RNFDauRG63U8EPnn1FFiE=; 
 b=XBiJ5PtJH21NGBKQfvcs96WgTQcMDI1vgEn2m5taV3z4NqODP8+2ma+4JEj18IJxFfnbiAa0OFbYmfpPLzTFd7fuTQq4N9/Aheon2iNEqwxBH38CteZHFHgNUvJabNGev0REuJpwdbCVtNt4lQgfkxJBuwadJiF08uUd9q++WfOc0JHmgqL35tcZfYarVyuMMDAYloiLqoNvUCoUWpfvrT0hChTkcuoeVpiGKqdPwESFnhEzhJF9xefSmJG939V17uHmUXcg8UIvH3su0UMuzp+bclKZgj+Ii9vrSXcm3wVHcruszEUSvZvUjp8a6rveb0SIksGip9NyMXELuIQAvA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1irMi9-00046K-DO; Tue, 14 Jan 2020 14:58:25 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1irMi8-0000H9-V4; Tue, 14 Jan 2020 14:58:24 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/4] qcow2: Require that the virtual size is a multiple
 of the sector size
In-Reply-To: <9f7ab60c-c9d4-527b-55dd-40f487a36895@redhat.com>
References: <cover.1578596897.git.berto@igalia.com>
 <6a1cfcbb533b487bac96e1d2282ebf210954d27a.1578596897.git.berto@igalia.com>
 <bd6ca991-c2f7-0e27-5bee-07a7c53f8a8e@redhat.com>
 <w51v9peb2dz.fsf@maestria.local.igalia.com>
 <9f7ab60c-c9d4-527b-55dd-40f487a36895@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 14 Jan 2020 14:58:24 +0100
Message-ID: <w51sgkib0n3.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 14 Jan 2020 02:47:53 PM CET, Max Reitz wrote:

>> Yes, but does it make sense to try to support images with unaligned
>> sizes if no one is going to create them ever and QEMU cannot even
>> generate them?
>
> If nobody uses such images ever, isn=E2=80=99t the current code fine as-i=
s?

I'll rephrase:

1. It is possible to have a qcow2 image with a size of 1 GB + 13 bytes
   (the size field in the qcow2 header allows it).

2. qemu-img cannot currently produce such images.

3. QEMU can open them but it gets the size wrong.

4. Fixing this in QEMU involves non-trivial changes (at least at the
   moment).

5. I don't think there's any use case for such images so instead of
   fixing QEMU I propose that we simply refuse to open them.

Berto

