Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5328C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D88F208B3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgXpiT0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D88F208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDUw7-0005dg-QA
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 11:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDUv7-0004zi-ST
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDUv5-0004Vu-OM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599061410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2L6L0qFjWkPIVsxz6ldRrSbsxoL1mUZcWnz5ZRb8SY=;
 b=KgXpiT0Z2ZdiwM5NMYr8O1Kf6O0z5YbN9CNPtYNDiTltoOAu9EPhE78KeBeObNJiFe8jGJ
 Yo07h9/joKXcP/Q2XAdqYmBeoumCz4BxGbC5eHIaLtnmpqUY9KRFejWxPkaEKv2BY1NUIa
 XrVk7elTJMdVHiNqYj/D9UTykOdM06M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-mhR5pyTKOAekhRdTkXMwMg-1; Wed, 02 Sep 2020 11:43:28 -0400
X-MC-Unique: mhR5pyTKOAekhRdTkXMwMg-1
Received: by mail-wr1-f72.google.com with SMTP id n15so2204010wrv.23
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 08:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h2L6L0qFjWkPIVsxz6ldRrSbsxoL1mUZcWnz5ZRb8SY=;
 b=TmSZpf+j6+bOlBNP496jGinPMpv6scPxtPepBfZaT94dMi0zaCQ9yMPcNsn24Bdjio
 DBFARjXhd04UhrBByQ6YJ3k+tS3JSD/2MNxRO0GkJZNjRmOl9r7labVh6F6I61arrPkO
 LFd2UT8P8Hi0kKZMOVKIapuwNnenVYmJuSb1+6ObFQI4IWXy8ss81hUpwzHCT1nrQ526
 luKYh5Ag+vAYEvN+mAKSijIDEIrVKu5p9hoEryj+KOgHCE4FckfN4Eq18eDreMSJ0qnB
 QsK9MnSTS94n+KOTjha7SAH3rQ6RzdLar7c+1Aozpulp1dO6RGN+B54cbVdbiy0DXyMk
 nRsA==
X-Gm-Message-State: AOAM5304KXGPuKOJEQFC8MKUnHoPnDIZINeUJKxflnMlJVAPnKxBWNNX
 wfgCfiFCHT4yZcTWOUWiKlfnvICvrIgpjLmZwrDwGdiC1xGXx1ax3M96XdPB/R5jupJBJ2DSqEo
 nN8n6brouIG1TBZk=
X-Received: by 2002:a5d:5404:: with SMTP id g4mr7375933wrv.134.1599061407150; 
 Wed, 02 Sep 2020 08:43:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVN9GPlYYcjNzFBjD3OESodGLYNEGy5lmiw5I3n9mONWIWunAIV2C9pWNPnaboIjCkXwg6ag==
X-Received: by 2002:a5d:5404:: with SMTP id g4mr7375915wrv.134.1599061406962; 
 Wed, 02 Sep 2020 08:43:26 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id a83sm42007wmh.48.2020.09.02.08.43.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 08:43:26 -0700 (PDT)
Subject: Re: Cirrus CI for msys2 are working now, but still buiding failed
To: luoyonggang@gmail.com
References: <CAE2XoE_SkH-2dNULFAZNiRNRNP=OncwCy=xrDk0J3bzS1Th=tg@mail.gmail.com>
 <c61f6420-ffdb-b2b1-44ec-60b8a55f9c8a@redhat.com>
 <ac9ee76a-bc7f-0715-4324-d33c2fb2bb66@redhat.com>
 <CAE2XoE-uu35tMOu=OHjhOnv5jHxegv+3vdKaU2Ue16=6E1Wt9w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d59a63c4-8080-85a5-d171-df082f5c11b7@redhat.com>
Date: Wed, 2 Sep 2020 17:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE-uu35tMOu=OHjhOnv5jHxegv+3vdKaU2Ue16=6E1Wt9w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 17:06, 罗勇刚(Yonggang Luo) wrote:
> I've already making CI green match the cross version, and the fix is not
> just about -L, but also need to move the git submodule update to the end
> of the file

Ok, please send the separate patch for the git submodule update.

Paolo


