Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E1BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 11:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5587E206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 11:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4YDuXgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5587E206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k55nl-0006He-KR
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 07:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k55mk-0005gS-Me
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 07:16:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60548
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k55mj-0000Ds-4q
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 07:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597058168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yN7M5RaYVxQm+1Q6dPuZl4UHUL4fDobprbh/F1tMKk=;
 b=Q4YDuXgYiwTvHEeyED3SLsAstWTMNLkf+qlHxQrzPs1+cc6wFOGD2pb5loS3acJrWmnR7U
 mnTg8doAi1B/FC5zyGOvFKl1CDoJofF7t+l8QXb9sD8QPQd4epaEe0JTJg9hEdRbv8j6on
 EFg4IsWaSAmd2a6DXivry2RbdocH/8A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-IaSFnhz1OVajDfk52rvE7A-1; Mon, 10 Aug 2020 07:16:06 -0400
X-MC-Unique: IaSFnhz1OVajDfk52rvE7A-1
Received: by mail-wr1-f72.google.com with SMTP id d6so4075635wrv.23
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 04:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4yN7M5RaYVxQm+1Q6dPuZl4UHUL4fDobprbh/F1tMKk=;
 b=WETcqjJmU4DLmmPDZmgp/Rxqrx1YoWTeaLl95w/LuLeulBtX7Jlc4wXC6qJNDhoTls
 KYBF6zrSb4IMuMK9+gbLnBXKLZ0izMiCi4cHa3RuyY8L2NAeTPPMcfHuZviH/q9+tItJ
 23RtMerv8qylxTau2gx69SlQZWYD0DSzauZyEbSxRduAARtm9ogsNCF66sO1EWJyelET
 lXmuAZ7tVpsdVKs0e0MSx6GZ8X3vCMm0mCK3bUhPdYPJqWgP6Q51lNFYMQmxGfWM8s6/
 JUZnt9EDi/aH+QvVd8Gts1F587/+cmKZHi7egpqagDQyIQQGbsxeqd78iX9j83eGvM4D
 1xsg==
X-Gm-Message-State: AOAM532lfPMyKYxFzGa3sbt0GW0+1DyCVXHg/LI50GTf5oi+h9k/BSng
 LMK8ogQwuTuNZSklSyYG3ihR3spHMC9P7+ZzvFGCrxsW2eIiDkfO8YnVjeVGeR9p3cksOPV2nqg
 y7cjqLb44UFAMsT0=
X-Received: by 2002:adf:de8d:: with SMTP id w13mr23705219wrl.129.1597058165175; 
 Mon, 10 Aug 2020 04:16:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwTwwcw2UZ3F5hhk9pZ6U0Hs00m+njx2VTsuYwS65LVTUSRMpm+6Zs/0dt3SqC+SZo6229Fg==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr23705197wrl.129.1597058164959; 
 Mon, 10 Aug 2020 04:16:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103?
 ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id f16sm18954215wro.34.2020.08.10.04.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 04:16:04 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Cornelia Huck <cohuck@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <20200807085302.7d7616df.cohuck@redhat.com>
 <499b18ae-b15d-abbb-faf5-d9bdd5262fa4@redhat.com>
 <20200807113557.178825af.cohuck@redhat.com>
 <20200807142021.53967299.cohuck@redhat.com>
 <9b8cacc4-e60e-d436-4666-1457ec68e510@redhat.com>
 <20200810115851.36c21729.cohuck@redhat.com>
 <20200810120432.10b5176e.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5fec94b6-4ef3-39b2-6bab-63b88434b8d2@redhat.com>
Date: Mon, 10 Aug 2020 13:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200810120432.10b5176e.cohuck@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 05:06:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, alex.bennee@linaro.org,
 stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/20 12:04, Cornelia Huck wrote:
> 'make check' is unhappy, however:
> 
> Running test qtest-s390x: device-introspect-test
> missing object type 'virtio-gpu-device'
> Broken pipe
> ../tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> ERROR qtest-s390x: device-introspect-test - too few tests run (expected 6, got 5)

It could be an unnecessary dependency on virgl that was detected by the GitLab CI:

diff --git a/hw/display/meson.build b/hw/display/meson.build
index ffcccc0..fa4f806 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -77,7 +77,7 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
   #hw_display_modules += [[ 'virtio-gpu', virtio_gpu.sources(), [pixman, virgl],
   #                         ['CONFIG_VIRTIO_GPU']]]
 
-  softmmu_ss.add_all(when: [pixman, virgl, 'CONFIG_VIRTIO_GPU'],
+  softmmu_ss.add_all(when: [pixman, 'CONFIG_VIRTIO_GPU'],
                      if_true: virtio_gpu_ss)
 endif
 

In any case I'll post another version today or tomorrow.  (I decided to bite the
bullet, include the unit tests conversion and get rid of more Makefile gunk).

Paolo


