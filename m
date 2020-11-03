Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C9EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D5272080D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEFgaGjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5272080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzjf-0001bq-G9
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZzgT-00067l-Sg
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZzgO-0008Fh-I6
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604422878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DYfZ9cjm0QflG3ChqOKSLNxpczjBPSLYd00UEPN52q0=;
 b=XEFgaGjTTXCfmnqRCumWasmXRk+XlDQQwkj+NiDmJhNF+KFNNC0uD9Af3MOvl6KT+5vUpL
 o9D+C1EDpj1UqWAsMjz5jxxAesmbuhbpev/FLpe6zf2usLxAZkENP+N0XY9mxX7bntJkyt
 EwRoydKfqt+Nha9OH+r0Axt+T88C0WY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-fB2X-4IvPtWTHlTYdrbGlg-1; Tue, 03 Nov 2020 12:01:16 -0500
X-MC-Unique: fB2X-4IvPtWTHlTYdrbGlg-1
Received: by mail-wm1-f72.google.com with SMTP id c204so5058wmd.5
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 09:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DYfZ9cjm0QflG3ChqOKSLNxpczjBPSLYd00UEPN52q0=;
 b=ul8pvwXKR16RXlHDemK1Pj4A8mBOGwoPTOhy8aDP3o5nPj4fXe6x5jQ1srmRlqweO9
 SL/K/rzJnAN7/QWqpsOIhy1SPr/GAvd6QFfHQRgxkTywjzJH+NTbCCqub3LErfYepLDx
 OKwalQbvNwwGyxqwXRYCUexnssEl9Wvocz5Oty8HlTgP50Py1CLP7csl10S25EQZpzwx
 nyP7uRq2sIcR/CdTbBaeUZhEmNYKYhO9Kfu++ydlUvuYEvq3+iBxT126Hofbde/NZ6Le
 BiMeeN/MtMDPykQ1cuMNN+6rj9jGt3d/BdRS8tUdknFe2n9o6nAAK1lmE0IaZEngF7WK
 fH/A==
X-Gm-Message-State: AOAM5300R3COtvLo7mhCNxxXMvHHbMHCrUwR5Er0HytuyXwmrRyzAfdD
 pAtE1ecV+fxjgFWwTB77jWSWOLtESY+1hMLbZUZGIEmTsfdhNjjbWNiInld8nCTOSFFq9iKdl9y
 5GqIWqbVtjv54mxA=
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr29209004wrh.213.1604422875453; 
 Tue, 03 Nov 2020 09:01:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEAdwipoyKoSNOAH8LJMmbkRmnjMPV0ZqFaKi798xLjBoVN5OvvOMv7OzHq371dMFPVLOO8w==
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr29208960wrh.213.1604422875141; 
 Tue, 03 Nov 2020 09:01:15 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y200sm4003662wmc.23.2020.11.03.09.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 09:01:14 -0800 (PST)
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
 <20201103165247.GT205187@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7654e063-98d3-84e0-8116-5a1b41d14636@redhat.com>
Date: Tue, 3 Nov 2020 18:01:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103165247.GT205187@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 5:52 PM, Daniel P. Berrangé wrote:
> On Tue, Nov 03, 2020 at 05:46:03PM +0100, Philippe Mathieu-Daudé wrote:
>> We test './configure --without-default-devices' since commit
>> 20885b5b169 (".travis.yml: test that no-default-device builds
>> do not regress") in Travis-CI.
>>
>> As we prefer to use GitLab-CI, add the equivalent job there.
>>
>> One minor difference: the GitLab Ubuntu docker image has the
>> Xen devel packages installed. As it is automatically selected,
>> we need to disable it with the --disable-xen option, else the
>> build fails:
>>
>>   /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in function `xen_be_register_common':
>>   hw/xen/xen-legacy-backend.c:754: undefined reference to `xen_9pfs_ops'
>>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undefined reference to `local_ops'
>>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): undefined reference to `synth_ops'
>>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): undefined reference to `proxy_ops'
>>   collect2: error: ld returned 1 exit status
> 
> Surely this is a build bug we need to fix rather than ignore in CI ?

Well it predates this series, so nobody really cared
(thus I wonder if it makes sense to invest resources
there).

Anyway I can have a look after 5.2-rc1.


