Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACE7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10E022282
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzHSmeUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10E022282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyGB-0006jN-N2
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQyBK-0000Oz-M1
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQyBJ-0002sR-0E
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvR8MGaS/ODPdBVgqT7NJIgT+tboahOcIKFyQerLJcg=;
 b=YzHSmeUd7ZXs6xRFuGaRL7M+ipqa3VwMvMc0t0QqQxbWimKXC+pnAAqqSwpco+iW7SDOoS
 1Sm11JOvywIn1/4fw4HaNg6snEJBgzvqqzvDm00Tp2BHmePdv+RNe/mVKN/x9+uBr6bMbP
 JQb4DAu5uObcyfO8DD5JVphafAIJqvU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-L2PZjbz8Msm1poVpRPjLXA-1; Fri, 09 Oct 2020 15:35:52 -0400
X-MC-Unique: L2PZjbz8Msm1poVpRPjLXA-1
Received: by mail-wm1-f70.google.com with SMTP id s25so4527998wmj.7
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 12:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fvR8MGaS/ODPdBVgqT7NJIgT+tboahOcIKFyQerLJcg=;
 b=D4mJYxz94k4PfTuL8VEpRcM+Yq3vfMbwBMXrm7BUL9sU3X2sgGomGEJzOdgB/1iTWc
 harqwU+lQOjjLPJ6Vv/6r3yCRMC1F9cxXilIW1OikkX10WktRkrmAvdjcqEBlOgAwzHq
 se1spZq3K7QvQw0pG73BsbDp0Slw9HKi1RUOvb1soeyAXC+zJdkK102ABxLSeBLDKH5M
 g2Nt7RFIQgaRtznIZ++f9vB2K52F8w4AK/wdEfOPKLI4nKgwSxYtoiFTb3qCR3tuf8TW
 80V5NMJ8/REOEYjyRcXWOxWROHTf4xkFHgVgTh6ViZ/jfT3GRSuQTNGr7+pCdyai77Qz
 S58A==
X-Gm-Message-State: AOAM533IM+KyJ8+LsbNtAKurUKkPHqvozMGrlE0sKPjjZMjbQ0jNNw6Q
 H8ORInsiztscHDFOu/igtdQiPGAv2eFKBp5HDD6oCwbEi7//tflewycnRBZpojUQmJN8FcCm89P
 y21Oc1liSUHvaheQ=
X-Received: by 2002:a5d:6a0d:: with SMTP id m13mr5706975wru.161.1602272151050; 
 Fri, 09 Oct 2020 12:35:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZDGzRlLZzZ9k+x6kms8DUp9pBk4Nx9nzVIoGUq6QND1ez4FhDayVcNnFMQyA1Q0O8VMmQxQ==
X-Received: by 2002:a5d:6a0d:: with SMTP id m13mr5706960wru.161.1602272150886; 
 Fri, 09 Oct 2020 12:35:50 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u202sm2572175wmu.23.2020.10.09.12.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 12:35:50 -0700 (PDT)
Subject: Re: [PATCH 3/3] python/qemu/qmp.py: Fix settimeout operation
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201009175123.249009-1-jsnow@redhat.com>
 <20201009175123.249009-4-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <75b4cd8f-f7b1-a182-ce5a-27bf2c9f1612@redhat.com>
Date: Fri, 9 Oct 2020 21:35:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201009175123.249009-4-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 7:51 PM, John Snow wrote:
> We enabled callers to interface directly with settimeout, but this
> reacts poorly with blocking/nonblocking operation; as they are using the
> same internal mechanism.
> 
> 1. Whenever we change the blocking mechanism temporarily, always set it
> back to what it was afterwards.
> 
> 2. Disallow callers from setting a timeout of "0", which means
> Non-blocking mode. This is going to create more weird problems than
> anybody wants, so just forbid it.
> 
> I opt not to coerce '0' to 'None' to maintain the principal of least
> surprise in mirroring the semantics of Python's interface.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/qemu/qmp.py | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


