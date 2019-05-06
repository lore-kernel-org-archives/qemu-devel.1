Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BECEC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 20:25:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C457920830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 20:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ao2.it header.i=@ao2.it header.b="iUW0hVrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C457920830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ao2.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33581 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNkAY-0002OH-MH
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 16:25:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51312)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <ao2@ao2.it>)
	id 1hNk9k-00025F-V4
	for qemu-devel@nongnu.org; Mon, 06 May 2019 16:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ao2@ao2.it>) id 1hNk9c-0006Zq-L6
	for qemu-devel@nongnu.org; Mon, 06 May 2019 16:24:08 -0400
Received: from mail.ao2.it ([2001:4b98:dc0:41:216:3eff:fe7c:639b]:42513
	helo=ao2.it)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ao2@ao2.it>) id 1hNk9W-0006Uf-WE
	for qemu-devel@nongnu.org; Mon, 06 May 2019 16:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it;
	s=20180927; 
	h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date;
	bh=qMknE7Pr8aQk1OKvUGizh1g/xCBNmX7Yi+VhUD3teI4=; 
	b=iUW0hVrQy3pJpOSpKZWM3kIXu6+5bLx7rG19iLM/xHZ3RZxz1U8Svu4gvEWvGHSta5NVTGzIP6onjl8uD56CiB3qWisdhX9jbT9gU3H+X6U8n+a6oEfVEcRH2sRUNh6b/FYH4KUT2tfUWJg8JBSAN+pIk2o5ddo3z3tOvH8MiMk4sUeeydOCST5LnmVbc7ftLcw9H4eSHWrRUtfOK+J5qfLlGnnLmGoi3IrKGwsPsChrgvwWTjB2TxU1G2RBHeo+KmyqylspV/o9SWj5oLWt3mdgdXiflbYl+JSIwyS7buDh4ydlClSLRAYEwwMrHDghjVtMH2vjnS+8k6Soqe+EEQ==;
Received: from localhost ([::1] helo=jcn.localdomain)
	by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.84_2) (envelope-from <ao2@ao2.it>)
	id 1hNk9L-0006Kr-Jk; Mon, 06 May 2019 22:23:47 +0200
Date: Mon, 6 May 2019 22:23:51 +0200
From: Antonio Ospite <ao2@ao2.it>
To: Eric Blake <eblake@redhat.com>
Message-Id: <20190506222351.efc96ff189c0ec16d2410f0f@ao2.it>
In-Reply-To: <541bfc5c-0e45-58e6-f0b1-81e9b0c8881d@redhat.com>
References: <20190503082728.16485-1-ao2@ao2.it>
	<20190503082728.16485-3-ao2@ao2.it>
	<541bfc5c-0e45-58e6-f0b1-81e9b0c8881d@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H; 1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;
	]yA5<GWI5`6u&+ ; 6b'@y|8w"wB;
	4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG
	!pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2001:4b98:dc0:41:216:3eff:fe7c:639b
Subject: Re: [Qemu-devel] [PATCH v2 2/2] configure: disallow spaces and
 colons in source path and build path
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Antonio Ospite <antonio.ospite@collabora.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 May 2019 12:27:46 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 5/3/19 3:27 AM, Antonio Ospite wrote:
> > From: Antonio Ospite <antonio.ospite@collabora.com>
> > 
> > The configure script breaks when the qemu source directory is in a path
> > containing white spaces, in particular the list of targets is not
> > correctly generated when calling "./configure --help" because of how the
> > default_target_list variable is built.
> > 
> > In addition to that, *building* qemu from a directory with spaces breaks
> > some assumptions in the Makefiles, even if the original source path does
> > not contain spaces like in the case of an out-of-tree build, or when
> > symlinks are involved.
> > 
> > To avoid these issues, refuse to run the configure script and the
> > Makefile if there are spaces or colons in the source path or the build
> > path, taking as inspiration what the kbuild system in linux does.
> > 
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1817345
> > 
> > Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
> > ---
> >  Makefile  | 4 ++++
> >  configure | 6 ++++++
> >  2 files changed, 10 insertions(+)
> > 
> 
> > +++ b/Makefile
> > @@ -1,5 +1,9 @@
> >  # Makefile for QEMU.
> >  
> > +ifneq ($(words $(subst :, ,$(CURDIR))), 1)
> > +  $(error main directory cannot contain spaces nor colons)
> > +endif
> > +
> >  # Always point to the root of the build tree (needs GNU make).
> >  BUILD_DIR=$(CURDIR)
> >  
> > diff --git a/configure b/configure
> > index 9832cbca5c..f7ad4381bd 100755
> > --- a/configure
> > +++ b/configure
> > @@ -279,6 +279,12 @@ ld_has() {
> >  # make source path absolute
> >  source_path=$(cd "$(dirname -- "$0")"; pwd)
> >  
> > +if printf "%s\n" "$source_path" | grep -q "[[:space:]:]" ||
> > +  printf "%s\n" "$PWD" | grep -q "[[:space:]:]";
> 
> For less typing and fewer processes, you could shorten this to:
> 
> if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
>

I always forget about this printf feature :)

> but that's trivial enough for a maintainer to fold in if desired.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

