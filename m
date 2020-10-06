Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0AFC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493C8206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AE7pYVTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493C8206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmUF-0000nO-Ao
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPmIS-0004Ht-P3
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPmIN-0008L6-1V
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601988138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q54DeDMlHthao9VmYbhxat3EqbyLespmyF/OvHq8mO0=;
 b=AE7pYVTl9rB98UUEYxuO9CJJTN8Ot7C3pHc99GjpBRV+0SvmAhun55MAUwoOgIUu3Vynrz
 E9EfxJe4DKH7kvzUhjkOp/61KQkeTnF2iuRIiBu50p8cwVV5pyu2ErtXrIRqXbJ6b24yaC
 vP3um497HFS5qcHVEX1RexoK8zHWe70=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-KphzZ_31NQKBoa6cTY5T8A-1; Tue, 06 Oct 2020 08:42:16 -0400
X-MC-Unique: KphzZ_31NQKBoa6cTY5T8A-1
Received: by mail-wm1-f70.google.com with SMTP id z7so1073737wmi.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q54DeDMlHthao9VmYbhxat3EqbyLespmyF/OvHq8mO0=;
 b=m6oeLpEPqZkFVMnb8cglH6oKs1Hd6iC5wHSzvz9e/nfPFo752WjPart7LbKyA9Kbyo
 pxnCxeQd7LvzX0/bnVsu4vJotyiwY3RVA134I1Hvim4NXmQT5JINT1xJXCTNvNIEQuhP
 cv4kLh3anv956zJJ/yzVHMl/wfxJ3v7NQhGU+ZowpBOGUJpokbqRdSsCK8Kg53e0K+h/
 BK2eWXPESdfvH9FCWcPtJSTU+lqmUhW5EpMXyo+cknJuQCvQXo6niDjrwn4gEWWco0EI
 5+IuWNO1hTdV1AmplnIpD6nN6XB6Hw+8ydG1xD97boYJsPaY0HuYzQCKtb1DNgGZhwZZ
 S3Uw==
X-Gm-Message-State: AOAM532GVsUGD5sCyiYNixLZhxlPA8Z5GP24rMuBWElhybPuCebt/Zji
 vyHf6NRzQvXw0rH9ZFhMj45Ocz6QnJ77QWzU8v8Uj8W7ZQNLtscs4wv9QnVSHiwaz6q8l51qSwL
 OobfdpP9vwt5SykM=
X-Received: by 2002:a5d:460e:: with SMTP id t14mr4797557wrq.399.1601988135247; 
 Tue, 06 Oct 2020 05:42:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLFiE8e+WLGiHJXB6+DIwkaD+ku9cjXzQ9Lsn+YIX9BP/bszXKTyCfdWJzVBD0DA6K/Sp6CA==
X-Received: by 2002:a5d:460e:: with SMTP id t14mr4797533wrq.399.1601988134964; 
 Tue, 06 Oct 2020 05:42:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e?
 ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id b8sm3802043wmb.4.2020.10.06.05.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 05:42:14 -0700 (PDT)
Subject: Re: [PATCH 0/3] docs: Include QTest protocol and libqtest API on
 documentation
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201005205228.697463-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62596d37-6bfe-36a4-1a72-d2d2d4c0ba88@redhat.com>
Date: Tue, 6 Oct 2020 14:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005205228.697463-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/10/20 22:52, Eduardo Habkost wrote:
> This moves the QTest section of testing.rst to a separate
> document, and include the QTest Protocol specification and
> libqtest API reference in the document.
> 
> Eduardo Habkost (3):
>   docs: Move QTest documentation to its own document
>   docs/devel/qtest: Include protocol spec in document
>   docs/devel/qtest: Include libqtest API reference
> 
>  docs/devel/index.rst          |  1 +
>  docs/devel/qtest.rst          | 72 ++++++++++++++++++++++++++++++++++
>  docs/devel/testing.rst        | 47 +---------------------
>  tests/qtest/libqos/libqtest.h | 20 +++++-----
>  softmmu/qtest.c               | 73 +++++++++++++++++++++++++++++++----
>  5 files changed, 150 insertions(+), 63 deletions(-)
>  create mode 100644 docs/devel/qtest.rst
> 

The series is moving obsolete (non-mesonified) information.  I should
fix the docs at the same time, so I've queued it and will send the fix
on top.

Paolo


