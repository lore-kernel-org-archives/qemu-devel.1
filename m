Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC25FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 08:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D57214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 08:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Om/F1EB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D57214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifJal-0004et-RR
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 03:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifJaA-0004DW-PK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifJa9-0004gM-GU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:12:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40381
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifJa9-0004f2-Ar
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576138340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wa6Iq77HQ0dn9CxSC3S7wL5atfzfhLSMSZjoau8pBeM=;
 b=Om/F1EB+Y5Ris2UGD6YSYtxo5mhfw4xP0+7pZsUn5/xecw6JoTJJm29zKRWbx/EBdBDeHa
 JqOyvJ50EEIQAwCENKChu+J/BuiYjmLeNFKkNa9nysZM90zP4f3yCZbiJXxheud/PKwH1f
 K11hV5zGk/cfmZbUMzwGFkOxBn+leMg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229--JHf0aQVPCuymjBk0YhF9g-1; Thu, 12 Dec 2019 03:12:19 -0500
Received: by mail-wr1-f71.google.com with SMTP id z10so708558wrt.21
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 00:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wa6Iq77HQ0dn9CxSC3S7wL5atfzfhLSMSZjoau8pBeM=;
 b=TnlOF3Iv/lS0/7pNOxppOI7C4RMQey4YN5YwoFBrCHoXBFKeZ+XQK6s9ByOwAOo27q
 lCNMqTwyx6k4n8knaLF70ogTPYtVncr5Gmnqj6RVa7ODj+BIJ52ViQDTOfehEqaWOqwX
 v4u+VkkXYZ2+/cyTVIXJVmsPdZQvPrlFbY+z6la8U55Cn0g7VVHHFMXg/abqAYYLJMzO
 AlFYP0QFSLPN8TpCF0SvFFiE43siFKjRW/9Oz+UjHCThGxRX6GDqrLjU81Y65EA3meSp
 pJMtIX0UITKXmuXRztCSunTGkXNjAcpGjTHNErmkonxHBdBLxE8lVN3uJUpVmVnsCJ8k
 5swA==
X-Gm-Message-State: APjAAAWam6HNriC+7f0TfphJ0H1yPtx+z3/d0WdZbsV5p53bRZ7ILsFr
 MxcUMxrifDjhH8iNe6GLMXsIZdCj0BbwViPpaZ/Zuq27zmBUXhxvLyxQM/EvBPQ4/+Sais3eD2J
 xxGDOphqCi0J/bYc=
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr4691600wrq.396.1576138338397; 
 Thu, 12 Dec 2019 00:12:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzi2kSHT0yWAKe7L7YcblfsgQGgvBSRFKa6kNNL/3/ccVUvXkjVTdGQ0Vrn8l2HdKnddb3b4A==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr4691566wrq.396.1576138338101; 
 Thu, 12 Dec 2019 00:12:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id x1sm5084893wru.50.2019.12.12.00.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2019 00:12:17 -0800 (PST)
Subject: Re: [PATCH] object: Improve documentation of interfaces
To: Greg Kurz <groug@kaod.org>
References: <157607116183.174911.9764813135617350231.stgit@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db99577e-a578-691b-fb6f-4c72729feb15@redhat.com>
Date: Thu, 12 Dec 2019 09:12:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157607116183.174911.9764813135617350231.stgit@bahia.lan>
Content-Language: en-US
X-MC-Unique: -JHf0aQVPCuymjBk0YhF9g-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/19 14:32, Greg Kurz wrote:
> QOM interfaces allow a limited form of multiple inheritance, at the
> condition of being stateless. That is, they cannot be instantiated
> and a pointer to an interface shouldn't be dereferenceable in any way.
> This is achieved by making the QOM instance type an incomplete type,
> which is, as mentioned by Markus Armbruster, the closest you can get
> to abstract class in C.
> 
> Incomplete types are widely used to hide implementation details, but
> people usually expect to find at least one place where the type is
> fully defined. The fact that it doesn't happen with QOM interfaces is
> quite disturbing, especially since it isn't documented anywhere as
> recently discussed in this thread:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg01579.html
> 
> Amend the documentation in the object.h header file to provide more
> details about why and how to implement QOM interfaces using incomplete
> types.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  include/qom/object.h |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 128d00c77fd6..5cf98d2c4350 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -200,8 +200,14 @@ typedef struct InterfaceInfo InterfaceInfo;
>   *
>   * Interfaces allow a limited form of multiple inheritance.  Instances are
>   * similar to normal types except for the fact that are only defined by
> - * their classes and never carry any state.  You can dynamically cast an object
> - * to one of its #Interface types and vice versa.
> + * their classes and never carry any state.  As a consequence, a pointer to
> + * an interface instance should always be of incomplete type in order to be
> + * sure it cannot be dereferenced.  That is, you should define the
> + * 'typedef struct SomethingIf SomethingIf' so that you can pass around
> + * 'SomethingIf *si' arguments, but not define a 'struct SomethingIf { ... }'.
> + * The only things you can validly do with a 'SomethingIf *' are to pass it as
> + * an argument to a method on its corresponding SomethingIfClass, or to
> + * dynamically cast it to an object that implements the interface.
>   *
>   * # Methods #
>   *
> 

Queued, thanks.

Paolo


