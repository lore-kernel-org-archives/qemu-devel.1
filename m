Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD0EC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7770F2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEDbbPFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7770F2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jKI-00084T-MJ
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4jJJ-0006yM-CJ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4jJI-0003bU-Hi
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:44:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36225
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4jJI-0003bE-De
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582195440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRn3svq+AKGGJQtrBiR9eYFyEd8x2FuO5jK/Pq/zaMs=;
 b=dEDbbPFLwLMxroQsU3WoZfKOCpxPIJBlnEWWSgKE3hvutadwsA/RVWj8VHZkzCQlXZLRiz
 W8EcrYTRMvytv94g4Rm0nG38cNQXAK6lZRqFAUEBuhLjwlrI70e3Y0HUqqWYKGA3JHz5XX
 VaJmnawQCwo7okvlXRYIN2ddMXfwE2E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-i7s1DRWePSuSRUtWr8FFiQ-1; Thu, 20 Feb 2020 05:43:57 -0500
Received: by mail-wr1-f72.google.com with SMTP id s13so1549146wru.7
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 02:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lRn3svq+AKGGJQtrBiR9eYFyEd8x2FuO5jK/Pq/zaMs=;
 b=Oi3cjNAV/Ms8JVhFI/ERpD8Q27clNjVdEmB3InLFi2FdUw6rqJ7Aahg1NMUIu3o4GF
 pzuJ+L2LjQHXEOUx6rZMGMLgJJlvOJA0r7PUz0E8sDyTwiZ15XjvIBhw6peuQvzwxCYJ
 H28wJp87Oits8FrcjMzG4pN5TUyXClL9bKW+rbzidk+dJepBciy25mdGdlmyitaW+MuB
 en5oLiL+QuUGtPLkuPuLSv3ia4ReNiNmzlhnZHb5i563JNMlrkMWyQjdF2bVGtc/HBI4
 2d3VEwf9udDBXDavJ3OmXtbgSkCjxKb/rD0wQIWjk89l2rJmFF6Iro26bhl2qI2KHN5p
 TqPQ==
X-Gm-Message-State: APjAAAX+K04wJIhLuTzlN7bj1jnbp2a9pN28qOTK4ZQv0m8CREMjnkWJ
 i7CgDq6Qh5nO3YiLEiJ0hKLmmxB1NfSUkyecB5eo5xGbzTBaRvbz+I1E1OnJZ21PMiTUXkieUte
 lHRMr3psn8cRyN7w=
X-Received: by 2002:a1c:7315:: with SMTP id d21mr3769925wmb.186.1582195435695; 
 Thu, 20 Feb 2020 02:43:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmq+wX4qy3g/khi9BvnTbSJWmCVzb/IwDGyzPt7Df/Kesmo25gPsAMjfijhYY9FD/50rx9Sg==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr3769906wmb.186.1582195435454; 
 Thu, 20 Feb 2020 02:43:55 -0800 (PST)
Received: from [10.201.49.12] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id f8sm3844274wrt.28.2020.02.20.02.43.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 02:43:55 -0800 (PST)
Subject: Re: [PATCH v2] util/async: make bh_aio_poll() O(1)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200219175348.1161536-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b11d618-06d8-50c5-98fd-d1115b1df8f2@redhat.com>
Date: Thu, 20 Feb 2020 11:43:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200219175348.1161536-1-stefanha@redhat.com>
Content-Language: en-US
X-MC-Unique: i7s1DRWePSuSRUtWr8FFiQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/02/20 18:53, Stefan Hajnoczi wrote:
> +}
> +
> +/* Only called from aio_bh_poll() and aio_ctx_finalize() */
> +static QEMUBH *aio_bh_dequeue(BHList *head, unsigned *flags)
> +{
> +    QEMUBH *bh = QSLIST_FIRST(head);

I forgot, this should also become QSLIST_FIRST_RCU.

Paolo


