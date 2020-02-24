Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830CEC35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473E520828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsIWjhGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473E520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6CI3-0005HF-96
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6CHI-0004eC-Nq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:52:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6CHH-0004Rr-I8
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:52:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21543
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6CHH-0004RY-Ef
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582545118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aYKPlPdCl47DeK3bKtPpf0d1xXE7UG8JlKfRaFMfe+Y=;
 b=dsIWjhGH44V/FJcQixshr+mWuAa0W4PKemD1ZdtMO/XknYtJxX9b1UEV6g4we33lWqWEzz
 iteSOZg2MTdfAIn0QosAQWRWyUbbqaNH5/BtPg8NfXekZ96aiqMeobvkYrCOFQvpt2yv4a
 H3d3H2jLGZq9bpe6lGLKj1K4c2RFXns=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-UghoXmYPO_2zZeLJu3RItw-1; Mon, 24 Feb 2020 06:51:57 -0500
X-MC-Unique: UghoXmYPO_2zZeLJu3RItw-1
Received: by mail-wr1-f69.google.com with SMTP id c6so5460149wrm.18
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 03:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aYKPlPdCl47DeK3bKtPpf0d1xXE7UG8JlKfRaFMfe+Y=;
 b=IazAdGyTchikAYV9ghF+60bgayLE7eBDT2PhP1INkdClJ8zgktvsRoi5hphYXHiktl
 65gSA2aZKecrOEXvwYz4vGYsmuhBlS2I5qQtibPdJF8L8pUMK0HzmfUXJrvfMUiEB1lg
 vZAgAurXspD5+aknn5HIXbCaL957qNkwL51WLp9w50H89BlMEQ1rF+uHdJmdWqr7lhdp
 Sd4+NlEt6ZWKzYV28vPe0PUCvGVtmsDGtHkj50OwkwzBif7hHMctQggQ5i93gv13nEmG
 c1P/IibNRd9vAvrdsYXjzJ1jP5hsRcOo8hj41BzHQLs1kyifPTmJ5d+8X4GqdltrqDbo
 TM6w==
X-Gm-Message-State: APjAAAVYePxMhZQK0kp6AgX3j+qLLfkOQDlQzNQSvm8nuplUBCOn/bpN
 PSxdYvfiln0VUTN4HFrFmhALsHIUYRi5s4P1ZAb7KGMkLV9zytNN98OcT6cfwuqebTCNRzETYWH
 LhFehAHXW6IgUDUE=
X-Received: by 2002:a7b:c935:: with SMTP id h21mr21170767wml.173.1582545116321; 
 Mon, 24 Feb 2020 03:51:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzG2c8Pr2ke7NAEICmAx3Gh1foJeB5uklkWpK5ADEv2nuCBVEMyZk3wklOgnK+S1KBTrzzM2Q==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr21170744wml.173.1582545116095; 
 Mon, 24 Feb 2020 03:51:56 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id l6sm11726692wrb.75.2020.02.24.03.51.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 03:51:55 -0800 (PST)
Subject: Re: [PATCH 1/2] qemu/queue.h: clear linked list pointers on remove
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200224103406.1894923-1-stefanha@redhat.com>
 <20200224103406.1894923-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0a6d15b1-7936-82a2-0d65-a1b77c4c5cc1@redhat.com>
Date: Mon, 24 Feb 2020 12:51:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224103406.1894923-2-stefanha@redhat.com>
Content-Language: en-US
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 11:34 AM, Stefan Hajnoczi wrote:
> Do not leave stale linked list pointers around after removal.  It's
> safer to set them to NULL so that use-after-removal results in an
> immediate segfault.
> 
> The RCU queue removal macros are unchanged since nodes may still be
> traversed after removal.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/qemu/queue.h | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index 294db54eb1..456a5b01ee 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -142,6 +142,8 @@ struct {                                                                \
>                   (elm)->field.le_next->field.le_prev =                   \
>                       (elm)->field.le_prev;                               \
>           *(elm)->field.le_prev = (elm)->field.le_next;                   \
> +        (elm)->field.le_next = NULL;                                    \
> +        (elm)->field.le_prev = NULL;                                    \
>   } while (/*CONSTCOND*/0)

OK.

>   
>   /*
> @@ -225,12 +227,15 @@ struct {                                                                \
>   } while (/*CONSTCOND*/0)
>   
>   #define QSLIST_REMOVE_HEAD(head, field) do {                             \
> -        (head)->slh_first = (head)->slh_first->field.sle_next;          \
> +        typeof((head)->slh_first) elm = (head)->slh_first;               \
> +        (head)->slh_first = elm->field.sle_next;                         \
> +        elm->field.sle_next = NULL;                                      \
>   } while (/*CONSTCOND*/0)
>   
>   #define QSLIST_REMOVE_AFTER(slistelm, field) do {                       \
> -        (slistelm)->field.sle_next =                                    \
> -            QSLIST_NEXT(QSLIST_NEXT((slistelm), field), field);         \
> +        typeof(slistelm) next = (slistelm)->field.sle_next;             \
> +        (slistelm)->field.sle_next = next->field.sle_next;              \
> +        next->field.sle_next = NULL;                                    \
>   } while (/*CONSTCOND*/0)
>   
>   #define QSLIST_REMOVE(head, elm, type, field) do {                      \
> @@ -241,6 +246,7 @@ struct {                                                                \
>           while (curelm->field.sle_next != (elm))                         \
>               curelm = curelm->field.sle_next;                            \
>           curelm->field.sle_next = curelm->field.sle_next->field.sle_next; \
> +        (elm)->field.sle_next = NULL;                                   \
>       }                                                                   \
>   } while (/*CONSTCOND*/0)
>   
> @@ -304,8 +310,10 @@ struct {                                                                \
>   } while (/*CONSTCOND*/0)
>   
>   #define QSIMPLEQ_REMOVE_HEAD(head, field) do {                          \
> -    if (((head)->sqh_first = (head)->sqh_first->field.sqe_next) == NULL)\
> +    typeof((head)->sqh_first) elm = (head)->sqh_first;                  \
> +    if (((head)->sqh_first = elm->field.sqe_next) == NULL)              \
>           (head)->sqh_last = &(head)->sqh_first;                          \

Here you check elm for NULL ...

> +    elm->field.sqe_next = NULL;                                         \

... then you assign it.

>   } while (/*CONSTCOND*/0)
>   
>   #define QSIMPLEQ_SPLIT_AFTER(head, elm, field, removed) do {            \
> @@ -329,6 +337,7 @@ struct {                                                                \
>           if ((curelm->field.sqe_next =                                   \
>               curelm->field.sqe_next->field.sqe_next) == NULL)            \
>                   (head)->sqh_last = &(curelm)->field.sqe_next;           \
> +        (elm)->field.sqe_next = NULL;                                   \
>       }                                                                   \
>   } while (/*CONSTCOND*/0)
>   
> @@ -446,6 +455,8 @@ union {                                                                 \
>               (head)->tqh_circ.tql_prev = (elm)->field.tqe_circ.tql_prev; \
>           (elm)->field.tqe_circ.tql_prev->tql_next = (elm)->field.tqe_next; \
>           (elm)->field.tqe_circ.tql_prev = NULL;                          \
> +        (elm)->field.tqe_circ.tql_next = NULL;                          \
> +        (elm)->field.tqe_next = NULL;                                   \
>   } while (/*CONSTCOND*/0)
>   
>   /* remove @left, @right and all elements in between from @head */
> 


