Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB06EC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5F72051A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPpM3F/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5F72051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDbtX-0001DT-DE
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 18:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDbkM-0005s6-AE
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDbkK-0006gt-64
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:28:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24607
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDbkK-0006Yk-1L
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584311315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGyGswra0vppqhzmM7kZUQGbb/i1eJCg5TX6PmB4si8=;
 b=JPpM3F/8EbW1TWOwKXV3dIBSShO6RfS46Fgfd5Y64DFlGgYc1KDzALgTPkPDARgjvMZ5V4
 4fnHl8be02DfM71W1J679ElmkuCvnIZBM2gnlUDJOJ8sq+clKCcSLs5P5PW9nTwiCOFVfK
 ECNbgdrPVg3K6yKr2IKOEAvAyPrckLE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-ew91L9-uOPubMG3jOqC2lg-1; Sun, 15 Mar 2020 18:28:33 -0400
X-MC-Unique: ew91L9-uOPubMG3jOqC2lg-1
Received: by mail-wr1-f69.google.com with SMTP id g4so380538wrv.12
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 15:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qKiK+efqrpk+y5Dkxh5f4OQ0f8fFMMyYobmm/4lpc5s=;
 b=p/nLKsWiQzRm7EFxJ6UhkM8vHPVGay96yGPvbzMu4Ibe8CYJrhBMO9X2pqqtvI5VrK
 M4k25A2ayN2bzNtID0NEMf5iueWqZs78qlGHnaj+c6coZlh96I/ptWW3nDNnVIBE52Vv
 uZrPrX1MuB85A1szv4JdwWzBcXkAPGfauxpfshvRmPCvuU95qHIF4u6Ax9qjbKzxrGS8
 iO6Yf7NLjXGOG3Dll6S7jHtUHB03444ACF+7hRgdS9PVsUMCvH7EWmcDGtIWKdfK1aHr
 56dExeT8WSvMgwMUZ3pD0k6c+LmDTEEImFiPd5YqFhWwINsm1WWEBIP3c4z9NPjyhDia
 RfLA==
X-Gm-Message-State: ANhLgQ2atgQN3hzwU0bmp/YxukxO0ATljtPhL8HBiX0ABmp7+NHB+bqj
 HS1GF/hUbOhbhnEY7U0i3hU9RvwlRFNf7tcpa12tjYXZVTnvaAlv4cVLUrpQlC0XnD8wwN+bqNO
 VGGLAn9JJDp2Qb+E=
X-Received: by 2002:adf:e54d:: with SMTP id z13mr32862779wrm.277.1584311312290; 
 Sun, 15 Mar 2020 15:28:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvTtIuYwBgkd4R39m8bGvxYRQ4OoQPzMBKu+VnDiBvFWtiFHgMk41BSRsbFi4/3uBMccLgkLw==
X-Received: by 2002:adf:e54d:: with SMTP id z13mr32862764wrm.277.1584311312107; 
 Sun, 15 Mar 2020 15:28:32 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id h10sm16920764wrb.24.2020.03.15.15.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 15:28:31 -0700 (PDT)
Subject: Re: [PATCH 1/9] hw/core/qdev-properties: Use qemu_strtol() in
 set_mac() handler
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200313184607.11792-1-philmd@redhat.com>
 <20200313184607.11792-2-philmd@redhat.com>
 <1037ec70-ff39-b195-a374-7cace38e9761@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d9002cff-8ae0-45e3-9a57-6a3cafdb034e@redhat.com>
Date: Sun, 15 Mar 2020 23:28:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1037ec70-ff39-b195-a374-7cace38e9761@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 10:25 PM, Richard Henderson wrote:
> On 3/13/20 11:45 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> +        if (qemu_strtol(str + pos, &p, 16, &val) < 0 || val > 0xff) {
>> +            goto inval;
>> +        }
>=20
> This is doing more that *just* using qemu_strtol, it's also validating th=
e
> input.  I don't think you need to adjust the patch, just improve the comm=
it
> message.  With that,
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Correct. I'll add a comment, as currently we ignore incorrect input due=20
to the implicit cast to uint8_t:

struct MACAddr {
     uint8_t a[6];
};

     mac->a[i] =3D strtol(str+pos, &p, 16);

Thanks!

>=20
> r~
>=20


