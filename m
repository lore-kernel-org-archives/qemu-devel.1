Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB70C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8874520870
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YN24gkxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8874520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZz1r-0003gY-J2
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZz1H-0003Fr-5y
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:18:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZz1D-0000ph-OC
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604420326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4oj0fqJURxknPISmumjXRW5QtFQPu4X/xaDIf6ufZWY=;
 b=YN24gkxIu7TEEV6XiUVAOf6AwRBBs5S+gFnvfBos1dS2c0rPTVZmBP4FXuFLKOzCbtkYN4
 hgmU0wCcwfOPd3rEdCFI3GFWPCApypG9UNN0SwT1xxe47RMlrGDAmbjbZmHnqGrp5vudUp
 keRVALlvYzEJmxNUHxaj8dGqe1IbFwE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-8_i_eKAiNIeXZH_EmHYG_A-1; Tue, 03 Nov 2020 11:18:44 -0500
X-MC-Unique: 8_i_eKAiNIeXZH_EmHYG_A-1
Received: by mail-wm1-f70.google.com with SMTP id e15so2801306wme.4
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 08:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4oj0fqJURxknPISmumjXRW5QtFQPu4X/xaDIf6ufZWY=;
 b=o43oI9lQspNgmerx9w6apowFunDyMRInItv4TIOkBZ4ko247vbD12ssCpkMotZ5nz+
 CjYxQSPAOfoG7H22rF7yvclbgP4CZejz5mt+5Rm034/CTUHmuDKTokWPnyv51yDDTq+U
 4T6q9xxOs1dMp0MGuhsw1a/wTwbYHTDCe3m4WdGcLN5gO2m7lMlvsa9usSjpvYfUpZNO
 1trCm6YkwcR6zkYZD7Qse6bGGzpXqJC8xRcBtDosMUK5/S/3H+/sJVn+G1VmN65DwafE
 2LDm87dLwvnrPIn/B/mkPpfpdFddcEecBKyVLrYQpVIe1p4WMozDkdLEV5b3XyINgZ1J
 Xk5Q==
X-Gm-Message-State: AOAM533FXvzP5qOMKZHWgVdvCwkVijt8hoCzn+u8heAVga4KQ1P8UNKB
 nex1nBs9fIngdIPTvmzmYhn5hel/Slhgs8m2s63gTQ+0CPdh8qTCiRR8g0v8csWmaXaGI/nAdRc
 BQhfwKn/R4gU/9wA=
X-Received: by 2002:a5d:4c4b:: with SMTP id n11mr26579047wrt.171.1604420323488; 
 Tue, 03 Nov 2020 08:18:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzljX3gdyrsmAletQnwyfZyV4URYPXiqhY/HBvPAk4NQBi+NP/yhYYQNYh06acaBXMS2MCKXQ==
X-Received: by 2002:a5d:4c4b:: with SMTP id n11mr26579036wrt.171.1604420323304; 
 Tue, 03 Nov 2020 08:18:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id w4sm12929376wrk.28.2020.11.03.08.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 08:18:42 -0800 (PST)
Subject: Re: [PATCH for-5.2 4/4] qemu-option: warn for short-form boolean
 options
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201103151452.416784-1-pbonzini@redhat.com>
 <20201103151452.416784-5-pbonzini@redhat.com>
 <20201103160843.GP205187@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff8ddc26-5d3d-8f0e-47ce-0c721fbef7f1@redhat.com>
Date: Tue, 3 Nov 2020 17:18:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103160843.GP205187@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/20 17:08, Daniel P. Berrangé wrote:
>> +Short-form boolean options (since 5.2)
>> +''''''''''''''''''''''''''''''''''''''
>> +
>> +Boolean options such as ``share=on``/``share=off`` can be written
>> +in short form as ``share`` and ``noshare``.  This is deprecated
>> +for all command-line options except ``-chardev` and ``-spice``, for
>> +which the short form was in wide use.
> 
> So IIUC, the short form was possible to use for absolutely /any/
> boolean property ?

s/boolean// (yikes)

> IMHO if we're going to deprecate short forms, we should do it
> universally including chardev and spice. Arguably spice/chardev
> are the most important ones to give an explicit warning about
> precisely because their widespread usage means a heads up is
> important to users.

Chardevs will probably become user-creatable objects; for -spice I was
hoping that it would be QAPIfied as "-display spice" which does not
support short forms, but I'm not sure if Gerd agrees.  In both cases,
the problem would be taken care of in a different way.

I can certainly warn for all of them, but I was thinking of the
lowest-impact option for 5.2 since we're already in soft freeze.

Paolo


