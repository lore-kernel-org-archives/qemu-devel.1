Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCF4C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E7422429
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIn0bMP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E7422429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMle-0003FJ-8g
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iXMkz-0002kN-1r
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iXMky-0004Gj-7J
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:58:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iXMky-0004GQ-4B
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574243919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=O9xQYpyBt76UEq8p+FvnObMCUEWajQTRzfrWqVNDag4=;
 b=CIn0bMP8ZSn0LoG3TNXeAFFR6zi+WhwEJMDyBIsA1euTF2siqI+54IDLbTqNsNzjI0tl3a
 KyFu4Y2aoJuZr/EFSf2zpD4zsu+xaNQD2y17voAy0u3882NMS1CjxpNNfRJcypwGmNEw+1
 QgvzZdqJcmfUuHn2QAfEbsplGZyQM+k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-fUyD2DkKO36Bhcf2tHWOJA-1; Wed, 20 Nov 2019 04:58:36 -0500
Received: by mail-wr1-f70.google.com with SMTP id h7so20877700wrb.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 01:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O9xQYpyBt76UEq8p+FvnObMCUEWajQTRzfrWqVNDag4=;
 b=OJB8jk5NhKSuNNquafPS4UJUK+wXgdZ1A+15PGpZhxKqX3lD0+9c2AKuwNKJDgGgrh
 g6Zdj0pQxx8VYjHQtgJpXJZiaohVf0fVJafLxscaYAwKfdY7yElsRV05j83PRxyl0+bm
 Pv9JVqnTllaDoeO+PM2tFn1en75bRj3P9THuQLQSWpsU/nuGKJSFIrPYtsp7Ikr3Y0Yj
 gGIPAM0M/LbxQBV6ugUU2fjStSOppoLAUzeuJrTIQi25X5e9cO2QIVf3gudFGlM90lt9
 Hj0FGd/oIwLnN+8qQpoiBPKnLJ1VHUuqefNBKPIQ7i7ffCWKuXvyseegHnHcu66sYIq8
 X9nA==
X-Gm-Message-State: APjAAAUQkOT8mA7gxPnIfNWAQSPZ/IBeiGkpzINe7rWBxsuTEs/AaAyq
 nU23BdOF7XSQ5usMQos5k+NgCv9vDEPEpF0KaTJKldegNpY7SqsESAUdR94h2FVwf++YM2DXZk8
 oy2mST+cLfudQX6c=
X-Received: by 2002:adf:82cc:: with SMTP id 70mr142379wrc.231.1574243915167;
 Wed, 20 Nov 2019 01:58:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5iEVwmXGMwC3lqq6ogRh5jhXw5zeItNp4KAE8jW5hHoVaXbmnZYGUjXMxrS1DWublusdVdg==
X-Received: by 2002:adf:82cc:: with SMTP id 70mr142354wrc.231.1574243914909;
 Wed, 20 Nov 2019 01:58:34 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:dc24:9a59:da87:5724?
 ([2001:b07:6468:f312:dc24:9a59:da87:5724])
 by smtp.gmail.com with ESMTPSA id v81sm6367455wmg.4.2019.11.20.01.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 01:58:34 -0800 (PST)
Subject: Re: [PATCH for-5.0 0/4] Remove the deprecated bluetooth subsystem
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20191120091014.16883-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <689a3583-9535-f744-1938-061ad0df114b@redhat.com>
Date: Wed, 20 Nov 2019 10:58:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191120091014.16883-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: fUyD2DkKO36Bhcf2tHWOJA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: libvir-list@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/19 10:10, Thomas Huth wrote:
> This patch series removes the bitrotten bluetooth subsystem. See
> the patch description of the third patch for the rationale.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


