Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D112C34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E236207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNLVIaBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E236207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4WH0-0000hc-92
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 15:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4WFy-0006uX-AY
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4WFw-0007I2-BH
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:47:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40582
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4WFw-0007HH-7P
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582145258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z9QaCXOPH0IL857mIjX6EVX79caSBUCxrTpEEX+6sv8=;
 b=NNLVIaBa3zzhRAajQKgJ1SLtqKbincOWN4IP8Qfus1yVJ3MSDz0uMjjctGjrUM1ac/WObg
 0+c/5UvpVsWtdTLajv8K6ttEKxm9gRWAkEUIoh++J9Uzbhm0CykZSzSR0bRwXscudPGEQ1
 6ssdkxzw/0oqnMW7mELKHSFQp1CS6M4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-a0JBVOOMMI-qIgoB80_Q5w-1; Wed, 19 Feb 2020 15:47:33 -0500
Received: by mail-qt1-f199.google.com with SMTP id t9so1053935qtn.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 12:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GxXuC9VpnfsN8ECtBzUcIwHdNAaNt0W0kIa1/2wFcSw=;
 b=U6KVFacH+QaoiAuSOd1wnKDi1otZku/Q6I/uM7XMOZIW5gGfhg20ghcSPkeNmtZn3p
 5LUCs7oLzef+vgMCRTGppo1p94unD4ePadYoiPkbzNM2EaEHrAVUyGA0/EEX0XhcsMWO
 Ibq3XMe8VqN4jbvACt9KeJXXqjLsC/WUfaqJZbgl/XhzvfeBQXQosj3PNczeg6cWWj4p
 NBwSe92QHFErqJq6UldxfGu+UqysolpeH4Ml2fGD/bHMJfQvWN/Srw4wqEtpquNtJpPw
 1zJDcVHbOSuhUmiaaHbY2F1Qbkrd9fNQM56jPSPLvswtp2XbXfg+8DYIAqbesbv0xtSH
 L3Xg==
X-Gm-Message-State: APjAAAUypo2OFz75//bVer16y3yB6vC7TKGsSiP4GeguNcZmBpLJzPVA
 UnPFh1E9r7gZ0ebqK7dsSG2NFn/a0XoLyeCKdJ7jdPii6+2EIO14VlHzGg0issEG4DKr/HcCRQ6
 v6mUCLD0zojoEYzY=
X-Received: by 2002:ad4:40c7:: with SMTP id x7mr23082314qvp.176.1582145253368; 
 Wed, 19 Feb 2020 12:47:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2oxTlZi/AvZsRG49TgxaPQhpo9srMSSVoM1tKdfCr34AU6tK3TkaoXypm1PfPFFtI/fFbAA==
X-Received: by 2002:ad4:40c7:: with SMTP id x7mr23082305qvp.176.1582145253091; 
 Wed, 19 Feb 2020 12:47:33 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id i28sm675040qtc.57.2020.02.19.12.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 12:47:32 -0800 (PST)
Date: Wed, 19 Feb 2020 15:47:30 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 07/13] migrate/ram: Get rid of "place_source" in
 ram_load_postcopy()
Message-ID: <20200219204730.GB37550@xz-x1>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-8-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200219161725.115218-8-david@redhat.com>
X-MC-Unique: a0JBVOOMMI-qIgoB80_Q5w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 05:17:19PM +0100, David Hildenbrand wrote:
> It's always the same value.

I guess not, because...

>=20
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  migration/ram.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index cbd54947fb..75014717f6 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3119,7 +3119,6 @@ static int ram_load_postcopy(QEMUFile *f)
>          ram_addr_t addr;
>          void *host =3D NULL;
>          void *page_buffer =3D NULL;
> -        void *place_source =3D NULL;
>          RAMBlock *block =3D NULL;
>          uint8_t ch;
>          int len;
> @@ -3188,7 +3187,6 @@ static int ram_load_postcopy(QEMUFile *f)
>                  place_needed =3D true;
>                  target_pages =3D 0;
>              }
> -            place_source =3D postcopy_host_page;
>          }
> =20
>          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
> @@ -3220,7 +3218,7 @@ static int ram_load_postcopy(QEMUFile *f)
>                   * buffer to make sure the buffer is valid when
>                   * placing the page.
>                   */
> -                qemu_get_buffer_in_place(f, (uint8_t **)&place_source,

... it can be modified inside the call.

I feel like this patch could even fail the QEMU unit test.  It would
be good to mention what tests have been carried out in the cover
letter or with RFC tag if no test is done yet.

For a series like this, I'll try at least the unit tests and smoke on
both precopy and postcopy.  The resizing test would be even better but
seems untrivial, so maybe optional.

Thanks,

> +                qemu_get_buffer_in_place(f, (uint8_t **)&postcopy_host_p=
age,
>                                           TARGET_PAGE_SIZE);
>              }
>              break;
> @@ -3265,8 +3263,8 @@ static int ram_load_postcopy(QEMUFile *f)
>                  ret =3D postcopy_place_page_zero(mis, place_dest,
>                                                 block);
>              } else {
> -                ret =3D postcopy_place_page(mis, place_dest,
> -                                          place_source, block);
> +                ret =3D postcopy_place_page(mis, place_dest, postcopy_ho=
st_page,
> +                                          block);
>              }
>          }
>      }
> --=20
> 2.24.1
>=20

--=20
Peter Xu


