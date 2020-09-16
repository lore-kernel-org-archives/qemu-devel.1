Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1CFC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B69F22246
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KimvRwE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B69F22246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXIV-0000cG-IV
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIXHR-000058-2q
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIXHP-0003Nb-Dp
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600262122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Ie3Y2N0X/CPUx2cbAr5xjtUAzdGz/98YvN2sjKALPY=;
 b=KimvRwE9icF/NxnSWp9CHY202P55EbMdZI/ykSeO1MILo+WqE3nuiAzQhE9XhOcRcYdEQ/
 XrTYU9VutqF4QE031rNLjcNf2sFOj5heZxLCpMdbpHBBPc+jhu/lrMMVkKtOCppa/Ejd4A
 4SL4r7wScFVkF0Anax+qz3rCPzeIenI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-rHjTMhFOMFi89pKHa4OBiA-1; Wed, 16 Sep 2020 09:15:19 -0400
X-MC-Unique: rHjTMhFOMFi89pKHa4OBiA-1
Received: by mail-wr1-f72.google.com with SMTP id v12so2540047wrm.9
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 06:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6Ie3Y2N0X/CPUx2cbAr5xjtUAzdGz/98YvN2sjKALPY=;
 b=Ua3BBqoKS/g93LCpiXibjWIzngqWOsA4+ihk1vh04Le0P5Xt1QSw6xrNAmWMSTqhbj
 YsF9UamldCou2xPKdb3HJnlwM374mSkrj7160hxJGDfmRVySm1Vs0W/dQl9mogoGe6dT
 /xgS+sxr/H9bBPN21wjBd7D0EGzs4vTEmbCx26SlNapMZat5fKc7PyOwcl9lRIQ1tSdF
 AHMrnsJQK6SuQqB198okernxxhiw8Qytcg6zozsWZFJRHqmSV//f3ssoCHjoiHpJidss
 6pqvO+JEmNlz7F5RFh7bS8MiBgQjozOzifPSB/fvdqO3LcoxTLit8JD4bpfWpXKHnd9O
 CAew==
X-Gm-Message-State: AOAM532LAz4FEbPIejS7+IOCTTMgfX52AYy6SCY/Hg+zk9HWgDg0klIx
 fdrflXY/CLCI5EbZLSFVNlfEOfhvEoQZgVTKvEL0murvXVUpJnwa6eKkAcqXk7vNmZc+tDkm09D
 5jbK3T5src5/srQk=
X-Received: by 2002:adf:dd49:: with SMTP id u9mr3773482wrm.392.1600262118134; 
 Wed, 16 Sep 2020 06:15:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgDMx+GGOv+PjHdFaVQ23Fm2dzNH8/Ir4TGAYSF6DRqQuTmoh22tYDzBFOovXWxSUZGCqZtA==
X-Received: by 2002:adf:dd49:: with SMTP id u9mr3773457wrm.392.1600262117935; 
 Wed, 16 Sep 2020 06:15:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cf8e:a9a0:1aed:9a37?
 ([2001:b07:6468:f312:cf8e:a9a0:1aed:9a37])
 by smtp.gmail.com with ESMTPSA id a13sm5364735wme.26.2020.09.16.06.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 06:15:17 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] Automatically convert configure options to meson
 build options
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200913100534.22084-1-pbonzini@redhat.com>
 <20200914095753.GB579094@stefanha-x1.localdomain>
 <e661b2cf-0721-441c-3ce6-573b3eb7950a@redhat.com>
 <20200916112538.GC756728@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c13e672-a296-4e72-86c2-dac2e3d35e24@redhat.com>
Date: Wed, 16 Sep 2020 15:15:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916112538.GC756728@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/09/20 13:25, Stefan Hajnoczi wrote:
>> No, only developers need jq and only if they add configure options.
>> Using Python would certainly be possible, though probably it wouldn't be
>> a one-liner as for jq.
> I see. Avoiding the dependency would be nice but only if the alternative
> is reasonable.

I guess this counts as reasonable:
 
python3 -c 'import json, sys; print(
  json.dumps(sorted([x for x in json.loads(sys.stdin.read()) 
                    if x["section"] == "user"], key=lambda x: x["name"]),
             indent=2))'

Paolo


