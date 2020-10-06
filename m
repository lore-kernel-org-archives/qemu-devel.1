Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDBAC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7CC20663
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYeOxHrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7CC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlyn-0005Hr-WA
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPlxc-0004c1-8j
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPlxa-0005ih-Bw
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601986849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yKhEI6hGtGyOexgkf0zZrKG4n1BUnGHKrFd2w5ttso0=;
 b=PYeOxHrJSWXmr8wiRP4Jld82FL+KwEPcLjFHrtIhN5/uF/NRaCipMGQCEp2BAprwfVT7S3
 qcCIr8/Gb+zpOe39WgAbp9df032mJ1AZ4QuuR64+oJsC3Jey0YTo9Ql25llWloMVf0GEy+
 sLYanFEao9c68mY2BUXL4pdXAAK2xf4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-y9IKYQSqNaudU-PKvXHG4w-1; Tue, 06 Oct 2020 08:20:47 -0400
X-MC-Unique: y9IKYQSqNaudU-PKvXHG4w-1
Received: by mail-wm1-f72.google.com with SMTP id c204so1046863wmd.5
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yKhEI6hGtGyOexgkf0zZrKG4n1BUnGHKrFd2w5ttso0=;
 b=UNIWpSiQJjIhN86apoeS1Rvled+Ilj7RU4e9RBhODq7JDVGQ0hggm/kel/mtOMgovc
 kFGHuZmTf5PHdTH4M0ZouvrC1UP1fNXbbUSt7EXIrjFGuddHYcoYCc0xFOVzeIS77Lti
 uUA4A04a8NJvT9U3lFScWTYU+gryvz/TPIjD5c9g7T6/5RlthDVQhXIXuADeMKD/M6S3
 SiIfBQWth2lDPP9c4isZM3v8tHyHpn/Atyodwc++QOktGOayD2PHy/mBa13hnWd3mHvS
 R2GQK+p8BlRkim412+W1BKNQ8vXEZYS31yT2yJ7JcSUdUq9RoUXzTAW9xrUszbKJn1ux
 PVzQ==
X-Gm-Message-State: AOAM5336ZJn6IVfQC4ZNWHsBzk4qv3r+2pkD/ewA29AoDInNOkJluRLn
 +aAJqcgc2yLyjtk5y3S8N2J6rnNCe7kdrfdrK8WbF3Dp3elHnp86W/Uh9Hkm12k02NM+eaNgCz4
 DmK4gDx5KxYEiBlE=
X-Received: by 2002:adf:e54f:: with SMTP id z15mr4460770wrm.136.1601986846544; 
 Tue, 06 Oct 2020 05:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDo75M2KqwF+Bh+oMKIb01HS6rlEHPK9hebSwilGjUlbCc3wB3ukyADYJnMvFvkQaT+68kEA==
X-Received: by 2002:adf:e54f:: with SMTP id z15mr4460740wrm.136.1601986846291; 
 Tue, 06 Oct 2020 05:20:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e?
 ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id q18sm4033897wre.78.2020.10.06.05.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 05:20:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] hw/nvram: Always register
 FW_CFG_DATA_GENERATOR_INTERFACE
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20201006111909.2302081-1-philmd@redhat.com>
 <20201006111909.2302081-2-philmd@redhat.com>
 <20201006121507.GE4202@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c36178f9-67f1-2d22-6537-15c73516cbbe@redhat.com>
Date: Tue, 6 Oct 2020 14:20:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006121507.GE4202@linux.fritz.box>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laszlo Ersek <lersek@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/20 14:15, Kevin Wolf wrote:
> Am 06.10.2020 um 13:19 hat Philippe Mathieu-DaudÃ© geschrieben:
>> While the FW_CFG_DATA_GENERATOR_INTERFACE is only consumed
>> by a device only available using system-mode (fw_cfg), it is
>> implemented by a crypto component (tls-cipher-suites) which
>> is always available when crypto is used.
>>
>> Commit 69699f3055 introduced the following error in the
>> qemu-storage-daemon binary:
>>
>>   $ echo -e \
>>     '{"execute": "qmp_capabilities"}\r\n{"execute": "qom-list-types"}\r\n{"execute": "quit"}\r\n' \
>>     | storage-daemon/qemu-storage-daemon --chardev stdio,id=qmp0  --monitor qmp0
>>   {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 5}, "package": ""}, "capabilities": ["oob"]}}
>>   {"return": {}}
>>   missing interface 'fw_cfg-data-generator' for object 'tls-creds'
>>   Aborted (core dumped)
>>
>> Since QOM dependencies are resolved at runtime, this issue
>> could not be triggered at linktime, and we don't have test
>> running the qemu-storage-daemon binary.
>>
>> Fix by always registering the QOM interface.
>>
>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>> Fixes: 69699f3055 ("crypto/tls-cipher-suites: Produce fw_cfg consumable blob")
>> Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> 
> This fails to build for me:
> 
> ../hw/nvram/meson.build:2:7: ERROR: Unknown method "add" in object.

It's

  Based-on: <20201006111219.2300921-1-philmd@redhat.com>

(which won't be applied in exactly that shape, but more or less it will
be the same).

Paolo


