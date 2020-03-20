Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32443C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01B520722
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Acg7Q1Mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01B520722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFI50-0000xA-4d
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 09:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jFI4G-0000NP-CQ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jFI4E-0000Gj-Vs
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:52:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50615)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jFI4E-0000GK-SZ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584712326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KG3HC1LEbmDsondjaF71yYWY0gMriiPruOy9LU69aBs=;
 b=Acg7Q1Mgy8drumd8Qf8bFnP2NNM5zHh92XNJR1FmUF+g0rL42Zb2pm5OSvjPYV/FKlXsu3
 gokXYWdutHkvpExHj51q7HrzmI4YNemRhNqhTniY9ztdD/+wYi4nFtGUTbA6D7rWyOknLC
 u0OJRaZfCRYClPyzLdn1FoT6kmXWq1U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-GKTPzVsiNjKYGfd4adAb3Q-1; Fri, 20 Mar 2020 09:52:01 -0400
X-MC-Unique: GKTPzVsiNjKYGfd4adAb3Q-1
Received: by mail-wm1-f71.google.com with SMTP id 7so151597wmg.4
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 06:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KG3HC1LEbmDsondjaF71yYWY0gMriiPruOy9LU69aBs=;
 b=MtrsRuyNoe7PugzWn44Zi8eiMlmwQm8v1fyRdjOUIXu/olkQcqpHndqZh5oLFN1EpU
 aRDG//LLT0XTkA9l05ujjF7JMtj033+VaTQjRLUd3DsioaUTl8nCxaibNCMKx9F/xmSe
 05jv2EiYjbfntKw9ipfecTzcfsJoleNxlsUw6cGbp6PX6NdNcXzQhJZdTwZHUTMu5oZc
 kjxhFFxajU7LdCMTfeODAQNqheCoaQBpTUu0uZHNowHDeKcebsgpUfu7ud7Rztmy4HIT
 0CtdFBA5tPFhrqQpPEyFM/VoRMAiFTyIWKT99yia5YbybxUB1jH7S39M/Dopt98Ro57r
 2M+A==
X-Gm-Message-State: ANhLgQ0dAsmbWRuux2viWc+7QYSpWPrS/02NLaWzjrV3RD9PS8RSiboc
 BaeISv+iXO9RYN+cL5aM+RIj1yt1jf9nGj7W7J67d8Dd2p/DHlsuiCHKIDAbaeurgOnTU1qd4b8
 lNK4ksFP9eBBQNOg=
X-Received: by 2002:a1c:8008:: with SMTP id b8mr10073189wmd.43.1584712320376; 
 Fri, 20 Mar 2020 06:52:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvcvCSlIxxaTkZ9gRjNX/PgF+1hfL4pqbTC8raVEIh3m75BPanZNMmTFh/5+ROFq9NZud5NAQ==
X-Received: by 2002:a1c:8008:: with SMTP id b8mr10073153wmd.43.1584712320023; 
 Fri, 20 Mar 2020 06:52:00 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id u7sm7878939wme.43.2020.03.20.06.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 06:51:59 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] lockable: replaced locks with lock guard macros
 where appropriate
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Daniel Brodsky <dnbrdsky@gmail.com>
References: <20200320120456.1931482-1-dnbrdsky@gmail.com>
 <20200320120456.1931482-3-dnbrdsky@gmail.com> <20200320123348.GA3464@work-vm>
 <CA+ZmoZVp3M0oF-qVbwkBa=OcO_Q-uTYEO8J5-hXj=G4Rnu9yNQ@mail.gmail.com>
 <20200320125634.GB3464@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6b4cbe4-4cf8-7c27-036f-6e180c45e28b@redhat.com>
Date: Fri, 20 Mar 2020 14:51:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320125634.GB3464@work-vm>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/03/20 13:56, Dr. David Alan Gilbert wrote:
>> According to https://wiki.qemu.org/ToDo/LockGuards cases that are trivial (no
>> conditional logic) shouldn't be replaced.
> OK

I don't think that has to be either-or.  Trivial lock/unlock sequences
are not the first ones that should be converted, but there's an
advantage in having a single patch that converts all possible uses of a
lock.  Trivial sequences certainly do not belong in a bigger patch like
this, as they would make the patch even bigger.

> So for what you've already got there,
> 
> For migration:
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 

Can you just extract that and queue it yourself (for 5.1 probably)?

Paolo


