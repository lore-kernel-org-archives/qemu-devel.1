Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C89C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1929D20657
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDblGTla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1929D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZIpt-0003yy-Ac
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 14:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZIog-0003Uj-RB
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:42:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30842
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZIog-0006QG-13
 for qemu-devel@nongnu.org; Thu, 14 May 2020 14:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589481764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rpg5FQNn+c2UbJd0lwMSDFsyj0pY0NU8hfI/tx/CTzU=;
 b=BDblGTlaQKd44dBvj9XKAaklVo93J2VCaFgZLzNlOmmsnb+9oTfcVAkuSQ4qL9cKEqEVzF
 IjQFnNQz1Famm5DnYP8rrJTYMcfuJlilEA5OJoixIoxVeJAR0bevRuGfYhE89wcKBM+cRk
 JIMMXOafLKU9IbVLqMe0AQTr9Lt/abM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-GtwOoev6PE-zhQcI99ki8g-1; Thu, 14 May 2020 14:42:42 -0400
X-MC-Unique: GtwOoev6PE-zhQcI99ki8g-1
Received: by mail-wr1-f69.google.com with SMTP id z16so1048367wrq.21
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 11:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rpg5FQNn+c2UbJd0lwMSDFsyj0pY0NU8hfI/tx/CTzU=;
 b=WZyDw1tSOsDdBj3ddNmS6DwsjfsUXPWHdKk/USptM1Bpwl99y10asi8S9l4mZ+OnU/
 oXToqglVk2Caxdh74SMyrXZacdWuSM4LVwU8/epZPXRvUTVJ0t9aesOPa5zqPnjvOP3U
 zoVcdxjMCNqIxTZLJeYsZfZpW4FNEQxKkARlCYJ9uhT5cLdFIRcb6hK6HG4Un1pkH8pe
 N84n+COX5W2G/uDly2X09XmG2cJabGJ5PUwTjELY8gpbjorSCMkzCRqWvQ7vp1eb1V+c
 p4arbkJ3MN2tj1B13aFZ48ylg3t56rYHBA7BdxD6Cpd0qYfSQJhVdIeout9WbCGamzcR
 wfjQ==
X-Gm-Message-State: AOAM531FqT42HAqgZx2LKOcJozDJGg2K23hce7YsrcF8qYFJyL1yWd98
 hAq5rsPGJKPZE8FXF7BCbWhJwf1aXLe5bp+Ls9Cq7UUlaqKz/rJ39JqociETZu4jtdFElyEy7xp
 69hxQsMslr3BEfQ4=
X-Received: by 2002:a5d:658b:: with SMTP id q11mr6786446wru.112.1589481760717; 
 Thu, 14 May 2020 11:42:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVqMuOpbOZ5TM0iAUnZ96YVqQTcYrVUveQpByBveCvUF+ldOqnwUZrKTkQhKWWgXNaorhLOg==
X-Received: by 2002:a5d:658b:: with SMTP id q11mr6786433wru.112.1589481760565; 
 Thu, 14 May 2020 11:42:40 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q5sm5781426wra.36.2020.05.14.11.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 11:42:40 -0700 (PDT)
Subject: Re: [PATCH] msix: allow qword MSI-X table accesses
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20200514151648.877882-1-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3e68c7aa-93a9-ec68-5128-7f2b7461dec6@redhat.com>
Date: Thu, 14 May 2020 20:42:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514151648.877882-1-mst@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:31:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: jusual@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 5:16 PM, Michael S. Tsirkin wrote:
> PCI spec says:
> 
> For all accesses to MSI-X Table and MSI-X PBA fields, software must use
> aligned full DWORD or aligned full QWORD transactions; otherwise, the
> result is undefined.
> 
> However, since MSI-X was converted to use memory API, QEMU
> started blocking qword transactions, only allowing DWORD
> ones. Guests do not seem to use QWORD accesses, but let's
> be spec compliant.
> 
> Fixes: 95524ae8dc8f ("msix: convert to memory API")

9 years =)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   hw/pci/msix.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 29187898f2..e6a5559038 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -199,6 +199,9 @@ static const MemoryRegionOps msix_table_mmio_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .valid = {
>           .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
> +    .impl = {
>           .max_access_size = 4,
>       },
>   };
> @@ -227,6 +230,9 @@ static const MemoryRegionOps msix_pba_mmio_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .valid = {
>           .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
> +    .impl = {
>           .max_access_size = 4,
>       },
>   };
> 


