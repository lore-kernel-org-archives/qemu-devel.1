Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E3EC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6F4221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdCasDbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6F4221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKgbL-0001zv-58
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKgaL-0001L1-39
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKgaI-00012X-K4
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600774545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVuM9z2yUr8zyxXYDwbwyPVDW6UrW4ow9wkAb6hmN1A=;
 b=IdCasDbB5I3yINNoIe57gd423VtZ1c8ErAIk9ObVFnwFUE9Ysd+hoy3Vzzh84Q/JdJXHZ5
 nGmIeMbWTjPoQMKc/N+yHrEiIndvwuRFWVN7qyqwHjFqVReVs6RIEuJK1hHcf5lHOH1+yc
 IbC6IfRrEyB3mD0Hh/0K7PUddt8D11E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-FfOz195WNO2YHfeCoNidYw-1; Tue, 22 Sep 2020 07:35:42 -0400
X-MC-Unique: FfOz195WNO2YHfeCoNidYw-1
Received: by mail-wr1-f70.google.com with SMTP id l15so7285458wro.10
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 04:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iVuM9z2yUr8zyxXYDwbwyPVDW6UrW4ow9wkAb6hmN1A=;
 b=UwWd1Hq+6hk0QFKle9LcdFHcZpunrShZjInxXj8K66bLIpy/Rrd12faskUfOduDq8m
 uvR8eQJ7Ar98aDZGac5bV5pw9reAfzHBZt6darL15mzQjEzOLqZUCpUuktvyKxTvxpTS
 qGuLcIdXqSX2TEMh4jmlt16DsOgrifPu80LAmoB7NZzqO6TnDhhdqaC4ueaHon/ZboSI
 W3omPqXeC8Yt9RT+MOZ/IYadWEt+MVcj4msfx+4Wzdu9M0VSY/IcThPGLsVwu2fHaTIP
 LSTwrTJAiX+x3g5DnF1syxSnAqulnk0ZwXhagux6O7olAbYRBzPF5Hew0ReGO2XcVqAD
 T6uA==
X-Gm-Message-State: AOAM5305aTfcN/FtnRMaV3sMxTQcl6JwELJT9fBtPLn6TfTkE+qPAUnC
 fIY18lPLhdS57Qruku8WeXhdbMD8TsvMo2IVKsogPX6rvtM8EaNnp2ySrIDYunSyOfQd4qQY2z9
 HAgFtscfuxcC26qc=
X-Received: by 2002:a1c:2c0a:: with SMTP id s10mr522305wms.103.1600774540945; 
 Tue, 22 Sep 2020 04:35:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRA5AQEUn4rCczYkkzXjxs49KTP7PwCp4IUjQhU4ZWgDSvFRTPtzciduuPsGxbrjwX11t5eA==
X-Received: by 2002:a1c:2c0a:: with SMTP id s10mr522238wms.103.1600774540651; 
 Tue, 22 Sep 2020 04:35:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6?
 ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
 by smtp.gmail.com with ESMTPSA id m18sm25626053wrx.58.2020.09.22.04.35.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 04:35:39 -0700 (PDT)
Subject: Re: [PATCH v2] qemu/atomic.h: prefix qemu_ to solve <stdatomic.h>
 collisions
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200922085838.230505-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33631340-e3e3-b10f-4f9a-0e1b295d79ef@redhat.com>
Date: Tue, 22 Sep 2020 13:35:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922085838.230505-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 sheepdog@lists.wpkg.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, Jiri Slaby <jslaby@suse.cz>,
 Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Juan Quintela <quintela@redhat.com>, Paul Durrant <paul@xen.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, Liu Yuan <namei.unix@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-riscv@nongnu.org, Sunil Muthuswamy <sunilmut@microsoft.com>,
 John Snow <jsnow@redhat.com>, Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 10:58, Stefan Hajnoczi wrote:
> clang's C11 atomic_fetch_*() functions only take a C11 atomic type
> pointer argument. QEMU uses direct types (int, etc) and this causes a
> compiler error when a QEMU code calls these functions in a source file
> that also included <stdatomic.h> via a system header file:
> 
>   $ CC=clang CXX=clang++ ./configure ... && make
>   ../util/async.c:79:17: error: address argument to atomic operation must be a pointer to _Atomic type ('unsigned int *' invalid)
> 
> Avoid using atomic_*() names in QEMU's atomic.h since that namespace is
> used by <stdatomic.h>. Prefix QEMU's APIs with qemu_ so that atomic.h
> and <stdatomic.h> can co-exist.
> 
> This patch was generated using:
> 
>   $ git grep -h -o '\<atomic\(64\)\?_[a-z0-9_]\+' include/qemu/atomic.h | \
>     sort -u >/tmp/changed_identifiers
>   $ for identifier in $(</tmp/changed_identifiers); do
>        sed -i "s%\<$identifier\>%qemu_$identifier%g" \
>            $(git grep -I -l "\<$identifier\>")
>     done
> 
> I manually fixed line-wrap issues and misaligned rST tables.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * The diff of my manual fixups is available here:
>    https://vmsplice.net/~stefan/atomic-namespace-pre-fixups.diff
>    - Dropping #ifndef qemu_atomic_fetch_add in atomic.h
>    - atomic_##X(haddr, val) glue macros not caught by grep
>    - Keep atomic_add-bench name
>    - C preprocessor backslash-newline ('\') column alignment
>    - Line wrapping
>  * Use grep -I to avoid accidentally modifying binary files (RISC-V
>    OpenSBI ELFs) [Eric Blake]
>  * Tweak .gitorder to show atomic.h changes first [Eric Blake]
>  * Update grep commands in commit description so reviewers can reproduce
>    mechanical changes [Eric Blake]

I think the reviews crossed, are you going to respin using a qatomic_
prefix?

Paolo


