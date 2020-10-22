Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B308FC388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DE122267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkzD+Osv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DE122267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVYUN-0007hi-Tv
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 07:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVYSy-0006mU-Rq
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:09:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVYSv-0002MZ-JK
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603364944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ybuCH6zDh9OlLsOzpWgK+yR6ZZ+K3WiqiQL+vxYpRQ=;
 b=EkzD+Osv191Zg1l2u4QvGmUDt9U69//xAoUmGTBiPqp7uD1kIYoP72+XoeTBfpHeUpOnEE
 Wxop+47johcyXVyO9oYExR00MRA3iE1ExAMFcX1DLfrk8xZW8Etjr4VZRCA6wP8K05vWcO
 NCViINBA0eXJnMBhf4ejvZSe5Q4RP6Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-lK6D3OjmMq-vBEH8O-_qqQ-1; Thu, 22 Oct 2020 07:09:01 -0400
X-MC-Unique: lK6D3OjmMq-vBEH8O-_qqQ-1
Received: by mail-wm1-f72.google.com with SMTP id m14so304835wmi.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 04:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6ybuCH6zDh9OlLsOzpWgK+yR6ZZ+K3WiqiQL+vxYpRQ=;
 b=uXpE1bXg7J6PFE+jTcHMhmdjJ6SG3O5Fw226X9ygbjh9Zea0aqfN7bbhca/+ovKQqb
 JuotsV7dywaGlQfXlzpzQod+2W81qLu98lecvS96DcUiMYCCAodrxipj4efItlp40lbV
 kFomDE8aTCbn2jMcJxr1hVIpsE5ucpf59fiCRK7YmBI5DsoUihjvg9n4ihh2HTeBALzY
 vi8SKlODGfA6jDXfvGSxiOC4g4PzWGnsvrRHKyL3yFmutZwpVhv2O2QgyX8M56cdiO9D
 0P4g5ctOEc+XMYUgL60zUFUNXPCfdSlWuQ56UNd5NO1eJqZJxc6PouME+8FWWGece2sv
 VI7w==
X-Gm-Message-State: AOAM530EGoR2J7p++GMsn+QD5gWQ5GgJnNMGPYm0WIgPc5Dp07bseALV
 SgVVxDL8/VkAf8J8K/RMVmIL0WpihwyqEQHSoyDTBxanTqvNgNSNYkP/yvt5Fz9BIVuaKtq9gFw
 r58yVryEEVzhJiSY=
X-Received: by 2002:a7b:c183:: with SMTP id y3mr2006588wmi.84.1603364940652;
 Thu, 22 Oct 2020 04:09:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6LIDwaAi33TnV0pQ3Icm9SBMOoE945ZeAYJNqAUdS0baeiUWOuyxZA7zCYQw0LB75Illayw==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr2006571wmi.84.1603364940491;
 Thu, 22 Oct 2020 04:09:00 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id y185sm3039223wmb.29.2020.10.22.04.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 04:08:59 -0700 (PDT)
Subject: Re: [PATCH v1 4/6] gitlab: skip checkpatch.pl checks if no commit
 delta on branch
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201021163136.27324-1-alex.bennee@linaro.org>
 <20201021163136.27324-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e52bfb38-0aa6-6724-e6fd-01c9e88ea4b3@redhat.com>
Date: Thu, 22 Oct 2020 13:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021163136.27324-5-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 6:31 PM, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> If the current branch is synced to the current upstream git master,
> there are no commits that need checking. This causes checkpatch.pl
> to print an error that it found no commits. We need to avoid calling
> checkpatch.pl in this case.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20201019143537.283094-2-berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/check-patch.py | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


