Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E19C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AA1214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPiF5cKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AA1214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT12n-0001Rh-PE
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iT11h-0000dc-CO
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iT11g-0001rQ-2b
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:57:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27893
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iT11f-0001qh-VW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573207074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weepwUGiED/puLTNQqDTFbnV60Gc/fsDN1dvqL6Dygo=;
 b=PPiF5cKLNY36gVC4/1hLfvLQdb3Q/NlYvGTL+P4fJ3646jr6KeDYKA9IjYWKjCxpJNA++q
 LYBuIs6+QWJW5nTn8bh5ZUDq4c0Erhzs37XkFxK66u7B9wEck/Y0pNP+OMhzwX5z/hrmAL
 zPt2eOSaqfHWFqSsLZ9/bbiH32B5pbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-NfZW-_1WOV6wRVVYAgWoxg-1; Fri, 08 Nov 2019 04:57:51 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA3871800D7B
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-167.ams2.redhat.com
 [10.36.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC4045DA7F;
 Fri,  8 Nov 2019 09:57:41 +0000 (UTC)
Subject: Re: [PATCH 0/3] Some memory leak fixes
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
References: <157316385831.31898.8575258200533586465@37313f22b938>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0d0e067f-4354-1486-8910-35a2ff1bb5d0@redhat.com>
Date: Fri, 8 Nov 2019 10:57:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <157316385831.31898.8575258200533586465@37313f22b938>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: NfZW-_1WOV6wRVVYAgWoxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: lvivier@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/11/2019 22.57, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191107192731.17330-1-marcandre.lu=
reau@redhat.com/
>=20
> Hi,
>=20
> This series failed the docker-quick@centos7 build test. Please find the t=
esting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> make docker-image-centos7 V=3D1 NETWORK=3D1
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>    TEST    check-unit: tests/test-thread-pool
>    TEST    check-unit: tests/test-hbitmap
> **
> ERROR:/tmp/qemu-test/src/tests/migration-test.c:903:wait_for_migration_fa=
il: assertion failed: (!strcmp(status, "setup") || !strcmp(status, "failed"=
) || (allow_active && !strcmp(status, "active")))
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/migration-test.c:903:wai=
t_for_migration_fail: assertion failed: (!strcmp(status, "setup") || !strcm=
p(status, "failed") || (allow_active && !strcmp(status, "active")))

I assume this is unrelated to your patches and a generic Patchew problem=20
instead?

  Thomas


