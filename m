Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716DFC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA8D20863
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kuh3QZAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA8D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU9LH-0006uu-M5
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:30:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU9K0-00061y-M2
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU9Jz-00055f-On
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:29:16 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:47090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hU9Jz-00054w-JU
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:29:15 -0400
Received: by mail-ot1-x343.google.com with SMTP id j49so8471107otc.13
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 05:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=3kRYKD9opdbo5kmKXTBP7Gc0tSW5Tzsf57LsKn0CRzQ=;
	b=kuh3QZAgFMC3qP0xEd3yro822uRQUHmWU4RSbA79bDr14W8xehbz5Xgcta32kW6J1+
	qxdAAn1fw/VVo/gGGPocDUOaFOipVlXPSGPP3f4R5KM1ODZnrwK0gio2Rn5iUqDWCikX
	PUI6NkWwohoFh84uj5ZCPrpUNadBNGhrWVeKfTicczWrJm+euhNGtwko5XGi543ygiKM
	x1uBUZDsiZRS4wddGu1MtKqeKalM/C7tQgnJIbLleRteEE57x1pmzzLzmFpjYHoqgD0n
	6MzpnEi6gv1gRk9gz3aOPI82h52wAy6+iN6YaUERJGBFMcTG9WEcJoamuqhOHS90a9u5
	sXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=3kRYKD9opdbo5kmKXTBP7Gc0tSW5Tzsf57LsKn0CRzQ=;
	b=Isk/sSuH8lj3zRi5EZZgMLOJ5uQCLgasgvRRh1/JyYLl/8HujOw5dMDMOgIWR8qCU4
	TtR9f05kc2H1Qgr1z9tWq+0mBqWEfNmMSbK4NbgQKzjyAC59rfvYsNsPeM3PgZgh+nu4
	grh1xTkynltfqM+vrakWB+XeXZ00vxebKYbW72HbuqwpvPbhFm4nKm4ZEgmFRnv0Bm3s
	7UjJTFohS2zoHHkICbi3+fqJUM6sDB5Sk5ViU2bWC84dukyS1jyaMmPknm7C2pvXtQOE
	ZUk1EN3feSA3/4jVhi5iBvDnsu+XlsymM7zHwmEsHqut5TjlPJx9P+FTlbN5yu2p0du5
	ZBuA==
X-Gm-Message-State: APjAAAVlODfnlY00PApkuijSpFGa7aJI3FjHt8pRMhc0CmEMUusGlyrY
	ioHrfwN6cNeFdexHPtSMUjos64Rirc7EsObT7SQGxw==
X-Google-Smtp-Source: APXvYqxHexywmjQxm4U0dCVfUSFKBenWYo2z0GXHUiycaP8qq9hozlDEGHjNKNkfC5khIdrwyWVg5VI9CqNP9IJKurM=
X-Received: by 2002:a05:6830:209a:: with SMTP id
	y26mr31961050otq.232.1558700954729; 
	Fri, 24 May 2019 05:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-7-armbru@redhat.com>
	<CAFEAcA_b-rPUuDF_A2Q112-aJEqfSA17kJjD3W0aKaOOP7-hjA@mail.gmail.com>
	<87ftp49gz9.fsf@dusky.pond.sub.org>
In-Reply-To: <87ftp49gz9.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 May 2019 13:29:03 +0100
Message-ID: <CAFEAcA8QUyORuMfCBoWhtYArreMxK5OUzO_76imU--ER5KJjJw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [RFC v4 6/7] tests: Don't limit check-headers to
 include/
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 May 2019 at 13:25, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Thu, 23 May 2019 at 09:15, Markus Armbruster <armbru@redhat.com> wrote:
> >>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >
> >>  432 files changed, 1035 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
> >> index 685602b076..352da0c745 100644
> >> --- a/accel/tcg/atomic_template.h
> >> +++ b/accel/tcg/atomic_template.h
> >> @@ -18,6 +18,9 @@
> >>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> >>   */
> >>
> >> +/* NOTE: May only be included into target-dependent code */
> >> +/* FIXME Does not pass make check-headers, yet! */
> >> +
> >
> > I'm not sure I see much point in touching several hundred
> > header files just to add a FIXME note. We can fix them,
> > or we can just leave things as they are...
>
> Adding FIXMEs without an intent to actually fix them would be stupid.
>
> The FIXMEs direct "make check-headers" to skip the headers so marked.

Ah, right. It wasn't clear that this is a directive to the script:
it looks like the usual free-text aimed-at-human-readers kind of
FIXME/TODO comment.

thanks
-- PMM

