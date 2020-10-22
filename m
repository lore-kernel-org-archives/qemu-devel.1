Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC32C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DED8222E9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+C/EC19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DED8222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVUwl-0000kR-5e
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVUvy-0000CE-WF
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 03:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVUvq-0008JD-N4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 03:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603351361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9uz6J9G9iJGh9S+u6LWEyz7xjXbPbZc0YRAgDswiZc=;
 b=c+C/EC19k3iq4cXLopHDkwVyKJ/pv65X2I1EfpEQciZ7t6isw4XvMnVOBCZKan7qRNDrWJ
 NiZIe8R5D+lG70tFJ69emY/Cl29fUF723gUPIxZ8CsRJqzCIRHMfLQrEBc/5BcNc1X4aKK
 euiGnc9WSKR9mGZ5VeDk2yT49u8175c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-gGa84bMyN02xG1idNOEvlg-1; Thu, 22 Oct 2020 03:22:38 -0400
X-MC-Unique: gGa84bMyN02xG1idNOEvlg-1
Received: by mail-wr1-f71.google.com with SMTP id x16so261887wrg.7
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 00:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D9uz6J9G9iJGh9S+u6LWEyz7xjXbPbZc0YRAgDswiZc=;
 b=t9uBBxUPas+uaHq7qloRt4pq5jI9EccnTHnbzKRfn02tcaYEI/NNdM2tJUHptVLEjK
 d5UEoF4/8mGY8yFSnKYOqvZEldCIPVL60eI1UOXPmgfuSfgNeyRc5EMKNSJViAbGmeZo
 mSTG5+EsmXTj5xCER4jMWXShegT7bdhVHkebdX5jJW2KEE72+/4XMdk/TP7le5nqQqrD
 zf8aUu6KRQjzU8xSGvzP/L5BDlcNMREHTbNG7LGDS/6as26pVigZIVf+wG7lusbm45mE
 LJNe6T8AcqZsMQJQ3ciNVqS4AlObbypf638+E1+E5zV6IVuxH714EYfY1qJio4NMAD61
 fzdA==
X-Gm-Message-State: AOAM531B4f4jREB6X9FsjmQ/DkmL5xqVub7F8WymFGb4/YKkV06TgCWb
 lZ8JTqyR6dBB3XeeOq8OnHbLPE9LoCw72J6NEb0U8ijsr1pV/gN8j8ZoNpBXNZxwSlVmgHjkF9W
 ZUWf4PPxRJTkKhFE=
X-Received: by 2002:a1c:b6d5:: with SMTP id g204mr1145284wmf.65.1603351357287; 
 Thu, 22 Oct 2020 00:22:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJNh71jcFh4E173RJ3BtGb7f0jkCAhrHp5Kcqe3DP2yknl6EpdUW7h74l4Yvvz3J6/WU8cFA==
X-Received: by 2002:a1c:b6d5:: with SMTP id g204mr1145264wmf.65.1603351357038; 
 Thu, 22 Oct 2020 00:22:37 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p67sm1853646wmp.11.2020.10.22.00.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 00:22:36 -0700 (PDT)
Subject: Re: [PATCH 12/22] vl: move bios_name out of softmmu/vl.c
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201021205716.2359430-1-pbonzini@redhat.com>
 <20201021205716.2359430-13-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ec9dc887-b36f-de59-b1be-c16250c101b4@redhat.com>
Date: Thu, 22 Oct 2020 09:22:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021205716.2359430-13-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, jsnow@redhat.com, ehabkost@redhat.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 10:57 PM, Paolo Bonzini wrote:
> bios_name is a legacy variable used by machine code.  Hide it
> from softmmu/vl.c.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/core/machine.c | 5 +++++
>   softmmu/vl.c      | 2 --
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 3c674bb05e..e4dac350d4 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -212,6 +212,8 @@ GlobalProperty hw_compat_2_1[] = {
>   };
>   const size_t hw_compat_2_1_len = G_N_ELEMENTS(hw_compat_2_1);
>   
> +const char *bios_name = NULL;

I expect checkpatch.pl to complain "do not zero-initialize global".

> +
>   static char *machine_get_kernel(Object *obj, Error **errp)
>   {
>       MachineState *ms = MACHINE(obj);
> @@ -396,6 +398,9 @@ static void machine_set_firmware(Object *obj, const char *value, Error **errp)
>   
>       g_free(ms->firmware);
>       ms->firmware = g_strdup(value);
> +
> +    /* HACK */

With a slightly better rationale explanation:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +    bios_name = ms->firmware;
>   }
>   
>   static void machine_set_suppress_vmdesc(Object *obj, bool value, Error **errp)
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 52e7d317d7..e32e209a82 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -123,7 +123,6 @@ static int data_dir_idx;
>   static const char *mem_path;
>   static const char *boot_order;
>   static const char *boot_once;
> -const char *bios_name = NULL;
>   enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
>   int display_opengl;
>   const char* keyboard_layout = NULL;
> @@ -4314,7 +4313,6 @@ void qemu_init(int argc, char **argv, char **envp)
>       kernel_filename = qemu_opt_get(machine_opts, "kernel");
>       initrd_filename = qemu_opt_get(machine_opts, "initrd");
>       kernel_cmdline = qemu_opt_get(machine_opts, "append");
> -    bios_name = qemu_opt_get(machine_opts, "firmware");
>   
>       opts = qemu_opts_find(qemu_find_opts("boot-opts"), NULL);
>       if (opts) {
> 


