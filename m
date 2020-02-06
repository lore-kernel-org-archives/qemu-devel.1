Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AC1C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C429520658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyGEv0gY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C429520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34981 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izeHQ-0002bq-Tj
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izeGC-0000yt-74
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izeGB-0006KE-4s
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:19:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40105
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izeGB-0006GQ-0X
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580984386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=aAqlWyoIpQxTSGvdx3xhKNH2/8zol/m6HDWfLkkbzOY=;
 b=eyGEv0gYiBC4MfRMrwpjvXg/TY7lucwzie8mcogcFhjoP9Sef2ZTgk5eZLUoguxz0CgtXC
 QjnafoH2JG7X4ktYdFuoAwaOGQWg6sg91ru7Hl0dBP4ho/D7vADzgSPn/UlpWmwQu42Ern
 pOfMmCWh/QNuG6yAhx5riBhE6KkKG2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-hRM8m4EcP_CuZd5_wpqIeA-1; Thu, 06 Feb 2020 05:19:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC25F104FB6D;
 Thu,  6 Feb 2020 10:19:41 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EEFA60BEC;
 Thu,  6 Feb 2020 10:19:39 +0000 (UTC)
Subject: Re: [PATCH] tests/plugin: prevent uninitialized warning
To: kuhn.chenqun@huawei.com, qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <20200206093238.203984-1-kuhn.chenqun@huawei.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <85dc652f-1a54-bac4-6ed3-f6e6d6dd08a0@redhat.com>
Date: Thu, 6 Feb 2020 11:19:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200206093238.203984-1-kuhn.chenqun@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: hRM8m4EcP_CuZd5_wpqIeA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, richard.henderson@linaro.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/02/2020 10.32, kuhn.chenqun@huawei.com wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
>=20
> According to the glibc function requirements, we need initialise
>  the variable. Otherwise there will be compilation warnings:
>=20
> glib-autocleanups.h:28:3: warning: =E2=80=98out=E2=80=99 may be
> used uninitialized in this function [-Wmaybe-uninitialized]
>    g_free (*pp);
>    ^~~~~~~~~~~~
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
>  tests/plugin/bb.c   | 2 +-
>  tests/plugin/insn.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
> index f30bea08dc..8b9da23a04 100644
> --- a/tests/plugin/bb.c
> +++ b/tests/plugin/bb.c
> @@ -22,7 +22,7 @@ static bool do_inline;
> =20
>  static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
> -    g_autofree gchar *out;
> +    g_autofree gchar *out =3D NULL;
>      out =3D g_strdup_printf("bb's: %" PRIu64", insns: %" PRIu64 "\n",
>                            bb_count, insn_count);
>      qemu_plugin_outs(out);
> diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
> index 0a8f5a0000..c83b1c0157 100644
> --- a/tests/plugin/insn.c
> +++ b/tests/plugin/insn.c
> @@ -44,7 +44,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct q=
emu_plugin_tb *tb)
> =20
>  static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
> -    g_autofree gchar *out;
> +    g_autofree gchar *out =3D NULL;
>      out =3D g_strdup_printf("insns: %" PRIu64 "\n", insn_count);
>      qemu_plugin_outs(out);
>  }

Just a matter of taste, but I think in these simple cases, it would be
nicer to put everything in one line, e.g.:

    g_autofree gchar *out =3D g_strdup_printf("insns: %" PRIu64 "\n",
                                            insn_count);

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>


