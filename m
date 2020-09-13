Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1591C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 13:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC87C2158C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 13:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hp+nduN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC87C2158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHSFj-0001qb-TL
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 09:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHSEw-0001Fv-Hl
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 09:40:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHSEt-00088M-A9
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 09:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600004417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WK4cwScZukhiDE0h3weI7FrDnA04T0JeHgW0rURXSLU=;
 b=Hp+nduN0bjVYLdBXXlJGftwDH76cmVn3QJhx0JWDINsRoWRxSKVAZuOpe/f11WXj/GfkzQ
 JzGchvnaszCF94kxvq//f+nUILOZTQ403XLkEibXROEflt24ov1+LC25Q9k1vMAGzaUiES
 OKwbkdHpomB1Z68/iXRtLW6IWu544tI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-moJeZxQON8uphjkH6hzZwQ-1; Sun, 13 Sep 2020 09:40:13 -0400
X-MC-Unique: moJeZxQON8uphjkH6hzZwQ-1
Received: by mail-ed1-f71.google.com with SMTP id x23so8271424eds.5
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 06:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WK4cwScZukhiDE0h3weI7FrDnA04T0JeHgW0rURXSLU=;
 b=ZXD+FWceh3IhdjgWxlC7jBQX9zletWTQaaa6uQKi1pKwfmGa4Cq86v57B4ORbdjo/y
 6BfgsENN0im4z5NXszoaMb9ufRsT7CL3tO+DYU4NojaqMjgXLlO0JlDMBRj1gfvQHA08
 1Kmd/h9Rx3L4bnGwg1mROciHsewirN2Wqukk9nq3c4+bqVeSIgV3jNDLUrFeEieYtShb
 Uzco+Z8p3txMo9E9CTj1CDk1qE0Gn1lpcRn17OY5GzG8W7Z7q5HZjL2E17KoLpylT1uu
 GAKWYC5yjv0sozGiQbDZ+Hk1LtSNkbkgkUh976FgRn5XTKYxcFlYsWSTGjMAADnZgQ4t
 6S7Q==
X-Gm-Message-State: AOAM531yCsTXC8Xa1eo426MLe4uBk1DaUevm7lxzk7ykvxtvWfP16duN
 xIPYJnPikmoSWd+9myksklrjG8HDyWR8IsaPry1f62Dxhe9+74uWKrFzrbSNsKHPcYnI9rGRjvu
 f1WCCgbNx8anLpkc=
X-Received: by 2002:aa7:d785:: with SMTP id s5mr12437786edq.154.1600004412144; 
 Sun, 13 Sep 2020 06:40:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFF0NKb3ySm3NBcJOqkdm8/vcc23fZ/7ad/adR3kTwd1qzJJkvM50bTev2asLv/kSSGsi/zw==
X-Received: by 2002:aa7:d785:: with SMTP id s5mr12437743edq.154.1600004411743; 
 Sun, 13 Sep 2020 06:40:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:edca:afb8:6969:492b?
 ([2001:b07:6468:f312:edca:afb8:6969:492b])
 by smtp.gmail.com with ESMTPSA id k1sm5272527eji.20.2020.09.13.06.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 06:40:11 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] user-mode: Prune build dependencies (part 2)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200910152225.524322-1-philmd@redhat.com>
 <f8c9c94c-9b27-6c16-bde1-1a0a91287563@redhat.com>
 <fb687ccc-919c-6c61-4dbc-9e76625c3743@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <84799885-c40c-a8ae-915d-798fdae3e303@redhat.com>
Date: Sun, 13 Sep 2020 15:40:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <fb687ccc-919c-6c61-4dbc-9e76625c3743@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 07:42:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/09/20 13:31, Philippe Mathieu-Daudé wrote:
>> I'm not sure about the first.  It's a bit ugly to have a property whose
>> getter aborts.
> This is (IIUC) the change Markus requested in v3 (see [*]).
> 
> Commit description: "add a stub to satisfy the linker."
> 
> This stub should be never used on user-mode => abort.
> 
> [*] https://www.mail-archive.com/qemu-block@nongnu.org/msg67560.html
> 

Yes, I'm not sure about the stub _in general_.  I would prefer to either
have the type available even on user-mode emulation, or remove the
property altogether... I don't know, anything but not a property that
aborts. :)

Paolo


