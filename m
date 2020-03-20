Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7331FC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F392C20722
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKXmTVUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F392C20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLU1-0007Hw-Tf
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1jFLTO-0006h9-Fo
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsuvorov@redhat.com>) id 1jFLTN-00046z-HJ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:30:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21137)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsuvorov@redhat.com>) id 1jFLTN-00046p-EB
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584725417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ykXk2E+lWMcuiOhPMluf7qmvakDaNrmcJ7I4Dqdlu7U=;
 b=aKXmTVUUQuIdGAqOqxBiD+rL1q0j1vqc78HzXtd94nKNy6G2K6CfMVu+C3Cipe+YiEsivE
 ZS1cv8Fs1je1y8QyvdUb1A9S4OVdmsWnE1ybFERPLcAIzvSAZ2+0V/aQF+e/uuQQD6yHhY
 fsEq6cjQYWGLu+TYMLRFqUz8YMK8EEM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-jcqad8cmO7S-Q-Q2RcIpRQ-1; Fri, 20 Mar 2020 13:30:15 -0400
X-MC-Unique: jcqad8cmO7S-Q-Q2RcIpRQ-1
Received: by mail-lj1-f200.google.com with SMTP id e14so1127384ljp.12
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GOcoe0J9w1J/GQg4S1bRWkNrGCbJYRtmcESUhZ2BySI=;
 b=T7Sdpq9umf5UeBrZHGnAz2qruHzb7dPWoRmdG/6bywJNC3SKas5TQKETOg9xxhw/4l
 9d/IUE1hkB8USgm9wguqKe8m9lYXsiHBvMOCvKjZaVPYjckxAk6XlNjCiMemq1wErOh2
 mV6b7hZu+KABwqCl9plY5QIcZ7Y5LpqvyOF8x4bt/CpRqLOaPaaUjX8xtXKMkK2H3k/7
 lgfOG2T96srzgkopMSb/UywH0wjalrS09h5nk242rnIfB/qpDpP9LWIuLp2BpbLFX6hb
 T/304ESoHy1oAFB8HCv+4r2mmtAqJPIHfkgBq6pBf39armmK536X2XRT0I0NwTebUGRW
 4CEA==
X-Gm-Message-State: ANhLgQ3OztfZfu8lHXmx2ifYY1PqSOl4dQSYEpSYQ/MdW1v2hgCYiVJI
 joVkHemB2N7bA+Mb/tdbE+z+v/IonNPDAz1rAL51f38ODFaUvLs5iTLD3FPMsCPbKP5Y3f0iKrg
 41LI3l7b6KaJG0UFrk/bZLyDcEBDNHQc=
X-Received: by 2002:a19:f008:: with SMTP id p8mr5886133lfc.217.1584725413554; 
 Fri, 20 Mar 2020 10:30:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvmbmm10XxnYGNsEhCnO3kX0zteatMw5OcwiFwCzctx21ktliZUKd51vUCSPoHJWyQQwcf9mbEv1rB/N83dYR0=
X-Received: by 2002:a19:f008:: with SMTP id p8mr5886120lfc.217.1584725413269; 
 Fri, 20 Mar 2020 10:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200318134849.237011-1-jusual@redhat.com>
 <20200320152022.GC138042@stefanha-x1.localdomain>
In-Reply-To: <20200320152022.GC138042@stefanha-x1.localdomain>
From: Julia Suvorova <jusual@redhat.com>
Date: Fri, 20 Mar 2020 18:30:02 +0100
Message-ID: <CAMDeoFX2D-c03PHcfiQ_ub4GMptjdUkUozZ53P4a-Vd_eNw86g@mail.gmail.com>
Subject: Re: [PATCH] hw/rdma/vmw/pvrdma_dev_ring: Replace strncpy with pstrcpy
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-trivial@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 4:20 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Wed, Mar 18, 2020 at 02:48:49PM +0100, Julia Suvorova wrote:
> > ring->name is defined as 'char name[MAX_RING_NAME_SZ]'. Replace untrunc=
ated
> > strncpy with QEMU function.
> > This case prevented QEMU from compiling with --enable-sanitizers.
> >
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >  hw/rdma/vmw/pvrdma_dev_ring.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Here is my equivalent patch
> <20200316160702.478964-3-stefanha@redhat.com> but feel free to merge
> this.

Oops, sorry, I guess I didn't search carefully enough for the solution.

> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


