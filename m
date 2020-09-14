Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B10C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CFF20665
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Glyoa8Uj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CFF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqQ2-0002zM-A6
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHq7e-0003fD-7F
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHq7c-0000kp-8t
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600096223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f6kQWIbAStQqMS5tqkWJYoj30kfLL6D+iVGO59jvutw=;
 b=Glyoa8UjbxK4aAH983zZ9P2Q1QSG5B757n8YA6ya/4htaqGSHoHFmQcAUqEt7tdvmYeCIx
 op9S89zspVefMEwK1sSCaY+FZPkQAj9JtC0kNhRQEn6hL7M99zXpyb+NJaHZ3sbn1sOWgn
 oywwIC3Jzsp1D/IBeQQ8R74qV2eYYgo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-mPwo8tq0P2yHfYV-9Y96rQ-1; Mon, 14 Sep 2020 11:10:15 -0400
X-MC-Unique: mPwo8tq0P2yHfYV-9Y96rQ-1
Received: by mail-wr1-f69.google.com with SMTP id 33so6999186wrk.12
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 08:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=f6kQWIbAStQqMS5tqkWJYoj30kfLL6D+iVGO59jvutw=;
 b=r4ZgSwRccXDHxlga6JLGHDbXdmPZzvnaFUFpaWgfBEmQFjlDI+Uc2KvWEs015d8GSS
 8PPIIepLXBe5EjlAqRuosvnIV2fY3VFwJmowuDvmPzNm0itPfJsrVSqJBqaGHuOeaBoi
 qf/WMpSvMwc1+7H2/pOiueewFjm5xrIHrgwNwUa2ldf3JvNKXYLz4L/pK3/i07FaOA6P
 28kL1Afa41bRii/rzuK0iyR6Y9AaHOkj+63VOwxqJdyFCRiohkF+0KdV2ZIJNpgEImHV
 zMJyl5jd+bXnmdtNEyiFF+Mx+X8/QDQpqwgD1TnaSYtf1TJTbUiVYlvfeLLPedUeRC49
 RdnQ==
X-Gm-Message-State: AOAM531qJWk5HNppqUr8e5k/M0wazALjb0Tot98o+k4kZXWwnfBLFDHa
 11nrr/uNUbVyty3W0bPbosqSMPb/4m+wJMB7FWqa+c82NOz1U4LagIGIXBf9b9uZb7wB5aw+IWO
 hJTfxesFHp4OO0jY=
X-Received: by 2002:a1c:2ed0:: with SMTP id
 u199mr15000683wmu.125.1600096213187; 
 Mon, 14 Sep 2020 08:10:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDKAXQuwMNkhPLKzPvDmfAKBkFnu/krn71dYyLm263nvrXtdXAAGgyGX6/hmDEEDJBf5M3Sg==
X-Received: by 2002:a1c:2ed0:: with SMTP id
 u199mr15000665wmu.125.1600096212960; 
 Mon, 14 Sep 2020 08:10:12 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y5sm20766103wrh.6.2020.09.14.08.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 08:10:12 -0700 (PDT)
Subject: Re: [PATCH v2] qom: simplify object_find_property /
 object_class_find_property
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200914135617.1493072-1-berrange@redhat.com>
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
Message-ID: <ec7a1ce1-d273-2b31-ee37-732a12384bca@redhat.com>
Date: Mon, 14 Sep 2020 17:10:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914135617.1493072-1-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 3:56 PM, Daniel P. Berrangé wrote:
> When debugging QEMU it is often useful to put a breakpoint on the
> error_setg_internal method impl.
> 
> Unfortunately the object_property_add / object_class_property_add
> methods call object_property_find / object_class_property_find methods
> to check if a property exists already before adding the new property.
> 
> As a result there are a huge number of calls to error_setg_internal
> on startup of most QEMU commands, making it very painful to set a
> breakpoint on this method.
> 
> Most callers of object_find_property and object_class_find_property,
> however, pass in a NULL for the Error parameter. This simplifies the
> methods to remove the Error parameter entirely, and then adds some
> new wrapper methods that are able to raise an Error when needed.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> v1: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03621.html
> 
>  hw/arm/armv7m.c                  | 10 +++---
>  hw/arm/exynos4210.c              |  2 +-
>  hw/arm/highbank.c                |  2 +-
>  hw/arm/integratorcp.c            |  2 +-
>  hw/arm/realview.c                |  2 +-
>  hw/arm/sbsa-ref.c                |  2 +-
>  hw/arm/versatilepb.c             |  2 +-
>  hw/arm/vexpress.c                |  4 +--
>  hw/arm/virt.c                    | 10 +++---
>  hw/arm/xilinx_zynq.c             |  2 +-
>  hw/core/qdev-properties-system.c |  2 +-
>  hw/core/sysbus.c                 |  2 +-
>  hw/cpu/a15mpcore.c               |  4 +--
>  hw/cpu/a9mpcore.c                |  2 +-
>  hw/misc/iotkit-sysctl.c          |  2 +-
>  hw/pci/pci.c                     |  2 +-
>  hw/scsi/scsi-bus.c               |  4 +--
>  include/qom/object.h             | 48 ++++++++++++++++++++++---
>  qom/object.c                     | 60 +++++++++++++++++++-------------
>  target/arm/monitor.c             |  2 +-
>  target/i386/cpu.c                |  2 +-
>  target/ppc/translate_init.c.inc  |  2 +-
>  22 files changed, 109 insertions(+), 61 deletions(-)

If possible, please use scripts/git.orderfile ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


