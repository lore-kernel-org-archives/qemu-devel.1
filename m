Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D539DC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B939F20575
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9XzgCwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B939F20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCHP6-0006fS-SU
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 02:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCHOP-0005Vw-W2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCHOO-0007Fa-MJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:32:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52466
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCHOO-0007D4-Fr
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583994748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYPlNWIvtGK61J24nOshJuoxiaAAfsYVurK3NYsF3C8=;
 b=Y9XzgCwZ4ldb2jxH+lbZj/ddzd8CE1RMI3ZEuqaLCqo5b3dNxsttA6oeOovmjDHVbw+O2y
 rw8PhDwSIR8veMFXZuHF8PML9o4RWgd7S5TBMz1lN3NZTdeSZ01aVcX8jSXQowRiwYamir
 RPHebKC84brJztG3jt3x55pjsy9MrDA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-Nq0oYPgdO66J5EbJNm79LA-1; Thu, 12 Mar 2020 02:32:18 -0400
X-MC-Unique: Nq0oYPgdO66J5EbJNm79LA-1
Received: by mail-qk1-f200.google.com with SMTP id z185so3172404qkc.17
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 23:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1jFnIPA9wpJqutkLIu7VzJdYLS2n+sxvNDTkBAMNSN0=;
 b=MZ7WHUYGWvNooiIR/IgF9e3BlUvyCfdMnqzH/A+QAMUgNcdE2TkRuo6hy+O2dmeHzT
 lks13D08kKT621zcQxw0nyQoyleQamXxA1X5e9tIKWx8zfGTrt6+bjfdoHDptJPMh5l5
 rJvCrixFBPnzMbzQNp7rpqUh2CA0QHocUbn6a90ZbdxPQ5OswqWqAXPJCWiLMGpX3P/R
 L6nlBGmmojzMravEMcNhazDw7GErS83lEKrMMieX6NIKRUIiXGbCNCIqKRcWiyMwPMTG
 QhpkU2hEfEnijrbx1Q5jIpOkhQkhNdt//yIByIphliIioVxtW4A0siygRORxcI7k/g3Q
 EwIg==
X-Gm-Message-State: ANhLgQ3+XK5bEXGVlKe4bxr6doROD6VEQrZXOODjv3efdfty8rHaCQZB
 2bZpcM/mfCTZNzE3144sZILYc3OjBqsZKs/7nxhhIluVhEnZb3VOd0ZeEOypgRSZVVbLfaIAihE
 48qL7ecBs1TP+b1o=
X-Received: by 2002:a37:2d04:: with SMTP id t4mr6292710qkh.105.1583994738003; 
 Wed, 11 Mar 2020 23:32:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuohpVusm3oImKIGFAKPuSXuU0os3uq32DKX8lX+gVzfxG3mgNmzfNdfQtkEnlKbqcZ8FpgDQ==
X-Received: by 2002:a37:2d04:: with SMTP id t4mr6292689qkh.105.1583994737727; 
 Wed, 11 Mar 2020 23:32:17 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id g2sm26365424qkb.27.2020.03.11.23.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 23:32:17 -0700 (PDT)
Date: Thu, 12 Mar 2020 02:32:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Upstream QEMU guest support policy ? Re: [PATCH v3 0/2] spapr:
 Use vIOMMU translation for virtio by default
Message-ID: <20200312023041-mutt-send-email-mst@kernel.org>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200310114343.GD3234052@redhat.com>
 <20200311011247.GT660117@umbus.fritz.box>
 <20200311031202-mutt-send-email-mst@kernel.org>
 <20200312011049.GC711223@umbus.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200312011049.GC711223@umbus.fritz.box>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: pair@us.ibm.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, aik@ozlabs.ru,
 groug@kaod.org, qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org,
 mdroth@us.ibm.com, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 12:10:49PM +1100, David Gibson wrote:
> On Wed, Mar 11, 2020 at 03:33:59AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Mar 11, 2020 at 12:12:47PM +1100, David Gibson wrote:
> > > I am wondering if we have to introduce an "svm=3Don" flag anyway.  It=
's
> > > pretty ugly, since all it would be doing is changing defaults here an=
d
> > > there for compatibilty with a possible future SVM transition, but
> > > maybe it's the best we can do :/.
> >=20
> > Frankly I'm surprised there's no way for the hypervisor to block VM
> > transition to secure mode. To me an inability to disable DRM looks like
> > a security problem.
>=20
> Uh.. I don't immediately see how it's a security problem, though I'm
> certainly convinced it's a problem in other ways.

Well for one it breaks introspection, allowing guests to hide
malicious code from hypervisors.

> > Does not the ultravisor somehow allow
> > enabling/disabling this functionality from the hypervisor?
>=20
> Not at present, but as mentioned on the other thread, Paul and I came
> up with a tentative plan to change that.
>=20
> > It would be
> > even better if the hypervisor could block the guest from poking at the
> > ultravisor completely but I guess that would be too much to hope for.
>=20
> Yeah, probably :/.
>=20
> --=20
> David Gibson=09=09=09| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au=09| minimalist, thank you.  NOT _the_ _oth=
er_
> =09=09=09=09| _way_ _around_!
> http://www.ozlabs.org/~dgibson



