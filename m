Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F61CC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 04:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07EF12073E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 04:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="zXUBZNGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EF12073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUMv4-0004eh-5k
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 00:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jUMtw-0004BT-1L
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jUMsP-0001Ft-CI
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:03:47 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:38736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jUMsO-0001BV-Mt
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:02:12 -0400
Received: by mail-yb1-xb44.google.com with SMTP id l5so4376341ybf.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 21:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dwPr5CeSD22xun4uwHzjt31R/6aosAS1XXrgpoFOuos=;
 b=zXUBZNGDKBn4JNhA/nXzll1ANUOlrxcZpukSk9jo1kIhHN2vSmy2k3UH4Zf+uPrjs0
 ixB64N2C+/iqxEB/H2LVJ//HRkjOf1thYs3mMGLvpQx2EFl+nGoeGg1Ma2A2gbccoI9U
 +57iPSzKgtPIHcyBOwVmQXZGQH0v9stau1B2S2KXwPOkup9C4cV7MxMT5pmwiNUBF9yJ
 Qm+FNQzaz0qYViV6363Gpf/kJTGUTn3P/J+tYhBpgbKXqV1eM3hhRSyCVU6/CO/I4AbK
 L8mILsS902HfnaJYk0e2VzCsmLqE70kQ++Bjz7jCqJ7lo3XF+GqfYbW3YmImQbBATkr1
 gqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dwPr5CeSD22xun4uwHzjt31R/6aosAS1XXrgpoFOuos=;
 b=t70WkszI2CmzzCT7xiX9xJfN6loADjCYrff67E98PddJyoFZkIuBUKc4z9FCH58seO
 7etNdVbA+pNDEQdd0O/eGXVo4zRFRAX3eBs2a6EHvHmHUXPWdqFhZCk8D5Y4wU//tUJm
 0I3fIu18F4JSAJxMuMLZ6WqBwu3fcaOQkIABYnKDXD4JDJycC078/BH76XA9HZd4+nR3
 eUo3w9FaxBT9stWHZkOz9nO73S76iUs2bxLuF898t3I44lKbOW9nDf6MUpgU9NB3Flih
 LMW4oQDYABHck9xikdmw7NAMctrTdCxA+bHy3OtzeMgkBvv7C2gw/AFUYNW962bvRybP
 UaMA==
X-Gm-Message-State: AGi0PubtUU1/iXs0KbZqquRw+JkpLwXMGDpcVGQFDWfQCCuC4YQh/nvf
 KOuCPh4gfo9TBsGRkDGjZKZ5a941aIW7eCI1wq8dXg==
X-Google-Smtp-Source: APiQypLECBuM/B/5h128wGk3f92rddFJozjxQL1lhebHQPh+74hhO8OjRmHMwRm5Zp8irKyrTP75NPvpvPBHvJEHlDM=
X-Received: by 2002:a25:4149:: with SMTP id o70mr3262661yba.235.1588305730529; 
 Thu, 30 Apr 2020 21:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200329150953.23812-1-yuri.benditovich@daynix.com>
 <20200331102004-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200331102004-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Fri, 1 May 2020 07:01:58 +0300
Message-ID: <CAOEp5OeOcTZM_b254LxX5=jRiiAkGSoLsbMeiMjPs2OoF1MxNA@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] reference implementation of RSS and hash report
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000dcff4905a48e3e76"
Received-SPF: none client-ip=2607:f8b0:4864:20::b44;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::b44
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000dcff4905a48e3e76
Content-Type: text/plain; charset="UTF-8"

Michael/Jason,

As Linux headers was updated in qemu and now include RSC/RSS/Hash
definitions, please let me know what you prefer:
1. You apply this series as is, then I submit clean-up series that will
remove all the redundant defines from virtio-net.c
2. I post v8 of this series with cleanup of all the redundant defines and
also RSC ones
3. Something other

Thanks,
Yuri Benditovich

On Tue, Mar 31, 2020 at 5:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Sun, Mar 29, 2020 at 06:09:46PM +0300, Yuri Benditovich wrote:
> > Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
> > features in QEMU for reference purpose.
> > Implements Toeplitz hash calculation for incoming
> > packets according to configuration provided by driver.
> > Uses calculated hash for decision on receive virtqueue
> > and/or reports the hash in the virtio header
>
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
> Probably post 5.0 material.
>
> > Changes from v6:
> > Fixed a bug in patch 5 "reference implementation of hash report"
> > that caused the ASAN test to fail
> > was: n->rss_data.populate_hash = true;
> > fixed: n->rss_data.populate_hash = !!hash_report;
> >
> > Yuri Benditovich (7):
> >   virtio-net: introduce RSS and hash report features
> >   virtio-net: implement RSS configuration command
> >   virtio-net: implement RX RSS processing
> >   tap: allow extended virtio header with hash info
> >   virtio-net: reference implementation of hash report
> >   vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
> >   virtio-net: add migration support for RSS and hash report
> >
> >  hw/net/trace-events            |   3 +
> >  hw/net/virtio-net.c            | 448 +++++++++++++++++++++++++++++++--
> >  include/hw/virtio/virtio-net.h |  16 ++
> >  include/migration/vmstate.h    |  10 +
> >  net/tap.c                      |  11 +-
> >  5 files changed, 460 insertions(+), 28 deletions(-)
> >
> > --
> > 2.17.1
>
>

--000000000000dcff4905a48e3e76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Michael/Jason,<div><br></div><div>As Linux headers was upd=
ated in qemu and now include RSC/RSS/Hash definitions, please let me know w=
hat you prefer:</div><div>1. You apply this series as is, then I submit cle=
an-up series that will remove all the redundant defines from virtio-net.c</=
div><div>2. I post v8 of this series with cleanup of all the redundant defi=
nes and also RSC ones</div><div>3. Something other</div><div><br></div><div=
>Thanks,</div><div>Yuri Benditovich</div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 31, 2020 at 5:26 PM Mi=
chael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Sun=
, Mar 29, 2020 at 06:09:46PM +0300, Yuri Benditovich wrote:<br>
&gt; Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT<br>
&gt; features in QEMU for reference purpose.<br>
&gt; Implements Toeplitz hash calculation for incoming<br>
&gt; packets according to configuration provided by driver.<br>
&gt; Uses calculated hash for decision on receive virtqueue<br>
&gt; and/or reports the hash in the virtio header<br>
<br>
<br>
Reviewed-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" targe=
t=3D"_blank">mst@redhat.com</a>&gt;<br>
<br>
Probably post 5.0 material.<br>
<br>
&gt; Changes from v6:<br>
&gt; Fixed a bug in patch 5 &quot;reference implementation of hash report&q=
uot;<br>
&gt; that caused the ASAN test to fail<br>
&gt; was: n-&gt;rss_data.populate_hash =3D true;<br>
&gt; fixed: n-&gt;rss_data.populate_hash =3D !!hash_report;<br>
&gt; <br>
&gt; Yuri Benditovich (7):<br>
&gt;=C2=A0 =C2=A0virtio-net: introduce RSS and hash report features<br>
&gt;=C2=A0 =C2=A0virtio-net: implement RSS configuration command<br>
&gt;=C2=A0 =C2=A0virtio-net: implement RX RSS processing<br>
&gt;=C2=A0 =C2=A0tap: allow extended virtio header with hash info<br>
&gt;=C2=A0 =C2=A0virtio-net: reference implementation of hash report<br>
&gt;=C2=A0 =C2=A0vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro<br>
&gt;=C2=A0 =C2=A0virtio-net: add migration support for RSS and hash report<=
br>
&gt; <br>
&gt;=C2=A0 hw/net/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4=
48 +++++++++++++++++++++++++++++++--<br>
&gt;=C2=A0 include/hw/virtio/virtio-net.h |=C2=A0 16 ++<br>
&gt;=C2=A0 include/migration/vmstate.h=C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt;=C2=A0 net/tap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +-<br>
&gt;=C2=A0 5 files changed, 460 insertions(+), 28 deletions(-)<br>
&gt; <br>
&gt; -- <br>
&gt; 2.17.1<br>
<br>
</blockquote></div>

--000000000000dcff4905a48e3e76--

