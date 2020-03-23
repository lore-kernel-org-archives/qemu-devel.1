Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCE5C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA23B2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDufmMM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA23B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGTE3-0007mT-TN
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 15:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jGTDM-00079h-5y
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jGTDL-0001kA-2A
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:58:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40555)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jGTDK-0001jm-V3
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584993502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9kIzDXXtlINe/+Atp6GUjlV5OCetXDIKJYJB1tDydw=;
 b=NDufmMM5sqQAlr8bzhEUtp7uYqyQdTbYfS7o4ZBDx/v0Vm1OVox+o+z2GBeNuZg/rYhwxW
 yiiLaruQM8nKBzg/WMbHAX3tMp0ccoRG4XKquWVIPgQAhETkO3KCbZUZ9qygkH9YYT0LAY
 AsfRBO8/EOAejxCtMMl+txZk/ewmOwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-8TqyEUwOPJCzcLxRS7ZgdQ-1; Mon, 23 Mar 2020 15:58:18 -0400
X-MC-Unique: 8TqyEUwOPJCzcLxRS7ZgdQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69C1BA0CC0;
 Mon, 23 Mar 2020 19:58:17 +0000 (UTC)
Received: from work-vm (ovpn-112-29.ams2.redhat.com [10.36.112.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 932FA9B932;
 Mon, 23 Mar 2020 19:58:12 +0000 (UTC)
Date: Mon, 23 Mar 2020 19:58:10 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 v3] tests/migration: Reduce autoconverge initial
 bandwidth
Message-ID: <20200323195810.GI3017@work-vm>
References: <20200323184015.11565-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200323184015.11565-1-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> When using max-bandwidth=3D~100Mb/s, this test fails on Travis-CI
> s390x when configured with --disable-tcg:
>=20
>   $ make check-qtest
>     TEST    check-qtest-s390x: tests/qtest/boot-serial-test
>   qemu-system-s390x: -accel tcg: invalid accelerator tcg
>   qemu-system-s390x: falling back to KVM
>     TEST    check-qtest-s390x: tests/qtest/pxe-test
>     TEST    check-qtest-s390x: tests/qtest/test-netfilter
>     TEST    check-qtest-s390x: tests/qtest/test-filter-mirror
>     TEST    check-qtest-s390x: tests/qtest/test-filter-redirector
>     TEST    check-qtest-s390x: tests/qtest/drive_del-test
>     TEST    check-qtest-s390x: tests/qtest/device-plug-test
>     TEST    check-qtest-s390x: tests/qtest/virtio-ccw-test
>     TEST    check-qtest-s390x: tests/qtest/cpu-plug-test
>     TEST    check-qtest-s390x: tests/qtest/migration-test
>   **
>   ERROR:tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'go=
t_stop' should be FALSE
>   ERROR - Bail out! ERROR:tests/qtest/migration-test.c:1229:test_migrate_=
auto_converge: 'got_stop' should be FALSE
>   make: *** [tests/Makefile.include:633: check-qtest-s390x] Error 1
>=20
> Per David Gilbert, "it could just be the writing is slow on s390
> and the migration thread fast; in which case the autocomplete
> wouldn't be needed. Perhaps we just need to reduce the bandwidth
> limit."
>=20
> Tuning the threshold by reducing the initial bandwidth makes the
> autoconverge test pass.
>=20
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

This is what I'm expecting to help, so if it passes testing lets try it.

'got_stop' being true just indicates the migration managed to complete.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
> v3: really reduce =3D)
> ---
>  tests/qtest/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 3d6cc83b88..2568c9529c 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
>       * without throttling.
>       */
>      migrate_set_parameter_int(from, "downtime-limit", 1);
> -    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100=
Mb/s */
> +    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s=
 */
> =20
>      /* To check remaining size after precopy */
>      migrate_set_capability(from, "pause-before-switchover", true);
> --=20
> 2.21.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


