Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07435C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60EB2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eS2JEkfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60EB2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEw08-0001Nm-Pr
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 10:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jEvzK-0000a0-Tc
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jEvzI-00076j-1m
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:17:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51015)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jEvzG-000755-Iu
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584627449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxWAHYhZDe9XHoK1UjIs4KL+3FKzl7JdL1wm4si9IS4=;
 b=eS2JEkfp5dHJqyyKutaUyt66t/9xslvzBqfyA+czW4jA0Lb9TCbRJZOdzyvy9bR7iFje4S
 z+XpsUtJRH+iB76c5pmZQFKOotXsc8I2q/Dvg5KLNj4KR4pmTPAvoRRzwZN1Jb+PL72b2H
 0CYpz/mQSdmDwcM8aSTgtXPynJOgAs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-RT5gb8wHNC2sCXaH_3AhOA-1; Thu, 19 Mar 2020 10:17:27 -0400
X-MC-Unique: RT5gb8wHNC2sCXaH_3AhOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 872DC800D5C;
 Thu, 19 Mar 2020 14:17:25 +0000 (UTC)
Received: from work-vm (ovpn-113-31.ams2.redhat.com [10.36.113.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24D10100164D;
 Thu, 19 Mar 2020 14:17:19 +0000 (UTC)
Date: Thu, 19 Mar 2020 14:17:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 v2 3/4] tests/migration: Reduce autoconverge
 initial bandwidth
Message-ID: <20200319141717.GC2833@work-vm>
References: <20200318222717.24676-1-philmd@redhat.com>
 <20200318222717.24676-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200318222717.24676-4-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
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
> ---
>  tests/qtest/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 3d6cc83b88..727a97cf87 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
>       * without throttling.
>       */
>      migrate_set_parameter_int(from, "downtime-limit", 1);
> -    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100=
Mb/s */
> +    migrate_set_parameter_int(from, "max-bandwidth", 10000000000); /* ~1=
0Gb/s */


Hmm - I was expecting you to need to *reduce* the speed;
now I'm very confused.
You should get 'stop' if the migration completed too soon - surely
incresing the bandwidth would make that *more* likely to happen.

Dave


>      /* To check remaining size after precopy */
>      migrate_set_capability(from, "pause-before-switchover", true);
> --=20
> 2.21.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


