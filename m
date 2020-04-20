Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E84C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D47F20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpuYwgZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D47F20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWyE-0004PF-BZ
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37066 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQWs2-0006Il-Nx
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:53:59 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQWs0-0004Pf-SV
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:53:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41682
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQWs0-0004JR-Ec
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587390834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mB2ao8i2YAh8yWyvMTvLyB+0Y6vZId++LN68zo9fN4g=;
 b=JpuYwgZQ/I5MXjH6lQ1dwRToyHn+dQj6b2Bw+YgOURVuXUPWiryOwa4KeAyMVaucv3ik/P
 iMroi0zBaO7a6E9tS6eEgnOxMYK6WxmqV/ZUZOe4few+0UaxcvrfJ+SStiD+5nuEUoP0xM
 AVdjEp+1yGazplj9kU0i/g9meuhWOlg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-Gk7IPs0eMlyWjE5wT74y4A-1; Mon, 20 Apr 2020 09:53:53 -0400
X-MC-Unique: Gk7IPs0eMlyWjE5wT74y4A-1
Received: by mail-wr1-f71.google.com with SMTP id p2so4982382wrx.12
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 06:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mB2ao8i2YAh8yWyvMTvLyB+0Y6vZId++LN68zo9fN4g=;
 b=UjQmDcqPhiwM+u9qVcnpUfvydE1gzMLn5tbTkpj9zs+1NJO0Ncd3bjBnx8YA/VB02q
 cj/eIkWWz8pK4o/fQq7Pd+XWrf4NTPtzdA/B9261wwE8dMJaWWktnLL5xV5jMxD4efb2
 LlyuisB0n6sLZq5Y4tUunawOteY+VFwJ0bSQvy8Za8+3AumEaxnl1PpCLVcdm0xWK1j0
 fPI1GsEWLotH9YozhTNhyOyfMhoFOJCIcQIyKlxv+2lj5ZBL49eNH4QzbjW6PayuQt1G
 ZzhmrZ9rA514BckbGVMjaRdS/yAKi/mZPmWHr2KpWugVaENkoQ/jK3bvTlNmuZv52mg6
 P5fw==
X-Gm-Message-State: AGi0Puathd+ZrKRdoodj8/bSJT82tQXu170cyxwbFUtSr+OlIX+eaYlF
 nvfXLMrNSVAcYn9TIHqrUekU3P07svVc/KyUE3pIdF1ScopM89wwXsJ4zNbV7OIG/35YatAi92D
 YlS+o1MuoYCn9+sk=
X-Received: by 2002:a7b:c118:: with SMTP id w24mr17225666wmi.173.1587390832232; 
 Mon, 20 Apr 2020 06:53:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypJzZ5bEu0jg4eBvua6Dqi5r6IBYxbg4UIo1O4/+dzLSYqD70C8sgUnuBxHgnXuAH8GjPYLBxQ==
X-Received: by 2002:a7b:c118:: with SMTP id w24mr17225648wmi.173.1587390831937; 
 Mon, 20 Apr 2020 06:53:51 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id s6sm1388560wmh.17.2020.04.20.06.53.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 06:53:51 -0700 (PDT)
Subject: Re: [PATCH 4/4] smbus: Fix spd_data_generate() for number of banks > 2
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0f9a89ea-9dad-023c-ab8f-2c5c5546e8f5@redhat.com>
Date: Mon, 20 Apr 2020 15:53:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200420132826.8879-5-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 3:28 PM, Markus Armbruster wrote:
> spd_data_generate() splits @ram_size bytes into @nbanks RAM banks of
> 1 << sz_log2 MiB each, like this:
> 
>      size = ram_size >> 20; /* work in terms of megabytes */
>      [...]
>      nbanks = 1;
>      while (sz_log2 > max_log2 && nbanks < 8) {
>          sz_log2--;
>          nbanks++;
>      }
> 
> Each iteration halves the size of a bank, and increments the number of
> banks.  Wrong: it should double the number of banks.
> 
> The bug goes back all the way to commit b296b664ab "smbus: Add a
> helper to generate SPD EEPROM data".
> 
> It can't bite because spd_data_generate()'s current users pass only
> @ram_size that result in *zero* iterations:
> 
>      machine     RAM size    #banks  type    bank size
>      fulong2e     256 MiB         1   DDR      256 MiB
>      sam460ex    2048 MiB         1   DDR2    2048 MiB
>                  1024 MiB         1   DDR2    1024 MiB
>                   512 MiB         1   DDR2     512 MiB
>                   256 MiB         1   DDR2     256 MiB
>                   128 MiB         1   SDR      128 MiB
>                    64 MiB         1   SDR       64 MiB
>                    32 MiB         1   SDR       32 MiB
> 
> Apply the obvious, minimal fix.  I admit I'm tempted to rip out the
> unused (and obviously untested) feature instead, because YAGNI.
> 
> Note that this is not the final result, as spd_data_generate() next
> increases #banks from 1 to 2 if possible.  This is done "to avoid a
> bug in MIPS Malta firmware".  We don't even use this function with
> machine type malta.  *Shrug*

We would like to but lack testing so instead keep old (now duplicated) 
code :(

It should be easy to write SPD EEPROM tests although.

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/i2c/smbus_eeprom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 07fbbf87f1..e199fc8678 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -229,7 +229,7 @@ uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size)
>       nbanks = 1;
>       while (sz_log2 > max_log2 && nbanks < 8) {
>           sz_log2--;
> -        nbanks++;
> +        nbanks *= 2;
>       }
>   
>       assert(size == (1ULL << sz_log2) * nbanks);
> 


