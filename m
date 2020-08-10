Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D01C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF0B22BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4uCOXpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF0B22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DRX-00032X-1T
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5DQq-0002ck-I8
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:26:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50794
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5DQo-0002G0-QO
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597087561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/v3H1JR4hUF5h7ZJzucrmwtWbFjK4d7NDDM5DTLVQg=;
 b=D4uCOXpcQm33p6AIZ07ELyGOJlvycmV6DlN+hLkoj69hOKuZx7O2CoashiLirMiphPXdEw
 GJCCaeoSb3xRd1fJwgmCBDeoFPBIwEHY0uO8rcHlIqa/Fe3+aQsRa6n684vlA0/NhlvwSo
 RVh+01SuV4Lzfk0OIyHygVFyi9sFiu8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-5KAHTA_GN-mmbdmmlPA_FQ-1; Mon, 10 Aug 2020 15:25:59 -0400
X-MC-Unique: 5KAHTA_GN-mmbdmmlPA_FQ-1
Received: by mail-wr1-f69.google.com with SMTP id k11so4586348wrv.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L/v3H1JR4hUF5h7ZJzucrmwtWbFjK4d7NDDM5DTLVQg=;
 b=DlXtjM3uSgSbxWHuWs6ebSz7JrW3U0aDaOst4TVQFN/0khWAiUs5DHytyhDwadiWmo
 DY8IiXIhP9TCPMGfFAwKJ5PlsYpar11RDLzPKLk0bUlHMJpLHpwfbKO3UBsXo5+4l1qp
 f0R8L81+JxpF/Gn7+j7wcqNbZJYbb+3SycL43AmHLat+ABDW3NwU+6/oriGqWXBvb9te
 vzIYYF8JflGptv3UP8H1CuRWFMR51cDcLlCpPgYiFMtmXU9+QWWxc0MwaNwkpZ9cBC5a
 R6ljNcFrg5e2rsQIns4YfxfHqJgEn3FsIb5AbMCqIT5oRLpwogS8dUkQht/Sp/0g5rgY
 txvg==
X-Gm-Message-State: AOAM531qAiBB5UTG4MnLyhjOyqVKoU01Of6Tly2SjSTnKrHN+a0QusmK
 QD51Oyw9xw9LFgpKyVwNHN65Hr+nowtTnpJZksr3E0knbto5h14uT4OUyMXWpKxR116Pw21vpkW
 Ynf3WfIVGBbEq2XU=
X-Received: by 2002:a1c:bd56:: with SMTP id n83mr653018wmf.64.1597087558517;
 Mon, 10 Aug 2020 12:25:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQ8KPxMV14XqaCS0DAcPg3iAVFb4S1e9tq5SCv8J18z9CXxe5XvAUVyFNpuesYVYh1H0IuBw==
X-Received: by 2002:a1c:bd56:: with SMTP id n83mr653000wmf.64.1597087558287;
 Mon, 10 Aug 2020 12:25:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103?
 ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id f16sm20694417wro.34.2020.08.10.12.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 12:25:57 -0700 (PDT)
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Peter Maydell <peter.maydell@linaro.org>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6549f29d-f38b-0fc5-8310-e9cbedba3080@redhat.com>
Date: Mon, 10 Aug 2020 21:25:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 15:26:01
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/20 20:09, Peter Maydell wrote:
> ModuleNotFoundError: No module named 'pkg_resources'
> 
> ERROR: meson setup failed

Missing dependency, you have to install python3-setuptools.  But it will 
fail just as aarch64 due to the same incorrect line.

> make: *** Deleting file 'config-host.mak'
> make: *** No rule to make target 'config-host.mak', needed by
> 'meson-private/coredata.dat'.  Stop.
> make: Leaving directory '/home/peter.maydell/qemu/build/all-a32'
> 
> 
> Build failure, aarch64:
> 
> Program scripts/grepy.sh found: YES
> Configuring config-all-devices.mak with command
> Program scripts/hxtool found: YES
> Program scripts/shaderinclude.pl found: YES
> Program scripts/qapi-gen.py found: YES
> Program scripts/tracetool.py found: YES
> Program scripts/qemu-version.sh found: YES
> Program keycodemapdb/tools/keymap-gen found: YES
> Program scripts/decodetree.py found: YES
> Program ../scripts/modules/module_block.py found: YES
> Program nm found: YES
> Program scripts/undefsym.sh found: YES
> Program scripts/feature_to_c.sh found: YES
> Program scripts/tracetool.py found: YES
> 
> ../../meson.build:969:2: ERROR: File kvm64.c does not exist.
> 
> A full log can be found at /home/pm/qemu/build/all/meson-logs/meson-log.txt

My bug, fixed thusly:

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 056223a..bd46cdb 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -34,7 +34,7 @@ arm_ss.add(zlib)
 arm_ss.add(when: 'CONFIG_TCG', if_true: files('arm-semi.c'))
 
 kvm_ss = ss.source_set()
-kvm_ss.add(when: 'TARGET_AARCH64', if_true: 'kvm64.c', if_false: 'kvm32.c')
+kvm_ss.add(when: 'TARGET_AARCH64', if_true: files('kvm64.c'), if_false: files('kvm32.c'))
 arm_ss.add_all(when: 'CONFIG_KVM', if_true: kvm_ss)
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
 

Paolo


