Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA671C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73DDE206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AInp0i55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DDE206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiGYC-00085K-P9
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 08:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiGXW-0007ap-Iw
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:06:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41778
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiGXV-0007ly-Nj
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591617965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kqX50uhw+9TpAm31lsNMvm2wysrG53Z1P/9iLyrzuUo=;
 b=AInp0i55ySk/IMfa5BTXp5Cgw2GLngOv2+nsq3KRDU0pZJKsUrwO2B2MhTWLOnUVb0y7iM
 74sjnEqdCyAsSjUHW9j6D08NZjq6LXPXheWAqq8aeYOA/pliplRxiTQaGMkZAJiebTgxB0
 vPHqKrXN2mOZFTZdCLGIr54MfIKAp0Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-5lbSwKz4M-akU5UjEOCzAQ-1; Mon, 08 Jun 2020 08:06:01 -0400
X-MC-Unique: 5lbSwKz4M-akU5UjEOCzAQ-1
Received: by mail-wm1-f71.google.com with SMTP id c4so1336109wmd.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 05:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=kqX50uhw+9TpAm31lsNMvm2wysrG53Z1P/9iLyrzuUo=;
 b=Zi0Th7o6f2CnTsOnH6HuZ+SkKhmXjANLvGLwziVGpx34gkI8RKiS5fw6xfT1n8Hyf1
 y73PPf212eGXY0LAMlWtOMShwHsMUfoXgPQ6SKRE76i6F8GVbBg9OfMbG2czvkPxpSa3
 WQM9i9ZA81fG5Bv5rrwWkNRJurpq69CSn9LhmCPT2DU68FJD+Q+I0bWM8HZwbkfiYdI4
 GAcurwYe3yYIp9Jl2hCH4GoJwBKn0vD3YTkix+4FkiMQ7N3RqmwMFyZwdP0Jux0jqHyj
 ysUukxvpYItPStWNHzQ7Q3sL2H5KWurKttSWodRMUZAvSSQozQ8XC9m0V/gUHEpgX8Bl
 GTTg==
X-Gm-Message-State: AOAM532dKOHdAQ0RfBPlocLlVCJG9R6xgVDwdh+ncsLrpxg3WwXmJjD2
 fLM2DWaAzERX1bh+TmNgW4aDzvLBzaEV+XKtUnF78LEO9GEpQr1bo0XSWNhfiZAeUXzfQazUaRG
 qm/lGPYdEaDMk+4M=
X-Received: by 2002:adf:e84c:: with SMTP id d12mr22717921wrn.284.1591617960735; 
 Mon, 08 Jun 2020 05:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxJanuOMGAtsYhp5drs9CLJeni9oivfTpWt+i7MFSOk4BDa7QYPBUK8jol5lN+DQt5CvgVuw==
X-Received: by 2002:adf:e84c:: with SMTP id d12mr22717898wrn.284.1591617960544; 
 Mon, 08 Jun 2020 05:06:00 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q5sm23364896wrm.62.2020.06.08.05.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 05:06:00 -0700 (PDT)
Subject: Re: [PATCH] travis.yml: Test also the other targets on s390x
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200608114049.4693-1-thuth@redhat.com>
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
Message-ID: <a3055bde-b598-e5cb-321c-551434adf216@redhat.com>
Date: Mon, 8 Jun 2020 14:05:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200608114049.4693-1-thuth@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/8/20 1:40 PM, Thomas Huth wrote:
> s390x is our only big endian host in our CI, so building and testing QEMU
> there is quite valuable. Thus let's also test the other targets with
> additional jobs (also using different sets of pre-installed libraries to
> get a better coverage of the things that we test).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 564be50a3c..41e97fb050 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -504,6 +504,45 @@ jobs:
>                $(exit $BUILD_RC);
>            fi
>  
> +    - name: "[s390x] GCC (other-softmmu)"
> +      arch: s390x
> +      dist: bionic
> +      addons:
> +        apt_packages:
> +          - libaio-dev
> +          - libattr1-dev
> +          - libcap-ng-dev
> +          - libgnutls28-dev
> +          - libiscsi-dev
> +          - liblttng-ust-dev
> +          - liblzo2-dev
> +          - libncurses-dev
> +          - libnfs-dev
> +          - libnss3-dev
> +          - libpixman-1-dev
> +          - libsdl2-dev
> +          - libsdl2-image-dev
> +          - libseccomp-dev
> +          - libsnappy-dev
> +          - libzstd-dev
> +          - nettle-dev
> +          - xfslibs-dev
> +          # Tests dependencies
> +          - genisoimage
> +      env:
> +        - CONFIG="--disable-containers --audio-drv-list=sdl --disable-user
> +                  --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
> +
> +    - name: "[s390x] GCC (user)"
> +      arch: s390x
> +      dist: bionic
> +      addons:
> +        apt_packages:
> +          - libgcrypt20-dev
> +          - libgnutls28-dev
> +      env:
> +        - CONFIG="--disable-containers --disable-system"
> +
>      - name: "[s390x] Clang (disable-tcg)"
>        arch: s390x
>        dist: bionic
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


