Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D11C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27F120708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmMlSWB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27F120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJAl-0001NN-Sz
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 18:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1ixJ9y-0000no-1F
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1ixJ9w-00077i-4G
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:23:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53692
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1ixJ9v-00075Z-Vr
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580426614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VwOHhR6MY/vWG2T0Mlz60kca5YH/wACx5t0rEnrMgnE=;
 b=GmMlSWB3HhOkdIi3cTpsilfXHewZjon3dBClN/BqJ9Z0rtfgw8zu59HhaTo8aO9eBDcTny
 0gP3CYcxuRG+kM7jO+7zHDkoWAJE3jYm0QksPj8EzUblTJWylSnUmb0QdRqzxiRcvMwzzH
 xS7noKJ405Q4ntTxiVaVvm1IAqpHfRQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-TEAR-7FRM62-PwSsKP5wRg-1; Thu, 30 Jan 2020 18:23:32 -0500
Received: by mail-wm1-f69.google.com with SMTP id q125so832569wme.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 15:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VwOHhR6MY/vWG2T0Mlz60kca5YH/wACx5t0rEnrMgnE=;
 b=ZRzNsOfZ67bTat3TusY5XbHUqc1NHOgI+xY+d5qWmND31uxGA4lvDksYCZ6E0LlW8n
 FHgB3hHzGgZe4c0MChXLwjEu/hx1XCs8tp4K2JgINFvlnSItxnwzybDgcDz8iZo7KiKy
 pd/R0JQdNu0LFomjD0T18g3Wi7Fhc4TeHIxY2BbT3YWeZpmJHOxlikALtjUvuLwDTfb/
 aJlVdLIl7dfWf2zd97JdsRTx2bObdKliH6IJ7/lyrZ5vW2T63FP6TCuALAV98e7iRBUd
 FvH8uxhA+MkEQnrR7ljU2DW/gG4Ku8Bx8iq5wVpJyMs054R4zbJFxZeLW30ru63t//2C
 xv+A==
X-Gm-Message-State: APjAAAVgQ6F2vk1AzkjJ9MPQVlnSuYregT3io77b+w9nvIRsU80JLNFN
 8QXk6Dj/40v3N8+fvEWzfP4jFvnxtIBvhUjDGvaXxRNKD+hmHCE0BV6uCVQ1AQI0GSOxiYqCbj9
 /0yZH85ZX9y36W7SDp31Wq+m7jHrlWzw=
X-Received: by 2002:adf:f54d:: with SMTP id j13mr8101285wrp.19.1580426610749; 
 Thu, 30 Jan 2020 15:23:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvjekrcA8iPqAf7yv3yAHrftJTCS3EEK/w/XUnmCOcNRXeSwRXq8bDR3dNzXFUyTcF2A3RtruvVVN/M8p4ACI=
X-Received: by 2002:adf:f54d:: with SMTP id j13mr8101267wrp.19.1580426610469; 
 Thu, 30 Jan 2020 15:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20191218170003.31356-1-wainersm@redhat.com>
 <20191218170003.31356-4-wainersm@redhat.com>
 <a91835b1-dc60-2832-69cd-c25a7a658f3d@redhat.com>
In-Reply-To: <a91835b1-dc60-2832-69cd-c25a7a658f3d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 31 Jan 2020 00:23:19 +0100
Message-ID: <CAP+75-UPXDjFcXrRpFed2Sf-23nmLaU0EC8+AimfCSPJg4rDuw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tests/acceptance: avocado_qemu: Refactor the
 handler of 'machine' parameter
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
X-MC-Unique: TEAR-7FRM62-PwSsKP5wRg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 11:56 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 12/18/19 6:00 PM, Wainer dos Santos Moschetta wrote:
> > The Test._param_to_vm_args variable contain VM arguments that should be=
 added
> > at launch which were originated from test parameters. Use this variable
> > to set -M from 'machine' parameter as well.
> >
> > Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> > ---
> >   tests/acceptance/avocado_qemu/__init__.py | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> > index aff32668d9..ba9539d511 100644
> > --- a/tests/acceptance/avocado_qemu/__init__.py
> > +++ b/tests/acceptance/avocado_qemu/__init__.py
> > @@ -120,6 +120,8 @@ class Test(avocado.Test):
> >
> >           self.machine =3D self.params.get('machine',
> >                                          default=3Dself._get_unique_tag=
_val('machine'))
> > +        if self.machine:
> > +            self._param_to_vm_args.extend(['-M', self.machine])
> >
> >           default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
> >           self.qemu_bin =3D self.params.get('qemu_bin',
> > @@ -162,8 +164,6 @@ class Test(avocado.Test):
> >               name =3D str(uuid.uuid4())
> >           if self._vms.get(name) is None:
> >               self._vms[name] =3D self._new_vm(*args)
> > -            if self.machine is not None:
> > -                self._vms[name].set_machine(self.machine)
> >           return self._vms[name]
> >
> >       def tearDown(self):
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Also, applied to my python-next tree:
> https://gitlab.com/philmd/qemu/commits/python-next

Oops, this depends of the previous patch (which has a v3).
I'm removing this patch.


