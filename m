Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A2BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C1220674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0duDIdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C1220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaf5J-0008Eu-Ol
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 08:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jaf4G-0006wJ-HN
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:40:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54238
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jaf4E-0003xR-IE
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589805625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJ4IgRgsiTBA/N9X0FKjjCpdw+wTyU5KVvVwmM9WQmc=;
 b=W0duDIdfXGr65U7V45zn+/ofPUqQ1kESzBrC3toMmo3wrlO1ubBVS/jtaTxRaYdxBBURzK
 q6QIvE6T4Lw5tAcKcEkgaYr9y9Hke9R72UV/GrCeoqmD41cV+D3Y17xhUstJDXK8dhdfhC
 MEJxcvZovLEUqImgrSzZ9YTwi5nD0Qg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-EalCN3WFNMCmpLErLqvLhQ-1; Mon, 18 May 2020 08:40:23 -0400
X-MC-Unique: EalCN3WFNMCmpLErLqvLhQ-1
Received: by mail-wm1-f70.google.com with SMTP id u11so3032764wmc.7
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 05:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yJ4IgRgsiTBA/N9X0FKjjCpdw+wTyU5KVvVwmM9WQmc=;
 b=IdTs6+yggTp0mvHUKwPVvNKAMQnRflIKchFc81dpIWQtxLqvGq7Avbfjo/IYPjEI/T
 nUR8BoTHXNOmMYfLzAG7lNY5AN1hm/dy0mUloTVobgK/CnZjq/IRM6saCSQLeBnazinZ
 R5kB5zPQAY1U0nkXK9Xu6ANr7QrhdibCejwd0DZbgHmgJvghyLILv/eQjdLtuIgbJjVL
 cgWWGxwNKF5MCXGRyZ8kGXHPFtgI0RJnas6rf5eNoGFP+TS/FSfiGXheFL03c7Gf7k6T
 ZQLn9NedMcxhOyPZpMEP1lb0HbOJQHFRZtQdNt8WgSrf0isQ/K6bdhwF8quJuKI50XGr
 QL7g==
X-Gm-Message-State: AOAM532iBHOwSYZmUH95f2Ovq4ruSDxo7RXwyCkpLOtGT/av1ijzYY8S
 11KJH3bXlFHQiEzf495TMosBfHpJFG2iC5AmjLzXQjSGWjtBoekdp5uREfh2NxPOiiWyv6SbmYC
 CvP6cKstsi+MfjY8=
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr19378276wrq.171.1589805621656; 
 Mon, 18 May 2020 05:40:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCAR79q1r/u+ElQ0DSvEZICk9eI3J0VHulHSHUS5E92yAv0i/D3GvHsxNo7k5eyzb/9Bk8AA==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr19378219wrq.171.1589805621356; 
 Mon, 18 May 2020 05:40:21 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.90.67])
 by smtp.gmail.com with ESMTPSA id q74sm17336275wme.14.2020.05.18.05.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 05:40:20 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] various: Remove unnecessary casts
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200512070020.22782-1-f4bug@amsat.org>
 <871rnlsps6.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8791b385-8493-f81d-5ee3-cca5b8559c27@redhat.com>
Date: Mon, 18 May 2020 14:40:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <871rnlsps6.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/05/20 07:58, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Remove unnecessary casts using coccinelle scripts.
>>
>> The CPU()/OBJECT() patches don't introduce logical change,
>> The DEVICE() one removes various OBJECT_CHECK() calls.
> Queued, thanks!
> 
> Managing expecations: I'm not a QOM maintainer, I don't want to become
> one, and I don't normally queue QOM patches :)
> 

I want to be again a QOM maintainer, but it's not the best time for me
to be one.  So thanks for picking up my slack.

Paolo


