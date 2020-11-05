Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD7DC388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221C220728
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdEi2D56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221C220728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kakwB-0002kd-5G
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 14:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kakv4-0002A9-KJ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kakv2-0008NH-I7
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604604455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sr2uLDzMa0Xo2JPvF9ACkieW/OdLUrRAJ56OMahhDJ4=;
 b=AdEi2D56ycvuaMgydYYtimzKufwrJt9/D5+rejB75VEYiOfPoyb+KSAwPrEq0Fh8YeSeJ8
 yYIzMhz6luwvFFke4RZowOUK0N55lnxRV1ZwbJI9vZ6c8Bv8u3ccNzfsTBjXY+JmDipoWr
 Gj8UDpGu/0E9OZjJttfHxPjUXqaQ2PY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-MID-UFYEPYOs03d6V6V6gw-1; Thu, 05 Nov 2020 14:27:34 -0500
X-MC-Unique: MID-UFYEPYOs03d6V6V6gw-1
Received: by mail-wr1-f69.google.com with SMTP id w3so1109307wrt.11
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 11:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sr2uLDzMa0Xo2JPvF9ACkieW/OdLUrRAJ56OMahhDJ4=;
 b=Fbrl0tGn7G+v5zrQ3lIUJ+n+OgTQu5TkjxcOJEaGX1SdWUKJcFYwBdrbh1W7NAXbv9
 RrTU7fB18glrJDCOEpWm+qtsrmh7ntfNrRotuJWneeWGqmPQlbYOAfNd+7R9++7sZvde
 1TpIewgyWgU92MDFp/iGg0mNuyxkG1j9iFrZj8Q9HMq67+xzl0vPohLOOkBRTIQn47zv
 tyxK8IyOMiVPuKa+QXxxMX1gx0qJ6XdV2mMrwaORR4uMq2khDibOhwI2Lm9MEMbfx95H
 h9T8y7HvyrKkQCJItNcMJ0jwWlQOAuZdTSjsoihGvLlwhYdFQD+lx/h5HNEFpW3HeoM4
 elpw==
X-Gm-Message-State: AOAM532g/xC7LMCvSTOdHiOFoKlDn+RtA5nJHOWPTEfZzvhOn26CwjE6
 Bf1Q340fTlLhkrYiY0GogYihMMiqQratGfEnhV/4yvojfcJM4e/513ev1MLBfygSfg+J7MW5siW
 l44OyyRl1khiA7bQ=
X-Received: by 2002:adf:d188:: with SMTP id v8mr441799wrc.167.1604604453014;
 Thu, 05 Nov 2020 11:27:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyK6zQ2dYZfHYdiyRA0pL6rWY4BRLLB1n8CMAvYWwok/tYf9u1O3ixH+4O0I3e+ZmUMeJVD6w==
X-Received: by 2002:adf:d188:: with SMTP id v8mr441782wrc.167.1604604452786;
 Thu, 05 Nov 2020 11:27:32 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t1sm4154035wrs.48.2020.11.05.11.27.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 11:27:31 -0800 (PST)
Subject: Re: [RFC PATCH 01/15] hw/board: promote fdt from ARM VirtMachineState
 to MachineState
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ea13af19-9ec7-3d91-e7b8-b4f59aa4cf1d@redhat.com>
Date: Thu, 5 Nov 2020 20:27:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105175153.30489-2-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, julien@xen.org,
 Eduardo Habkost <ehabkost@redhat.com>, masami.hiramatsu@linaro.org,
 andre.przywara@arm.com, stefano.stabellini@linaro.org,
 takahiro.akashi@linaro.org, "open list:Virt" <qemu-arm@nongnu.org>,
 stefano.stabellini@xilinx.com, stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 6:51 PM, Alex Bennée wrote:
> The use of FDT's is quite common across our various platforms. To
> allow the generic loader to tweak it we need to make it available in
> the generic state. This creates the field and migrates the initial
> user to use the generic field. Other boards will be updated in later
> patches.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20201021170842.25762-2-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Two S-o-b better than one!

> ---
>  include/hw/arm/virt.h |   1 -
>  include/hw/boards.h   |   1 +
>  hw/arm/virt.c         | 322 ++++++++++++++++++++++--------------------
>  3 files changed, 170 insertions(+), 154 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


