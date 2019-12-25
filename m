Return-Path: <SRS0=MlkC=2P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706EDC2D0DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2019 17:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375802072A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2019 17:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6JExa9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375802072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikAfi-0007Ky-Ds
	for qemu-devel@archiver.kernel.org; Wed, 25 Dec 2019 12:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1ikAf0-0006r3-Du
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 12:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1ikAex-0007S8-PN
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 12:41:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60017
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1ikAex-0007R7-95
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 12:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577295681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75nd8LPhguXL5eQa9iSLPRnL3MkzQpzvJ1JrQLx6COM=;
 b=F6JExa9e0NAEKBzhFGtw8t8w+42SuwcdctcFla2K+5aPhtPsSgqlkJ5nTyEua3nI6inNDx
 etXo5+jJnnLbSMyGvnPExTcCHV6rVclRG3AkBMninJvD/0Pn5xc92XkmJVWLDPPNs91XEv
 xMQ3A2ML9qqyqTnCsOxSq03FSJ6KvTs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-XmEzLmUqP42RqveRVt4D6Q-1; Wed, 25 Dec 2019 12:41:18 -0500
Received: by mail-ot1-f70.google.com with SMTP id z3so11843879oto.22
 for <qemu-devel@nongnu.org>; Wed, 25 Dec 2019 09:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BCaMTqiEJgKqu5QNyfCIB3RvYZmZ+uVPRwSdPjEP/tM=;
 b=cVafZY62EIB48CHQZYL3V35JiMRNgvlGIAQIkV329G5HOriYOUUsyjzc81Q3gCcdaX
 QJWEj8vMykRGqzmcsQYLmk74zEPo1DcAfmselc6oQdsDJ+8F+Ej6hCN2o5Sf7uqaqWML
 WvqjDgtR0A3LF5X4HznB90/9Uza9AGhjS+IuX0zxFgOU8uhUEX+CJS0aHA3iv+grWD2s
 iLzeDa9/XC4Ine5Cy0j6lLD2ojFH3/m6dXiCeVmdlgmNKhPn2gzYKuQ2KSxa7SEK522A
 q8+3ZVmnsg2Kv+sQ1aOD6LrH9bEinZOXgt4Fz46ulRRz8F9IBYpIQjpAblrTIsXvdS+E
 ZXCw==
X-Gm-Message-State: APjAAAX/z2ohEz28e1WxQ8perRNop3sng/WsI8+KPxsHz9FaNYM9Z2kr
 998bv4Zucpxgw/c/Mw9wbIazypwD+LzZwWwygPUfVWNXvS6zBICBS4ncTowTFYMzEMSaRuAml3m
 tIHcEiquDguq5uXoyQbkBPNGwR57FqOc=
X-Received: by 2002:a9d:7757:: with SMTP id t23mr47842254otl.315.1577295677490; 
 Wed, 25 Dec 2019 09:41:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzY3L1Oxg7a+YeMjZYsEMi/4cdWfc4B2dYf2ws05TP4NsV03XRbWqqvvJdFxv4B6tgrNiCOMeeTCFAVMjuM0fs=
X-Received: by 2002:a9d:7757:: with SMTP id t23mr47842236otl.315.1577295677298; 
 Wed, 25 Dec 2019 09:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20191219125151.21482-1-nsoffer@redhat.com>
 <443c32b3-0e0c-ef9e-4d5b-9404b16eaa02@virtuozzo.com>
 <20191219140433.GK5230@linux.fritz.box>
 <CAMRbyyvqa1_3U=2Q7HmCrRcEq+yJjxUP7MM-GM5hUdrZw=yBOw@mail.gmail.com>
 <ddf58827-72e8-f853-e6bc-05d19100c62d@virtuozzo.com>
 <CAMRbyysHGjsWaCWXW2+iNSwU03DhavRF6sJ9-POUx3Mky6LK7Q@mail.gmail.com>
In-Reply-To: <CAMRbyysHGjsWaCWXW2+iNSwU03DhavRF6sJ9-POUx3Mky6LK7Q@mail.gmail.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Wed, 25 Dec 2019 19:41:01 +0200
Message-ID: <CAMRbyysG9iG-5b_esosp1Db=BssNQ3J5e5zrQDAjnpbW7VtU8w@mail.gmail.com>
Subject: Re: [PATCH] block: nbd: Fix dirty bitmap context name
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-MC-Unique: XmEzLmUqP42RqveRVt4D6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Nir Soffer <nirsof@gmail.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 5:55 PM Nir Soffer <nsoffer@redhat.com> wrote:
>
> On Thu, Dec 19, 2019 at 5:17 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@virtuozzo.com> wrote:
...
> > Note also, that client may use NBD_OPT_LIST_META_CONTEXT with query
> > "qemu:dirty-bitmap:", to get list of all exported bitmaps.
>
> This is another option, I did not try to use this yet. We can use the sin=
gle
> exported bitmap and fail if we get more than one. This is probably better
> than changing the entire stack to support bitmap name.

I went with this option for now, getting the single bitmap published by qem=
u.
https://gerrit.ovirt.org/c/105861/2/common/ovirt_imageio_common/nbd.py

This way I can work with current libvirt, and I don't care about the name o=
f
the bitmap.

Practically this will break if libvirt will configure another dirty
bitmap, but it is fine.
Using API that promise list with unknown bitmap name is the same as API
returning only one bitmap. Libvirt cannot change it now since it will break
existing users :-)


