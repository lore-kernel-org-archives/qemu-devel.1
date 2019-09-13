Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C3CC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8709C206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXK7/CXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8709C206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8iXW-0007y6-Jx
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 06:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ronniesahlberg@gmail.com>) id 1i8iWo-0007TO-LE
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ronniesahlberg@gmail.com>) id 1i8iWj-0006Kn-LB
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:10:10 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44365)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ronniesahlberg@gmail.com>)
 id 1i8iWh-0006H7-4d; Fri, 13 Sep 2019 06:10:03 -0400
Received: by mail-io1-xd44.google.com with SMTP id j4so61809435iog.11;
 Fri, 13 Sep 2019 03:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=v7VoEjZd64TBrVcaMX+wiNehcYDH0VADPAWFTCkD7BY=;
 b=EXK7/CXI2vqhbGqmEoAl0jcvNC0ygn9EwcAWw6SHIm/ybhxFrSR7rtQwoXrXmT0DRg
 zYkljnnyVsHvn7HsNQTOQ2KPPiOQNB/qSALqh92FEJs4IIG1OTKnVBBtqCs/kEZ3Uvuv
 PtyPVh+Mw8eSGQ2CJijXYjreviM8wfBDzJDW1GNPyMLGg2v11hX3+5jKgqqzc8PQJb2H
 tVbZtAcxJbu2dq6AULaN/7BAb8nHqKwYPUczqjkYCFG8hhyz4nBqU9HaP0iewpwWDFpx
 h9crkePONIwb7eOCfz+OZr0l546XxVGxd8G4eo0RoS/fIsK85UXyZoPS0hv2vUDKvvth
 F/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=v7VoEjZd64TBrVcaMX+wiNehcYDH0VADPAWFTCkD7BY=;
 b=m4UqC9ubWLzrPKdiQcKZ3nnigpQBXXLbxV4iepk2ZwcknRm20glGHQLbA3M7sR3p2o
 kCUpPvE8Vgj6muzSPDDa9UNEgnhTby7L56aDm3mMWlRSsLsuPgifFlK5Fb3ccMX5LfkR
 zuchL+Q0PJ8ML7hXCUKsRVxPmsI9x17JRnGDwIC5iM50diJrV3CaVn4CTkXh4rYJBMpK
 wQ821IPJEr/yF0g+wl5J54huyCBOhGXMBzfk4zKMroUWWEE/GA65lpB8B+C9Fvhimzoy
 UwYg9EzIPdqpAP+8W5KKCuheFpq0NSM+N6OxHVhBufTL1iJ1emgoQVQUDzLVGm6qUK1d
 BTCw==
X-Gm-Message-State: APjAAAXQLaJc8LYkuRa/T0DIS9BhMooHPv5DIpJNs3hIdgnyUV93EtX4
 14Ur0dNyJvnXE1ltJhNLso4x3VIwdLhpvsM7R58=
X-Google-Smtp-Source: APXvYqxgLbWOfuaGVeca20JjaVYBg6IWuxzIrbzIv9Qn7b5JBn7qKqK2qJ+m+pAPaSBRJny4Gb5yNbt1GWQU35F3Du0=
X-Received: by 2002:a6b:b243:: with SMTP id b64mr3408898iof.252.1568369401798; 
 Fri, 13 Sep 2019 03:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190910154110.6905-1-pl@kamp.de>
 <20190910154110.6905-3-pl@kamp.de>
 <e2b37e13-ef22-4a16-38e5-3866e7d5409a@redhat.com>
In-Reply-To: <e2b37e13-ef22-4a16-38e5-3866e7d5409a@redhat.com>
From: ronnie sahlberg <ronniesahlberg@gmail.com>
Date: Fri, 13 Sep 2019 20:09:50 +1000
Message-ID: <CAN05THTY99Zj84LerBurGsHJDZToiYkhXvM=0eoL4SOHYUf=qw@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [PATCH V2 2/2] block/nfs: add support for
 nfs_umount
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 11, 2019 at 5:48 PM Max Reitz <mreitz@redhat.com> wrote:
>
> On 10.09.19 17:41, Peter Lieven wrote:
> > libnfs recently added support for unmounting. Add support
> > in Qemu too.
> >
> > Signed-off-by: Peter Lieven <pl@kamp.de>
> > ---
> >  block/nfs.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/block/nfs.c b/block/nfs.c
> > index 2c98508275..f39acfdb28 100644
> > --- a/block/nfs.c
> > +++ b/block/nfs.c
> > @@ -398,6 +398,9 @@ static void nfs_client_close(NFSClient *client)
> >              nfs_close(client->context, client->fh);
> >              client->fh =3D NULL;
> >          }
> > +#ifdef LIBNFS_FEATURE_UMOUNT
> > +        nfs_umount(client->context);
> > +#endif
> >          nfs_destroy_context(client->context);
> >          client->context =3D NULL;
> >      }
>
> I don=E2=80=99t understand what unmounting means in this context.  Is it =
just
> generic clean-up for NFSv3 (it appears that it=E2=80=99s a no-op for NFSv=
4)?
> Why isn=E2=80=99t that done by nfs_destroy_context()?

Umount is weird since there isn't actually any state in NFSv3 and
"mounting" in nfsv3 is really just a matter of converting the path to
be mounted into a filehandle.
That is all the mount protocol is really used for.

This is all handled in a separate protocol/server called rpc.mountd
that is separate from NFSd. Running as a different process and
listening to a different port.
And the only purpose of rpc.mountd is to take a path to a share and
return a nfsv3 filehandle to the root of that path.
As a side-effect, rpc.mountd also keeps track of which clients have
called MNT but not yet UMNT and thus showmount -a
can give a lost of all client that have "mounted" the share but not
yet called "UMNT".

It has no effect at all on NFSv3 and is purely cosmetic. This ONLY
affects "showmount -a" output.
NFSv4 does away with all these separate protocols such as mount,
statd, nlm and even portmapper
so there is not even a concept of showmount -a for nfsv4.


As the libnfs maintainer, why did I do nfs_umount() the way I did?
First of all, I think of nfs UMNT as really just cosmetic and didn't
want to put too much work into it. But people wanted it.

I implemented it as a sync function since I think few people would
actually use it at all and it meant that I just didn't have to invest
in having to build an async piupelinje.

I did NOT implement it inside nfs_destroy_context() since that
function is supposed to be, in my view, non-blocking andn should just
tear the connection and immediately return.
As unmount would be
* close the tcp socket to the nfs server
* open new socket to portmapper and ask "where is rpc.mountd"
* close socket to portmapper, then open new socket to rpc.mountd
 * tell rpc.mountd to remove us from the showmount -a list
* close socket

I just took the cheap and easy path. Do it as a sync function with my
own eventloop.

Again, UMNT has no real effect on anything related to NFS except what
showmount -a will return. That is one big reason why
I was just not much motivated enough to build it as an async function.

Once we all switch to NFSv4 this will all be moot since the MOUNT
protocol no longer exists and neither does rpc.mountd.



>
> Max
>

