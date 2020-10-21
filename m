Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A5C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2731B2177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tnq80iTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2731B2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHAi-0001Zo-0b
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVH8j-0007sk-R5
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVH8h-0006KN-Ta
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603298342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxWJG0ffhPChzDF7ELDLcdBh2KyEnKwLjbNVcDW+cVM=;
 b=Tnq80iTLEPBz4+iIoDp2pOGpdBvWRjEX0E8NoQ70q3J/392lhtGuhqVMCj1AnXbX6MEgq6
 YDwA4+d7aXDbEWI4ooe7j55jeAXjWG2fTUxDunPIjJVcfRrvsePgWF++EK8fJGR+OEFqwB
 9vNOI0/SbKfJRXUcEu537qFO790S0Mo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-lXuXm6e2PamICduvS3ZZsg-1; Wed, 21 Oct 2020 12:39:00 -0400
X-MC-Unique: lXuXm6e2PamICduvS3ZZsg-1
Received: by mail-wm1-f71.google.com with SMTP id f2so1777682wml.6
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 09:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QxWJG0ffhPChzDF7ELDLcdBh2KyEnKwLjbNVcDW+cVM=;
 b=rxI8e1yqqeIKbJrQeXm53OjtwvhQ1uLjH5Vm7W2arxkWp6Bdq9eAwJE50cgqQpPJiu
 LOEznULeYtr2se9GThnUxkl1gqkgvWaDh2hdszYY5tvF2TWqOuGvRS0RSK+h2DyBMfpU
 0dHzxflry7Tm4Wgrlnq+GrYOCZ/b976YiLlgHKTYzenvq7XRAuzMqlIbCEgIvZCqRPQk
 p4dO3GkfzpB+apx04VieA5Fk08/OpW/Y3zWxOvYJbibZj8o9ej+79UOfq9+j05U9oMey
 EWGsMsZJvjkAjbzFr1h0OIOxUfZ8C0+7+YYrncebJm2h7UBC6gP4PV3BE0zbUI37pg9w
 5A1A==
X-Gm-Message-State: AOAM532Xfr2dZ7wL3QHcBesRm/8w0PiuyPBkMIQ7StA2jLk0LScLdtBl
 tMYVvHFeCUe595c/Ehien9pYCiW8bxrIq4tmKU8WiYqWJEhXprMxng+f/EdrKLmiMPxTieQfdCU
 ZHRnJelYtS0Omun8=
X-Received: by 2002:a1c:9ed8:: with SMTP id h207mr1467023wme.75.1603298339454; 
 Wed, 21 Oct 2020 09:38:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi+P09tLcGZcvIz6ifxzwUOHRdbwJTwKQ/IXFiFYEw+wFyQOIIpUOUfRMR2WlHu3TwS7vq6A==
X-Received: by 2002:a1c:9ed8:: with SMTP id h207mr1466998wme.75.1603298339257; 
 Wed, 21 Oct 2020 09:38:59 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id c1sm4973322wru.49.2020.10.21.09.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 09:38:58 -0700 (PDT)
Subject: Re: [PATCH v7 08/11] migration: wire up support for snapshot device
 selection
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201021162704.3652555-1-berrange@redhat.com>
 <20201021162704.3652555-9-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <76fc47c5-abbf-9b2f-76ac-82cfef6ec1b5@redhat.com>
Date: Wed, 21 Oct 2020 18:38:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021162704.3652555-9-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 6:27 PM, Daniel P. Berrangé wrote:
> Modify load_snapshot/save_snapshot to accept the device list and vmstate
> node name parameters previously added to the block layer.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/migration/snapshot.h | 18 ++++++++++++++++--
>   migration/savevm.c           | 28 +++++++++++++++++-----------
>   monitor/hmp-cmds.c           |  5 +++--
>   replay/replay-debugging.c    |  4 ++--
>   replay/replay-snapshot.c     |  5 +++--
>   softmmu/vl.c                 |  2 +-
>   6 files changed, 42 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


