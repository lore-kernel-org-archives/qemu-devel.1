Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F4AC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D4F20801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL2MyiDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D4F20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4i5P-0002nI-5H
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j4i4P-00017u-7Y
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j4i4J-000102-CB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:24:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42991
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j4i4J-0000zX-22
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582190665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ryCUbgIe8KsZ1D8uUWBYI1LF9vZcPPEDDkxnFAX4H7A=;
 b=gL2MyiDwZRZm6Spo7a6vvUjezVSoskO5OZnFNRyxm3mMWk3+xmJQWI4bnkOf31hL+OiMPG
 6unfaaCAFrtKgqGjVrRTCe1drhhUVtHiXO9qcFdIs5cxuAgZl8Hf2uN9jt3RUehmwXyM3M
 OEoAUZ1nyhs9CFdCIuJFctJsGweVXBc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-x0fypKa-POyPfpWfcZE3kg-1; Thu, 20 Feb 2020 04:24:24 -0500
Received: by mail-wr1-f72.google.com with SMTP id o6so1466366wrp.8
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 01:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=20J2xNJndwD0uRSo76vE5fqmNGT6NiOBpd0H4BNpJXs=;
 b=ca3Xp4EEeWg4qZmxEQB1DHpUlbyowOG7NNWAwWn1Ct9CF6oYm9qQM+6pgVNyFHaWsq
 ROD0YEfg0O7JaYq6h4QtHXT5BEHtcyeHVWrFhPLRt+zuN0T0Gub2HYgjiHFz1ltwEA2l
 avGhAqB//15V59/+80AdD1ZBsiSfVr7eZ5UpvEV/TB0zjkYfIQKUwG58zuql2TrKeOSy
 4+c/VnXNRuNfyWjFViLsHMpigZld5avcikI6tgb8ql3P6J3cchnrnJ2WmOzmV1k2RPnV
 bYx41sZpOfz+D7b99bKRWQAO+PYqQgmRlGrvhZGmrwTQUBpqx+hMolGFIoYQRkAoSqlR
 WpPQ==
X-Gm-Message-State: APjAAAVuoQo2ps77G54t9KorcnhyE4aog98HSJtaqRKbpLK2SZA8cQ5z
 ZCntybynzLgXw7OCEtxEi95X4/A2Tja65iengjmqXzjRcClM7De32qRraZ3qfG44tbQWEB4aFOs
 UBk8dG4+Zi9tDrlQ=
X-Received: by 2002:a1c:6408:: with SMTP id y8mr3294327wmb.130.1582190663235; 
 Thu, 20 Feb 2020 01:24:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxErA+v6CThtewt0oOBLJXzaudgsibdEYgcKQcqWTtHx1g3/BUEkzmEv9QAC87+tIcz8drbbQ==
X-Received: by 2002:a1c:6408:: with SMTP id y8mr3294291wmb.130.1582190662896; 
 Thu, 20 Feb 2020 01:24:22 -0800 (PST)
Received: from [131.159.204.89] (w204-2h-v4.eduroam.dynamic.rbg.tum.de.
 [131.159.204.89])
 by smtp.gmail.com with ESMTPSA id t131sm3863346wmb.13.2020.02.20.01.24.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 01:24:22 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 07/13] migrate/ram: Get rid of "place_source" in
 ram_load_postcopy()
Date: Thu, 20 Feb 2020 10:24:19 +0100
Message-Id: <5DD859C1-9FF5-4488-8928-43B83D8AD677@redhat.com>
References: <20200219204730.GB37550@xz-x1>
In-Reply-To: <20200219204730.GB37550@xz-x1>
To: Peter Xu <peterx@redhat.com>
X-Mailer: iPhone Mail (17D50)
X-MC-Unique: x0fypKa-POyPfpWfcZE3kg-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 19.02.2020 um 21:47 schrieb Peter Xu <peterx@redhat.com>:
>=20
> =EF=BB=BFOn Wed, Feb 19, 2020 at 05:17:19PM +0100, David Hildenbrand wrot=
e:
>> It's always the same value.
>=20
> I guess not, because...
>=20
>>=20
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: Juan Quintela <quintela@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> migration/ram.c | 8 +++-----
>> 1 file changed, 3 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/migration/ram.c b/migration/ram.c
>> index cbd54947fb..75014717f6 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -3119,7 +3119,6 @@ static int ram_load_postcopy(QEMUFile *f)
>>         ram_addr_t addr;
>>         void *host =3D NULL;
>>         void *page_buffer =3D NULL;
>> -        void *place_source =3D NULL;
>>         RAMBlock *block =3D NULL;
>>         uint8_t ch;
>>         int len;
>> @@ -3188,7 +3187,6 @@ static int ram_load_postcopy(QEMUFile *f)
>>                 place_needed =3D true;
>>                 target_pages =3D 0;
>>             }
>> -            place_source =3D postcopy_host_page;
>>         }
>>=20
>>         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
>> @@ -3220,7 +3218,7 @@ static int ram_load_postcopy(QEMUFile *f)
>>                  * buffer to make sure the buffer is valid when
>>                  * placing the page.
>>                  */
>> -                qemu_get_buffer_in_place(f, (uint8_t **)&place_source,
>=20
> ... it can be modified inside the call.

Very right, will drop this patch! Thanks!

>=20
> I feel like this patch could even fail the QEMU unit test.  It would
> be good to mention what tests have been carried out in the cover
> letter or with RFC tag if no test is done yet.

I test all code I share. This survives =E2=80=9Emake check=E2=80=9C. I assu=
me all tests send small pages where =E2=80=9Ematches_target_page_size=3D=3D=
true=E2=80=9C, so the tests did not catch this.

I even spent the last day getting avocado-vt to work and ran multiple (obvi=
ously not all) migration tests, including postcopy, so your suggestions hav=
e already been considered ...

Could have mentioned that in the cover letter, yes.


