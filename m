Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5819CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276CC207F5
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7XZrC0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276CC207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jadEg-0008Il-Ap
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jadE2-0007tZ-Pv
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:42:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50299
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jadE1-0006KR-Iq
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589798544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZ6JkzK1lfuZYMce4i3RMIj5wbbmLus+EmDz200qn74=;
 b=b7XZrC0cKX9vRZcakpz+v7gkYavNVgtZrIZCYYhxBLqs65OOKQjSAdj01F8917R+oAkXCi
 HzP+2HM37qe1uslZl7ZsECgcE7DfMKaWcyihvMBcsWL+0iASAH85axGG+8Vo5ua1SGVbk6
 mIyRE/ycRxXPNOJXiI8srkti1YAkeGA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-N-IB0R4QN_2Rh-CE2D8Edw-1; Mon, 18 May 2020 06:42:22 -0400
X-MC-Unique: N-IB0R4QN_2Rh-CE2D8Edw-1
Received: by mail-wm1-f72.google.com with SMTP id l2so1243769wmi.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 03:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WZ6JkzK1lfuZYMce4i3RMIj5wbbmLus+EmDz200qn74=;
 b=Z565m25EC/8FFo2VT5fbVIc6JOVS6Zuhiy/wAMhocmGQK5Vwze9zbjbfGUgYopwTZv
 M9oggVjxvQUTv/LsXAQ7AhdSM7GkE7ZtpRPrGJYtdS/HWjHHSxrBuG8ah9IXHkVuFOwD
 v3EmhTxOFJhjhDWS+OjTaQ1iDO+rgjsFmfu+nqIRGWUweKpfjucq1bcK0fkVpCjSlyLy
 ETOp0/SQqZgx2g2BhxDumtvnunL7KJrNK+X3P5ClqO6h567voOiOj3BGTDEnnoCWV+Wi
 v1rBZ4cQsAA7RTKRnJAyaRtjwB6R9cOc6M/jYWpqfUDs6t9J/TmtzUIzAkNhTl0c4oFD
 SQSg==
X-Gm-Message-State: AOAM532UUjA0wv2M9A4sROGVB3hjCZZt5hyQM1SN+/NYtnw/r22aknKM
 9EDCcYcfx53OPYxbzINFR9pEODSLmhQY8sWI7AuEsbOd7zh7dVu3LRjN6340L4s8lXUQiywPX8n
 rr1l/Ir/sRXjff1c=
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr19354423wma.170.1589798541075; 
 Mon, 18 May 2020 03:42:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8YIoPF3aKF4AWFKwmH1UxuvAAAd2qixI458WKkulYNnPBwKL8NQ/rFn7+a1XTJooAe6GquA==
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr19354410wma.170.1589798540835; 
 Mon, 18 May 2020 03:42:20 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.90.67])
 by smtp.gmail.com with ESMTPSA id u23sm1718202wmu.20.2020.05.18.03.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 03:42:20 -0700 (PDT)
Subject: Re: [PATCH v2 00/13] audio: deprecate -soundhw
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200515143528.13591-1-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a8fb1d1-b241-b817-6820-298c4719500a@redhat.com>
Date: Mon, 18 May 2020 12:42:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200515143528.13591-1-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: libvir-list@redhat.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/05/20 16:35, Gerd Hoffmann wrote:
> v2:
>  - use g_assert_not_reached() for stubs.
>  - add deprecation notice.

If I understand it, the deprecation message suggests "-device ac97"
instead of "-soundhw ac97", but that in turn relies on the deprecated
default audiodev feature.

So I'm not sure deprecating -soundhw is a good idea.  Instead, is it
possible to make "-soundhw foo" desugar to "-audiodev
something,id=audio0 -global foo.audiodev=audio0 -device foo", where the
"-device foo" would be omitted for isa-pcspk?  It's all ad hoc, but
that's the point of combined frontend/backend options like -nic.

This doesn't change that libvirt can just stop using -soundhw just by
looking for the isa-pcspk.audiodev property.

Thanks,

Paolo

> Gerd Hoffmann (13):
>   stubs: add isa_create_simple
>   stubs: add pci_create_simple
>   audio: add deprecated_register_soundhw
>   audio: deprecate -soundhw ac97
>   audio: deprecate -soundhw es1370
>   audio: deprecate -soundhw adlib
>   audio: deprecate -soundhw cs4231a
>   audio: deprecate -soundhw gus
>   audio: deprecate -soundhw sb16
>   audio: deprecate -soundhw hda
>   audio: deprecate -soundhw pcspk
>   audio: add soundhw deprecation notice
>   [RFC] audio: try use onboard audiodev for pcspk
> 
>  include/hw/audio/soundhw.h |  2 ++
>  hw/audio/ac97.c            |  9 ++-------
>  hw/audio/adlib.c           |  8 +-------
>  hw/audio/cs4231a.c         |  8 +-------
>  hw/audio/es1370.c          |  9 ++-------
>  hw/audio/gus.c             |  8 +-------
>  hw/audio/intel-hda.c       |  3 +++
>  hw/audio/pcspk.c           | 27 ++++++++++++++++++++++++---
>  hw/audio/sb16.c            |  9 ++-------
>  hw/audio/soundhw.c         | 24 +++++++++++++++++++++++-
>  qdev-monitor.c             |  2 ++
>  stubs/isa-bus.c            |  7 +++++++
>  stubs/pci-bus.c            |  7 +++++++
>  docs/system/deprecated.rst |  9 +++++++++
>  stubs/Makefile.objs        |  2 ++
>  15 files changed, 88 insertions(+), 46 deletions(-)
>  create mode 100644 stubs/isa-bus.c
>  create mode 100644 stubs/pci-bus.c
> 


