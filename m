Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5943FC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DFA20661
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuDm9TEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DFA20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRtG-00041J-B2
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:42:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isRrx-0002kQ-Bz
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isRrs-0004xB-R4
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:41:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32975
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isRrs-0004wB-MO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579268455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07RTHvBHE4VNC9jCjfontt3M2n7z1N4EXWkvTtXywdk=;
 b=HuDm9TEVs8lL418p+dTFEuC7WF6MnuoHFJ9AsrTfcVPRKv5BevYbz9rYnGNg7efMa4ovvE
 UPN+MJs4FN7RJT1X9xtYqrBlUZrlarLIEVx/HMwIKf3ewjiGgP+QmVs4t8kjhBZlnI1zYD
 +ddlDD7K3sy2KBUqONzouF5YUvlkAqY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-__kkDFV-MRyedEsBaPCCQQ-1; Fri, 17 Jan 2020 08:40:54 -0500
Received: by mail-wr1-f71.google.com with SMTP id t3so10470945wrm.23
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=07RTHvBHE4VNC9jCjfontt3M2n7z1N4EXWkvTtXywdk=;
 b=rxwXHbi6L/ECHzjg37pxhBgbAT66AY2li+nfrnQkrI0bylfd4ZKsqdGpyvyytHcxPj
 UMFFLSxZcDILp0QBajY756xkVkLDcbiZLXkIN8I/IcF/cPhjRQEG+HI6sqvkHFb1dsDC
 uGrvYSVoYcVPZtEW9CdhW+NstnUt5tUfpvAvAhkWrj/nOI6rXuMUgdM3yfDjjgc8mZkR
 MJkVr5HVaVy5FzErepZ+7SWkx9gOUSl1916R85iMFEg6Yfqk00iNX18fzCtXUHRnyh7k
 98t08Jsf8xxMwIKcKYARsg30K1fsI4LLeeW1tU6w4mXbDoioGGgu6o82nXPL2bt/lL57
 TXdw==
X-Gm-Message-State: APjAAAXLZeauwFkKM4GZFuuy7fv12RYtLrc7oOlAOhVKXhUBrmHSqyqh
 7WTD7LwilJWbnIQvymWsDmt/UJibN85R+jduETrkjdIN80OGgUh1/IZjrrVq2mEe3AuBZfwmv8k
 eJ8TNrfBm93xAsgY=
X-Received: by 2002:a05:600c:214f:: with SMTP id
 v15mr4724155wml.110.1579268452983; 
 Fri, 17 Jan 2020 05:40:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqx493g8s/LQRyA/WdT7Yi2O3EAIjVzby+wmczFtRmbIWgj6UD3eERoQR4EVHe8CA2ha7kuhwA==
X-Received: by 2002:a05:600c:214f:: with SMTP id
 v15mr4724135wml.110.1579268452753; 
 Fri, 17 Jan 2020 05:40:52 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id u8sm9749149wmm.15.2020.01.17.05.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 05:40:52 -0800 (PST)
Subject: Re: [PATCH 101/104] virtiofsd: prevent FUSE_INIT/FUSE_DESTROY races
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-102-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <73aa1b6c-612e-363e-dd49-04d1ba4f88f8@redhat.com>
Date: Fri, 17 Jan 2020 14:40:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-102-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: __kkDFV-MRyedEsBaPCCQQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 12/12/19 5:39 PM, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> When running with multiple threads it can be tricky to handle
> FUSE_INIT/FUSE_DESTROY in parallel with other request types or in
> parallel with themselves.  Serialize FUSE_INIT and FUSE_DESTROY so that
> malicious clients cannot trigger race conditions.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tools/virtiofsd/fuse_i.h        |  1 +
>   tools/virtiofsd/fuse_lowlevel.c | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> index d0679508cd..8a4a05b319 100644
> --- a/tools/virtiofsd/fuse_i.h
> +++ b/tools/virtiofsd/fuse_i.h
> @@ -61,6 +61,7 @@ struct fuse_session {
>       struct fuse_req list;
>       struct fuse_req interrupts;
>       pthread_mutex_t lock;
> +    pthread_rwlock_t init_rwlock;
>       int got_destroy;
>       int broken_splice_nonblock;
>       uint64_t notify_ctr;
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
> index 10f478b00c..9f01c05e3e 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -2431,6 +2431,19 @@ void fuse_session_process_buf_int(struct fuse_session *se,
>       req->ctx.pid = in->pid;
>       req->ch = ch ? fuse_chan_get(ch) : NULL;
>   
> +    /*
> +     * INIT and DESTROY requests are serialized, all other request types
> +     * run in parallel.  This prevents races between FUSE_INIT and ordinary
> +     * requests, FUSE_INIT and FUSE_INIT, FUSE_INIT and FUSE_DESTROY, and

typo "FUSE_INIT and FUSE_INIT" -> "FUSE_INIT and CUSE_INIT"?

> +     * FUSE_DESTROY and FUSE_DESTROY.
> +     */
> +    if (in->opcode == FUSE_INIT || in->opcode == CUSE_INIT ||
> +        in->opcode == FUSE_DESTROY) {
> +        pthread_rwlock_wrlock(&se->init_rwlock);
> +    } else {
> +        pthread_rwlock_rdlock(&se->init_rwlock);
> +    }
> +
>       err = EIO;
>       if (!se->got_init) {
>           enum fuse_opcode expected;
> @@ -2488,10 +2501,13 @@ void fuse_session_process_buf_int(struct fuse_session *se,
>       } else {
>           fuse_ll_ops[in->opcode].func(req, in->nodeid, &iter);
>       }
> +
> +    pthread_rwlock_unlock(&se->init_rwlock);
>       return;
>   
>   reply_err:
>       fuse_reply_err(req, err);
> +    pthread_rwlock_unlock(&se->init_rwlock);
>   }
>   
>   #define LL_OPTION(n, o, v)                     \
> @@ -2538,6 +2554,7 @@ void fuse_session_destroy(struct fuse_session *se)
>               se->op.destroy(se->userdata);
>           }
>       }
> +    pthread_rwlock_destroy(&se->init_rwlock);
>       pthread_mutex_destroy(&se->lock);
>       free(se->cuse_data);
>       if (se->fd != -1) {
> @@ -2631,6 +2648,7 @@ struct fuse_session *fuse_session_new(struct fuse_args *args,
>       list_init_req(&se->list);
>       list_init_req(&se->interrupts);
>       fuse_mutex_init(&se->lock);
> +    pthread_rwlock_init(&se->init_rwlock, NULL);
>   
>       memcpy(&se->op, op, op_size);
>       se->owner = getuid();
> 


