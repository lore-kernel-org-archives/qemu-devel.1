Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59393C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DDF52189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDF52189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibNM-0007j1-Eg
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55586)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hib3p-0005Wu-MX
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hib3o-0006jS-7G
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:56:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hib3m-0006ae-GC
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:56:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id a10so712943wrp.9
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5hqKXw0WigrRDM/xfFgMojUW0/duKskBtxOPqigeWcw=;
 b=uFwWDkbgfsTeZDNUShZbKMv1oOHr9J4pwigIa9o85WAmz27n1o9T7gEMQAYKuv97mu
 g/L980/KXlkArve18oRhkPcX21nPrtjDfNCCQdBe+WiAo2Y1akCFlGQMAkEMZPCJ6mh8
 xYeatqicjEkAjxTbjBpSG4bho8LKmI7PCZrt/JJHgelGcmsZmGh/4IjcbRh1l11c+roh
 AelTDRnzI9GTCdhvTbJ6n7+lsKBpBTbTRdcD3XZo4fAhKNq6oEpDrBSarPYkxCsItMjK
 f51AnFSIhiDp+o6yqUugGd9Dn43G6wqtFaYOCHjoQGrvdLWnfRmtLG3kbyeI0L54sren
 zTRQ==
X-Gm-Message-State: APjAAAWfHITM1OrzZ5xxWCvx0cs16Qp22W44HxpCQUqib1qOUADtAc7B
 szf38vhZdcZnXRC+R3E+kauRJQ==
X-Google-Smtp-Source: APXvYqxRLurFUFdT0/F3EwipHLVNDnGsLNTGcxxb/tF1XaUUOaxCO+wbCWGOXegMwSxtDvBMXeIUkQ==
X-Received: by 2002:adf:a19e:: with SMTP id u30mr22783948wru.33.1562144172123; 
 Wed, 03 Jul 2019 01:56:12 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id g14sm1823903wro.11.2019.07.03.01.56.11
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 01:56:11 -0700 (PDT)
To: Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
References: <20190703013805.2722-1-chen.zhang@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bab54e27-0e4f-3701-1562-92b062f37415@redhat.com>
Date: Wed, 3 Jul 2019 10:56:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703013805.2722-1-chen.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 3:38 AM, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> Address Peter's comments in patch "COLO-compare:Add colo-compare
> remote notify support".

This comment is not useful in the git history (no reference).

You might reword him, use full coment, or simply:

Reported-by: Coverity (CID 1402785)

> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  net/colo-compare.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 909dd6c6eb..363b1edd11 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -1008,21 +1008,20 @@ static void compare_notify_rs_finalize(SocketReadState *notify_rs)
>  {
>      CompareState *s = container_of(notify_rs, CompareState, notify_rs);
>  
> -    /* Get Xen colo-frame's notify and handle the message */
> -    char *data = g_memdup(notify_rs->buf, notify_rs->packet_len);
> -    char msg[] = "COLO_COMPARE_GET_XEN_INIT";
> +    const char msg[] = "COLO_COMPARE_GET_XEN_INIT";
>      int ret;
>  
> -    if (!strcmp(data, "COLO_USERSPACE_PROXY_INIT")) {
> +    if (!strcmp((char *)notify_rs->buf, "COLO_USERSPACE_PROXY_INIT")) {
>          ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
>          if (ret < 0) {
>              error_report("Notify Xen COLO-frame INIT failed");
>          }
> -    }
> -
> -    if (!strcmp(data, "COLO_CHECKPOINT")) {
> +    } else if (!strcmp((char *)notify_rs->buf, "COLO_CHECKPOINT")) {
>          /* colo-compare do checkpoint, flush pri packet and remove sec packet */
>          g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> +    } else {
> +        error_report("COLO compare got unsupported instruction '%s'",
> +                     (char *)notify_rs->buf);
>      }
>  }
>  
> 

