Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC60CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3792075F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wzr+2Qfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3792075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbI8l-0005i2-R4
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 02:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbI7p-0005Gx-JA
 for qemu-devel@nongnu.org; Wed, 20 May 2020 02:22:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24450
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbI7n-0004xR-DJ
 for qemu-devel@nongnu.org; Wed, 20 May 2020 02:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589955761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1HAVuHuK8J+ceFtD+NRtFdbyXmgDMYg1eHdQx/RTaaI=;
 b=Wzr+2Qfb1eXbcrbt7HVWh/nu8awsG8ShyxSWO6kxrUTsOkeLw2YRtWYoSqv7iuy4DqbIHu
 h/Pd0gwi5quzUkmCglWICz+gHF41uAIO4mP5jL01tc/AEAoJW4/ss0CH5xGRdDUVnF4jsr
 YnUDdqmsM8j4jn2pqFJKAxLxlqswERI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-guASwyBTOVC0wBYrDJnDCg-1; Wed, 20 May 2020 02:22:37 -0400
X-MC-Unique: guASwyBTOVC0wBYrDJnDCg-1
Received: by mail-wm1-f69.google.com with SMTP id o8so1637639wmd.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 23:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1HAVuHuK8J+ceFtD+NRtFdbyXmgDMYg1eHdQx/RTaaI=;
 b=NvCKhxJt3CrHGjrh5pqzJ1tWD5pj9Cfb6atq3K17q8fgcPZiVVMkGw3QIo2Txbl8q7
 StCGS82RxrnqJYKF8NNTEGs+rXXRsXYOYVPGPDfz2jKee4hLV2tg0YiffCeh0DyD74MU
 2hV3lFk8jsxvPjcbGOmPF7PzykKFmRSxv3HuxnnxIxRvprZmSJbqdk7fvqNxWBV3TKen
 a6+iZEGGusRkONpJOalyHocA0Zhry7XUozSqIpCVEd/cyqS1EMmu24lNUkGJ4C4Z8iie
 xjk2jNUcsmX0sS8BLpJsp1u1pqEP+QOX8cHMRFxdI02VLLBn5ismcAYYECbvWCjpXGOL
 O9jg==
X-Gm-Message-State: AOAM532vm45ehhBKDSKkuL1MoNDcz1KmaVn1viJbOgDy2PfAb+oGnlky
 OELF++hK2cnVHgIhkavknm6sjYiLmoqED6td1xHNbAm4Xi4GQXd+zBym2MXMcytFWjZXi8Q5HVH
 r6GV3KK9RQytCkZc=
X-Received: by 2002:a1c:ab45:: with SMTP id u66mr2992392wme.152.1589955756624; 
 Tue, 19 May 2020 23:22:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhYxur3vY1e1hpzn2uTpMQX0FxIGzyt4q8x3VkywTdALubbHRSvX++fJPWlaCyLefYcAY5kw==
X-Received: by 2002:a1c:ab45:: with SMTP id u66mr2992378wme.152.1589955756407; 
 Tue, 19 May 2020 23:22:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:591e:368f:1f3f:27d2?
 ([2001:b07:6468:f312:591e:368f:1f3f:27d2])
 by smtp.gmail.com with ESMTPSA id z12sm2137944wmc.6.2020.05.19.23.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 23:22:35 -0700 (PDT)
Subject: Re: [PATCH 03/55] qdev: New qdev_new(), qdev_realize(), etc.
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-4-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9b329adc-8110-c108-996a-3b7d8463d042@redhat.com>
Date: Wed, 20 May 2020 08:22:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200519145551.22836-4-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/05/20 16:54, Markus Armbruster wrote:
> +
> +    object_ref(OBJECT(dev));
> +    object_property_set_bool(OBJECT(dev), true, "realized", &err);
> +    if (err) {
> +        error_propagate_prepend(errp, err,
> +                                "Initialization of device %s failed: ",
> +                                object_get_typename(OBJECT(dev)));
> +    }
> +    object_unref(OBJECT(dev));

Why is the ref/unref pair needed?  Should it be done in the realized
setter instead?

Paolo


