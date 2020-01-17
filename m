Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90FBC33CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31B32073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sE6t2T6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31B32073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSqT-0006Mt-Rs
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:43:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1isSiF-0004v6-Af
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1isSiE-0004Nj-0P
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:35:03 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:46599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1isSiD-0003xT-CT; Fri, 17 Jan 2020 09:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=r2zledLn0ugG3HPL0wqIuq8vwZctvziOYmn6k0hzc5Y=; 
 b=sE6t2T6lOvjY9JvSNLerRRFDIh1ASoUAol/EY5PCVEF+T1HDyY0IUhlMuFux/n/YbqQFc+yj6g/CQTss72wb5PnB6JUc3FdiYtG3YKcyYwPMMiH/pdOKBffHlSty0PvDPY46bAGOlU3Ke/J1DWXo6S4R8Lu1n3W5xn1YzheY8NNAh67rLZ32onLvuEA+X0Uu2tA8ed4y2Ng0dnHFbECl/7p/nRnAMmtqBAO9IqvaXSgqxrmtPAO96DLNLmVknKu9XNvEaLcZtKp+NeSmmbqEziiQ0LgF3NfYBE6CqD55bntGDmPR/pKV2ivBIwZv8R3c+6QW8sQXl0AqL06T4EXPWQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1isShu-0001w4-KA; Fri, 17 Jan 2020 15:34:42 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1isShu-0005jl-8G; Fri, 17 Jan 2020 15:34:42 +0100
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 4/4] qcow2: Use BDRV_SECTOR_SIZE instead of the
 hardcoded value
In-Reply-To: <20200117115104.GE7394@dhcp-200-226.str.redhat.com>
References: <cover.1578596897.git.berto@igalia.com>
 <e3982d5118a90db2442c6ac18f339ec8ba006df2.1578596897.git.berto@igalia.com>
 <02552511-6fcf-d678-362c-707ce6d73659@redhat.com>
 <w517e1rf0fo.fsf@maestria.local.igalia.com>
 <56ec1ead-bba9-f4de-5c87-e81f802dfc79@redhat.com>
 <20200117095538.GB7394@dhcp-200-226.str.redhat.com>
 <f0de9a2b-6ce2-22a5-8bfe-526100fcd544@redhat.com>
 <20200117115104.GE7394@dhcp-200-226.str.redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 17 Jan 2020 15:34:42 +0100
Message-ID: <w51blr2kv7h.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Nir Soffer <nsoffer@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 17 Jan 2020 12:51:04 PM CET, Kevin Wolf wrote:
>> > Now, what's wrong about the logic to avoid the RMW is that it assumes
>> > a fixed required alignment of 512. What it should do is looking at
>> > bs->file->bl.request_alignment and rounding accordingly.
>> 
>> Yes.
>
> Who'll write the patch? :-)

I have to resend the series anyway so I can do it.

Berto

