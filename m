Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F257C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1915420776
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mx5pftpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1915420776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltb4-0007FP-5m
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jltaO-0006gi-Nf
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:24:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jltaL-0002yk-Nm
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592483040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kz5tISaCr8JW6TKiu/3hqmm/CJ/vinGNMO+FowNE3QU=;
 b=Mx5pftpxy4kdC5F3paZkxO0VElj+7VR0awr1oRxp624bWwK7DZKzMBMePOSSAKYs6rz7Ja
 Hpr3n0+lMTb2cBS8AaLp/lZgW0oxC9QUiGayYKQkP+Xr+BkURbTD/hgMSwPdHJag2iO+J/
 xXzpbxH8Q22F+DC33vJxpRTJReGKqAg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-UAzKyEXqPGePBBme3oqRfw-1; Thu, 18 Jun 2020 08:23:54 -0400
X-MC-Unique: UAzKyEXqPGePBBme3oqRfw-1
Received: by mail-wm1-f72.google.com with SMTP id a18so1738203wmm.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kz5tISaCr8JW6TKiu/3hqmm/CJ/vinGNMO+FowNE3QU=;
 b=gqVSUq5YdsKrAE6JD0MaF2kCyebIc6J0ZsDamVoac4bc3W+Tlh0guNalA+YB6c/g/m
 t70kC6GaSbGOyoXOpTqbA9gIc3fc/UhHO1/n3df9m2aQnPOfyfV4g/OKvBPmAxM+RB/Z
 zSVj/xBTLKHYWjL0uvG80C905HBWx+c30huH2sBA/Ofei2bHfVpMS9OHliCdJikwJouO
 W3ZdJleONhJ16t8eSkt2VBIX+uqAo7QkiNvMMsw3uPxYoai7DmqETuI4bqYjzwWLV4HR
 q4YGnu7D37dCAl163ZCXMU8zQC4KCQfgj5j3hXM6cF0gWgPmblE1t3JZvEP2Z/LdVuTa
 Ca8w==
X-Gm-Message-State: AOAM532wGWrk9F33t7l/TQIJq1M5mBRwfIrJpDqSBS0eq8gXmNxGh7GF
 2z2RcD7qOm6XGlvxaRxev4upBfvtYXx1tfpZtW9fpO47w271EHlkRSbTOzpy3YhFlGnhsB2lJTe
 +pq55FKYd0Cbn234=
X-Received: by 2002:a1c:c357:: with SMTP id t84mr3278521wmf.155.1592483033111; 
 Thu, 18 Jun 2020 05:23:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFBafGrbmImPFjKFYpRyatrGE9MaAzGwwoOmvQBqJarhsoa6FhMUbhj25a2W6dz9ZmqsE/sg==
X-Received: by 2002:a1c:c357:: with SMTP id t84mr3278478wmf.155.1592483032769; 
 Thu, 18 Jun 2020 05:23:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb?
 ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
 by smtp.gmail.com with ESMTPSA id o10sm3380558wrj.37.2020.06.18.05.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 05:23:51 -0700 (PDT)
Subject: Re: [PATCH 0/7] misc: Reduce QEMUTimer pressure by using lower
 precision when possible
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200616075121.12837-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6170c76-27d3-c3b2-e32f-427fea769350@redhat.com>
Date: Thu, 18 Jun 2020 14:23:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200616075121.12837-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/06/20 09:51, Philippe Mathieu-Daudé wrote:
> This series contains few patches resulting from the notes I
> took while reviewing Mark ADB series last Sunday, in particular:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg712078.html
> 
> I have another patch for hw/input/hid.c but I prefer to hold it
> to test it more.

This is in principle a very good idea; however, util/qemu-timer.c does
not use the scale to coalesce low-precision timers with nearby
high-precision ones.

Paolo


