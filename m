Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A927FC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AAB2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eojtzK+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AAB2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7O3m-0007mB-M1
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 13:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j7O2y-0007FP-2a
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j7O2x-0003WV-7T
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:38:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42852
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j7O2x-0003Ve-3g
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582828685;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9MnFxfXGiREnWBDLjgCDwPfHXBU7We4D+aVAxA2Wc0=;
 b=eojtzK+ygs2TE7DScWZf35rYQ/zK353EGdBRk1m+NJkAa+eYfZg7XvA9gMqY3NKolGPlYR
 0R/oxb1geogC28+Qbcd0SXbhLsksTaWHCBLLdD3ezr7ytXRoehni45Rz3Xxc0p944K+efe
 Xmpvar9W4GMbqpSBqdzJk+U/qGZeOsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-btIa6ENBOduYhmlkhUcN_Q-1; Thu, 27 Feb 2020 13:38:03 -0500
X-MC-Unique: btIa6ENBOduYhmlkhUcN_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46D6513E5;
 Thu, 27 Feb 2020 18:38:02 +0000 (UTC)
Received: from redhat.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0742C90F5B;
 Thu, 27 Feb 2020 18:38:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Subject: Re: [PATCH V2 3/8] savevm: Don't call colo_init_ram_cache twice
In-Reply-To: <20200224065414.36524-4-zhang.zhanghailiang@huawei.com>
 (zhanghailiang's message of "Mon, 24 Feb 2020 14:54:09 +0800")
References: <20200224065414.36524-1-zhang.zhanghailiang@huawei.com>
 <20200224065414.36524-4-zhang.zhanghailiang@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 27 Feb 2020 19:37:59 +0100
Message-ID: <87v9nrc1vc.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: danielcho@qnap.com, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

zhanghailiang <zhang.zhanghailiang@huawei.com> wrote:
> This helper has been called twice which is wrong.
> Left the one where called while get COLO enable message
> from source side.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


