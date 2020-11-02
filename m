Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326BDC4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBF221D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQQq8/eQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBF221D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbWJ-0007MT-Ud
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZbUw-0005qh-U6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:11:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZbUv-0006Ew-5z
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604329912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsaPR7/j/QS8+liIT0HTIJopWuYx4/UMRPz/YdD5+w8=;
 b=TQQq8/eQiPhayiuVm0xh3DJMz7Digc7gzKrOQSX7lAubbX9hHNBetKy/3PNmc8fyqlVTN1
 avBzH/9r5QQ1LwKa4Zrei/en+/j/WVCHXeDXm+pczF+P7Fx4JEH0lRcmd4Xb4Rzrs/pSfz
 /F2B211585lqnJklwnMLt9xnWwbkSDw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496--lRdOV8wOvKAxeq1Fl-cJQ-1; Mon, 02 Nov 2020 10:11:47 -0500
X-MC-Unique: -lRdOV8wOvKAxeq1Fl-cJQ-1
Received: by mail-ed1-f70.google.com with SMTP id c2so888182edw.21
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 07:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dsaPR7/j/QS8+liIT0HTIJopWuYx4/UMRPz/YdD5+w8=;
 b=Zy1uJC0dny5CKHljlWaAjXTbtRrogY6lh/jxuI9rAmQirApeeA4fhDYcyKEWNHQFnK
 PfAPNFOypHcvaifqMfpJmw7DfUMs/Av1wXp/n+DAmH+wXUyyQY5LA5X0SRZAuL1l6oc8
 t8sSCrHZdxREPnf7ZyGmce15HD9clLK7O0eNEUFE9ZkEGgkG04nH7iBxygBXEV0LlRBB
 OFvOt3dY5ZxHvxDGF/n8uq0LEVKwnkmiEOHNaTNRvWwJjcd6DlpzzqINT5RRLGivPU/0
 MFMAO34/k1hVA/Az0cIldNOJISGDTTOv7CU4A9Q6/+dvtta8+99JJam8F4HfCXCVwl37
 bK2A==
X-Gm-Message-State: AOAM531kaRqtgcUJfFETut2E0407P4zo104z4owPtND2eQPhY5vnMfwM
 JmLDTrzPGCfx+JhE1rIr0lUFeGipGpVhLqekzk0oBGyK6S84NrRRhv+HbMKWPJwH9Lssnn49US5
 kb3N8/jD3ZJ60vCM=
X-Received: by 2002:a50:9e86:: with SMTP id a6mr3152867edf.238.1604329906487; 
 Mon, 02 Nov 2020 07:11:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7jVUOPagzom0J4UCAEUfwFvTnBvzHa1CYL3o6ECz1n0yoAArpTLO+bKn4FyrDA0rctQ8n0g==
X-Received: by 2002:a50:9e86:: with SMTP id a6mr3152855edf.238.1604329906327; 
 Mon, 02 Nov 2020 07:11:46 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id la9sm1176414ejb.121.2020.11.02.07.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 07:11:45 -0800 (PST)
Subject: Re: [PATCH] virtiofsd: Seccomp: Add 'send' for syslog
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, virtio-fs@redhat.com, amulmek1@in.ibm.com,
 stefanha@redhat.com
References: <20201102150750.34565-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e1a007ed-7a9f-38cd-4003-144d0e99dd6e@redhat.com>
Date: Mon, 2 Nov 2020 16:11:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102150750.34565-1-dgilbert@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 4:07 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> On ppc it looks like syslog ends up using 'send' rather than 'sendto'.
> 
> Reference: https://github.com/kata-containers/kata-containers/issues/1050
> 
> Reported-by: amulmek1@in.ibm.com
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/passthrough_seccomp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/virtiofsd/passthrough_seccomp.c b/tools/virtiofsd/passthrough_seccomp.c
> index eb9af8265f..672fb72a31 100644
> --- a/tools/virtiofsd/passthrough_seccomp.c
> +++ b/tools/virtiofsd/passthrough_seccomp.c
> @@ -118,6 +118,7 @@ static const int syscall_whitelist[] = {
>  
>  /* Syscalls used when --syslog is enabled */
>  static const int syscall_whitelist_syslog[] = {

Is it worth restricting the syscall to POWER?

   #if defined(__powerpc64__)

> +    SCMP_SYS(send),

   #endif

>      SCMP_SYS(sendto),
>  };
>  
> 


