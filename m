Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5436C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E18220823
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkyzO4xH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E18220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8u5-0005Tc-Mt
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 13:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo8iz-0003Ti-0V
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:58:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55429
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo8iw-0003KI-Pi
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+LP2F32fk/QU8Knd2vnQ9qxRC0G4rjxcCGR/GDMa2I=;
 b=HkyzO4xHi35vDoEMp+sZbVWFHYqU5LXo+tKEiVE9xDciKnWK2UfxZFNJKh76nmWE3Okggo
 7FKkH3WEyKImZtSsdRY4xxPtjIHQfsQgI4JrqEk3HsQrst6wanBsRSgWUzyWELPdu6E+fB
 pLEeROZclhiH6RhMizS2FKebt2aJ9/4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-SKywMzeXNT-iqnkDpCFRig-1; Wed, 24 Jun 2020 12:58:07 -0400
X-MC-Unique: SKywMzeXNT-iqnkDpCFRig-1
Received: by mail-wm1-f70.google.com with SMTP id h25so5070972wmb.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 09:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z+LP2F32fk/QU8Knd2vnQ9qxRC0G4rjxcCGR/GDMa2I=;
 b=tQ9EOq6zRyt3kpn0ngc7iWaT4QLSbIx2HYMQqVHFgPRZ50iaDf/gMargZr4eHmrDln
 j1JTTxbIDtclEldZ5q5o+k6hNma/5RElHiBHScCpqVk7PfxBKoNcLt5bv8ffMDyAun8E
 WPy76J0FEdiWEjavZoTZh03bgRUVcXig0Y3/nkMiZxexFXgNNhtgd1ouqNYa3vxXGD9I
 PSO3oa9Lz1pGyU7femQLMBIp2tjehiq1/qdQPL6M/VNddcwClcHkt75H/QoZYAEbxT+P
 KPLIKh8Smx9syXO7XO2zMgt6a0Wwgr7sKEet42YsQb7x/ieMipsbRQt2fajdiFAqVCT+
 intA==
X-Gm-Message-State: AOAM533He2lKTDLncV6fDioYbH+W1/vQrvhJXaeWphdXhnsJA/hwNf4h
 0D7YkHZIQAy7w/5bGuxHJj0BQdeKGRt3VGaQmaJp++tEz6Vf8UNLrYMBNs4jguiVpU3zJ6OGzVa
 Zf6aukUTXsj25s7Y=
X-Received: by 2002:adf:fe46:: with SMTP id m6mr19686769wrs.192.1593017886567; 
 Wed, 24 Jun 2020 09:58:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx90PW8SRWVsX5lvPn0sfau+jJxcVJtJI9QTQDhNf+Fo5UiBsyOpKJG4TV8jBdAa2N3edsAgQ==
X-Received: by 2002:adf:fe46:: with SMTP id m6mr19686752wrs.192.1593017886343; 
 Wed, 24 Jun 2020 09:58:06 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.253.55])
 by smtp.gmail.com with ESMTPSA id p4sm17720374wrx.63.2020.06.24.09.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 09:58:05 -0700 (PDT)
Subject: Re: [PATCH 00/46] Less clumsy error checking
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9cf09e59-9617-f27b-6011-e735f01eba9a@redhat.com>
Date: Wed, 24 Jun 2020 18:58:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/20 18:42, Markus Armbruster wrote:
> When the Error API was created, we adopted the (unwritten) rule to
> return void when the function returns no useful value on success,
> unlike GError, which recommends to return true on success and false on
> error then.

I was actually never aware of the GError rule, but I, for one, welcome
our new bool overlords.

Paolo


