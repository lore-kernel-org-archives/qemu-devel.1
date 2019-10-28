Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C01CA9EBC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1517B20873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7wNa9Kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1517B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP1wL-0005p2-8O
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 06:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iP1vE-0005IB-Cz
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iP1vC-000437-S8
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:06:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iP1vC-00041x-Og
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572257205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+uUZMKBW+x5CKLMowSqg75mZzEIfdofCH7sxfPylzTc=;
 b=H7wNa9KjuN/M1ZNKwzysRifFXh6VR6NW1Pfl/uBGkFQswvqfh3uJMrNtqqgA2TMd+7ThLb
 /SlrsMBiCuWqbOpuKkpV4yEtlre2x1HYVD3VTbmMbUKZ2tOSQ0q6rXApO9W7u2op1OwQ7J
 5f2KSvH1uwS3TTK1yhUbTjPKD+KOgJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-lqm6FnorPdi6F2TqzXY06w-1; Mon, 28 Oct 2019 06:06:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 764D15E8;
 Mon, 28 Oct 2019 10:06:40 +0000 (UTC)
Received: from [10.3.116.125] (ovpn-116-125.phx2.redhat.com [10.3.116.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11BD35C1D6;
 Mon, 28 Oct 2019 10:06:38 +0000 (UTC)
Subject: Re: [PATCH] iotests: Test nbd client reconnect
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1572187725-685325-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8acd5c43-adcb-eff5-aa87-030d57216a5e@redhat.com>
Date: Mon, 28 Oct 2019 08:55:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1572187725-685325-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: lqm6FnorPdi6F2TqzXY06w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/19 3:48 PM, Andrey Shinkevich wrote:
> The stress test for an NBD client. The NBD server is disconnected after
> a client write operation. The NBD client should reconnect and retry the
> operation.
>=20
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/277     | 91 +++++++++++++++++++++++++++++++++++++++=
+++++++
>   tests/qemu-iotests/277.out |  7 ++++
>   tests/qemu-iotests/group   |  1 +
>   3 files changed, 99 insertions(+)
>   create mode 100755 tests/qemu-iotests/277
>   create mode 100644 tests/qemu-iotests/277.out

How does this differ from 264?  If it adds anything new, can it be=20
merged into the existing test?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


