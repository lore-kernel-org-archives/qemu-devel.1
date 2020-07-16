Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25482C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C2720760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcRkEAuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C2720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw1Hn-0005cz-NP
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jw1H1-0004x8-2f
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:37:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58716
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jw1Gy-0002fJ-Km
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594895871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BYjWkP3u+XdxqsChSNuWqjmicIzaj3jbg3cBmthFANk=;
 b=gcRkEAuz3h7aQvDbrNuJszRMnCG9lBqsKY8zExnUXb8WjEN3mN9plA3ZxCPvxZkCZkaAjQ
 WZ6mn5974YXX78VLVATlFjOSOILMR1amAuSCpH7POGGd1kb6X+IeqnI4g5ciaw9p4/i0IU
 Dm4IqyLFE0z6P50ePEo7wJne4K4Rv7k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-cNzBtqNUMju3zRNTGGPxbw-1; Thu, 16 Jul 2020 06:37:49 -0400
X-MC-Unique: cNzBtqNUMju3zRNTGGPxbw-1
Received: by mail-wr1-f69.google.com with SMTP id y13so5354759wrp.13
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 03:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=BYjWkP3u+XdxqsChSNuWqjmicIzaj3jbg3cBmthFANk=;
 b=E63dmjG1kZ6SW/x8M0YEBsprUZevadnscm2deTE1uPoaOYxMYuAa5Ju9+boiM4TeRr
 khC6HJoDIV2ncy/OMyBk5VL27Kt3XpNQSzbqPrv8p+0pL174ABBet6WSVx4Pvk4noAdE
 FKPxSBBfD3CRExK4SMdbWA3xClHOXWaF6gTBmmQHTD6rwPSMmIp/u2vvIXbLXta5Un7C
 PZlIU871sCAhong+zKwVTDIYvb2YWUdHwMNXl6LMEwvQRLBNyVUznwKveoDZRwMfPraY
 wRFASmbh+Os83nizohoyNXjRPMU3JyK5kodtpIC+Nl3VCkRQDH06R8vRCVow4zXmuNOE
 ytFQ==
X-Gm-Message-State: AOAM532sBlXdWnfoQY7/IKAQ4SxF91FU9F+ofJTWhXFWYhAjROf6IJu4
 Rj7FqB513eMpcihZwa2bMAhMvnQtyvbWmI4vV+kqAck99NPCCUMpHknofxWgmJykrOd46nRPj2r
 nhFro92H85ya7eqM=
X-Received: by 2002:a05:6000:1cf:: with SMTP id
 t15mr4775474wrx.180.1594895868553; 
 Thu, 16 Jul 2020 03:37:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNLiN2vTQwV1Gl7lhfFA7jkf8yO+2QtFnxJ9EKo3dcOW1rqG9B0dZhQxKOOY+j4PTOAcDETQ==
X-Received: by 2002:a05:6000:1cf:: with SMTP id
 t15mr4775459wrx.180.1594895868330; 
 Thu, 16 Jul 2020 03:37:48 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id m2sm8322638wmg.0.2020.07.16.03.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 03:37:47 -0700 (PDT)
Subject: Re: [PATCH] virtiofsd: Remove "norace" from cmdline help
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20200716101442.48057-1-slp@redhat.com>
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
Message-ID: <b0c32bdb-908e-9c8e-f1a9-131d373e9be7@redhat.com>
Date: Thu, 16 Jul 2020 12:37:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200716101442.48057-1-slp@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
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
Cc: Miklos Szeredi <mszeredi@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/20 12:14 PM, Sergio Lopez wrote:
> Commit 93bb3d8d4cda ("virtiofsd: remove symlink fallbacks") removed
> the implementation of the "norace" option, so remove it from the
> cmdline help too.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  tools/virtiofsd/helper.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 3105b6c23a..7bc5d7dc5a 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -159,8 +159,6 @@ void fuse_cmdline_help(void)
>             "    -o max_idle_threads        the maximum number of idle worker "
>             "threads\n"
>             "                               allowed (default: 10)\n"
> -           "    -o norace                  disable racy fallback\n"
> -           "                               default: false\n"
>             "    -o posix_lock|no_posix_lock\n"
>             "                               enable/disable remote posix lock\n"
>             "                               default: posix_lock\n"
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


