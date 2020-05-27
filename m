Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC51C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A96207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWXqpcqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A96207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdqfS-0000Ai-IF
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 03:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdqeX-00080B-RB
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:39:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38651
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdqeV-0005Hk-PD
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590565142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZHyrhfNbQZZw4rIsBAbPiAkC2dJHYAUX2/DXiQ/zaUA=;
 b=RWXqpcqGccIfKIKHjepQV1qVN09nwxZVnfm/vMk8pCq5dqkcwO2md2xKjZgxI9n20+oWfp
 USYwRumMWC5PLnhxeAZizQMgcjIUAL+HdNQGEgnhLGH8yMS/Gt2Jo3WDcDtb4N8YdJH9Tc
 qPGEVTIAe7/EFdInfjaA50HvQZlRR1I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-U_SEyt9oPM6c3-etksprdQ-1; Wed, 27 May 2020 03:39:00 -0400
X-MC-Unique: U_SEyt9oPM6c3-etksprdQ-1
Received: by mail-wm1-f70.google.com with SMTP id l26so567901wmh.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 00:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ZHyrhfNbQZZw4rIsBAbPiAkC2dJHYAUX2/DXiQ/zaUA=;
 b=SOzgPP3HtWGVeV+L1YmAo+AGDEor1ANppLi598gWDVc3wXczWOabnGbkda23p5sUeN
 qdc//dgqOwGDKGGqh29ai4dMZGKknprOjiB6nazcQXPJhDOS2cn9ZrUkJxyxxde+o8K6
 HEC5s7MuPWxfZFSvPB9wi4JsuCPpogmq1TcUlFSCBtAeAcsnIdPJaw+WHQWQjpq6SNKP
 lJS1dQCOn+0E4tzOQmI6roZx67xA0M7GTLrPCSWPsXfF7R5sgk/p3VMV6t0Clnc0o7GG
 bebPbvZqq5jbyVf/yNVIJmruv/NhDNKDxXbq+Y5vDawlxdffYXTQSYUIjqt4/UL8tJ7h
 GirA==
X-Gm-Message-State: AOAM533G/kz/GFXFaWYdGxQ29ezZPC4T9PccTHtkAVHtOA5NlPFi/Uup
 1zrI+PLyuuqOS+d/nrtGxY9rgbgtIvfOsJJPsCz+ZBZaBc0qrJQ1IzzywfHnK+vlB2YYbER9GBy
 HnF1xbEIWuBHUTlg=
X-Received: by 2002:a1c:2643:: with SMTP id m64mr2926928wmm.158.1590565139027; 
 Wed, 27 May 2020 00:38:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz125HXwnGL1JQNUyKGqjcCGovF0+dbSHce720lv/s1KRB02kAVk04s67WI6uKewsk3X0uOGQ==
X-Received: by 2002:a1c:2643:: with SMTP id m64mr2926905wmm.158.1590565138752; 
 Wed, 27 May 2020 00:38:58 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id o15sm1977206wmm.31.2020.05.27.00.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 00:38:58 -0700 (PDT)
Subject: Re: [PATCH v2] trace/simple: Fix unauthorized enable
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200527065613.25322-1-armbru@redhat.com>
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
Message-ID: <07cfb8eb-4596-5c06-5ec3-fe529f5249d9@redhat.com>
Date: Wed, 27 May 2020 09:38:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200527065613.25322-1-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 8:56 AM, Markus Armbruster wrote:
> st_set_trace_file() accidentally enables tracing.  It's called
> unconditionally during startup, which is why QEMU built with the
> simple trace backend always writes a trace file "trace-$PID".
> 
> This has been broken for quite a while.  I didn't track down the exact
> commit.
> 
> Fix st_set_trace_file() to restore the state.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> v2: Make st_set_trace_file() less confusing [Stefan]
> 
>  trace/simple.h |  2 +-
>  trace/simple.c | 20 ++++++++++++++------
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/trace/simple.h b/trace/simple.h
> index 5771a0634f..26ccbc8b8a 100644
> --- a/trace/simple.h
> +++ b/trace/simple.h
> @@ -12,7 +12,7 @@
>  #define TRACE_SIMPLE_H
>  
>  void st_print_trace_file_status(void);
> -void st_set_trace_file_enabled(bool enable);
> +bool st_set_trace_file_enabled(bool enable);
>  void st_set_trace_file(const char *file);
>  bool st_init(void);
>  void st_flush_trace_buffer(void);
> diff --git a/trace/simple.c b/trace/simple.c
> index fc7106ec49..9cd2ed1fb3 100644
> --- a/trace/simple.c
> +++ b/trace/simple.c
> @@ -302,10 +302,17 @@ static int st_write_event_mapping(void)
>      return 0;
>  }
>  
> -void st_set_trace_file_enabled(bool enable)
> +/**
> + * Enable / disable tracing, return whether it was enabled.
> + *
> + * @enable: enable if %true, else disable.
> + */
> +bool st_set_trace_file_enabled(bool enable)
>  {
> +    bool was_enabled = trace_fp;
> +
>      if (enable == !!trace_fp) {
> -        return; /* no change */
> +        return was_enabled;     /* no change */
>      }
>  
>      /* Halt trace writeout */
> @@ -323,14 +330,14 @@ void st_set_trace_file_enabled(bool enable)
>  
>          trace_fp = fopen(trace_file_name, "wb");
>          if (!trace_fp) {
> -            return;
> +            return was_enabled;
>          }
>  
>          if (fwrite(&header, sizeof header, 1, trace_fp) != 1 ||
>              st_write_event_mapping() < 0) {
>              fclose(trace_fp);
>              trace_fp = NULL;
> -            return;
> +            return was_enabled;
>          }
>  
>          /* Resume trace writeout */
> @@ -340,6 +347,7 @@ void st_set_trace_file_enabled(bool enable)
>          fclose(trace_fp);
>          trace_fp = NULL;
>      }
> +    return was_enabled;
>  }
>  
>  /**
> @@ -350,7 +358,7 @@ void st_set_trace_file_enabled(bool enable)
>   */
>  void st_set_trace_file(const char *file)
>  {
> -    st_set_trace_file_enabled(false);
> +    bool saved_enable = st_set_trace_file_enabled(false);
>  
>      g_free(trace_file_name);
>  
> @@ -361,7 +369,7 @@ void st_set_trace_file(const char *file)
>          trace_file_name = g_strdup_printf("%s", file);
>      }
>  
> -    st_set_trace_file_enabled(true);
> +    st_set_trace_file_enabled(saved_enable);
>  }
>  
>  void st_print_trace_file_status(void)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


