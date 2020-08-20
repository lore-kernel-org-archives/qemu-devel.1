Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C713C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177212054F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2kBokaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177212054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mun-0004zO-DH
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8mpw-0007Yp-Bh
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8mpp-0003PI-TN
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597938634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EKdHiMImrBUeEfe2Mc5IU0CiBDyX/2fNYHUyVcaZ7oc=;
 b=J2kBokaNAJ/0yW32jL7UUbK5FoTXBwELR1NaLkr5hWb1urDb7hj0qrOMl44w2WkOjEUyDq
 3YeOlcZ/W2srITOrLENwPSlayH24ZGRlLkJit6rCXyYbQVN5gTN7p5qlboohIr694kKCRa
 Rxnk4hxKzMvqC+hnrK8yjaAnyxUx3rw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-UYrMVW0bMhGw1xmQVDLiVA-1; Thu, 20 Aug 2020 11:50:32 -0400
X-MC-Unique: UYrMVW0bMhGw1xmQVDLiVA-1
Received: by mail-wm1-f71.google.com with SMTP id c186so1101110wmd.9
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 08:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EKdHiMImrBUeEfe2Mc5IU0CiBDyX/2fNYHUyVcaZ7oc=;
 b=qkKwsXDFtvlt6LjUXbPhwbx5dL3fhhwgS/1ICoedacMTwyseFv0VuNYYJ0iUdw+637
 Ap657UV4G66AxF2UqyQKh7wKWGKzSyQKzaJHZ4GIANPXcB//FG2bTwr+BLBmdzzzAUCu
 NW1jJHKubDND4c/d8AObXMl+9H5vxDI/ejrio6yo+LRcO8GLcHc3gCgHkTQwVPZen349
 GdtYOTVxn2ei6e8R6jyl/9UrywxqQZa0fHQnTNWP0GQnRruEh8PyVZ500z24eT8ms4uB
 RN6onKgXzt0DRjreGw8ueO+g8DPTyTbmT6WGYw45ZeS4Jn1zjESEHIzuBd73dwoxYWyC
 i/bA==
X-Gm-Message-State: AOAM530tuP/8Y+c7fagfE4LjbDOHnR2jBOP6BU9g7mJhqLKRwkfaBGTZ
 Xun4nojuPQo9h2hQlzXyAd/9sIg/FzegyxwszI5482Qw38YUiYMKdbRKxQ4mT0gacj0mkYZ1Idq
 MK+XEt/YbjDVlfyU=
X-Received: by 2002:adf:ab0d:: with SMTP id q13mr3627495wrc.134.1597938631506; 
 Thu, 20 Aug 2020 08:50:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAfQG0MgRasLgysNP8GP+d8n+qVQPPfAbHlpSjlvgNgr5skChUryJAHD5VumNy+cSjH7c7tw==
X-Received: by 2002:adf:ab0d:: with SMTP id q13mr3627475wrc.134.1597938631255; 
 Thu, 20 Aug 2020 08:50:31 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id l1sm5445596wrb.12.2020.08.20.08.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 08:50:30 -0700 (PDT)
Subject: Re: deprecation of in-tree builds
To: Kevin Wolf <kwolf@redhat.com>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <alpine.BSF.2.22.395.2003212338020.36211@zero.eik.bme.hu>
 <20200323133244.GK261260@stefanha-x1.localdomain>
 <CAFEAcA9VPgQ1MPYhcda4tdxMuhMC5R9fd6D=OVOZKRLMO8n_xw@mail.gmail.com>
 <20200820105401.GA99531@linux.fritz.box>
 <9bdbb3b9-01df-2a6b-0c82-b58ef6e0edf9@redhat.com>
 <20200820133023.GD99531@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <80348ec7-4897-a2ab-54a6-2997ee47b598@redhat.com>
Date: Thu, 20 Aug 2020 17:50:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200820133023.GD99531@linux.fritz.box>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 09:00:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/08/20 15:30, Kevin Wolf wrote:
> So without that, and also without a mention in deprecated.rst, I don't
> think having mentioned a wish to break things a while ago means that we
> should just follow through with that despite the objections.
> 
> At least this isn't how it has worked for other patch series. If it is
> the new standard, I can remove -drive tomorrow. I've been mentioning for
> years that I don't like it and want to remove it, so people can just
> deal with it.

Come on, you're too smart to say that seriously.  The deprecation policy
only applies to user-visible features, users don't care if ./configure
&& make works.  (There is precedent for that: the switch from "make
subdir-*" to "make */all" was never included in user-visible documentation).

I hate to say this but if the Meson conversion does not land in the next
few days (I will disappear again on Saturday) I'm just going to drop it
on the floor and let people have fun with their Makefiles.

I have already spent the last 3 weeks on it almost full time and I
cannot really justify, to both myself and my employer, spending much
more time on a build system rather than fixing real bugs[1] or doing
shiny new stuff.

Paolo

[1] Though there's plenty of known bugs in the Makefiles that are now fixed.


