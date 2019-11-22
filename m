Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53274C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:01:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A322068E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HL5LTsJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A322068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY8YX-0007ke-0F
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 08:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY8XS-0006oh-CN
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY8XP-0005bv-DS
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:59:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38779
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY8XP-0005bm-0L
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574427589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20WinXQxzHN7ybIWaiJ7FKH7bIprGcYx1MOID4gugfk=;
 b=HL5LTsJ2+HELuTOFrbQxLSFWVzLJeuSJPE9OZpLDce2K3fOPrdMh164q9D5aAu3T0kcxBE
 igb6HMQXP6D6RfBhdSl2ImaTcO7iph2E716zjF5HPUe5Q5OBmMHyc1XrIpUnwhAQEhkRgv
 etpU3vPWuFiO48G1FMjyaa8ee4tQ86g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-KnApzefYP6ynAy_xEy7luw-1; Fri, 22 Nov 2019 07:59:48 -0500
Received: by mail-wr1-f71.google.com with SMTP id y1so3900564wrl.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 04:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7IQnHHmWf61do96KKdhdxCSuQtMnMKEq7xaHkj6ifE4=;
 b=hNCBX5aFxpd5RjpRUCQVJuUGCA1aB5j+MHmrK6BFkkWuTT8OxP9LQ+vrzcvcUUTz5f
 RngMSRP26P7l8v4vyhOmsN5Q37SwnDORlD++fZZ+Rz2WogU1wX3WmIxEGxxhsQtwsTmG
 J77tEGiGFpWQ++WW4T/EDWQ6hV8QCbuBBKMABRqFQO3+3sUDA/myghUQQT+J6zCx9mGU
 2bPQvKIybi1ichfdKEkKTAjPawWh/i7qqkj0VtIUqL5QT/JkK0lSB6TrkFRM4FjJltNp
 ih/jmTXWetgUOLnBbAYtGT8ozF/y0z3LPNEqciZn05+Vzn9CSLEjQPwSXeXPHOxBeQ1M
 Hc+w==
X-Gm-Message-State: APjAAAWOhLog+a2ldXq1LZoRVhJXEEsTZrp/em4akGKsQoJR2MWOldtP
 7JZnXiP1slhTvzOaE0LTA9wasALTPOPkKxVQRrw2d7E+F/vm9Rp2zDgu+Tfa1Mz2qPMnXq3zYHE
 bVG0NUo0NJbUnqFg=
X-Received: by 2002:adf:979a:: with SMTP id s26mr17910089wrb.92.1574427586816; 
 Fri, 22 Nov 2019 04:59:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJF0BB3Kmiyknfyw5qJCnTZWlojkSFB+B87d5+9p4Y04u0hYxazCcivUeUd0IBGbVR2ZfjAw==
X-Received: by 2002:adf:979a:: with SMTP id s26mr17910072wrb.92.1574427586619; 
 Fri, 22 Nov 2019 04:59:46 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id d16sm5935070wrg.27.2019.11.22.04.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 04:59:46 -0800 (PST)
Subject: Re: [PATCH] virtiofsd: fix libfuse information leaks
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191122113130.481113-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0bda9aff-2912-4107-6d9f-c385068ca646@redhat.com>
Date: Fri, 22 Nov 2019 13:59:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122113130.481113-1-stefanha@redhat.com>
Content-Language: en-US
X-MC-Unique: KnApzefYP6ynAy_xEy7luw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: virtio-fs@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 12:31 PM, Stefan Hajnoczi wrote:
> Some FUSE message replies contain padding fields that are not
> initialized by libfuse.  This is fine in traditional FUSE applications
> because the kernel is trusted.  virtiofsd does not trust the guest and
> must not expose uninitialized memory.
>=20
> Use C struct initializers to automatically zero out memory.  Not all of
> these code changes are strictly necessary but they will prevent future
> information leaks if the structs are extended.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Nice cleanup.
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


