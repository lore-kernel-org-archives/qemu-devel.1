Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27413CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61442064B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dh8ox3l7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61442064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbf2-0001lE-4h
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbYz-0002g5-Ef
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbYy-0007Yi-9u
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:33:49 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMbYx-0007TN-7j
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:33:47 -0400
Received: by mail-pg1-x541.google.com with SMTP id k20so8235450pgi.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RfpCMPAfJ5FAZVd1/jCmUc+GumO48EkPyc2dotCRUQ4=;
 b=Dh8ox3l7+13L8v02/fylkP1K686iUgrbvTPFdq9Zb+Ks0OLpFA9k9yr2AItTZxb+kh
 +8zAygPP6HZNzLKZ2SS4/HgQ1FM0FqY59Nav2ue1FLKzsI6BTDidey7B3UwZ5icTc6tl
 Mx7nG9Mp6bRxRhKfdw9DLVLsoTIoP0nx6dxDPeVQu1bxqVeoY5GoK9NduINPqqCrpIW5
 EliSN5Q0c6mTOLYLdIyGTUjYAC+VT5hWkkRq4dWcDBgA6AKqVDGvqXZkcYL3CheVcTUF
 VKrw8TsCJ6JB9ay2roaDQznBtiinAfcKdanyCXSI7/5HiPnuQ6l622LLSgmrw56nbbrn
 E0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RfpCMPAfJ5FAZVd1/jCmUc+GumO48EkPyc2dotCRUQ4=;
 b=WfiNLX00wSIY2dL0kuFto/+gJvV1jwzxUzHrUuxxJ9bZViIpSdcXcK/Ys0PN+ifbDv
 IMiz1LNzbB5J2Sdes8//C8McWH1ARisGTKEVHPXq3MAcZ+ck9Z66FAsud/Q80aJE76cB
 8L7X9803zY743lLEcICqP9BC6KjLKQbjOlDPIPJApnOyroArK2mAUvon3ZDTcIH6H7SV
 x+d1pFjYbO5C/S8yLfvK3devXmd2mff0zP65uspKvfBWdJVcJeAWw4bwf1ToyGxwSYsj
 pSh7mKGRPSjiPuw+kCftqs5UYe3LMAG6yyJOUM/cbW5zp/QGKk7XcjQ8opP2TCj3E/CD
 072w==
X-Gm-Message-State: APjAAAVAChRGO1TWr3J4DcR7eGOSNDd1+AM+NKBXNwah2Ss7l5GgjtDx
 N1Zw8qnK/UH3kN+eNMDej/l73w==
X-Google-Smtp-Source: APXvYqxMaKLsGa7GvE/iyhX5zswh52/14YHRvBNOHJTA6WE7xyKyBlFxURX16Hq+Z7aLCHGNSRV8hw==
X-Received: by 2002:a17:90a:f0c5:: with SMTP id
 fa5mr29888785pjb.68.1571679217410; 
 Mon, 21 Oct 2019 10:33:37 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 196sm18393714pfz.99.2019.10.21.10.33.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:33:36 -0700 (PDT)
Subject: Re: [PATCH 20/21] hw/sparc: Let the machine be the owner of the
 system memory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-21-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b9bb1ef2-c02b-a1a5-f4b1-487101b793d5@linaro.org>
Date: Mon, 21 Oct 2019 10:33:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-21-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/19 3:56 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/sparc/leon3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

