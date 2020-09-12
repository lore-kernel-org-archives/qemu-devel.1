Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78B9C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C09920855
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrY+cVFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C09920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGycO-00020a-33
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 02:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGybV-0001Mu-Hh
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGybT-0001Wq-4R
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599890497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gl2AtlMXNqKvTmPK+6Z4nh0TVjCyOpaXQ00n1fpFNqc=;
 b=RrY+cVFIycz9JgF1LOD3fXvk7rQMvD76KomXurEQcA3JJKbXID1Rg9wcB5fFy0+3uX5sOy
 cug+bSE1V7gMZy8Kils9CuUIwhHgHbemD6bO/Z5BiAOzUro4CkT8ScGnwzxel1cQje7chG
 hAToegmQs3FMOE4C5xHxUjKLofiP3Ok=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-UAa2Re4AMQalTkX3OvoDZA-1; Sat, 12 Sep 2020 02:01:35 -0400
X-MC-Unique: UAa2Re4AMQalTkX3OvoDZA-1
Received: by mail-wm1-f71.google.com with SMTP id a7so1673382wmc.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 23:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gl2AtlMXNqKvTmPK+6Z4nh0TVjCyOpaXQ00n1fpFNqc=;
 b=LRQ/9W9j7P/E3iOTFxBthptNzSU5/ZYIBP//k0icWc8b+6r8qeBBlUNoQ+9IDXK0Zj
 CLsNXA8gW4FIiirSU13xVf5Dx1dDSzQ8dwk6nLib0IjivsJkw9EnCNVBv0xIW8T7mMH8
 Iag/E+/KJJjl85r5lqX6Yi8K1Xl9bD//O98EFLGewCu1FuSNqx0N5JhMFpKeX/yVetFA
 B5D9tCFDxqBcfq6GXkaEtmoySJCPFkd0bCcY7yGCFggutTo4B2RsNIMVou28O1QSAVoE
 cEeulbp2s8vXH3kbuNG4yKvOrkyOMv90wA77XiMrrz5zZPi5PSVNpdBA4PXRtwlgW36/
 TCIA==
X-Gm-Message-State: AOAM533Jc3B3Dc9Eicsperrn+7AytUgFS8pwQhIbS6QBgS7/nBTRBDsU
 QotU1b9aly8RM9yKFwSdzUkXImKQRBxrlhQbWMV/CTstzRb2uLJhnDZrozTAtNTtKyF1NngdgLe
 LkdLXK+LYMWjpYOo=
X-Received: by 2002:a1c:7714:: with SMTP id t20mr5734235wmi.55.1599890494249; 
 Fri, 11 Sep 2020 23:01:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAz3LYjm0ULsjJ7PFs3pE9KI5HeANjEihDIHjNBSdqeZwduh4mU/81Grk535fRy3WpkjP1Bw==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr5734216wmi.55.1599890493915; 
 Fri, 11 Sep 2020 23:01:33 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id m13sm8278190wrr.74.2020.09.11.23.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 23:01:33 -0700 (PDT)
Subject: Re: [PATCH v2] scripts/git.orderfile: Display meson files along with
 buildsys ones
To: Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200907161222.41915-1-philmd@redhat.com>
 <bd658d44-d9bd-81d1-f3c7-89c0d61f6dd2@redhat.com>
 <79de1ef4-6e08-6f1c-030e-f40e7410e06c@redhat.com>
 <2d435bb0-eb8d-7a12-b962-2bce246c30fb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b529fd7-aae4-645e-c956-aa6f9fc2aea5@redhat.com>
Date: Sat, 12 Sep 2020 08:01:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2d435bb0-eb8d-7a12-b962-2bce246c30fb@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 02:01:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/20 14:30, Laszlo Ersek wrote:
> 
> The current working directory is the source tree.
> 
> The working directory is pristine, as in:
> $ git reset --hard
> $ git clean -ffdx
> $ git submodule deinit --force --all
> 
> Then:
> 
> $ git submodule update --init --force
> $ make clean
> $ git status

I see.  We should probably rename the Makefile in the source tree, since
it is only meant to be used from the build tree.

Paolo


