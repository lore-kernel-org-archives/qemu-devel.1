Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88800C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD5C20709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLlQty5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD5C20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDO8n-0007Or-BY
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDO81-0006VE-LX
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:28:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDO7z-0004WL-1m
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599035302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EpyqrikJnziNzKEJ7zAl1NUL78OgKLqOfvxCCG0bCLU=;
 b=CLlQty5QBxEQE5Z8CrgfJmk7d3vCtwFAJcYeo4zOAQevCv+PR7CFPr8ejobrqk19SVsRAv
 xl+Smz3YlKkmLX6/QysC33/HCL6dIM4yF3oBR7IBSkwJl87ikZ51PF2tcUdz0T7mbwf+iI
 jNjCIJvxiZH+vpdrF4umUz2qJJaZQrc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-AliPPYu_P-WJVQshE-f2SA-1; Wed, 02 Sep 2020 04:28:20 -0400
X-MC-Unique: AliPPYu_P-WJVQshE-f2SA-1
Received: by mail-wm1-f70.google.com with SMTP id q7so1322887wmc.6
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=EpyqrikJnziNzKEJ7zAl1NUL78OgKLqOfvxCCG0bCLU=;
 b=uNwU5DUD6VlykLYvD7e454akjIeECrOVXpmd6twQ9BTQFdtU4FHIMsaF5e7Dw756A6
 uqfaW6W4hfIlp3n2inLq/jvhN8iMDqA0YbZW1sV0ZUBhP7H3IAk8E7eVv+b5sU11lnCD
 76P6o7Botaj9uvA5I0a6cZIuxUFqjbNr/gLV4Mb5buWzL7D5rxL+ghUKkp6kUVSIFJ64
 s1+ATpxXBYpyuosFjoIWVNcWF14XZCv9ZydhIzYwrL0dB93grKhmhLDI7XCzOLUiFSAx
 /vbcMXDssjor/vmXKxTIZzjLRmA7cJXa+ku2MpOkP/q2OhssmJhWir6n3TRy/SZtWhPN
 +NSw==
X-Gm-Message-State: AOAM5302aPf6I0uZbHPU1eLf/wl5Vkd3UPLrwtz639HWNETtuNupK4t/
 pqCwX27+Dv454DS85/tcUSTLLpSbbkZ46vTLTvv01dv6brZJfJjWQMRciRip5e080Ku96ovJQWu
 v0guFKMHcXX3cyrQ=
X-Received: by 2002:adf:83c3:: with SMTP id 61mr5761690wre.287.1599035299178; 
 Wed, 02 Sep 2020 01:28:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfAkPzzqPwTT4kaNDjn7A05dX8vK9vlK/+QjeAW4XbSCM+WLvvWX50wmLwSpwnvA9s+vbsPg==
X-Received: by 2002:adf:83c3:: with SMTP id 61mr5761669wre.287.1599035298886; 
 Wed, 02 Sep 2020 01:28:18 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id c206sm5332545wmf.47.2020.09.02.01.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 01:28:18 -0700 (PDT)
Subject: Re: [PATCH 08/13] vl: relocate paths to data directories
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200901062020.26660-1-pbonzini@redhat.com>
 <20200901062020.26660-9-pbonzini@redhat.com>
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
Message-ID: <daeab859-fb07-fbb1-1b7d-79ed75578f2c@redhat.com>
Date: Wed, 2 Sep 2020 10:28:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901062020.26660-9-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 8:20 AM, Paolo Bonzini wrote:
> As an additional advantage, the logic is now unified between
> POSIX and Win32 systems.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu-common.h   |  1 -
>  include/sysemu/sysemu.h |  2 +-
>  os-posix.c              | 20 --------------------
>  os-win32.c              | 11 -----------
>  softmmu/vl.c            | 40 ++++++++++++++++++++++++++++------------
>  tests/qtest/fuzz/fuzz.c |  5 +++--
>  6 files changed, 32 insertions(+), 47 deletions(-)
> 
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index bb9496bd80..b856bfcec4 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -131,7 +131,6 @@ char *qemu_find_file(int type, const char *name);
>  
>  /* OS specific functions */
>  void os_setup_early_signal_handling(void);
> -char *os_find_datadir(void);
>  int os_parse_cmd_args(int index, const char *optarg);
>  
>  /*
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 4b6a5c459c..817ff4cf75 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -14,7 +14,7 @@ extern const char *qemu_name;
>  extern QemuUUID qemu_uuid;
>  extern bool qemu_uuid_set;
>  
> -void qemu_add_data_dir(const char *path);
> +void qemu_add_data_dir(char *path);
>  
>  void qemu_add_exit_notifier(Notifier *notify);
>  void qemu_remove_exit_notifier(Notifier *notify);
> diff --git a/os-posix.c b/os-posix.c
> index 8d8e7fc15c..af91089c01 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -80,26 +80,6 @@ void os_setup_signal_handling(void)
>      sigaction(SIGTERM, &act, NULL);
>  }
>  
> -/*
> - * Find a likely location for support files using the location of the binary.
> - * When running from the build tree this will be "$bindir/pc-bios".
> - * Otherwise, this is CONFIG_QEMU_DATADIR.
> - *
> - * The caller must use g_free() to free the returned data when it is
> - * no longer required.
> - */
> -char *os_find_datadir(void)
> -{
> -    g_autofree char *dir = NULL;
> -
> -    dir = g_build_filename(qemu_get_exec_dir(), "pc-bios", NULL);
> -    if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> -        return g_steal_pointer(&dir);
> -    }
> -
> -    return g_strdup(CONFIG_QEMU_DATADIR);
> -}
> -
>  void os_set_proc_name(const char *s)
>  {
>  #if defined(PR_SET_NAME)
> diff --git a/os-win32.c b/os-win32.c
> index eb8501b9e5..fd1137bab1 100644
> --- a/os-win32.c
> +++ b/os-win32.c
> @@ -57,17 +57,6 @@ void os_setup_early_signal_handling(void)
>      atexit(os_undo_timer_resolution);
>  }
>  
> -/*
> - * Look for support files in the same directory as the executable.
> - *
> - * The caller must use g_free() to free the returned data when it is
> - * no longer required.
> - */
> -char *os_find_datadir(void)
> -{
> -    return g_strdup(qemu_get_exec_dir());
> -}
> -
>  void os_set_line_buffering(void)
>  {
>      setbuf(stdout, NULL);
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 0cc86b0766..81e325fa44 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2005,7 +2005,7 @@ char *qemu_find_file(int type, const char *name)
>      return NULL;
>  }
>  
> -void qemu_add_data_dir(const char *path)
> +void qemu_add_data_dir(char *path)

But we have 'const char *data_dir[16];', why remove the const?

>  {
>      int i;
>  
> @@ -2017,10 +2017,11 @@ void qemu_add_data_dir(const char *path)
>      }
>      for (i = 0; i < data_dir_idx; i++) {
>          if (strcmp(data_dir[i], path) == 0) {
> -            return; /* duplicate */
> +            g_free(path); /* duplicate */
> +            return;
>          }
>      }
> -    data_dir[data_dir_idx++] = g_strdup(path);
> +    data_dir[data_dir_idx++] = path;
>  }
>  
>  static inline bool nonempty_str(const char *str)
> @@ -2829,6 +2830,26 @@ static void create_default_memdev(MachineState *ms, const char *path)
>                              &error_fatal);
>  }
>  
> +/*
> + * Find a likely location for support files using the location of the binary.
> + * When running from the build tree this will be "$bindir/pc-bios".
> + * Otherwise, this is CONFIG_QEMU_DATADIR (possibly relocated).
> + *
> + * The caller must use g_free() to free the returned data when it is
> + * no longer required.
> + */
> +static char *find_datadir(void)
> +{
> +    g_autofree char *dir = NULL;
> +
> +    dir = g_build_filename(qemu_get_exec_dir(), "pc-bios", NULL);
> +    if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> +        return g_steal_pointer(&dir);
> +    }
> +
> +    return get_relocated_path(CONFIG_QEMU_DATADIR);
> +}
> +
>  void qemu_init(int argc, char **argv, char **envp)
>  {
>      int i;
> @@ -2862,7 +2883,7 @@ void qemu_init(int argc, char **argv, char **envp)
>      Error *main_loop_err = NULL;
>      Error *err = NULL;
>      bool list_data_dirs = false;
> -    char *dir, **dirs;
> +    char **dirs;
>      const char *mem_path = NULL;
>      bool have_custom_ram_size;
>      BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
> @@ -3195,7 +3216,7 @@ void qemu_init(int argc, char **argv, char **envp)
>                  if (is_help_option(optarg)) {
>                      list_data_dirs = true;
>                  } else {
> -                    qemu_add_data_dir(optarg);
> +                    qemu_add_data_dir(g_strdup(optarg));
>                  }
>                  break;
>              case QEMU_OPTION_bios:
> @@ -3927,17 +3948,12 @@ void qemu_init(int argc, char **argv, char **envp)
>      /* add configured firmware directories */
>      dirs = g_strsplit(CONFIG_QEMU_FIRMWAREPATH, G_SEARCHPATH_SEPARATOR_S, 0);
>      for (i = 0; dirs[i] != NULL; i++) {
> -        qemu_add_data_dir(dirs[i]);
> +        qemu_add_data_dir(get_relocated_path(dirs[i]));
>      }
>      g_strfreev(dirs);
>  
>      /* try to find datadir relative to the executable path */
> -    dir = os_find_datadir();
> -    qemu_add_data_dir(dir);
> -    g_free(dir);
> -
> -    /* add the datadir specified when building */
> -    qemu_add_data_dir(CONFIG_QEMU_DATADIR);
> +    qemu_add_data_dir(find_datadir());
>  
>      /* -L help lists the data directories and exits. */
>      if (list_data_dirs) {
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index 1811cb1d88..d9ef4b3e1e 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -170,8 +170,9 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>          datadir = g_build_filename(bindir, "pc-bios", NULL);
>          if (g_file_test(datadir, G_FILE_TEST_IS_DIR)) {
>              qemu_add_data_dir(datadir);
> -        }
> -        g_free(datadir);
> +        } else {
> +            g_free(datadir);
> +	}
>      } else if (*argc > 1) {  /* The target is specified as an argument */
>          target_name = (*argv)[1];
>          if (!strstr(target_name, "--fuzz-target=")) {
> 


