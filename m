Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DF7C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC4720578
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcyOizn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC4720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58qM-0002Ke-Lt
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j58ph-0001aL-MX
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j58pg-0004gb-2H
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:59:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47487
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j58pf-0004g1-Pl
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582293546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UsL+0IdZ8pm8ASYC8IW+IZRGNpwRCajZf4t6eS+LTc=;
 b=LcyOizn192cPCmrEPXtVfhhXAlyDNqxmNmnskysT5iQG/6esMIizKG8FcCpxdj1TnpWeuo
 e0XLFgkn6mKVWrfj+C1JWJcq9o2qqHnMM948eo4eLq3xmQUATMCXoCK4DP2LJ45kou5LDU
 20+WZoksrbNWTC60i82qujhCwXnvKUc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-QH54lq8NPf2N6R_xj6d1pQ-1; Fri, 21 Feb 2020 08:59:02 -0500
X-MC-Unique: QH54lq8NPf2N6R_xj6d1pQ-1
Received: by mail-wr1-f72.google.com with SMTP id u8so1052479wrp.10
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2rBuoukEfWGSnOn46gcwr6yCc/JAOvC6dSwgmTsDYIs=;
 b=oItyZIbNTt1CG5ik1dml3OKKsfTROst77wQlSckgNwukxheawtw9ndSx/G46D2ebG/
 JnnFTOvlmS0fuNzWQD1yZfjv9e5W5nt3zXnq9uJAE0kBfxL5HePTgjCUSIdJ+G+jjDQ6
 ZFT+/Qjagy3CCyXrUntyZb2B7Q62XFdWqALHknOh2v83gxO68LttCTP0SFDWfnKksfBu
 GU/OmQIhmqXIw6ncq5obWuOd2V8VlC+nT3UDK55VIAaCfKx1T0uL4++iXpLnTaMT9PwN
 QjreWDhikmOFP396SQTsr752TaalAqGJwM9sYUpV0cBq6AqHLD5cKdUtIW7KWCp68ZJu
 R9VA==
X-Gm-Message-State: APjAAAXsrDkfdCoi1XasD5P340kwWjvrzLu5GsEOcrVIdq25xWMhyB3g
 RNiwPnjFAOryoXTcv84F/B48e8BdMjXAoTkLXAwRb2smCWl06r4lXmLni/XNJ93qKGhp8QKPbXY
 pPuv2JRcXJLcS0gw=
X-Received: by 2002:adf:f10b:: with SMTP id r11mr49134832wro.307.1582293541520; 
 Fri, 21 Feb 2020 05:59:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqypEzMOriaeWRFsZbGwHrwP7nDKNUA8D9iiO/RVraMwoSXIp+9bNX8Hv9xjDIICf2LERprmSw==
X-Received: by 2002:adf:f10b:: with SMTP id r11mr49134806wro.307.1582293541258; 
 Fri, 21 Feb 2020 05:59:01 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
 by smtp.gmail.com with ESMTPSA id t12sm3990012wrq.97.2020.02.21.05.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 05:59:00 -0800 (PST)
Subject: Re: [PATCH] qdev-monitor: Forbid repeated device_del
To: Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@redhat.com>
References: <20200220165556.39388-1-jusual@redhat.com>
 <20200221135305.GN1484511@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4898f063-e1e8-cd08-961b-4a776d3f8a5b@redhat.com>
Date: Fri, 21 Feb 2020 14:58:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200221135305.GN1484511@stefanha-x1.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/02/20 14:53, Stefan Hajnoczi wrote:
> On Thu, Feb 20, 2020 at 05:55:56PM +0100, Julia Suvorova wrote:
>> Device unplug can be done asynchronously. Thus, sending the second
>> device_del before the previous unplug is complete may lead to
>> unexpected results. On PCIe devices, this cancels the hot-unplug
>> process.
>>
>> Signed-off-by: Julia Suvorova <jusual@redhat.com>
>> ---
>>  qdev-monitor.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

Queued, thanks.

Paolo


