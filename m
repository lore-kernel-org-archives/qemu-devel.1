Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ADAC4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AE021D41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwj1ZXHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AE021D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWPhE-0005Pd-Bn
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 15:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPfW-00045g-9r
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPfT-0000DY-3M
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603569453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1djc2uC6li7icZmBiP53sYdm4keIKkSxKA0UycuWZ8=;
 b=iwj1ZXHdan4Tgcy0NOO5uLDnd2nTBa8nZJ4gFaJP7egh1hM4b24swMRi0vt0NGN37W/kq4
 oDJneiWTpfoWsdCIm3QXWbtbdM+yPIitPIjsO9KtfK+QFmlBURTkrFKbDcYd/n3qV0U3P9
 mXjXZ3Vf9X1SmDl0HE8ERnqCh49TCgY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-nZxdMTt4OEOKnYXN_I1MVw-1; Sat, 24 Oct 2020 15:57:31 -0400
X-MC-Unique: nZxdMTt4OEOKnYXN_I1MVw-1
Received: by mail-wr1-f70.google.com with SMTP id p6so3677365wrm.23
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 12:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L1djc2uC6li7icZmBiP53sYdm4keIKkSxKA0UycuWZ8=;
 b=AZlT6QxMk2kZRXP+8bMCRePP8fbVGzkpb6jyyTlC/rgbhxdw1im2cdUOPXoQHJlIwz
 MPe77D5JZ+TvKtR1nfovd/75PZ1EjELmjeKOYDHIZ9/1bTAfMUNT4O667xsu53jHhxYg
 Pne5hTrSXXtbfvhagdTymb5DKJdJ3HtTHnVU2OTEjwLaWtaPUzg8+RxddacCUj66ioTY
 Y7bfwBSiNHgyowA2nZVJk7+f0icZJ0hQ6cM5O9KPON/ZoHDqTyJ6fhWm8P6mrCpwcl9M
 80rGqwgN38bYgTSb6msFUSl/AYivqTNpAWUddcC/V5+c7PBs8ptYpPVdGQt5B7AO66ka
 qQpw==
X-Gm-Message-State: AOAM532pJVjWECivTxT2U9+PXY+H5JNrZu3vBvKLZ3W5rYbzr1o4Jr6U
 ZbE2ULkWtAq6TvZJLwZJmvSN5aDsKieglErG9tsklzsYhnsySKnuZBXCTj3sTKQoz4V4EG7QsUQ
 5MIOd8XJS6tvWG9g=
X-Received: by 2002:a1c:bc06:: with SMTP id m6mr8953995wmf.68.1603569450378;
 Sat, 24 Oct 2020 12:57:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/mv4K3ScjY1s0QkROFoctCEDO16ZLg8kE1vBeuRvsCP/60l9Z6BkV2691AeymEDwULCvdNw==
X-Received: by 2002:a1c:bc06:: with SMTP id m6mr8953982wmf.68.1603569450192;
 Sat, 24 Oct 2020 12:57:30 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id l11sm12302142wro.89.2020.10.24.12.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 12:57:29 -0700 (PDT)
Subject: Re: [PATCH 07/15] scripts/qom-fuse: Apply pylint rules
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201021185208.1611145-1-jsnow@redhat.com>
 <20201021185208.1611145-8-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a57f69ae-49de-159a-29f1-0d19d49953fd@redhat.com>
Date: Sat, 24 Oct 2020 21:57:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021185208.1611145-8-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 15:52:22
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
Cc: Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 8:52 PM, John Snow wrote:
> - Catch specific exceptions from QMP
> - Reraise errors with explicit context
> - method parameters should match parent's names
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qmp/qom-fuse | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


