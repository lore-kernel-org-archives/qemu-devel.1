Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A81BC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728A9206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728A9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHXeb-0000kQ-BS
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 14:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHXdp-0008Uq-3q
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHXdm-00047D-N4
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:21:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iHXdm-00046d-Hj
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:21:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C80CA44AF1;
 Mon,  7 Oct 2019 18:21:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52E735DE5C;
 Mon,  7 Oct 2019 18:21:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 569BF1138648; Mon,  7 Oct 2019 20:21:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Is network backend vde worth keeping? (was: Is network backend netmap
 worth keeping?)
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
Date: Mon, 07 Oct 2019 20:21:14 +0200
In-Reply-To: <87imr8l0ti.fsf_-_@dusky.pond.sub.org> (Markus Armbruster's
 message of "Thu, 08 Aug 2019 06:48:25 +0200")
Message-ID: <878spwct7p.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 07 Oct 2019 18:21:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, renzo@cs.unibo.it,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Please excuse the attention-grabbing subject.

Again.

[...]
> So, to make use of QEMU's netmap backend (CONFIG_NETMAP), you have to
> build and install netmap software from sources.  Which pretty much

CONFIG_VDE seems to be similarly cumbersome to build-test.

> ensures nobody uses it.  It was added in commit 58952137b0b (Nov 2013).
[...]

The vde backend was added in commit 8a16d273887 (Jul 2008).  The commit
message blames it on Luca Bigliardi.  Julia (cc'ed) fixed a bug in 2018.
Can't see any other VDE-specific activity since we split net/vde.c off
net.c in 2009.

I found a github repository virtualsquare/vde-2, which seems to be
pertinent.  Recent commits have been merged by
danielinux@users.noreply.github.com, which looks anti-social enough to
me not to bother with a cc.  Further digging coughed up Renzo Davoli
(cc'ed).

[...]
> Why is the QEMU netmap backend worth keeping?
>
> Who is using the netmap backend?
>
> How do they obtain a netmap-enabled QEMU?  Compile it from sources
> themselves?
>
> Would it make sense to have netmap packaged in common Linux distros?

Same questions for the QEMU vde backend.

