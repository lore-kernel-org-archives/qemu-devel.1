Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2ADC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3712177B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gd9do2Qp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3712177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3F8P-0003BP-60
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3F7K-00025A-5K
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:49:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36422
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3F7H-0000IW-4x
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596617381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xzWQSml/odaAXEbBxJon9v9uyqmWMKioo+gjLnCQUk=;
 b=gd9do2QpFJWiICpmi9WUPgmAXCAIJUc6BSrJ/C8rcZVqJ907dm9QfXY8moSONtaPCbp8ii
 ExhqgLcxNS/y9mvtj3CFUJg0ttD7T9Vkih9hWrt4qeqrvZK1+9JQG6nAHivTgUSQpswQti
 8bcNOnkebrzGqoNkcowuCzNr50NaQAY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-tlp4WpikMsihviPEdBAkgg-1; Wed, 05 Aug 2020 04:49:39 -0400
X-MC-Unique: tlp4WpikMsihviPEdBAkgg-1
Received: by mail-wr1-f72.google.com with SMTP id b18so10319400wrn.6
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 01:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8xzWQSml/odaAXEbBxJon9v9uyqmWMKioo+gjLnCQUk=;
 b=KMaMec91g6Q7id/I0BIPiP36jAZIR3q1CeDFA4lSKDIY04N90pTUdpnpLZ7j1rySF2
 C7TYJe3EHFuqfCABPpF2hvWpIRRQPKit61GK3NasVeH5fafRUgPT1rbZH3bumMYeLrFd
 h41TYDucFW2uImc5LZazriv+LUr538CqJPA5ho+6r2vDyR7duu2YXVCS1eRtqLjt++N1
 f2LdXC2FB3h8Ill0giMDHF+pXEtBZy9ZfJpN/Ufkm86fyGMrBE9dF6dA+mzLx5bRCctX
 z9DP2ZlJ9PGP6xulbaQrHXKxO0BsufSa9/cK6wNYatKSThKvO7ENGbwLbdbrAusL/l0E
 6kcg==
X-Gm-Message-State: AOAM532Szu5ZGiL6X6fxZm7qiZ8hhpA2xkWyUadr+72hUO0KDUYXT2Y5
 HmPho2Awt+b2d3ib6V6FTd4JSeT1csFQgvXExQw0+/vCTFvEJ+KSs4HqqhzsEdltl9z3/sSr4Wx
 MDCaL/GxpGH6IjQE=
X-Received: by 2002:a1c:2095:: with SMTP id g143mr2218213wmg.113.1596617378437; 
 Wed, 05 Aug 2020 01:49:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6jHpqDFexrL8ojGbU+2Z4eaDvlENStmylVg6PDPbz1EeccqJcFhbfONxhBHg4eJLKaavAvw==
X-Received: by 2002:a1c:2095:: with SMTP id g143mr2218187wmg.113.1596617378207; 
 Wed, 05 Aug 2020 01:49:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id z8sm1750488wmf.42.2020.08.05.01.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 01:49:37 -0700 (PDT)
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <87d048i1m2.fsf@dusky.pond.sub.org>
 <83bbe0b0-c5e0-e3b7-5ba1-5946098370d5@redhat.com>
 <87ft94klyl.fsf@dusky.pond.sub.org>
 <490a0786-73f3-411e-4dfe-8c2ae90de251@redhat.com>
 <87y2mvhg3k.fsf@dusky.pond.sub.org>
 <facfef76-d880-82dd-f862-a64f8f487ba2@redhat.com>
 <87k0yeg7mc.fsf@dusky.pond.sub.org>
 <6e5df5fc-94f8-ee8e-0c14-f56135de25e4@redhat.com>
 <87o8np5ysp.fsf@dusky.pond.sub.org>
 <9f83eb93-5389-7aad-3031-0777de0c35b0@redhat.com>
 <20200805083949.GA3004@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <241436db-1aec-b804-314f-7893954e981b@redhat.com>
Date: Wed, 5 Aug 2020 10:49:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200805083949.GA3004@work-vm>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/20 10:39, Dr. David Alan Gilbert wrote:
>> Do you really use "git blame" that much?  "git log -S" does more or less
>> the same function (in a different way) and is not affected as much by
>> large code movement and transformation patches.
>
> I use it a lot!   Following stuff back to find where a change came
> from and then asking people.

Indeed, but I use "git log -S" instead. :)  Another possibility is to
just do "git log -p" and search for a relevant line of the code I'm
"blaming".

Paolo


