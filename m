Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40247C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3A5208C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9m5optB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3A5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j92sG-0002c3-6w
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 03:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j92rb-0001sq-OH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j92ra-0001NM-GV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:25:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31649
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j92ra-0001Mp-9n
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583223913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FcWGSBE2EkydazOQwLb0MlmwKMYVz1MGYzJxAoobqX0=;
 b=N9m5optBIeGs/aAadEea8tibCCN5WLVljiC8h6rIL0RxMqT0pyaz81t3/gIfTnZSajU05Q
 0FkXlisb9gqv1rcB595y6sQrZ3Fd2w9wXLG5jmAghMcrMYYudiXOr3HxZZJ1Ep4QMiHF10
 nDLl1S3RutyZB/xTs6TngrdiR45kUI4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-e_j3-xFnMTiLuREOTqg0NA-1; Tue, 03 Mar 2020 03:25:11 -0500
X-MC-Unique: e_j3-xFnMTiLuREOTqg0NA-1
Received: by mail-wr1-f72.google.com with SMTP id w11so878918wrp.20
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 00:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FcWGSBE2EkydazOQwLb0MlmwKMYVz1MGYzJxAoobqX0=;
 b=Xtmm9CTfn5J8heLkUOGU79SI7Tn2sdKaG0e9bSp4ZDZxBZxBBChCqdyEvRGjaqBEQc
 lAkmJfdV+45U9/h7oDTcYmAzkrzLrYkMwGF4kKv8NLcGqkRAggIuq04v70fwz41g3NuW
 XwAZo9ImNvRyDQBH7Iitrqke2vIE+CoMZfgjUANKAC9cOnrgjktFSpfUplTZNiJbZqIG
 6SSQVCFhcbzJcb7BrhhKtwEYUgLRr49E0R9eimp/2eeLsDmlvdi8NGxzP17qBf4Apk4P
 2nKU2FvtRLwWy6LFjxDi67Yjx1xGncBWGE0SN2yjz0/RakxdmBjc0WXOhXIhsbwVTWRK
 C6Ww==
X-Gm-Message-State: ANhLgQ3BhjDQMlpFxNu+wJDEPN8Oc5g+BUAH1iqwIViD6yxTA9CGXYhC
 GJYnOAhjemnirlp5ogK+tqvKKzrzzUpmPI4PfMxPPE9zRT+YqEcZPnwhciOsXLidxgVi2S6Uvjk
 mZsweJGLGSD7KMU4=
X-Received: by 2002:adf:828b:: with SMTP id 11mr4182867wrc.169.1583223910494; 
 Tue, 03 Mar 2020 00:25:10 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsATh9DnwIaW8VvNC14MIGbDtybBSicFWZY2bKDh3jgG0YFHf1qejDSV63F7W+XrrsLgD2hlQ==
X-Received: by 2002:adf:828b:: with SMTP id 11mr4182818wrc.169.1583223910217; 
 Tue, 03 Mar 2020 00:25:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4c52:2f3b:d346:82de?
 ([2001:b07:6468:f312:4c52:2f3b:d346:82de])
 by smtp.gmail.com with ESMTPSA id o18sm28324367wrv.60.2020.03.03.00.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 00:25:09 -0800 (PST)
Subject: Re: [PATCH v6 0/4] Improve default object property_add uint helpers
To: Felipe Franciosi <felipe@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20200204131601.125677-1-felipe@nutanix.com>
 <CAJ+F1CJLvKtSnFFurBUy4LcP+DqNTtqHd4oevJADfW8JEVuXXA@mail.gmail.com>
 <64CA08E4-01C2-4BB8-B2B0-163406E1CD6F@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1976a1de-f02d-6ddb-f020-e2609618bea7@redhat.com>
Date: Tue, 3 Mar 2020 09:25:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <64CA08E4-01C2-4BB8-B2B0-163406E1CD6F@nutanix.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Phillipe Mathieu-Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/03/20 09:05, Felipe Franciosi wrote:
>>
>> Paolo, would you queue it?
> Ping: did this get lost?

Yes, I have queued it now and fixed the conflicts.

Paolo


