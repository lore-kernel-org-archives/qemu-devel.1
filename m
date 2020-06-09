Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9BEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4515A20774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DY+sBNxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4515A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihzC-00024s-Fp
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jihc0-0001Yp-D4
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:00:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23666
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jihby-0007CM-30
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Spz2f+SUk5AefDAFfHDgkwritikWtaoW508X2LhDCLA=;
 b=DY+sBNxUyVcAUYcNqYadxCv1mOIxytbjpFai4OGkMoeVYDP06NmHWmVZaLVyNbnJQYX1sh
 BujuA2O+HNybutPnBfuk6zbSBa1LYbh14Q9MjJ5UtpfoJVvXFpGXR4aGeAAgv79j+m8S9c
 O2OIyDFiCmmb2SWcxE2ReOZMkAkeNJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-DiGThF0CNKyGb-CR_Ei94Q-1; Tue, 09 Jun 2020 13:00:26 -0400
X-MC-Unique: DiGThF0CNKyGb-CR_Ei94Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F6D21800D42;
 Tue,  9 Jun 2020 17:00:24 +0000 (UTC)
Received: from work-vm (ovpn-115-12.ams2.redhat.com [10.36.115.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E501819D61;
 Tue,  9 Jun 2020 17:00:20 +0000 (UTC)
Date: Tue, 9 Jun 2020 18:00:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL 3/9] tests/migration: Reduce autoconverge initial bandwidth
Message-ID: <20200609170017.GD2841@work-vm>
References: <20200325131632.311034-1-dgilbert@redhat.com>
 <20200325131632.311034-4-dgilbert@redhat.com>
 <20200609123323-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200609123323-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: vsementsov@virtuozzo.com, maozhongyi@cmss.chinamobile.com,
 pannengyuan@huawei.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Wed, Mar 25, 2020 at 01:16:26PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> > 
> > When using max-bandwidth=~100Mb/s, this test fails on Travis-CI
> > s390x when configured with --disable-tcg:
> > 
> >   $ make check-qtest
> >     TEST    check-qtest-s390x: tests/qtest/boot-serial-test
> >   qemu-system-s390x: -accel tcg: invalid accelerator tcg
> >   qemu-system-s390x: falling back to KVM
> >     TEST    check-qtest-s390x: tests/qtest/pxe-test
> >     TEST    check-qtest-s390x: tests/qtest/test-netfilter
> >     TEST    check-qtest-s390x: tests/qtest/test-filter-mirror
> >     TEST    check-qtest-s390x: tests/qtest/test-filter-redirector
> >     TEST    check-qtest-s390x: tests/qtest/drive_del-test
> >     TEST    check-qtest-s390x: tests/qtest/device-plug-test
> >     TEST    check-qtest-s390x: tests/qtest/virtio-ccw-test
> >     TEST    check-qtest-s390x: tests/qtest/cpu-plug-test
> >     TEST    check-qtest-s390x: tests/qtest/migration-test
> >   **
> >   ERROR:tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'got_stop' should be FALSE
> >   ERROR - Bail out! ERROR:tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'got_stop' should be FALSE
> >   make: *** [tests/Makefile.include:633: check-qtest-s390x] Error 1
> > 
> > Per David Gilbert, "it could just be the writing is slow on s390
> > and the migration thread fast; in which case the autocomplete
> > wouldn't be needed. Perhaps we just need to reduce the bandwidth
> > limit."
> > 
> > Tuning the threshold by reducing the initial bandwidth makes the
> > autoconverge test pass.
> > 
> > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> > Message-Id: <20200323184015.11565-1-philmd@redhat.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Tested-by: Alex BennÃ©e <alex.bennee@linaro.org>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> 
> This slows make check down significantly for me, it stays
> at the migration test for minutes.

Is this on the s390x version or all of them?

> I'm carrying a revert at top of my tree for now but I'd rather
> not need that.
> 
> 
> This seems like a fragile way to test things anyway.
> What happens if someone slows writing even more
> e.g. because it's running in a container or a VM?
> 
> How about detecting that migration finished too early
> and slowing it down until autocomplete triggers?

THe problem is you can't rely on any form of consistency in a heavily
contended container, so the fact that it took n-seconds to migrate at
this attempt means very little about what the next attempt will take.

Dave

> 
> 
> > ---
> >  tests/qtest/migration-test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > index 3d6cc83b88..2568c9529c 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
> >       * without throttling.
> >       */
> >      migrate_set_parameter_int(from, "downtime-limit", 1);
> > -    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
> > +    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
> >  
> >      /* To check remaining size after precopy */
> >      migrate_set_capability(from, "pause-before-switchover", true);
> > -- 
> > 2.25.1
> > 
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


