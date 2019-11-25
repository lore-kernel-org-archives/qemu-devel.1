Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1693DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5ED52082F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbmAty/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5ED52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZDXW-0002No-Jw
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 07:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iZDVk-00019Z-Q5
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iZDVi-00042S-W3
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:30:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50414
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iZDVi-000425-K6
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574685030;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hH0ytavy2jwiUc2UJnGfIJ6CbhqbQyX1Vo+H3VqaR0M=;
 b=QbmAty/ThIjaKjhrG/wf8e6ElTBUxGOu1nhjD7S2moUa74WNFOs82mM2cd3d4WkSAbz4Qo
 5rVirZx1dmq7LuiZ41vnGCiWPKbkHk2m0gILg4BGqcGGaWrvpHrMbKU41X2h4UKhI7HqO3
 xkkRwGb2IPvDFU7bc4K3z5Qnb3zR/5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-BBdL9iw-Mh2fuknznsQyeQ-1; Mon, 25 Nov 2019 07:30:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66AEC8C3DDD;
 Mon, 25 Nov 2019 12:30:26 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1B815D9CA;
 Mon, 25 Nov 2019 12:30:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH] migration/ram: Yield periodically to the main loop
In-Reply-To: <20191125120548.13589-1-yury-kotov@yandex-team.ru> (Yury Kotov's
 message of "Mon, 25 Nov 2019 15:05:48 +0300")
References: <20191125120548.13589-1-yury-kotov@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Mon, 25 Nov 2019 13:30:23 +0100
Message-ID: <87y2w42l5s.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: BBdL9iw-Mh2fuknznsQyeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Reply-To: quintela@redhat.com
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yury Kotov <yury-kotov@yandex-team.ru> wrote:
> Usually, incoming migration coroutine yields to the main loop
> when it's IO-channel waits for data to receive. But there is a case
> when RAM migration and data receive have the same speed: VM with huge
> zeroed RAM. In this case, IO-channel won't read and thus the main loop
> is stuck and for example, it doesn't respond to QMP commands.
>
> For this case, yield periodically, but not too often, so as not to
> affect the speed of migration.


Ouchhhhh

As a workaround, I agree.

As a final solution, I think that it is best to just move the incoming
migration to its own thread, we get trouble like this from time to time :-(


>
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>  migration/ram.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 5078f94490..fed6ef4b22 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4227,7 +4227,7 @@ static void colo_flush_ram_cache(void)
>   */
>  static int ram_load_precopy(QEMUFile *f)
>  {
> -    int flags =3D 0, ret =3D 0, invalid_flags =3D 0, len =3D 0;
> +    int flags =3D 0, ret =3D 0, invalid_flags =3D 0, len =3D 0, i =3D 0;
>      /* ADVISE is earlier, it shows the source has the postcopy capabilit=
y on */
>      bool postcopy_advised =3D postcopy_is_advised();
>      if (!migrate_use_compression()) {
> @@ -4239,6 +4239,17 @@ static int ram_load_precopy(QEMUFile *f)
>          void *host =3D NULL;
>          uint8_t ch;
> =20
> +        /*
> +         * Yield periodically to let main loop run, but an iteration of
> +         * the main loop is expensive, so do it each some iterations
> +         */
> +        if ((i & 32767) =3D=3D 0) {
> +            aio_co_schedule(qemu_get_current_aio_context(),
> +                            qemu_coroutine_self());
> +            qemu_coroutine_yield();
> +        }
> +        i++;
> +
>          addr =3D qemu_get_be64(f);
>          flags =3D addr & ~TARGET_PAGE_MASK;
>          addr &=3D TARGET_PAGE_MASK;


