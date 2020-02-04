Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F98C3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2A42084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqxaqOLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2A42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuIl-0007Si-Ge
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iyuI2-0006oa-U1
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:14:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iyuHz-0003Ki-U1
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:14:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32423
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iyuHz-0003Cb-NQ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580807673;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=an2Gkp9unIEriLSGyodP//4XJXFL/hL+jhCSDIXSz9U=;
 b=CqxaqOLiTP0Q6dnxGzLUBsBCzh7cCYAnDb1GusBX03OR6MWVhWzVpTuaTa3aNALiK+/JBE
 Px2M0+5zWIvuYsE11hnfC2yFxULPhTjyo3SqRG4A9xd4amIRaFWTpmy7bUYnNiF/XYOHEO
 p0vlY7Jf2LzEASltgkmu/mFNhIodjRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-GhtMIrN5M6SFCFNClTYhnA-1; Tue, 04 Feb 2020 04:14:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F109B801E72;
 Tue,  4 Feb 2020 09:14:30 +0000 (UTC)
Received: from redhat.com (ovpn-117-28.ams2.redhat.com [10.36.117.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74AD35C1B5;
 Tue,  4 Feb 2020 09:14:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH] migration: Optimization about wait-unplug migration state
In-Reply-To: <20200204050841.44453-1-zhukeqian1@huawei.com> (Keqian Zhu's
 message of "Tue, 4 Feb 2020 13:08:41 +0800")
References: <20200204050841.44453-1-zhukeqian1@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 04 Feb 2020 10:14:24 +0100
Message-ID: <87blqehfyn.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: GhtMIrN5M6SFCFNClTYhnA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: quintela@redhat.com
Cc: jfreimann@redhat.com, wanghaibin.wang@huawei.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keqian Zhu <zhukeqian1@huawei.com> wrote:
> qemu_savevm_nr_failover_devices() is originally designed to
> get the number of failover devices, but it actually returns
> the number of "unplug-pending" failover devices now. Moreover,
> what drives migration state to wait-unplug should be the number
> of "unplug-pending" failover devices, not all failover devices.
>
> We can also notice that qemu_savevm_state_guest_unplug_pending()
> and qemu_savevm_nr_failover_devices() is equivalent almost (from
> the code view). So the latter is incorrect semantically and
> useless, just delete it.
>
> In the qemu_savevm_state_guest_unplug_pending(), once hit a
> unplug-pending failover device, then it can return true right
> now to save cpu time.
>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

For my reading you are right:
- 1st function naming is not right
- 2nd function achieves exactly the same effect

I will wait until Jens says anything, but then I will queue it.

Thanks, Juan.


