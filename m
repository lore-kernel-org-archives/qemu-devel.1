Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A4AC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7FE20663
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gH4xHANs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7FE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLci-0007VK-Ab
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iiLX9-00084Q-CV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iiLX8-0007YP-Aj
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:53:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21041
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iiLX8-0007Xk-5r
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576860825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fp5Omub8AuN7t5W84nXIABU4uqK0fYoWUw5C+nS7Zms=;
 b=gH4xHANsWvLZD1TqUa8NrYnEd8p3oKlO/j/OF5do+isTVpfoYFdk2PWqWf/3n82mgzGOoE
 vFEFcUux0QPrGIdANiLm7esHLWriTytuEP2ndCNWjLsUXlFx57Za0cBLgrXNVuJtXq1YAe
 xaa4UOhSLWlmVjJdOUwGs+WPTGvnUTk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-IwuMTj3-NLuUOYvfIwP7gw-1; Fri, 20 Dec 2019 11:53:44 -0500
Received: by mail-wr1-f71.google.com with SMTP id o6so159721wrp.8
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 08:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fp5Omub8AuN7t5W84nXIABU4uqK0fYoWUw5C+nS7Zms=;
 b=XMXLBSczRn2c1gtuJnOCmr6siSCMVJm/G9f0xuVdiNU28rkYy7+MYotRDpgpM39tzz
 XupUWwIFMfZz4Cw8mH9PMvaVVg1xYwfLKIHepPCPnHvLQbGnceaIqvvwERSVvNF8aQfd
 r269LLMmvmUUlcOMw2sOZCVB2mEnZN7tU6yZJAFZAKV9JA3D8SDa42EpR2v55avrtS0F
 EQvxDnx14VdNigp3M0+fvUj1SvrBy6Xt6l4qm76wYF39OQ1NlDA/Y3NiPpft5uSlysJ7
 a5k/n6nnaE38bQQKZjMCeJzMEsWyGUCAbKw0opLVvJJgXLe2qvaw1P75nKc46jEKOb3+
 Zm+w==
X-Gm-Message-State: APjAAAXvk7knG5EWvn4bnmNaJqiuuR49ks3hO4sSKyDljPnAzbRD2mQ1
 rFUjDp5toMXKWR/oD3ljk4n3e/pEV02LnnB/SJ3xMa4Ya2N0WCOK9hW4mJD5lJcxjKvAVXLDsli
 +6VQdZdUKChpbnfI=
X-Received: by 2002:a1c:a543:: with SMTP id o64mr16673268wme.73.1576860822584; 
 Fri, 20 Dec 2019 08:53:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEdF68cWwBpVOnOdZ97eRNbkK7LkN21Wo/vA3AQbuisSi/YUCCywAYoBWfCxMclYrTWhkw5Q==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr16673253wme.73.1576860822370; 
 Fri, 20 Dec 2019 08:53:42 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id d14sm10985725wru.9.2019.12.20.08.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2019 08:53:41 -0800 (PST)
Subject: Re: [PULL 0/2] Require Python >= 3.5 to build QEMU
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20191220165141.2207058-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5c6ea1a0-44dc-fa8e-f0d0-c0b139c9da11@redhat.com>
Date: Fri, 20 Dec 2019 17:53:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220165141.2207058-1-ehabkost@redhat.com>
Content-Language: en-US
X-MC-Unique: IwuMTj3-NLuUOYvfIwP7gw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/20/19 5:51 PM, Eduardo Habkost wrote:
> Differences from the previous Python 3.5 pull request
> that was rejected:
> 
> * Now tests/vm/netbsd was fixed
> * .travis.yml is being updated to replace Python 3.4 job with 3.5
> 
> The following changes since commit f59b31e6d0c69792b5d817c5aa0a6ed64fba42e0:
> 
>    Merge remote-tracking branch 'remotes/stsquad/tags/pull-tesing-and-misc-191219-1' into staging (2019-12-20 14:00:49 +0000)
> 
> are available in the Git repository at:
> 
>    git://github.com/ehabkost/qemu.git tags/python-next-pull-request
> 
> for you to fetch changes up to ddf90699631db53c981b6a5a63d31c08e0eaeec7:
> 
>    configure: Require Python >= 3.5 (2019-12-20 13:45:59 -0300)
> 
> ----------------------------------------------------------------
> Require Python >= 3.5 to build QEMU
> 
> Python 2 EOL is 11 days away, we will stop supporting
> it in QEMU 5.0.

That was quick! Thanks for sending it again today :)

> ----------------------------------------------------------------
> 
> Eduardo Habkost (2):
>    travis: Replace Python 3.4 build with 3.5
>    configure: Require Python >= 3.5
> 
>   .travis.yml            |  2 +-
>   configure              | 18 ++++--------------
>   tests/Makefile.include |  5 -----
>   3 files changed, 5 insertions(+), 20 deletions(-)
> 


