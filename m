Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B65C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41792073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDvT/MFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41792073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIvuZ-0005yM-4x
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jIvtb-00055L-Rg
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jIvta-0001MH-Gv
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:00:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54525)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jIvta-0001Lf-DA
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585580409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RAOXFkl9ffxDrsBd90hMDNWafxydI4lsMUC8/U+IgFM=;
 b=bDvT/MFCQGkzpjGEHU0ahTjp0P+RcJphh/YxiBvIr3MWgbvVgckLskW0Pjc0T3gtOV/gMN
 OEhud3oa5GyNyID1sgzauxkbcTxibgfri9ron7ps1r/Q2MDtYr3u/ys/7dnbRvYbwI6oLw
 qSxSfQDMaKckfBCf9jEkDpfFsTkLJ9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-YxAwhhHoMNKoLf46qYBWOg-1; Mon, 30 Mar 2020 11:00:07 -0400
X-MC-Unique: YxAwhhHoMNKoLf46qYBWOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 153D11922022;
 Mon, 30 Mar 2020 15:00:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9156A5DA83;
 Mon, 30 Mar 2020 14:59:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2351211385E2; Mon, 30 Mar 2020 16:59:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH for-5.0 2/3] qmp: fix leak on callbacks that return both
 value and error
References: <20200325184723.2029630-1-marcandre.lureau@redhat.com>
 <20200325184723.2029630-3-marcandre.lureau@redhat.com>
Date: Mon, 30 Mar 2020 16:59:57 +0200
In-Reply-To: <20200325184723.2029630-3-marcandre.lureau@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 25 Mar 2020
 19:47:22 +0100")
Message-ID: <87pnctubv6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Direct leak of 4120 byte(s) in 1 object(s) allocated from:
>     #0 0x7fa114931887 in __interceptor_calloc (/lib64/libasan.so.6+0xb088=
7)
>     #1 0x7fa1144ad8f0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x588f0)
>     #2 0x561e3c9c8897 in qmp_object_add /home/elmarco/src/qemu/qom/qom-qm=
p-cmds.c:291
>     #3 0x561e3cf48736 in qmp_dispatch /home/elmarco/src/qemu/qapi/qmp-dis=
patch.c:155
>     #4 0x561e3c8efb36 in monitor_qmp_dispatch /home/elmarco/src/qemu/moni=
tor/qmp.c:145
>     #5 0x561e3c8f09ed in monitor_qmp_bh_dispatcher /home/elmarco/src/qemu=
/monitor/qmp.c:234
>     #6 0x561e3d08c993 in aio_bh_call /home/elmarco/src/qemu/util/async.c:=
136
>     #7 0x561e3d08d0a5 in aio_bh_poll /home/elmarco/src/qemu/util/async.c:=
164
>     #8 0x561e3d0a535a in aio_dispatch /home/elmarco/src/qemu/util/aio-pos=
ix.c:380
>     #9 0x561e3d08e3ca in aio_ctx_dispatch /home/elmarco/src/qemu/util/asy=
nc.c:298
>     #10 0x7fa1144a776e in g_main_context_dispatch (/lib64/libglib-2.0.so.=
0+0x5276e)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/qmp-dispatch.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index c30c7ff9e1..79347e0864 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -155,6 +155,8 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QObje=
ct *request,
>      cmd->fn(args, &ret, &err);
>      qobject_unref(args);
>      if (err) {
> +        /* or assert(!ret) after reviewing all handlers: */
> +        qobject_unref(ret);
>          goto out;
>      }

Returning both a value and an error is wrong.  We should assert to flush
out these errors.  Doing that close to the release would be imprudent,
though.

The next patch fixes the one known instance of this error pattern.  If
we want to guard against leaks for unknown instances in 5.0, then this
patch is okay.  I wouldn't bother myself.

If we keep this patch, its new comment should say TODO.  Paolo, perhaps
you can still fix that up.


