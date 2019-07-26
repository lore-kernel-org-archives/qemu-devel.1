Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E3AC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79F9229F9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fad+FAn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79F9229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwSu-00077X-Ry
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42925)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqwSg-0006dd-DF
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqwSc-0005qK-CK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:24:24 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqwSc-0005lY-4a
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:24:22 -0400
Received: by mail-oi1-x242.google.com with SMTP id q4so10632820oij.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p0Qrs+wBe+yU3V1LUom8LdVwwr4/B1c5vMUwSH66/qQ=;
 b=fad+FAn7waqUs7kCfB7g7hq6qY/OzrkmgtoK1I4y6TWPKWFsb1iLDGzvY4Rgxg9hXl
 LvZvAsf1wEH77aEX99hU69m0yEsFes4OZz3O0XMw/uCSHEAUjXgURzhuuCv6ixQ7g/Ze
 330RsObXqlvq68DRa//ztrYZhHujZfDUu0lxWgDchM+VzfMLkNVajkBUh2YSnmcjWZkm
 s2WyLAJMfz5sqnPIeUgnMMEay4SBX9ba53eKFxsWZx1+vJOokaLqO4JapqXfJMSMj7oI
 9y2jcHaMmuXyDNT1vrRDrog/AZCgp4+NDL7cKXgzBi/ivcuQI+zObzgAT+rTtDXJ2QsH
 7iVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p0Qrs+wBe+yU3V1LUom8LdVwwr4/B1c5vMUwSH66/qQ=;
 b=b1pk64otsfI1wqLaAUiRDVwNEFP4ofmaEJ/dIG/aMvRArdy/Elpa2IyajwGqNl3hqB
 6NLeC+GAzZsuWZUhLmtEwKzcE24sIpUkK4BtZaG7zoN7mFXtfUyjKWPHTE49nbJ0D3WB
 r5Xucft82QbTqurEU7CEqoxN/zVRq7OqDJU3ryP+Byvbwi4fY5cbmeXGUTXtVRD8c2h9
 n0CoMjvGE0CLAuzPnhFyRLH48rAnN6CcAGAsdrkvP0FTpFNJOfBs6fuW6MZqNpXEV7xr
 JVDQfh9Wl6M9djASYMd8aNyI7FebjF7TIx5NnAoYbB/j6jViEMmKF74xgHA3tbd0vB9D
 RC3g==
X-Gm-Message-State: APjAAAXvDaNx0B6HPGDQzNC1arjHzsJggQWCjCNYBmbKZRwa/oFKbYD9
 /Rpyz4Rcf6QCe50T+BWNFEH7vTeuJZD48b7IlVomqQKHK0U=
X-Google-Smtp-Source: APXvYqxUpKEP0Q0gXR2lBVCRZ2qrpoNNxlvvoEmSxXdYljJQf7W5SlGiBOUcO3UPSs/8YlrD+ay1i0PlUgGCZawrpqs=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr41721837oib.146.1564133060523; 
 Fri, 26 Jul 2019 02:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190725163710.11703-1-peter.maydell@linaro.org>
 <20190725163710.11703-3-peter.maydell@linaro.org>
 <20190725172712.GM2656@work-vm>
 <CAFEAcA-jGvNS4N4qobLekHYdV82qSUWVQOvTRQbrpcCRF0Yvwg@mail.gmail.com>
 <20190725180007.GN2656@work-vm>
In-Reply-To: <20190725180007.GN2656@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 10:24:09 +0100
Message-ID: <CAFEAcA8T25Fq5wj8a-K9KAyXdfj3+HtW=kTJ13zr+-iHFz4-GA@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH for-4.1? 2/2] vmstate.h: Type check
 VMSTATE_STRUCT_VARRAY macros
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 at 19:00, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > On Thu, 25 Jul 2019 at 18:27, Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> > >
> > > * Peter Maydell (peter.maydell@linaro.org) wrote:
> > > >  #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
> > > > +/* Check that t2 is an array of t1 of size n */
> > > >  #define type_check_array(t1,t2,n) ((t1(*)[n])0 - (t2*)0)
> > >
> > > I'd have to admit I don't understand why that does what you say;
> > > I'd expected something to index a t2 pointer with [n].
> >
> > Note that this is just a comment describing what the existing
> > macro does, as a way to distinguish its job from that of the
> > new macro I'm adding.
> >
> > What happens here is that t2 is a type like "foo [32]", ie
> > it is an array type already. t1 is the base 'foo' type; so the macro
> > is checking that t1[n] matches t2, where n is passed in to us
> > and must match the declared array size of the field (32 in
> > my example). (In C the size of the array is carried around as
> > part of its type, and must match on both sides of the expression;
> > so if you pass in the name of an array field that's the wrong size the
> > type check will fail, which is what we want.)
>
> Ah, OK that makes sense; what it really needs is that example to make
> me realise that t2 was already the array.

Would

/*
 * Check that type t2 is an array of type t1 of size n,
 * eg if t1 is 'foo' and n is 32 then t2 must be 'foo[32]'
 */

be clearer ?

thanks
-- PMM

