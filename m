Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CB6C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A9020936
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfDE0urH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A9020936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVrem-0005oN-GN
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 03:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVrdO-0004UL-Ox
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVrdM-0004Zs-Tv
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603438628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlRkRAwl6dnRhQZwie6q6QnCQsitL5bei/rBFmrntnI=;
 b=LfDE0urHUzzx7xuvWbfqH8OkKt1sTDUBDyAxUGtvIWbOhXqRWrHc1nrsGiq6eszRbHjKJN
 T9rwTbIkuBQycITFxFEvREtdX3ZsvSNwa27tfJuuIQothXXYUNneonZGy2+ZZ2m5U0oCsQ
 UAtVWwFT933djG5oC8Y1C1ZTpQiEjXQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-UtaxOrDqPHmCVvQx3k_TFQ-1; Fri, 23 Oct 2020 03:37:06 -0400
X-MC-Unique: UtaxOrDqPHmCVvQx3k_TFQ-1
Received: by mail-wm1-f72.google.com with SMTP id l23so67573wmg.6
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 00:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KlRkRAwl6dnRhQZwie6q6QnCQsitL5bei/rBFmrntnI=;
 b=EMP/JyUCoGPmtcI+nQuNqwqUDYkjxZc/VmXRAO9o9G7ycMcIsKz10BrhjpXvFm9Phh
 mVYV1affr0MS2YYXS9hfLZzo73ozv9u6YgSnp+JVw6mM3Rk/7mTGZaz0CiSkaao/7vc7
 Z7/u0yRuwZuaOJBwf8hli2xVxVHsyt+A+DzKwS+7hF7YRo3/XfaugD22HHZ/v8Ow4HAs
 gridCS6yUrn4u286crJE3XF25ItK80d6OJ8dVwM3XKd+VrhLGli2LSEVDih30pPxZGhs
 OgfftkO+L35BS+q0fQvTw1zEkmrDHxxn9NPdnY4Tq4fNM/vw/1Qx14v7Dadkjfv8MiXg
 xrcw==
X-Gm-Message-State: AOAM532CXxACCXZSU3hQJdubQM+Q1REXVK7iyEY2eUm+yw1qWAh4t2q3
 f/EBXQ570UkiMOuGQMrb55XzajCEvegaPRI6/m5oKgq9FiextxUufZDDwXZNqa4CDaEssjonudJ
 cz9gHKCo6l+XgQGo=
X-Received: by 2002:a05:600c:21c3:: with SMTP id
 x3mr876225wmj.81.1603438622585; 
 Fri, 23 Oct 2020 00:37:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyG6iWXwfwATBOCWPL4HALDNGXWOauCaVjC3bNeiWfIaTt++/cXT4ivgrVtK1EoO8g4pMXOmg==
X-Received: by 2002:a05:600c:21c3:: with SMTP id
 x3mr876204wmj.81.1603438622351; 
 Fri, 23 Oct 2020 00:37:02 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id r3sm1529624wrm.51.2020.10.23.00.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 00:37:01 -0700 (PDT)
Subject: Re: [PATCH 0/4] qom: Introduce object*_property_add_bool_ptr()
 functions
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201022223140.2083123-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <50e3805e-5750-b3fe-fb80-8be407033e62@redhat.com>
Date: Fri, 23 Oct 2020 09:37:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022223140.2083123-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 12:31 AM, Eduardo Habkost wrote:
> Based-on: 20201009160122.1662082-1-ehabkost@redhat.com
> Git branch: https://github.com/ehabkost/qemu work/qom-bool-ptr-prop
> 
> This series introduces a helper to make it easier to register
> simple boolan QOM properties.  It will be useful for simplifying
> existing property code in some types that can't use
> QDEV_PROP_BOOL yet (because they are not TYPE_DEVICE subtypes).
> As examples, some TYPE_MACHINE and TYPE_QAUTHZ_LIST_FILE
> properties are converted to use the new functions.
> 
> This depends on the QOM property code cleanup that was also
> submitted as part of:
> 
>    https://lore.kernel.org/qemu-devel/20201009160122.1662082-1-ehabkost@redhat.com
>    Subject: [PATCH 00/12] qom: Make all -object types use only class properties<
> 
> Eduardo Habkost (4):
>    qom: object*_property_add_bool_ptr() functions
>    autz/listfile: Use object_class_property_add_bool_ptr()
>    machine: Use object_class_property_add_bool_ptr() when possible
>    pc: Use object_class_property_add_bool_ptr()
> 
>   include/qom/object.h | 23 +++++++++++++
>   authz/listfile.c     | 27 ++-------------
>   hw/core/machine.c    | 78 ++++++++------------------------------------
>   hw/i386/pc.c         | 57 +++++---------------------------
>   qom/object.c         | 31 ++++++++++++++++++
>   5 files changed, 79 insertions(+), 137 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


