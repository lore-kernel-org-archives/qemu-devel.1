Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B176C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE10520730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnW4QpXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE10520730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6p1-00050z-RW
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 10:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1is6mf-0001jk-3M
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1is6me-00082q-2Q
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:10:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41534
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1is6md-00082F-Tj
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579187407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMSQ1i+RFrNHRJejFHFm0eh8blRFauB4+6pGjqc90j8=;
 b=cnW4QpXpLRRU70o9mos5cxKKojbTTkUcZVUVNM4XzclZeGVqJTC5OVS3kLCo/mxoUM5UN8
 azZ5kyn+WBQBrpp+j/PIP9+KoFQbPkePm+1f9TrVlrS3O/H43jTj12X1RSVxpXxahuKEVT
 qeYCRSJcnjJaPUF5HDqZ/RFIsYus7Ik=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-tplBK8MZNg-8o0GUEcxGOg-1; Thu, 16 Jan 2020 10:10:03 -0500
Received: by mail-wr1-f70.google.com with SMTP id r2so9353703wrp.7
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 07:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yMSQ1i+RFrNHRJejFHFm0eh8blRFauB4+6pGjqc90j8=;
 b=YsQcQJZ1B7wZBEH3k+KkzNNDrjWtyBUyaj/6QVdTvhhAW1XO35ysVnAKkfgoElRde3
 ChP4VyTWt3CBNxWk3+4iaQKwzmSlVKczy+HUAs9xl68+6rqtlvn+LjAQI52IhEGa8YKD
 Y+6s+wO0ey2at5ysGMJ8bb2T/0AB4wmH+hYraHNoChuGaVlWhgSeY1Ovomqsa6uWhcCK
 wDaG/ZIGG0ap/flUbZFmuJFxLAv40Dvq9bzyjOo7OOMLDtqeT2JEiHyQ/rjLBvytc4/N
 6ltaxLqKaMJt4RyoYUfgyhx9UjSWJ46IgFdKMk1ol+PCM/wIWg9fv6/cyP4GbhaQFYIE
 6P7g==
X-Gm-Message-State: APjAAAVKhFKNEY1z/74QAw3Pid+BRsA7B5+AqLnCGL90oPZ0Y2UogpcV
 JhvV0DUrjBFQ/YiaO3r4GZ8LgUU0qt5qNjDzDCreejsneZV/npMqpgT+DLtW42b8HawEGssMEfO
 p6BC50X4juct9UNk=
X-Received: by 2002:a1c:2dcd:: with SMTP id t196mr6506706wmt.22.1579187402343; 
 Thu, 16 Jan 2020 07:10:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwulFOMgJFbccyv/HwXTBWZmNN0WwpZtkSeRwocOEAMsP9DVR2h7eHHyFFpb+Q7XtRtk868tg==
X-Received: by 2002:a1c:2dcd:: with SMTP id t196mr6506676wmt.22.1579187402000; 
 Thu, 16 Jan 2020 07:10:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a?
 ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
 by smtp.gmail.com with ESMTPSA id n10sm29222379wrt.14.2020.01.16.07.10.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 07:10:01 -0800 (PST)
Subject: Re: [PULL 20/87] vl: warn for unavailable accelerators, clarify
 messages
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
 <1576670573-48048-21-git-send-email-pbonzini@redhat.com>
 <7378ae78-818f-723f-88a7-1556791135f2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf6088f9-dbd7-c45d-a3df-8dd7ee0ceaaf@redhat.com>
Date: Thu, 16 Jan 2020 16:10:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <7378ae78-818f-723f-88a7-1556791135f2@redhat.com>
Content-Language: en-US
X-MC-Unique: tplBK8MZNg-8o0GUEcxGOg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/01/20 15:50, Laurent Vivier wrote:
> Every time I run a non native VM I have this message:
> 
> $ uname -m
> x86_64
> $ ./ppc64-softmmu/qemu-system-ppc64
> qemu-system-ppc64: invalid accelerator kvm
> qemu-system-ppc64: falling back to tcg
> 
> Is that expected?
> 
> At least it's annoying... it was silently falling back to tcg before
> that patch.
> 
> Should the default be set to tcg to avoid the fallback?

Richard has posted a patch to fix it, I expect him to include it in his
pull request.

Paolo


