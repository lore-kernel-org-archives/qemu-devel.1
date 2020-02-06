Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5863C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A046420730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ns68lEfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A046420730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izqm3-0004sa-JU
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 18:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1izqlF-0003pX-Pq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 18:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1izqlD-0003xD-H7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 18:40:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33557
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1izqlD-0003v9-7m
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 18:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581032438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kua5MEqIBm2BcOv/LKzMLJkD6YXmMtVULwwNLe9eD+Q=;
 b=Ns68lEfTaPUiX+230YHppNSCPmz3W9wtftd9ol2IEWyDa3HGmmnimKiQe620fpZiq6e2+H
 RBndoJAyLWd2VxQ7IUGOt2DlfGvtjKSk+hQrGia47J+7HPFmZaEfXUGFxweRuVYGZzFyIX
 4DWXOxrUi+/0O2a+S+i5Ku660yTd8jQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-8S01zQoeNymGRQ0bLiJpbQ-1; Thu, 06 Feb 2020 18:40:36 -0500
Received: by mail-wr1-f72.google.com with SMTP id c6so263458wrm.18
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 15:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kua5MEqIBm2BcOv/LKzMLJkD6YXmMtVULwwNLe9eD+Q=;
 b=lQWundRXUpMSe1z9S/ouBXUPCVz4GHiHoWlXDhxgu7jXwAopFwa/GX0/kQ/ZN7YA5t
 J9RDp3rSY0jBxnff4qvgGZ4A5+neC6MQrgK4f309wyEvuo8LfXPJEEyLvUrZUndslHKG
 K9FpmuOZFoAFP8TUiK3YW+L8N5OMB69BYvp65YLoC+b1OpOqhaFApqwPpGlI3eaBY8J/
 Z0IZT7OQAxpZ503T0NfACvH3KCnjOIsxexNgtaGDvbHFlJgciTMHqV38nEys8c83tKhH
 57mIRNEd1JMhxt3922DJ8WatpaEWQyk/LsJz40wvkhs2Z/Xl0dnTXUZDUeoQ2VBMPURZ
 D4Aw==
X-Gm-Message-State: APjAAAXN7dXZidYAsfl6OUp488AkD29NA21dl+lhWehUUosOAwTSKtZI
 N83RQ6GECnW50qTXofIY7HWbJBkYr/9EFi/NrfvP70WhZdy3sRpDHhEVWtIq8RdfV5uo3XuF/vt
 eRsX2Z7D5U9+aVFU=
X-Received: by 2002:a5d:4447:: with SMTP id x7mr429171wrr.393.1581032435272;
 Thu, 06 Feb 2020 15:40:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqycnCujtqE2b5EtyWd8eVtyhkaM6S8WSmmIYXK1Ze3c/VQwIE3AujvzEmcAIVYTqBZF38AwNA==
X-Received: by 2002:a5d:4447:: with SMTP id x7mr429146wrr.393.1581032434979;
 Thu, 06 Feb 2020 15:40:34 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56?
 ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
 by smtp.gmail.com with ESMTPSA id f8sm1046957wru.12.2020.02.06.15.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 15:40:34 -0800 (PST)
Subject: Re: [PULL 20/59] target/i386: kvm: initialize microcode revision from
 KVM
To: Alex Williamson <alex.williamson@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
 <1579787449-27599-21-git-send-email-pbonzini@redhat.com>
 <20200206162412.11d5b9c6@w520.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f2e74bc5-b3ce-c917-d0d3-bd9a8a194c36@redhat.com>
Date: Fri, 7 Feb 2020 00:40:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200206162412.11d5b9c6@w520.home>
Content-Language: en-US
X-MC-Unique: 8S01zQoeNymGRQ0bLiJpbQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/02/20 00:24, Alex Williamson wrote:
> Hey Paolo,
> 
> My Windows 10 VM boot loops with this :-\  It seems to be related to
> the CPU model.  Now fails (host-passthrough):
> 
> -cpu host,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff,hv-vendor-id=KeenlyKVM,kvm=off

Can you try adding ucode-rev=0x100000000 just to double check that it's
the microcode version?  Also perhaps doing "rdmsr 0x8b" and if you have
anything set in bits 0-31 clearing them.

Thanks,

Paolo


