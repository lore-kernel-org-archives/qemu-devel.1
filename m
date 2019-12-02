Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE9DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259A02070B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFzICIIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259A02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iboxI-0003wd-CE
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 11:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ibowT-0003Sy-79
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ibowR-000381-R7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:52:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54388
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ibowR-00037v-NK
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575305575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8o9wbt8QJrr0V6TI7ckB8LfeVTjp3iTj00Ne9zwCS0w=;
 b=eFzICIIcRwkXgvOy/M5GZ9jHQTwDsW5Fp5QBFpGdgrYQifm/hS6c+29gsYy+2X+EGZGv6d
 vwm3eXix8D3BNvlRYXahZ72YaUJN9qrVL/9VnJAc8FzGP/jLb0dovCCgM8RlFWH3aLqdPz
 a5pTpDYCLHyhcDPLHLVG3PQbGz46WAY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-6WddnxW7PReqa828DbYbcw-1; Mon, 02 Dec 2019 11:52:50 -0500
Received: by mail-qk1-f199.google.com with SMTP id b9so65499qkl.13
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 08:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ro72EbjH1P33boRCaxKcroQU1/ah3SYZHMEEMtBH3L8=;
 b=OFeNucWc/wrcjv54kaALue/sBPkNm5a7pBYNNPjsM+mB1H6wwK+5QZB9JItohJFp54
 FcJFFXMjhCiRKOsGCHal+K9arOx5frM4fhuwviVqXkTeyyMc1KhMVunT9U1Y9bMEJo4H
 FNIVT+szfKDaIIGZKaRpZxhz1NtmVDQV+jTN1FBlFnAOZKnGSzXQ4lv+698yiuYnWuR5
 mCqhNj/5oNQHTfg6NPyvumbYE4LV5rIw3R/8HQ2vhYCkcyiJvNkSpkdH3cHNkqL8/yIN
 B/+gMSvBmCr1kFys+X2fVKC/d4suSFFN52t9sQVE4fyiTOGRT0WGLX5bYpJkiVNT/9mn
 IHcA==
X-Gm-Message-State: APjAAAWGbhPhv8MwpcKMI0ViCl+7wib9AcRC1I3z88dmz9OMMJ2brZO5
 +HjhikPo3IpHRAEdK3CicKqheVnreSxawp7m3OFrFy9y5q2+oMCSlVliumPat+fhhFdAvu/RF3t
 moHQHsCgIfTN+7PY=
X-Received: by 2002:ac8:745a:: with SMTP id h26mr253648qtr.192.1575305570337; 
 Mon, 02 Dec 2019 08:52:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAvGEsL8SzLI/ryVsQm6IbOK6ozyGmfjN/pYzyDkzrVVEsKpLAnstGbtbXm6z55qIpH72HAw==
X-Received: by 2002:ac8:745a:: with SMTP id h26mr253629qtr.192.1575305570117; 
 Mon, 02 Dec 2019 08:52:50 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id n198sm54011qke.0.2019.12.02.08.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 08:52:49 -0800 (PST)
Date: Mon, 2 Dec 2019 11:52:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: virtiofsd: Where should it live?
Message-ID: <20191202114724-mutt-send-email-mst@kernel.org>
References: <20191125185021.GB3767@work-vm>
 <20191202043040-mutt-send-email-mst@kernel.org>
 <20191202164423.GE2904@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191202164423.GE2904@work-vm>
X-MC-Unique: 6WddnxW7PReqa828DbYbcw-1
X-Mimecast-Spam-Score: 0
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
Cc: mszeredi@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 02, 2019 at 04:44:23PM +0000, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
> > On Mon, Nov 25, 2019 at 06:50:21PM +0000, Dr. David Alan Gilbert wrote:
> > > Hi,
> > >   There's been quite a bit of discussion about where virtiofsd, our
> > > implemenation of a virtiofs daemon, should live.  I'd like to get
> > > this settled now, because I'd like to tidy it up for the next
> > > qemu cycle.
> > >=20
> > > For reference it's based on qemu's livhost-user+chunks of libfuse.
> > > It can't live in libfuse because we change enough of the library
> > > to break their ABI.
> >=20
> > Generally there could be some ifdefs that allow one to
> > build libfuse-host or whatever from the same source.
> > I am guessing the big reason this doesn't fly is that
> > libfuse is not actively developed anymore.
>=20
> libfuse is certainly taking patches; so it's not dead.
> However, the changes for the transport are quite invasive,
> and it doesn't feel right to impose them on it.
> We've pushed up small fixes/changes etc - but not things
> that are big intrusive lumps for our use.

Maybe they will want these patches then ....  The big question would be
around security, e.g.  what if you rebase, how do you know they didn't
introduce what is a security hole for virtiofsd ...  But then, that
question remains even if you keep a separate tree.

> > Given that, the main remaining part is libvhost-user,
> > and it's less work to use than to duplicate that.
> > That kind of dictates being in qemu.
> >=20
> > >  It's C, and we've got ~100 patches - which
> > > we can split into about 3 chunks.
> > >=20
> > > Some suggestions so far:
> > >   a) In contrib
> > >      This is my current working assumption; the main objection is it'=
s
> > >      a bit big and pulls in a chunk of libfuse.
> > >   b) In a submodule
> > >=20
> > >   c) Just separate
> > >=20
> > > Your suggestions/ideas please.  My preference is (a).
> > >=20
> > > Dave
> >=20
> >=20
> > My preference is close to a, and maybe to avoid confusion we should hav=
e
> > a new top-level directory for "separate daemons qemu invokes, and need
> > to be built together with qemu". libvhost-user would have to move there=
,
> > too. "modules"?
>=20
> "modules" feels too close to "plugins" to my mind.
>=20
> Dave

daemons?

> >=20
> > >=20
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >=20
> >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


