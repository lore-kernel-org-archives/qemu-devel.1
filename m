Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3020AC5519A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD7C20656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCdhf+6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD7C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzuq-0000DG-K8
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jSzu2-0007O6-DV
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jSzu1-0005Ge-SL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:18:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jSzu1-0005GW-E9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587979092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wp5GFyfKapdeIVkNjqpCH4FVWw0VYM6g5TVNuBJWjXI=;
 b=OCdhf+6Zo691Ha7TJF/gxtrtfZargMb3Z6QaWh2+1aq9/9Y0mgBIzvy5I+nSj7ZnN6pUk7
 6WF5Xe7UerpGD0taJqmCq0eDESG3J8L+rDsBg8JXAFePJvQIz6jqS0LG7OWvdfkcUA+UHe
 6qGbM2iLjqYhk24wddamcxFv5u/FZ8Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-vx70sLgoMJKY-jciLfWjhA-1; Mon, 27 Apr 2020 05:18:09 -0400
X-MC-Unique: vx70sLgoMJKY-jciLfWjhA-1
Received: by mail-wm1-f69.google.com with SMTP id 71so8413719wmb.8
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 02:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pgHwErbHIHf8vl+AmHsB6UtYeyrd9jehT7AHaZmj9s0=;
 b=bYJn5DeXyrp+vjZeSvhQmph/J1XZP/IDmNZffoTyvScpE+GUirvPS0PETBQLSTUedO
 ONdVdQIBDaVKV0V6FAKPKuZiiywb+4Qj34Blrh+5MdC3myL5BphZBuqBcJB9GnhJHLom
 jPgO4JX+xoseNcPMWRsEtLnvOldJJLti/A6QbY6n6dGPNC7W9+coTP5fSJVJSguuJheg
 LbUTAdkTHBSC/Ni+xhR991DwmwHBTruBDhn+joSGb+0jHJMW/rLluAEugvhT+xlEf5jT
 g5Abs7MwiizbjTqjWsSj1vcBTwYGVnaJ56sz05bPDUFxxElo+godQcuqSJGj3Va8AUBi
 +rcg==
X-Gm-Message-State: AGi0PuaZ6GUfoCvGQGe/t2bv+e7joc4/fugR8jqxVetuPesFsGNr7F7D
 jH/6M+z41+3d0TXjVrXugvmjibrsgRwtLrF1gJSInT88ApOlL+eYyJ5FgLmCYSDI2n/s0+ZuL5V
 edS+sCbUy2BvB4og=
X-Received: by 2002:a1c:4985:: with SMTP id
 w127mr25083822wma.100.1587979088227; 
 Mon, 27 Apr 2020 02:18:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypLg2SHOPJeRGTVNfhQsgepl5Sp8VgXuB9dVkG08gwsvOqdC4rRP2L0nUmsC59HPOkI9px0a+A==
X-Received: by 2002:a1c:4985:: with SMTP id
 w127mr25083799wma.100.1587979087928; 
 Mon, 27 Apr 2020 02:18:07 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 v131sm15449866wmb.19.2020.04.27.02.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 02:18:07 -0700 (PDT)
Date: Mon, 27 Apr 2020 05:18:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: VIRTIO_NET_HDR_F_RSC_INFO in virtio-net vs headers update
Message-ID: <20200427051713-mutt-send-email-mst@kernel.org>
References: <20200427093345.4111acd9.cohuck@redhat.com>
 <8a559698-fb15-1f38-2fad-ee5db27f81f4@redhat.com>
 <20200427111029.703f8703.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200427111029.703f8703.cohuck@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:32:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 11:10:29AM +0200, Cornelia Huck wrote:
> On Mon, 27 Apr 2020 16:41:30 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>=20
> >=20
> > On 2020/4/27 =E4=B8=8B=E5=8D=883:33, Cornelia Huck wrote:
> > > Hi,
> > >
> > > I'm currently trying to prepare a linux-headers update to 5.7-rc3,
> > > which adds the definition of VIRTIO_NET_HDR_F_RSC_INFO.
> > >
> > > Unfortunately, this breaks the build of virtio-net, because now
> > > virtio_net_rsc_ext_num_{packets,dupacks} are undefined (they are
> > > guarded by existence of VIRTIO_NET_HDR_F_RSC_INFO).
> > >
> > > What is the right way to fix this? Remove the constants that are now
> > > provided by the header and keep the definitions of
> > > virtio_net_rsc_ext_num_{packets,dupacks}?
> >=20
> >=20
> > We probably need to add a version of the above function when=20
> > VIRTIO_NET_HDR_F_RSC_INFO is defined as attached.
> >=20
> > But I fail to understand why we need a fallback when=20
> > VIRTIO_NET_HDR_F_RSC_INFO is not defined.
>=20
> Yes, the current code in virtio-net looks a bit odd, which is why I
> asked.
>=20
> I see two options:
> - do the change you proposed, do the headers update, and then rip out
>    the compat handling
> - do the above in a single step
>=20
> I'd prefer the second option.

Slight preference for 1st one but both are ok.

> >=20
> > Thanks
> >=20
> >=20
> > >
> > > [I'd like to queue a headers update as soon as possible, as the whole
> > > s390 protected virt stuff depends on it...]
> > >
> > >


