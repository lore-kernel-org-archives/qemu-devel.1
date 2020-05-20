Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8325FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD9320709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLSA2KLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD9320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRwj-00006P-GW
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbRwC-00087S-GW
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:51:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51098
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbRwA-0005rP-0z
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589993480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xM/id5ZbCUmOdTPRpHN6212KiN73mNdJMsEaZvrQUoQ=;
 b=HLSA2KLJHX9qqqIxtez1FR3ozv25g7HkcsJ3ZDUfhqsYcYNAQBZA7L7AYw9T+oR+jT8tyl
 I9YZgwmuREKFic4iz6URHBZwqLNkOK9bWLSvOODHwxJjZ39UD0zL6uhxEE6iMuZWbQ9KgH
 HrKruC3VMk9H4owUvuxZibXo3ttmKxs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-fw0e5b5_OP2i5fNy_olbdQ-1; Wed, 20 May 2020 12:51:16 -0400
X-MC-Unique: fw0e5b5_OP2i5fNy_olbdQ-1
Received: by mail-ed1-f69.google.com with SMTP id w15so917794edi.11
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 09:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xM/id5ZbCUmOdTPRpHN6212KiN73mNdJMsEaZvrQUoQ=;
 b=pE+iUUuZP4yuMphFG9lIcn4ubpuKngD8YcEgyzeaww9OS8UrIlcTQLaV4tEssS/MD8
 59V8Grv8Suki13NzhcuN5BaT+wJosU5P/CgYdZif7RbEAt8EEWQeqUumrtGUk6cZ6+Jm
 Rh/az/4ZFDKja+ucpDC2b+Yz7h/gNO3X6C6XpExHZeVmyhrtPvSnsJRzsstGGkn+Vkdk
 mkyeQRWRIRxZaemKYIrs+EbnnHA3kf1MzlEHG1bglBo/bYOcOs0tlV2RbFSnPBqeUcRE
 NQETHuMmT96Jcnrf+VhTso3Op4wZrQZM3JwB/DHKeJKeoCPL8E2R+V2qw1OS1S6XSEnd
 iFEw==
X-Gm-Message-State: AOAM5310BpK63Z/nf4/hKVtwJSDXhwUwAFB88VhHmORd0w7+sp1o2Fh4
 JH5NhbjGIQb4X9W0wvnD2NVkzn6f3aoW3vG+Yc4cLgPwLWwkMZqfoDKRSjKLnO0e1DYz8B3BCrD
 GTbFRSyLzgWJL5+U=
X-Received: by 2002:a50:98a3:: with SMTP id j32mr4330945edb.34.1589993475493; 
 Wed, 20 May 2020 09:51:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRimuYx53J+y1ILy/3/vtGjsYwRwreiEp+pxioVhfZDnrDvx1OROwZeXJa6NNhaemkbfqbIg==
X-Received: by 2002:a50:98a3:: with SMTP id j32mr4330925edb.34.1589993475268; 
 Wed, 20 May 2020 09:51:15 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id k3sm2198648edi.60.2020.05.20.09.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 09:51:14 -0700 (PDT)
Subject: Re: [PATCH 1/4] fuzz: add datadir for oss-fuzz compatability
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200512030133.29896-1-alxndr@bu.edu>
 <20200512030133.29896-2-alxndr@bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <18b02a81-1f0e-973a-1867-4ff30edbe128@redhat.com>
Date: Wed, 20 May 2020 18:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512030133.29896-2-alxndr@bu.edu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 5:01 AM, Alexander Bulekov wrote:
> This allows us to keep pc-bios in executable_dir/pc-bios, rather than
> executable_dir/../pc-bios, which is incompatible with oss-fuzz' file
> structure.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>   include/sysemu/sysemu.h |  2 ++
>   softmmu/vl.c            |  2 +-
>   tests/qtest/fuzz/fuzz.c | 15 +++++++++++++++
>   3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index ef81302e1a..cc96b66fc9 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -15,6 +15,8 @@ extern const char *qemu_name;
>   extern QemuUUID qemu_uuid;
>   extern bool qemu_uuid_set;
>   
> +void qemu_add_data_dir(const char *path);
> +
>   void qemu_add_exit_notifier(Notifier *notify);
>   void qemu_remove_exit_notifier(Notifier *notify);
>   
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index afd2615fb3..c71485a965 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -1993,7 +1993,7 @@ char *qemu_find_file(int type, const char *name)
>       return NULL;
>   }
>   
> -static void qemu_add_data_dir(const char *path)
> +void qemu_add_data_dir(const char *path)
>   {
>       int i;
>   
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index f5c923852e..33365c3782 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -137,6 +137,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>   {
>   
>       char *target_name;
> +    char *dir;
>   
>       /* Initialize qgraph and modules */
>       qos_graph_init();
> @@ -147,6 +148,20 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>       target_name = strstr(**argv, "-target-");
>       if (target_name) {        /* The binary name specifies the target */
>           target_name += strlen("-target-");
> +        /*
> +         * With oss-fuzz, the executable is kept in the root of a directory (we
> +         * cannot assume the path). All data (including bios binaries) must be
> +         * in the same dir, or a subdir. Thus, we cannot place the pc-bios so
> +         * that it would be in exec_dir/../pc-bios.
> +         * As a workaround, oss-fuzz allows us to use argv[0] to get the
> +         * location of the executable. Using this we add exec_dir/pc-bios to
> +         * the datadirs.

I don't understand well the problem. How do you run it?

> +         */
> +        dir = g_build_filename(g_path_get_dirname(**argv), "pc-bios", NULL);
> +        if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> +            qemu_add_data_dir(dir);
> +        }
> +        g_free(dir);
>       } else if (*argc > 1) {  /* The target is specified as an argument */
>           target_name = (*argv)[1];
>           if (!strstr(target_name, "--fuzz-target=")) {
> 


