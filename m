Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28520C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F1820719
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAxtoTpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F1820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJeUg-0003gS-0y
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 10:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1jJeTd-0002gM-19
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1jJeTb-0003DM-HM
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:36:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25232
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1jJeTb-0003Br-D4
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585751778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0HhxWxLh02fJVJp4LVVG+4+DEa30nEIdCgKV6IPzrU=;
 b=JAxtoTpMhlFYwnnVHFouTVNAEcVGM1asoxCq+Au2vTxxFXa593jIdqdG2vualt/t0uwQ8B
 aPU1YNvx71kkpSP5Wr5kR/jJtlZ8pBMdv/YsXmtAZTC5J6RknsprT+3qf8juRKaPmNUvX7
 NOxwfuIveKDv+SurP0G1BqH9Y+XnWhk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-KPVYIdxfNumU-biex7XZkg-1; Wed, 01 Apr 2020 10:36:11 -0400
X-MC-Unique: KPVYIdxfNumU-biex7XZkg-1
Received: by mail-wr1-f71.google.com with SMTP id j12so14589618wrr.18
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 07:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=wMTuqB3xp3q/wCkNzofppZx/HxXObvR69NvhYurCQfY=;
 b=DuRaNwXsE/9Be1YgUudJLVncilJDJgO5Zgq+fE15JdZMfIOzwqpanIl+SsNqmGMLgd
 puB7NVE2FHjrelvhud87TUsFvDM7SjnNzEQJW460Fl9gv5s1LmzFUUm7KcVzZwNfr9zB
 7j8cMaUoiQsvEYfnijVXNMO+GCog+9mQygsEa/gyXpvFieE9MQ8+GC0YR1pEbEyifqNA
 VS8HQYr6LmuXpRs+fEqwj2rchtbUWYF7xG4q+44pk9mcqmEHXRy5Qpb96icrkaEi6S0Z
 ZLjnfYqLxrreKjCnJdyMnkxzLX9MsqcK79Rbm3l1KUyDwal0PzemCv05XG+CCAPQNE1x
 HqiA==
X-Gm-Message-State: AGi0PubKb/eZwabD6e3hL4v3WT7CQzPBbpsN6wRu70jCQ7FKuTwECJl9
 pPU3dNyLtnPqs7XVAR9yzLMW3x4Zr62tjIqL6d8obdh9Yu5Anp6MsLAq9KdR5Z2M0db6jAdNssF
 QaOFFPbMC6U6QDvs=
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr4613837wmj.87.1585751770371;
 Wed, 01 Apr 2020 07:36:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypJS/T45sQ2Q53UVsuueuE9FJSqTpQeaeapqHanxS44jbYGeaJBEhHnMVlbDe79sq9trPyh/8w==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr4613813wmj.87.1585751770099;
 Wed, 01 Apr 2020 07:36:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id f13sm3047379wrx.56.2020.04.01.07.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 07:36:09 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: "Montes\, Julio" <julio.montes@intel.com>
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary
 execution controls
In-Reply-To: <BY5PR11MB39607C77082407729CFEBA399AC90@BY5PR11MB3960.namprd11.prod.outlook.com>
References: <20200331162752.1209928-1-vkuznets@redhat.com>
 <f976c1b0-2f50-d9f6-0921-2fc8e25ddb80@redhat.com>
 <BY5PR11MB396059E9E1FFE4B93EDE38E89AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
 <877dyz1y9g.fsf@vitty.brq.redhat.com>
 <BY5PR11MB39607C77082407729CFEBA399AC90@BY5PR11MB3960.namprd11.prod.outlook.com>
Date: Wed, 01 Apr 2020 16:36:07 +0200
Message-ID: <87wo6zz31k.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

>> Does you kernel have 95c5c7c77c ("KVM: nVMX: list VMX MSRs in
>> KVM_GET_MSR_INDEX_LIST")?
>
> I was using linux 5.0.0, now I have 5.3.0 and it's working, thanks for fi=
xing this
>

Thanks for the confirmation!

I don't see any good solution for kernels without 95c5c7c77c, we'll have
either one issue or another.

--=20
Vitaly


