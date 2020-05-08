Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CA2C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27890207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+Y5b9eu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27890207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5IE-0004EQ-7M
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jX50Z-0006sP-FN
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:33:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38678
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jX50Y-0006E2-I4
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588952029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JuSorLg7Qq6QRnbKcuGatq1qidVnqnPNge7Pc1/vX6M=;
 b=E+Y5b9eufZTOphVPV+hNY2DALImefD0WhElM2S2xP3SSMoK02NmxePUTiSNWJhCypaeqt/
 PVH/qQU+hbNQWL0o9S/fGiMcRdA208q0ugR6/gzxX/veHvI6Z8QRrzC8Tr5rUipPp1J0HG
 HC511wXgDh1BoqxF+IV1l8kd2+bQm+U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-X6JUKO_XOdKHyPiaDVET1Q-1; Fri, 08 May 2020 11:33:45 -0400
X-MC-Unique: X6JUKO_XOdKHyPiaDVET1Q-1
Received: by mail-wm1-f69.google.com with SMTP id a206so1654370wmh.6
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JuSorLg7Qq6QRnbKcuGatq1qidVnqnPNge7Pc1/vX6M=;
 b=n70thvNPnl3GYWBxdNrkjJEqcU+3NAOT/imVi3T5WbTnfgpX5Y1tQwdyMIAssrSXVS
 8IoSddZaPpKsVkuNBtFQ1ZZIF50qValx9CnShGlgXvkajD5jgnr6yDFsZs6mW+UZ+B8U
 DU/WOKnl6yV1P7y2GpN7ewgVkiGMcw+kIv7PbUpfJbgw5MQZ73GpBYYmgEq3neMlakEv
 uZ7/HPXdBAOJlhl/d/rjBgtfOGDIl4b1R34wLIh27IXrLuFmzbRi/AIljhU1NGBvYrVH
 U8pc19pJ7bObN6iQd8911pybC3Xka08qJZ7olrsFqTlt8locanavbe6yW7BfmStyDqSj
 JxKQ==
X-Gm-Message-State: AGi0Puby7yRJmbjjAVr7MBVyXPI9i8ZE947pxNkIu1AUJ6CRJTy6thJt
 CDINUFnJoQRl6o/1TXLnEfgMle5NyuTr/EvhdR0jMsM+oV4WdKqAGml307UA+e2d0SCayRagYdA
 +8thvhUbCt4rOE6E=
X-Received: by 2002:a1c:abc3:: with SMTP id u186mr16284247wme.42.1588952024456; 
 Fri, 08 May 2020 08:33:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypKI5ASUy709+UpyMRvItcS2+SeXzd2gHwF38Ok5kmcpflVIkBz3109BvlUFZB7+oA4YTT/Rzw==
X-Received: by 2002:a1c:abc3:: with SMTP id u186mr16284237wme.42.1588952024221; 
 Fri, 08 May 2020 08:33:44 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.138])
 by smtp.gmail.com with ESMTPSA id l5sm13068023wmi.22.2020.05.08.08.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 08:33:43 -0700 (PDT)
Subject: Re: [PATCH 0/4] memory: Add memory_region_msync() & make NVMe
 emulated device generic
To: Beata Michalska <beata.michalska@linaro.org>
References: <20200508062456.23344-1-philmd@redhat.com>
 <9396e0cb-388a-e08e-c066-82a60708ecdc@redhat.com>
 <CADSWDzvECqOXzusk=tj8r4z-E5CDZn4TNG8PJ5pxLHAn3saOzA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <500bd6f3-2b14-eda8-72e5-56c46b7860bd@redhat.com>
Date: Fri, 8 May 2020 17:33:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CADSWDzvECqOXzusk=tj8r4z-E5CDZn4TNG8PJ5pxLHAn3saOzA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/05/20 17:20, Beata Michalska wrote:
>>
>> mr->dirty_log_mask tells if dirty tracking has been enabled, not if the
>> page is dirty.  It would always be true during live migration and when
>> running on TCG, but otherwise it would always be false.
>>
>> Beata, can you explain what you had in mind? :)
>>
> It has been a while ... , but the intention there was to skip the sync
> if there is nothing to be synced in the first place - so for performance
> reasons. I honestly do not recall why I went for the dirty_log_mask,
> as that seems not  to be the right choice .

You probably wanted to look at the dirty bitmap, but you would have to
define a new bitmap rather than looking at dirty_log_mask.

But that's cool, because it means that we can just remove it!  Thanks,

Paolo


