Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332CCC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0177B20829
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Td9ShYMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0177B20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uWN-0007hU-AY
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0uVm-0007Ce-CP
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 18:25:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50675
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0uVj-0002xX-BJ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 18:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596061517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60KhQWmXte+9CZmsBx/mjk5jlF14YLvXKXjWYwlycT8=;
 b=Td9ShYMhLr4yelm1NnaTipXDCzmruTVG68/CTqkTYBED/lcMnMDCluBQxCSpjGAaDjV+jv
 6LH+4zfilWyJTPTL8kSBXkzye+gEHFWRiWBHGK83yoHCLZwy1QrpvTCv1PdZjycArtkLs3
 XIvBCiGp6mvzG5mJjySagfI5fhcwdBQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-tpdC-FolPlyM_XMELYaSLA-1; Wed, 29 Jul 2020 18:25:13 -0400
X-MC-Unique: tpdC-FolPlyM_XMELYaSLA-1
Received: by mail-wr1-f71.google.com with SMTP id z12so7144695wrl.16
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 15:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=60KhQWmXte+9CZmsBx/mjk5jlF14YLvXKXjWYwlycT8=;
 b=CDEHcfYGCGb9686DgkQdalrZV9RuIdsh7fLBP5ICgjC2RRVbo4pQQU21Frk4EwOzn3
 mLlcHf+K0TzAggYoPKJcttOXOpQOkn4vJW1i0rnc9tufQXK6dYBBupiDw/SeRwdeCznr
 3bvIn0tDqFqShmli9VTzYU4knFHRsvM55dZzDzeJBFEjj86YrEntNmwiG3SxmHA6ZmUC
 Hmtf7bApH6dHzAniDzD2kToBqN3mUTLV6Ci0IY2IWM0H2lLc/ouiGNogevIokMx+tbHr
 n8lvqRBTnmk7lbTvoFmkCFq9ctW5RRGv+hoxuZ5sv9597vxGwmwiXjHyU2puA3nQSQDg
 yBNg==
X-Gm-Message-State: AOAM5313lJ3Tht05Lj2+1Ij0RMGLSoSDya8Kzj+T8wNi7KRo6sJ5Ya2z
 TDMgdQvlzg/17vxt2FlXHIkGATERuuUT/EAQI1APWX++a1xlpcU3LBDlC/mNbOeYRPFk9sg8iKE
 D4soX73+sjRb/ZQY=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr31969046wrn.415.1596061511878; 
 Wed, 29 Jul 2020 15:25:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsnMRbKbhOeAn/JaCSf5B5JOgmSW+NzcPf16urbqjyT4r9CPn9kyUNnu9oGDluBj8PxFHFbw==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr31969030wrn.415.1596061511667; 
 Wed, 29 Jul 2020 15:25:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:101f:6e7:e073:454c?
 ([2001:b07:6468:f312:101f:6e7:e073:454c])
 by smtp.gmail.com with ESMTPSA id p6sm6356990wru.33.2020.07.29.15.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 15:25:10 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 v4] hw/core/qdev: Increase qdev_realize() kindness
To: Markus Armbruster <armbru@redhat.com>
References: <20200727175112.6820-1-f4bug@amsat.org>
 <87d04gf5i4.fsf@dusky.pond.sub.org>
 <b5cd0d50-c0a6-afee-5b63-80bb83e7e001@redhat.com>
 <87r1suahxu.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c086f053-b4db-532d-2c8e-b29ec5e3e708@redhat.com>
Date: Thu, 30 Jul 2020 00:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87r1suahxu.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/20 09:39, Markus Armbruster wrote:
> Taking a step back, I disagree with the notion that assertions should be
> avoided just because we have an Error **.  A programming error doesn't
> become less wrong, and continuing when the program is in disorder
> doesn't become any safer when you add an Error ** parameter to a
> function.

I don't think it is actually unsafe to continue after passing a bus-less
device with a bus_type to qdev_realize.  It will fail, but orderly.

So even though it's a programming error, it should not be a big deal to
avoid the assertion here: either the caller will pass &error_abort, or
it will print a nice error message and let the user go on with their
business.

I'm not particularly attached to the change, but it seemed inconsistent
to use error_setg(&error_abort).

Paolo


