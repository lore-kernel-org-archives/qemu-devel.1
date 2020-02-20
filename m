Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F687C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA8620722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwpYB7Jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA8620722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4pxq-0000D8-9o
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4pvC-0005Bk-Mo
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:47:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4pvA-0007HZ-Sg
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:47:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22059
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4pvA-0007HH-KS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582220851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5MJDJCSApmEM161Uz0Leqmc4vmBLXNSRjpHFwHYLpug=;
 b=JwpYB7JyPmEdOyLdHanm9QLj7PSu8aOmZPhedYN02UtAl6RP9I5tCo06cpdhVwPIXt6Qde
 VeyPe0Kz6zc6ryCsxJcl6MD3QD62mRpLqe6B8hltGndGeGRGSdZpcdiZPcZCpVLIe6xrqI
 PakjZqiW6uDETCfDAov9ZvqBGNc909o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-M8m_t_3yPQiNOH2_vR3roA-1; Thu, 20 Feb 2020 12:47:29 -0500
Received: by mail-wr1-f71.google.com with SMTP id l1so2077338wrt.4
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 09:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yjTS1c7av9pPeA3s1aAtIRF/cx9k3CMavHRSlN9+IjM=;
 b=a/30cTBysJhpv0nJefpvWY4Lcjsrbs2XRQ3rhnH5VxarnnORTYF2lJXWcHo97MoPaT
 gcmxZcfaqnl2IBVBqQ34YdnDj1ljWDOERUoRMIIS5HVOM7XuhQ9Bq628puk0hOQIK0og
 Md1bQzP6DqkBuxFPDwVDRkFUbX5WGgXV3tokjGIYAGXBfisB1nH59rlj5gsLKum972gz
 6IKv2Pzyd5jaAUgJOKCShp8jzph9jMFPvuoevsNqZl39MQnLdroEs3b3YnMUqn8etzU4
 pIZn7Xy+Fruyx8RbHjnbqJ3iVrjSYxYPsN7GcoKMKvL1Lkax6K+B9BG5vpnDqXGqlNt9
 BIYQ==
X-Gm-Message-State: APjAAAXoTSTyIlP5dhkFuDyxIc6g33siC1jd7GhKyEX3u+hGSih/Klau
 OSVFUwUWRLsC+3aF8aqBbXPzUZ/Bwp7n7M8ADfLxS91QdivDn+C9jMHehF5oqQ2r6ykQssX3Ql1
 R9Fl3tStgsu1TJYs=
X-Received: by 2002:a05:600c:146:: with SMTP id
 w6mr5962084wmm.180.1582220847981; 
 Thu, 20 Feb 2020 09:47:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQSellGpX5zqi8xBQPMYtty91AFk25Zhzu0elx6iN+HlAl0WtEy1NTQ7Fc4rYvZjMbkCFLKg==
X-Received: by 2002:a05:600c:146:: with SMTP id
 w6mr5962070wmm.180.1582220847742; 
 Thu, 20 Feb 2020 09:47:27 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a184sm41534wmf.29.2020.02.20.09.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 09:47:27 -0800 (PST)
Subject: Re: [PATCH] tcg: gdbstub: Fix single-step issue on arm target
To: Changbin Du <changbin.du@gmail.com>, alex.bennee@linaro.org
References: <20200220155834.21905-1-changbin.du@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <269f16b4-e843-1058-4c3b-f11de45b04e1@redhat.com>
Date: Thu, 20 Feb 2020 18:47:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220155834.21905-1-changbin.du@gmail.com>
Content-Language: en-US
X-MC-Unique: M8m_t_3yPQiNOH2_vR3roA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/20/20 4:58 PM, Changbin Du wrote:
> Recently when debugging an arm32 system on qemu, I found sometimes the
> single-step command (stepi) is not working. This can be reproduced by
> below steps:
>   1) start qemu-system-arm -s -S .. and wait for gdb connection.
>   2) start gdb and connect to qemu. In my case, gdb gets a wrong value
>      (0x60) for PC.
>   3) After connected, type 'stepi' and expect it will stop at next ins.
>=20
> But, it has never stopped. This because:
>   1) We doesn't report =E2=80=98vContSupported=E2=80=99 feature to gdb ex=
plicitly and gdb
>      think we do not support it. In this case, gdb use a software breakpo=
int
>      to emulate single-step.
>   2) Since gdb gets a wrong initial value of PC, then gdb inserts a
>      breakpoint to wrong place (PC+4).
>=20
> Since we do support =E2=80=98vContSupported=E2=80=99 query command, so le=
t's tell gdb that
> we support it.
>=20
> Before this change, gdb send below 'Z0' packet to implement single-step:
> gdb_handle_packet: Z0,4,4
>=20
> After this change, gdb send "vCont;s.." which is expected:
> gdb_handle_packet: vCont?
> put_packet: vCont;c;C;s;S
> gdb_handle_packet: vCont;s:p1.1;c:p1.-1

You actually fixed this for all architectures :)

This has been annoying me on MIPS since more than a year...

I haven't checked the GDB protocol spec, but so far:
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>   gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index ce304ff482..adccd938e2 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2111,7 +2111,7 @@ static void handle_query_supported(GdbCmdContext *g=
db_ctx, void *user_ctx)
>           gdb_ctx->s->multiprocess =3D true;
>       }
>  =20
> -    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";multiprocess+"=
);
> +    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";vContSupported=
+;multiprocess+");
>       put_packet(gdb_ctx->s, gdb_ctx->str_buf);
>   }
>  =20
>=20


