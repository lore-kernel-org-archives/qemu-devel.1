Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8D6C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FC320704
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtVf+5gF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FC320704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVs72-0001JX-9e
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 04:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVs5u-0008J4-HP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVs5t-0006Wk-5m
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603440396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V08BVp0omfUQxfrM0QXR93eKxkkj0/clyzjQCD16s3U=;
 b=MtVf+5gF9BKmdKexBLyvd1zbid/BQJg6kR+HE4M3dBvtUnl3EDE95Kk5DsV8VuEPyUP9BP
 nVgDsQ/HzmyXY4CiIGcJ4jDbkARISh7ESX+hdzTxFSsA+w9jLN2+A6q4ojEGwFRoutOeQB
 kbPaWPypKqFkpQbX225LuI7XgmI+rW4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-Gb7mg_09NfW-KJ8xvUi7OA-1; Fri, 23 Oct 2020 04:06:34 -0400
X-MC-Unique: Gb7mg_09NfW-KJ8xvUi7OA-1
Received: by mail-wr1-f70.google.com with SMTP id u15so306303wrn.4
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 01:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V08BVp0omfUQxfrM0QXR93eKxkkj0/clyzjQCD16s3U=;
 b=Evkb2/5LW09AW26e3mQ+1pr6fBuDO2I50Z6dLzWiXeEoXVhJOhjFOO7kbFpq9FLQcc
 jt9DyN/ICKE9aSExz5tBq5HlUY2Q2DqkzVsKfYCaB7pzkqPZOztat7kukxF5an8dicui
 t3swQslt46n9eQvttla4K/1LLKRCkMNRM38oalzczhf+cMtIuWBo13JmaXsvAEvZAB7E
 cOPhT3+L2EWLXrviyUk3TOSh9DLa054XUgiKyVUHPLerbQ8Y09j7vjub4HZ2tRTcgJkn
 C7kmfotYc6NI77K70DOzxNtSTpVGELKM16Ua1bdG7DxpUokNpDT8+Ahnx+1czlqmNPCz
 UmSA==
X-Gm-Message-State: AOAM531S7DdEaiVn6yckPGnaazdPHTLGVw4qCVC7Dyv3YYBhbFi187m9
 sVyyFxso0w5AMdQsOiMhZGMA1F/5qhR728DesJBj7xylfYj+/V9tVaU81BhUw0Z2nNAfgLFLuP5
 Nly2fRJVSePqLoh8=
X-Received: by 2002:adf:ee44:: with SMTP id w4mr1313909wro.114.1603440393379; 
 Fri, 23 Oct 2020 01:06:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3E24pXGGgRHYkxqEkNQdFsrjjeQompue0WHRsWbKZXWJXMSrLDubxJg3vJ9nayM1S3l56Ag==
X-Received: by 2002:adf:ee44:: with SMTP id w4mr1313894wro.114.1603440393193; 
 Fri, 23 Oct 2020 01:06:33 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id g83sm1559804wmf.15.2020.10.23.01.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 01:06:32 -0700 (PDT)
Subject: Re: [PATCH 3/4] tests/acceptance: Enable AVOCADO_ALLOW_UNTRUSTED_CODE
 in the gitlab-CI
To: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201023073351.251332-1-thuth@redhat.com>
 <20201023073351.251332-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3290ef69-1d0f-290b-2174-503babfcf649@redhat.com>
Date: Fri, 23 Oct 2020 10:06:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023073351.251332-4-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 9:33 AM, Thomas Huth wrote:
> The tests are running in containers here, so it should be OK to
> run with AVOCADO_ALLOW_UNTRUSTED_CODE enabled in this case.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .gitlab-ci.yml | 1 +
>   1 file changed, 1 insertion(+)

Thanks :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


