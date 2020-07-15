Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1797FC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 16:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D960E20663
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 16:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSzMVclr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D960E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvjwO-0002gN-Ve
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 12:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvjvA-0001BD-E0
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 12:06:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48928
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvjv8-0005il-3T
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 12:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594829169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S4oT1fmevprqxPrPQkePqusmLpYgbJHQsz3x9BJQN6I=;
 b=eSzMVclrEmrsLOEEADBqCvwxqaKgZI/C08NSmJ6Yp4K9uwWEb5ZpWBikoiokPqtn/UKIxT
 2+w68CexO4TfybWzXAuyMUrvz0Xi8CrcViJcosDCcVkG3pPBiZHWkOxHwziFJd//RRZr4E
 PcV+BAxrKK+/2N/Usn4OI+gSdNcSiFw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-pPyVtNp-MHSSHE-JMzuwzw-1; Wed, 15 Jul 2020 12:06:05 -0400
X-MC-Unique: pPyVtNp-MHSSHE-JMzuwzw-1
Received: by mail-wm1-f70.google.com with SMTP id c81so1213986wmd.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 09:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=S4oT1fmevprqxPrPQkePqusmLpYgbJHQsz3x9BJQN6I=;
 b=Ouk220CssHhFKSZNr5o+WFMsdNHjjsLpfcvSJ/2AD9ZTeDH1VQSfMHDXr47uY4Xfep
 d/SMSmIn5SdGTRR2DdpTg22fhhgiZB3Qq1e0Ze+EDNFo5+ULuzMYUXYUVM5rEbVKX4/r
 41Z03PVexfwa7YZLihsYng9np7QLigYCVcW75RQ/+YmPH5ZyubIE6M4y6dBxkwe4qYeh
 59RinAkJB+fKSeNa5SH+0962tekmIhmE7pyIcPvGy7P61vW8nu5pFho+zZtyPuTQbbMZ
 K/DV9zRVFFVyonD1LFtEOYT18fu0+vmKZJgxTg2hydOhua+3yzTwiHkpowShkz4cA7yX
 vpXQ==
X-Gm-Message-State: AOAM530M74HlyVX/+SwCD7Nywx2tBClsLoIK9OdeGm0rkBlLMAROdCTS
 9lnZuDB+pc0Kpi3l3z4XZnbt7nyTxJ1Numxe5PaaLj79Bvg1JsDpKhh1UWNjikNV23T4CvmYs1k
 A7m7qcP10YP+4Joc=
X-Received: by 2002:a7b:c8c2:: with SMTP id f2mr156234wml.57.1594829164175;
 Wed, 15 Jul 2020 09:06:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmOk8GuXve+Y4YTqtAGXdhIlh0fEhv17Vn0PF1eaFg2SaF4jr/glClpPgJDmrRIZ2B1SPn+A==
X-Received: by 2002:a7b:c8c2:: with SMTP id f2mr156212wml.57.1594829163963;
 Wed, 15 Jul 2020 09:06:03 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c25sm3712138wml.46.2020.07.15.09.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 09:06:03 -0700 (PDT)
Subject: Re: [PATCH 1/1] analyze-migration.py: fix read_migration_debug_json()
 return type
To: Alexey Kirillov <lekiravi@yandex-team.ru>
References: <20200715152135.20287-1-lekiravi@yandex-team.ru>
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
Message-ID: <f365e96e-3e83-ede6-3db5-2e02eb03adaa@redhat.com>
Date: Wed, 15 Jul 2020 18:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200715152135.20287-1-lekiravi@yandex-team.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Eduardo/Cleber.

On 7/15/20 5:21 PM, Alexey Kirillov wrote:
> Since we use result of read_migration_debug_json() as JSON formatted string,
> we must provide proper type. Before Python 3.6 json.loads() method
> support only str typed input.
> 
> Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
> ---
>  scripts/analyze-migration.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index 95838cbff3..c5f06482cf 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -97,7 +97,7 @@ class MigrationFile(object):
>          # Seek back to where we were at the beginning
>          self.file.seek(entrypos, 0)
>  
> -        return data[jsonpos:jsonpos + jsonlen]
> +        return data[jsonpos:jsonpos + jsonlen].decode("utf-8")
>  
>      def close(self):
>          self.file.close()
> 


