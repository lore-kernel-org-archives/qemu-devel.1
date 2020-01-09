Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9360CC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CCBF20673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSzSDeZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCBF20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipToA-0003FF-FN
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 04:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1ipTnM-0002Vf-MS
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1ipTnL-0008Mo-If
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:08:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1ipTnL-0008Hp-CO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578560878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IsDwMPXcCv7+6PzjfjoTr9fJjxGOakuvEu5jk51/y64=;
 b=WSzSDeZXipZT+ZQNwY+RR9XH05GIxMwNkDO4d9WQH5Grllp7NRJYFtoEjckk1kaL3prLz7
 m/cLkmPdX3jYIozW1IJ6HdNnneSfGEfla1uw+v5lgGlu7/j/xvKb6+C7O75JVNjZCa7zlT
 vzczkIuLjt1w4ALiSOOiy/jrzVKgTus=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-N0vqMPIPM62LLz52XgdY6w-1; Thu, 09 Jan 2020 04:07:54 -0500
Received: by mail-wm1-f71.google.com with SMTP id t16so659815wmt.4
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 01:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=kV465tktOfEqHtBv+Vh0jQXTgZgU67zXGOfh7xHrAhY=;
 b=ugTuyA79UCZ+QfnITg7EDuPUZQ6aFC0An6JflbsB6lGKycCRaALgNd9C7pjDA6B8Uy
 sqnFwRpwgF/Lg8PhuckrJFbdwBd6LHic9L+xqY+UGDmeieTU/az5ajQO3KENi9uf4dPc
 ER76EZJHbAXml0idlTCh5qTyg0pFudYTfkxWzHKBERsU0YvMRMAZcNVHxTNubml4Mz0G
 oDXnjPdZ+kUCjCcvObDuw7JvZUJQNZUjqZ7Cm1/QVaTL+XxU7uc1MOszvkw55I21gKHo
 CoriMZgW10ienuWidP4LIGRhCeQEBdHQQ3jCrHsrSQ+ibGRljqyo27ClkdPDY3/fcBpQ
 Uslw==
X-Gm-Message-State: APjAAAWTs4h+gEiZQ5pwcZfWBwqvyKgL62Fv1KyEAx2sXBM48QezvKX2
 wttJmDHGt0JzHR8tlrAGXVBg1i57c6jTnhkhY9TG7sRwGVw+idqEvvmt1rMqaxsG1wsyIP4uMOQ
 nkU1PgBK89zNGVJY=
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr9650660wro.128.1578560872966; 
 Thu, 09 Jan 2020 01:07:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqyxtmVJDwi5ZsWJTHa97pzlKAVVZPQQucRcjF9IzWt4r+55f4JDhhw8AxhP9lA473vf5iyLbg==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr9650640wro.128.1578560872721; 
 Thu, 09 Jan 2020 01:07:52 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id i10sm7811713wru.16.2020.01.09.01.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 01:07:52 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/2] exclude hyperv synic sections from vhost
In-Reply-To: <53359208-3cd9-b0b6-f424-a5135e770fca@redhat.com>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <53359208-3cd9-b0b6-f424-a5135e770fca@redhat.com>
Date: Thu, 09 Jan 2020 10:07:50 +0100
Message-ID: <87tv55q9p5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: N0vqMPIPM62LLz52XgdY6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Roman Kagan <rkagan@virtuozzo.com>, mst@redhat.com,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Wang <jasowang@redhat.com> writes:

> On 2020/1/8 =E4=B8=8B=E5=8D=889:53, Dr. David Alan Gilbert (git) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> Hyperv's synic (that we emulate) is a feature that allows the guest
>> to place some magic (4k) pages of RAM anywhere it likes in GPA.
>> This confuses vhost's RAM section merging when these pages
>> land over the top of hugepages.
>
>
> Hi David:
>
> A silly question, is this because the alignment when adding sections? If=
=20
> yes, what's the reason for doing alignment which is not a must for vhost=
=20
> memory table.

SynIC regions are two 4k pages and they are picked by the guest, not the
host. These can be anywhere in guest's ram.

--=20
Vitaly


