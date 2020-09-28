Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E6EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3246D21531
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fm2aNXUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3246D21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMoej-0006YR-8n
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 04:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMoeA-00068h-2Z
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMoe8-0005xh-JE
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:36:33 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601282191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJEsPiEQGz38fiz+JXHv+Suv8lXrQZHW0XagmKp6dvE=;
 b=fm2aNXUnLIG3QvrE90zQp9c9/GNaEJh5Wj1K83ZQmrAi+rENvsU1yCh804+y+T8JDb6NOe
 ZZ1IhXCQxper9GHuuTTxWSQVrOQxZqczEV5PdU82j3vkRIVP1L9ZTKL7zxElRHe+DUa+qb
 zpo2e0a/XhuQU9uxD8dHX9TNm8TzQlQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-yfgGjquAPU-EuNbnskNHGw-1; Mon, 28 Sep 2020 04:36:29 -0400
X-MC-Unique: yfgGjquAPU-EuNbnskNHGw-1
Received: by mail-wm1-f70.google.com with SMTP id m125so99788wmm.7
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 01:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AJEsPiEQGz38fiz+JXHv+Suv8lXrQZHW0XagmKp6dvE=;
 b=qF3sXwktklTrIBTShCBsJ/Pr3J8Ob0nZ3x1+pcAERA9WvIc8zSelknk+YipdD0qlmU
 WoZT39YDuXL+YQq4pYwU7B4q+PMnCgcLCrLuk48DMllYqHaCWhC223X7XXdSNYYLNvcK
 77oCzUDRpuz9ZtWZCwFjnWESu/mqY1SulxeiBH6pdeFGysOHgByYuXIhuuEHRajGRS5Y
 TOL2VXLZApLRjywm6mF27Z90tdWjLphOBTyrGQki81Q1Sdf0KrogzUXWrm/4SeCMbxg1
 JKfjJCye9TTgERrv9M4iwPtjSRFbNYc3XROtWLD+3UjyQf3rR0EwCQKjFviKJBSCIk0z
 3Dpw==
X-Gm-Message-State: AOAM532imaSIvfnK+jLPZwt1fEBeMIeXHhgzIw9qrp0uNCXKXC0Pk0Pj
 wuLzm0yMhVR00+luPxGuGmjZuaX7jhZfRD5G6jfl6e0b67hHK4zjW97alpJbYxGU5KJRAeuSjAt
 tXpVivYTEkiXShn8=
X-Received: by 2002:a1c:26c3:: with SMTP id m186mr399937wmm.115.1601282188737; 
 Mon, 28 Sep 2020 01:36:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsoWYiVRi+XqAidoxUeG9RhaTQ6JX21QY2JYkhkYDuxnfSNrL0hZHSV9c0xHbQNAVx2Rl+ew==
X-Received: by 2002:a1c:26c3:: with SMTP id m186mr399917wmm.115.1601282188568; 
 Mon, 28 Sep 2020 01:36:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4f8:dc3e:26e3:38c7?
 ([2001:b07:6468:f312:f4f8:dc3e:26e3:38c7])
 by smtp.gmail.com with ESMTPSA id y68sm285355wmd.39.2020.09.28.01.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 01:36:28 -0700 (PDT)
Subject: Re: [PATCH 08/12] tests/9pfs: refactor test names and test devices
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
 <265f5d9a0fb10ce5e782455839d1baf678dbac48.1601203436.git.qemu_oss@crudebyte.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <082742b4-ea10-e3d5-0742-29687543744e@redhat.com>
Date: Mon, 28 Sep 2020 10:36:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <265f5d9a0fb10ce5e782455839d1baf678dbac48.1601203436.git.qemu_oss@crudebyte.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.011, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/09/20 12:40, Christian Schoenebeck wrote:
> +    qos_node_produces("virtio-9p-device-synth", "virtio-synth");

This is wrong, since it disables the generic virtio device tests (right
now there is only one in virtio-test.c).

Paolo


