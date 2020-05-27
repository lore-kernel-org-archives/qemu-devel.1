Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D701C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421602078B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sfky8I/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421602078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxRX-0008O5-Ef
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdxQl-0007OX-E2
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:53:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41485
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdxQj-00067D-PD
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590591195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/rHDaFadDN4dwN9iPwmVYCAw4liEeBbFDTXaKdUjBF4=;
 b=Sfky8I/yluruoquX5k3wY0WCUOJLzBeKQ9j0WfMQSvHpTIOCUL+pYwpGsNlutGvCM5NH3u
 e1YvemVhQMgiIFF1iJPWjHY9YFsIjBJ7yvsBTetqn0d7aXczEkRGrpj3Ininn52BqfHga6
 4jNOmpU+FIfuusQ8MWFVerOBW2Du9+Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-1kX9HiCWMXmeK1iOcyyIzA-1; Wed, 27 May 2020 10:53:13 -0400
X-MC-Unique: 1kX9HiCWMXmeK1iOcyyIzA-1
Received: by mail-ed1-f70.google.com with SMTP id bo26so10131161edb.22
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/rHDaFadDN4dwN9iPwmVYCAw4liEeBbFDTXaKdUjBF4=;
 b=eRBPq0oN1SJ3zp/ywJtzC8l0g0248Rf/nzXL+QrWTrNvecHelN4YxOEIokzyxKRJPN
 BySALN814MSGoO0ySZUZ84z0KiyXmWq27hxU5E16ous71pErgoSLDk0+oiUX4oDbDIMk
 NNcBUL1x1JL7R1kylIvx5poYBGk4L1DLhV9HW9S9vCuQKRc58huBUfu6g8KGcKHsGXpq
 TiTS2YYOaXbbKGNnSpwEQ8L2nN282CGxP3pdZt71ulsoxFEzv6iHWr/lfvMaoEQW3YLu
 uAiGiLvNCI12rG/L4UA2rg5QewHBz0n47PN2DWeJP8co0W0dvcFF1nmOAz9Y2JFBB5/p
 BGlQ==
X-Gm-Message-State: AOAM530f06UY3DziIyA+owx+d+/ti5xfR2ooXfAqY9PIYz0UpPOuTonb
 vIJ3FQX0BwIm1CFcEkGhcHE4F3PK4S6K3SbPRDxrR23bmZHa/F5hmcCjq94P1wAQlhwAxTLPm7G
 880bP7kem1qO9+q8=
X-Received: by 2002:a50:afa2:: with SMTP id h31mr2092099edd.213.1590591192762; 
 Wed, 27 May 2020 07:53:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHM1YtUFPSu9XGyzHKo657UnGN+ALp+wa2qcYTegL5RxQnsjD2ALcwWyG/A4cUyhGtidNdHA==
X-Received: by 2002:a50:afa2:: with SMTP id h31mr2092073edd.213.1590591192492; 
 Wed, 27 May 2020 07:53:12 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id qn17sm2914144ejb.125.2020.05.27.07.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 07:53:11 -0700 (PDT)
Subject: Re: [PATCH v2 04/11] tests/acceptance: add kernel record/replay test
 for x86_64
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057546117.16818.15607496040935344350.stgit@pasha-ThinkPad-X280>
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
Message-ID: <1510a96e-2768-32c9-44f5-465ed9b0d859@redhat.com>
Date: Wed, 27 May 2020 16:53:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159057546117.16818.15607496040935344350.stgit@pasha-ThinkPad-X280>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: wrampazz@redhat.com, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru,
 crosa@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 12:31 PM, Pavel Dovgalyuk wrote:
> This patch adds a test for record/replay an execution of x86_64 machine.
> Execution scenario includes simple kernel boot, which allows testing
> basic hardware interaction in RR mode.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  0 files changed
> 
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> index b8b277ad2f..c7526f1aba 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -55,3 +55,19 @@ class ReplayKernel(LinuxKernelUtils):
>                      True, shift, args)
>          self.run_vm(kernel_path, kernel_command_line, console_pattern,
>                      False, shift, args)
> +
> +    def test_x86_64_pc(self):
> +        """
> +        :avocado: tags=arch:x86_64
> +        :avocado: tags=machine:pc
> +        """
> +        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
> +                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
> +                      '/vmlinuz')
> +        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
> +        console_pattern = 'Kernel command line: %s' % kernel_command_line
> +
> +        self.run_rr(kernel_path, kernel_command_line, console_pattern)
> 

This one timeouted (I build with --enable-debug):

 (1/1) tests/acceptance/replay_kernel.py:ReplayKernel.test_x86_64_pc:
replay: recording...
replay: replaying...
INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
reached\nOriginal status: ERROR\n{'name':
'1-tests/acceptance/replay_kernel.py:ReplayKernel.test_x86_64_pc',
'logdir':
'avocado/job-results/job-2020-05-27T16.48-71d7bf4/test-results/1-tes...
(90.68 s)


