Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ADAC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CBFA2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUiWY3Ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBFA2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka3OR-0002p1-1O
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ka3NQ-0002KG-9T
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:58:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ka3NN-0002Re-AI
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604437073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXae1/NS+McPsw+jDQ8VzIlDFAYd3s+rEqSMmXxf7S8=;
 b=gUiWY3Ieg3mOHcfHfnrs4MUG/9ezrGY63TndUzbrSQRsQ4x+3wRNXRzkECCZF/xRBV0ld2
 jdCTAalh4TSqSjYYSZOIC060DrOCIruf2/v9MeuYKQogsHtXh+3AJnk6vqjiNq0qeylDZO
 Ifx0/iLWqGS5igH0zgsiMFQ3w6lm+h0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462--bHAZ3_-Mq2AyAOdLwLbtw-1; Tue, 03 Nov 2020 15:57:51 -0500
X-MC-Unique: -bHAZ3_-Mq2AyAOdLwLbtw-1
Received: by mail-pg1-f200.google.com with SMTP id s4so12000993pgk.17
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 12:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OXae1/NS+McPsw+jDQ8VzIlDFAYd3s+rEqSMmXxf7S8=;
 b=UTJGyavDO9wTbZTLp1AQWOk4CL0uy+9VX1QYYCPzHjemye4FS8DPKGWmxhfQ4b0vug
 W07m8xETlT+1n1MOXI8HC6aGi5wvZqIc4E67v1M+Rx0an6KgwxvqJRjNsB8uHjwE1MdM
 VGv0l7jiVDa3+ja6nBznZIr7BFcN3VdCAM/BwK7jpjIivHH5/6R+AeLUMEByVLM7uEOm
 RBSctynCpf6n814MG4PnlYvhpfdAtONK4Ppz1XutVubXrDjtJI0yJWjhOOcv3h5rKAdT
 6FGGTSR30974dKK5CiFkn1Pje3YoRobmPXjS7jMxyxliEaC+VZOqWx1Mwl7hRZX+uof5
 hHtg==
X-Gm-Message-State: AOAM532PnJLKUM8EwpjKpippEyzTkXlfhhCN8RK9Ed0RZO9CHTsbqYXJ
 B4TxxMYCp41kNQjFHRPe+g1JM8zbAd3pekhHgzSwPypUzAC/KNiVbRHwimBUYLoHAacUk+zKv10
 1QjQqum1yv+MiE3iJ5FOIRfJXtPO2uXc=
X-Received: by 2002:a63:ec0d:: with SMTP id j13mr2516215pgh.281.1604437070602; 
 Tue, 03 Nov 2020 12:57:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyan1ZLq+3aMCMyPrtIZv8u9Qk7eUxC5FVa8/K+V62pNCZHj1AcvvBmOVATg/sI3sKABoUmulcwjLQWr7QnMJE=
X-Received: by 2002:a63:ec0d:: with SMTP id j13mr2516187pgh.281.1604437070281; 
 Tue, 03 Nov 2020 12:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
 <20201103165247.GT205187@redhat.com>
 <7654e063-98d3-84e0-8116-5a1b41d14636@redhat.com>
In-Reply-To: <7654e063-98d3-84e0-8116-5a1b41d14636@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 3 Nov 2020 21:57:39 +0100
Message-ID: <CABgObfYN+_GsVS89oxRThCivox0F6BJ6XjM3d2gro85y-_17=g@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 3, 2020 at 6:01 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
> On 11/3/20 5:52 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Nov 03, 2020 at 05:46:03PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> We test './configure --without-default-devices' since commit
> >> 20885b5b169 (".travis.yml: test that no-default-device builds
> >> do not regress") in Travis-CI.
> >>
> >> One minor difference: the GitLab Ubuntu docker image has the
> >> Xen devel packages installed. As it is automatically selected,
> >> we need to disable it with the --disable-xen option, else the
> >> build fails:
> >>
> >>   /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in functi=
on `xen_be_register_common':
> >>   hw/xen/xen-legacy-backend.c:754: undefined reference to `xen_9pfs_op=
s'
> >>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): un=
defined reference to `local_ops'
> >>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): u=
ndefined reference to `synth_ops'
> >>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): u=
ndefined reference to `proxy_ops'

All these symbols are defined in hw/9pfs/meson.build's fs_ss, which is
conditional on CONFIG_9PFS. So:

diff --git a/accel/Kconfig b/accel/Kconfig
index 2ad94a3839..d24664d736 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -7,3 +7,4 @@ config KVM
 config XEN
     bool
     select FSDEV_9P if VIRTFS
+    select 9PFS if VIRTFS

or alternatively (and I think better):

diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
index d3ebd73730..3ae5749661 100644
--- a/hw/9pfs/Kconfig
+++ b/hw/9pfs/Kconfig
@@ -2,12 +2,8 @@ config FSDEV_9P
     bool
     depends on VIRTFS

-config 9PFS
-    bool
-
 config VIRTIO_9P
     bool
     default y
     depends on VIRTFS && VIRTIO
     select FSDEV_9P
-    select 9PFS
diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
index cc09426212..99be5d9119 100644
--- a/hw/9pfs/meson.build
+++ b/hw/9pfs/meson.build
@@ -15,6 +15,6 @@ fs_ss.add(files(
   'coxattr.c',
 ))
 fs_ss.add(when: 'CONFIG_XEN', if_true: files('xen-9p-backend.c'))
-softmmu_ss.add_all(when: 'CONFIG_9PFS', if_true: fs_ss)
+softmmu_ss.add_all(when: 'CONFIG_FSDEV_9P', if_true: fs_ss)

 specific_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-device=
.c'))

Paolo


