Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA55EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 22:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D2CF2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 22:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEPr9pgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2CF2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8WGx-00021k-Qf
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 18:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8WGS-0001ba-0Z
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 18:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8WGP-0004cA-Fs
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 18:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597874935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JbnOGEf73g3BigK8gWmcWfOQoyNMpVZwLTfGXzUKN6c=;
 b=MEPr9pgvj1tW/jYiU9+CmkxoE6kx3gPmt8bEgu2pRbWCMxwBxvdT8K6Z8G7h4yqBSjpduz
 6hDtDp35g61/zpeFyyeu8SGZ7IVawY/N5NDvLbUBUPJLqCWmUb4cIwwrvEG1e01/6dINcN
 uZmrmfl5L/ABG/ePysbRkixDYwPL3XY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-sUbVYWw4OGWBM5R6XDHppg-1; Wed, 19 Aug 2020 18:08:54 -0400
X-MC-Unique: sUbVYWw4OGWBM5R6XDHppg-1
Received: by mail-wr1-f71.google.com with SMTP id e12so9768788wra.13
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 15:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JbnOGEf73g3BigK8gWmcWfOQoyNMpVZwLTfGXzUKN6c=;
 b=ItijHjXUtKIMonGp0VHDb0KYJcMCDjbg4twSivCXzsvSxpzzznf5Ea+ww/A1T9LDHi
 35bnitCcUZNTwSaQqPvs5fTKRAR9lNvTjhCvuekAHKAMLPt4ZkphmebiD6WL5kqlei/4
 BozJtefqH/SkKhTrjrkIDspD1Dsh/sefqddn+AND752E5tuGTesTKfRbgGCnj/1osyuw
 DO2fszo/dgiYJEOZuADdZ+UEOYbMWA3dXVhwAqhwHGhy2kMcXTRCAGneIQQcRdOy8e9n
 JC+IAWIceSnp0IcELS3co5GZyGxzhFMqsQGtU5eVvZ2mPuovBz8qg5QikwWhijzYjauN
 Rqnw==
X-Gm-Message-State: AOAM530LSnGzYrhX8fDyd35si8BgvtWEiuxEbixRevVJIDe0Hw4ZL3dD
 quqaKsCB0Pfhhk7l/uRJvTvcN3Hqo1dIbokcWq2JsbSBVcylTI0Mq3NwJjtOeDpvbWbDNLqStuz
 ckIm5ER/XDqgep1k=
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr361213wmj.92.1597874932798;
 Wed, 19 Aug 2020 15:08:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp4pplpSubefsx5IsexX+OwbX2bHZZ9E/uFIh+2LLGCx4IqAdzdIzDrxg3GDyn1kQfxQI36Q==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr361196wmj.92.1597874932551;
 Wed, 19 Aug 2020 15:08:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id w64sm502210wmb.26.2020.08.19.15.08.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 15:08:52 -0700 (PDT)
Subject: Re: [PULL v7 000/151] Meson-based build system
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200819213203.17876-1-pbonzini@redhat.com>
 <3689e853-b267-a553-a78f-d906618512db@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e020de7b-2ec6-c2ac-97f1-3da9d874fd45@redhat.com>
Date: Thu, 20 Aug 2020 00:08:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3689e853-b267-a553-a78f-d906618512db@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 16:17:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/20 23:59, Eric Blake wrote:
> On 8/19/20 4:32 PM, Paolo Bonzini wrote:
>> The following changes since commit
>> d0ed6a69d399ae193959225cdeaa9382746c91cc:
>>
>>    Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> Unrelated to the pull request proper, but I note in MAINTAINERS that you
> have listed:
> 
> T: git https://github.com/bonzini/qemu.git scsi-next
> 
> Have you switched to gitlab as your personal mirroring preference, and
> if so, should MAINTAINERS be updated?

Yes, but also I've not used a scsi-next branch for years. :)

>> for you to fetch changes up to 2eddb3c65821dce76433d5da6f3e6419349d1b77:
>>
>>    docs: convert build system documentation to rST (2020-08-19
>> 16:13:30 -0400)
>>
>> v6->v7:
>> * new patch to preserve compatibility symlinks from previous binary
>> locations
>> * fixed cut-and-paste error in linux-user/mips/meson.build
>> * preserve compatibility check-block target even if no block tests are
>> defined
> 
> FWIW: I haven't done any review or testing of the earlier iterations of
> this series.  But since it will be landing soon, I merged this tag to an
> incremental build tree that was previously sitting on a finished 5.1
> build (sources in qemu/, VPATH build in qemu/build/), typed 'make' then
> 'make check', and everything finished successfully at least for my
> typical setup.  So good job on getting this massive rewrite in while
> still preserving at least the common 'make' interface.

I must admit I was a bit lazy with incremental builds until Peter
pressed me for it, and I must say it wasn't _that_ hard to do, with a
fresh mind.  I tried a bunch of touch&&make scenarios and they all
worked fine.  It always helps to steal tricks from Autoconf's bag, since
QEMU's "./config.status --skip-meson" is basically the same as
Autoconf's "./config.status --recheck".

Paolo


