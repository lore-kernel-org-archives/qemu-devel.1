Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2190C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB8E20716
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPe8jco7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB8E20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw35L-0001tH-Ma
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iw34e-0001J8-85
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iw34c-0002Ec-W9
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:01:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38190
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iw34c-0002Dt-AQ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580126457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lvmduv85SkHlF4bE+SqcEFJeiqFyzB6lIJHf9AQYk5g=;
 b=EPe8jco7kZvGywjHb8X4tl4dzcUwFWM9JBbawWXgWO5rerFBQZ4qkwqdjtLizt6kJFLe6C
 mhVxm9tm/bLZSfOCMFO9a7SNoYU96cdszyAePTO1+haDpwPqer2zOxhLW3p+lQ9JYGVuWA
 RtPgA4KEMUv7FdFAByS3+XSuoZo/uIs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-yKx_n8eLO7yZZgkQE6q6Fg-1; Mon, 27 Jan 2020 07:00:55 -0500
Received: by mail-qk1-f198.google.com with SMTP id z1so6016117qkl.15
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 04:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ByjXrZuGUmvdTasWEBG0jlug5ZQZLFIn9PCwHh4qVZU=;
 b=deNaSyM1bpJh6VqmCcBhyRu1i0UcZmlaDqArb7kpKxH+CqhE7hi5//U/G0ckdtD6Yx
 QmQBP3Gs76/dP1bLe5EJXkSM6G3N5OfMT5bq+HCImM3Dfe7BvbtiwLQmMlpQXrh6HGFm
 U+mifwnsJ95BFF06v4ydVVGb/n8uN441fR80jSOs5XOjzlrCbiWCHlZTBSmC6aRyATnh
 Ob7woY0FRqGpqR4+KZnzvC5nGdm7Gzhxg4U65+Tjx9nE6EZ/9kqErc+DSfNBBVXuW3mg
 ssKpTdRcjaUTbquP+ZTMXE9LerKpnNDS/+KQ+8VX8C6aJ4L1tX1PnMAOfUqi34yF0paM
 jxAA==
X-Gm-Message-State: APjAAAXrrDOxlhYreYtivjX56MIulj35DzHExD6FgrCMS7T0DdxPTRde
 MFpAtdcdQJLQLPAHbbW0GbfuFEVxRruT3u8h4kcs38vmYlgrf0qMwd3oKF0fuGRXXq0wYjIgPLx
 4TO4qcjoIUmH8lEQ=
X-Received: by 2002:a0c:fe10:: with SMTP id x16mr9811694qvr.188.1580126454252; 
 Mon, 27 Jan 2020 04:00:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6BF4pKjFKP/3DbE3IMPIoqVVfyAoNQMsuP82947t8vuD4SrOr0/NSds8BK71BoPqlXrVz2Q==
X-Received: by 2002:a0c:fe10:: with SMTP id x16mr9811660qvr.188.1580126453880; 
 Mon, 27 Jan 2020 04:00:53 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id q126sm9551412qkd.21.2020.01.27.04.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 04:00:53 -0800 (PST)
Date: Mon, 27 Jan 2020 07:00:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web PATCH v2] Add "Security Process" information to the
 main website
Message-ID: <20200127070030-mutt-send-email-mst@kernel.org>
References: <20200123171150.12782-1-thuth@redhat.com>
 <b24abc8e-032c-c95f-89ae-c6480cee8b3c@redhat.com>
 <a0b6986c-3732-9326-e383-675596dc61aa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a0b6986c-3732-9326-e383-675596dc61aa@redhat.com>
X-MC-Unique: yKx_n8eLO7yZZgkQE6q6Fg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: sstabellini@kernel.org, pmatouse@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 11:00:29AM +0100, Thomas Huth wrote:
> On 23/01/2020 20.43, Eric Blake wrote:
> > On 1/23/20 11:11 AM, Thomas Huth wrote:
> >> One reporter of a security issue recently complained that it might not
> >> be the best idea to store our "Security Process" in the Wiki. Well, wh=
ile
> >> the page in the Wiki is protected (so that only some few people can ed=
it
> >> it), it is still possible that someone might find a bug in the Wiki
> >> software to alter the page contents...
> >> Anyway, it looks more trustworthy if we present the "Security Process"
> >> information in the static website instead. Thus this patch adds the
> >> information from the wiki to the Jekyll-based website now.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >> =A0 v2: Improved some sentences as suggested by Paolo
> >>
> >=20
> >> +### Publication embargo
> >> +
> >> +As a security issue reported, that is not already publically disclose=
d
> >=20
> > publicly
> >=20
> >> +elsewhere, has an embargo date assigned and communicated to reporter.
> >> Embargo
> >=20
> > Reads awkwardly. I'd suggest:
> >=20
> > If a security issue is reported that is not already publicly disclosed,
> > an embargo date may be assigned and communicated to the reporter.
>=20
> Ok, thanks, I've added your suggestions and pushed the changes now to
> the website.
>=20
> To the people on CC: ... could someone please update the wiki page
> (https://wiki.qemu.org/SecurityProcess) to point to
> https://www.qemu.org/contribute/security-process/ instead? ... I don't
> have write access to that page, so I can not do that on my own.
>=20
>  Thomas

Stefan I think you can do it right?

--=20
MST


