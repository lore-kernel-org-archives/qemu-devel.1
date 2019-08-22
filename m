Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8630CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F7121848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBUFugIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F7121848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0wA5-0003rT-DI
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 19:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0w9G-0002qq-MW
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0w9D-0002y1-PN
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:05:41 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:42976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i0w9D-0002vh-IX
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:05:39 -0400
Received: by mail-oi1-x22a.google.com with SMTP id o6so5641885oic.9
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=UgUT1BNWL4KszXuwqIIqSIoFhiIUaNEeAXv21OOgWVU=;
 b=YBUFugIUGRuQik2vkY63KUVAhrk/NdoIFDcQVIZSlB3NTFASGxvwdgJ+a8M2XdPbY5
 o5mtWZt/9bTwj8croKntAu8ioR9Fn15MOeOTHy3zm1xfD4+vj0mii/JtTn7o2Zr3kOjz
 NBaDUodLQiK96lxkpZWVQKTELEZguweR3nQFTxkW+wDefkrHVF3/Df/PeNQybkvyU6zT
 khjWdag2Q6Xl7CAlLdTObCRKGF83pOGb1YcKz6JVd1IVtzJylGr0SN1n4IWD62WcKYzG
 utSSezhiy6450Ie8dJg4+DtCLJ07aPJQwyQ/Gqdlv8tH55dJZN8Fk+NzHV07Z0wDm/du
 JEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=UgUT1BNWL4KszXuwqIIqSIoFhiIUaNEeAXv21OOgWVU=;
 b=o9nlsxm8n1KxhYWFKEEzjn9GBSWQXptl3fNJNDSf6ss6f2SgoetZsrtZ8LRgBRyqnM
 L5l78IGVyO3ztcLGZK8sBBQSFpHHePvg8oHEyEjRaalldFHEknrb5kvM6SeFuGpOK9Hw
 rVTO9yY0YgdrJAcKhE9mpVcr2HYw1o1O0J4p4Np1HqlaUJyg6U0sxw/EP9Shh2EjXL1T
 wJ9Q3U7DeLLWvpQCxGf+PooQjy3IBsetenLfmRm31SnfPd2NhppPROHN7+0rLrw5V8L7
 0qi7uJHEK90VnhxoISP6ypKRW2nA6kEP+sSQTvlZ1yG+ZUFunvHb/4y/XRG43D8vPsZp
 E5TA==
X-Gm-Message-State: APjAAAW7Sd3r2PlLS/bPtTp30vZYrubcyhEd8O526qro8lmxM7WcCYLC
 B8ss5T5MsDLa/SX8JjrRMHwzokXotqo8bWQok23CjA==
X-Google-Smtp-Source: APXvYqyOleJij1xvlxIzHgmLTTAGzXl2QLvgA7XmY8f9l8LpKwEtylsu4NNEMuObiV5AttRJ26YA4acnzi4S1poi6+Y=
X-Received: by 2002:aca:4083:: with SMTP id n125mr1086093oia.106.1566515136894; 
 Thu, 22 Aug 2019 16:05:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 22 Aug 2019 16:05:35
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 22 Aug 2019 16:05:35
 -0700 (PDT)
In-Reply-To: <3be10e98-f2db-60e1-d846-40c16c70da7b@redhat.com>
References: <3be10e98-f2db-60e1-d846-40c16c70da7b@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 23 Aug 2019 01:05:35 +0200
Message-ID: <CAL1e-=jfrNAoAOXMf_84Ou47qQSq8ECxZ+VAiBDFG7cCmQPeFQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] contrib/gitdm: Add group map for RT-RK?
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.08.2019. 00.47, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Hi Aleksandar,
>
> I noticed this list of contributors:
>
> Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
> Lena Djokic <Lena.Djokic@rt-rk.com>
> Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
> Petar Jovanovic <petar.jovanovic@rt-rk.com>
> Stefan Brankovic <stefan.brankovic@rt-rk.com>
>
> I see most of the commits are MIPS related (a few are PPC).
>
> Should we add these emails to contrib/gitdm/group-map-wavecomp or should
> we rather add a new group-map file for this company?
>

The most appropriate and simplest approach would be to add a line in
qemu/contrib/gitdm/domain-map for company RT-RK.

Thanks, Aleksandar

> Thanks,
>
> Phil.
>
