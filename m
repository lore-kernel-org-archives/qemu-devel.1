Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B52BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 06:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE44920773
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 06:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7BJPLe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE44920773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joLgk-0007os-MN
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 02:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joLft-0007P8-Mw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 02:47:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55292
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joLfr-0003mB-7H
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 02:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593067670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvIfa2DV1H2Ac1mwds9lcLObi4nycughU/DwVUrAlY8=;
 b=L7BJPLe0vtsG1ROy7GoseSalW8kB2GgrkRMmrSh7RVvb6xjcuQ5QG9OA8UBFXHfIEhmRyw
 okl8/MxKuJG+Tk0tf8Xav4mVwD/bs5tnEqrb80cLM/HyA4Q7QOxJoT+R4qEYQHLQuCnvDZ
 iqcov6NzFZ31enQWlNBuUzWLUu3Sbkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-YfOzclgPN4Sux28gmxCeHA-1; Thu, 25 Jun 2020 02:47:46 -0400
X-MC-Unique: YfOzclgPN4Sux28gmxCeHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 395A2BFC0;
 Thu, 25 Jun 2020 06:47:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 275E67167D;
 Thu, 25 Jun 2020 06:47:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A75EA11384D4; Thu, 25 Jun 2020 08:47:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: lichun <lichun@ruijie.com.cn>
Subject: Re: [PATCH v2] chardev/tcp: fix error message double free error
References: <20200621213017.17978-1-lichun@ruijie.com.cn>
Date: Thu, 25 Jun 2020 08:47:40 +0200
In-Reply-To: <20200621213017.17978-1-lichun@ruijie.com.cn>
 (lichun@ruijie.com.cn's message of "Mon, 22 Jun 2020 05:30:17 +0800")
Message-ID: <87pn9n3alv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@redhat.com, 706701795@qq.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

lichun <lichun@ruijie.com.cn> writes:

> Signed-off-by: lichun <lichun@ruijie.com.cn>
> ---
>  chardev/char-socket.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index afebeec5c3..569d54c144 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -142,6 +142,8 @@ static void check_report_connect_error(Chardev *chr,
>                            "Unable to connect character device %s: ",
>                            chr->label);
>          s->connect_err_reported =3D true;
> +    } else {
> +        error_free(err);
>      }
>      qemu_chr_socket_restart_timer(chr);
>  }
> @@ -1086,7 +1088,6 @@ static void qemu_chr_socket_connected(QIOTask *task=
, void *opaque)
>      if (qio_task_propagate_error(task, &err)) {
>          tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
>          check_report_connect_error(chr, err);
> -        error_free(err);
>          goto cleanup;
>      }

Since my "Error handling fixes & cleanups" series fixes similar errors.
I'm happy to merge this patch along with it.  Up to Marc-Andr=C3=A9.


