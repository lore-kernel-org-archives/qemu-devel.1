Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04AFC4742F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214BD21924
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRLvZRr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214BD21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwJc-0006EA-84
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 12:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMwIW-0005J1-Ta
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMwIR-0002DE-Di
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:46:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601311598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izvfoLGOdR8USH8NeKtmMHY+Y0GF6ldFMPfVRE/xLHY=;
 b=ZRLvZRr1eMZThMQYeAuGIRvuwZyxoKVwpLKdkyGdlxsard30mziE0kXFEWMeHxAeOT72fv
 /5zahGaYXgYUkvkkqU4JQzXKtCQoFnjhIgrm5F9tl234yHxIZy+9o0QaEtCAtLALeNYxpY
 CaRRj1oPJygr3uTjHFm5FwjGrvuuISM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-uxNdH8VEOa6rMPSpJ6YcLw-1; Mon, 28 Sep 2020 12:46:36 -0400
X-MC-Unique: uxNdH8VEOa6rMPSpJ6YcLw-1
Received: by mail-wm1-f72.google.com with SMTP id r83so177726wma.8
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 09:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=izvfoLGOdR8USH8NeKtmMHY+Y0GF6ldFMPfVRE/xLHY=;
 b=HY1kcEz7zPUUtiuJFkQLsBCxEJTUJnwiyU9VWkBbRfPBcoW12X4uE0CrgkW+v2K7jo
 GnljaqoId33AIVqmB3XEAkEoQJgrAL3WqhDuupPWrJyg1qRgqkYXyN8mrJaV4JTVlz0W
 /Me/AKyH1sQlccjSncaLNAOAqnW6YnhQGykLTYdr8uGJc4V0eJbGofdN+mwQ8Unap8eh
 lfYIsDfLdtyp5ywfMN9/k3p3iHjSWH0o2obtMQkzDzsjnzsnuSLgWU93e7Yf28eY0U3A
 vbKUenWMcwKyemO58S7HyZoAvCWWfmLQOKMHqVfmIkHFHWpqUWEBDHl8u+nABX7Ue2i/
 VlrQ==
X-Gm-Message-State: AOAM532Y5S/xinltkiWrm/N+15coy6Cb55fETTtm/ROTymPl/ZK/0AW8
 SpLsm//rH+kPKhNtAMzhY9jwCR3/6hOTNpksPedd+qKqz0P3btimwjNEz8k7Gp+OFBUx6h5y7Dg
 hOR0iWTQNMyHPMIA=
X-Received: by 2002:a05:600c:20c8:: with SMTP id
 y8mr101073wmm.108.1601311595130; 
 Mon, 28 Sep 2020 09:46:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJ0vXQsPGLmNdXnHE0ZU2i8skQOxN+zDJvpeCBkImrrlDDi7VLJCRelPYe+Da1T8qKLOwTjQ==
X-Received: by 2002:a05:600c:20c8:: with SMTP id
 y8mr101050wmm.108.1601311594911; 
 Mon, 28 Sep 2020 09:46:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4f8:dc3e:26e3:38c7?
 ([2001:b07:6468:f312:f4f8:dc3e:26e3:38c7])
 by smtp.gmail.com with ESMTPSA id h8sm1925511wrw.68.2020.09.28.09.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 09:46:32 -0700 (PDT)
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
 <d85a3245-c774-5098-5d14-2e3b3a2eda18@redhat.com>
 <CY4PR11MB1447BB55E8AF4915CD56655980350@CY4PR11MB1447.namprd11.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <761a025d-6973-e4ab-df6b-c25a171d1298@redhat.com>
Date: Mon, 28 Sep 2020 18:46:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CY4PR11MB1447BB55E8AF4915CD56655980350@CY4PR11MB1447.namprd11.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Strong,
 Beeman" <beeman.strong@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/09/20 14:42, Kang, Luwei wrote:
>> No, if a feature cannot be emulated, that means it cannot be
>> enabled unless it matches the host.  That's generally not a problem
>> since Intel PT is usually used only with "-cpu host".
>> 
> The limitation of LIP in qemu will mask off the Intel PT in KVM guest
> even with "-cpu host". e.g. This bit will be set in SnowRidge HW and
> later.

I agree that QEMU would have to learn about LIP.  Unlike this patch,
however, x86_cpu_filter_features would have to fail if host LIP != guest
LIP.  That is, something like

           (ecx_0 & INTEL_PT_IP_LIP)) !=
		(env->features[INTEL_PT_ECX_0] & INTEL_PT_IP_LIP)

where "intel-pt-lip" would be a feature in env->features[INTEL_PT_ECX_0].

> How about "-cpu cpu_model, +intel-pt" use case? The current value of
> Intel PT CPUID is a constant. Can we make the ICX CPUID as basic
> inforation(LIP is 0) and using "+intel-pt-lip" to make Intel PT work
> on the CPU which LIP is 1 on the host? As you mentioned before, Intel
> PT cannot be enabled in guest unless it matches the host.

Yes, this would work.

Paolo


