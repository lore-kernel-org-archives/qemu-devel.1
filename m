Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D25AC35E0C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD602084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0DSc8F2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD602084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dfg-0006Um-4f
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 12:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j6daH-0000RD-5e
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j6daG-0004Wp-3t
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:01:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43502
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j6daF-0004Wf-VF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582650083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+V9EAKGQNYz6krmgcIbT+mmpIxAE1UKd9LX7WpYoYQ=;
 b=C0DSc8F2kVJeollxP0GsTkPSDSAmNoodkd/Pvw3PFimOgF4/aiEuymkHJHJ0znqMIhIrED
 a40WcqPC2oTj+1pz1bo1iUXGE2s5j5sMSD8EvCAt4CqoB907aVxYnGl+GUcXQkXxMUDuYd
 ZJ1rbmSi0s2kkcGJCu284G+ZCWwjLSg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-kFd45B0mMH6p7dFEoPHIcQ-1; Tue, 25 Feb 2020 12:01:19 -0500
X-MC-Unique: kFd45B0mMH6p7dFEoPHIcQ-1
Received: by mail-wm1-f69.google.com with SMTP id f66so22021wmf.9
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 09:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W+V9EAKGQNYz6krmgcIbT+mmpIxAE1UKd9LX7WpYoYQ=;
 b=BvKVdQ58+4ZxiEUbq5lU7mz3bB5lLUmB2YZAMx019+EZszYSw9p5eiMEReEKdnydSA
 OjsTcuUfgW++itQmVfJa+mmnKSuC0tyftHbx47UXpms8LKI8gEJNYJnBFA1am01ZTOKT
 LJA8lSecINDDaKBPMIB59AHKonNml4h1AMELU4qA1ZbQGqhkla7ewFZliIcG4+fRUdeW
 +XpfBuaQx5utTZsjvZCTzoxVot8EV9YA9sxEtWWiYJ3Ll6W3oXBhgpxIOM1niqG/D2dL
 JQMIzpRbTb0Zy+a5BI6q63Wn4iJZVfN1m6rqZa/Uapkc6TlANlswYwaFG/y44pYoS8y6
 ml6w==
X-Gm-Message-State: APjAAAVuEyxbbNimwcC+SDmD7qWfbxM8zzxZVg4+2GDEcw/4fMomJIh0
 MbIFS2zpgzSbTNt63m6b5mqqCOsKoiDcI0s3fKijv9n5QZwdFVMN3kNqMVcN0DndMLiKLdDmPK0
 lL6Fs+ZCu1wgYyl8=
X-Received: by 2002:adf:e949:: with SMTP id m9mr118361wrn.342.1582650078401;
 Tue, 25 Feb 2020 09:01:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxV33VibyDtjydYzaMNS3kOga/lt3g5pRyBWmbKawKU7eUHLZJ7S5CJgQiuHQI43Vatpzonyw==
X-Received: by 2002:adf:e949:: with SMTP id m9mr118334wrn.342.1582650078151;
 Tue, 25 Feb 2020 09:01:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6?
 ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
 by smtp.gmail.com with ESMTPSA id s1sm24396824wro.66.2020.02.25.09.01.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 09:01:17 -0800 (PST)
Subject: Re: [PATCH 0/4] docs: Miscellaneous rST conversions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200225154121.21116-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a6757cb-fda2-ba3f-6c24-f09829faf4ab@redhat.com>
Date: Tue, 25 Feb 2020 18:01:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225154121.21116-1-peter.maydell@linaro.org>
Content-Language: en-US
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/02/20 16:41, Peter Maydell wrote:
> This patchset converts some texi files used in qemu-doc.texi to rST:
> 
>  * docs/security.texi
>  * qemu-tech.texi
>  * qemu-deprecated.texi
> 
> which all end up as sections of the "system" manual.
> 
> In all cases, these pieces of the documentation are part of
> the qemu-doc HTML file, but not included in the qemu.1 manpage,
> so they are just a straightforward format conversion.
> 
> security and deprecated are pure conversions with only
> changes to the formatting, not to the contents.
> 
> For qemu-tech.texi, a large part of it was an extremely out of
> date and partial attempt to document the limitations of our
> CPU emulation. Apart from a change to the Xtensa section in
> 2012, no part of the actual text seems to have been updated
> since 2008. I judged it better to simply dump this rather
> than carry it over. Creating an actually accurate section
> about the limitations of the various guest architectures
> is probably easier done from scratch if we want it and are
> prepared to actually keep it up to date this time...

I assume these are not meant to be applied now, except patch 2?
For what it's worth, security.texi can be converted just fine with:

makeinfo -o - --docbook security.texi  | pandoc -f docbook -t rst

Paolo


