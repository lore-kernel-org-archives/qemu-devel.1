Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226A8C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E191120836
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2zIa50Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E191120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3eg8-0007ay-4h
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j3efF-00077F-56
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j3efE-0008L0-89
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:34:13 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1j3efE-0008Iw-0M
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:34:12 -0500
Received: by mail-wr1-x442.google.com with SMTP id w12so19287844wrt.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 03:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OY0mYD4bUEBlNUTnY3tVhp8G3+SssOaM6SVKZaE7O1w=;
 b=t2zIa50Q5pNFD+Z9ItQw1f0C6xZM9GVXGitdld0iz8kr4UdU6ift4DQDf7cfmHvsV1
 BA/CLxXhCJblXjkzJjcWVWHHdYqZ4QP/0qIC/hbsUpCtrlcT3n9SAs2GywD+2dORVppO
 iLo15L0pOIxPtP6LCvcR/j/lrFS9qcGNwYN5Bb5UH9D9jhiFHbGQSY/UsDggLdqns4a4
 /jLCNvgcCuQY9b+dyGM8W2McVaSRUVGwKu3DHTmwT2HfGRrD0Sx51eMgops8hUfjhZp2
 3cpPHyTD/YMTbYgnRcLGJDpE0vIpmZGC/s1u5NhAjzNElSC/+tO6uMqFTyYUb/O3cobu
 mV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OY0mYD4bUEBlNUTnY3tVhp8G3+SssOaM6SVKZaE7O1w=;
 b=acBlrPda1gSu+Ok0AjN/JwbfFSwa/vmQ65hZ8k01ZhJ0mHJ8UJ5qsf18xEcfvexdiW
 hOK07mhNvYW/IidcbmNRuE4PIO+JdjcHZUexK6k68yahkV+N/0crVrOCSKyx41zzb0Rn
 i3KGArmH9yzrrpzZXX0xncWsmSj+drwgrB3Sg68CA5th1UQ9A7i6I0pK03vq4yaV+toL
 Ncma3qUYYutreJIFjijgP4hFodAKX1rKOKBGDF2bL0QUud3R/2zbiZbVzyOH/jvSbueg
 vrhY9XLS+8n9sASBD41sZzBv1cJ35AsVNei9+2VQJS5MG1nWSWbI1dxsacLO0Pcgvo3b
 c1bw==
X-Gm-Message-State: APjAAAUAtLu6SXGhjWXlE9rz1ZRl7hHL2SupOy9gKztEKABPajetYmaZ
 Fv2+Oh1Ukzib3b6qCA+f72gLvsfidkmVbIgSTfY=
X-Google-Smtp-Source: APXvYqx4PuwLFi7ywqgk7Jr4NVgCjG0KnvahFRLP2dE9whc5I2Sa4RMfEd9KceD+QMx8h84LWp/ZsVNuifooRR5tRQI=
X-Received: by 2002:a5d:550f:: with SMTP id b15mr21555783wrv.196.1581939250474; 
 Mon, 17 Feb 2020 03:34:10 -0800 (PST)
MIME-Version: 1.0
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
 <20200103074000.1006389-4-marcandre.lureau@redhat.com>
 <8736cqi07g.fsf@secure.laptop>
In-Reply-To: <8736cqi07g.fsf@secure.laptop>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 17 Feb 2020 12:33:58 +0100
Message-ID: <CAJ+F1CLgg6Yz=2V8_eCVtsJ1zPm=1-piz-Nw05KGXkSqWytLgA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] savevm: check RAM is pagesize aligned
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Juan

On Wed, Jan 8, 2020 at 2:08 PM Juan Quintela <quintela@redhat.com> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> n> Check the host pointer is correctly aligned, otherwise we may fail
> > during migration in ram_block_discard_range().
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> queued
>

Did it get lost? thanks


--=20
Marc-Andr=C3=A9 Lureau

