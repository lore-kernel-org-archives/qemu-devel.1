Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FD7C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A56204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNmDNV/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A56204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLvPo-0005Q0-Lf
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 17:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLvOc-0004xJ-5w
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:36:50 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLvOa-0003pq-Aq
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:36:49 -0400
Received: by mail-pg1-x543.google.com with SMTP id d13so3677602pgl.6
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=437+k7V+C5+AGiO0yrFwb5Yb0aoN9KJMityORokIo80=;
 b=bNmDNV/28Gf8hdymws8VaQ4qkq7aRwzOKNFGyOqPmbtaLhslXOLwzHfzzd0qqy1TUT
 oBA5BTMKK5q+U8EG9qK1LTWIaN6pQRaorGG9Rjmxd8gQ/vNKbPpbPFcD38hBewmzFfzQ
 rh6gsZWTkIRBxgkq37j/ZCXbEU67aNOeRUtWuusDWY7gnMBB4DO7rAhEaOzsMLrnUoab
 adP2mpXHLDXTxpEQTo2zn12H2fdG8ECfYwkCcOBQyD5YnUXB26Mjrd0aGEu29H8wTT1t
 cJ4BxDlz8mu0uewIsoY+n0HMYDFyjwsqVPEqugJPy933dZ8PuCptskPFzgc1EJxjK5iQ
 S5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=437+k7V+C5+AGiO0yrFwb5Yb0aoN9KJMityORokIo80=;
 b=tbcJohMSWZ4WpMh6llxycyof8EelILW56rpXbvyrahptiEnSZiUwKzvx5AJCVok1hD
 ITSxf8tG8Stt8YlWx4knXfnK8CthuuyGg5kspifYjXSxboGDSlexCjI9w3LI6iYGEkwe
 Q7tMY6HqvzDygWrvWqHfsYLMfCjccl+IHSbzS5av6LSDLf5lWjoKt5Ueu9XBNjj1qMjd
 FQNZuC//xNna8eYmj3Fz9sXdjHGZx1zMv61CYav6p9Pa03dLEP/5S2KNkb9UagJt0Qvh
 N+6OgFAJAiXHu7l0raTEbgZiukkwdbXmqbi35QGvYMP7afUlXNqQuQpssLu+6XUyqPzL
 Dc0A==
X-Gm-Message-State: AOAM5322pz7MLkhivxP+ZHJBcE6UgGVETjnwzl9J4ANMl3H94tY5J0Wl
 Qzbnv8bVZU50u5w14YDYv1RRXg==
X-Google-Smtp-Source: ABdhPJwkNYm3NHMEir1yA19VBV2X9Zdc6LxBiaoKGfurm1OMYvqQtYbUOGQogD2/XZ6hiSEfSuGtHg==
X-Received: by 2002:a17:902:9884:b029:d2:4276:1b64 with SMTP id
 s4-20020a1709029884b02900d242761b64mr1339081plp.76.1601069806590; 
 Fri, 25 Sep 2020 14:36:46 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3516722pfa.125.2020.09.25.14.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 14:36:45 -0700 (PDT)
Subject: Re: [PATCH v1 3/8] s390x/tcg: Implement MULTIPLY (MG, MGRK)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200922103129.12824-1-david@redhat.com>
 <20200922103129.12824-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9def3734-d562-4591-ad6b-6a82e989e471@linaro.org>
Date: Fri, 25 Sep 2020 14:36:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922103129.12824-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 3:31 AM, David Hildenbrand wrote:
> Multiply two signed 64bit values and store the 128bit result in r1 (0-63)
> and r1 + 1 (64-127).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def |  2 ++
>  target/s390x/translate.c   | 13 +++++++++++++
>  2 files changed, 15 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


