Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31D8C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5072176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJRUxrBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5072176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j40vg-00086D-Mi
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 06:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j40uz-0007Jn-8I
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j40ux-0006N0-Qf
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:19:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35882
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j40ux-0006MQ-MO
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582024794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G6u1yunyP/23w4WDGSFYWBiZtX5ujwBx7j3VLy7VJrQ=;
 b=OJRUxrBvKB0an/54mS0GDv8w9Ky9YTN8qK3tq9ANrFtrX+TBDX8y5D+nONVdsjRnNHCcIV
 12Mm50PokZsNPBChkBEe9CQmWZT1dy9bCBZTbXlbmfwRlsr7Lxsdl5wli2cBh8+oYbvKtJ
 zyP+Ta3PDKkiUmfMNkIFAjMoTleEq6k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-TB9E-HQOMVO5qmzuEu4fsQ-1; Tue, 18 Feb 2020 06:19:52 -0500
Received: by mail-wr1-f69.google.com with SMTP id z15so10684765wrw.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 03:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G6u1yunyP/23w4WDGSFYWBiZtX5ujwBx7j3VLy7VJrQ=;
 b=mhKGPwjOXSD5j5Y8kPZMHW+kV8X/hml9d9relLZ9nHqJRpvQgHwTr46QJW4to5WSIX
 wyCzosu3rYrqc9AdijGzLEImVy48R5vPgNidroVedLNId/dTl+nrNxHvkTY1e2/1lSFg
 pLXUnGsWPRqpfanHN+PphD5tjEBDJTto3ud7cRftKO25wSvevTThoZzB3rE25DQcXeXN
 C1EeT3v2y/fIjKHOj2V7M/TUnahJhbALs0+ya+UGe7M6Yt80gQHQhb8JpSrKjNrPh5D3
 egl1L7ROG0f+htJj6XSYGqhq6GelhpA/oZO+xXyBCh4yeNUf0TLIFGNU0gujZQv4Ogou
 w+pg==
X-Gm-Message-State: APjAAAXlGWlA6Puraec+bZJJ/BZPSH7oN0OGqZHSu6AonzCXI3A79usO
 NU5A67ipIZ5iibJPwdQB0HAMyLi554p+QWdKYW6Fz5ENI1XgXSrEZPbYqqJDQVZo3qybzRCyasl
 lgXer57hlnIcCX9E=
X-Received: by 2002:adf:e906:: with SMTP id f6mr28216993wrm.258.1582024791890; 
 Tue, 18 Feb 2020 03:19:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqwp6MzhnguRfW727NYSmZtEZ7pAIcuviMSOfdSUtBOPDodYOK6DwRts4RCvKnGYpT4sDQfDJA==
X-Received: by 2002:adf:e906:: with SMTP id f6mr28216959wrm.258.1582024791624; 
 Tue, 18 Feb 2020 03:19:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4?
 ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
 by smtp.gmail.com with ESMTPSA id k10sm5739820wrd.68.2020.02.18.03.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 03:19:51 -0800 (PST)
Subject: Re: [PATCH] Avoid address_space_rw() with a constant is_write argument
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200218110137.22161-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6db2038a-099a-9f7f-1b27-07a13896de82@redhat.com>
Date: Tue, 18 Feb 2020 12:19:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200218110137.22161-1-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: TB9E-HQOMVO5qmzuEu4fsQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/02/20 12:01, Peter Maydell wrote:
> I could break this down into separate patches by submaintainer,
> but the patch is not that large and I would argue that it's
> better for the project if we can try to avoid introducing too
> much friction into the process of doing 'safe' tree-wide
> minor refactorings.
> ---
>  accel/kvm/kvm-all.c       |  6 ++--
>  dma-helpers.c             |  4 +--
>  exec.c                    |  4 +--
>  hw/dma/xlnx-zdma.c        | 11 +++----
>  hw/net/dp8393x.c          | 68 ++++++++++++++++++++-------------------
>  hw/net/i82596.c           | 25 +++++++-------
>  hw/net/lasi_i82596.c      |  5 +--
>  hw/ppc/pnv_lpc.c          |  8 ++---
>  hw/s390x/css.c            | 12 +++----
>  qtest.c                   | 52 +++++++++++++++---------------
>  target/i386/hvf/x86_mmu.c | 12 +++----
>  11 files changed, 103 insertions(+), 104 deletions(-)

I agree, but please include the semantic patch in scripts/coccinelle/.

Thanks,

Paolo


