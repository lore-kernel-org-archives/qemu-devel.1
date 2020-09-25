Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16BCC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C853E235FD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ym4687Qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C853E235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLuGs-0007gt-RQ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 16:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLuG4-0007GO-VD
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLuG3-0003SM-Ca
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:23:56 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601065434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yOarH7YLKpdyhNbgWxwYJF8rdj0cXftvtpgA0IREE5c=;
 b=Ym4687QzEgC28uOKrO+HaeoQ7vHOTr5iCymFwsoCD6/Gh4DeyuyzpG7WkW/6wjMjISesy+
 YisCmL8q1fT2igaUUWIXSqtAPNYqv0T2QIKSC6DQ5h/Liyo2hEl2+wJx5szwHB87hxZ1Mb
 2r+4bcp8zO6mTgHAP4gQh4cowDASm1A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-kd2ePY32NfizirQQuhnaOA-1; Fri, 25 Sep 2020 16:23:52 -0400
X-MC-Unique: kd2ePY32NfizirQQuhnaOA-1
Received: by mail-wm1-f71.google.com with SMTP id x81so57447wmg.8
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 13:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yOarH7YLKpdyhNbgWxwYJF8rdj0cXftvtpgA0IREE5c=;
 b=X7ASb7HrIa+8WyGWrl8GwyFMEFY9r6SgcmvAv5/jJCrdMNoyX9TNInoqgIsyRFPPUS
 N4Mv5rSrYU37tAegzg7OS8nZpeLrC4s5vYwBN7nBQNymTyhc1eFx0hhODsbWb4r6QiS8
 DHGLCecM6wLmUaAWhNEzZVWn5tut/qC3/jqQBsX4IdVkLFhNCKuN26uRAAABzvT8vQSS
 AF7mb2IFMDHBsTNhgAw9bOvym3h8uaTMqyWHuvZtNGFL5J11KIQGUvNy3CAQ0nhDYeF2
 zVLOkSLH25VBNeFEI6r7z2F77fa+/qN5d6QFoiJ/eiw1etJrzbjbmR3PhO6yrD8ELMie
 Me8g==
X-Gm-Message-State: AOAM532wEl9rRQv6FvBqpaOoktFCbqQSbTAXs1uTNrPn1JpaTQTF2P0W
 tWLugdOrsydH2Ml6f6VSfzgZWDmPQDXYQmhE6dTcQlv2BpFxLXenm2F3W8STSVLdjJno+ei3FSl
 EzYHHrfdUEe9viFk=
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr6225492wrv.8.1601065431171;
 Fri, 25 Sep 2020 13:23:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzT0DDIXRK1DKabS23+aC3GCYeI9eK5CU0+4ENwn1kx9HEeaG5F/sa6Tx5UPbLO8wpf75mnwg==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr6225475wrv.8.1601065430978;
 Fri, 25 Sep 2020 13:23:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id m185sm192375wmf.5.2020.09.25.13.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 13:23:50 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
To: Eduardo Habkost <ehabkost@redhat.com>,
 "Strong, Beeman" <beeman.strong@intel.com>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <1582580312-19864-2-git-send-email-luwei.kang@intel.com>
 <20200925161539.GS3717385@habkost.net>
 <MW3PR11MB46655375CAECC74BA2D7CAECF2360@MW3PR11MB4665.namprd11.prod.outlook.com>
 <20200925165415.GT3717385@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <036ba624-670c-d6b7-721c-ad5c9d648c1f@redhat.com>
Date: Fri, 25 Sep 2020 22:23:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925165415.GT3717385@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "Kang, Luwei" <luwei.kang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/20 18:54, Eduardo Habkost wrote:
> On Fri, Sep 25, 2020 at 04:42:26PM +0000, Strong, Beeman wrote:
>> LIP=0 will differ from LIP=1 behavior only when CSbase is non-zero, which requires 32-bit code.  In that case a LIP=0 implementation will provide only the EIP offset from CSbase in IP packets (like TIP or FUP), while LIP=1 implementation will provide the full LIP (CSbase + EIP offset).
>>
> Thanks.  Is it possible to make KVM emulate LIP=0 behavior
> correctly on LIP=1 hosts, or vice versa?

No, it's not possible.  KVM doesn't have a say on what the processor
writes in the tracing packets.

Paolo


