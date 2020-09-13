Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25D9C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 15:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F44E2078D
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 15:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdaS1YXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F44E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHU5J-00061R-Ek
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 11:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHU4T-0005W7-TY
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 11:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHU4R-0006se-BZ
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 11:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600011458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hqiSoZurTOJ8/BN+HnfAtGmrRKzLCK3+n+z/BXyAgy8=;
 b=ZdaS1YXQ+gNmwGTeDsvJYbCsbNCR3be11vWXfQwwgeGJd+ytyFL4sqRCobziK4ss1+d3Nv
 tcUASYN1qllzMzZ6hT+j6jiu1niJmKvSghN8OrX8ImKDZhDVJDJy70xeUx8+Ryymc05xZc
 BH150IH/uKQq8mopFzP+Qh4HWoTzZBk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-GlZm0pxdN4yK8lEta4ZwFQ-1; Sun, 13 Sep 2020 11:37:36 -0400
X-MC-Unique: GlZm0pxdN4yK8lEta4ZwFQ-1
Received: by mail-wr1-f69.google.com with SMTP id x15so5645458wrm.7
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 08:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hqiSoZurTOJ8/BN+HnfAtGmrRKzLCK3+n+z/BXyAgy8=;
 b=KOiOFgRRtvtgzLuRyYlsmg0CTZR89xWJDp/x0NcO6pD/j2/AGx/wj/o91puslU6xca
 iKX++WWS9lA4Ny5rzcbv4PHctAty98cATDqElJ6vKhChq/S9VEdeb6ihrW79rzMK0PKv
 /B4Z0B2dLyr/5URJgUoZxkbD+ObeZaE1Ar5ziyqhJFmstZXYQh1dnateGA1diHmag90n
 u/u4zbspV465bqYHyjLZgi4lFjVdmEoZSqNKME7VJqn1fuAHSem2gUsIsUAFGGBZwXaS
 URBlCLlXqcqxr/uGfd8anzCYNhJ8CRG/y46SyoG6p5AZpAyeZ8AkbSjVx1xEFYW5IQ/3
 iEnQ==
X-Gm-Message-State: AOAM531PLmf1Bw8/aaznSxWPzkInr7eaCm5wijft++GYsQL7ho7vVnLD
 OAxZc0GEnHEHGc/zcF/tawjWc3ebdwTTA3euzZA8yi4jOHYgzAtQO0RwOrUKQ+MSIvSvKvC5iYm
 6Pm78swFTLHymvhg=
X-Received: by 2002:adf:e8c5:: with SMTP id k5mr11805851wrn.352.1600011455256; 
 Sun, 13 Sep 2020 08:37:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq5jacw74Rvet98UCP88/IPty6GgMK465cWArgYk9XtOUdeBiHNHUCK0/bADnMKrYCoOt6yg==
X-Received: by 2002:adf:e8c5:: with SMTP id k5mr11805826wrn.352.1600011455071; 
 Sun, 13 Sep 2020 08:37:35 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id s17sm16898888wrr.40.2020.09.13.08.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 08:37:34 -0700 (PDT)
Subject: Re: [PATCH v8 08/27] tests: Fixes test-replication.c on msys2/mingw.
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-9-luoyonggang@gmail.com>
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
Message-ID: <505f8221-1da9-b09f-625a-e60f82e2cfa7@redhat.com>
Date: Sun, 13 Sep 2020 17:37:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200912224431.1428-9-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 11:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/20 12:44 AM, Yonggang Luo wrote:
> On Windows there is no path like /tmp/s_local_disk.XXXXXX
> Use g_get_tmp_dir instead of /tmp.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/test-replication.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/test-replication.c b/tests/test-replication.c
> index 9ab3666a90..e7cbd6b144 100644
> --- a/tests/test-replication.c
> +++ b/tests/test-replication.c
> @@ -23,14 +23,14 @@
>  
>  /* primary */
>  #define P_ID "primary-id"
> -static char p_local_disk[] = "/tmp/p_local_disk.XXXXXX";
> +static char *p_local_disk;
>  
>  /* secondary */
>  #define S_ID "secondary-id"
>  #define S_LOCAL_DISK_ID "secondary-local-disk-id"
> -static char s_local_disk[] = "/tmp/s_local_disk.XXXXXX";
> -static char s_active_disk[] = "/tmp/s_active_disk.XXXXXX";
> -static char s_hidden_disk[] = "/tmp/s_hidden_disk.XXXXXX";
> +static char *s_local_disk;
> +static char *s_active_disk;
> +static char *s_hidden_disk;
>  
>  /* FIXME: steal from blockdev.c */
>  QemuOptsList qemu_drive_opts = {
> @@ -571,6 +571,11 @@ static void setup_sigabrt_handler(void)
>  int main(int argc, char **argv)
>  {
>      int ret;
> +    const char *tmpdir = g_get_tmp_dir();
> +    p_local_disk = g_strdup_printf("%s/p_local_disk.XXXXXX", tmpdir);
> +    s_local_disk = g_strdup_printf("%s/s_local_disk.XXXXXX", tmpdir);
> +    s_active_disk = g_strdup_printf("%s/s_active_disk.XXXXXX", tmpdir);
> +    s_hidden_disk = g_strdup_printf("%s/s_hidden_disk.XXXXXX", tmpdir);
>      qemu_init_main_loop(&error_fatal);
>      bdrv_init();
>  
> @@ -605,5 +610,10 @@ int main(int argc, char **argv)
>  
>      cleanup_imgs();
>  
> +    g_free(p_local_disk);
> +    g_free(s_local_disk);
> +    g_free(s_active_disk);
> +    g_free(s_hidden_disk);
> +
>      return ret;
>  }
> 


