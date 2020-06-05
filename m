Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1909C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0C1206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWXTTezL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0C1206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhE09-0000S4-OH
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jhDpr-0003Cb-QV
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:00:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38299
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jhDpq-00085I-Mb
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591369241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsT4QRAIBxIyVKln8pZc+kjXogZ9qtpkSimbC9OGRsk=;
 b=DWXTTezLD4wW/jgrRV3dCRaK1au33Z/2uaL0uA0DQNuXXmz7CP8vlI+sLPvqLMqGpKxDr4
 h7uw8jST41z/z0hZiUBxR33wxHGazJx0/4ywUcwa7JnMs+h/9hLGLrd3W0UUL/Jm/MRLz7
 gkkXmJtcuyzDj7ayGVPcI4Px4+iuG3Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-aJ8QflR6MQGHvCKFatgA_Q-1; Fri, 05 Jun 2020 11:00:37 -0400
X-MC-Unique: aJ8QflR6MQGHvCKFatgA_Q-1
Received: by mail-wr1-f72.google.com with SMTP id l1so3866506wrc.8
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fsT4QRAIBxIyVKln8pZc+kjXogZ9qtpkSimbC9OGRsk=;
 b=F/3rvObQjkIf63KDeBqlxbYiLmMwSGa3BqTIIZpKarKCjw4Gpr5S2bon2EfE8WzZXp
 SUi0lYAQcpTw8arC9H//v7ASc6sb2+0O5itNz8fwNwguIRXKE9sk4eL24O4VPI+2iwm1
 lRvatrvD5i0sAHd7B/Lkd1Rth/BiyYtfQgLCx+JQSDJaDgi8z2X/X51XwH0G5ctkSWv3
 dDHQO71kghev6Cbqewd+VdWAXvwelJHBOlSIHfsdXl1EfcNesgouSvyas+2kscxWJpKF
 GGS9XQbvGJ14+ideps/cJwTkpEjI7L7A3c1U9cmEBhPxT8guJ/3Z3Yo97EmfyhC/eAQp
 WDtA==
X-Gm-Message-State: AOAM533E5lxVcMYaHL8Z5/snaZvVRpmf3pdm9D6pCx2asXIJEN3u+wXu
 icglegzba0jNb3qnt6On2tkUueA/UC4ydkuvIPTYdHrUpXzI29wzzjODeTsMXqT6qUQsfVsX6Wh
 uHqDS8P4g9b2DZVA=
X-Received: by 2002:a1c:22c1:: with SMTP id i184mr2993309wmi.187.1591369236403; 
 Fri, 05 Jun 2020 08:00:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8uj7KUq4Lc8iVTTtpseU0NkDiO3JhnY8xbE9QSgGN4naqeOmERS77rsDoPnBy5xlNKdS9iw==
X-Received: by 2002:a1c:22c1:: with SMTP id i184mr2993273wmi.187.1591369236026; 
 Fri, 05 Jun 2020 08:00:36 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.243.176])
 by smtp.gmail.com with ESMTPSA id a3sm11387356wmb.7.2020.06.05.08.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 08:00:35 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] exec/cpu: Cleanups around "exec/hwaddr.h"
 (reserved to system-mode)
To: Cornelia Huck <cohuck@redhat.com>
References: <20200526172427.17460-1-f4bug@amsat.org>
 <525ebf16-1265-e403-54b6-e1168d84e4f4@redhat.com>
 <20200605161801.4bba0d0e.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c5a04c3-0c3b-5acb-d03a-a4649c9222a2@redhat.com>
Date: Fri, 5 Jun 2020 17:00:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200605161801.4bba0d0e.cohuck@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/06/20 16:18, Cornelia Huck wrote:
> On Thu, 4 Jun 2020 20:11:38 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 26/05/20 19:24, Philippe Mathieu-Daudé wrote:
>>> The 'hwaddr' type declared in "exec/hwaddr.h" is meant for
>>> system-mode emulation only.
>>> This series is a preparatory cleanup to allow later poisoning
>>> it in user-mode code.
>>>
>>> Missing review: patche 7
>>> - target/s390x: Restrict system-mode declarations
>>>
>>> Maybe PPC/S390X maintainers can take their patches and let
>>> the rest to Paolo, or he can take all the series. They are
>>> not dependents.
>>>
>>> Since v1:
>>> - Do not poison hwaddr type
>>> - Addressed Cornelia & David review comments
>>> - Added R-b/A-b
>>>
>>> $ git backport-diff -u v1
>>> Key:
>>> [----] : patches are identical
>>> [####] : number of functional differences between upstream/downstream patch
>>> [down] : patch is downstream-only
>>> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
>>>
>>> 001/7:[----] [--] 'sysemu/accel: Restrict machine methods to system-mode'
>>> 002/7:[----] [--] 'sysemu/tcg: Only declare tcg_allowed when TCG is available'
>>> 003/7:[----] [--] 'sysemu/hvf: Only declare hvf_allowed when HVF is available'
>>> 004/7:[----] [--] 'target/ppc: Restrict PPCVirtualHypervisorClass to system-mode'
>>> 005/7:[----] [--] 'target/s390x: Only compile decode_basedisp() on system-mode'
>>> 006/7:[0002] [FC] 'target/s390x/helper: Clean ifdef'ry'
>>> 007/7:[0005] [FC] 'target/s390x: Restrict system-mode declarations'
>>>
>>> Supersedes: <20200509130910.26335-1-f4bug@amsat.org>
>>>
>>> Philippe Mathieu-Daudé (7):
>>>   sysemu/accel: Restrict machine methods to system-mode
>>>   sysemu/tcg: Only declare tcg_allowed when TCG is available
>>>   sysemu/hvf: Only declare hvf_allowed when HVF is available
>>>   target/ppc: Restrict PPCVirtualHypervisorClass to system-mode
>>>   target/s390x: Only compile decode_basedisp() on system-mode
>>>   target/s390x/helper: Clean ifdef'ry
>>>   target/s390x: Restrict system-mode declarations
>>>
>>>  include/sysemu/accel.h          |  2 ++
>>>  include/sysemu/hvf.h            |  6 +++---
>>>  include/sysemu/tcg.h            |  2 +-
>>>  target/ppc/cpu.h                |  4 ++--
>>>  target/ppc/kvm_ppc.h            | 22 +++++++++++-----------
>>>  target/s390x/internal.h         | 16 +++++++++++-----
>>>  target/ppc/translate_init.inc.c |  4 ++++
>>>  target/s390x/helper.c           |  5 -----
>>>  8 files changed, 34 insertions(+), 27 deletions(-)
>>>   
>>
>> Queued all, thanks.
> 
> So, I guess I should unqueue patch 5-7 from s390-next again?

I can unqueue them too, no problem.

Paolo


