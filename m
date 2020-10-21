Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61504C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD98E22249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMPYRFIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD98E22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV8o2-0003AJ-GX
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 03:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kV8n4-0002M4-7b
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kV8my-0007qU-Aj
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603266242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LC+vWQH3t71oKb0keKRkjZOm3wPav/L1gR43+fPwNkI=;
 b=hMPYRFInVTBLB5m4+n33yjmj8uYZi17/1hUkzn8Jwk2d1KTdq7chtq/EninlaggKd6l36f
 pk+40/8g3dCkt3LrN0B2wXNhJ5OcDpJ2AciPRltq0pSBaQDpeHydp5fdkpmAo23H6A6J+U
 cBGb/UwodI30c2sTSmrzAb46QO0XBs8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-YID68XTEMNS3J34T2cuyUA-1; Wed, 21 Oct 2020 03:39:34 -0400
X-MC-Unique: YID68XTEMNS3J34T2cuyUA-1
Received: by mail-wr1-f69.google.com with SMTP id b6so1126506wrn.17
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 00:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LC+vWQH3t71oKb0keKRkjZOm3wPav/L1gR43+fPwNkI=;
 b=J2++cHEL9J1eGIW69ki1Tvt+dtN9DP/0XrtHIQ4kwSyDL6Tuajh4Ur3DLQxnnxkIYb
 7d/WePx9qznGgYgWKhrl2Na1QJJsDpMV+nWT5W2TMan2L+6dVGbatJCKP9zg2Xjl381I
 RV45IGUqYmINLNIeYaYsYx4Kn/NUJh7QpoiwKtSuQ7I0GMtkc90QtkDYNoWDR6BKRuHi
 GEqaNefjgM/A6rkN5tLsa5WT59iVYR1hR9Doo95M/fLJFPQGW+MjNJkPkumll0GIVCrt
 dRX0Is2+C0d3UeY6xBgyA0byMKYnnS3QY9ooGOlg8xBVVI7qRoxrxAcibD6g1Gva3YuM
 DAWQ==
X-Gm-Message-State: AOAM531qWeGmDiQBAXl4wKHNe8SSP+Z4DklAfAARnhF96cYDAQh7vW1C
 xhtXGaaooot2xEsvReYxXOsE6YY52ymydYY8pM2mq8CXlMPhyrou+HsNYlM/AsL1Xwm4bQpqdag
 IZ1Ej04ZFXg+P9AU=
X-Received: by 2002:a5d:688c:: with SMTP id h12mr3158393wru.92.1603265973265; 
 Wed, 21 Oct 2020 00:39:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRc9SljaJ5jgIbU5DBPqaAUczF9lCsk5Mq762pJU1t4JLcYAH4yxZbEiDztN25hAFpQALHgQ==
X-Received: by 2002:a5d:688c:: with SMTP id h12mr3158372wru.92.1603265973077; 
 Wed, 21 Oct 2020 00:39:33 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x15sm2450581wrr.36.2020.10.21.00.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 00:39:32 -0700 (PDT)
Subject: Re: [PATCH 3/4] qga-win: Fix guest-get-devices error API violations
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201021071520.2168877-1-armbru@redhat.com>
 <20201021071520.2168877-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4dc47c4e-4824-ae97-c589-c37591b1221f@redhat.com>
Date: Wed, 21 Oct 2020 09:39:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021071520.2168877-4-armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
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
Cc: marcandre.lureau@redhat.com, tgolembi@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 9:15 AM, Markus Armbruster wrote:
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
> 
> qmp_guest_get_devices() is wrong that way: it calls error_setg() in a
> loop.
> 
> If no iteration fails, the function returns a value and sets no error.
> Okay.
> 
> If exactly one iteration fails, the function returns a value and sets
> an error.  Wrong.
> 
> If multiple iterations fail, the function trips error_setv()'s
> assertion.
> 
> Fix it to return immediately on error.
> 
> Perhaps the failure to convert the driver version to UTF-8 should not
> be an error.  We could simply not report the botched version string
> instead.
> 
> Drop a superfluous continue while there.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qga/commands-win32.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


