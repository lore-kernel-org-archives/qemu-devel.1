Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED4C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4848B207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mJjfRypO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4848B207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMJH-0000t7-7A
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1irM7m-0002Yn-CN
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1irM7i-0001ET-C9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:20:49 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:40070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1irM7h-0001E8-Pj; Tue, 14 Jan 2020 08:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=F1h5/Fq0caHTUDwzD3ZBcQmWmRRis8CvP4nsIBobSy0=; 
 b=mJjfRypOsv0l8U1hFaXRISIgBsYePL25j6X91KCW/yRAMjW+BJ/uaX3EQcNiun7UcvlMo90H3x0uwnAE5G6xjvaxA+F+c5qyUyDEjXckQ7gPdnWfvdJEyk95fP1zQqRTfJGq/f6/WFn34VBmUVWHKx4zx39TT5MKINg7qX/F8aSA8/xmn9hDfYDWKFh+btUT8iBCLS4rWushCW/zLpa7Wp4vreZTNmOyirUMek0ALzJj+LdDx33z2AW5zCL2x4NdS2+edqxF+wNJQM0h1uFlf4etnKVp8pYynfEYdjckb4vySdmugR6/qQARARKuyB+mFTEtj0IuteOzvwHaKOO9Ag==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1irM7c-0000LQ-Ue; Tue, 14 Jan 2020 14:20:40 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1irM7c-0007m3-KL; Tue, 14 Jan 2020 14:20:40 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/4] qcow2: Require that the virtual size is a multiple
 of the sector size
In-Reply-To: <bd6ca991-c2f7-0e27-5bee-07a7c53f8a8e@redhat.com>
References: <cover.1578596897.git.berto@igalia.com>
 <6a1cfcbb533b487bac96e1d2282ebf210954d27a.1578596897.git.berto@igalia.com>
 <bd6ca991-c2f7-0e27-5bee-07a7c53f8a8e@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 14 Jan 2020 14:20:40 +0100
Message-ID: <w51v9peb2dz.fsf@maestria.local.igalia.com>
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

On Tue 14 Jan 2020 02:01:03 PM CET, Max Reitz wrote:
>> However when an image is opened the virtual size is rounded down,
>> which means that trying to access the last few advertised bytes will
>> result in an error. As seen above QEMU cannot create such images and
>> there's no good use case that would require us to try to handle them
>> so let's just treat them as unsupported.
>
> But isn=E2=80=99t that just a bug in qemu?

Yes, but does it make sense to try to support images with unaligned
sizes if no one is going to create them ever and QEMU cannot even
generate them?

Berto

