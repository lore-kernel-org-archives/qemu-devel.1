Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D4DC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9126520866
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlECHBCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9126520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDA99-0008Aa-PZ
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDA8L-0007ON-8D
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:31:49 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDA8J-0008VB-Jz
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:31:48 -0400
Received: by mail-pg1-x543.google.com with SMTP id u13so121050pgh.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GBK57YN5P0NON/F4PvCc2+1mZjTZHHQbW1Rw0tbWPsc=;
 b=dlECHBCtGglVnZ5a4TpoW5ZCxPHof+79GOnCoTJ97GGfkDjM0hoPsx0LYvNMACYc04
 thukjPk0U1I9NsiU3OAWwXx1C6GpcQYQSBhBFjc7vBgJULSH3d9ANKwcLn0l4HZjFDnf
 pvnrB28txXjJSceBtu++QU0qv5SYPxuZJQ9SZjDzoH5LumsuCuYagxef1qHtWDBbMv1s
 0/HmEah+DebFnE3aYpBLKM15JTSGYUATxehr95rdhkhxlHlMZE3NDG1FweQSUYjy+tH2
 fUj2xipJT1izaH0VMgMWRR9+SM3+wPVRbQgDnDbZNt8dV2jP+3iHXQjHf08sZ6TTyWU/
 +65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GBK57YN5P0NON/F4PvCc2+1mZjTZHHQbW1Rw0tbWPsc=;
 b=gv31VnBxATRgVwJbULERVhVAgnYaW4PTraBiRmQJ/2lrOP2Hxl6AbkxnDSRYEZlK7q
 ZIc4Gi/vTGko2WlzncfTk5PuQ6IwCaPxgjaToBmF96F5k47HwG3CReTSgD1QJivZa+Q4
 QBYRqEBM133XOzb8xSxshPBet2Flv76qI5y2il/OxTR+qy0+QW7Tgqiq0kAATeXHwmTq
 zCjxHx3lHJZPKvvZZneXSFohCgc5Fzgely5WPNN2OW8uM0hc6KjocNwPTODuQfQeAvvS
 52iGh2nbWQmPzsP3N0AuSsiE6I8BOGYTuNKykf3vVqrf9CiJK41DkB2taxrFEUye0IdO
 iWgw==
X-Gm-Message-State: AOAM530sKgwIUjme+mPDVio+u3g/cIfSDcbF/v1xKzb06KWzWIO2qlB+
 mJXnxWPoZpmgRXJbhK2gfQashQ==
X-Google-Smtp-Source: ABdhPJx8Q30U91O54vUDSVtU8CMZQLpfNkGzrj8v6ZAX/vzoY63LN3YW92fc09rUMSWTIh+5IqUsgg==
X-Received: by 2002:a62:868b:: with SMTP id x133mr2813914pfd.165.1598981506078; 
 Tue, 01 Sep 2020 10:31:46 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a1sm2842558pfd.65.2020.09.01.10.31.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:31:45 -0700 (PDT)
Subject: Re: [PATCH v6 03/16] cpus: prepare new CpusAccel cpu accelerator
 interface
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200901072201.7133-1-cfontana@suse.de>
 <20200901072201.7133-4-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2d3986c3-6b7c-ddd3-2416-4f4501a69f29@linaro.org>
Date: Tue, 1 Sep 2020 10:31:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901072201.7133-4-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Colin Xu <colin.xu@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 12:21 AM, Claudio Fontana wrote:
> The new interface starts unused, will start being used by the
> next patches.
> 
> It provides methods for each accelerator to start a vcpu, kick a vcpu,
> synchronize state, get cpu virtual clock and elapsed ticks.
> 
> In qemu_wait_io_event, make it clear that APC is used only for HAX
> on Windows.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


