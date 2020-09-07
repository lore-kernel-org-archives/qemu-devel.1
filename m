Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221BBC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB5E206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZK02o1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB5E206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNEx-00058H-MC
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 15:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFNDg-0004DG-8N
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:54:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46004
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFNDe-00070c-4D
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599508464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=je64t4FUv5U8gA5Od/z1OOpApUKk8oMd5nWkA74GktM=;
 b=hZK02o1CqyiJun0W8IYGeCuha8vcI6I4lNj+nisHl1OumCeiPzRDPODPsKM/oTLzNwnzW9
 TSt9cikonQ3GLCUHnOu38nELBRfo+Uq631tD/YSX0aZGf3hEXTzKuUvUaJ0dIke1Mj2Wc7
 e5bQzXUm5ApKzA0FCfBlKVBoXjj8kp4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-RCVE1EXSPnGs0AuGSr8MnQ-1; Mon, 07 Sep 2020 15:54:23 -0400
X-MC-Unique: RCVE1EXSPnGs0AuGSr8MnQ-1
Received: by mail-wr1-f72.google.com with SMTP id a12so6041740wrg.13
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 12:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=je64t4FUv5U8gA5Od/z1OOpApUKk8oMd5nWkA74GktM=;
 b=QJbWhqvDwSg3O8wqArWUxIbcC5a71Tc8JgfpdEUrFuAQt9dioMyOPxfwHVEpNwRCSR
 SxgXtufnq0hBXQPjnRE6N9KMrT+LyGXM7biMIimDeD7rPnpEbdR/YoJ7FUCBYlWk7ctg
 m0qAgBR+QnBMJcrm3K4V+fwo6FKzdVPVi/DFyYiRatSQfg/Uf2W6vj3Z4/DOw3dyNhET
 W1qxX7n9Vvkm36HmSt1miABGaJG0uqdKdIX/DydF6wEIWwn4pu7kZxZ6mCGek17T6MBh
 2Jsh+xeVBbbY4X/DsdfpnhUD1RAMuWUGQ2vUIPP3clCDAAfqXfgPgfnifakDsxfNgQR0
 jGEQ==
X-Gm-Message-State: AOAM531IMsjbbRmpVXHxOmlw4yV/+92SQEm0HeGZkk04+sc/VGJ8hMRK
 5JstQYfBoldPCbLdwtVXa5KI77Wqj3xJIG/CEDR9b9BT1OlIpr3/pLsr9WmIBO/BYd2pWrqyPZR
 IliYPnXX0VAf93Yg=
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr951454wmj.68.1599508462022;
 Mon, 07 Sep 2020 12:54:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNOJSuvdgxGrKifnm+yTplmBxizs8GDIXc+Ic1WUJwkpa4ynd51yq09JkDv1NG/UMVYVXeNw==
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr951442wmj.68.1599508461843;
 Mon, 07 Sep 2020 12:54:21 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k8sm28508503wrl.42.2020.09.07.12.54.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 12:54:21 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] vmstate: Trying fixes test-vmstate.c
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200907195025.2308-1-luoyonggang@gmail.com>
 <20200907195025.2308-2-luoyonggang@gmail.com>
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
Message-ID: <f57a5ea9-0d69-6254-9e34-56ce128783b9@redhat.com>
Date: Mon, 7 Sep 2020 21:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907195025.2308-2-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Trying fixes" or "Fixes" in subject?

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

On 9/7/20 9:50 PM, Yonggang Luo wrote:
> The vmstate should be valid on win32
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/test-vmstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index f8de709a0b..4c453575bb 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -34,7 +34,6 @@
>  #include "qemu/module.h"
>  #include "io/channel-file.h"
>  
> -static char temp_file[] = "/tmp/vmst.test.XXXXXX";
>  static int temp_fd;
>  
>  
> @@ -1487,6 +1486,7 @@ static void test_tmp_struct(void)
>  
>  int main(int argc, char **argv)
>  {
> +    g_autofree char* temp_file = g_strdup_printf("%s/vmst.test.XXXXXX", g_get_tmp_dir());
>      temp_fd = mkstemp(temp_file);
>  
>      module_call_init(MODULE_INIT_QOM);
> 


