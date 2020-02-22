Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8720CC35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 07:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E4120707
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 07:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d46TErtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E4120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5PMI-0005ut-EH
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 02:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j5PLk-0005TN-Nw
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 02:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j5PLe-0004N9-Ty
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 02:37:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30529
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j5PLe-0004Jh-N6
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 02:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582357033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BADePD2CDWPVnUUrjtkaGZWirrjoPe2vBaoNADjEj8o=;
 b=d46TErtwyiUnXfUKCAnMohEi/hRdoW5clLuaFfuuXnu4rbxxHYlwG78Y3GcJiGfgsd9V5p
 sDYy6/mGz/kNxcIBEwCB2fxaK8r818NwVh787Hn0o3Z6wdXko1woO8rOWXtGjPr8AHJ2tY
 +kCfuBpYoRGbdtruNGyqX7vP/mGSitU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-9ecAI1E9P5-auuoa_c-jEw-1; Sat, 22 Feb 2020 02:37:11 -0500
X-MC-Unique: 9ecAI1E9P5-auuoa_c-jEw-1
Received: by mail-wr1-f72.google.com with SMTP id w6so2157016wrm.16
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 23:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BADePD2CDWPVnUUrjtkaGZWirrjoPe2vBaoNADjEj8o=;
 b=jgZpjh7LFYeWEvjTFAjuz0qnFweTQEeTZYbnzFVswF1R1oIPocn3V8c35iAfME5xRz
 NynEb7jCyNFCkRmhngSvPZKkM4Z818A31LuIK2t7S9si+FDmatWdSy4DQ4DLh4eHuPaV
 5vTI8Ry13jg+NIjK+EzQKvld6LAIQdmeP69NOB9daQcx58nrX7ZHJTk4IE2sKpLeSxlU
 D7OIS+fC2XSzzoj1Ma9+bwhVUHOYYlaLJZvDT94ik8nBu9zZj7nHy6e2hb4mDftF0ef2
 a4suA1kXj99oALrIlW6xbVqIQh4GSLQxDBR/fOf7Cs7vAjerMoKUNHuESzjAGXC4vEi9
 PuhQ==
X-Gm-Message-State: APjAAAWo8aG0XM6nNFoLpTQJq4aKbiunJOIaGF+1byHe80Wn25M5+IOk
 sMedNnxnd4PsrdunmSxypIiy6e2h8MwJa1OJAHprziBf20YrqxImUYi0Qdr4bQarMVnsofMO3r/
 /pf8Ifk0U8GNSg+0=
X-Received: by 2002:a5d:5007:: with SMTP id e7mr53595771wrt.228.1582357030679; 
 Fri, 21 Feb 2020 23:37:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyaBZIx3DKBwoM+G1KuVbpVf64luAW4oF89n0wNE2LT5MhVT7/E1O2WIBKTYfn0Brks2Bktfw==
X-Received: by 2002:a5d:5007:: with SMTP id e7mr53595746wrt.228.1582357030389; 
 Fri, 21 Feb 2020 23:37:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51?
 ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
 by smtp.gmail.com with ESMTPSA id a13sm7428590wrp.93.2020.02.21.23.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 23:37:09 -0800 (PST)
Subject: Re: [PATCH] target: i386: Check float overflow about register stack
To: Chen Gang <chengang@emindsoft.com.cn>
References: <20200221034547.5215-1-chengang@emindsoft.com.cn>
 <a5533719-7ef1-938b-e52c-20711e65417f@redhat.com>
 <900fd511-72f0-675d-4a7e-d228b2ade9c7@emindsoft.com.cn>
 <d893eac5-0b7a-ddfe-2acf-a6f27ab48ccf@redhat.com>
 <f3bea474-468b-5818-9f69-5463be6d9b2a@emindsoft.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ab8ed82-dadd-2d5e-5bbc-69a67ba89e26@redhat.com>
Date: Sat, 22 Feb 2020 08:37:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f3bea474-468b-5818-9f69-5463be6d9b2a@emindsoft.com.cn>
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
Cc: qemu-devel@nongnu.org, Chen Gang <gang.chen.5i5j@gmail.com>,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/02/20 03:10, Chen Gang wrote:
> Set C1 to 1 if stack overflow occurred; set to 0 otherwise".
> 
> In helper_fxam_ST0, I guess, we need "env->fpus |= 0x200" (but I don't
> know wheter it will be conflict with SIGND(temp)). And we have to still
> need foverflow, because all env->fptags being 0 doesn't mean overflow.

No, you need to add "env->fpus |= 0x200" and "env->fpus &= ~0x200"
directly to fpush, fpop, etc.

Polo


