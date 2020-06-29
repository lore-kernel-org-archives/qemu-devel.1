Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7BDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B825F248F4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuVH7goi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B825F248F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvgr-0007ha-Sn
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvg7-0007Bm-AO
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:26:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29614
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvg5-0001t4-35
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593444396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjpPm5i8DrXvqauCBbjiqxOHZNosF8BrnGtzLwOEkXU=;
 b=GuVH7goisudq/Dhg7QmmGgFaPg5paydFBzE5OtP+mgJ4Bq2GroXtTaoyO1sJFrWErM9n/4
 JXfeKWObSkRM0DtalRh47u2L25BST6G5h5TxUZWp/A6Dpt2YHviRaGAAXB23ZbAeALv90Z
 hww3zK7DLy6lSIplHqZBfSKOaTWaJbc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-as8e8fwfML-y2vrEbmUXCA-1; Mon, 29 Jun 2020 11:26:32 -0400
X-MC-Unique: as8e8fwfML-y2vrEbmUXCA-1
Received: by mail-wr1-f69.google.com with SMTP id h28so16598706wrc.18
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 08:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gjpPm5i8DrXvqauCBbjiqxOHZNosF8BrnGtzLwOEkXU=;
 b=ptLZm+uzUVuIqtlGkjXdzxuJHn/OIxF9+qv5V7cjDLHj50Y0t1Z824tzl3S1ZZuaZw
 6oVlUQd0LEypnKy+44jTtfbeesYgApDe96zIJMSrYWR7aC43S5KAPxHc+k+RXRYliGxU
 +rNiAO+ZhRVTexi+9UhE4029ymbPEJAD5/cMdKqmW7EtNzfpSjcczAE4meOR7KIfj6jD
 Gr5oVYRChcY/ETjPVSNJrjvnqOqB0Oara8clp02pgBSHeHn1N0YhJlh+noBlk9GM0/Sg
 /R2vZ1AvvYxKLKUhkzIpBExRG8OKSlDDUr9jcJIyLaNC9LgfnhtJJL5ywfN/iMEcMmXd
 Ll9Q==
X-Gm-Message-State: AOAM533P9YYeo1ePc3prW1ULpRpiVHU89wD4c9WhlUcj6cdEkq9zprSe
 eJW4JBU02PFdo6DjfHmfcpShc7zUKSfm3SckmJ9ZC99ky7+7fgokztPGbmJuWgyaUGQ1tsrBXlT
 yASa4D7SpTaCHZnU=
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr16750803wrm.379.1593444390989; 
 Mon, 29 Jun 2020 08:26:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4BAe2GuAxPrdbIrsJminBbaYHb/fo2l5BpmByQliGIYPRhKaG6QFzHz3t7kF8x8EwUkZ01w==
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr16750774wrm.379.1593444390656; 
 Mon, 29 Jun 2020 08:26:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id c11sm112424wmb.45.2020.06.29.08.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 08:26:30 -0700 (PDT)
Subject: Re: [PATCH] util/qemu-error: prepend guest name to error message to
 identify affected VM owner
To: Mario Smarduch <msmarduch@digitalocean.com>, qemu-devel@nongnu.org,
 armbru@redhat.com
References: <20200626201900.8876-1-msmarduch@digitalocean.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5107c448-54b3-8009-2aea-0c2317c86045@redhat.com>
Date: Mon, 29 Jun 2020 17:26:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200626201900.8876-1-msmarduch@digitalocean.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/06/20 22:19, Mario Smarduch wrote:
> This is followup patch to the one submitted back in Oct, 19
> 
> https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg02102.html
> 
> My mistake here, I took my eyes of the mailing list after I got the
> initial thumbs up. This patch follows up on Markus comments in the
> above link.
> 
> Purpose of this patch:
> 
> We want to print guest name for errors, warnings and info messages. This 
> was the first of two patches the second being MCE errors targeting a VM 
> with guest name prepended. But in a large fleet we see many other
> errors that disable a VM or crash it. In a large fleet and centralized
> logging having the guest name enables identify of owner and customer.
> 
> Signed-off-by: Mario Smarduch <msmarduch@digitalocean.com>
> ---
> Test verification summary:
> 
> a) qemu-system-x86_64 -msg help
>   guest-name=<bool (on/off)> - Prepends guest name for error messages but only if -name <guestname> is set otherwise option is ignored
> 
>   timestamp=<bool (on/off)>
> 
> b) qemu-system-x86_64 -help
> -msg [timestamp[=on|off]][,guest-name=[on|off]]
>                 control error message format
>                 timestamp=on enables timestamps (default: off)
>                 guest-name=on enables guest name prefix but only if
>                               -name guest option is set (default: off)
> 
> c) man qemu
>        -msg [timestamp[=on|off]][,guest-name[=on|off]]
>               Control error message format.
> 
>               timestamp=on|off
>                      Prefix messages with a timestamp. Default is off.
> 
>               guest-name=on|off
>                      Prefix  messages  with guest name but only if -name guest
>                      option is set otherwise the option is ignored. Default is
>                      off.
> d) command options
> ./x86_64-softmmu/qemu-system-x86_64 -msg timestamp
> 2020-06-26T01:01:23.140294Z qemu-system-x86_64: Testing ERROR...
> 
> ./x86_64-softmmu/qemu-system-x86_64 -msg timestamp,guest-name
> 2020-06-26T01:02:30.301431Z qemu-system-x86_64: Testing ERROR...
> 
> ./x86_64-softmmu/qemu-system-x86_64 -msg timestamp,guest-name \
>                                     -name guest=DROPLET-123
> 2020-06-26T01:04:37.720380Z DROPLET-1234 qemu-system-x86_64: Testing ERROR...
> 
> ./x86_64-softmmu/qemu-system-x86_64 -msg timestamp=off,guest-name=off \
>                                     -name guest=DROPLET-123
> qemu-system-x86_64: Testing ERROR...
> 
> ./x86_64-softmmu/qemu-system-x86_64 -msg timestamp=on,guest-name=off \
>                                     -name guest=DROPLET-123
> 2020-06-26T01:06:33.888859Z qemu-system-x86_64: Testing ERROR...
> 
> ./x86_64-softmmu/qemu-system-x86_64 -msg timestamp=off,guest-name=on \
>                                     -name guest=DROPLET-123
> DROPLET-1234 qemu-system-x86_64: Testing ERROR...
> 
> ./x86_64-softmmu/qemu-system-x86_64 -msg timestamp=on,guest-name=on \
>                                     -name guest=DROPLET-123
> 2020-06-26T01:09:31.116283Z DROPLET-1234 qemu-system-x86_64: Testing ERROR... 
> 
> 
>  include/qemu/error-report.h |  2 ++
>  qemu-options.hx             | 12 +++++++++---
>  softmmu/vl.c                |  9 +++++++++
>  util/qemu-error.c           |  7 +++++++
>  4 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> index 87532d8596..a5ad95ff1b 100644
> --- a/include/qemu/error-report.h
> +++ b/include/qemu/error-report.h
> @@ -75,5 +75,7 @@ void error_init(const char *argv0);
>  const char *error_get_progname(void);
>  
>  extern bool error_with_timestamp;
> +extern bool error_with_guestname;
> +extern const char *error_guest_name;
>  
>  #endif
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 93bde2bbc8..ff75510b7c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4290,16 +4290,22 @@ HXCOMM Deprecated by -accel tcg
>  DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
>  
>  DEF("msg", HAS_ARG, QEMU_OPTION_msg,
> -    "-msg timestamp[=on|off]\n"
> +    "-msg [timestamp[=on|off]][,guest-name=[on|off]]\n"
>      "                control error message format\n"
> -    "                timestamp=on enables timestamps (default: off)\n",
> +    "                timestamp=on enables timestamps (default: off)\n"
> +    "                guest-name=on enables guest name prefix but only if\n"
> +    "                              -name guest option is set (default: off)\n",
>      QEMU_ARCH_ALL)
>  SRST
> -``-msg timestamp[=on|off]``
> +``-msg [timestamp[=on|off]][,guest-name[=on|off]]``
>      Control error message format.
>  
>      ``timestamp=on|off``
>          Prefix messages with a timestamp. Default is off.
> +
> +    ``guest-name=on|off``
> +        Prefix messages with guest name but only if -name guest option is set
> +        otherwise the option is ignored. Default is off.
>  ERST
>  
>  DEF("dump-vmstate", HAS_ARG, QEMU_OPTION_dump_vmstate,
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index f669c06ede..3f7aad89c3 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -389,6 +389,12 @@ static QemuOptsList qemu_msg_opts = {
>              .name = "timestamp",
>              .type = QEMU_OPT_BOOL,
>          },
> +        {
> +            .name = "guest-name",
> +            .type = QEMU_OPT_BOOL,
> +            .help = "Prepends guest name for error messages but only if "
> +                    "-name guest is set otherwise option is ignored\n",
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -1109,6 +1115,7 @@ static void realtime_init(void)
>  static void configure_msg(QemuOpts *opts)
>  {
>      error_with_timestamp = qemu_opt_get_bool(opts, "timestamp", false);
> +    error_with_guestname = qemu_opt_get_bool(opts, "guest-name", false);
>  }
>  
>  
> @@ -3578,6 +3585,8 @@ void qemu_init(int argc, char **argv, char **envp)
>                  if (!opts) {
>                      exit(1);
>                  }
> +                /* Capture guest name if -msg guest-name is used later */
> +                error_guest_name = qemu_opt_get(opts, "guest");
>                  break;
>              case QEMU_OPTION_prom_env:
>                  if (nb_prom_envs >= MAX_PROM_ENVS) {
> diff --git a/util/qemu-error.c b/util/qemu-error.c
> index dac7c7dc50..017288b6c9 100644
> --- a/util/qemu-error.c
> +++ b/util/qemu-error.c
> @@ -26,6 +26,8 @@ typedef enum {
>  
>  /* Prepend timestamp to messages */
>  bool error_with_timestamp;
> +bool error_with_guestname;
> +const char *error_guest_name;
>  
>  int error_printf(const char *fmt, ...)
>  {
> @@ -213,6 +215,11 @@ static void vreport(report_type type, const char *fmt, va_list ap)
>          g_free(timestr);
>      }
>  
> +    /* Only prepend guest name if -msg guest-name and -name guest=... are set */
> +    if (error_with_guestname && error_guest_name && !cur_mon) {
> +        error_printf("%s ", error_guest_name);
> +    }
> +
>      print_loc();
>  
>      switch (type) {
> 

Queued, thanks.

Paolo


