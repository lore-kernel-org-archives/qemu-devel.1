Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51151C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B63221FC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hcn7qN9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B63221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV8fJ-0003WV-U8
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 03:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kV8du-0002qD-TB
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kV8dt-0004QF-3n
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603265680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQUHQViuogUGfVv7iWTb29qtookIYDx6aBUykap6SNU=;
 b=Hcn7qN9ZxngcPvMJA43bJdAH34ZPGFAwLMM8LYsAeF7LdGgNg+rQdWL4bAMdll3yIPXV/P
 BwoMPLdu3hxS/RrgKigoHZLyLfluTVxw6+JvlaGkBb5yNmMelZ/4VunjGFwknS9AlHKTVO
 Vb+eOHLFaJKtqH7PW8w0c+llglYstnk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-M1BBlMhuODa1CU2Uy0Hb6w-1; Wed, 21 Oct 2020 03:34:38 -0400
X-MC-Unique: M1BBlMhuODa1CU2Uy0Hb6w-1
Received: by mail-wm1-f70.google.com with SMTP id f191so125459wmf.9
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 00:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KQUHQViuogUGfVv7iWTb29qtookIYDx6aBUykap6SNU=;
 b=OJWPa3ldpqmWYQfCm2GXUiNLODALJyvkQpmsE8g5JyOyTznD0/hNEn+Xc2TXGBKeBV
 Kv/XAOLci1fWIwb077mh05aMgObMBqGTDbnKMHmqZKYS3Li+ObCoQwIXR8iKscRdx3f3
 SZ01ETEM5Ou8FGXRPiK4QsqSPJhJI7A1tf82d2ikIGCiVmcZe7zCkf5BpNBuCTjJMxaG
 8sht2s6kZ1cIcxA57C16K5y8HgUwUCe0Mjf+ZODMK95XIw/jBXaPyZTBHVgC3e56mXsE
 DJHDUngKCdbYvCsqoGdOjBWoiRA5pnhQQfOFnuesdUSRupna0m64zGmCcxDCkfQmbCEF
 610g==
X-Gm-Message-State: AOAM532CLgLw+er56UZKBz/SnpIeNXcEvV+GrM7OSWSlUvX4RAqV5hRX
 8IRyETR5WWmLOPQbTEPuSEDQ6meeRKgrGjZrz9WJyF+0PlIgeh/cQerMNH+Q8mxEDTq8ZAbSiiQ
 BFjmCU6Q4LJooRbg=
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr2199396wmg.38.1603265677486; 
 Wed, 21 Oct 2020 00:34:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztVVk2J2UnMvWjDRWfmFUGPRXkVH5YkKltT3foxkR9J6qqTGum1t5gjCILnVkBRIPRFLXAFw==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr2199385wmg.38.1603265677277; 
 Wed, 21 Oct 2020 00:34:37 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u6sm1834411wmj.40.2020.10.21.00.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 00:34:36 -0700 (PDT)
Subject: Re: [PATCH 1/4] qga: Rename guest-get-devices return member 'address'
 to 'id'
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201021071520.2168877-1-armbru@redhat.com>
 <20201021071520.2168877-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0f29af6e-e134-4ccd-1946-5ababf40eab8@redhat.com>
Date: Wed, 21 Oct 2020 09:34:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021071520.2168877-2-armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: marcandre.lureau@redhat.com, tgolembi@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 9:15 AM, Markus Armbruster wrote:
> Member 'address' is union GuestDeviceAddress with a single branch
> GuestDeviceAddressPCI, containing PCI vendor ID and device ID.  This
> is not a PCI address.  Type GuestPCIAddress is.  Messed up in recent
> commit 2e4211cee4 "qga: add command guest-get-devices for reporting
> VirtIO devices".

Out of curiosity, how did you notice?

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Rename type GuestDeviceAddressPCI to GuestDeviceIdPCI, type
> GuestDeviceAddress to GuestDeviceId, and member 'address' to 'id'.
> 
> Document the member properly while there.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qga/qapi-schema.json | 17 +++++++++--------
>   qga/commands-win32.c | 16 ++++++++--------
>   2 files changed, 17 insertions(+), 16 deletions(-)


