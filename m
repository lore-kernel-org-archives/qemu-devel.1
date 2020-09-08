Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75925C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18332074D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHbBe577"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18332074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcjp-0003Pf-14
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFcdq-0001EU-Ko
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:22:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60871
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFcdo-0006vx-Bv
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599567747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j9bRCsXCmfmrIbbIICY3xvGS0ShpRCj5v2H5VF82r6s=;
 b=SHbBe577nOoDU4E93QxUTj/aFOM7RzgZRwVDvrMVjXf0YykKluCMoYMvEQaiGA2uG++wrT
 DxY3ThT5zMrcXN+V0kw/GxPdeVQi/9DX+o2DvvfSjfAkV0Q8UbFcxR2PPTMo8463dzDLcH
 S3zEKtde4pLNWbFzi7BY+74gb3rtKB8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-T3jYHFmuO6CpIcWPyXTBDw-1; Tue, 08 Sep 2020 08:22:26 -0400
X-MC-Unique: T3jYHFmuO6CpIcWPyXTBDw-1
Received: by mail-wm1-f71.google.com with SMTP id 189so1246096wme.5
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 05:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=j9bRCsXCmfmrIbbIICY3xvGS0ShpRCj5v2H5VF82r6s=;
 b=TdTOAMFXGh3hpoOs8ylo1xN7bycgBNN+4UjUL+A4CB/Iz4T650dNVR2RfMdI65fodd
 MFdW7h7qYauWaLAiEFR0YqSwwoYOw+1ToQwBPI5sxcXtc00FC8AhlzNqoeLTUvs2/o+R
 jpVhQLVRizxMw5fWDuFoab9eBYt4F+pxEpGgyrE9ZxbIfvZjo7mif1N+s7DzgU1DF58P
 MuYNSOsgJN2a7TX67Q8PiXDIePZNKHtTZEX05XKaTFGegK/ZkKrO4ImBVyn12JrOR9iX
 P/zh4lOVxOfjznXBNjmgYuhBXvKTBGjgkn0TxRtsVUv/R8NMXUpO2ZcqJuZ81fKSc/G+
 ygkg==
X-Gm-Message-State: AOAM530icUUigH3A4hRJAHfhLo5+Ikg3DMOmNYLx1yggw0B8kCzSI4VF
 ffwdgO3DhzC8Dic5IsY+vRBOz21YMCvtgE7jKMR2f6qsYE578PuS+/HKMur4xDJKWVS6knRoDiV
 INu89OllfqZiH6MM=
X-Received: by 2002:a1c:105:: with SMTP id 5mr4405376wmb.83.1599567744852;
 Tue, 08 Sep 2020 05:22:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmoe/dLRmVUfLonxLnNtngAuTpGIZJSVI3oi6kkamjhYbMm0hbJbq+O7p3saSKmdUSV6XWHw==
X-Received: by 2002:a1c:105:: with SMTP id 5mr4405358wmb.83.1599567744640;
 Tue, 08 Sep 2020 05:22:24 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o5sm31091761wmc.33.2020.09.08.05.22.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 05:22:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] logging: Fixes memory leak in test-logging.c
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200908121022.11-1-luoyonggang@gmail.com>
 <20200908121022.11-2-luoyonggang@gmail.com>
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
Message-ID: <e8d1f130-f990-b681-9fb8-ccaaca1f8c93@redhat.com>
Date: Tue, 8 Sep 2020 14:22:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908121022.11-2-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Daniel Brodsky <dnbrdsky@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 2:10 PM, Yonggang Luo wrote:
> g_dir_make_tmp Returns the actual name used. This string should be freed with g_free() when not needed any longer
>  and is is in the GLib file name encoding. In case of errors, NULL is returned and error will be set.
> Use g_autofree to free it properly

Please limit your lines to 80 chars, see CODING_STYLE.rst:

  Line width
  ==========

  Lines should be 80 characters; try not to make them longer.

Also it is recommended to limit commit description to
72 chars. With that addressed:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

(and please keep the reviewers tags when you repost the
same patch, this way we don't have to review your patches
twice).

> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/test-logging.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/test-logging.c b/tests/test-logging.c
> index 8a1161de1d..957f6c08cd 100644
> --- a/tests/test-logging.c
> +++ b/tests/test-logging.c
> @@ -196,7 +196,7 @@ static void rmdir_full(gchar const *root)
>  
>  int main(int argc, char **argv)
>  {
> -    gchar *tmp_path = g_dir_make_tmp("qemu-test-logging.XXXXXX", NULL);
> +    g_autofree gchar *tmp_path = g_dir_make_tmp("qemu-test-logging.XXXXXX", NULL);
>      int rc;
>  
>      g_test_init(&argc, &argv, NULL);
> 


