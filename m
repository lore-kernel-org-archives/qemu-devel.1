Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87439C47420
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F39208FE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 07:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dof0L+QT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F39208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMni2-0000vC-Ls
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 03:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMnhS-0000VC-IE
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 03:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMnhQ-0007Hi-C4
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 03:35:53 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601278550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5FVO6WB4o3G6sA9GfTk9b6cbkeMgKVW5wuX96gGvwwg=;
 b=Dof0L+QTD7XPKn995+BpuGz7kF9DQLDSwX93S7X/c4BhMK2jP8MC/ixuvEJoxxx6one7vS
 l0sZsGcPubAGoCMZ0wzcJziDe06o8/fBZpyBTm89AwJyON+Zr5xEsZ2Q/399ozw9/HE+o6
 SXSiQ3nUdzZ6XgZ6oBYZCcqJE+Vo7Wc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-e89l8gCnPK-BEV9L18-qyQ-1; Mon, 28 Sep 2020 03:35:45 -0400
X-MC-Unique: e89l8gCnPK-BEV9L18-qyQ-1
Received: by mail-wr1-f72.google.com with SMTP id v5so37636wrs.17
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 00:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5FVO6WB4o3G6sA9GfTk9b6cbkeMgKVW5wuX96gGvwwg=;
 b=NrdPwOHnY5Rr88tSQVyGNX2vHrhgvTVZcf4m9WFGEyWjZcC8+QJBkc7460vYbvlm5i
 InYcqTQ3YHPaCR7JvcIikN9m2r8YKCKrQ31U9iCyqgLAPgVPExC6Wvwp7tn6u7x9CN/A
 XdkqsrAAWH5pggD26tAfXlLzLeGB+MGdj8Tdp535HuvkjgfANguXIwsiinjsmDrxVg/h
 O6Mk5QGrItlxU5toPg7x6Xa7AvSfS1kd+7MAIOIHeuWgfg0pzCv98OwN0ffm6ow/sOdq
 iewCk9F5um8PUpQK/YsD9R7JMuaZmYOTqw9gyWK8VcfeRwMboyFnfJtWMmrefhDQvhJ/
 YFgA==
X-Gm-Message-State: AOAM5325qu3m+LrfCtEmNjivs4PoQh5IIctRMNd9clfd9p63aW86IA76
 c125zi3JqdxfhkvLfjezjZmOCy8gBEeoLpObANBX2z7pgDxpoJIcTefJuWugv1QBJ9+Mhd9/mn+
 cEhBQDLY688YA5NY=
X-Received: by 2002:a1c:f608:: with SMTP id w8mr155056wmc.161.1601278543895;
 Mon, 28 Sep 2020 00:35:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQJFD+3AAhA2EGKGcHw+/FBnRq3g2oqVWni9G2/x37ZWOT4BiqZ8Z8nV3Onq4dwlKZAqdyCA==
X-Received: by 2002:a1c:f608:: with SMTP id w8mr155039wmc.161.1601278543692;
 Mon, 28 Sep 2020 00:35:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:18a0:e78d:6703:1066?
 ([2001:b07:6468:f312:18a0:e78d:6703:1066])
 by smtp.gmail.com with ESMTPSA id y68sm58393wmd.39.2020.09.28.00.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 00:35:43 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
To: "Kang, Luwei" <luwei.kang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <1582580312-19864-2-git-send-email-luwei.kang@intel.com>
 <20200925161539.GS3717385@habkost.net>
 <MW3PR11MB46655375CAECC74BA2D7CAECF2360@MW3PR11MB4665.namprd11.prod.outlook.com>
 <20200925165415.GT3717385@habkost.net>
 <036ba624-670c-d6b7-721c-ad5c9d648c1f@redhat.com>
 <20200925202956.GV3717385@habkost.net>
 <db31a0fa-c6cf-4730-6d64-f81228948d30@redhat.com>
 <CY4PR11MB1447C4CA6B6D455EE33F724D80350@CY4PR11MB1447.namprd11.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d85a3245-c774-5098-5d14-2e3b3a2eda18@redhat.com>
Date: Mon, 28 Sep 2020 09:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CY4PR11MB1447C4CA6B6D455EE33F724D80350@CY4PR11MB1447.namprd11.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.011, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Strong,
 Beeman" <beeman.strong@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/09/20 07:19, Kang, Luwei wrote:
>>>> No, it's not possible.  KVM doesn't have a say on what the processor
>>>> writes in the tracing packets.
>>> Can KVM refuse to enable packet generation if CSbase is not zero and
>>> CPUID.(EAX=14H,ECX=0)[bit 31] seen by guest is different from host?
>>
>> Yes, but the processor could change operating mode (and hence CSbase) while
>> tracing is active.  This is very unlikely, since it would require nonzero CS-base
>> and a 32-bit host, but in principle not impossible (could be a firmware call, for
>> example).
>>
>> The only solution is for KVM to accept both, and for QEMU to refuse a setting
>> that does not match the host.
>>
> 
> So I need to add a patch in KVM to disabled the Intel PT when the
> CSbase is not zero and the guest LIP different from the host. And this
> limitation in qemu (disabled the PT when LIP is enabled in the host) can
> be remove. Is that right?

No, if a feature cannot be emulated, that means it cannot be enabled
unless it matches the host.  That's generally not a problem since Intel
PT is usually used only with "-cpu host".

Paolo


