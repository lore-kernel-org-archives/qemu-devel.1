Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F51C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033172467A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZtrx8O4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033172467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuDvA-0002v8-3f
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 06:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuDuB-0002Tu-Jq
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuDuA-0004Mv-2F
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:10:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45828
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuDu9-0004Mk-Ui
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579691437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yHtpiqDmW7wXprIfbDTct/EqoODGQex6jVSwpRmBmCU=;
 b=hZtrx8O4hSEwxoMql8LHW2oDgwu4eYy4CaC08jHy9XdpqXzOJJ8TCnjiMXXXhUu0pfhyUN
 0HXHXaJulZ05GtehylgtX2nJ7RJSw6ROLIvGZm60inf63KcrUVeqAVukVsQoY0LPnjkJ6I
 txH/Rij1r+iQg4CgHmI/URbTEOAlKOs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-N7S8kplJMT-W4AisFUVpww-1; Wed, 22 Jan 2020 06:10:34 -0500
Received: by mail-wr1-f72.google.com with SMTP id h30so2856056wrh.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 03:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eO4GVMtUbM431bCEg+lkuqmor778MjyCZA808QLMqS4=;
 b=sIqep0t6/lpg5vmcc4oEGIlNQ8tEuY6QunMeKg7XqNJckMA9UxbiqgjVEugwsIfyD5
 yuhWtg+GdRJsfOVRCEafe4ZgEhCZeEpL8mDO1myvajAodzp9Oz126AQzuMU4kQFZjzUB
 1VEfagniGaTda8qJksaNbQAna0tRo/CghXPlI5AoeFRWV+zONHwki5ziggsFWp0TMNkS
 gEUrLyIwA/dvK2Kjslm54CYaJLIlvNYfxuLvAv4orKxgWfuImjwrManZ9gEcJVRm0mkH
 Bd7ArjOOE5sL4vokyWEt2tzzac9hqVFICv/3jF5MjWpeK9XXXBTYop2CzE+NwLlQgalE
 wG8A==
X-Gm-Message-State: APjAAAV7W0atIwmmVMLvPpdMJ3/JZmX0YrpHjDFYEZ5Uh0NOCZAkpy2y
 MK6HW9Qc1DeoQQwWe76WGB8tmnHoqjQIysJEevbyf6Ls8MtUo0Jgu6DmLqczkwgQy/QuaNimPUE
 kRUmbaOPD9lE9aEg=
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr10441944wrv.316.1579691432734; 
 Wed, 22 Jan 2020 03:10:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8oL2cX5iW5xD84daiqBJZSBzLc4PmEMw71lBAcTJXkhMX+dk+nsIzrC+pF4km4UpxwIKoAQ==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr10441902wrv.316.1579691432316; 
 Wed, 22 Jan 2020 03:10:32 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 c5sm3739958wmb.9.2020.01.22.03.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 03:10:31 -0800 (PST)
Date: Wed, 22 Jan 2020 06:10:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [virtio-dev][RFC PATCH v1 1/2] content: define what an exported
 object is
Message-ID: <20200122060844-mutt-send-email-mst@kernel.org>
References: <CAD=HUj640QfNwO4J_tdcSx36YOVAVT_dZUXYuKPaCKvZVWeHsg@mail.gmail.com>
 <20200122032103-mutt-send-email-mst@kernel.org>
 <CAD=HUj4pORJK1SQ2+n_oiXJyGaKqakSiOGcXdRCGSAMnuxY4cw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj4pORJK1SQ2+n_oiXJyGaKqakSiOGcXdRCGSAMnuxY4cw@mail.gmail.com>
X-MC-Unique: N7S8kplJMT-W4AisFUVpww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: virtio-dev@lists.oasis-open.org, Zach Reizner <zachr@chromium.org>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 07:13:41PM +0900, David Stevens wrote:
> > > +When an object created by one virtio device needs to be
> > > +shared with a seperate virtio device, the first device can
> > > +export the object by generating a \field{uuid}
> >
> > This is a field where?
>=20
> It's a property of the exported object, but I guess it doesn't really
> correspond to any concrete field. I'll remove \field.
>=20
> > > which the
> > > +guest can pass to the second device to identify the object.
> >
> > s/guest/Driver/ ?
>=20
> The uuid can be passed to a second device controlled by a different
> driver, so I think 'driver' by itself is ambiguous. I'm using guest as
> a shorthand for 'system which includes the drivers and software which
> sits on top of the drivers', and that meaning does seem to be
> compatible with language in the rest of the spec. If that shorthand
> isn't acceptable, I can rewrite the sentence passively as '... a uuid
> which can then be passed to a second device ...'.
>=20
> > Also - what are guest and host here?
>=20
> There are a number of places in the virtio spec where 'guest' is used
> to refer to the system where drivers run and where 'host' is used to
> refer to the system where devices run. I guess those terms aren't
> concretely defined within the spec, but they do seem to have a well
> understood meaning. Or is the guest/host language discouraged in new
> additions to the spec?
>=20
> -David

Yes - generally most devices are/should be implementable in hardware.
In that setup guest/host doesn't make sense.
We haven't reworked all of spec with that in mind yet,
and in some cases such as the balloon it's actually specific to
virtualization.

--=20
MST


