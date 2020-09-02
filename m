Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3548C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9285D207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwPp1J8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9285D207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWeG-0003Ut-Ir
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDWcM-00023S-Am
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:32:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52673
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDWcI-0004Md-WF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599067933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6dmK/kAGlF8J5ucJAKyYPw9giIfOymzeGc05m1YO+WY=;
 b=XwPp1J8C3GDRnCCqJO9dBTGEmLZr/W+PnMBVW6gOBgwTuy+NB6Npdpvrfy9TC0Tn7opZvN
 7FJd0MwpP8NaHoK0mTxfXtpVYGQk984LY+hOnv8qA+EvbWSNhRtDCfq4RuFFeYOp7t2hb1
 MV4WlOVDzz8KHpaN61EJJykLShiNamM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-XxcU1-VtNSST59FKHfTNVg-1; Wed, 02 Sep 2020 13:32:11 -0400
X-MC-Unique: XxcU1-VtNSST59FKHfTNVg-1
Received: by mail-wr1-f72.google.com with SMTP id l17so2332346wrw.11
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6dmK/kAGlF8J5ucJAKyYPw9giIfOymzeGc05m1YO+WY=;
 b=AXWpR/Mo83+1RlmpEKckfBw710iLt9BPH11f2tnD745Rdq2YHbaF8+hDPE1d/T62IB
 5IAhsbUjO9uPjYn+EjhfHiwPF9ScV+M5hY8TXC2zHeS+s98sw67pvP6pPKNJ4VgK05jU
 a0Z1l56tlhjBM5eR0ncvJvZNAdZAmlVYTM3ywqX1e7lyH5UTpJazrazSLSwk8zZxAs5Y
 BKOfN2oHYmfOudmYRZlbxyndjh9GkZVcR3OMTx6mN+Y8CquiszVHng0SzvP2Mq5nvMxB
 +d1tCPlJXgwdoDt+ImO4cL2IzxooZg+At9PLal7tYFO92jnQQZDJAmDGQPsIV3hhtc/x
 Hr9w==
X-Gm-Message-State: AOAM5318jdeB8FvZArFTCnv3LO0kqMah3E8S7fs1r6Z5INkC/wpUe9j1
 R1zpL5HrwCifvcSZM21f1hzo8OQGovBjd7m6aDi0U0yptRWaCj1Z0agAXRAAobK7v53vVZUi3v6
 w1Ipl8qMsep9g/So=
X-Received: by 2002:adf:c3cc:: with SMTP id d12mr8360222wrg.399.1599067929888; 
 Wed, 02 Sep 2020 10:32:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbkOpCzcv8NUi+dIt4hFk/G9LGgeFixftHdMJYyquRJ6eQh/fh3nu34qnOdwIOw+WYSh7gOA==
X-Received: by 2002:adf:c3cc:: with SMTP id d12mr8360204wrg.399.1599067929689; 
 Wed, 02 Sep 2020 10:32:09 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id z9sm533978wma.4.2020.09.02.10.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 10:32:09 -0700 (PDT)
Subject: Re: [PATCH 1/6] configure: fixes dtc not cloned when running msys2 CI
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-2-luoyonggang@gmail.com>
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
Message-ID: <1000842f-3f7e-fa77-e9ce-5cc242ac44bb@redhat.com>
Date: Wed, 2 Sep 2020 19:32:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902170054.810-2-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 7:00 PM, Yonggang Luo wrote:
> Symlink dtc after git submodule update, because on win32 symlink to non-exist folder are forbidden.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  configure | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/configure b/configure
> index 8a3acef89d..30f8c4db29 100755
> --- a/configure
> +++ b/configure
> @@ -2053,9 +2053,6 @@ fi
>  if test "$meson" = git; then
>      git_submodules="${git_submodules} meson"
>  fi
> -if test "$git_update" = yes; then
> -    (cd "${source_path}" && GIT="$git" "./scripts/git-submodule.sh" update "$git_submodules")
> -fi
>  
>  case "$meson" in
>      git | internal)
> @@ -4261,9 +4258,6 @@ EOF
>        if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.git" ; then
>            fdt=git
>            mkdir -p dtc
> -          if [ "$pwd_is_source_path" != "y" ] ; then
> -              symlink "$source_path/dtc/Makefile" "dtc/Makefile"
> -          fi
>            fdt_cflags="-I${source_path}/dtc/libfdt"
>            fdt_ldflags="-L$PWD/dtc/libfdt"
>            fdt_libs="$fdt_libs"
> @@ -6593,6 +6587,16 @@ if test "$cpu" = "s390x" ; then
>    fi
>  fi
>  
> +if test $git_update = 'yes' ; then
> +    (cd "${source_path}" && GIT="$git" "./scripts/git-submodule.sh" update "$git_submodules")
> +
> +    if test "$fdt" = "git" ; then
> +        if [ "$pwd_is_source_path" != "y" ] ; then
> +            symlink "$source_path/dtc/Makefile" "dtc/Makefile"
> +        fi
> +    fi
> +fi
> +
>  # Check that the C++ compiler exists and works with the C compiler.
>  # All the QEMU_CXXFLAGS are based on QEMU_CFLAGS. Keep this at the end to don't miss any other that could be added.
>  if has $cxx; then
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


