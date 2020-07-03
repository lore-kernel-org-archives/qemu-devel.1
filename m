Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4201AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0722070C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFG9AFVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0722070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrGwc-0001w0-A0
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 04:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrGw3-0001MQ-15
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:20:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54032
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrGw1-0003LA-IX
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593764436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Vz2eU+RvowEKLnwzfla0N/b+laKD2SzlguG4+dRzxdM=;
 b=NFG9AFVH6Hh/K9Q2Ik2PIOs1JMPAn2C9plFqhcm2dQiWFCcqiErdHN+tou+nVmFqqQwyxy
 6w9/d/Jjd9+s9+HeWzerTtECKFjicuAC3dTBsT/Kk3vw0RhgYD+XKXoYeha07RQ0bLi3xM
 oZYUfajE4Bj9eC1VEJotf/1DXRqTaag=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-_bOW1-RRPeulb4oivkJsvg-1; Fri, 03 Jul 2020 04:20:32 -0400
X-MC-Unique: _bOW1-RRPeulb4oivkJsvg-1
Received: by mail-wm1-f69.google.com with SMTP id h25so20538862wmb.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 01:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Vz2eU+RvowEKLnwzfla0N/b+laKD2SzlguG4+dRzxdM=;
 b=nIVeU8k7CFx2tnf5GG77vY7W39J/XPK/LnwomcptfRoHnyyEn0u34G7NowUSDb2M2T
 3IRaR5jSUkZ9uiB/yVvVW41bby5VeEBo9v0Z2RqZ3MXDMuyLUw9Z/TBA+kGpMYApMpqV
 YfTEefT8aU7XWWXf3ZM1GqOBXpnoYC6MvBH6wL0xj3LJDK5lzy1XC7TZTYDhfuzNhUND
 +cPCcFTDJjj7nzHGvo3fhCoySNr61XUv0owLyqiOv95ecmoxSimxtPMTExO7+jjr0Tac
 rhV2f07R8BIE7ax03YZhoLkeVGuxvuv44v1V5hRciBksb+kPTgPkRzVLsSAaX/x4pzrl
 AAzQ==
X-Gm-Message-State: AOAM533UnpBUF69qGPwgE31YmjUpWDLuNoMskeqnJ1B5bwWtYooeAlFY
 h3psp2kNSpHb6F2JL3S6B67Y6HwTK2g8je2BSt0Whq+0k07pA74las3S2ZWyaVZ/Og3M6zOEJCM
 XtQgKvOx9w9MFky4=
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr24433841wrw.10.1593764431852; 
 Fri, 03 Jul 2020 01:20:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcD8kCJIEllq93UojSSJeev6oBlojbqbxC0qzE5+vjG1MgkmJxy+UvrlxlufvmOAsU19kK0g==
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr24433823wrw.10.1593764431664; 
 Fri, 03 Jul 2020 01:20:31 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u10sm12621199wml.29.2020.07.03.01.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 01:20:31 -0700 (PDT)
Subject: Re: [PATCH v2 15/18] hw/block/nvme: reject invalid nsid values in
 active namespace id list
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200703063420.2241014-1-its@irrelevant.dk>
 <20200703063420.2241014-16-its@irrelevant.dk>
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
Message-ID: <6a038075-13fd-2f60-23a2-ddc7081cff32@redhat.com>
Date: Fri, 3 Jul 2020 10:20:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703063420.2241014-16-its@irrelevant.dk>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 8:34 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Reject the nsid broadcast value (0xffffffff) and 0xfffffffe in the
> Active Namespace ID list.

Can we have a definition instead of this 0xfffffffe magic value please?

> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 65c2fa3ac1f4..0dac7a41ddae 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -956,6 +956,10 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>  
>      trace_pci_nvme_identify_nslist(min_nsid);
>  
> +    if (min_nsid == 0xfffffffe || min_nsid == NVME_NSID_BROADCAST) {
> +        return NVME_INVALID_NSID | NVME_DNR;
> +    }
> +
>      list = g_malloc0(data_len);
>      for (i = 0; i < n->num_namespaces; i++) {
>          if (i < min_nsid) {
> 


