Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66DEC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DAB206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqOUHAkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DAB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEF6p-0004e9-F4
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEF6A-00046q-TP
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 13:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEF68-0002hu-VW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 13:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599238919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H/BmVtXqwmiRQle8AnEhf0VuCVo9nDWOQRAO9ksuSp8=;
 b=aqOUHAkwV4KCHpnFdL+a2w0I5C9Tl5EUaYg9blGtzjO4mypDKkdL9QHQ0B0sGBp0pJTktR
 KHIXVl5t9kkNBudaNW7IATBJLgFqVeudo0c89zXHg9oIRDYj63tZc2jQUnGDuhmPUzmMPG
 J5nwZKIDXCynG9OiNV3FhsnuFVrEBv4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-TYxxh3mHNjeI0vsF28ya9w-1; Fri, 04 Sep 2020 13:01:55 -0400
X-MC-Unique: TYxxh3mHNjeI0vsF28ya9w-1
Received: by mail-wr1-f71.google.com with SMTP id r16so2494643wrm.18
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 10:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=H/BmVtXqwmiRQle8AnEhf0VuCVo9nDWOQRAO9ksuSp8=;
 b=nJBJzEJKGHzGUlM/sZn0QQ6RPwNXnwxAHminwRFQtBiHFtDMNNhj8W11seob/RJTkw
 cBNQGUckM5KDm1CzMFqrdBIAjmD3Uw7Vn7BCRULr5oOzeq0TLmYbwfh+IB60LoW3ZeXV
 xS/ii5LAJiA/qIjDar4bLX5nXhu7ZiVHy5jh57RQadI2Ax4N2HrGXjHRifTH9FjotaSX
 jnz5y8MNI9YVZwzIcmBrNvcqQxGfL4fh4YrdHfYFr4SY1KYik3+g1YsPPSkrLcxylNax
 dLZwmA2B0QXsbNSrbfh9kJSwWes4+mRx6cH6jK6HPPNtqAAURjbSVaSTkfTLuzoj/WyE
 JPdQ==
X-Gm-Message-State: AOAM531Qfn1r1bOIOf5Rm2RS/GgA4XF7JPZ11GbcPhWgdfjJryJ2ylBC
 /nsjqny+AKQzlJLJ0ZGDeWb/oi4fONyDh9TnEqRaQCwFsPQf23IVhf/s66xp9R+1YkS8vPYY9DH
 YJVQp+PhBAqkjkOI=
X-Received: by 2002:a1c:9d4b:: with SMTP id g72mr8686052wme.68.1599238912391; 
 Fri, 04 Sep 2020 10:01:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbrSL9m2sGrF2rPPZ3lCG5AVw+Z1mUoyjcpTpr3haOFxIoybkiEwOY6PNeGxFHMI28tQpJcQ==
X-Received: by 2002:a1c:9d4b:: with SMTP id g72mr8686031wme.68.1599238912215; 
 Fri, 04 Sep 2020 10:01:52 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id q20sm11795030wmj.5.2020.09.04.10.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 10:01:51 -0700 (PDT)
Subject: Re: [PATCH 1/7] scripts/ci/gitlab-pipeline-status: make branch name
 configurable
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200904164258.240278-1-crosa@redhat.com>
 <20200904164258.240278-2-crosa@redhat.com>
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
Message-ID: <89a0e149-76a1-697e-5895-76e949861ab9@redhat.com>
Date: Fri, 4 Sep 2020 19:01:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904164258.240278-2-crosa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 06:46:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 6:42 PM, Cleber Rosa wrote:
> With the utility function `get_local_staging_branch_commit()`, the
> name of the branch is hard coded (including in the function name).
> 
> For extensibility reasons, let's make that configurable.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  scripts/ci/gitlab-pipeline-status | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
> index 348a49b6a4..194dd4d0bb 100755
> --- a/scripts/ci/gitlab-pipeline-status
> +++ b/scripts/ci/gitlab-pipeline-status
> @@ -23,20 +23,20 @@ import time
>  import sys
>  
>  
> -def get_local_staging_branch_commit():
> +def get_local_branch_commit(branch='staging'):
>      """
>      Returns the commit sha1 for the *local* branch named "staging"
>      """
> -    result = subprocess.run(['git', 'rev-parse', 'staging'],
> +    result = subprocess.run(['git', 'rev-parse', branch],
>                              stdin=subprocess.DEVNULL,
>                              stdout=subprocess.PIPE,
>                              stderr=subprocess.DEVNULL,
>                              cwd=os.path.dirname(__file__),
>                              universal_newlines=True).stdout.strip()
> -    if result == 'staging':
> -        raise ValueError("There's no local branch named 'staging'")
> +    if result == branch:
> +        raise ValueError("There's no local branch named '%s'" % branch)
>      if len(result) != 40:
> -        raise ValueError("Branch staging HEAD doesn't look like a sha1")
> +        raise ValueError("Branch '%s' HEAD doesn't look like a sha1" % branch)
>      return result
>  
>  
> @@ -110,7 +110,7 @@ def main():
>                                'for https://gitlab.com/qemu-project/qemu, that '
>                                'is, "%(default)s"'))
>      try:
> -        default_commit = get_local_staging_branch_commit()
> +        default_commit = get_local_branch_commit()
>          commit_required = False
>      except ValueError:
>          default_commit = ''
> 


