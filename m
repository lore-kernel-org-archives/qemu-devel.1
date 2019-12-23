Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8852C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 07:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1CBC206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 07:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A3IPxwu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CBC206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijISJ-00028y-OW
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 02:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zxq_yx_007@163.com>) id 1ijIRD-0001hv-L0
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 02:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zxq_yx_007@163.com>) id 1ijIRA-0007d1-FV
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 02:47:33 -0500
Received: from m12-18.163.com ([220.181.12.18]:39601)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zxq_yx_007@163.com>) id 1ijIR9-0006ta-SE
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 02:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=L71vR
 WxqVPf7OkpJBsBr16Svylqd7aQX6uaLomO8ki8=; b=A3IPxwu1T218Rc5G0b98A
 7typVYHKqRpxKb+HmQlE6RuiBMfGoeM/0rAYnbKfGauuzeC5t51Wpsm/YOrL2S5k
 sAaq9XnpFYfFrEoEo/4/w/eYGCWlgmE0VXMNHvnTOcT/sEsv2wTlLWyxehsH8kE8
 LYAC02cMbH+IpyNS7grWXQ=
Received: from [10.11.32.153] (unknown [39.155.168.46])
 by smtp14 (Coremail) with SMTP id EsCowAAHHYztcABejUTrNQ--.1742S2;
 Mon, 23 Dec 2019 15:46:54 +0800 (CST)
Subject: Re: [PATCH v5 04/37] chardev: generate an internal id when none given
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
 <20191220134601.571905-5-marcandre.lureau@redhat.com>
From: xiaoqiang zhao <zxq_yx_007@163.com>
Message-ID: <de920b4c-88df-0f91-0aeb-231bb11424c2@163.com>
Date: Mon, 23 Dec 2019 15:46:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220134601.571905-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: EsCowAAHHYztcABejUTrNQ--.1742S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw45Wr4UXw4rCF1kXFyrWFg_yoW5ZFyUpr
 4UJFn0k3y8t3W7WwnIgF9FkryrAF48Gr4a9w1rA3WvvayDJ34DXrW293W0qr18Xr4Iqr4Y
 qay2gF48Wa1YkF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jAgAwUUUUU=
X-Originating-IP: [39.155.168.46]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiMw6UxlXl1LG7VwAAsW
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 220.181.12.18
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

在 2019/12/20 下午9:45, Marc-André Lureau 写道:
> Internally, qemu may create chardev without ID. Those will not be
> looked up with qemu_chr_find(), which prevents using qdev_prop_set_chr().
>
> Use id_generate(), to generate an internal name (prefixed with #), so
> no conflict exist with user-named chardev.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   chardev/char.c    | 32 ++++++++++++++++++++++++--------
>   include/qemu/id.h |  1 +
>   util/id.c         |  1 +
>   3 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 7b6b2cb123..e7e7492b0e 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -37,6 +37,7 @@
>   #include "qemu/help_option.h"
>   #include "qemu/module.h"
>   #include "qemu/option.h"
> +#include "qemu/id.h"
>   
>   #include "chardev/char-mux.h"
>   
> @@ -944,10 +945,10 @@ void qemu_chr_set_feature(Chardev *chr,
>       return set_bit(feature, chr->features);
>   }
>   
> -Chardev *qemu_chardev_new(const char *id, const char *typename,
> -                          ChardevBackend *backend,
> -                          GMainContext *gcontext,
> -                          Error **errp)
> +static Chardev *chardev_new(const char *id, const char *typename,
> +                            ChardevBackend *backend,
> +                            GMainContext *gcontext,
> +                            Error **errp)
>   {
>       Object *obj;
>       Chardev *chr = NULL;
> @@ -991,6 +992,21 @@ end:
>       return chr;
>   }
>   
> +Chardev *qemu_chardev_new(const char *id, const char *typename,
> +                          ChardevBackend *backend,
> +                          GMainContext *gcontext,
> +                          Error **errp)
> +{
> +    g_autofree char *genid = NULL;
> +
> +    if (!id) {
> +        genid = id_generate(ID_CHR);
> +        id = genid;
> +    }
> +
> +    return chardev_new(id, typename, backend, gcontext, errp);
> +}
> +
>   ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
>                                  Error **errp)
>   {
> @@ -1003,8 +1019,8 @@ ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
>           return NULL;
>       }
>   
> -    chr = qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc)),
> -                           backend, NULL, errp);
> +    chr = chardev_new(id, object_class_get_name(OBJECT_CLASS(cc)),
> +                      backend, NULL, errp);
>       if (!chr) {
>           return NULL;
>       }
> @@ -1061,8 +1077,8 @@ ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
>           return NULL;
>       }
>   
> -    chr_new = qemu_chardev_new(NULL, object_class_get_name(OBJECT_CLASS(cc)),
> -                               backend, chr->gcontext, errp);
> +    chr_new = chardev_new(NULL, object_class_get_name(OBJECT_CLASS(cc)),
> +                          backend, chr->gcontext, errp);
>       if (!chr_new) {
>           return NULL;
>       }
> diff --git a/include/qemu/id.h b/include/qemu/id.h
> index 40c70103e4..b55c406e69 100644
> --- a/include/qemu/id.h
> +++ b/include/qemu/id.h
> @@ -4,6 +4,7 @@
>   typedef enum IdSubSystems {
>       ID_QDEV,
>       ID_BLOCK,
> +    ID_CHR,
>       ID_MAX      /* last element, used as array size */
>   } IdSubSystems;
>   
> diff --git a/util/id.c b/util/id.c
> index af1c5f1b81..5addb4460e 100644
> --- a/util/id.c
> +++ b/util/id.c
> @@ -34,6 +34,7 @@ bool id_wellformed(const char *id)
>   static const char *const id_subsys_str[ID_MAX] = {
>       [ID_QDEV]  = "qdev",
>       [ID_BLOCK] = "block",
> +    [ID_CHR] = "chr",
>   };
>   
>   /*

Looks good to me.

Reviewed-by: xiaoqiang zhao <zxq_yx_007@163.com>



