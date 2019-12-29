Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1678C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8767A20748
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKTCKjlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8767A20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilh7r-0007l7-Mp
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ilh6l-0006z9-6t
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:32:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ilh6k-0001Me-3f
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:32:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30397
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ilh6j-0001LI-T9
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577658740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0Vmrgf/tlFq3uzsUdLs7eo+y3Jw4rPPlzqHGohE6N0=;
 b=fKTCKjlwxliQ8XuviFPh3OtuWMKR3d/UOe5bqILlE6ZbeZ2pjcciUxqojld9jc9qf7U19h
 kkmWIQRjmyjG/1eHLvI/J0XpkeFohpEwHcJycE+/PukZPS5L6MXlsOEymv9E3eTCpW5ELB
 X5TZkcp/vPDg4mLVqNtF/FBKTtN4FMA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-LJRISXMXN06pPVp9WOUgcw-1; Sun, 29 Dec 2019 17:32:17 -0500
Received: by mail-wr1-f69.google.com with SMTP id c17so10681316wrp.10
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 14:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bFh662LMsBqADDG6Hmx6APHpOPB1li0Ha3/3Wm6rkhs=;
 b=Iq6OHE08jV3mpRAQtsAUVlsA4tVOnknoV0ebRWj6FZiVo1v8gsRT1XZy1JcXZaBC/2
 8BhjgEfNrjjxmLwNTvJ3u2FKpPdAE9dz6MKj0jkFAaX8KdBRSgtesYVN9RQtxOQnNXmj
 oPNMfayXnXN4t2XNIULR/T9YfYVNE8zXd5OKc460HKI4cHbBEM8jezXDwJ2/QiA3k4rP
 LN+2qV0o4ur8wE66zbrvRpl/4/8OwYv24GcsVS4JvTVCsSX3crU92iV484X3j2hDux6r
 WWEZjZNyth5Og65DVmmdZyqgHl3sKMKmsx0UufT/5uKrj+1LDL5796WhbK/gY/7b7eTs
 drmw==
X-Gm-Message-State: APjAAAWKsSw93+7pZYZ6CpfUoA2+uGGyJKttMAAnjrfUtoxMap0SIXQN
 gOdoNGqRKzPcdM/pCj3XeVuonHk/2+xp/MwEN+rmJTfnLb1PG+49HYBLWyetlFsP39/y6qfPvbN
 ZvFRjnbKAjbhonSY=
X-Received: by 2002:a7b:c084:: with SMTP id r4mr29548119wmh.99.1577658735927; 
 Sun, 29 Dec 2019 14:32:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6KORLoyMIgoRlvganp8U/97vWN82s+t22TyMADBoAAATRbnLe0ac2VdQgkUWSnpQGU5UWeA==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr29548105wmh.99.1577658735787; 
 Sun, 29 Dec 2019 14:32:15 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id a5sm18856121wmb.37.2019.12.29.14.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Dec 2019 14:32:15 -0800 (PST)
Subject: Re: [PATCH v40 07/21] target/avr: Add instruction translation - Bit
 and Bit-test Instructions
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191229215158.5788-1-mrolnik@gmail.com>
 <20191229215158.5788-8-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8baeb67f-efa1-e7a6-826c-c252f627a19c@redhat.com>
Date: Sun, 29 Dec 2019 23:32:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191229215158.5788-8-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: LJRISXMXN06pPVp9WOUgcw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, richard.henderson@linaro.org,
 dovgaluk@ispras.ru, imammedo@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/29/19 10:51 PM, Michael Rolnik wrote:
> This includes:
>      - LSR, ROR
>      - ASR
>      - SWAP
>      - SBI, CBI
>      - BST, BLD
>      - BSET, BCLR
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>

Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   target/avr/translate.c | 241 +++++++++++++++++++++++++++++++++++++++++
>   target/avr/insn.decode |  14 +++
>   2 files changed, 255 insertions(+)


