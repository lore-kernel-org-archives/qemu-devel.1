Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5E2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D689B206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgewr9tK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D689B206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIgN-0008B5-2q
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtIJj-0001M4-Kw
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:13:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53966
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtIJh-0008Cs-Tr
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRpmmMJBZi/RuCtlwkjSQB4f9CiyAhlj3ulPr3tyJHE=;
 b=fgewr9tKjcMZZz8jkCUMKSFLhP1eESr3IOcsiYCNgR7AdJmJrbhiqyYNmjTdZ28PeJSNFO
 v/CoP1aN22CJJ8IaeUMhntrhQl325NJO+gMUCt8GtYgDCEt0tMMNnmpV9ZHQdt9ClsB9Bj
 AfvbIe/nixf7O1ppG06X6KLWVgZWQ+I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-o-Agv4VMM0S6PL5HLc4uEQ-1; Wed, 08 Jul 2020 12:12:40 -0400
X-MC-Unique: o-Agv4VMM0S6PL5HLc4uEQ-1
Received: by mail-wr1-f70.google.com with SMTP id 89so29030890wrr.15
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tRpmmMJBZi/RuCtlwkjSQB4f9CiyAhlj3ulPr3tyJHE=;
 b=VfZiEFuo2xVr5Lj2Xlxd6Nst6TDLdv6t4tIOUJDJXVG2FPUDfkdz2BkZ1xyw4dAE9S
 6RP4iTXIyRhZQJLf69Uxlfh3tyVV17NXwMO+djUvn+ApwayoQ5uEmLqbsPCndudcB00f
 GAixD9L6ceR+FiuOG7rgkldv1QOZBh2ANYVaZHePMywg4RGIQ7JzKSr/algI7lGkH+GS
 qV83Jdj16RGHn6HeCAh4qGXeV368lZhQ/5nkERtfxy5OeOgvJkdIjrRpAgTisjgo0yzW
 5KTNlAkNGCKPGu8BuKR9HFC9iP0PZgOiGVQeNKJLcRqQnLXrZL0bwYcxtjKzDUBZMU0U
 Yi2A==
X-Gm-Message-State: AOAM532xayFLASFuVEwvAdnE1Of3IKoqQTskRTGi9HN76xIcAupPv9CK
 HMD3RWWVZFA0ml6kL0sA7rpuGDKAmJM5QBnhrT1J231PKz2a2bgbWu44BVF2aOFGdrDimWcz6lg
 DIRC5FlUaj6ohaEg=
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr8519999wmn.6.1594224759494; 
 Wed, 08 Jul 2020 09:12:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9Kx3/uBigE3Fm0HLpEyhMDKRLhtyoVy1XaqViqMaM28Pov5W7LwX4kcWvhF22xFRxUkicig==
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr8519979wmn.6.1594224759292; 
 Wed, 08 Jul 2020 09:12:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id d132sm327043wmd.35.2020.07.08.09.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 09:12:38 -0700 (PDT)
Subject: Re: [PULL 13/29] qapi: Flatten object-add
To: Kevin Wolf <kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
 <20200306171458.1848-14-kwolf@redhat.com>
 <7dc27dad-7797-dc2a-9456-2a7aaf9a4e5c@redhat.com>
 <20200708160555.GE4902@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5693a1e-e891-efd2-6e8a-1302b7ca3332@redhat.com>
Date: Wed, 8 Jul 2020 18:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708160555.GE4902@linux.fritz.box>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/07/20 18:05, Kevin Wolf wrote:
> Markus was going to introduce new QAPI schema syntax that would allow to
> specify a few options explicitly and then one option for "the rest" that
> would just be mapped to a QDict like "any" or "gen": false, and that
> wouldn't require any nesting.

Oh, I wasn't aware of that.  That would be something like 'properties':
'remainder' I guess.  That would be fine too.

Paolo

> I'm not sure if any progress was made there, but making things
> consistent between device_add, netdev_add and object_add was a step in
> this direction anyway.
> 
>> As an aside, it would have been nice to run this through Markus and me,
>> though in all fairness I'm not sure I would have been responsive back
>> in February.
> It went through my tree because of the other patches in the series, but
> I wrote this patch specifically at Markus's request.
> 
>> I would like to un-deprecate this for 5.1, and revert it in either 5.1
>> or 5.2.  (Also I will be away next week, so the decision would have to
>> be taken quickly).
> Please discuss it with Markus then.


