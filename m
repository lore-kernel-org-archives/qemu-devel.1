Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565E3C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 21:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E54F2072B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 21:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Bv7+HO8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E54F2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isCsL-0003FS-7q
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 16:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1isCrR-0008Kp-F7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1isCrN-0003YT-WB
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:39:28 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:47531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1isCrN-0003T3-FC
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 16:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=K6P27VijYtbkOW8W8xcotoP399r5iN7obpeZ6pnvR6o=; b=Bv7+HO8VXeoE83VnSecaiZSMYN
 EFD+LbPaoX73O61RW3KLvrWI66pzG8L+6IIpEfu0RlTTUOrvyrZzTypq1s+PW0uBdH/Px3NuA6g3J
 2/X/NYCHJfwd1Zi5HDweW0gCakZuU2Cb/NOHWqegDt1z/KkIR8Xar1MGkP5YXnHrBAlvEeFlyF1sL
 oCRiD6gBxikvKI7Bn9L4WKN0pyt3QxvKFTpkBk5gz1ASy9ltS7i5Dswi9xrsUkFI1rZdC6KMcEb36
 3PWT7rDzckUvkzCeujL8y7yuj+ygcsvTLXzj4GBJrz7zJQjZZ/09vlJ8JtH32/IH6qZRZHthtDjCX
 jHMosthg5bUCENJ7sVT8AIw1BeMoEz2uqYAEfIiNcLWjUZv7gXrhAg7riRJVqYW3A9CW3s1RRUL74
 +rLFCYQ+NBP9QZ9LRU0SUi2ZvTDmDKGDcFqkXMK5xGbZ6opAjwq6IC0HPFPAxiM9/6NDXjXfrsidw
 O6pNbfcDDBD5lKrAQkeSowaJswE0QD3RMWRVc8ZKZglMr9yb/+L01SKY0mLx7n7SvukM8rgewMFzL
 hpuajW2PSbXLBfCikmlVrqopsUXDtrFm6AVUXmL9vn+CUOUbs5zZwTI25rgmuUSnNK7T8sg6zEEKs
 NNTXEcoG6m+xAQgBK5N0uNFJnJM1uXrBa8H2pVCNM=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v3 02/11] 9pfs: require msize >= 4096
Date: Thu, 16 Jan 2020 22:39:19 +0100
Message-ID: <2330562.Ag4oC6Dxye@silver>
In-Reply-To: <20200116190748.6a656af8@bahia.lan>
References: <cover.1578957500.git.qemu_oss@crudebyte.com>
 <2705438.6bQikqVx44@silver> <20200116190748.6a656af8@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 16. Januar 2020 19:07:48 CET Greg Kurz wrote:
> > The point here was that there must be some kind of absolute minimum msize,
> 
> Then the absolute minimum size is 7, the size of the header part that is
> common to all messages:
> 
> size[4] Message tag[2]
> 
> > even though the protocol specs officially don't mandate one. And if a
> > client choses a msize < P9_IOHDRSZ, what useful actions shall it be able
> > to do?
> I haven't checked but I guess some messages can fit in 24 bytes.
> 
> > That's why I mentioned P9_IOHDRSZ just in case somebody might come up
> > later
> > asking to lower that minimum msize value for whatever reason.
> 
> That's precisely what I want to avoid. The semantic of P9_IOHDRSZ is
> that it is the header size of a Twrite message and as such it is used
> to compute the 'iounit' which the guest later uses to compute a
> suitable 'count' for Tread/Twrite messages only. It shouldn't be
> involved in msize considerations IMHO.
> 
> > But np, IMO this sentence makes the fundamental requirement for this patch
> > more clear, but I have no problem dropping this sentence.
> 
> Then you can mention 7 has the true minimal size.

Ok, I'll drop P9_IOHDRSZ completely and mention literal 7 as absolute 
theoretical minimum instead.

> > > > Furthermore there are some responses which are not allowed by the 9p
> > > > protocol to be truncated like e.g. Rreadlink which may yield up to
> > > 
> > > No message may be truncated in any way actually. The spec just allows
> > > an exception with the string part of Rerror.
> > 
> > Rreaddir, Rread, Twrite, Rerror can be truncated. So I suggest I'll just
> > change that to s/some/most/ semantically.
> 
> I mean truncate with loss of data. Rreaddir can return less than 'count'
> but it won't truncate an individual entry. It rewinds to the previous
> one and returns its offset for the next Treaddir. Same goes with Rread
> and Twrite, we always return a 'count' that can be used by the client
> to continue reading or writing.

Individual entries are not truncated, correct, but data loss: Example, you 
have this directory and say server's fs would deliver entries by readdir() in 
this order (from top down):

	.
	..
	a
	1234567890
	b
	c
	d

and say 37 >= msize < 45, then client would receive 3 entries ".", "..", "a" 
and that's it.

> Rerror is really the only message where we can deliberately drop
> data (but we actually don't do that).
> 
> > > Maybe just mention that and say we choose 4096 to be able to send
> > > big Rreadlink messages.
> > 
> > That's not the point for this patch. The main purpose is to avoid having
> > to
> > maintain individual error prone minimum msize checks all over the code
> > base. If we would allow very small msizes (much smaller than 4096), then
> > we would need to add numerous error handlers all over the code base, each
> > one checking for different values (depending on the specific message
> > type).
> 
> I'm not sure what you mean by 'minimum msize checks all over the code
> base'... Please provide an example.

1. Like done in this patch series: Treaddir has to limit client's 'count'
   parameter according to msize (by subtracting with msize).

2. get_iounit() does this:

		iounit = stbuf.f_bsize;
		iounit *= (s->msize - P9_IOHDRSZ) / stbuf.f_bsize;

   without checking anywhere for a potential negative outcome
   (i.e. when msize < P9_IOHDRSZ)

3. Example of directory entry name length with Rreaddir above.

Individual issues that can easily be overlooked but also easily avoided by not 
allowing small msizes in the first place.

Best regards,
Christian Schoenebeck



