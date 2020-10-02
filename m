Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964EFC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 09:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23102068E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 09:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UONWntPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23102068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOHCB-00027V-Sx
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 05:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOHAy-0000gL-2o
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 05:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOHAv-000877-K6
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 05:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601630184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0IunIFTvaLpk9IaEJfln833ty6W63cGRgjBvzkBoavk=;
 b=UONWntPM8FIPi9D+VLZoEA2Nb2vEDqfZQM6yrgjTqUZKl78ur3GowE3g18+0mJThrNGlem
 yNTLWQSNKrZcPEdtkLEectNHG+m5USwaByoF5mxpOoFeVGUD5EBZNu1nRCopNVgMFt4Jsf
 ggLYtNvgglzxXZYtRjI4actMjsxxOrU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-5pUCmwL8MkKdp2zgm7E93Q-1; Fri, 02 Oct 2020 05:16:22 -0400
X-MC-Unique: 5pUCmwL8MkKdp2zgm7E93Q-1
Received: by mail-wm1-f70.google.com with SMTP id m25so325459wmi.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 02:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0IunIFTvaLpk9IaEJfln833ty6W63cGRgjBvzkBoavk=;
 b=STHVL23A3WV0Q+o3BQ/o+1dFwU4RFW1na1GBFz6rcQvTTIn+D9QfxUKFilPV+b03Y1
 eRLKb6lkHjrxoq1x7t92onv/1JwNQTiEWg1t6WpK81oxrG4I7IibNKuDjlcUErgoilQd
 OMc+dKTG/dnPMJz8jHe6D8sK6SdMhjyLdYm3t3XZ7WEL/MI+qssycKzIl9dsoQ/MZUmU
 v4qdhTJg+UGCeJcu2CQPsS05MvKVQMGyffO1eeXDtDm/ec6scZooVCgGQIj5Z1VYCKnS
 qzBaTXLSrtJlGe0Ok4LWNluEzpT7xOXecfmHNzaHegqipZ988GcpSsEAN0tQg0IQFdLT
 HoDA==
X-Gm-Message-State: AOAM5311R9VZodu7lREJqUgBijnBhkDA82DptRdefejSvaf48d73jcEi
 0hubNlCUl+9X7457Kh1vKzv4xHaJqxkYo6H4pUd3MTaJ645TbjaAmCLYQrpTddB7v8cLTSf9uej
 Tltywfm9KxvOeqG8=
X-Received: by 2002:adf:f44d:: with SMTP id f13mr1867506wrp.224.1601630181816; 
 Fri, 02 Oct 2020 02:16:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0YsfHA7pvrHKKwT/64v+NyrDkkaXK1fukREFs0CpARJKdK8wstKXK21AXAEYNLT6xxfnfyw==
X-Received: by 2002:adf:f44d:: with SMTP id f13mr1867485wrp.224.1601630181653; 
 Fri, 02 Oct 2020 02:16:21 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id s11sm977007wrt.43.2020.10.02.02.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 02:16:21 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] qapi: Restrict code generated for user-mode
To: qemu-devel@nongnu.org
References: <20201002073621.1653924-1-philmd@redhat.com>
 <20201002073621.1653924-2-philmd@redhat.com>
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
Message-ID: <688d25a9-7980-8626-2c1b-0006707bb1de@redhat.com>
Date: Fri, 2 Oct 2020 11:16:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002073621.1653924-2-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 9:36 AM, Philippe Mathieu-Daudé wrote:
> A lot of QAPI generated code is never used by user-mode.
> 
> Split out qapi_system_modules and qapi_system_or_tools_modules
> from the qapi_all_modules array. We now have 4 groups:
> - always used
> - only used by system-mode
> - not used by user-mode
> - not used by tools
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  qapi/meson.build | 51 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 15 deletions(-)
> 
> diff --git a/qapi/meson.build b/qapi/meson.build
> index 7c4a89a882..10cf01ef65 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -14,39 +14,60 @@ util_ss.add(files(
>  ))
>  
>  qapi_all_modules = [
> +  'common',
> +  'introspect',
> +  'misc',
> +]
> +
> +qapi_system_modules = [
>    'acpi',
>    'audio',
> +  'dump',
> +  'machine-target',
> +  'migration',
> +  'misc-target',
> +  'net',
> +  'pci',
> +  'rdma',
> +  'rocker',
> +  'tpm',
> +  'trace',
> +]
> +
> +qapi_system_or_user_modules = [
> +  'machine', # X86CPUFeatureWordInfo
> +  'qdev',

I forgot the justification for this one:

     'qdev', # DEVICE_DELETED

> +]
> +
> +qapi_system_or_tools_modules = [
>    'authz',
>    'block-core',
>    'block',
>    'char',
> -  'common',
>    'control',
>    'crypto',
> -  'dump',
>    'error',
> -  'introspect',
>    'job',
> -  'machine',
> -  'machine-target',
> -  'migration',
> -  'misc',
> -  'misc-target',
> -  'net',
>    'pragma',
> -  'qdev',
> -  'pci',
>    'qom',
> -  'rdma',
> -  'rocker',
>    'run-state',
>    'sockets',
> -  'tpm',
> -  'trace',
>    'transaction',
>    'ui',
>  ]
>  
> +if have_system
> +  qapi_all_modules += qapi_system_modules
> +endif
> +
> +if have_system or have_user
> +  qapi_all_modules += qapi_system_or_user_modules
> +endif
> +
> +if have_system or have_tools
> +  qapi_all_modules += qapi_system_or_tools_modules
> +endif
> +
>  qapi_storage_daemon_modules = [
>    'block-core',
>    'char',
> 


