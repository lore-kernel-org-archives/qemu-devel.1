Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B16CC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E20222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0lKQnV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E20222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUu5R-0002oq-6R
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iUu4e-0001wR-IW
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iUu4c-0004ww-5Y
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:56:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iUu4c-0004wc-1t
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573657004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=hSyZLg3iNFB/VjiXjwhvki6gOVPosjITeZvLzxM9CV8=;
 b=i0lKQnV5Aa+XP8EkzN9Txzzq1bb0Z50GtP5pphjMIzxIdhvjHay7XskA/g7Gb0zAzc8/YM
 hCDA5qremKUdqKU6FAc8ywBGIorDoBgmy4ZNIur0kbZ/Aa2gVSaYW0fIhHuNp6PAW+gmLG
 87S/R6qCzxvBHwqBUjWRjfY2bnJs0Ks=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-bnx-1L5hOH6Xv-EE7XHaMw-1; Wed, 13 Nov 2019 09:56:42 -0500
Received: by mail-wr1-f72.google.com with SMTP id w9so1743557wrn.9
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:56:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gVEm51OtwHcVEP8YB627Pu6+uCfy3WFE71Hu4DP4kA0=;
 b=libDurHs77yeOuTFaviPYqTCBbIpbuDHSicerngSMziKpDDZPqA9J+0LzB7LlcTn3F
 ghemrRnqKNsMi/+XLPwigh6AfBDUh+Y+IYLKek9iW3gskziuHbBH2BwcM+D+ss/rDYAm
 QMHYe30hKvbfKoV2BxU8gn56c+rldpZRYa6h87NNN38ZBUW98DMaBckcJVXYoXwPCxsg
 FKcyqb5eW2j8S7Kj2BvaSw3zbw8q4ysIG41CPAIl2EZOjQQ4lsUaRSqpo5nPY6dW2rra
 pFps6+J4uBAwE0rf1wEWFH+U7Fs1yzNcZXZT1TKD0waJSt7XkXJsPYA5XZ+Igh6aASdI
 d8vg==
X-Gm-Message-State: APjAAAVHGyK6Cehl7ifi2wNIld220REprG4J483QtN8/tTH+KpzvZmyQ
 /h7NXj6L8XJbkye6b1+1/NamknVNWBISuw6xd1nZx361hjnEQEflAkQY3tkNPkzJu6E7OVKBxeT
 +oAjINEVcn+DYxrs=
X-Received: by 2002:a05:6000:18c:: with SMTP id
 p12mr3167255wrx.154.1573657001354; 
 Wed, 13 Nov 2019 06:56:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1jgRZUFLEdnrflIJyI9ChE0IPuiJUvSree8NGyS20G2KsX0XZl0Y42LWhNvDY/0ZDsBgKrA==
X-Received: by 2002:a05:6000:18c:: with SMTP id
 p12mr3167240wrx.154.1573657001068; 
 Wed, 13 Nov 2019 06:56:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:64a1:540d:6391:74a9?
 ([2001:b07:6468:f312:64a1:540d:6391:74a9])
 by smtp.gmail.com with ESMTPSA id z4sm2744124wmf.36.2019.11.13.06.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:56:40 -0800 (PST)
Subject: Re: [PATCH v2] WHPX: support for xcr0
To: Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
References: <MW2PR2101MB1116F07C07A26FD7A7ED8DCFC0780@MW2PR2101MB1116.namprd21.prod.outlook.com>
 <MW2PR2101MB1116F6FEFFFB607B07CF4456C0770@MW2PR2101MB1116.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4eb3d6e9-edd2-7303-c54b-171a64e7edb9@redhat.com>
Date: Wed, 13 Nov 2019 15:56:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB1116F6FEFFFB607B07CF4456C0770@MW2PR2101MB1116.namprd21.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: bnx-1L5hOH6Xv-EE7XHaMw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/19 19:52, Sunil Muthuswamy wrote:
>=20
>=20
>> -----Original Message-----
>> From: Sunil Muthuswamy
>> Sent: Thursday, November 7, 2019 11:49 AM
>> To: Paolo Bonzini <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.=
net>; Eduardo Habkost <ehabkost@redhat.com>
>> Cc: qemu-devel@nongnu.org
>> Subject: [PATCH v2] WHPX: support for xcr0
>>
>> Support for xcr0 to be able to enable xsave/xrstor. This by itself
>> is not sufficient to enable xsave/xrstor. WHPX XSAVE API's also
>> needs to be hooked up.
>>
>> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
>> ---
>> You will need the Windows 10 SDK for RS5 (build 17763) or above to
>> to be able to compile this patch because of the definition of the
>> XCR0 register.
>>
>> Changes since v1:
>> - Added a sign-off line in the patch.
>>
>=20
> Is it possible to get some eyes on this?
>=20

Sure, we're currently in freeze and I was also busy with yesterday's
processor CVEs.  But I will review the patch soon.

Thanks,

Paolo


