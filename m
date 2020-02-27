Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39806C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06EC3246A1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XD4sPJTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EC3246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7NW3-0006WK-94
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 13:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j7NVL-00063C-E7
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j7NVK-0000Ze-Fh
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:03:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40855
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j7NVK-0000YA-C2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582826602;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXcoFIKfdayPp5Ufj0uzs8sJ+k93gtb12lIAf/a5BIY=;
 b=XD4sPJTBeuKMOU4A7nuYE+dstaHE4aEHL5iUqSlH4rdvmuRx7pQYKi6zSYz+fedz9aGcqL
 r9uwSCwfYW25yd2wZuHhL05BtOgfszxoAJFTGUOslg1ff3Ybk3gBA4dimg6n4DM3CYmat0
 6cdPsjmNrh+Mdm6HHDZkq+ivFBAuUlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-xEpoaVMmOxWd3FwjgR43ow-1; Thu, 27 Feb 2020 13:03:16 -0500
X-MC-Unique: xEpoaVMmOxWd3FwjgR43ow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA55D100DFC4;
 Thu, 27 Feb 2020 18:03:14 +0000 (UTC)
Received: from redhat.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AAF55DA7B;
 Thu, 27 Feb 2020 18:03:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH v2] test-vmstate: Fix memleaks in test_load_qlist
In-Reply-To: <20200220134103.26224-1-kuhn.chenqun@huawei.com> (kuhn chenqun's
 message of "Thu, 20 Feb 2020 21:41:03 +0800")
References: <20200220134103.26224-1-kuhn.chenqun@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 27 Feb 2020 19:03:12 +0100
Message-ID: <87k147di1r.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, dgilbert@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

<kuhn.chenqun@huawei.com> wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
>
> There is memleak in test_load_qlist().It's not a big deal,
> but test-vmstate will fail if sanitizers is enabled.
>
> In addition, "ret" is written twice with the same value
>  in test_gtree_load_iommu().
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued


