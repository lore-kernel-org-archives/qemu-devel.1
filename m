Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B0DC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52282168B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrLtNh4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52282168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1wC5-0001cP-0f
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 12:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1wAY-00085z-RV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1wAX-0002Gz-JL
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:51:26 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:38158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1wAX-0002GY-DP
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:51:25 -0500
Received: by mail-oi1-x235.google.com with SMTP id l9so2863762oii.5
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 09:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=K1GGyr2TE+QgS009TcytuT7HNi9xt6oVlWbsfRLCleE=;
 b=DrLtNh4qshNjh1JqWC1xINDHvKNs//yTphLFYRWk/Hgopz+Tig8qfEFNmHS5lei++e
 cD+tKCJZOmXlR6OdRtwwtzRehMn1LN8Sf0uIop3XUNiaFRo42M2s3UZe3UPk/WRhag2D
 CVEbcRrlb12+Iud1fh3A41OzKo22Nxe+oVCI7VXBaIw+A21ax8BVUF50qcTFxEfD+nkZ
 t6lKsh5I6ebgXfyeapfhTr8UEKAeztHqLzNE2UTRSYVhXNwiLorSzVMU21vyfG3nXhlS
 N3Ijc9WqckGfqpEmOeGE8OlVvB5nWagpGl23imnxaM7vapZOSPNmvw+IcW0zUeknJ8MV
 zgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=K1GGyr2TE+QgS009TcytuT7HNi9xt6oVlWbsfRLCleE=;
 b=pxkRsanigRw1JGIiwujh0ajAS40s6/2zQQSYJKfUWP3Guw+tH0nYNb6YStd0XEDiFH
 ILBJSP6Ymh1kx6dRlZoCX+z0T8kizq8HMCA5vLBgoch7QFRNucz5e2c2fDWDSwn/6q+d
 eG4++WIQYnhIbrBjyOaeRyxUbLcz0DnU20uRRI+mk+UGqn4hk7EuqfUsySMBhsYqRjMe
 by3JRFsOhRAXBkfanrVUpcYuZ6FJmQ5RfpPdoMNgb7oi+aTR+YZ2hf0vIFsS2dGx+sQT
 QBhyZQhcwwnxz0+/i/A5xqBezaYo2miY9tQQaL+fTN7D0pxv5O8K/GKaHPxV+DnStldW
 chmg==
X-Gm-Message-State: APjAAAUueI36XQ9SUnslsTKqiFlYvG3qqU+arOxFSjT/ikIW9bTMTU2v
 jwQbPAbRIkpb2sihKrJXl90GOhgYu1IXqb5lu0bV7g==
X-Google-Smtp-Source: APXvYqxR0KUqtm6a9EHd24uxdalE7G8fsS9DrhyAsQJJOnfKFXwGrsEDwBMnF4vXewZedyb1XXzXn3d27FjrAxt3AZU=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr181683oid.98.1581529884675;
 Wed, 12 Feb 2020 09:51:24 -0800 (PST)
MIME-Version: 1.0
References: <1908428819.7192207.1581512184275.JavaMail.zimbra@redhat.com>
 <1608747495.7195569.1581513386780.JavaMail.zimbra@redhat.com>
 <CAFEAcA-F-F1C4si7OXNkMnzE+9DHXtNnvCYv1eTx-nEpb4_OZw@mail.gmail.com>
 <20200212142832.GC434563@redhat.com>
 <CAFEAcA_VsdWJELxDuMJW9iaRsB-At_Dyf3Z6paOHWEp+VEhSgw@mail.gmail.com>
 <625cd959-6031-0a27-f25b-e2be6dc7ec3a@redhat.com>
In-Reply-To: <625cd959-6031-0a27-f25b-e2be6dc7ec3a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Feb 2020 17:51:13 +0000
Message-ID: <CAFEAcA97NfPA+yZThojcaYWqdS8kvFtDNYJRn96iRuRMaU-uMg@mail.gmail.com>
Subject: Re: [PATCH] docs: Fix virtiofsd.1 location
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Feb 2020 at 16:51, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> We stopped testing in-tree builds 2 months ago:
>
> commit bc4486fb233573e77b6e9ad6d6379afb5e37ad8c
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Wed Dec 11 15:33:49 2019 +0100
>
>      ci: build out-of-tree
>
>      Most developers are using out-of-tree builds and it was discussed
> in the past
>      to only allow those.  To prepare for the transition, use
> out-of-tree builds
>      in all continuous integration jobs.

I'd missed that. Paolo, do you have a plan for following
through and actively forbidding in-tree-builds, if that's
the route we're taking ?

thanks
-- PMM

