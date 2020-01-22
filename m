Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2625C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F042071E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOLS9U0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F042071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuHvZ-0007hu-GK
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 10:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuHuk-0007Ck-8R
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuHui-0003UN-6g
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:27:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55514
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuHui-0003U1-39
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579706847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eTGchNada5z0iXz7CqU603oQOTdMG/a06JeM55nQdoo=;
 b=hOLS9U0mjxDUhLSJeuxBHAjk1fZ5hL0MS5hLNco0DA5EmI3hKQUdLWsapIJEX5p9Rk8Bvm
 QMZGzc/9phugz3r2DWleG+VYCosj4Th+wXbjmXSlDV89rTVDRQANCRMrpRpPjkPA+tmN9k
 Gwe7OCIrk8QvPify5xS8igqfXnspNt8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-GsVvZGhFOyWxvTdLHEhdzQ-1; Wed, 22 Jan 2020 10:27:25 -0500
Received: by mail-wr1-f72.google.com with SMTP id v17so3189312wrm.17
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 07:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tJv6evB77R4mlZE4+JfQU7yPOjXXkihIZjgbgPaP+cs=;
 b=hU0cgCzcKRhMjo3Uts15SVpZJzzkegUcvslxVZPOebJ2K8f/6qZawTUTf1gYljaKBJ
 6KyinBb5emmN8njerATct/GqUpPNezAjppRlqFBlqO4B7i3oIArbNo6t3QUft0xVhuk7
 p4Qa58fNIfeBaaG8lDvfDC9Zu9ZDlxcTjNja914JtB3cm4T0L4CC2ra5jfEATubdp0MG
 sQ2S2kw8KdGCkU+GyvwTiZICvseeiRBNV/TawUnp7oORXVT/WsVr78u1xv0z2o8DfDg9
 8xssmR1yin0lZHacNvxV5lnc9ybhYSvqRItCxe0ziaYHAkgbTQs0/8cJa6ol20QsBHfK
 0q7Q==
X-Gm-Message-State: APjAAAW8plGcBaThIVSrCE+sWnGOT/t6UbP16cMr+yV9SmTh1RATUTJJ
 n9QNBj6Qbh9x1CHg8NCHIKo3r//lTjnGfxckWAwSxAV+OapRWWG322comnEl4g2FjFwIm3JSWxp
 24Ca5LaOQpRU+4CI=
X-Received: by 2002:a7b:cd87:: with SMTP id y7mr3768567wmj.189.1579706843520; 
 Wed, 22 Jan 2020 07:27:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqypeyyQO6E7hi9hs7TsG6ogacl3B4aOPUGtEMw7hmPHixKAv+DcUQsFpEcgD/9y3NivlPs3Rg==
X-Received: by 2002:a7b:cd87:: with SMTP id y7mr3768539wmj.189.1579706843300; 
 Wed, 22 Jan 2020 07:27:23 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n28sm13193314wra.48.2020.01.22.07.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 07:27:22 -0800 (PST)
Subject: Re: [PATCH v2 061/109] virtiofsd: Add ID to the log with
 FUSE_LOG_DEBUG level
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-62-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <74b392da-5925-3139-81f6-e9cbaaf04d18@redhat.com>
Date: Wed, 22 Jan 2020 16:27:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121122433.50803-62-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: GsVvZGhFOyWxvTdLHEhdzQ-1
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 1:23 PM, Dr. David Alan Gilbert (git) wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>=20
> virtiofsd has some threads, so we see a lot of logs with debug option.
> It would be useful for debugging if we can identify the specific thread
> from the log.
>=20
> Add ID, which is got by gettid(), to the log with FUSE_LOG_DEBUG level
> so that we can grep the specific thread.
>=20
> The log is like as:
>=20
>    ]# ./virtiofsd -d -o vhost_user_socket=3D/tmp/vhostqemu0 -o source=3D/=
tmp/share0 -o cache=3Dauto
>    ...
>    [ID: 00000097]    unique: 12696, success, outsize: 120
>    [ID: 00000097] virtio_send_msg: elem 18: with 2 in desc of length 120
>    [ID: 00000003] fv_queue_thread: Got queue event on Queue 1
>    [ID: 00000003] fv_queue_thread: Queue 1 gave evalue: 1 available: in: =
65552 out: 80
>    [ID: 00000003] fv_queue_thread: Waiting for Queue 1 event
>    [ID: 00000071] fv_queue_worker: elem 33: with 2 out desc of length 80 =
bad_in_num=3D0 bad_out_num=3D0
>    [ID: 00000071] unique: 12694, opcode: READ (15), nodeid: 2, insize: 80=
, pid: 2014
>    [ID: 00000071] lo_read(ino=3D2, size=3D65536, off=3D131072)
>=20
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>    added rework as suggested by Daniel P. Berrang=C3=A9 during review
> ---
>   tools/virtiofsd/passthrough_ll.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 20b5a242cb..991de69334 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -42,6 +42,7 @@
>   #include <cap-ng.h>
>   #include <dirent.h>
>   #include <errno.h>
> +#include <glib.h>
>   #include <inttypes.h>
>   #include <limits.h>
>   #include <pthread.h>
> @@ -2267,10 +2268,17 @@ static void setup_nofile_rlimit(void)
>  =20
>   static void log_func(enum fuse_log_level level, const char *fmt, va_lis=
t ap)
>   {
> +    g_autofree char *localfmt =3D NULL;
> +
>       if (current_log_level < level) {
>           return;
>       }
>  =20
> +    if (current_log_level =3D=3D FUSE_LOG_DEBUG) {
> +        localfmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__NR_gett=
id), fmt);
> +        fmt =3D localfmt;
> +    }
> +
>       if (use_syslog) {
>           int priority =3D LOG_ERR;
>           switch (level) {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


