Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C27C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D2920848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d62KjyN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D2920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVV3j-0003aU-Ut
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVV1Y-0002Gs-Az
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 03:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVV1W-00020J-Bd
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 03:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603351712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P198mSN3KmlxZRdm+7A5VDYNS8UJ5B8MqZuJPsLXIbQ=;
 b=d62KjyN4RT8gU1f2v3cJ/dWzsXiilWaYbQDBryB1WxQKX5UxX/skdAtZw0lWDSWbJpI35X
 ITaXvZ4xa9TeqduYKE93UbEcZSBg2ZE718QLZe6uExAwkFyILa5WsB5mZ45D2u9+NrtyNn
 fCLfs4jMGEFMS4hUs/hUgXR5lDaYk5I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-ObCTLEpLP5yhoWfXYf2lKg-1; Thu, 22 Oct 2020 03:28:30 -0400
X-MC-Unique: ObCTLEpLP5yhoWfXYf2lKg-1
Received: by mail-wr1-f69.google.com with SMTP id k14so269545wrd.6
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 00:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P198mSN3KmlxZRdm+7A5VDYNS8UJ5B8MqZuJPsLXIbQ=;
 b=JNsHchUVYrK9qr5YBMY2HEsBzU8IM57yrIoU0Oyrw6Rjcjwpar3JCnGuQh4HAfFmtv
 /Tiq0HfToVIOmiHDZYwB4EdzmDILn6OPIcJJPZUYwAyBZu2UaZO44xVQaNTEQFy3ZfnG
 9pw+Qcf6IwBPZf+rCQM0cCoa8wx42j7wp+NpbgEA4LwWsRNKcFF7fnGjOq5boTXcm9E8
 GwoCxChhPd8hjct2P4tte3iRwXA94rYh/9aOrcNeNvjz53DJW3FFx0GrlKhLVlV1E7o1
 0Yt5GVr3QeF/2QxbJZkewzzVHnTkV0UU5Wg7Uhe1BDiW61gXZ4e6ENfL4mYMEy7cXF6C
 V4oQ==
X-Gm-Message-State: AOAM5306o313igR9/opmuMR6uxCfzdeItuhQ89/UozjBKznKBCpb5OXt
 7Kx1OFDULWLV58fJb4I8ouQBWnsDTRGOBtaiZvd1HtCPp5bYXCT4BYLEbhHBbxaMcLa92S+PFjw
 R91ahuwg0jMIDU+w=
X-Received: by 2002:a7b:ca50:: with SMTP id m16mr1178863wml.106.1603351709663; 
 Thu, 22 Oct 2020 00:28:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbIq4jr3kUxoySccGG2TdHnnfJCg9TjGShc3CgsRGnuFW15VCNUdSIcwr2UbrivoOdy2T6oQ==
X-Received: by 2002:a7b:ca50:: with SMTP id m16mr1178849wml.106.1603351709494; 
 Thu, 22 Oct 2020 00:28:29 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id z6sm1780724wmi.28.2020.10.22.00.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 00:28:28 -0700 (PDT)
Subject: Re: [PATCH 17/22] vl: load plugins as late as possible
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201021205716.2359430-1-pbonzini@redhat.com>
 <20201021205716.2359430-18-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ae8842bd-933f-0f8e-032d-b5b238079a16@redhat.com>
Date: Thu, 22 Oct 2020 09:28:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021205716.2359430-18-pbonzini@redhat.com>
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
> There is no need to load plugins in the middle of default device processing,
> move -plugin handling just before preconfig is entered.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   softmmu/vl.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 8577667b8f..75e57133ad 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -125,6 +125,7 @@ static const char *boot_order;
>   static const char *boot_once;
>   static const char *incoming;
>   static const char *loadvm;
> +static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
>   enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
>   int mem_prealloc; /* force preallocation of physical target memory */
>   int display_opengl;
> @@ -3064,12 +3065,18 @@ void qemu_finish_machine_init(void)
>       MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
>       DisplayState *ds;
>   
> +    /* from here on runstate is RUN_STATE_PRELAUNCH */
> +

Please move this comment in your patch #11:
"vl: move prelaunch part of qemu_init to a new function"

Then:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>       if (machine_class->default_ram_id && current_machine->ram_size &&
>           numa_uses_legacy_mem() && !current_machine->ram_memdev_id) {
>           create_default_memdev(current_machine, mem_path);
>       }
>   
> -    /* from here on runstate is RUN_STATE_PRELAUNCH */
> +    /* process plugin before CPUs are created, but once -smp has been parsed */
> +    if (qemu_plugin_load_list(&plugin_list)) {
> +        exit(1);
> +    }
> +
>       machine_run_board_init(current_machine);
>   
>       /*
> @@ -3196,7 +3203,6 @@ void qemu_init(int argc, char **argv, char **envp)
>       Error *err = NULL;
>       bool have_custom_ram_size;
>       BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
> -    QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
>   
>       qemu_add_opts(&qemu_drive_opts);
>       qemu_add_drive_opts(&qemu_legacy_drive_opts);
> @@ -4164,11 +4170,6 @@ void qemu_init(int argc, char **argv, char **envp)
>                                  machine_class->default_machine_opts, 0);
>       }
>   
> -    /* process plugin before CPUs are created, but once -smp has been parsed */
> -    if (qemu_plugin_load_list(&plugin_list)) {
> -        exit(1);
> -    }
> -
>       qemu_opts_foreach(qemu_find_opts("device"),
>                         default_driver_check, NULL, NULL);
>       qemu_opts_foreach(qemu_find_opts("global"),
> 


