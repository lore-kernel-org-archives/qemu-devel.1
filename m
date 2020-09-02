Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E2DC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003902065E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4CNm6uw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003902065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQ1K-0007MX-NX
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDPzf-00062b-6F
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDPzc-0004Gb-TN
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599042471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xbIfG6vUeEt5W8wW8UTuRXpr1fDL+Ojv/u1KCvupiFA=;
 b=B4CNm6uwiShxxnMXJeOmzf8iI9+2zVZ5oCrNDrGkavRFk1/was5fJzQT5W4T8CiekDk+eu
 2iwMQOQgyO/e5LOmzEWrdGunPJbExNbRvh1eNdmYGItAjaZzcbRrPSLgZDVHTw4ZDF/9dc
 ueGSzZicd2qikVanFO7E03Y3e1cKYEo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-Hkae1_ZCNMydFdFQr3zRIw-1; Wed, 02 Sep 2020 06:27:50 -0400
X-MC-Unique: Hkae1_ZCNMydFdFQr3zRIw-1
Received: by mail-wm1-f70.google.com with SMTP id s24so1467639wmh.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 03:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xbIfG6vUeEt5W8wW8UTuRXpr1fDL+Ojv/u1KCvupiFA=;
 b=N4TiuEzVAjpfSdqsyJKRNzySQ1fkomTOEI1sgN56GbQMamP+CV1vAF12KvKxdV2szt
 vwJj85XlouRjNeDEeXf9QeGmbjVISNOQ3VEBGILS3puR5a+/J8gCk1A7Y2ulEDRAN+IJ
 lElWzRuEUFFt4lrE9aCf5qkNJcz8948DmybrmEPpgE8NU4xmzcxNGQfZVzpyIX7bgLOy
 JLKzK/+owdIrdaHs2joy0aZzVfdFcc9hCfrDN1Cq6AQvhVsFgHRtVdZM6nau20KF4a4K
 MsHfQsK5dYNbmUqEedXgvHVcQYFycWsPT6cmt3mN22MwBzFF/JFPXxw2rgZPHfRi/fN6
 gbTA==
X-Gm-Message-State: AOAM531uKW5k9yq7dht9UUW5zQfwcTYQNL+7LPRSCk0nTIZmgbaFEY2E
 mzHPB8s8hSPfpoBm0PetgkJymDJSdrpghO1jkKhkcZ/IpwFDmDln2y/jHNz4xr93v43N7HXcskh
 RH3nLj5OGcl9Y+XY=
X-Received: by 2002:a05:600c:228e:: with SMTP id
 14mr6523425wmf.17.1599042468815; 
 Wed, 02 Sep 2020 03:27:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS348gPAURWVoyajTIN3yYQvnWXc9IpSWehvRc3GpgTu+9qwRGD6FjUPI+YoYF0sGQpHQ5Cg==
X-Received: by 2002:a05:600c:228e:: with SMTP id
 14mr6523410wmf.17.1599042468576; 
 Wed, 02 Sep 2020 03:27:48 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id 201sm6300411wma.27.2020.09.02.03.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 03:27:48 -0700 (PDT)
Subject: Re: meson build failure, configure without tcg, fixed by running make
 again
To: Claudio Fontana <cfontana@suse.de>
References: <c9971e27-fded-3e5d-d489-b1fb539b8ec1@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41c09bb2-1704-47c0-9638-9f1eff010e8c@redhat.com>
Date: Wed, 2 Sep 2020 12:27:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c9971e27-fded-3e5d-d489-b1fb539b8ec1@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 12:03, Claudio Fontana wrote:
> Hi Paolo,
> 
> there seems to be some parallelism or race condition somewhere?
> 
> with master, commit 8d90bfc5c31ad60f6049dd39be636b06bc00b652
> I am doing:
> 
> mkdir build-nontcg
> cd build-nontcg
> ../configure --disable-tcg --enable-kvm --enable-hax
> make -j120
> make -j120 check
> 
> I am getting:

Yes:

diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 19931b9248..268ea23803 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -52,6 +52,6 @@ libqos = static_library('qos',
         'arm-xilinx-zynq-a9-machine.c',
         'ppc64_pseries-machine.c',
         'x86_64_pc-machine.c',
-), build_by_default: false)
+) + genh, build_by_default: false)
 
 qos = declare_dependency(link_whole: libqos)

Paolo


