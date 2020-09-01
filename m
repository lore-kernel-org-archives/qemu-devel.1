Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FF5C28E83
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0DBF204EC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNbcEqn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DBF204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8tR-0001RZ-W8
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kD8od-0004Iw-Ee
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kD8ob-0004sT-Q8
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598976440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G4/0NT+4WIv9LgPBmg4QagojxIRU9na4tbXZ1KKnrE8=;
 b=aNbcEqn2/bF6hAIJWE1n+z7o+QxiHWv7b1H/jItRbl1oGHyD810qgJBeo4DhnDTtLnD5MA
 EYSFAICV7hYLyUC2ifjf2NMwJJfOB99o/Kk2eBwC7j3B0ZeJ7E8WlBfuvheqwdf58Ajc+i
 T9eH/DrDCZv6K8OG6iR5AnQb8ZLRn0Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-tuP8ViAINei-Dvf0LKl31Q-1; Tue, 01 Sep 2020 12:07:19 -0400
X-MC-Unique: tuP8ViAINei-Dvf0LKl31Q-1
Received: by mail-qk1-f197.google.com with SMTP id y187so1252641qka.10
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 09:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G4/0NT+4WIv9LgPBmg4QagojxIRU9na4tbXZ1KKnrE8=;
 b=L3ng0nQ3M4UpJhXLJCKLodPLGGkgLJiO9vexrXLHONa2SyNHmigFrmbicxFF3oe+Xh
 T6/ojlJyZRu6bF5t8CVugAOmmSeyRsV8Ty1OR4aQoggCB7dZ7IwrallJQGNwCaH07pjs
 7qH4Lu01WFqHUm3GjAtYHOioJPDn3FkzOGC72M70m9sNJsab/QB2BAlcuU8Bb28rdNZh
 /Qfx21H1z/Ib+ZsCVn6+UsoMvMuXlJ8bjict5y0MsAXETZ1UXgoqxUGVju83zBWUmQGR
 dZqrZw2ymAmaDj4ZQkjtSi9e0RdR4JkCHTSyPS5GcFhBBAM7UUO40gCGdhWqo4KzX2Qy
 zIMQ==
X-Gm-Message-State: AOAM531J1PiLf9p96/F0z5PVv5T05sMrJ5ErUJJnCoXPeYlzXG9wq5Zo
 qSIQqJEPl+Ou0cS+ijr340j79ZmrW2ZBvLm7jg6o4WhhB4tmH4kKxM5AllkZPBrcyp/Hs9IWl2a
 r1AgpCYcDn9T/Zmo=
X-Received: by 2002:ac8:46d7:: with SMTP id h23mr2533091qto.18.1598976438613; 
 Tue, 01 Sep 2020 09:07:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxll8BA4lNJJEZ43GIdPm7MFZYvXUwYS66LhgGCovj2+EUoh34/1aGZ0IU9Ofql5KFEPi6DSw==
X-Received: by 2002:ac8:46d7:: with SMTP id h23mr2533072qto.18.1598976438359; 
 Tue, 01 Sep 2020 09:07:18 -0700 (PDT)
Received: from [192.168.0.172] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 k9sm1840767qke.56.2020.09.01.09.07.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 09:07:17 -0700 (PDT)
Subject: Re: [PATCH 1/2] Makefile: Add back TAGS/ctags/cscope rules
To: Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org
References: <159896923655.442705.11922948674073863022.stgit@bahia.lan>
 <159897001005.442705.16516671603870288336.stgit@bahia.lan>
 <f31b9650-9db4-e038-9e4d-bd5faf1f5b96@redhat.com>
 <8a3c31f0-b9e7-5ae8-2c58-0e8cee06d469@redhat.com>
From: Connor Kuehl <ckuehl@redhat.com>
Message-ID: <c79871c5-6ade-b3c6-3bab-a22c90bc4587@redhat.com>
Date: Tue, 1 Sep 2020 11:07:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8a3c31f0-b9e7-5ae8-2c58-0e8cee06d469@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 11:04 AM, Paolo Bonzini wrote:
> On 01/09/20 16:59, Connor Kuehl wrote:
>> On 9/1/20 9:20 AM, Greg Kurz wrote:
>>> It is a bit of a pain to be forced to run configure before being able
>>> to use cscope and friends. Add back the rules to build them in-tree
>>> as before commit a56650518f5b.
>>>
>>> Fixes: a56650518f5b ("configure: integrate Meson in the build system")
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>
>> This might be a user error on my part, but the way I read this it sounds
>> like I could do this:
>>
>>      $ rm -rf build
>>      $ make cscope
>>
>> and have it emit a cscope file,  but when I do so it complains about the
>> build dir not existing. As I understand it, running ./configure (or
>> meson build) is what generates that build dir. Here's the error for
>> posterity:
>>
>> changing dir to build for make "cscope"...
>> make[1]: *** build: No such file or directory.  Stop.
>> make: *** [GNUmakefile:11: cscope] Error 2
> 
> You have a stray GNUmakefile in your source directory.  It's not
> introduced by Greg's patch.
> 
> I suggest that you remove the GNUmakefile and just use out-of-tree builds.

You're right! There was a stray GNUmakefile. Thanks!

Connor


