Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A459BC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1AA20757
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAVinZHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1AA20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbVj-0005Zt-J2
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jMbUh-0004Re-LU
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jMbUg-0001BS-KU
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:01:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36612
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jMbUg-0001Au-GE
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586455298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5U6sFpx2dH/GaJD3694bYIhd8KMdcHVrUQFq/q+enY=;
 b=OAVinZHhMZBMvnWdqfVC+tra6tIXCFB54ldpUuRl+dpYJWOKSBvk4BqugpSE9WzZx0ye+M
 hncMFN/V7iUrY4xkGQ0rar03FMX+367Zce/RNXTMeekUgiAgRc0L6HIEjQLIxeLEhWZpSJ
 75ZoD7ewXRNLZHIJGGkvBqXcJLwAa/I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-oUWP4OLvPQ2pwaTGKLC4hw-1; Thu, 09 Apr 2020 14:01:36 -0400
X-MC-Unique: oUWP4OLvPQ2pwaTGKLC4hw-1
Received: by mail-wm1-f69.google.com with SMTP id w8so413726wmk.5
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 11:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=XerKs3Mbx2b79V0d+hgonl7siBG/nHxzL60tiDiMwjg=;
 b=U/wrOSYpL1uM1QpAXTDGrNvj0H3NSAZn2W1pqveJUIIJgqN2bLIKWW37nMo8boGptx
 11rK219FM334QyU45LgrKL+cqPFrYvOl+zt8SAMrC1y3p4PG1RuAQfE0LF6pXUqYDm1q
 kMJx8fi+9bS5/5W7hBUG3sYA0eeOTwO4+F6cp2Q48y4gT9kgY+EPi3S5b0/Nt19Y1uxs
 s+s+q567Zgt3URKj4ES2h4htdxLWFnvEolXuHZXVPimkxiSSQUGev9EqMCqZsqntcgvV
 k0dulpTgtm6psZf3MMZ0yhFSGJP05JEj3J35wyAR9QCWLwTpXfOS0WOZERH+2bVubeUs
 5d4g==
X-Gm-Message-State: AGi0PuaeY/5B7mkqqBUo1XPBsTXH+m+Gl5EYwRQ8mq2K+8yprA5E0XD1
 HviqEcYshoD0kgk2kn+x//y+yGLpgPFFumkQ+NoIYUsfvyQD9CBC34cqlCYM7lk0Ezi9iGt0lh6
 Kv1orsVSFT4C3MU4=
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr948848wmh.141.1586455295057; 
 Thu, 09 Apr 2020 11:01:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypIsQkT3VQAHQmBNuMcQg/sSOd45W00HdXZKoeNtTZDLkoWhfqqFiye3VgiJ0KRxKX+yAvTTAw==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr948827wmh.141.1586455294786; 
 Thu, 09 Apr 2020 11:01:34 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id c190sm4649081wme.10.2020.04.09.11.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 11:01:34 -0700 (PDT)
Date: Thu, 9 Apr 2020 14:01:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/2] gdbstub: i386: Fix gdb_get_reg16() parameter to
 unbreak gdb
Message-ID: <20200409180130.GA10061@xz-x1>
References: <20200409164954.36902-1-peterx@redhat.com>
 <20200409164954.36902-3-peterx@redhat.com>
 <b559bedc-c6d7-922b-35fd-96ac4f068d9b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b559bedc-c6d7-922b-35fd-96ac4f068d9b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Phil,

On Thu, Apr 09, 2020 at 07:21:04PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On 4/9/20 6:49 PM, Peter Xu wrote:
> > We should only pass in gdb_get_reg16() with the GByteArray* object
> > itself, no need to shift.  Without this patch, gdb remote attach will
> > crash QEMU.
>=20
> You are correct.
>=20
> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")

Oh I forgot to paste the fix line.  However, is it b7b8756a9c
("target/i386: use gdb_get_reg helpers", 2020-03-17) instead?

>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

>=20
> Same problem in m68k_fpu_gdb_get_reg().
>=20
> TODO for 5.1, rename mem_buf -> array.

--=20
Peter Xu


