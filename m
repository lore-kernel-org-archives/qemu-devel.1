Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23688C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FD92086A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJRAXUV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FD92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaf5Y-0008Oo-50
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iaeKe-0007md-Ie
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iaeKa-0007KE-4S
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:21:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38233
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iaeKZ-0007DK-S0
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575026457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fBPwedJ0zJjT1KbqSm2z0fRrd2QLnzihLmWkZ3WUMs=;
 b=eJRAXUV8LAsvZ3kntJMP/r1iv/h7sOtlKYiMs+OhF4iuTVjt0KRcNqt1qv0p91uodHKsSS
 FZwJ63NR99af6B35LqFL6Foq3+kAPPxgblgEHFJmV9XYT01D5SRCtV5cb/1acFfmE/nRVU
 xBmYRipJiTAgXTrhG3I4elT/NWnU+CY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-lBkpNfpqNOaJxtWA6LiXWQ-1; Fri, 29 Nov 2019 06:20:56 -0500
Received: by mail-wm1-f69.google.com with SMTP id y125so3254189wmg.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 03:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4fBPwedJ0zJjT1KbqSm2z0fRrd2QLnzihLmWkZ3WUMs=;
 b=YbsRp6P/P9sXVJfdUrmBf9fPWTx6/4k4dHR0S25jFufcej+YwdBt6kLssBo6vf/7Dh
 7DRPm9u+TrLtCMs0745aN3WGKxlN821htMHfaPM90bZPdk7fnNlWKw2UHgJNpNIvTKs3
 /phwpMPgSY89thKWL256XYib/sc6ElLLJrPxWUrp3ofONPMdtOIbtLuZDdlITgRV0rrn
 z48v9P/bjaInZhqbyhebOVLTE30WaVMNIZm941xp5py1tEDlPI0zFgTFqNMACR4LggiB
 rmYIORLkaRRL3rDp1rZbqL6sBJoh8idkl2ReXKCdztpQtDWT1NIPzUepVeE9u2vGH5M1
 2unw==
X-Gm-Message-State: APjAAAUB6gJ1Mim+j9TOhLyjc6alOWR/XUA7x411wte8KxsPpTMHoI03
 ePe0B5HQr1Dm/Kd36DLNgQ1NSE+PQYYXNwWPG2Xt3QevMfETKbB5mRpA5KcZl4+ORwvmnd6xKUs
 BBRQzqzAMKv5DliM=
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr3886446wml.50.1575026451066; 
 Fri, 29 Nov 2019 03:20:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqwrfS3NEjhMtHfDMYa1G5rou//oVq/XF2/dHn6vRNJX74CN8giTyar3DErMlex/XBq0NRaCBg==
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr3886417wml.50.1575026450769; 
 Fri, 29 Nov 2019 03:20:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:459f:99a9:39f1:65ba?
 ([2001:b07:6468:f312:459f:99a9:39f1:65ba])
 by smtp.gmail.com with ESMTPSA id x6sm27502109wrw.34.2019.11.29.03.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2019 03:20:49 -0800 (PST)
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
To: Igor Mammedov <imammedo@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191129070253.5hwksjrapomk434x@sirius.home.kraxel.org>
 <CAMxuvawieN7JQZkRku19v5X-o6q664Wz1Rtx3+Wz3d33m-7Tug@mail.gmail.com>
 <20191129092713.GA2260471@redhat.com>
 <6b441014-1852-3257-2bc5-897cc51d08dc@redhat.com>
 <20191129111357.0256ec2a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <29041466-a612-d0e3-4249-7c0e7121ef4d@redhat.com>
Date: Fri, 29 Nov 2019 12:20:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129111357.0256ec2a@redhat.com>
Content-Language: en-US
X-MC-Unique: lBkpNfpqNOaJxtWA6LiXWQ-1
X-Mimecast-Spam-Score: 0
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/19 11:13, Igor Mammedov wrote:
>> Agreed, mkstemp+shm_open seems better.  Perhaps this could be done in
>> hostmem-memfd.c though, basically as a fallback option?  In principle
>> one could even use getmntent to search for a hugetlbfs mount.
> So far fall backs proved to be a pain to deal with, as end users can't
> be sure what machine they are getting eventually.
> I'd prefer if we fail cleanly if asked config isn't possible and
> let user fix vm configuration instead.
> 

As far as I know memfd vs. mktemp+shm_open+shm_unlink is pretty much the
same thing.  memfd provide additional features such as sealing, but
unless someone explicitly checks for memfd features, the two should look
the same.

Paolo


