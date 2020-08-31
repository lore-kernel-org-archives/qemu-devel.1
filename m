Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51008C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 12:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193DC207DA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 12:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwYjF7pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193DC207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCijI-0007Vc-7r
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 08:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCiig-0006xZ-4V
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 08:15:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57608
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCiie-000179-Ah
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 08:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598876127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7yTSNBrIqnysjG8q6pa4J781+BQX7SGznCbX77pUsM=;
 b=iwYjF7pk88MtG8i1SMDF3SK1b8OxxaCzmdyRSdpkc197azOMmASnYyCYuRcFVQntlIwFR7
 lI1+zNyKeOSfIUoxKNHjtgVR9ymT5nhlRwk51WW/9beNtnTjjPgCA1ZEwRgr1Au4971vpX
 SwYMbJwekQljFvX5vz4fIVJjqXMCzho=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-uYYNCNEOPdGbhQiwtGkE7A-1; Mon, 31 Aug 2020 08:15:25 -0400
X-MC-Unique: uYYNCNEOPdGbhQiwtGkE7A-1
Received: by mail-wr1-f70.google.com with SMTP id v5so3126038wrs.17
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 05:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t7yTSNBrIqnysjG8q6pa4J781+BQX7SGznCbX77pUsM=;
 b=YcA3k6QRoiV+BCzoPu/ODruQhubHBRUGHOl09LCA6OW+vD/1ibuB89Gib03KRzmMTp
 El+TJF9Tyswotn+QfPZgvGlELEpL4JcqRclKZxu1ZhdON9iXWXbgNKch5h9tr02ZbtpP
 vOozj0ykBYxeGuUWX303rVZ0dRye3MdFStZs3s7YNKMIggbkhS2QVu8/SchAicdaEAvA
 7zHKWRYfwIgmnHdHUHRWWUx0aJUMqAfar0MNRiKpL3go3ztKK8nMWLOdKb+0XuRNPOPz
 vsfD2CEYX5MUnAo0PXONvXhApytvJyRjuj6q8MOJbB/+zmPmfFYmdl+3jjnCxtAr6eFc
 dihw==
X-Gm-Message-State: AOAM530D+Z2pI6uYwLQ1zwnGL/P1CuLJ0dosaAx3uvqevIX3VS0M8ydP
 1thEfkjKq9sJoRvmgBPivSK5WwqHZ3lPkjVZVIzyjtL5BQfaUlnmKVIEnbzsza73OBvrWC++38r
 4btVsU/cnQgUNGdg=
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr1106756wmh.74.1598876124368; 
 Mon, 31 Aug 2020 05:15:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/R7pthbbn+7K2qqN7kegJbdLuX6Xw/LJATmEKgmm9NBEI2a37NHMD1EJbiNt+Ao9el4KtGg==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr1106745wmh.74.1598876124208; 
 Mon, 31 Aug 2020 05:15:24 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.203])
 by smtp.gmail.com with ESMTPSA id 21sm12549491wrc.55.2020.08.31.05.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 05:15:23 -0700 (PDT)
Subject: Re: [PATCH] meson: use pkg-config method to find dependencies
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200831102819.24334-1-pbonzini@redhat.com>
 <20200831110655.uj6f2hq3yyygqqox@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e111925-dded-3866-cfd7-6de152f7e95c@redhat.com>
Date: Mon, 31 Aug 2020 14:15:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831110655.uj6f2hq3yyygqqox@sirius.home.kraxel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/08/20 13:06, Gerd Hoffmann wrote:
> 
>> Keep "auto" for SDL so that it tries using
>> sdl-config too.
>> -  sdl = dependency('sdl2',
>> -                   required: get_option('sdl'),
>> +  sdl = dependency('sdl2', required: get_option('sdl'),
>> +                   method: 'pkg-config',
> code and commit message mismatch here.

That's docs/devel/build-system.rst, I wanted to keep the "method" so
that people can cut-and-paste correctly.

Would you prefer if I switched from sdl2 to something else (for example
pixman which has a "version" keyword argument as well)?

Paolo


