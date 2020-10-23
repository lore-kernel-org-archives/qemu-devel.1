Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079C7C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A712192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyuKN4Zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A712192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVtUc-0002qh-53
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 05:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVtT7-0001wL-QV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVtT0-0003h0-UO
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603445673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGMVu3aa9dhMCzxAud5NWcJoHpEpj2AUgXtxCn9BG9E=;
 b=MyuKN4Zc1RS6hm4KMpIk2K8J9IMAIW54dVpNrRFSlAQ+3qyty1urLrP+6MhnUfuLRTvrNm
 rC8fCV44NYKPE8S03++F7UuTwLkte6N95gRosj2sZ63u/HHR4cGidx+j0WrUpIfZ29IoGM
 Xv9KO1MvivaLBG4IR+YYpDDiRgFGg+I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-AGXMDN9jMBi2FBnasE5Xuw-1; Fri, 23 Oct 2020 05:34:31 -0400
X-MC-Unique: AGXMDN9jMBi2FBnasE5Xuw-1
Received: by mail-wm1-f69.google.com with SMTP id z62so314892wmb.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 02:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FGMVu3aa9dhMCzxAud5NWcJoHpEpj2AUgXtxCn9BG9E=;
 b=R47hy6G2jvEJifsAJD9yZ2KvAqhlraDTT/S1MuAqBeID8DSu2ZiKO0/SpN46sDgR4/
 mvnqWoVWk548EoFVKYBSRm+xERXyEE2ZJrCnAVOBvd2XR8kjG2Z3suQHySF8emjoWqBn
 6AiF/hXLYW5j8MnYO4G/8lEJDPJJV46/w4EPF6RzfJAlP5LLkRWTH4/vvJkzGPKbFloC
 P1nxgj3DgwaExyTPPALneSQ7Cb9bO3YFi/L7z6dQduQjP/yKrpGtETVzmImJQqxuAxBh
 JVbXIuy7SuiAHYdM5/fGuJ2s5Dd+M1rz72o++3t1IA7MmwBlJf/06zcrP/H0bMAPiAj2
 JnlA==
X-Gm-Message-State: AOAM531r/YObEns9A/XDI4mq8PD6PK+mrD+FklqA0A+tZ1OTM+aTlE18
 CUcMkzEaeeTmoDr519DBu71GkO38hWimyRC13siPIi1WZmTjVzatlIpB3vioMzCum+RH6vZDgV/
 HY1dH6F5C2LFf4JI=
X-Received: by 2002:a5d:4648:: with SMTP id j8mr1595261wrs.131.1603445670128; 
 Fri, 23 Oct 2020 02:34:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZEPFC0cYdFNLJkhT7P2Q/rKqhDgKW2UfR2mE25lRSMsIsWGSZR75378dt7F6GcxlNTU540A==
X-Received: by 2002:a5d:4648:: with SMTP id j8mr1595234wrs.131.1603445669876; 
 Fri, 23 Oct 2020 02:34:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id m8sm2152212wrw.17.2020.10.23.02.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 02:34:29 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Add Xen CpusAccel
To: Thomas Huth <thuth@redhat.com>, Jason Andryuk <jandryuk@gmail.com>
References: <20201013140511.5681-1-jandryuk@gmail.com>
 <ddb5c9c2-c206-28d6-2d9d-7954e7022c23@redhat.com>
 <CAKf6xpvpuG1jVdf3+heXzHFd_kc5kVHYdJgC+8iazFLciqOMZw@mail.gmail.com>
 <d9f23eee-c0af-d2dd-9b9d-f0255fc8e3d1@redhat.com>
 <1927b32e-7919-5061-0285-d9c7184d0bae@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c0ef825b-ac02-67ab-aef2-f7722da1272a@redhat.com>
Date: Fri, 23 Oct 2020 11:34:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1927b32e-7919-5061-0285-d9c7184d0bae@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 QEMU <qemu-devel@nongnu.org>, Claudio Fontana <cfontana@suse.de>,
 Anthony Perard <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/20 09:09, Thomas Huth wrote:
> On 22/10/2020 17.29, Paolo Bonzini wrote:
>> On 22/10/20 17:17, Jason Andryuk wrote:
>>> On Tue, Oct 13, 2020 at 1:16 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>
>>>> On 13/10/20 16:05, Jason Andryuk wrote:
>>>>> Xen was left behind when CpusAccel became mandatory and fails the assert
>>>>> in qemu_init_vcpu().  It relied on the same dummy cpu threads as qtest.
>>>>> Move the qtest cpu functions to a common location and reuse them for
>>>>> Xen.
>>>>>
>>>>> v2:
>>>>>   New patch "accel: Remove _WIN32 ifdef from qtest-cpus.c"
>>>>>   Use accel/dummy-cpus.c for filename
>>>>>   Put prototype in include/sysemu/cpus.h
>>>>>
>>>>> Jason Andryuk (3):
>>>>>   accel: Remove _WIN32 ifdef from qtest-cpus.c
>>>>>   accel: move qtest CpusAccel functions to a common location
>>>>>   accel: Add xen CpusAccel using dummy-cpus
>>>>>
>>>>>  accel/{qtest/qtest-cpus.c => dummy-cpus.c} | 27 ++++------------------
>>>>>  accel/meson.build                          |  8 +++++++
>>>>>  accel/qtest/meson.build                    |  1 -
>>>>>  accel/qtest/qtest-cpus.h                   | 17 --------------
>>>>>  accel/qtest/qtest.c                        |  5 +++-
>>>>>  accel/xen/xen-all.c                        |  8 +++++++
>>>>>  include/sysemu/cpus.h                      |  3 +++
>>>>>  7 files changed, 27 insertions(+), 42 deletions(-)
>>>>>  rename accel/{qtest/qtest-cpus.c => dummy-cpus.c} (71%)
>>>>>  delete mode 100644 accel/qtest/qtest-cpus.h
>>>>>
>>>>
>>>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>> Thank you, Paolo.  Also Anthony Acked and Claudio Reviewed patch 3.
>>> How can we get this into the tree?
>>
>> I think Anthony should send a pull request?
> 
> Since Anthony acked patch 3, I think I can also take it through the qtest tree.

No objections, thanks!

Paolo


