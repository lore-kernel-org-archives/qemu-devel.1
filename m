Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110BEC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9912225D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvWFbYgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9912225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQp29-0006Yq-BU
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 05:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQp1E-00062f-HM
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQp1B-0006Ra-BI
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602236932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zlVLaQtoHTam43g0YQl/7cQ7LS0Sjon5MkHA1194Y6g=;
 b=RvWFbYgRaOAQZq0tQBZVnUt5ZEBqPibX80Df/ufDRX3zCj4/zohHrSfw2XzxaSeOwfwQ2d
 qoMLvvnWB6NmpeJUg2hORTfDezVXjJLq2ErEO5MT30Ht/OQVOP7FdiGGhGJQXUPb9GuMqE
 RnZCVGRdPFZZIWTckaowd/Nn06Bg/+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-Bzuc6CheOyqKyuw-iRI4RQ-1; Fri, 09 Oct 2020 05:48:50 -0400
X-MC-Unique: Bzuc6CheOyqKyuw-iRI4RQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4615487505F;
 Fri,  9 Oct 2020 09:48:49 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-224.ams2.redhat.com [10.36.113.224])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE8E15D9E8;
 Fri,  9 Oct 2020 09:48:47 +0000 (UTC)
Date: Fri, 9 Oct 2020 11:48:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v8 07/17] qemu-iotests, qtest: rewrite test 067 as a qtest
Message-ID: <20201009094846.GB5109@linux.fritz.box>
References: <20201007115700.707938-1-pbonzini@redhat.com>
 <20201007115700.707938-8-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201007115700.707938-8-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.10.2020 um 13:56 hat Paolo Bonzini geschrieben:
> Test 067 from qemu-iotests is executing QMP commands to hotplug
> and hot-unplug disks, devices and blockdevs.  Because the power
> of the text-based test harness is limited, it is actually limiting
> the checks that it does, for example by skipping DEVICE_DELETED
> events.
> 
> tests/qtest already has a similar test, drive_del-test.c.
> We can merge them, and even reuse some of the existing code in
> drive_del-test.c, and improve the quality of the test by
> covering DEVICE_DELETED events.  The only difference is that
> the new test will always use null-co:// for the medium
> rather than qcow2 or raw, but this should be irrelevant
> for what the test is covering.  For example there are
> no "qemu-img check" runs in 067 that would check that
> the file is properly closed.
> 
> The new tests requires PCI hot-plug support, so drive_del-test
> is moved from qemu-system-ppc to qemu-system-ppc64.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

As discussed on IRC, I'm not a big fan of moving QMP tests that don't
make use of the qtest protocol at all to C unit tests (nothing in
drive_del_test makes use of the qtest protocol, neither before nor after
this patch). It's generally harder to write this kind of tests in C than
in Python, and assertion based tests are harder to debug than reference
output based ones.

There is one argument why this should be a qtest, which is that qtests
are run for multitple guest architectures while iotests run only for the
first architecture we found. I'm not sure if it's a good argument, but I
can't completely dismiss it.

The commit message should mention this argument, though.

In the future, I think iotests should be extended to provide the
necessary infrastructure to run tests on several architectures, and then
this should be converted to a Python iotest.

> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 9e4f7c0153..0d31fda111 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -88,7 +88,6 @@
>  064 rw quick
>  065 rw quick
>  066 rw auto quick
> -067 rw quick
>  068 rw quick
>  069 rw auto quick
>  070 rw quick

Please keep a comment that 067 shouldn't be reused, like we do for some
other cases. (It only causes merge conflicts for downstreams.)

> +static void test_empty_device_del(void)
> +{
> +    QTestState *qts;
> +
> +    /* device_del with no drive plugged.  */
> +    qts = qtest_initf("-device virtio-scsi-%s -device scsi-cd,id=dev0",
> +                      qvirtio_get_dev_type());
> +
> +    device_del(qts, false);
> +    qtest_quit(qts);
> +}

067 tested reset and query-block after this. Is the removal intentional?

Other than these, the conversion looks correct. I'm not convinced that
doing it is a step in the right direction, but with these two things
fixed, you can add:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


