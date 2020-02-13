Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097A6C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA22F217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0Jkhp3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA22F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Ba3-0007Mz-2U
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 05:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j2BZF-0006DR-Dx
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j2BZE-0003jA-CH
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:17:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28772
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j2BZE-0003j1-82
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581589075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndPSmi7b75UqOeW/1qpFCxSjCUlv20k4LwGL0todVl0=;
 b=N0Jkhp3fRKdrqykaQyXKUCHRglr2/fcYw4o29hx1OWKVFq/7jQOwG7oEKBNJfOBJ/vkSKI
 7yFcDYbhI9MicZ5Eh2ld+UBGgpwcS2ezLA0l25AjTdSKNojxQzhOaegBrloLYdKzWrxiej
 BB+iGOmImBDqZPsbyMOhlQjTPBvocZU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58--TgCaBGZNweTCF3v7E-6FQ-1; Thu, 13 Feb 2020 05:17:53 -0500
Received: by mail-wr1-f72.google.com with SMTP id s13so2125158wru.7
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 02:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ndPSmi7b75UqOeW/1qpFCxSjCUlv20k4LwGL0todVl0=;
 b=Fq+n5Z23p7/hBijQfGlY/3lKkFlu95O4PN29s7D4He5Km5OnNZaTFTwurnLz2jBvNZ
 DQibAdMIovpbSP4kK3L/tobGmrVKY6BbiNp8hniOCskbvgjWeKXV1VtLCmJQQAulfxRw
 1kYcoBAjc3cHWHbhL9m5XERzyf5MvuHmV26J8mwvAlImi+ruDP+QUIhprmKBBrmtyOp6
 EZ0zch+LZAUdA4oDoedioLZ09m+DQ7uUbUKE/VukWuAFb5RBv50rA07E4JQqmcG6caTx
 crcmWiRtxt6nxMyeA7lD0uhOm/k+XAKnaricB26SUmy00erjy7ilcl5vzDv/wpOpknjn
 JzRw==
X-Gm-Message-State: APjAAAUlg+QIzj5RLnX8+TOgCLetVk7zX6DcJP+TPHsI3Jv5Qf6Dmmsq
 OyDIK1onE0fpFEQq0jgchc5ceF/eWkHfPN9YkaK+/DKGkT6+uSvzr9VOB04qdcQWHF1ywUZxSos
 Ow2qKaVXr7BWTHkw=
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr5121573wmi.71.1581589071894; 
 Thu, 13 Feb 2020 02:17:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzo7qLug+zvte8mHgk93FTQMvzqYv2AapxUthTgn3vcOTq28476G1DgB5mJvadadKMpA+wPgg==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr5121551wmi.71.1581589071581; 
 Thu, 13 Feb 2020 02:17:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:48f0:7b10:ad88:6d83?
 ([2001:b07:6468:f312:48f0:7b10:ad88:6d83])
 by smtp.gmail.com with ESMTPSA id c9sm2526768wme.41.2020.02.13.02.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 02:17:50 -0800 (PST)
Subject: Re: VW ELF loader
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <20200205055851.GH60221@umbus.fritz.box>
 <73105e0b-c0a0-009f-aeba-fec818d3088c@redhat.com>
 <23090d06-320e-91b5-f73e-c17e065fcad8@ozlabs.ru>
 <dbea9886-04d8-f9fe-f79d-31d8abe76615@redhat.com>
 <274037e5-9bd5-8507-4b4b-067a86225787@ozlabs.ru>
 <9539866e-b3ca-cf29-5a05-164480f89075@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2dea0786-5e4b-bda0-5ca8-fdcb3a4f3e50@redhat.com>
Date: Thu, 13 Feb 2020 11:17:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <9539866e-b3ca-cf29-5a05-164480f89075@ozlabs.ru>
Content-Language: en-US
X-MC-Unique: -TgCaBGZNweTCF3v7E-6FQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cornelia Huck <conny@cornelia-huck.de>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/02/20 02:43, Alexey Kardashevskiy wrote:
> 
> Ok. So, I have made a small firmware which does OF CI, loads GRUB and
> instantiates RTAS:
> https://github.com/aik/of1275
> Quite raw but gives the idea.
> 
> It does not contain drivers and still relies on QEMU to hook an OF path
> to a backend. Is this a showstopper and without drivers it is no go? Thanks,

Yes, it's really the drivers.  Something like netboot wouldn't work for
example.

I don't have a problem with relying on QEMU for opening and closing OF
paths, but I really believe that read/write on ihandles should be done
within the firmware and not QEMU.

Paolo


