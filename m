Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D5FC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9042E20730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dju5ij/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9042E20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0qW-0005if-QE
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iz0pK-0004O8-4U
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iz0pI-0005Xn-U1
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:13:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29409
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iz0pI-0005VM-P7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580832804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sR1BQf3PlmYd+8reaYQpqxbcRtzvZTljknl9mYjG/gY=;
 b=dju5ij/1mEorhbSLUhRuMbcBGDogTt3eHvqJkSwjOC8CDZySHvU68rNVewlaGWab+5v5U4
 DFvBaHx1KPjyRNM20ZTgMsXl4aKKwudFRacMcO4dSXm7CdWgmQXki55plpcOolLLda3X+a
 skiTG/8QvwlBO99wtiQnLU6apBQ06CY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-7cFN_4V6OnCIfL3T6Un0IQ-1; Tue, 04 Feb 2020 11:13:21 -0500
Received: by mail-wr1-f69.google.com with SMTP id j4so10520910wrs.13
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sR1BQf3PlmYd+8reaYQpqxbcRtzvZTljknl9mYjG/gY=;
 b=JLZoMmf6TzZ+UXk/Rm0+o6YqzwzSRf2GSgA0tWqnL5MORnqbvGpIn4QR8vjQsU5AiR
 o3L3d48SUE3FygdBKJ1/dz9TxRMHlVe9r7bNRNppLWOas8CjhZ+TCOdeN/GNoAnrJI/g
 Q1TAMKQH5CR56ItvT1xAOzqRXBkydERPOp92UJ1IKFMGkhLkBknp5WvHtSJe+rkHOSFj
 +rnOvvB7osiWKS93pg6Uszmv7q/QmcFE8M89/zdtWvNu+PmbfxLPedW5ZycBiwxVaZav
 ilwrwwxGfzYZkNnTqmuOPHqysjktYHC/ZMIpl/M8ehHU1gv1m7CJCEOGVK7FBdURqEKx
 cfsA==
X-Gm-Message-State: APjAAAX/CZa0ncglHxmGeN9QRuNlXXpzOCTM84zBhvb20042DU8fgJ5i
 bmEoRkS6N/cmvPOvALgRTVFVahRu76A08xdBn+9O7UD3+FNgCgqipmOT+3bkldbFMPyhwgcX+kn
 BhUls3kQ3WsBmw5E=
X-Received: by 2002:a7b:c258:: with SMTP id b24mr6910125wmj.140.1580832800566; 
 Tue, 04 Feb 2020 08:13:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDI6RDsAvMZA53N+DwKIti5/0wPI1xP8cdlj6mO4qfKaoV6OfqajhhTb95nybsswMWzZhpUw==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr6910096wmj.140.1580832800284; 
 Tue, 04 Feb 2020 08:13:20 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id t9sm20660927wrv.63.2020.02.04.08.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 08:13:19 -0800 (PST)
Subject: Re: [PATCH v3 0/2] Acceptance test: provides to use different
 transport for migration
To: Oksana Vohchana <ovoshcha@redhat.com>, qemu-devel@nongnu.org
References: <20200203111631.18796-1-ovoshcha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a94c680-6e76-5ac8-45b2-74d9825e54fe@redhat.com>
Date: Tue, 4 Feb 2020 17:13:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203111631.18796-1-ovoshcha@redhat.com>
Content-Language: en-US
X-MC-Unique: 7cFN_4V6OnCIfL3T6Un0IQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 12:16 PM, Oksana Vohchana wrote:
> This series makes refactoring to migration test and adds new tests with
> EXEC and UNIX protocols
> 
> ---
> v2:
>    - Removes unnecessary symbols and unused method
> 
> v3:
>   - Makes refactoring and split into 2 patches
>   - Provides TCP and EXEC migration
> 
> Oksana Vohchana (2):
>    Acceptance test: provides to use different transport for migration
>    Acceptance test: provides to use different transport for  migration
> 
>   tests/acceptance/migration.py | 52 +++++++++++++++++++++++++----------
>   1 file changed, 37 insertions(+), 15 deletions(-)
> 

Series applied to my python-next tree (splitting each patch in 2):
https://gitlab.com/philmd/qemu/commits/python-next


