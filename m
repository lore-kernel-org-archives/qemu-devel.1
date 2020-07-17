Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081A2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57BD20691
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmtHefHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57BD20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwSKs-0006Sg-0v
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jwSJp-0005sX-M6
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:30:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jwSJm-0006t0-Qt
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594999833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7RpVnQ6ZZ6dlWV8CePWkjA1hbCvX5kWsOOkkParpKjs=;
 b=HmtHefHf+nQFKkTMdaUxPpuPY4R8s7uPf5/FJUj6Uf4rkaozu9sYNQwq/j1dq4lsJgEEVf
 F6pem45mBUyseAtA6fDRLhpGhMCNK9w85CFUnKQnQiHeGOazcKEI7HrJc12tldl2s94d7U
 agimD2MPPJG9vtrlcjmKVG5yOsCiMIk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-CygeNArGM6eLKyAkns1WYA-1; Fri, 17 Jul 2020 11:30:31 -0400
X-MC-Unique: CygeNArGM6eLKyAkns1WYA-1
Received: by mail-ed1-f69.google.com with SMTP id u25so6171262edq.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 08:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=7RpVnQ6ZZ6dlWV8CePWkjA1hbCvX5kWsOOkkParpKjs=;
 b=hQyk0qTUV2TLAEiv1CxTsJUzdi1UEcoN5N/6vFFnZwYwJR6nq8M9oQjC9VemPxdhue
 pinefiUfGSSyEj1FC86na2lCUkU6EmCB1UlpRouvpPwnvtyKc4tPlS29FsouBwawN/+3
 GHnCqDP1jw997FF0t9Yxq252fRivT/VBH/M2u9YFI9kzkvFsatbxkYgESraasn5M7ILi
 +HLSIg50aFDZa3thoV++vxg3sQwuzMeuddA9Eg3PMpYL1J1F9XX+S5Sns1B/9RlsxoF/
 hjDTr1edSecWhiWz8cG/T1ouWzjS9C+3rY+d/9sgIMitQ/f3SRdkJoVFWRk6ii0XNPDg
 GC1g==
X-Gm-Message-State: AOAM532Nv2uiiSlzdpc8TH4HT6t981sDuWAFG+0b6lxv6kKUBkzrEXtf
 CyAjcuXlPr38/AJ7fESHAzb0lgkrk1S5Bo3GLWa5d0UzUnBo2bDl6NTPM5B8ImeMq+H0p9qbKYw
 RurhKT2Ao6525/iA=
X-Received: by 2002:a05:6402:543:: with SMTP id
 i3mr9428759edx.182.1594999829910; 
 Fri, 17 Jul 2020 08:30:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfJ5946NuO8EYBdcqlrzyT36EL5bKAY3+RO92LnnR0YAfGb2JGc2OKsik750/to3ufDM7F3Q==
X-Received: by 2002:a05:6402:543:: with SMTP id
 i3mr9428734edx.182.1594999829528; 
 Fri, 17 Jul 2020 08:30:29 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id y22sm8544256edl.84.2020.07.17.08.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 08:30:28 -0700 (PDT)
Subject: Re: [PATCH for-5.1] Makefile: Remove config-devices.mak on "make
 clean"
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200717152508.10272-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <6b2ea83f-2dbb-5ba1-8151-b275b80b3644@redhat.com>
Date: Fri, 17 Jul 2020 17:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200717152508.10272-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 5:25 PM, Peter Maydell wrote:
> The config-devices.mak files are generated by "make", and so they
> should be deleted by "make clean".
> 
> (This is different from config-host.mak and config-all-disas.mak,
> which are created by "configure" and so only deleted by
> "make distclen".)

typo "distclean"

> 
> If we don't delete these files on "make clean", then the build
> tree is left in a state where it has the config-devices.mak
> file but not the config-devices.mak.d file, and make will not
> realize that it needs to rebuild config-devices.mak if, for
> instance, hw/sd/Kconfig changes.
> 
> NB: config-all-devices.mak is also generated by "make", but we
> already remove it on "make clean".
> 

Suggested-by: Paolo Bonzini <pbonzini@redhat.com> ?

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I didn't remove the existing 'rm -f $(SUBDIR_DEVICES_MAK)'
> from the 'distclean' rules on the basis that config-all-devices.mak
> is explicitly removed in both 'distclean' and 'clean', despite
> 'distclean' depending on 'clean'...
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index 32345c610ee..c2120d8d48d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -775,6 +775,7 @@ clean: recurse-clean
>  	rm -f storage-daemon/qapi/qapi-gen-timestamp
>  	rm -rf qga/qapi-generated
>  	rm -f config-all-devices.mak
> +	rm -f $(SUBDIR_DEVICES_MAK)
>  
>  VERSION ?= $(shell cat VERSION)
>  
> 


