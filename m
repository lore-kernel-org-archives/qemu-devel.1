Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4976EC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14132206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HODa2SPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14132206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSoN-0002iU-7P
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43386 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jQSnU-0001eB-5z
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:33:00 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1jQSnS-0002DX-IF
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:32:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57677
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jQSnS-0002A4-3w
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587375176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZBSAqXyEUjM/lDcUFh4JaIG1DMdLIK1+F2AB63GneM=;
 b=HODa2SPGg2yp/768iMLXGrnyRBlIM2RzKSuTgX6kG1wO+ptKL2oWubL9Lfiaadvo1kpyuJ
 oz5XigMaGtRTtUBn8vhzVWP3W69Ik6S0487FSTNFB4e7gVzNo0HFOx23CR3S8cMv/Nc67K
 BCJEad2fpNyy/wn/NqlMUSO4TyXB/Ik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-vRJ5u7GDPquiV5_MOIryDw-1; Mon, 20 Apr 2020 05:32:52 -0400
X-MC-Unique: vRJ5u7GDPquiV5_MOIryDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 853081083E81;
 Mon, 20 Apr 2020 09:32:51 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-228.ams2.redhat.com
 [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 456B15C1B2;
 Mon, 20 Apr 2020 09:32:47 +0000 (UTC)
Subject: Re: [edk2-discuss] Load Option passing. Either bugs or my confusion.
To: Hou Qiming <hqm03ster@gmail.com>
References: <623b1855-285c-cce3-c806-c17e5fd217ea@redhat.com>
 <5211.1586899245384995995@groups.io>
 <a972450d-8834-ae87-e4e3-5263a41d1735@redhat.com>
 <CABSdmr=u9QeNA6jy29e2pkiqnGH=xw1n+Hkkrd=AH1RRvj92Ng@mail.gmail.com>
 <2941f608-7e0f-1190-cccb-2b17d9ea20bf@redhat.com>
 <CABSdmrk2L8L-J-JmKQC-kyswOq9Bh3AUnM_+FkiHpW9c1EuxwQ@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <31c4bd9a-080e-9e15-82db-606d12e68349@redhat.com>
Date: Mon, 20 Apr 2020 11:32:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABSdmrk2L8L-J-JmKQC-kyswOq9Bh3AUnM_+FkiHpW9c1EuxwQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: edk2-devel-groups-io <devel@edk2.groups.io>,
 qemu devel list <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 discuss@edk2.groups.io, valerij zaporogeci <vlrzprgts@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/17/20 05:22, Hou Qiming wrote:
> I'm glad we can reach a consensus that ramfb needs sanity checks. And well,
> I'm probably at fault with the hijacking.
> 
> Your QEMU/TCG in QEMU/TCG example also made me realize a deeper problem,
> though: your setting still can't escape the host display / physical GPU
> issue. The middle display layers be bochs or whatever, but as long as the
> framebuffer content and resolution values are propagated, and the end
> result is displayed at all on the host, the host GPU attack surface remains
> exposed to the L2 guest, and checks are needed. Everything shown on the
> screen involves the display driver - GPU stack, GTK or SDL or tty, you
> can't avoid that. ramfb-kvmgt just happened to be the shortest pipeline
> where every stage neglected the checks, which exposed this problem.

Good point.

> Blaming
> this on ramfb is unfair since in your scenario the checks are better done
> in the display subsystems.
> 
> TL;DR You made me realize right now, it's a very real risk that an AARCH64
> Windows guest could exploit a x64 host's display driver by specifying a
> crafted framebuffer with overflowing resolution. I don't want to break it,
> but I'd prefer a broken state over an insecure state.
> 
> I'm not quite sure what this thread is. But I think with the scope this
> discussion is going, maybe it's more of a bug than a regression.

All display devices (frontends) emulated by QEMU have to set bounds for
the permissible resolutions, for the guest. And those limits must never
break the capabilities of the display backends. So this is not a new
problem. How is it handled with other frontends? Like bochs-display, for
example -- I assume bochs-display too is purely virtual, i.e. the
resolution is fully controller (between bounds) by the guest. How is the
guest currently prevented from setting a bochs-display resolution that
"breaks SDL" (whatever that means)?

I'm inclined to agree that we're just seeing two sides of the same bug
-- the first state was too lax, and the current state is too strict.

Thanks
Laszlo


