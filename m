Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA46C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 06:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E4520771
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 06:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJWWxZcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E4520771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrxyI-00041R-Vk
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 02:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrxxN-0003UY-HV
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 02:16:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrxxK-0005Ed-Ta
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 02:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593929809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VADVZ6Ej0tDqIflCyu2IGJa04QpD6Nw95M1AmRUqy0=;
 b=MJWWxZcuBW+PxMrkNQlBDwaV7LYixMtFFwp+xmws5TbbieiK0GMkPT2qnSBjrvaGJfYhyr
 7mOAyVio7XK06+5aryHJot9j3In9vQUN9lCIWTqGnki47akAAW+1RJFcwrsxg9oUAORu20
 Cfij8sdK4jBEpMEopT2o0GpwRu/bJLw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-I3Cc4peAO0OqzkynFyFWHQ-1; Sun, 05 Jul 2020 02:16:46 -0400
X-MC-Unique: I3Cc4peAO0OqzkynFyFWHQ-1
Received: by mail-wr1-f70.google.com with SMTP id z1so7909739wrn.18
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 23:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3VADVZ6Ej0tDqIflCyu2IGJa04QpD6Nw95M1AmRUqy0=;
 b=QjFbR2S0S01ZrrgP8QS4+DZaqQBaI2fzGn2auARQ+kPzbL+YMXsMs0mGmcXRSgzYzX
 bT6TgWYoEjeInmrjmA4gVpKGvuyeM0/4RuGuTV3/gG7Y9Q7t7IMQqHjSww49nGp4YtMK
 eK2QDrQKmmX8YKOOE3/74YFe8ANIqDRdOOx43jJ6IIL98J+qeBAxT9whi7RovKpWZ/r7
 llurtePHPs7RFBqR4WE+uOftUljdw7A2UZifjFHyONsb3VYzjbviTBbUHR4xRI0hdH7S
 UYQD2a6yMcV0wtWI0EKrqm1Bhq6tOVQyeTRTKVWTorYVvGct4wEthODus/c6UuJa0ajK
 cSIA==
X-Gm-Message-State: AOAM531lQ/bYySfUp7pR8WVJKxx4uCJYJ+/OMRlU9kSJAEV/ITyT3+2V
 Xx2FC3WBrz+keFk4Cst4dIB2mucla5LjfHDYpzRklZxmG4/hp/PUqPOaoRLDSeRGb/AmuQFqSvM
 LVJJFoCUqv37tMeg=
X-Received: by 2002:adf:80e6:: with SMTP id 93mr42026026wrl.17.1593929805391; 
 Sat, 04 Jul 2020 23:16:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6bzwIY05j8xBSW3ojgumYkCmyZgKwMx4W7zE3X9NPf1kOCVtE21TGfIM3nG2WCzL7CpksAw==
X-Received: by 2002:adf:80e6:: with SMTP id 93mr42025995wrl.17.1593929805116; 
 Sat, 04 Jul 2020 23:16:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:adf2:29a0:7689:d40c?
 ([2001:b07:6468:f312:adf2:29a0:7689:d40c])
 by smtp.gmail.com with ESMTPSA id w7sm19014289wmc.32.2020.07.04.23.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 23:16:44 -0700 (PDT)
Subject: Re: [PATCH 0/7] accel/kvm: Simplify few functions that can use global
 kvm_state
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200623105052.1700-1-philmd@redhat.com>
 <a36faa0a-6aa9-463d-03a0-b862141a427d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad581a87-03dd-17d3-6ad2-cd6c90170f97@redhat.com>
Date: Sun, 5 Jul 2020 08:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a36faa0a-6aa9-463d-03a0-b862141a427d@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 00:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/07/20 18:50, Philippe Mathieu-Daudé wrote:
> kind ping :)

Queued all except 4.

Paolo

> On 6/23/20 12:50 PM, Philippe Mathieu-Daudé wrote:
>> Following Paolo's idea on kvm_check_extension():
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg713794.html
>>
>> CI:
>> https://travis-ci.org/github/philmd/qemu/builds/701213438
>>
>> Philippe Mathieu-Daudé (7):
>>   accel/kvm: Let kvm_check_extension use global KVM state
>>   accel/kvm: Simplify kvm_check_extension()
>>   accel/kvm: Simplify kvm_check_extension_list()
>>   accel/kvm: Simplify kvm_set_sigmask_len()
>>   target/i386/kvm: Simplify get_para_features()
>>   target/i386/kvm: Simplify kvm_get_mce_cap_supported()
>>   target/i386/kvm: Simplify kvm_get_supported_[feature]_msrs()
>>
>>  include/sysemu/kvm.h         |  4 +-
>>  accel/kvm/kvm-all.c          | 76 +++++++++++++++----------------
>>  hw/hyperv/hyperv.c           |  2 +-
>>  hw/i386/kvm/clock.c          |  2 +-
>>  hw/i386/kvm/i8254.c          |  4 +-
>>  hw/i386/kvm/ioapic.c         |  2 +-
>>  hw/intc/arm_gic_kvm.c        |  2 +-
>>  hw/intc/openpic_kvm.c        |  2 +-
>>  hw/intc/xics_kvm.c           |  2 +-
>>  hw/s390x/s390-stattrib-kvm.c |  2 +-
>>  target/arm/kvm.c             | 13 +++---
>>  target/arm/kvm32.c           |  2 +-
>>  target/arm/kvm64.c           | 15 +++---
>>  target/i386/kvm.c            | 88 +++++++++++++++++-------------------
>>  target/mips/kvm.c            |  6 +--
>>  target/ppc/kvm.c             | 34 +++++++-------
>>  target/s390x/cpu_models.c    |  3 +-
>>  target/s390x/kvm.c           | 30 ++++++------
>>  18 files changed, 141 insertions(+), 148 deletions(-)
>>
> 


