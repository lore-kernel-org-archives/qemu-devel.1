Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A99FC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCFD221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AezzZHdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCFD221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvOzc-00067T-Hn
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 13:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvOys-0005LB-1w
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:44:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33353
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvOyp-0008Oo-Pi
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594748674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aivCaQ+yML8FnW0Q0+pUpNnLVDiFKSd5JhMf7YsUCZQ=;
 b=AezzZHdEvltsRjDkEynbdHEII8DHcwa58rsbHAwB5NUzg7y6QYcJxcRq3VUGzSBZrUW7gM
 qz9vsUw8Y73JrHGSBTNRfZnFOuD3lcycHNu8ACpO7dgiuRavC8f9vZrNmVod+1u6i4mnqM
 fkyjsnMxGsO/p90wHzzarMQRAkkuRAw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-KQbeuHD5Px6e7TWqcMZLqA-1; Tue, 14 Jul 2020 13:44:33 -0400
X-MC-Unique: KQbeuHD5Px6e7TWqcMZLqA-1
Received: by mail-wm1-f69.google.com with SMTP id s134so4997363wme.6
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 10:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aivCaQ+yML8FnW0Q0+pUpNnLVDiFKSd5JhMf7YsUCZQ=;
 b=BHA9a5ZwGN9J1AQkn34MRqVnv1Z/sfSDSlRstZFqpU6ky+AUAfDwHTxCE9XZ/Ak+W5
 29YzdmQXRugknXfolvUWbagOVfrZGFreP4ZBc2I64/4L5AXiCsm86CQFmS384Fx0OFId
 IV10z/uUXAtWP7Cr3XeFjcIDQh/QXFv6tBYnLgfvjRXqU2/cgxuZl59kgpOQRWN6Tn1y
 O+ohgsxWnAFf1oFLddhZK6Ouyhliuebbw92JFsJOxU15CHSy6VgkL/wZrOqvTHeCYfSa
 jR2VgD0vJdYJxYJWdheXwmI0tztBkRd2FRqVafZWQFwjns+TclynO+wXoSRlxA53OgH6
 LBzg==
X-Gm-Message-State: AOAM533nEFbRXyCeavoYBKI7hOfs/4sGXiM/ph8x1hfugDJLs/lxISt/
 NyzsLcF6AimzFMes3cVaTurGWQn5SE7HOvaIKW2AqBdqViF3rqwoMqYOizQ6AnE/BQNy44tRxX+
 j+5gmNHq8sJnNzgI=
X-Received: by 2002:a1c:98c1:: with SMTP id a184mr5096119wme.116.1594748671611; 
 Tue, 14 Jul 2020 10:44:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP96GaY7fh2h4CjDNMQY1oklZzCE1E6k5G7VW6e1Lcbynf1PbFETvHzAWKMG4JbVlNnDuLkQ==
X-Received: by 2002:a1c:98c1:: with SMTP id a184mr5096093wme.116.1594748671392; 
 Tue, 14 Jul 2020 10:44:31 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id o21sm5346637wmh.18.2020.07.14.10.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 10:44:30 -0700 (PDT)
Subject: Re: [PATCH for 5.1] crypto: use a stronger private key for tests
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200714173700.1027116-1-berrange@redhat.com>
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
Message-ID: <18a88b51-73a2-8584-ce73-7c99e88b5fd9@redhat.com>
Date: Tue, 14 Jul 2020 19:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714173700.1027116-1-berrange@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:02:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 7:37 PM, Daniel P. Berrangé wrote:
> The unit tests using the x509 crypto functionality have started
> failing in Fedora 33 rawhide with a message like
> 
>       The certificate uses an insecure algorithm
> 
> This is result of Fedora changes to support strong crypto [1]. RSA
> with 1024 bit key is viewed as legacy and thus insecure. Generate
> a new private key then. Moreover, switch to EC which is not only
> shorter but also not deprecated that often as RSA. Generated
> using the following command [2]:
> 
>     openssl genpkey --outform PEM --out privkey.pem \
>       --algorithm EC --pkeyopt ec_paramgen_curve:P-384 \
>       --pkeyopt ec_param_enc:named_curve
> 
> 1: https://fedoraproject.org/wiki/Changes/StrongCryptoSettings2
> 2: technically I just copied the key from libvirt git but that's
>    how libvirt generated it
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/crypto-tls-x509-helpers.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/crypto-tls-x509-helpers.c b/tests/crypto-tls-x509-helpers.c
> index 9b669c2a4b..bdb72b9ed0 100644
> --- a/tests/crypto-tls-x509-helpers.c
> +++ b/tests/crypto-tls-x509-helpers.c
> @@ -39,22 +39,10 @@ ASN1_TYPE pkix_asn1;
>  gnutls_x509_privkey_t privkey;
>  # define PRIVATE_KEY                                              \
>      "-----BEGIN PRIVATE KEY-----\n"                               \
> -    "MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALVcr\n"     \
> -    "BL40Tm6yq88FBhJNw1aaoCjmtg0l4dWQZ/e9Fimx4ARxFpT+ji4FE\n"     \
> -    "Cgl9s/SGqC+1nvlkm9ViSo0j7MKDbnDB+VRHDvMAzQhA2X7e8M0n9\n"     \
> -    "rPolUY2lIVC83q0BBaOBkCj2RSmT2xTEbbC2xLukSrg2WP/ihVOxc\n"     \
> -    "kXRuyFtzAgMBAAECgYB7slBexDwXrtItAMIH6m/U+LUpNe0Xx48OL\n"     \
> -    "IOn4a4whNgO/o84uIwygUK27ZGFZT0kAGAk8CdF9hA6ArcbQ62s1H\n"     \
> -    "myxrUbF9/mrLsQw1NEqpuUk9Ay2Tx5U/wPx35S3W/X2AvR/ZpTnCn\n"     \
> -    "2q/7ym9fyiSoj86drD7BTvmKXlOnOwQJBAPOFMp4mMa9NGpGuEssO\n"     \
> -    "m3Uwbp6lhcP0cA9MK+iOmeANpoKWfBdk5O34VbmeXnGYWEkrnX+9J\n"     \
> -    "bM4wVhnnBWtgBMCQQC+qAEmvwcfhauERKYznMVUVksyeuhxhCe7EK\n"     \
> -    "mPh+U2+g0WwdKvGDgO0PPt1gq0ILEjspMDeMHVdTwkaVBo/uMhAkA\n"     \
> -    "Z5SsZyCP2aTOPFDypXRdI4eqRcjaEPOUBq27r3uYb/jeboVb2weLa\n"     \
> -    "L1MmVuHiIHoa5clswPdWVI2y0em2IGoDAkBPSp/v9VKJEZabk9Frd\n"     \
> -    "a+7u4fanrM9QrEjY3KhduslSilXZZSxrWjjAJPyPiqFb3M8XXA26W\n"     \
> -    "nz1KYGnqYKhLcBAkB7dt57n9xfrhDpuyVEv+Uv1D3VVAhZlsaZ5Pp\n"     \
> -    "dcrhrkJn2sa/+O8OKvdrPSeeu/N5WwYhJf61+CPoenMp7IFci\n"         \
> +    "MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDD39t6GRLeEmsYjRGR6\n" \
> +    "iQiIN2S4zXsgLGS/2GloXdG7K+i/3vEJDt9celZ0DfCLcG6hZANiAAQTJIe13jy7\n" \
> +    "k4KTXMkHQHEJa/asH263JaPL5kTbfRa6tMq3DS3pzWlOj+NHY/9JzthrKD+Ece+g\n" \
> +    "2g/POHa0gfXRYXGiHTs8mY0AHFqNNmF38eIVGjOqobIi90MkyI3wx4g=\n" \
>      "-----END PRIVATE KEY-----\n"
>  
>  /*
> 


