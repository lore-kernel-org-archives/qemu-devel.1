Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1A3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A259208FE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdhRF3Cf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A259208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFiJO-00075x-1x
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFiIQ-0006Wy-NP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFiIN-0007mK-3k
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599589481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j/cmPbRIq1rjarD6Gg3MFpxG71LKybNJQBlGBLQ5drw=;
 b=PdhRF3CfSQoD8IYDRj9RMwMUNOvUNZVw0h7ETtJmduCKvwPVS/fJVOxPjmr3kFd4hX7bIB
 kLc7tl7HXuAas4GgFfvNVEu9jh2kuOqh37IB0NceLNheBzh6KEvIsXnbcQQBPuuQG90ft0
 w9/puqT7hdoqizDE9ixAi855OGVgyks=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-TAjVyLwfNuq1HWOQCGAbHw-1; Tue, 08 Sep 2020 14:24:40 -0400
X-MC-Unique: TAjVyLwfNuq1HWOQCGAbHw-1
Received: by mail-wr1-f72.google.com with SMTP id k13so67879wrl.4
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 11:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=j/cmPbRIq1rjarD6Gg3MFpxG71LKybNJQBlGBLQ5drw=;
 b=iiSafPXvLxWqexhTihpLXLCnlOiYVj8Flbfh/tyoeboVbegS+uQtD/HZDTsL0rwx22
 +OhZi9E2oOUWW0qQG8yaFY/iTrZkEra4/n1twHRKpdVyNEOB4UUkRzWhUSGLvZxHBdsR
 MEl2/EiAhTuCcd0+ixsoOW2gzQJA9W9Q12Qir4tdBioi1JTNVD8cM/YbLni/uAEP/8oC
 +HGG1kjebtpim1Kn7GXaJENIsGSuX1W3sVSYW15S6FdXxI8xbueLeFvgmqBRhhXQdo1E
 34o7LxiLl4df7LWRHlVBQ8fk8ZsFvWjaMKcahuRSwhennrgK7Mc8h6tvGDCriA6aj8lP
 ERBQ==
X-Gm-Message-State: AOAM531rV3ytyiGsqmeeM6eqF7j8W26Aeax95efylTm6CZWZHWpWV9sz
 PW+vJEOdHDJGlVPJzoduBz0flsg3kTtSqwRHAWyhdL+I78ZeTg78gLpvlZgA3PoRK6paB60EAQO
 3on4fCegv9fcQJYU=
X-Received: by 2002:a1c:1b8f:: with SMTP id b137mr384582wmb.151.1599589479141; 
 Tue, 08 Sep 2020 11:24:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQJ1+9csnHt8wrp4/IQHD7WryVcYsycN60m3Jg9xidtQJoYxfXQtVTbVM4/Y+Mi4qtX1tfdQ==
X-Received: by 2002:a1c:1b8f:: with SMTP id b137mr384543wmb.151.1599589478884; 
 Tue, 08 Sep 2020 11:24:38 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id f126sm293837wmf.13.2020.09.08.11.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 11:24:36 -0700 (PDT)
Subject: Re: [PATCH 1/5] hw/smbios: support loading OEM strings values from a
 file
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200908165438.1008942-1-berrange@redhat.com>
 <20200908165438.1008942-2-berrange@redhat.com>
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
Message-ID: <cd82e5fe-28d9-39c3-871d-1a538fc1e55b@redhat.com>
Date: Tue, 8 Sep 2020 20:24:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908165438.1008942-2-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Daniel,

On 9/8/20 6:54 PM, Daniel P. Berrangé wrote:
> Some applications want to pass quite large values for the OEM strings
> entries. Rather than having huge strings on the command line, it would
> be better to load them from a file, as supported with -fw_cfg.
> 
> This introduces the "valuefile" parameter allowing for:
> 
>   $ echo -n "thisthing" > mydata.txt
>   $ qemu-system-x86_64 \
>     -smbios type=11,value=something \
>     -smbios type=11,valuefile=mydata.txt \
>     -smbios type=11,value=somemore \
>     ...other args...
> 
> Now in the guest
> 
> $ dmidecide -t 11
> Getting SMBIOS data from sysfs.
> SMBIOS 2.8 present.
> 
> Handle 0x0E00, DMI type 11, 5 bytes
> OEM Strings
> 	String 1: something
> 	String 2: thisthing
> 	String 3: somemore
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/smbios/smbios.c | 72 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 59 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 7cc950b41c..8450fad285 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -110,7 +110,7 @@ static struct {
>  
>  static struct {
>      size_t nvalues;
> -    const char **values;
> +    char **values;
>  } type11;
>  
>  static struct {
> @@ -314,6 +314,11 @@ static const QemuOptDesc qemu_smbios_type11_opts[] = {
>          .type = QEMU_OPT_STRING,
>          .help = "OEM string data",
>      },
> +    {
> +        .name = "path",
> +        .type = QEMU_OPT_STRING,
> +        .help = "OEM string data from file",
> +    },
>  };
>  
>  static const QemuOptDesc qemu_smbios_type17_opts[] = {
> @@ -641,6 +646,8 @@ static void smbios_build_type_11_table(void)
>  
>      for (i = 0; i < type11.nvalues; i++) {
>          SMBIOS_TABLE_SET_STR_LIST(11, type11.values[i]);
> +        g_free(type11.values[i]);
> +        type11.values[i] = NULL;
>      }
>  
>      SMBIOS_BUILD_TABLE_POST;
> @@ -940,9 +947,8 @@ static void save_opt(const char **dest, QemuOpts *opts, const char *name)
>  
>  
>  struct opt_list {
> -    const char *name;
>      size_t *ndest;
> -    const char ***dest;
> +    char ***dest;
>  };
>  
>  static int save_opt_one(void *opaque,
> @@ -951,23 +957,61 @@ static int save_opt_one(void *opaque,
>  {
>      struct opt_list *opt = opaque;
>  
> -    if (!g_str_equal(name, opt->name)) {
> -        return 0;
> +    if (g_str_equal(name, "path")) {
> +        g_autoptr(GByteArray) data = g_byte_array_new();
> +        g_autofree char *buf = g_new(char, 4096);
> +        ssize_t ret;
> +        int fd = qemu_open(value, O_RDONLY);

While not use g_file_get_contents()?

> +        if (fd < 0) {
> +            error_setg(errp, "Unable to open %s: %s", value, strerror(errno));
> +            return -1;
> +        }
> +
> +        while (1) {
> +            ret = read(fd, buf, 4096);
> +            if (ret == 0) {
> +                break;
> +            }
> +            if (ret < 0) {
> +                error_setg(errp, "Unable to read from %s: %s",
> +                           value, strerror(errno));
> +                return -1;
> +            }
> +            if (memchr(buf, '\0', ret)) {
> +                error_setg(errp, "NUL in OEM strings value in %s", value);
> +                return -1;
> +            }
> +            g_byte_array_append(data, (guint8 *)buf, ret);
> +        }
> +
> +        close(fd);
[...]


