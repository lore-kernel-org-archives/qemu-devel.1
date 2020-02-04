Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6A1C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F6A20674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLqTraC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F6A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0Ng-0003VH-8g
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iz0N7-00035u-Cy
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iz0N5-00015w-Uf
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:44:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33501
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iz0N5-00011Q-Qn
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580831055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJu3PyKY8DxBz0b776osPvXBStS3drWEmVXJwiRiFfE=;
 b=TLqTraC9YYD59oEhSDFlJedS5RhsBKMv3MEVfjPhD/wxjT3MjSt00YfBSlW5IFnc1/8Xk2
 m6tvCpCfb9vmXRY8Pc7tS0/iHH/VbIrJIYre0IG9UezRrD6KIDgPzsB3D2SQq8dEpxWse2
 +RjtZlCUmipCnRS3kGdoYmlN6v17Fzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-gHFqUkPKOeeczDSm6bNQrQ-1; Tue, 04 Feb 2020 10:44:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7942910AFBC5
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 15:44:12 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12CD15D9C5;
 Tue,  4 Feb 2020 15:44:06 +0000 (UTC)
Date: Tue, 4 Feb 2020 15:44:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 3/4] virtiofsd: load_capng missing unlock
Message-ID: <20200204154404.GE3504@work-vm>
References: <20200204110501.10731-1-dgilbert@redhat.com>
 <20200204110501.10731-4-dgilbert@redhat.com>
 <fd996682-b280-c872-93cf-5147b52ab097@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fd996682-b280-c872-93cf-5147b52ab097@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: gHFqUkPKOeeczDSm6bNQrQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> Hi David,
>=20
> On 2/4/20 12:05 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Missing unlock in error path.
> >=20
> > Fixes: Covertiy CID 1413123
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >   tools/virtiofsd/passthrough_ll.c | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index e6f2399efc..c635fc8820 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -232,6 +232,7 @@ static int load_capng(void)
> >            */
> >           cap.saved =3D capng_save_state();
> >           if (!cap.saved) {
> > +            pthread_mutex_unlock(&cap.mutex);
> >               fuse_log(FUSE_LOG_ERR, "capng_save_state (thread)\n");
> >               return -EINVAL;
> >           }
> >=20
>=20
> What about moving the unlock call?
>=20
> -- >8 --
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -231,11 +231,11 @@ static int load_capng(void)
>           * so make another.
>           */
>          cap.saved =3D capng_save_state();
> +        pthread_mutex_unlock(&cap.mutex);
>          if (!cap.saved) {

I don't think I can legally check cap.saved there if I've already
unlocked

>              fuse_log(FUSE_LOG_ERR, "capng_save_state (thread)\n");
>              return -EINVAL;
>          }
> -        pthread_mutex_unlock(&cap.mutex);
>=20
>          /*
>           * We want to use the loaded state for our pid,
> ---
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


