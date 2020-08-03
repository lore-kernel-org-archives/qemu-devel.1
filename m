Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4670C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 21:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C087922BED
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 21:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zp2g07By"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C087922BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2hcH-0005gw-Lr
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 17:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k2hbe-0005C0-2z
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 17:02:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31894
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k2hbX-0006sF-IF
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 17:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEN1lQr9VDQAb94TgfhFi6wOq/mkgIeNknZwhSz9j7k=;
 b=Zp2g07ByGsczu1sqb3lDb7T5nXATQkB7D/Lu12cI0tF/toUfS+rdcvz6FoS8dNv26CbRUZ
 pJNouxMSA+J4M1pp/L8S/M97bFF4CisVKmV7rpSXdP4TOVi/Jqp2khxvYi3y7Two9zSiNY
 dq5d6IGHpvrnVkhT9KcmfBGu4aFPcOw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-4dxD1Wr-P52HNAOFFD_5fw-1; Mon, 03 Aug 2020 17:02:26 -0400
X-MC-Unique: 4dxD1Wr-P52HNAOFFD_5fw-1
Received: by mail-ot1-f72.google.com with SMTP id g3so9322139otq.7
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 14:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lEN1lQr9VDQAb94TgfhFi6wOq/mkgIeNknZwhSz9j7k=;
 b=l8QZdaIHFVefE1TUR+c/LdJ48uDcxMhjyihK0GLOnUzQ4BXPtB3G/ilhS4unNt8aV1
 H1UWqfS8dxf6cywTX3VoOvpDp9L2ytmBIHqFwmRnEAzrJkEyISpKuwVd9nGRfCOqvx9P
 /GzRssQJ5tYx7Tn0KQyUGzF15slx6PsnyCdQrR2EjIoReHYYQtqM025fjeLxgR8KpMuS
 hG/thgA1K3x/bl7OHcSA+c+oCZaOKrK8L3zWYWlF6cx6/IwalHBm447iIiKqA5e/CczM
 +i6xFo4/wUQ6SHZneRe3Djys5POjdOfvue4/3YQPeLKanp8/2Iz6iWG6eQ5Z9J6eTKgI
 Yp/Q==
X-Gm-Message-State: AOAM533Z6xjAN6UQz2osoongieuOPIf2RkcCgrWgEjDI5c0r+1zc/7SW
 qwaaMn4GSxdR+fYDKXHm/rU4TdHoVw598taegkmpoNDpPQ1X6boVBmeQYwWg2wVkyUkGrS2Df6a
 l9wjavmiiXzxBzmLW+04UgL3E5t1LzoI=
X-Received: by 2002:a9d:4c86:: with SMTP id m6mr14600511otf.315.1596488546000; 
 Mon, 03 Aug 2020 14:02:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6E8wLXy/9AKaMJPYQesuh7egJetOpIOw+U1yLQ+Kpg7LTgUYuimyCzAmmRkgVcACYMpoK1RvriMWaFrZ1fds=
X-Received: by 2002:a9d:4c86:: with SMTP id m6mr14600481otf.315.1596488545704; 
 Mon, 03 Aug 2020 14:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com> <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
 <20200731154429.GD3660103@redhat.com>
 <21cda868-85d3-77db-31d8-0248a5029318@redhat.com>
 <20200803113655.GI3670709@redhat.com>
 <fcc9056d-4d72-5bdb-bd21-2bf6213f5a55@redhat.com>
 <20200803122304.GJ3670709@redhat.com>
In-Reply-To: <20200803122304.GJ3670709@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 4 Aug 2020 00:02:09 +0300
Message-ID: <CAMRbyysHBJe4CzXgCvmxbGHsZen1jnyCOzPT9SO+f-EBn5bHhw@mail.gmail.com>
Subject: Re: [PATCH] schemas: Add vim modeline
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 3, 2020 at 3:23 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Mon, Aug 03, 2020 at 02:16:19PM +0200, Paolo Bonzini wrote:
> > On 03/08/20 13:36, Daniel P. Berrang=C3=A9 wrote:
> > >>> Given that QEMU needs to pass
> > >>> uint64 values, JSON was simply the wrong choice of format for QMP.
> > >
> > > I wasn't refering to RFC7159. The problem of undefined integer precis=
ion
> > > with JSON came up right at the very start when QMP was first designed=
 and
> > > implemented, and has come up again periodically ever since then. libv=
irt
> > > needed to do workarounds right at the start in 2009, in order to full=
y
> > > handle signed/unsigned 64-bit integers with QMP.
> >
> > I assume the workaround you refer to is to store the number as a string
> > and converting it lazily to either an integer or a floating-point type
> > in whoever uses the JSON API.  It may not be pretty but probably it
> > would have been the same for any text-based, schema-less protocol.  For
> > example, it didn't require writing your own parser.
>
> Yes, we get the raw values as a string, but not all parsers for C
> allow you to do this.  We'd really love to move off YAJL for JSON
> parsing, but the most viable alternatives don't have a way to let
> you get the string before they parse it as an integer and report
> errors.
>
> > It could be avoided by using a schema in Libvirt, just like QEMU has no
> > problem with it on the other side; it's just a different design choice
> > with different trade-offs, I don't think it's enough of an issue to
> > declare JSON "the wrong choice of format for QMP".
>
> The schema doesn't help - the problem is many JSON parsers don't allow
> use of full uint64 values when parsing - alot will simply report an
> error for anything bigger than LLONG_MAX and offer no workaround.

Jansson is considering this:
https://github.com/akheron/jansson/issues/69

The issue is 4 years old, but there is some activity lately. I guess
someone who wants this needs to invest the time.

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>


