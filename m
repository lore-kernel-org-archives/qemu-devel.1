Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20BFC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2553821D7D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5sC0aVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2553821D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzxT-0002xr-0y
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFzwT-0001ye-Nt
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:15:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFzwR-0003R5-VI
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599657314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TtbhIOhwYheu10IyWI3FzMffOUeVDNCjiCfuzmqJcRo=;
 b=e5sC0aVjZn0KbIBg0+lxl6Uw+ZycSXKTQMS2holCZsuZq+cXnC5fx3M0IBvWUi4BasHyik
 J/aeBQxQ8dinpkCbPcnVA2U/ECfvtwo6AfcQLeyVCuj0aFj0G4DSjCsFcXnR6BrMrowH+o
 MS55A9gaRVzUTZnsQAID0RiDkl82TxY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-mSBf-iclN5-0DA-v-snRSg-1; Wed, 09 Sep 2020 09:15:12 -0400
X-MC-Unique: mSBf-iclN5-0DA-v-snRSg-1
Received: by mail-wm1-f69.google.com with SMTP id a144so814382wme.9
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 06:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TtbhIOhwYheu10IyWI3FzMffOUeVDNCjiCfuzmqJcRo=;
 b=img0dDYiVwk/ar1u9BQV9wrGcdmB6CDf3IQsQJkrNTb6IOF2gYYhozPvoucJJbByQs
 7lYZlP41fEftkByEYY6lTAQDwH/KWVX71FLVsp79LrQBZNhQeRrNTHLkH+xhCb69xFTt
 30oAH5zmA10DFfKhkkxAMETCYHzeacBstg5Nhsi/ScDa4szA4Ur8Sgxgm27LWatO2Rtk
 dRhRisz8E4vAyPP4PVwuKY4jIXWDi67I20bJY2dI6eYawNwro1BD9IZCOBqw6Mvo1CcK
 a8fJx0yvfE65dOhnKSqcSiw9tPSZeiFtBixErlC0H7vc8zQ18Zb2wKOfV6fiIQ7hYxhm
 +VMg==
X-Gm-Message-State: AOAM533aixhJFLkmcJj0W6qrbb0z+PXa5lDaZfDErqkNeo06yP4uRMnK
 fPFyCFTeDkLB+X0Dpcfp5GcWtmBxi2ZfjlNYlgoWE8BQkapmb3qi6F2zOGkCZAeITPQzUuFZxd8
 xSgAc/EbUE+WLGHo=
X-Received: by 2002:a1c:2903:: with SMTP id p3mr3678801wmp.170.1599657311775; 
 Wed, 09 Sep 2020 06:15:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwNp6S9SojJ9Rl4kcRYeOP2BEDAmXX8bZs2UHZ+FcPOX0TdryhsJm+WVFv5YS2+dzCrGyiiw==
X-Received: by 2002:a1c:2903:: with SMTP id p3mr3678789wmp.170.1599657311608; 
 Wed, 09 Sep 2020 06:15:11 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v204sm4076363wmg.20.2020.09.09.06.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 06:15:10 -0700 (PDT)
Subject: Re: [PATCH v3 2/8] configure: always /-seperate directory from
 qemu_suffix
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20200826110419.528931-1-marcandre.lureau@redhat.com>
 <20200826110419.528931-3-marcandre.lureau@redhat.com>
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
Message-ID: <bfe25907-88ef-05ad-0464-1220c37439e2@redhat.com>
Date: Wed, 9 Sep 2020 15:15:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826110419.528931-3-marcandre.lureau@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: sw@weilnetz.de, berrange@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/26/20 1:04 PM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 

Typo "separate" in subject.

Btw can you copy the subject in the commit description?
This makes review simpler (no need to go back in the
thread view to see the subject and go back into the
mail to see the content).

> Otherwise, we may accept very strange directory names...
> 
> While at it, quote the variables.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/configure b/configure
> index 0e04c47722..61216b9210 100755
> --- a/configure
> +++ b/configure
> @@ -474,7 +474,7 @@ modules="no"
>  module_upgrades="no"
>  prefix="/usr/local"
>  firmwarepath="\${prefix}/share/qemu-firmware"
> -qemu_suffix="/qemu"
> +qemu_suffix="qemu"
>  slirp=""
>  oss_lib=""
>  bsd="no"
> @@ -1823,12 +1823,12 @@ Advanced options (experts only):
>    --with-git=GIT           use specified git [$git]
>    --static                 enable static build [$static]
>    --mandir=PATH            install man pages in PATH
> -  --datadir=PATH           install firmware in PATH$qemu_suffix
> -  --docdir=PATH            install documentation in PATH$qemu_suffix
> +  --datadir=PATH           install firmware in PATH/$qemu_suffix
> +  --docdir=PATH            install documentation in PATH/$qemu_suffix
>    --bindir=PATH            install binaries in PATH
>    --libdir=PATH            install libraries in PATH
>    --libexecdir=PATH        install helper binaries in PATH
> -  --sysconfdir=PATH        install config in PATH$qemu_suffix
> +  --sysconfdir=PATH        install config in PATH/$qemu_suffix
>    --localstatedir=PATH     install local state in PATH (set at runtime on win32)
>    --firmwarepath=PATH      search PATH for firmware files
>    --efi-aarch64=PATH       PATH of efi file to use for aarch64 VMs.
> @@ -6467,9 +6467,9 @@ EOF
>      fi
>  fi
>  
> -qemu_confdir=$sysconfdir$qemu_suffix
> -qemu_moddir=$libdir$qemu_suffix
> -qemu_datadir=$datadir$qemu_suffix
> +qemu_confdir="$sysconfdir/$qemu_suffix"
> +qemu_moddir="$libdir/$qemu_suffix"
> +qemu_datadir="$datadir/$qemu_suffix"
>  qemu_localedir="$datadir/locale"
>  qemu_icondir="$datadir/icons"
>  qemu_desktopdir="$datadir/applications"
> 


