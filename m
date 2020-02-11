Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9E6C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C832A206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+BN+nPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C832A206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZuY-0000Bc-VY
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j1Zto-0007w4-W0
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j1Ztm-0002nC-LR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:04:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28752
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j1Ztm-0002kc-GA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581444275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxioH2lHQhclurMyTdSDtGzja4mOiRq8u7D9CdGwZAY=;
 b=B+BN+nPfEj+HJVdoZptDBaAkpz4PHBGUw2QYfImcWkZxYVkyKdV1p3ZCKX/chy0sbEfXAV
 rm9uylJk7GNddj8sV2BGH/Rxm8aWvFhupN2nuYTm3ile2Cxnf+9XfFqlGWWtSWcEEVEnij
 UwuDntwGtAZ/oWnh3T9RXOWY45Il3MI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-njru_OQ4NayTJ2e5Wx3xuQ-1; Tue, 11 Feb 2020 13:04:25 -0500
Received: by mail-wr1-f70.google.com with SMTP id m15so7228330wrs.22
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TUntVZTjiFetO60JspdOtNIZER/DyJcfSPlH86kfP0U=;
 b=klbFZJPvrOy2as0bBkdTllBd8Mh3lRLVGwy+RABpnKrRy8pq8lfsAvJFAKQxFrFK+E
 F93wd4l/XnVRRkNHW79jSEpn5LKC205LHVTJrCgmTkUNpP9b0Yz4aisTK22IfaNfqZ7t
 JhBwKkxkrarTPVXHn6oA+eCdye3B1Gu04MFbFbfGWyxOblj0W15N7NfktWJLuaLRpstg
 dZZSzZxo5QjyQEpJbGVc4W6CTVlTXmM34wZHUyGVf3WtDjl31SWwOsN1W3S6+1qruGyW
 du5dESe23Hzpg84rcC23O2OyRD/4JGpLVFZL8mAbJE8u4ls2T25JzUVZLE2RMymBosRc
 GvkA==
X-Gm-Message-State: APjAAAWOehOi+w3rM4+0v3o18aHlbhg1dA+saEq1SC5Vi7bs13gJGxn/
 2UoRXMPDTPphk1X8jVUWXDkHBPEp8ye67NGiWCH0D+S4PilYRQxzUPst7GqMKPCysv6NbQ5H89a
 52v0wyzXNC78hfvE=
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr6458821wmi.146.1581444263850; 
 Tue, 11 Feb 2020 10:04:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqyfqPMWyqMXUz7gUWzLli3/68fWinBModYTyie6A9jpix5wfEx0ibAmCs39sBk/AtDaxB7h+A==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr6458794wmi.146.1581444263618; 
 Tue, 11 Feb 2020 10:04:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9?
 ([2001:b07:6468:f312:652c:29a6:517b:66d9])
 by smtp.gmail.com with ESMTPSA id g17sm6311193wru.13.2020.02.11.10.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 10:04:23 -0800 (PST)
Subject: Re: [PATCH] linux-user: un-register threads from RCU before exit
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200211173510.16347-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2429139-b27e-2c05-8b8c-ac57fae98c4d@redhat.com>
Date: Tue, 11 Feb 2020 19:04:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200211173510.16347-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: njru_OQ4NayTJ2e5Wx3xuQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/02/20 18:35, Alex Benn=C3=A9e wrote:
> Through a mechanism I don't quite yet understand we can find ourselves
> with a left over RCU thread when we exit group. This is a racy failure
> that occurs for example with:
>=20
>   alpha-linux-user running testthread
>     with libhowvec.so plugin
>     but only when run from make
>=20
> This may not be the correct fix but it seems to alleviate the
> symptoms.

Can you explain what is the effect of this left-over thread?  All
threads should be terminated when the process exits and I'm not sure why
the user-mode emulation is special.

Paolo


