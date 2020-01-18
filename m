Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E42C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 20:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4330F24680
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 20:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPq44LL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4330F24680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isv5z-0004gf-Bl
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 15:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1isv53-0004Fq-3v
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1isv52-0006Wv-9e
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:52:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36967
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1isv52-0006Wl-5f
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579380747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8jAcsLCwJvKPrvwvCcYB8c2+LFIGejoGKln4xEmrU4=;
 b=gPq44LL010gM8hsoinaOqv3UIh3K7vBG3pJ/pC39zKUntQBdbuAqK/kz7dlPlXJQKwNplC
 ImEigJJ5UsHP57FY7pJdD8E0HgmtTyNG4l6E3CAwZnBT0oXfxi/a+l4sHpjf+QYJmsydy8
 qH74RJI1uaUKy3NtmNVxWH2uYWQfZmQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-YHqK-lkUNaem9gBSTnUBUQ-1; Sat, 18 Jan 2020 15:52:25 -0500
Received: by mail-wr1-f71.google.com with SMTP id j13so12067284wrr.20
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 12:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y8jAcsLCwJvKPrvwvCcYB8c2+LFIGejoGKln4xEmrU4=;
 b=pywB97Usucgi4PDjaCilArFURhDjLQkcSRrVzbqpgA5rCtApu2r3f0oLsGnizkowzD
 1rq/Wyj3Ia52sUD2eQ7Dywjw9CtKP4WL4FqtqDRU79fsMoNj3eoFJ3UQZKeBY4A0cUcA
 8W53DY//wGZScFxP8Ltqs3+KQrv/hlvlVMkc9kqNS8V+Ov1eLszVrvOdqAPzhD66T8Jf
 f38rTac4DQC4N5MCn5KmpphlYIlTWo7c3kNeQCI3uPEoFexdNpvAF/DhE2kLjC8i6Y4p
 vTvNsxos8PMOjxw8Z5xirMR1dRMOjoiGYfmSQctW9k1BnlxbOX0uPE3wIqgbd69eY6Kj
 SAhg==
X-Gm-Message-State: APjAAAVY7z6W2MWA0NLgeNB17oCbZBsKLw5R8yCSe7fXsFtxVE7Fo0X6
 aqAAMQ2vKf+VtpiSzwP+IrMKkPnNa2jFhh1yYCbPvSNlSxM3WNFJWNnaT2Y++jRgNvtPlO0vxN8
 QTf8JgNhk/KnbPlk=
X-Received: by 2002:adf:fa43:: with SMTP id y3mr10012946wrr.65.1579380744719; 
 Sat, 18 Jan 2020 12:52:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/fHduYEOg4gnJh38lA8RRfYe9vyIoRGw+CbpBn6+nCXwOj4z83sgcg9WOpIPE8m/HC+UhFw==
X-Received: by 2002:adf:fa43:: with SMTP id y3mr10012934wrr.65.1579380744521; 
 Sat, 18 Jan 2020 12:52:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9?
 ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
 by smtp.gmail.com with ESMTPSA id f1sm41342154wro.85.2020.01.18.12.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 12:52:24 -0800 (PST)
Subject: Re: [PATCH 2/2] pvpanic: implement crashloaded event handling
To: zhenwei pi <pizhenwei@bytedance.com>
References: <20200114023102.612548-1-pizhenwei@bytedance.com>
 <20200114023102.612548-3-pizhenwei@bytedance.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c6d4cd97-e208-8bce-03c9-2b1889ecc5fb@redhat.com>
Date: Sat, 18 Jan 2020 21:52:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200114023102.612548-3-pizhenwei@bytedance.com>
Content-Language: en-US
X-MC-Unique: YHqK-lkUNaem9gBSTnUBUQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
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
Cc: gregkh@linuxfoundation.org, yelu@bytedance.com, qemu-devel@nongnu.org,
 mprivozn@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/01/20 03:31, zhenwei pi wrote:
> +# @info: information about a panic (since 2.9)

Removed this "since 2.9" and queued both patches, thanks.

Paolo


