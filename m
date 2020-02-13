Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A8CC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBD124689
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNbVUqZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBD124689
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GIN-0004RM-1M
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j2G70-0005ZW-LJ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j2G6w-00074k-Vc
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:09:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35707
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j2G6w-00073H-RH
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581606542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RP4jL+liXOr7+owGoE1uisFYbkKabx8mrOWiLhVUgk=;
 b=fNbVUqZV57v/9BFlacRccv+wdsQk6ntTrZAPenamYgKfyxJ4IR1S6eaVYWisKfr3zsjlz5
 7M4BuSY8cURpruVmw/vz7TM7BW9Cm0PX3GUpN/we84nX8/R9eSHB9Yg1QO9We0qeRot22p
 jQamYBFVLAXHvEqip2VX4Js53klIkG0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13--N5pNiBlOS6qFip21CCGbw-1; Thu, 13 Feb 2020 10:08:57 -0500
Received: by mail-qv1-f69.google.com with SMTP id n11so3672197qvp.15
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 07:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TTCs0FYlF7ncgzuKAoKWZgYBOizTPZCqyTpm/Xkwuxg=;
 b=uO3PeMaIjMm4gmwrmCetUCdBX8EeIcJK6hkwesSAnfaCEC9Ki2jiBvL+LejaZP4JuA
 weewfmCipPiSaHLCsniQpnQHfaqO9jNZq4eTfVIKEOZG+ueZXQcdDP7tQ7SkkMJHA5xb
 n01ZVAgQkwe7zSvwGQCSy7QkFyBASn9c/PDaB0k70mEXTTg5U6SNwKCDgEv8eoHTA++l
 IrV5v9oHEjm1ln2InWNL8RgUkSGP7FBN+OHcIVLmFDepNfTv8fOf7iJYHy4kMiUE3WRE
 GPZwX6caQCa9AtWMsmKoFNjZH6aBf+5iRsMnDFnYlYLIDcBmNn2oyXo2KnZRJ2arnZJS
 g2PA==
X-Gm-Message-State: APjAAAV2+TCtDfc7/6Q8r9LrZEl3X8X9A9KoV1ah9vQ4I9xxrx4IsT/t
 8W2YnwYH4rxSfjcbJ+Mv/Yvj7cdPZozn7HQZZg+mvTrCuF+g10hKdpXdyCqUVfD7600oLyqkCUA
 7yLEpViVurQIS/fI=
X-Received: by 2002:a05:620a:663:: with SMTP id
 a3mr16110922qkh.310.1581606537257; 
 Thu, 13 Feb 2020 07:08:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzUgLATtaYNS3Kg0ZyRQURNj5rc+bKl6duQGjBd/h/0kPnf2VPQA4IkJPSzdtqTGd9fGBjJUw==
X-Received: by 2002:a05:620a:663:: with SMTP id
 a3mr16110888qkh.310.1581606536927; 
 Thu, 13 Feb 2020 07:08:56 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id l19sm1441196qkl.3.2020.02.13.07.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 07:08:56 -0800 (PST)
Date: Thu, 13 Feb 2020 10:08:53 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 14/25] intel_iommu: add virtual command capability support
Message-ID: <20200213150853.GB1103216@xz-x1>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-15-git-send-email-yi.l.liu@intel.com>
 <20200211215630.GN984290@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A1BBBF4@SHSMSX104.ccr.corp.intel.com>
 <20200213143110.GA1103216@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200213143110.GA1103216@xz-x1>
X-MC-Unique: -N5pNiBlOS6qFip21CCGbw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 09:31:10AM -0500, Peter Xu wrote:

[...]

> > > Apart of this: also I just noticed (when reading the latter part of
> > > the series) that the time that a pasid table walk can consume will
> > > depend on this value too.  I'd suggest to make this as small as we
> > > can, as long as it satisfies the usage.  We can even bump it in the
> > > future.
> >=20
> > I see. This looks to be an optimization. right? Instead of modify the
> > value of this macro,  I think we can do this optimization by tracking
> > the allocated PASIDs in QEMU. Thus, the pasid table walk  would be more
> > efficient and also no dependency on the VTD_MAX_HPASID. Does it make
> > sense to you? :-)
>=20
> Yeah sounds good. :)

Just to make sure it's safe even for when the global allocation is not
happening (full emulation devices?  Do they need the PASID table walk
too?).  Anyway, be careful to not miss some valid PASID entries, or we
can still use the MIN(PASID_MAX, CONTEXT_ENTRY_SIZE) to be safe as a
first version.  Thanks,

--=20
Peter Xu


