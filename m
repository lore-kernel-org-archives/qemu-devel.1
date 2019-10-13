Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240A4C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 16:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05E620659
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 16:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TrZzU0Ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05E620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJgNC-0005QL-Vk
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 12:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJgLN-0004ib-Fw
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 12:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJgLM-0005WE-2b
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 12:03:41 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJgLL-0005Un-Q3
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 12:03:39 -0400
Received: by mail-pg1-x541.google.com with SMTP id i32so8623900pgl.10
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IbV5r8m31A1bRWtlAO7wvY0weqVmtv+4f6gASo/uKcI=;
 b=TrZzU0RiL+P/brFc29IP6sE0z8SApcZf9e3Hlk625R3pBK/jAU1r9/UOLsv5zKAbmK
 libL2s1qo/Dy+njLpxrgwFbuOXa3odaYWFySQs+2WpjCqEe0SEUhh+RGYDpVfmi1E6V9
 yZh/McXEVud+B+SLDqYI4WVz7nCiRTnjavYWXDYtoKb0zaZHeyVMmeLFX5cql0T6mubr
 C5gj2bYr/wDm2vxwPfDpdSAE4GJw9Q2vZW4XPe8GaIAjPSov5jONBPK94FLz5/csEcgY
 2oqSnGBBsbkr+QTKJBr2XwHldTIGCb7ifLiq5VbYROsPOkOPxBTryqAX3RnoRuLqZvhC
 RQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IbV5r8m31A1bRWtlAO7wvY0weqVmtv+4f6gASo/uKcI=;
 b=HUf8XIt2LBlXlZ11cnAXU+35ieTDppTiNhD64H60uBpThnsppY1wV5Useybae2Yq3q
 qbL8HbmdJ5GPqiB2S7n11bzR37i+U/M98SjffdustTH5d1XWay/SQ/n8ek6u+5SNEsDP
 YHDfcJSn3F2cvZRxZ7l2PC+//FgHy0vpXWhD3EyFB5DUkS2VjtaBEq5pnuVxp7kxofmU
 mn2OO1L3J44EGNz2H5mum8NgjawOGF7lmRPugi/Vy5HQbcgzfRQAQy/C3QVbl9iUKuJ6
 XagWN3oH2hSQbaWmC20nd9CwhRgtryIrhPq6JuyQ+ieWy/uSvhbr/LXpIqD5LxKkgeoP
 3QZA==
X-Gm-Message-State: APjAAAWSGLTgboEPykzlPttdN/UU6wfCeFl1QQLbOApTlof+PVyCrvMR
 9gKB3ZugDMQPCyqiyd7g3++YwQ==
X-Google-Smtp-Source: APXvYqwzw5zO4LMhXIN6hf5PZ71dTTKm6EFbgLSwCBS90sgyzskv1puy4AHyya0DfiF2iaUnBMzlgQ==
X-Received: by 2002:a63:4383:: with SMTP id
 q125mr28509849pga.373.1570982618444; 
 Sun, 13 Oct 2019 09:03:38 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i132sm14920153pgd.47.2019.10.13.09.03.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 13 Oct 2019 09:03:37 -0700 (PDT)
Subject: Re: [PATCH 2/2] core: replace getpagesize() with
 qemu_real_host_page_size
To: Wei Yang <richardw.yang@linux.intel.com>, pbonzini@redhat.com,
 ehabkost@redhat.com, imammedo@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, den@openvz.org,
 marcandre.lureau@redhat.com, kraxel@redhat.com, mst@redhat.com,
 rth@twiddle.net, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mark.cave-ayland@ilande.co.uk,
 david@gibson.dropbear.id.au, yuval.shaia@oracle.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com, quintela@redhat.com,
 dgilbert@redhat.com, armbru@redhat.com, sw@weilnetz.de
References: <20191013021145.16011-1-richardw.yang@linux.intel.com>
 <20191013021145.16011-3-richardw.yang@linux.intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d088e1fd-69b9-abd2-e84a-c2f7848ef924@linaro.org>
Date: Sun, 13 Oct 2019 12:03:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191013021145.16011-3-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/19 10:11 PM, Wei Yang wrote:
> There are three page size in qemu:
> 
>   real host page size
>   host page size
>   target page size
> 
> All of them have dedicate variable to represent. For the last two, we
> use the same form in the whole qemu project, while for the first one we
> use two forms: qemu_real_host_page_size and getpagesize().
> 
> qemu_real_host_page_size is defined to be a replacement of
> getpagesize(), so let it serve the role.
> 
> [Note] Not fully tested for some arch or device.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

