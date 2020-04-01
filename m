Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022BCC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96992071A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXfiCPMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96992071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJXSs-0006jJ-Tw
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 03:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1jJXRk-0005kv-Ct
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1jJXRi-0006Wp-OA
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:05:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39370
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1jJXRi-0006Rm-IH
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585724753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuTdQ6ViLygjwk5ZnNboOwY5qYRKAwjv3T1Clik5+8o=;
 b=cXfiCPMzAfvk/SsIKWQIrCtSZ89MGYEs5qpMakYMGTe8cj2CbGtTLrem1hqsLVTGkUWR78
 kwGRtHTIVlue0xV0vazHomSWOVG7MH4goqQeqobTH+RhcoO2aW0d5zPjI3lUdDRwxt6wVU
 3S4BLWZt4ogoiHLe6zLdgumXd1oB4G0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-q4CJsciKP8uEsqr7l2s9YA-1; Wed, 01 Apr 2020 03:05:51 -0400
X-MC-Unique: q4CJsciKP8uEsqr7l2s9YA-1
Received: by mail-wr1-f70.google.com with SMTP id i18so14051002wrx.17
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 00:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=3h41m3u5XxDdvdrbgv97wONhK5UEvay+f5Fg7/zCE0w=;
 b=gmD7DMqOtvrHcRTcJjf7DZYIcALcfEt812ZpOtQWG6MWHtHZx7qfgEnEQ7TMcbSatY
 m2GGFKPg4qBM+Yg9S+lP06F7S73P79fm5zcuvv56grqLkx+Dv5WBswTJOznvaJUAjNYd
 KHMtAfQdx2oK1eo+2WQgxaZJU3OTyprMwDleySn/a86A77AR9Ercl41OfY8bTts6oy+F
 8X4eiA4u1rQlkYyt94flEH0LhFYQS8+Jo4fSbmC937tOILaJir4qyCghY/7vgr2MSVya
 ElKf1gBB8ydCnSwdQ4Jcq2eFPrdRmaLu0zY58RhDvL5RxcdbR+JyWiCYN57QMj1Z4Rav
 qXyg==
X-Gm-Message-State: ANhLgQ02C4n0E+YhcgV886E2o/Gp5gR72T8DXn1so+XWqK2/Bl+5Xe/h
 bQiqOyaE8Rf93T2cW2Yeolku4svl+Jq/hHMYSbGMUap2BTB2Zb2brW5MgAm58SvWWym6/OHEDSA
 JnL7LwwBPNEeQ+Nw=
X-Received: by 2002:adf:e98a:: with SMTP id h10mr24921554wrm.370.1585724749412; 
 Wed, 01 Apr 2020 00:05:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs+2TR/BVO9F0jBmH+iPEPXRAARE0KFZW+5pA1IEpxpoDzCxszAj/ZKD3egY7REhRnTM6PEnw==
X-Received: by 2002:adf:e98a:: with SMTP id h10mr24921530wrm.370.1585724749226; 
 Wed, 01 Apr 2020 00:05:49 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id r20sm114426wmh.46.2020.04.01.00.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 00:05:48 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: "Montes\, Julio" <julio.montes@intel.com>
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary
 execution controls
In-Reply-To: <BY5PR11MB396059E9E1FFE4B93EDE38E89AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
References: <20200331162752.1209928-1-vkuznets@redhat.com>
 <f976c1b0-2f50-d9f6-0921-2fc8e25ddb80@redhat.com>
 <BY5PR11MB396059E9E1FFE4B93EDE38E89AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
Date: Wed, 01 Apr 2020 09:05:47 +0200
Message-ID: <877dyz1y9g.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Montes, Julio" <julio.montes@intel.com> writes:

> Hi Vitaly
>
> thanks for raising this, unfortunately this patch didn't work for me, I s=
till get the same error:
>
>

Does you kernel have 95c5c7c77c ("KVM: nVMX: list VMX MSRs in
KVM_GET_MSR_INDEX_LIST")?

--=20
Vitaly


