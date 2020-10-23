Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C07BC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B54E20704
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVXsvLGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B54E20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVs8f-00035y-97
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 04:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVs5U-0007hf-Ch
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVs5S-0006Ni-0a
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603440367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kjGCHtsRxV39syqhm4jalNJx7Y5lR3W0xXXv+P/xoA=;
 b=ZVXsvLGWMGyqFAhqm+Rla589DwNevksIxrOMm3n2ypFmug+AikDco3HB1civZAsKH+osOV
 x9vbW625F3I8Mfc3wMuBu964hKytR3JzpOp+3qnTnfjh26XzARCWL+eJmQEHp7lvYTCdWj
 pY4su3arvNMW9Wxn+eNsbs/Fu5bmEzs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-cSYUN7YWPw27t2130Q5p2g-1; Fri, 23 Oct 2020 04:06:05 -0400
X-MC-Unique: cSYUN7YWPw27t2130Q5p2g-1
Received: by mail-wm1-f71.google.com with SMTP id y83so78180wmc.8
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 01:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/kjGCHtsRxV39syqhm4jalNJx7Y5lR3W0xXXv+P/xoA=;
 b=i1t9bNuZc2EJpbFOAla4Tq09+FPjGGwd1YW4e6ZHESdyoVgA28ipcSpOI13ZIwy+Ko
 cE0nrYK+R0CIF22nZqGHMUi34k6ETsaCuCkdR6sEKMevg2gACnhQZrxjufQu+5eOAF16
 gRPL2GN5xs4sHQVW46spfi89VosGQUJD82+Sdalvv8MU8vcMdzeZKIVoP7gGTTm2npja
 ltRqF67g54svRVn3Nww0+yGAvApqdzPcXCO9J7cgNIfoxh1rPWnogLZKb5zR3RU/j2ZJ
 i/xRSdHWLQdxJ1niHM074Lov2kuaA115xjRHhLFgpMnJjThLioW+Sw1aLZV/E52/xcAy
 HnEA==
X-Gm-Message-State: AOAM530P7JXEVIaG/JOQ48YFFTGKAAACAs23E+41PocDLcSTjNg3SbS3
 /9LddrWqM250AfIj2OzncZyQ4GlNsuZoU29cuIJSylVBgnL0dNC9f4pEEZmH0CWCI/IzPgs+TH0
 UzIjyCfTHjvqdWq8=
X-Received: by 2002:a5d:4282:: with SMTP id k2mr1197924wrq.270.1603440364461; 
 Fri, 23 Oct 2020 01:06:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrRaaRtM+KSYB3HQy6w4YekV1mC3Bo3ySe80ANBTJ2fzw//zW9ysEFs8alKj2LYSCDMwPzkA==
X-Received: by 2002:a5d:4282:: with SMTP id k2mr1197914wrq.270.1603440364344; 
 Fri, 23 Oct 2020 01:06:04 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id v189sm1570946wmg.14.2020.10.23.01.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 01:06:03 -0700 (PDT)
Subject: Re: [PATCH 2/4] test/acceptance: Remove the CONTINUOUS_INTEGRATION
 tags
To: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201023073351.251332-1-thuth@redhat.com>
 <20201023073351.251332-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3b7aa6a8-77b3-ee21-dc3a-fd3ad2f64e50@redhat.com>
Date: Fri, 23 Oct 2020 10:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023073351.251332-3-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
> We are not running the acceptance tests on Travis anymore, so these
> checks can be removed now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/acceptance/ppc_prep_40p.py | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


