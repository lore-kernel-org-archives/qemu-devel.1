Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF17C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8422073B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hijwn8ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8422073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtSR-0007hc-W5
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdtLw-0002cz-Fa
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:32:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46295
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdtLv-0002I2-AY
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590575521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AVt01HXrdB+8fHDDTsd09q5b4DOu9jioBSw0WSFAwzk=;
 b=hijwn8ffWArjjlxQRLNpZcIVJXDchaWpErGWPWqyDSSpEJ4GXejQsuX32yBV5/XURVMSYr
 4EBk/YN3AfpiFJ913y+6TnNgUcHorWPRhZWYXRzgr7OSyOY96a6Y1gN/89BPjcY9NtMH+b
 FwKALCV7USbaOJAUOW8uU8YDF04ibjk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-aEQsy55aPUSYKW_fUU0MQw-1; Wed, 27 May 2020 06:32:00 -0400
X-MC-Unique: aEQsy55aPUSYKW_fUU0MQw-1
Received: by mail-wm1-f72.google.com with SMTP id v23so742525wmj.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 03:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=AVt01HXrdB+8fHDDTsd09q5b4DOu9jioBSw0WSFAwzk=;
 b=tDQrBIZQBjelo/44V4X+UDApzzSekcOlXiGuwNilMB8HjZxeQfYX9gw6wAAPZ3WRzP
 LHcYWmdz21BIKYhkMeCIIxxNqJ/KODWkUX8ScASmfMtxrvxJtBHsgEZ6idMM/Xq30JLx
 +szKy7jHBBP1QgbXoqFAPbzRk4sJJFMLGtaRQOFl4hDhImd2D46aPKv0q5XkmP5WOzDK
 mkXdjYmgqr9d28lTIjD7pPlHfrvlsllA9BxdQqD4BSelEfOwVIdDTSYMgMbZakRht6y6
 y9dfxqKXH5BM01VeNvgpdvETd7hoyO7iCAR10IxBzDcZML+ygCACgxkRJRSebAm9j/xy
 BpVw==
X-Gm-Message-State: AOAM530r3yKk2O+a9tgI1ip8P6wjuZ2VpzOf+qfR/rspsdkuIWdXYBcc
 UPPtEcBvucUVSXj32opPWp5o0agvi5y5CHObLLD7kYGGYpVRy/vakiyoBgc1dsEXE5bK9Lj07W3
 K92W5ce3M+zYNcJI=
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr3671873wmd.138.1590575519058; 
 Wed, 27 May 2020 03:31:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3dkURmAXEhZGPAM0MaGovjvBO8kWg5Yn+M5gS1JdYIY+vqi4ChK/O7NLA4ZVdQJgAEhBP0A==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr3671853wmd.138.1590575518809; 
 Wed, 27 May 2020 03:31:58 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id l5sm2247029wml.27.2020.05.27.03.31.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 03:31:58 -0700 (PDT)
Subject: Re: [PATCH 2/2] qom: Make "info qom-tree" show children sorted
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
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
Message-ID: <ad820bc6-437f-33c9-dc6f-3f325665d7cf@redhat.com>
Date: Wed, 27 May 2020 12:31:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200527084754.7531-3-armbru@redhat.com>
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
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 10:47 AM, Markus Armbruster wrote:
> "info qom-tree" prints children in unstable order.  This is a pain
> when diffing output for different versions to find change.  Print it
> sorted.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qom/qom-hmp-cmds.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index cd08233a4c..94bdee9a90 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -69,22 +69,25 @@ typedef struct QOMCompositionState {
>  
>  static void print_qom_composition(Monitor *mon, Object *obj, int indent);
>  
> -static int print_qom_composition_child(Object *obj, void *opaque)
> +static int qom_composition_compare(const void *a, const void *b, void *ignore)
>  {
> -    QOMCompositionState *s = opaque;
> +    return g_strcmp0(a ? object_get_canonical_path_component(a) : NULL,
> +                     b ? object_get_canonical_path_component(b) : NULL);
> +}
>  
> -    print_qom_composition(s->mon, obj, s->indent);
> +static int insert_qom_composition_child(Object *obj, void *opaque)
> +{
> +    GQueue *children = opaque;
>  
> +    g_queue_insert_sorted(children, obj, qom_composition_compare, NULL);
>      return 0;
>  }
>  
>  static void print_qom_composition(Monitor *mon, Object *obj, int indent)
>  {
> -    QOMCompositionState s = {
> -        .mon = mon,
> -        .indent = indent + 2,
> -    };
>      char *name;
> +    GQueue children;
> +    Object *child;
>  
>      if (obj == object_get_root()) {
>          name = g_strdup("");
> @@ -94,7 +97,12 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent)
>      monitor_printf(mon, "%*s/%s (%s)\n", indent, "", name,
>                     object_get_typename(obj));
>      g_free(name);
> -    object_child_foreach(obj, print_qom_composition_child, &s);
> +
> +    g_queue_init(&children);
> +    object_child_foreach(obj, insert_qom_composition_child, &children);
> +    while ((child = g_queue_pop_head(&children))) {
> +        print_qom_composition(mon, child, indent + 2);
> +    }
>  }
>  
>  void hmp_info_qom_tree(Monitor *mon, const QDict *dict)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


