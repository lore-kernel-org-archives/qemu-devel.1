Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F74C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AEAE2068D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6KNlPld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEAE2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiilV-0002eN-Bi
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 14:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiii8-0006ub-0A
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 14:10:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29140
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiii6-0003dH-So
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 14:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591726253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PRO3RJ8//ad3L7+cHhE1QpBAJL4ZvonlG7wq8Uwk88o=;
 b=a6KNlPldJfdGnnzjZVQjioXpx/8lFzLxEGT+RqLRekgmTVJoSXjDfmsjTj4hgVrNwmU9kZ
 O+zQQkJ4McFjxA7ZwTfR/2T1AE0k8xIPO0I20shTQtEXKPykFjfUEjV5NRxVS2LKmMbcU1
 W8hTVL2DD9t83AyUwQRz0us+8j1G1Jw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-f6KzA5MvNkuBofg74l1zxg-1; Tue, 09 Jun 2020 14:10:52 -0400
X-MC-Unique: f6KzA5MvNkuBofg74l1zxg-1
Received: by mail-wr1-f71.google.com with SMTP id n6so8944830wrv.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 11:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=/sHXkGI8UwucoG4Qfr/gDTd9nQ+9Mczx7ITEFMiWIZ4=;
 b=IA+n1obCimrtiUEahVw0f1Hznlbxk1cu6AThOqQ8/wNc85NoMQG27trpEMxpG6yy4y
 B9XAO3yU8TACmjC9YzwU2hhKR7RzYX5gWg2KEQVg7WiAW2ZgPRT83IXepMtB1PNV+A4o
 wQ077NmhDdMT/yvm7cAex3o7JX0rm8wCLXblzi0gvG4KX16J7tgwt3M5MR3jiJMp1IU1
 6zBECwl+0UJHx1/9sE9tZ9/AeFajs930NTI1vuI5Aur+2jsb1eDaxnTkgHZy4bAOwXFD
 x4IGXh3lYZWGZFXp4uiMjPfSuin9P8D8DEbMXE3HmBzkkyogHyhNK0KCSZHccSBytjCN
 d74g==
X-Gm-Message-State: AOAM533pRH+hZ2Pdnv9w7PeWtyz+fPxBEuawXu/aaDWyWzB2QXQMq1aB
 mU9NRwoDU2Gjp0ZTUI/KxKqqW6mE5Aa1B7vabuGTIeHJy+wxxhViZiLVHFBDlmSUmmz27pF0ZiO
 Ek3K5Koi45fRH/I0=
X-Received: by 2002:adf:fe07:: with SMTP id n7mr5646339wrr.240.1591726251185; 
 Tue, 09 Jun 2020 11:10:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztMpaI1fKtcn5pGvvUdkMUsmXIRBqnEBBchG48hBjwn8Wcw+LY7OAXmpt9ITPAUnGeWD0rog==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr5646317wrr.240.1591726250950; 
 Tue, 09 Jun 2020 11:10:50 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id u13sm3587091wmm.6.2020.06.09.11.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 11:10:50 -0700 (PDT)
Date: Tue, 9 Jun 2020 14:10:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PULL 3/9] tests/migration: Reduce autoconverge initial bandwidth
Message-ID: <20200609141005-mutt-send-email-mst@kernel.org>
References: <20200325131632.311034-1-dgilbert@redhat.com>
 <20200325131632.311034-4-dgilbert@redhat.com>
 <20200609123323-mutt-send-email-mst@kernel.org>
 <20200609170017.GD2841@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200609170017.GD2841@work-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Tue, Jun 09, 2020 at 06:00:17PM +0100, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Wed, Mar 25, 2020 at 01:16:26PM +0000, Dr. David Alan Gilbert (git) wrote:
> > > From: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> > > 
> > > When using max-bandwidth=~100Mb/s, this test fails on Travis-CI
> > > s390x when configured with --disable-tcg:
> > > 
> > >   $ make check-qtest
> > >     TEST    check-qtest-s390x: tests/qtest/boot-serial-test
> > >   qemu-system-s390x: -accel tcg: invalid accelerator tcg
> > >   qemu-system-s390x: falling back to KVM
> > >     TEST    check-qtest-s390x: tests/qtest/pxe-test
> > >     TEST    check-qtest-s390x: tests/qtest/test-netfilter
> > >     TEST    check-qtest-s390x: tests/qtest/test-filter-mirror
> > >     TEST    check-qtest-s390x: tests/qtest/test-filter-redirector
> > >     TEST    check-qtest-s390x: tests/qtest/drive_del-test
> > >     TEST    check-qtest-s390x: tests/qtest/device-plug-test
> > >     TEST    check-qtest-s390x: tests/qtest/virtio-ccw-test
> > >     TEST    check-qtest-s390x: tests/qtest/cpu-plug-test
> > >     TEST    check-qtest-s390x: tests/qtest/migration-test
> > >   **
> > >   ERROR:tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'got_stop' should be FALSE
> > >   ERROR - Bail out! ERROR:tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'got_stop' should be FALSE
> > >   make: *** [tests/Makefile.include:633: check-qtest-s390x] Error 1
> > > 
> > > Per David Gilbert, "it could just be the writing is slow on s390
> > > and the migration thread fast; in which case the autocomplete
> > > wouldn't be needed. Perhaps we just need to reduce the bandwidth
> > > limit."
> > > 
> > > Tuning the threshold by reducing the initial bandwidth makes the
> > > autoconverge test pass.
> > > 
> > > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> > > Message-Id: <20200323184015.11565-1-philmd@redhat.com>
> > > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Tested-by: Alex BennÃ©e <alex.bennee@linaro.org>
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > 
> > 
> > This slows make check down significantly for me, it stays
> > at the migration test for minutes.
> 
> Is this on the s390x version or all of them?

x86 slows down for me.

> > I'm carrying a revert at top of my tree for now but I'd rather
> > not need that.
> > 
> > 
> > This seems like a fragile way to test things anyway.
> > What happens if someone slows writing even more
> > e.g. because it's running in a container or a VM?
> > 
> > How about detecting that migration finished too early
> > and slowing it down until autocomplete triggers?
> 
> THe problem is you can't rely on any form of consistency in a heavily
> contended container, so the fact that it took n-seconds to migrate at
> this attempt means very little about what the next attempt will take.
> 
> Dave

What I'm saying is try migrating quickly. If it's too quick
try again ...

> > 
> > 
> > > ---
> > >  tests/qtest/migration-test.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > > index 3d6cc83b88..2568c9529c 100644
> > > --- a/tests/qtest/migration-test.c
> > > +++ b/tests/qtest/migration-test.c
> > > @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
> > >       * without throttling.
> > >       */
> > >      migrate_set_parameter_int(from, "downtime-limit", 1);
> > > -    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
> > > +    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
> > >  
> > >      /* To check remaining size after precopy */
> > >      migrate_set_capability(from, "pause-before-switchover", true);
> > > -- 
> > > 2.25.1
> > > 
> > > 
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


