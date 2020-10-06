Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E30EC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855F42078E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkIqSYRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855F42078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlH9-0003TO-Ff
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPlDz-0000kP-B3
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPlDx-00082h-Az
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601984020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2B+DD3ctGRt8Cywo9yb29QDLcgK+CfHXL7MYU3VdqJ8=;
 b=PkIqSYRg/GWLfu02aPuZarqCzoELXPkRhUa5xNnNW4ChmUGOaJdYzQ/QyovPzjci/ZlV+/
 ibxgQ7y0/cZOs0kooxy3tWOA8oJMz6JsLabosm8SI1Gbwbfo9tg7fiU7XA+uCW+7PwBPmI
 ZLrfOQkhpKUYCG8sbCMcuLB/st9JISQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-omQQ97IKNdOE7DFTu9-BJg-1; Tue, 06 Oct 2020 07:33:38 -0400
X-MC-Unique: omQQ97IKNdOE7DFTu9-BJg-1
Received: by mail-wm1-f71.google.com with SMTP id m14so603006wmi.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=2B+DD3ctGRt8Cywo9yb29QDLcgK+CfHXL7MYU3VdqJ8=;
 b=iMhZSDjsupc4AuCOGYdykIVitX3DzPnnN3odYzqJg8lIV8aApYuptIEUEV5p3qfgda
 WzZd4c7P76gwPW4mEfa+Qv3E4g49NLi1EseKHwd1Qky4HMxCFyeX7J6OiSHhGo4Qo2kk
 suXWjnzNvaNfufLXwT5OT3kdU4YxyjiZrsAdMA3Xe1G42ntJXTbFVdzx6ErAvk+rg01P
 t6+N9GJkhK8xMG44C7hrdPog+6WtfsAd9wHSIH3lbT7Mzo939hdetPBYgTAZz7k7RfBw
 IIpEscIosxMeTtA6vMV769qzwXhIouk3ee9+skPq8vuNqWUsyU85UudQw09yLur+zZBP
 53mg==
X-Gm-Message-State: AOAM5319k1Aw61nOT7o1omu4ePy3lpFzdsqr9PMHyxQJ5BOyVArqlDRV
 9Z699N6qMfjy0u2MHUSXnEFDuTJ1NFduAcacSk4dJutvNYL88gj/ofzZ2U8g1e7hxAY2ZQ85S6V
 qK4I6iw2hvj7SXk4=
X-Received: by 2002:adf:a28a:: with SMTP id s10mr4435133wra.300.1601984017037; 
 Tue, 06 Oct 2020 04:33:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2vvvpoz5u2PsgcW8t2tn8Q/+ltosRKHZ9sWm95AonVx6u9A3iLjXB060T9ezIi1zU2WbyYw==
X-Received: by 2002:adf:a28a:: with SMTP id s10mr4435118wra.300.1601984016803; 
 Tue, 06 Oct 2020 04:33:36 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id f189sm3715850wmf.16.2020.10.06.04.33.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 04:33:36 -0700 (PDT)
Subject: Re: [PATCH v5 05/36] qapi: Prefer explicit relative imports
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-6-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <fed558a5-8529-7b3b-5790-79b368e4d897@redhat.com>
Date: Tue, 6 Oct 2020 13:33:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005195158.2348217-6-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 9:51 PM, John Snow wrote:
> All of the QAPI include statements are changed to be package-aware, as
> explicit relative imports.
> 
> A quirk of Python packages is that the name of the package exists only
> *outside* of the package. This means that to a module inside of the qapi
> folder, there is inherently no such thing as the "qapi" package. The
> reason these imports work is because the "qapi" package exists in the
> context of the caller -- the execution shim, where sys.path includes a
> directory that has a 'qapi' folder in it.
> 
> When we write "from qapi import sibling", we are NOT referencing the folder
> 'qapi', but rather "any package named qapi in sys.path". If you should
> so happen to have a 'qapi' package in your path, it will use *that*
> package.
> 
> When we write "from .sibling import foo", we always reference explicitly
> our sibling module; guaranteeing consistency in *where* we are importing
> these modules from.
> 
> This can be useful when working with virtual environments and packages
> in development mode. In development mode, a package is installed as a
> series of symlinks that forwards to your same source files. The problem
> arises because code quality checkers will follow "import qapi.x" to the
> "installed" version instead of the sibling file and -- even though they
> are the same file -- they have different module paths, and this causes
> cyclic import problems, false positive type mismatch errors, and more.
> 
> It can also be useful when dealing with hierarchical packages, e.g. if
> we allow qemu.core.qmp, qemu.qapi.parser, etc.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qapi/commands.py   |  4 ++--
>  scripts/qapi/events.py     |  8 ++++----
>  scripts/qapi/expr.py       |  4 ++--
>  scripts/qapi/gen.py        |  4 ++--
>  scripts/qapi/introspect.py |  8 ++++----
>  scripts/qapi/main.py       | 14 +++++++-------
>  scripts/qapi/parser.py     |  4 ++--
>  scripts/qapi/schema.py     |  8 ++++----
>  scripts/qapi/types.py      |  6 +++---
>  scripts/qapi/visit.py      |  6 +++---
>  10 files changed, 33 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


