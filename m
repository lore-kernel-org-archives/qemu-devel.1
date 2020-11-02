Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C6C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6E821D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWYoAj8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6E821D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZVzl-00074c-Lb
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZVyv-0005tV-CT
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:18:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZVyt-0003yz-OB
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604308706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NeU9LZ5/J3nyk/EmK/FBm6lNHZz8wcWlUJKm/PTpzjI=;
 b=KWYoAj8whF07CglShli0yCmykiTmYXXcmbYqUpuCShRWpb/sxVKdRx1OOrzw0yDUj/LZvD
 DBy9lJz3FXKAowB4t1IO1uUvBowbPvnzbfS7y4j44DRs7zuFR6RMbnNyF5OwTkBRJYG4gJ
 fp5sYIIN91s7A19SQQmJb+k6Xazz9hA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-zMmbbu2eNxGpnm2FoUGQSw-1; Mon, 02 Nov 2020 04:18:25 -0500
X-MC-Unique: zMmbbu2eNxGpnm2FoUGQSw-1
Received: by mail-wr1-f69.google.com with SMTP id b6so6135468wrn.17
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 01:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NeU9LZ5/J3nyk/EmK/FBm6lNHZz8wcWlUJKm/PTpzjI=;
 b=qfrq7nMymIrXLnFXgGQbex5k5CzGeSQt9gGlagnTnrcJQLVLP1kyQrLuaPSVxpz+8+
 1XQImaXGj4rhOofRnL5+fW5tFNdoqjqWNHtCwo8NZG05AFUN6/9j3DK5NW43qRHkNX+e
 fF0N9DYLsk3EdgjmYeoh1rSAA/fBlNxIH6bxt2iX6b7KZWLxsH7f37FGvMyr8PBGmcx6
 +cBK/9VjYDQJ7IbEH1APMsYoG88HRb/5hu+/tAwEQOZKPOiMVvlNFhz5bnSDHd2g/48g
 mEyhfe1B3rY54A/oq0eU3dOjYdiHFR4KMlCfc0mt1zJ6aClY4NtFH+AnM+jHgenERcNl
 KGUg==
X-Gm-Message-State: AOAM533fuUO8neSC5/B7bfNw0IYwStIli7DJCr3rt2x3R/+FXrSQDlTV
 1zrJrvM7kZuSCEN9j/U1zB0NPpZjwAF3gGmFD/t95rQB78awBWdHJ55mh9lHZIMwJw1r2qEgpJQ
 zi6EOlO96kr64o6o=
X-Received: by 2002:a1c:8087:: with SMTP id b129mr16609204wmd.10.1604308704155; 
 Mon, 02 Nov 2020 01:18:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWx9CWwQ6fzCw6jXPHe3y5H0bbGDQy2idySo8hSklzd0003nwbP1zVfjAMVpzbcyREpsog+A==
X-Received: by 2002:a1c:8087:: with SMTP id b129mr16609193wmd.10.1604308703969; 
 Mon, 02 Nov 2020 01:18:23 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m8sm21075616wrw.17.2020.11.02.01.18.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 01:18:23 -0800 (PST)
Subject: Re: [PATCH] hw/input/ps2.c: Remove remnants of printf debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201101133258.4240-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ee9ddf0f-2368-d965-c6c0-0c467907fb24@redhat.com>
Date: Mon, 2 Nov 2020 10:18:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201101133258.4240-1-peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/1/20 2:32 PM, Peter Maydell wrote:
> In commit 5edab03d4040 we added tracepoints to the ps2 keyboard
> and mouse emulation. However we didn't remove all the debug-by-printf
> support. In fact there is only one printf() remaining, and it is
> redundant with the trace_ps2_write_mouse() event next to it.
> Remove the printf() and the now-unused DEBUG* macros.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/input/ps2.c | 9 ---------
>  1 file changed, 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


