Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554ECC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2149620730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEDBbNlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2149620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywtG-0003x8-An
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 07:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iywsM-00035H-Mf
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iywsK-0002zF-Ig
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:00:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45765
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iywsK-0002v3-De
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580817615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4S2zkpm53/TVfz2xRsw+6pWYB+pU/FKCFgcLc+uRZk=;
 b=QEDBbNlRIHG8+UUV+Xd1pnFb8g3iMitGpPDRRdbT2MkuHlvXjP+57+D1kwxU+ZUEMiV+AP
 0zAGsEQ2X42E1Z40NUPDr7WrgiYA9xxrk2YiEgzLfM6AC+z/M7E4pxF5z7SxwAw6d37Dtq
 5aVYmyZe0ZHUP+pGWlCoVivgrnF3lPE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-ZCMJkqHqOxS4_ZdPzoDUpQ-1; Tue, 04 Feb 2020 07:00:14 -0500
Received: by mail-wr1-f72.google.com with SMTP id a12so8379253wrn.19
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 04:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=30hVSMnZR5bfgZ6pQgCK+bXpNia0JJUOv+ErU52aR5Q=;
 b=csb4mCmj8rlvKST08gMHFC6X0DTyoMk9Vy+NC0hYz65nTnh4V7zibjjMJSmwwzr8nR
 4KpKUvs02mgGLbLj6cqDIcYRhIlKlZR+21E5YotOPlcvSNRPlbmA9vzfBvjxs+H/ERSY
 PcEosLraF8mx/InLOS5Kkd2PgbbuAp1yezxf77xGLQnrR/hSx1/E5Vf+wJy9yB0e+1IC
 ybBfhg5Ozt23OQvikv0W24C9syMLSls2hbtaRFh/zPUnZNR706OiwVFSOhPzI3MO9NSd
 yxdBxcKwAv7HQx/2ezYodsaxwofckzMtGBIUhdA3tZzJoErk9qdCd1iKQ2gAUnOvr1hY
 QYQg==
X-Gm-Message-State: APjAAAXOFnWp3TOc4vN5trtytcbIZdVg8R5md2opEup31R6XXivevYvd
 h/lBxBMW1837spHhBQrcSdyPkuFo4YyJ+jasrvtsTEVI+A55T3HAXmtuh2Z5So79UnSI1nhuZQq
 pAJgeaZHNZhPiiDY=
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr5761716wmi.51.1580817613089;
 Tue, 04 Feb 2020 04:00:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqa4vE17X8aqQE50rcbNADLDXfhTfHjsO+/nVcGtxV4SvWRqpAetj2K5s1lnwE3g87G6r6UQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr5761696wmi.51.1580817612845;
 Tue, 04 Feb 2020 04:00:12 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id g25sm4319149wmh.3.2020.02.04.04.00.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 04:00:12 -0800 (PST)
Subject: Re: [PATCH 2/4] virtiofsd: fv_create_listen_socket error path socket
 leak
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
References: <20200204110501.10731-1-dgilbert@redhat.com>
 <20200204110501.10731-3-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6cbd1174-86a5-f8b8-e6c1-8f091a6654f8@redhat.com>
Date: Tue, 4 Feb 2020 13:00:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204110501.10731-3-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: ZCMJkqHqOxS4_ZdPzoDUpQ-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 12:04 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> If we fail when bringing up the socket we can leak the listen_fd;
> in practice the daemon will exit so it's not really a problem.
>=20
> Fixes: Coverity CID 1413121
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   tools/virtiofsd/fuse_virtio.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.=
c
> index 80a6e929df..dd1c605dbf 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -916,6 +916,7 @@ static int fv_create_listen_socket(struct fuse_sessio=
n *se)
>       old_umask =3D umask(0077);
>       if (bind(listen_sock, (struct sockaddr *)&un, addr_len) =3D=3D -1) =
{
>           fuse_log(FUSE_LOG_ERR, "vhost socket bind: %m\n");
> +        close(listen_sock);
>           umask(old_umask);
>           return -1;
>       }
> @@ -923,6 +924,7 @@ static int fv_create_listen_socket(struct fuse_sessio=
n *se)
>  =20
>       if (listen(listen_sock, 1) =3D=3D -1) {
>           fuse_log(FUSE_LOG_ERR, "vhost socket listen: %m\n");
> +        close(listen_sock);
>           return -1;
>       }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


