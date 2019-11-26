Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEFBC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF5E20722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqWvYO8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF5E20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZWll-000688-NN
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 04:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iZWjm-0004Mk-FW
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iZWjg-00049y-ID
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:02:22 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iZWjg-00049a-A6
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:02:16 -0500
Received: by mail-wm1-x336.google.com with SMTP id f129so2333011wmf.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 01:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4g6DFYGNdDGjfZc5GLBMg/U+DjxAAWPrM01NS+p/b1o=;
 b=XqWvYO8onTu6h2H8uCdKYhFl8yGcqBUCI50YcWE7PraT2HgwKt16ciyuldeId23chq
 OqHTffpn0y+TBoXYX8SvYeTPSoIg/qqFvblf8vyR969pVeRCKvueTVeamPK52gg4u21d
 yc7ZJ6b/HpBHhTWdbHc/OWwXUQ5+5a0BypHHQdXFnS7x8UZBB7o8Qd5hCbVIlbY2vyv5
 6/VC+jQWe24J58PuG88/DrH1DJ/fcPOJ7pcwPe27Pg88WXQfRxhRvHOcZyWkQl+x5bkX
 9AvpBcQnEpVHb6wsSO1OPep/RO+TMVTXIFmfzXOFiaMivOmSNjRs3J5z/76llrbZBOd0
 h3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4g6DFYGNdDGjfZc5GLBMg/U+DjxAAWPrM01NS+p/b1o=;
 b=gH0ZXnNu9Zz7A0P7arV8dhYyCz3Z9xsEdFzVM5ChkT4K+yznJ36UL686zv60tF2pM/
 KBNQngLM6KXmkzJgu19klT4nhXwnRVJWgTL3c+zzuvZyeV00ficWqXqWTV6/68dAb1VW
 v8q0hdWFfvAn9acnr0Pu9mB9S7uTMsPaiOPAeaKyMJxiDiH6t9yRDD9IdBLsGt1YJnp7
 xGB/Rw2j5Sg1aWgMVg4OP1TVUVNzR+R8xfIVBwfKnAqYzu/i++2y7EsCZBeAM1XDIowh
 RDiYqsTKMUqlIy9+pAmQJONt3x845JwBqSDbk3tgfJUz1QGKK/daoaz+fjQYlyQtt6vg
 Ut9Q==
X-Gm-Message-State: APjAAAXX+K4XrQZ7UNeZXt90hd55B48eTR5Q6TzJZw63b6oA4CBxbrqh
 du30oOoW9h3J5AGdxPStqPuzaazNcBbpbt4rAU8=
X-Google-Smtp-Source: APXvYqwBEmn1qjbVPyjEwDMMISGmn9/vmv48cw1gsguSZtk+k9zQwIMrm2Om8Koy83HR3lfWnRwEKl3HiWe6P9v3tqc=
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr3113414wmh.5.1574758933698;
 Tue, 26 Nov 2019 01:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20191125185021.GB3767@work-vm>
In-Reply-To: <20191125185021.GB3767@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Nov 2019 13:02:01 +0400
Message-ID: <CAJ+F1C+6kgO5kX=fYQno3g-YoxxqOyph+zanpDmFaOnOqirKYQ@mail.gmail.com>
Subject: Re: virtiofsd: Where should it live?
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, mszeredi@redhat.com,
 "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David

On Mon, Nov 25, 2019 at 10:50 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> Hi,
>   There's been quite a bit of discussion about where virtiofsd, our
> implemenation of a virtiofs daemon, should live.  I'd like to get
> this settled now, because I'd like to tidy it up for the next
> qemu cycle.
>
> For reference it's based on qemu's livhost-user+chunks of libfuse.
> It can't live in libfuse because we change enough of the library
> to break their ABI.  It's C, and we've got ~100 patches - which
> we can split into about 3 chunks.
>
> Some suggestions so far:
>   a) In contrib
>      This is my current working assumption; the main objection is it's
>      a bit big and pulls in a chunk of libfuse
>
>   b) In a submodule
>
>   c) Just separate
>
> Your suggestions/ideas please.  My preference is (a).
>


It's more about code sharing and lifecycle.

The project started in a separate repository, and the proposed patches
for qemu aren't a clean series. Reviewing it is harder than it should
be, as we have to review/accept the whole thing.

As you said, it doesn't share much with qemu, but libvhost-user (which
we could quite easily copy or make standalone/submodule).

Then it dumps code from libfuse that is questionnable (showing age)
and often redundant with facilities provided by either glib, qemu
utils etc.

Is vhost-user-fs (the qemu device) going to have a strong relation
with virtiofsd?
Are we going to support different version of qemu and virtiofsd
combination? I suppose we have to, as vhost-user protocol should allow
that, and it's nice to allow other to experiment and implement it in
different ways.
If not, then perhaps we should think about introducing some version
checking between qemu and external processes (with config_stamp,
similar to modules).

From what I understand, I think c) would be fine. However, for
convenience/testing reasons, b) would be my preference.

--=20
Marc-Andr=C3=A9 Lureau

