Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB17C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B6A2051A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CoRONq8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B6A2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is66d-0006U9-DL
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1is64s-0004b0-Q1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1is64q-0004sL-0R
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:24:54 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:40077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1is64p-0004lW-FJ; Thu, 16 Jan 2020 09:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=IiCaZziZPacMcbVQ9RLheo3fn4G5bGB8e0He/NJ7oBo=; 
 b=CoRONq8qbRFaBenkzgPOOXbWxRzzJaoQKXvq+YmnwA9HidmAd++zLX6HLaNQO3XCY/bmt5xjai8ZS3egQG/W7jvEKld4QLfUNnSa3fLLLpvomMdnBqrU17/lkcikmDM/kAAg6dLX9VUpiiR64z2kWIsX5JRqq/t8n7D6vLHLcvNNP0EcHWGUBxbMODvrIU4+6mXxYGsF9xLL+qpF51x1EqPAu42/gMb7P5K5I19nrfqoGJvozg5SGiLiPaJiCMU8L4oabuxWn1tSFWnM7EfAyf9f80oPTwLkaOArTNj8hv7Blh0u55vcg6fNdNscIoItPykxW/M8EwfeGey4h7wYKQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1is64X-0007QI-F7; Thu, 16 Jan 2020 15:24:33 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1is64W-0003s6-QL; Thu, 16 Jan 2020 15:24:32 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/4] qcow2: Require that the virtual size is a multiple
 of the sector size
In-Reply-To: <70f3996c-e62d-c560-b7a3-e0653f38493d@redhat.com>
References: <cover.1578596897.git.berto@igalia.com>
 <6a1cfcbb533b487bac96e1d2282ebf210954d27a.1578596897.git.berto@igalia.com>
 <bd6ca991-c2f7-0e27-5bee-07a7c53f8a8e@redhat.com>
 <w51v9peb2dz.fsf@maestria.local.igalia.com>
 <9f7ab60c-c9d4-527b-55dd-40f487a36895@redhat.com>
 <w51sgkib0n3.fsf@maestria.local.igalia.com>
 <70f3996c-e62d-c560-b7a3-e0653f38493d@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 16 Jan 2020 15:24:32 +0100
Message-ID: <w51a76nfpi7.fsf@maestria.local.igalia.com>
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

On Tue 14 Jan 2020 03:03:31 PM CET, Max Reitz wrote:
>> 3. QEMU can open them but it gets the size wrong.
>
> Yes, but in a safe way.  The user simply doesn=E2=80=99t get access to th=
ose
> 13 bytes.

Ok, I think I'll withdraw the patch then :-)

Berto

