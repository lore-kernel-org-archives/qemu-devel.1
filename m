Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE54CC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 18:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7BE217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 18:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSRdcOYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7BE217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in5eG-00075p-U4
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 13:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1in5dZ-0006eT-1F
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 13:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1in5dX-0007No-NH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 13:56:00 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1in5dX-0007Ke-HE
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 13:55:59 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so40207728wrw.8
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 10:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UwYlqRJxcNx3Grw5iwK2/faM/GH1Vt+XAmmS+V8dY4w=;
 b=JSRdcOYyL+VEK5z8EZDJgrpgNm7aN1aeBx7RlUeYNsIOkjVcd8dAKZ1SvOTbb7/t/E
 sFbX7CeXLcZqoyEPKP1ivHPGudx8OM8BVfa3l133ijgkwgHMAYg4nPwvGYY/z25Zsmqi
 fM+m8Rb98KZ49RJNxPMOjUy7G08eGkLWDLpD1iy4qmQsN+osdZfa3vhp3ZMf1yeehLFA
 /WBCd7G7hORTODHAlyH/n3uWFLCVwwdzMd43y4BRRn+ofXjU1rzEFLHp1ID1SXI1N6vO
 JtLv92FwskUJ3cNzLGl269pRjUOYKtJk1VA7zKKYnB68dROnRkzAD4yw71kLD4h2ew/F
 alOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UwYlqRJxcNx3Grw5iwK2/faM/GH1Vt+XAmmS+V8dY4w=;
 b=hoNWhxHrxwZeWo1p213zTsFSkGBLGFiwphFYcXuNCUJGW53mKw00T6oJdG8cZF0sNd
 4it5jGH6lO/mHyTXfURxh9byeWALebtB9DVqxP11UQUTNLDenfy39yjevZBNJdgJOdEj
 p/NA+tWvoa6yujWVCxgsFWQFjQ+S+sbqDX+hjjSmmkqCwvqLE8l26eHaRFRqSoqc8xOC
 tSWhus+l8upTPazFwsSwh8Kvasxiu5xvS0tDTUoZ9EV/+zLxCBeywU1R1LRzajJWxMzC
 PA7RZvnCuquxMW4vAFMl/mRcw+FkGqRz08KiQT6V0+L4rVnuQPUtBcM67GRhMjcpAAxK
 YSLw==
X-Gm-Message-State: APjAAAUhYEPj2N5lKelWWGunI+ac8+VZR4Sb753Yy1yXw2vqjMXaJ/OK
 BhGxapH379hUnoiBiYot5qJFIW57R7Qf0VN/I7U=
X-Google-Smtp-Source: APXvYqyCEu4E//4Aby3EfqMdYzkiBN6dHHM7wfHatwcRpgK3mz0SnEkz1dmdZHnjaG2t2LIz3kj+fLvFehkf44BglR8=
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr82447271wrq.396.1577991358415; 
 Thu, 02 Jan 2020 10:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
 <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
 <20191219125504.GI1190276@redhat.com>
 <20191220094712.GA1635864@stefanha-x1.localdomain>
 <20191220102237.GA1699760@redhat.com>
 <20200102104255.GF121208@stefanha-x1.localdomain>
 <C4F6A4B0-607A-4BEE-B722-8F5447F1ADB7@nutanix.com>
In-Reply-To: <C4F6A4B0-607A-4BEE-B722-8F5447F1ADB7@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 2 Jan 2020 22:55:46 +0400
Message-ID: <CAJ+F1C+tKZy7T3R6HeMf+iNYq2nGjqizoKT5H=G-=9Zi8gHp=Q@mail.gmail.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
To: Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Walker,
 Benjamin" <benjamin.walker@intel.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Jan 2, 2020 at 3:03 PM Felipe Franciosi <felipe@nutanix.com> wrote:
> The reason I dislike yet another offloading protocol (ie. there is
> vhost, there is vfio, and then there would be qdev-over-socket) is
> that we keep reinventing the wheel. I very much prefer picking
> something solid (eg. VFIO) and keep investing on it.

I don't have a lot of experience with VFIO, so I can't tell if it's
really solid for the user-space case. Alex W could probably discuss
that.

> In that case, wouldn't it be preferable to revive our proposal from
> Edinburgh (KVM Forum 2018)? Our prototypes moved more of the Qemu VFIO
> code to "common" and added a "user" backend underneath it, similar to
> how vhost-user-scsi moved some of vhost-scsi to vhost-scsi-common and
> added vhost-user-scsi. It was centric on PCI, but it doesn't have to
> be. The other side can be implemented in libmuser for facilitating things=
.

Same idea back in KVM forum 2017 (briefly mentioned at the end of our
talk with Conrad)

The PoC is still around:
https://github.com/elmarco/qemu/tree/wip/vfio-user/contrib/libvfio-user

> I even recall highlighting that vhost-user could be moved underneath
> that later, greatly simplifying lots of other Qemu code.

That would eventually be an option, but vhost-user is already quite
complicated. We could try to split it up somehow for the non-virtio
parts.

cheers

--=20
Marc-Andr=C3=A9 Lureau

