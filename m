Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1496C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671862078A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUfd4W9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671862078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFfZ-0001lH-9B
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFdI-0000E7-HG
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFd9-0003n8-HN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602577558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v306TqnF7HXk0HKnjsdHRqJr7uLHQb9XkMbp84g3/Fw=;
 b=gUfd4W9ldf8EKVYNXFpvFdYXB+iPiAuoP+Gw+qeKTMSki1ac2kpoZdJqnPBWiXNgXBGv0F
 1UUbCzw8looBk+sx14aIMmFtRN2s7YCwxBuBbBMik7bY1YizyQIw9/WvxiX1kfVgvZs39a
 4JE4KaO0EE05ancgjhfUn9q5o1WnooA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-xNNtcwvSNCynPAE2bPBJ-w-1; Tue, 13 Oct 2020 04:25:57 -0400
X-MC-Unique: xNNtcwvSNCynPAE2bPBJ-w-1
Received: by mail-wr1-f72.google.com with SMTP id k14so9829149wrd.6
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 01:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v306TqnF7HXk0HKnjsdHRqJr7uLHQb9XkMbp84g3/Fw=;
 b=lNO5rP5lRSZGbJfvGGLAj2Uhanjwi/+9q4835a/zUatvE2spZaxmGl8hwiSM/31kIa
 GamoOliWiMrCN56iQgnDuxX3RcQjmHCkcL/VOKsl5QdeftNZuF6HkBOhzuhYxw8FtqF/
 tCCb0zjas3GWRSZ17yjXUdccS0b4JdYBL28ojtpKZhw/9gUxgBQc7qKgOAlHER4qsUoV
 pMcUqX92qs1tn630Y52bMzkWYoNmQlXAdol/TzmJkaigRmgI9rgwdkIAY0EopRvr7rkr
 naSd5J7tGUcgDeV0mAasNgxiw5/j9dkF1RHmpRyOecysHxyb/bMuoZlC/j3zOTIfrFcb
 i1CQ==
X-Gm-Message-State: AOAM531oZmhqG2A4AQOMB7f7XieYxcd+b8LgrHsscO5KJBmEak5LOVWy
 Nq68BR2lcEHOsifhs8r/6Qy7dc6nwEnWkACctguClqtbtStj0BWFK9goXDBSSBu7IgzbFXPgUMX
 rsyHWzW9lL5WvAY8=
X-Received: by 2002:a1c:c2c5:: with SMTP id
 s188mr14892041wmf.174.1602577555919; 
 Tue, 13 Oct 2020 01:25:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5uoDXTpD1OsT4adsCoW0EpcY6U11jd/lmRWXV7dQVqe9krxgU1I8MW5MKiU/QRrOtCbVR3w==
X-Received: by 2002:a1c:c2c5:: with SMTP id
 s188mr14892025wmf.174.1602577555765; 
 Tue, 13 Oct 2020 01:25:55 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id k190sm25785051wme.33.2020.10.13.01.25.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:25:55 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] unbreak non-tcg builds
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20201012214527.1780-1-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d32be762-ece9-c9cb-1bdc-3d7e65c5a7bc@redhat.com>
Date: Tue, 13 Oct 2020 10:25:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012214527.1780-1-cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 11:45 PM, Claudio Fontana wrote:
> This series now unbreaks current non-tcg builds
> (!CONFIG_TCG).
> 
> tests Makefiles need to avoid relying on all non-native
> archs binaries to be present,
> 
> bios-tables-test needs to skip tests that are tcg-only,
> 
> and notably the replay framework needs to consider that
> it might not be functional (or its code present at all)
> without TCG.
> 
> Tested ok target x86_64-softmmu on x86_64 host with:
> 
> ./configure --enable-tcg --disable-kvm
> ./configure --enable-kvm --disable-tcg
> ./configure --enable-tcg --enable-kvm
> 
> running make check-qtest

If you want to avoid these configurations to bitrot,
please cover them adding Gitlab jobs.

Thanks,

Phil.


