Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D54C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E6020863
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eseRlfAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E6020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1CVR-0004GG-Tq
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 12:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1CUM-00039D-Lh
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1CUK-0004Dh-Nw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:04:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1CUK-0004D4-JP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581354288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRJazcuaeU92nNmsUIqobWHhrho1n1srR6SJ1RBY4f8=;
 b=eseRlfAcM4ZtCRWn40SfUQzqqkGoJ4KQgUxfIgXU+Q/yUvJWKiqNHggxBwKzsyqWQsqW31
 RvU5WhQqv6ujSIZkK4CnHJHFZQPD/3DjRjnFmbZVQdRH4KSSksJFRyL1p7awep0LBpV1eD
 DS6FdO/P34pKeUSOVN6Ob/cvQ/zOWYE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-v1WYjSGpPA-zyhPlt00S1g-1; Mon, 10 Feb 2020 12:04:44 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so5274460wrm.18
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 09:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aRJazcuaeU92nNmsUIqobWHhrho1n1srR6SJ1RBY4f8=;
 b=S/YSk4ZBd2t/LrchMVTizOOicn0hh7l+Z3ruD94xx1dnLUDZTNbjjhBKjfuZjVRkoC
 lDWcxM9Amxb2SA6d7FVq8RuU8ZdoY9wwFrwWypZDMWc27E+b05sWRY8DGpyC4s9kZqek
 CZeSu8eROlHcS5Mhr1KksbjDb1PvVS9YheLc9xGvpaPPg8TX3lrTXkN7hWEegmBmGAHc
 JjUCUyrEEq0K7cQaiAouw+Xw0dlMxsFa1k8zeZDSnfak3y1XTORf3AqdwjBh0on2zdBq
 K3ErcPbl05IcgbFMol/eHJxiTf8zrsKUvJz8zYtG1oKbMS/Vl0TWjGyAiyjHqCKNlh+V
 FHvw==
X-Gm-Message-State: APjAAAWAtfvD9Vfx4QWNHmf3U56s7bOTVk853N5BKYLxptwSxCeNWJhF
 HOBg2lMBOkLHotFBMvaF+wTUbiX4yxSZFtk6rFfn3bVFF8zSXRjPIB1fIt+p+lfS6CLC09s9gH/
 AgVR+Uxwe8crX71I=
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr16232069wmi.21.1581354283620; 
 Mon, 10 Feb 2020 09:04:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPnv+HLbF8Cmb34VPV3xTfNL1i0uvN7nIB6lfidtDu7K1xlve9WTA67/K9NPnUWnD7+f9wWw==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr16232060wmi.21.1581354283382; 
 Mon, 10 Feb 2020 09:04:43 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id c9sm1226252wrq.44.2020.02.10.09.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 09:04:42 -0800 (PST)
Subject: Re: [PATCH v5 81/80] mips/mips_jazz: add max ram size check
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <09243f48-76bb-2c8a-52b6-d7c1375cdb55@amsat.org>
 <1581347177-88501-1-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ae091f24-f420-acfa-6c8b-d809d00bc154@redhat.com>
Date: Mon, 10 Feb 2020 18:04:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581347177-88501-1-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: v1WYjSGpPA-zyhPlt00S1g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: aleksandar.rikalo@rt-rk.com, hpoussin@reactos.org, amarkovic@wavecomp.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 4:06 PM, Igor Mammedov wrote:
> error out in case user asked for more RAM than board
> supports.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: philmd@redhat.com
> CC: hpoussin@reactos.org
> CC: aleksandar.rikalo@rt-rk.com
> CC: aurelien@aurel32.net
> CC: amarkovic@wavecomp.com
> 
> 
>   hw/mips/mips_jazz.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 85d49cf..32fbd10 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -164,6 +164,11 @@ static void mips_jazz_init(MachineState *machine,
>       SysBusESPState *sysbus_esp;
>       ESPState *esp;
>   
> +    if (machine->ram_size > 256 * MiB) {
> +        error_report("RAM size more than 256Mb is not supported");
> +        exit(EXIT_FAILURE);
> +    }
> +
>       /* init CPUs */
>       cpu = MIPS_CPU(cpu_create(machine->cpu_type));
>       env = &cpu->env;
> 

Thanks :)

Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>


