Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D5DC10DCE
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 00:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E954206E2
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 00:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcKnuxTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E954206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jANHK-0005Fr-1g
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 19:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jANAK-0003Ul-HE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 19:18:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jANAI-0000Me-Eg
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 19:18:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jANAI-0000Ii-9K
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 19:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583540281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wOMK3EzBye+JuPSGeIpXfTV4QB8BLvWei3+c47zVrWM=;
 b=VcKnuxTckqJW978W31d645jNFgwZo6t5RVT9xFN9ZDnAamIN+b1CnEzOpemyAwS/uIhsai
 47NuLIaryTezJ4A4Zg7A8LXp7TV95KTAcHrD+Ed2zWZ3BKNb/n5fAdRzQ/UvmWnweryJu+
 1MPHCZb2RArpQA92H3bVO2tY5s3Glxo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-CJ855SkqMZi7wwf9HdhKrQ-1; Fri, 06 Mar 2020 19:17:57 -0500
X-MC-Unique: CJ855SkqMZi7wwf9HdhKrQ-1
Received: by mail-wr1-f71.google.com with SMTP id 31so1730130wrq.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 16:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kDHFIaY63FjwwjfJ8Lr8fdR6vixc337sMIZVLZiZtZE=;
 b=mbwPr07/OkxPQORpVukVSzE/CbBMfLc3TWhAffUl3gsGojKQYiXlcZYGVMiaV9IwoW
 2Knxb4usz9/jmiOOJNqtBzBZJ7ml3N8kvCC+Gc/QcA3F+7gIuAOUuRZOA2TtKzIoCMV1
 d8RVE5VkXaozid6MvXeNI/gIpHRV5eNL1dyWZzmhsfpIn+4Ys+4LklrKdKzO1RqvViar
 LN4QHYxnhFKT4w+MTFXeRsu6FI1xUkIA0NQomRfqKuCE+gJk13H5/jvRsA0IicexMvQQ
 lZC1QKeiqBSBR8zooFwIiXkqBooJ3OGThd8FOCsr0ptmEIG0lqSngbjNdD0YhGgXMJju
 b8RA==
X-Gm-Message-State: ANhLgQ0CtCJSVuUVNNAc4+/bIuzfw8zcsCgsdfozQxFvtVn0tAyxK0/D
 gODh1Ds89SVHwCx1kysqa5itnnfn9m+dE7L28vgECHKYQv5ccz/79WUfEE1jT8S9X/BOVYGtZ3Q
 5Q9rJ332S5cRcZ8Q=
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr6356442wmc.8.1583540275847; 
 Fri, 06 Mar 2020 16:17:55 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvhdLJYo5/WfvgD1Tnh8+NJMCmxXoL0uKdcgTNQelQJXukM2267bfcnPHKa7qEQGb4SheLHzQ==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr6356418wmc.8.1583540275578; 
 Fri, 06 Mar 2020 16:17:55 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id n24sm10217844wra.61.2020.03.06.16.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 16:17:54 -0800 (PST)
Subject: Re: [PATCH] gdbstub: add support to Xfer:auxv:read: packet
To: Lirong Yuan <yuanzi@google.com>, qemu-devel@nongnu.org
References: <20200307000445.45265-1-yuanzi@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <289be6b2-8c38-987a-7c97-ed295df8744d@redhat.com>
Date: Sat, 7 Mar 2020 01:17:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200307000445.45265-1-yuanzi@google.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: jkz@google.com, alex.bennee@linaro.org, scw@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/7/20 1:04 AM, Lirong Yuan wrote:
> This allows gdb to access the target=E2=80=99s auxiliary vector,
> which can be helpful for telling system libraries important details
> about the hardware, operating system, and process.
>=20
> Signed-off-by: Lirong Yuan <yuanzi@google.com>
> ---
>   gdbstub.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index 22a2d630cd..c2865ea873 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2105,6 +2105,12 @@ static void handle_query_supported(GdbCmdContext *=
gdb_ctx, void *user_ctx)
>           pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
>                   ";qXfer:features:read+");
>       }
> +#ifdef CONFIG_USER_ONLY
> +    if (gdb_ctx->s->c_cpu->opaque) {
> +        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
> +                ";qXfer:auxv:read+");
> +    }
> +#endif
>  =20
>       if (gdb_ctx->num_params &&
>           strstr(gdb_ctx->params[0].data, "multiprocess+")) {
> @@ -2166,6 +2172,42 @@ static void handle_query_xfer_features(GdbCmdConte=
xt *gdb_ctx, void *user_ctx)
>       put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
>   }
>  =20
> +#ifdef CONFIG_USER_ONLY
> +static void handle_query_xfer_auxv(GdbCmdContext *gdb_ctx, void *user_ct=
x)
> +{
> +    TaskState *ts;
> +    unsigned long offset, len, saved_auxv, auxv_len;
> +    const char *mem;
> +
> +    if (gdb_ctx->num_params < 2) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    offset =3D gdb_ctx->params[0].val_ul;
> +    len =3D gdb_ctx->params[1].val_ul;
> +
> +    ts =3D gdb_ctx->s->c_cpu->opaque;
> +    saved_auxv =3D ts->info->saved_auxv;
> +    auxv_len =3D ts->info->auxv_len;

Maybe check we are in range first?

        if (offset + len > auxv_len) {
            put_packet(gdb_ctx->s, "E22");
            return;
        }

> +    mem =3D (const char *)(saved_auxv + offset);
> +
> +    if (len > (MAX_PACKET_LENGTH - 5) / 2) {
> +        len =3D (MAX_PACKET_LENGTH - 5) / 2;
> +    }
> +
> +    if (len < auxv_len - offset) {
> +        gdb_ctx->str_buf[0] =3D 'm';
> +        len =3D memtox(gdb_ctx->str_buf + 1, mem, len);
> +    } else {
> +        gdb_ctx->str_buf[0] =3D 'l';
> +        len =3D memtox(gdb_ctx->str_buf + 1, mem, auxv_len - offset);
> +    }
> +
> +    put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
> +}
> +#endif
> +
>   static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ct=
x)
>   {
>       put_packet(gdb_ctx->s, GDB_ATTACHED);
> @@ -2271,6 +2313,14 @@ static GdbCmdParseEntry gdb_gen_query_table[] =3D =
{
>           .cmd_startswith =3D 1,
>           .schema =3D "s:l,l0"
>       },
> +#ifdef CONFIG_USER_ONLY
> +    {
> +        .handler =3D handle_query_xfer_auxv,
> +        .cmd =3D "Xfer:auxv:read:",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "l,l0"
> +    },
> +#endif
>       {
>           .handler =3D handle_query_attached,
>           .cmd =3D "Attached:",
>=20


