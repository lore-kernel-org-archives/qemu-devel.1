Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BB5C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF82F208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pIihsSun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF82F208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDZE-0007VW-0o
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jJDYY-0006nf-My
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jJDYX-0000gS-Mv
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:51:38 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:48831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jJDYX-0000Xl-1o; Tue, 31 Mar 2020 05:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=ZNwlFk80yKGWjPz6MzH7je2SuR2raMED6kZGyVHCJtg=; 
 b=pIihsSun5S0XAyDt+pn2Saq7Grz27o7zT7XTIpEWJdHNJeSPT2Wk8417PucUE8k8mfBHxCoP83MFR2QI+YG5I2isA+5wtZfEi6pEe/A9EcwUguez5EXiA4VBaSGOICmZcSFaEahX60qasdKbp2cFB/Bpt7SH96F1TlYfyPLsfboE+nw4GmDbAg4rBwiZ7f94RgRMIpJZabVQ06oaOsv3CUyLotwC3fdj30OI1zngM+rLzHzmE7QMb579tpHsOyxphZp91WKBqRQuXWTl5W7S1EmWDAQnb9dBB8LUbLRBmiGd6+ZKr2qN+ZNWN0jzZ3xi6w1WwbzCk/jzgH6hyqCThQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jJDYF-0003sZ-Gw; Tue, 31 Mar 2020 11:51:19 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jJDYF-0008TV-4f; Tue, 31 Mar 2020 11:51:19 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4] qcow2: Forbid discard in qcow2 v2 images with backing
 files
In-Reply-To: <44971b75-3a06-3111-716e-8e615f775f0f@redhat.com>
References: <20200327185930.19493-1-berto@igalia.com>
 <81e31d93-8bd6-476b-ff92-080da8a2cd67@redhat.com>
 <44971b75-3a06-3111-716e-8e615f775f0f@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 31 Mar 2020 11:51:18 +0200
Message-ID: <w51v9mkx36x.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 31 Mar 2020 10:57:18 AM CEST, Max Reitz wrote:
> I=E2=80=99ll have to dequeue it again, because it breaks iotests 046 and =
177
> (both of which already have special handling for v2-specific discard;
> but it needs to be adjusted now that the discard operation no longer
> reveals the backing file contents).

??? None of those break for me, is that in your branch or in master?

Berto

