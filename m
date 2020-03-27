Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13726C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56D020737
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WND5Rr96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56D020737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHs4h-0005Tj-3b
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 12:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jHs44-00054t-JE
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jHs43-0000EF-Jh
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:42:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jHs43-0000Db-G8
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585327355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3wzB5De7ATj5AIgqnI7jha9G1quxvo/+4d1iLzRjPR0=;
 b=WND5Rr96wRhl7VHYqMytiKTsG5CpaNwgNbop21gOH2C9xe4+gGWZFq8M7Ib4RFmneFfoqY
 NPTSLMCB8tWdj92omCbyeg5VaTuCadajk5ImKbs9jij8fHbaubGdQSp7PRZQ71ZglKGIdX
 3VWULvvHOy0gDy84XrBHAWwLV6iXsG4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-MPFregK2M6CKLn7D-dQU0Q-1; Fri, 27 Mar 2020 12:42:28 -0400
X-MC-Unique: MPFregK2M6CKLn7D-dQU0Q-1
Received: by mail-wr1-f69.google.com with SMTP id w12so4796656wrl.23
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 09:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3wzB5De7ATj5AIgqnI7jha9G1quxvo/+4d1iLzRjPR0=;
 b=h6rWXkcbKL4uVOA5lYBFBvEEoix5Gg+oFEp+FzRsov4YGMevmxrrw7KdaOi25fEMj2
 xssoRvclbXnQQe9M66RiKyxkTeIK8Tyey3bxzag1kOAFjohhX0/p7Z7kg5pi7fQJkWCI
 WvgcB1UvkHy4+sXuswFct8FcHMO1zlkskFZg10vaehB+XiQWEeoC0ErMwCS6fUONknbN
 Xjt0AiQTRnirB57i2sfNGCgdonHxi8r2cah+Fi1gYoxBuzaaqwXoheTSz14UH3SKZWTg
 y0UfZMRbFQgbgnpNjGMRV7dUTgVen/rtTY+6wOST8QvGeHEXj2JCGawX2sifPRCy+nm0
 PRNw==
X-Gm-Message-State: ANhLgQ0IcIuUK05FL6Jw6wlfc8Y82NS6ebZNn+GM/d9BCGVKEPOu+9HI
 IQLocwZW/6d9rbBfG7BaMB4efq/kwrqjkzFY+KnZyy9msiIVqhSvfARNvplppKaZlXnajZmsq08
 Iz2HfxWNUP+S5qI4=
X-Received: by 2002:adf:edd2:: with SMTP id v18mr298631wro.55.1585327347421;
 Fri, 27 Mar 2020 09:42:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvp/OLxwqBeTVtcTOZAnfdT0ze853vEiz7KWHsE3UE3ogC2MHDiieeELo3e4PUZCxYuQip5lQ==
X-Received: by 2002:adf:edd2:: with SMTP id v18mr298613wro.55.1585327347227;
 Fri, 27 Mar 2020 09:42:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea?
 ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
 by smtp.gmail.com with ESMTPSA id m19sm8901234wml.48.2020.03.27.09.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 09:42:26 -0700 (PDT)
Subject: Re: [PATCH for-5.0] xen: fixup RAM memory region initialization
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200327104828.12647-1-imammedo@redhat.com>
 <20200327173622.0fb2f5dc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ddf9ac6-884f-f791-2dbe-cae10b855d1f@redhat.com>
Date: Fri, 27 Mar 2020 17:42:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327173622.0fb2f5dc@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: anthony.perard@citrix.com, rth@twiddle.net, ehabkost@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/03/20 17:36, Igor Mammedov wrote:
> Paolo,
> 
> could you take it along with Olaf's xenfv patch?

Yes, thanks.  Also your other patch.

Paolo


