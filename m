Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422FCC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73B22087C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5NgEhJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73B22087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzC2-0005qE-Hb
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWzAO-00045P-JN
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWzAL-0001Fg-Gr
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603705908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16OGB9Kvi8MPbR3GCy7IUPhMwJ+qeJkSkyzkBqKBsFM=;
 b=V5NgEhJnCZaAtrTDU1PBcXOoKvUuml7tP7TZsyF+pmBtW2f75GxUxpw9j3EXLRmc+9BDuq
 CYG6yaJ5KT8i2+JrwDpxGseR02igHSVa6kfHWZGdkRWmWRnWFgKbnf9xNViDwTEkB6n7uT
 5KPmdfGrZjSYbt6aSH2Gm6eExQ3Vis8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-G5urmYklNyOg3aOu3VMTDw-1; Mon, 26 Oct 2020 05:51:46 -0400
X-MC-Unique: G5urmYklNyOg3aOu3VMTDw-1
Received: by mail-wr1-f71.google.com with SMTP id 2so8143863wrd.14
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 02:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=16OGB9Kvi8MPbR3GCy7IUPhMwJ+qeJkSkyzkBqKBsFM=;
 b=VqMfrxJqWTMOtJiVhcW6SIQrCUbEAzFHo3hVj6H27Ts6F8brSgP/bleWBeaTzUiuw9
 dG1ayhWL5MuKodRhkqY/weOmy4R2Zyghmh6ftAC6iEr2RywZe4S9fTrrPq6wkez8VGm2
 cgY8VoulG6qsMEFEliEZjkOhFKGCBmBcb+Zqc/aDwgpPCp7hlyMkobE7vdWWTVgmE5+R
 laK/83FLIXrwNJhnAiQqsdQF8gufwYhREDT1ZriZevulw0vGQVKN6ZAUJ9I4OWPmeg78
 NMsfAoUQ4ZSNGYbMxx1qdiBOcRPdi1Nre8ZywNFktpD1jBVyqzlJeYoyFHBUUPOBOziy
 jkwA==
X-Gm-Message-State: AOAM531pkK8njng1NCHgfn6JIadXpPufFbixTkdLgnoBZN5vx4VKf8/+
 q5U+/LdrI95ah2IX76x36dr5EuUITgS8AyDTgUtttohIrBLZntgY9oPAhoznp3mpDRUF0mLHxhc
 8sqjDcs5/GVbgleI=
X-Received: by 2002:a7b:c183:: with SMTP id y3mr15070428wmi.84.1603705905333; 
 Mon, 26 Oct 2020 02:51:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwidYwr5cYEunlORaEGsvG7vBGKuH5/zNccHjbQk3gembDF5XoYVhAh8CX1teEEsLFX4lSxAw==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr15070409wmi.84.1603705905043; 
 Mon, 26 Oct 2020 02:51:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id 24sm19043075wmf.44.2020.10.26.02.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 02:51:44 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] configure: add option to enable LTO
To: Daniele Buono <dbuono@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-4-dbuono@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7aa00aba-ff8c-252a-899a-45ef4db7cc6e@redhat.com>
Date: Mon, 26 Oct 2020 10:51:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023200645.1055-4-dbuono@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/20 22:06, Daniele Buono wrote:
> This patch allows to compile QEMU with link-time optimization (LTO).
> Compilation with LTO is handled directly by meson. This patch adds checks
> in configure to make sure the toolchain supports LTO.
> 
> Currently, allow LTO only with clang, since I have found a couple of issues
> with gcc-based LTO.
> 
> In case fuzzing is enabled, automatically switch to llvm's linker (lld).
> The standard bfd linker has a bug where function wrapping (used by the fuzz*
> targets) is used in conjunction with LTO.
> 
> Tested with all major versions of clang from 6 to 12
> 
> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>

What are the problems like if you have GCC or you ar/linker are not up
to the job?  I wouldn't mind omitting the tests since this has to be
enabled explicitly by the user.

Paolo


