Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825A6C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45BDE2178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Wcqoeu+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BDE2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSj9x-0005YW-9t
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iSj1u-0007Iu-7J
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iSj1t-0004cA-6e
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:44:58 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:53167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iSj1s-0004IO-Jb; Thu, 07 Nov 2019 09:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=6e62Cy9el1vP6n4SF0hlIi4Q/qyr1Slm32ujbkIV+/U=; 
 b=Wcqoeu+JO5y1bVQ4UFbK31QzWJeDgdczIQWg4/3hQqsXPntG1WPPJQWwrHhqBVwjTnEU73a2KoPL7YM9YMpokRXT8shAM7Co5tHS1cgy7yvZyuRteqRCthlczanZTWmvo/0KRe5CN1HMUki1ACi05uWr7oEUf9WzkGriYNmV3BQ58uWFm+kd8uV9X70sWTQTOviH/sh/RcEM0FuakWghrF4ls4OxKEI8BexWEeWG06bNSolwwNCrI6xY6aChdSkYYTnYNQQRrLu8of/s8oIXu5scmGfxwG9hp8TPvGYuSug4M2RuI00TF0K7my2xVfguCvJk2brC8DsisZBrtCrQcQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iSj1Z-0003YC-Lj; Thu, 07 Nov 2019 15:44:37 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iSj1Z-0003zw-Ir; Thu, 07 Nov 2019 15:44:37 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 12/26] qcow2: Handle
 QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER
In-Reply-To: <016246de-df5c-b2a3-2d2d-b99ff7277fc5@redhat.com>
References: <cover.1572125022.git.berto@igalia.com>
 <2a6b34635cac78e76150a72c69669b3d9ec0fb8c.1572125022.git.berto@igalia.com>
 <78cc16f3-f8aa-9dcb-2389-4f6ed86080fd@redhat.com>
 <w51tv7jssjf.fsf@maestria.local.igalia.com>
 <016246de-df5c-b2a3-2d2d-b99ff7277fc5@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 07 Nov 2019 15:44:37 +0100
Message-ID: <w51h83fzqy2.fsf@maestria.local.igalia.com>
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

On Mon 04 Nov 2019 02:10:37 PM CET, Max Reitz wrote:

   [QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER]
> I still don=E2=80=99t know what you=E2=80=99re doing in the later patches=
, but to me
> it looks a bit like you don=E2=80=99t dare breaking up the existing struc=
ture
> that just deals with clusters.

Yeah, I decided to extend the existing type to make the changes less
invasive, but I'm also leaning towards creating a different type
now. I'll give it a try.

Berto

