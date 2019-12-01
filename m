Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F33EC432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 21:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B472146E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 21:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyFso0rN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B472146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibWy4-0004XS-Gx
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 16:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ibWxL-00044Z-0O
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 16:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ibWxH-00019Y-H8
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 16:40:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50067
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ibWxH-00016W-8i
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 16:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575236434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tG5TIZfLOA8xt1lh5rIij2KaaBjofpenlumD9fhRM3E=;
 b=AyFso0rNVXN6qyAcTA6x1rXijuJjzSp9wBkyWV/TJBRE0qLJySQSm2fNLSpIZOR3eA9v0A
 ZLFVa2EieH7MMzFap4pajmlIknUjcjb89oLZnYeeeehsnuu+Q9N9+cousk13/gfXJqO48/
 sFaBuQ/LFeoElggtJzqNVzE2McR8TyM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-cUhebpeKNG-L_HV5gdkfbA-1; Sun, 01 Dec 2019 16:40:31 -0500
Received: by mail-qt1-f197.google.com with SMTP id f14so23264363qto.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 13:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JTGzgGPMZkAos2frxTFOW4GGlQLGb9Frjb4++KqTi/M=;
 b=Q4x7y+EbyJ2HFTj6u5ODw45mkNVt4F0x3YNF0ZyubFB8dI3+hpnLWA4G9a9ndotWE+
 CaZD5WLwRs3KPlhEkxpqMzoPXnlPxiEgsDpMRSpwwuSFtNn6l8Sn0dWveBdiaiyZutt0
 hmqjk7j74/3ZuejLA7JDx5DNUrw++/6pNZVSXd63Ik20ks0vU8lQN7+dHuq10Y4pivPK
 ct2y1p9gxs2q9osyO2YjdXbMVZHkQyIug029y7j0Kv6b0Lt7EcpPJ5ujUVh/Z56P7eG3
 jpZ/+YkXD0s8C+mMJM6XLMzov5LzhsKuJGtQAqV+u3rPRIKJ9dgXe9A3831T3tnYiDlT
 QRjQ==
X-Gm-Message-State: APjAAAWpsg4Ak3iqJ/yrfRoOPfap4Jo5YVk4SWqLMUJzws3egw//UH9H
 cxMuR0HsvJ5SXMtaPxNN24dfXlwdThMOyID4itnojQXNpygbOkTA8oxdtrKswJh919k0Jkb/Yck
 uYhlcjbC/mgX3qqg=
X-Received: by 2002:a0c:9304:: with SMTP id d4mr20056119qvd.12.1575236430597; 
 Sun, 01 Dec 2019 13:40:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJvP9j5S9q3Ge/KOdZS8vWQSybrc86pCylj6ImGZeLhx1dUelTS/voklZcfzNpx7tuR/qMng==
X-Received: by 2002:a0c:9304:: with SMTP id d4mr20056096qvd.12.1575236430400; 
 Sun, 01 Dec 2019 13:40:30 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id r48sm15329424qte.49.2019.12.01.13.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2019 13:40:29 -0800 (PST)
Date: Sun, 1 Dec 2019 16:40:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC net-next 08/18] tun: run offloaded XDP program in Tx path
Message-ID: <20191201163730-mutt-send-email-mst@kernel.org>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
 <20191126100744.5083-9-prashantbhole.linux@gmail.com>
 <f39536e4-1492-04e6-1293-302cc75e81bf@gmail.com>
 <20191201.125621.1568040486743628333.davem@davemloft.net>
MIME-Version: 1.0
In-Reply-To: <20191201.125621.1568040486743628333.davem@davemloft.net>
X-MC-Unique: cUhebpeKNG-L_HV5gdkfbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: songliubraving@fb.com, jakub.kicinski@netronome.com, hawk@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, jasowang@redhat.com,
 john.fastabend@gmail.com, ast@kernel.org, qemu-devel@nongnu.org,
 prashantbhole.linux@gmail.com, kvm@vger.kernel.org, dsahern@gmail.com,
 yhs@fb.com, andriin@fb.com, kafai@fb.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Dec 01, 2019 at 12:56:21PM -0800, David Miller wrote:
> From: David Ahern <dsahern@gmail.com>
> Date: Sun, 1 Dec 2019 09:39:54 -0700
>=20
> > Below you just drop the packet which is going to be a bad user
> > experience. A better user experience is to detect XDP return codes a
> > program uses, catch those that are not supported for this use case and
> > fail the install of the program.
>=20
> This is not universally possible.
>=20
> Return codes can be calculated dynamically, come from maps potentially
> shared with other bpf programs, etc.
>=20
> So unfortunately this suggestion is not tenable.

Right. But it is helpful to expose the supported functionality
to guest in some way, if nothing else then so that
guests can be moved between different hosts.

Also, we need a way to report this kind of event to guest
so it's possible to figure out what went wrong.

--=20
MST


