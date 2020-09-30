Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F09C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32EBD2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8HMODN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EBD2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZT9-0007YT-0z
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZM3-0007Lj-Jc; Wed, 30 Sep 2020 06:28:59 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZM1-0007DG-TL; Wed, 30 Sep 2020 06:28:59 -0400
Received: by mail-wm1-x343.google.com with SMTP id e2so1158869wme.1;
 Wed, 30 Sep 2020 03:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EdXrNyfdBg0OEaEH8iOLmyouRMOpeJWD8doayLC7rOI=;
 b=O8HMODN81v6ysU6kXH11aws3iwdyV9vZ42t+AUPEb8zJVfuLuBgrLvdYL6hd1oH/Li
 4/9KSdu27LcFR9AYqVUttpjX4c7Px4H/xILpJ4AoXbGFszT9bwzXkQ64Jb7v0hxNhJA+
 pQT/NPUsVkIRuLnJj37+QPAMj46ZgsaH1Z77Ygp5kgKI7vP9dujKFd1B+FUTAaSOfNw5
 86m6SxE9QujqGHJ9Fo94MJiOe/mMJjLNX+uiU1tYiiJb7UY1A23e3QKdalEhigZ4uJTv
 CBaDN4NSudQC3ejUMyYvee2ZDXWhdpvOrlF8an8Id28RfDSnRQSfg+uRKTv8DZzr6gxn
 p0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EdXrNyfdBg0OEaEH8iOLmyouRMOpeJWD8doayLC7rOI=;
 b=K/yG+iT9PdnQkY14wZN8BQCNkfAAIFwtnYuvV8CyPB4G/LjC5zn9QUYAanyiM2UBF4
 0QZ6kwikfjcNYOEvIrDhYJFIi26HUojRuP8gj/7x5oBCbZeiI+YqJx8+9r9UEMYYSsXa
 fi/REIxOoZOIRAGvLdmBIJwWtX4wOTCYSzMuHID/9TKMVkZlVUn1QPVBVqZkeWm2RfTg
 vUfz/Srk1YNO/iuJIBEhGzrJq1YQuAYUKyMULy3aHyGb6tB9R42k4VYrCgvSLq/pXFNc
 1Gu8oyodrdgZY/SeqWFXMOCTzdqbgdXAROn9n2RJgRuGVpjAclsHtjhDp8GF30PwYIsO
 /+uA==
X-Gm-Message-State: AOAM531C58vqtoVgb3z+OPsdjGV8XxTrVu0364JX/1V4WAfY2L1IKfhG
 /IdrEZJr68FndxSNgzWfNnFjqhS9nG8=
X-Google-Smtp-Source: ABdhPJxXNA6/HHtyrT3ZKp3i86ROGfUzmssByUlDcT7WT6HxW4PdU4Nv9A4qdrj6u9U1Ti2TQHQNUw==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr2228751wml.6.1601461735177;
 Wed, 30 Sep 2020 03:28:55 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id w7sm1923524wmc.43.2020.09.30.03.28.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:28:54 -0700 (PDT)
Subject: Re: [PATCH RFC 00/14] fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200930095321.2006-1-zhaolichang@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3e850b75-c82c-81ef-4495-8a552bf5e5f8@amsat.org>
Date: Wed, 30 Sep 2020 12:28:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930095321.2006-1-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 11:53 AM, zhaolichang wrote:
> I found that there are many spelling errors in the comments of qemu/target/.
> I used spellcheck to check the spelling errors and found some errors in the folder.
> 
> The checkpatch.pl file in the Linux kernel can check spelling errors in patches.
> I'm trying to add this function to the checkpatch.pl in qemu,
> so that no similar spelling errors will occur in the feture.
> It's not done yet and I will commit the patch when it's done.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

BTW your git-config is still messy, maybe you missed my previous
comment:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg741642.html

