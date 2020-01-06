Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBFEC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA3C2070E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQPm8fm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA3C2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioWhx-000812-SN
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1ioWh5-0007Yq-9S
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1ioWh4-0003Qb-BF
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:01:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ioWh4-0003Py-7R
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578333693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9ncgIaMCzm6zngSu3o2Cby0g4134ReKpIiu9piBDpQ=;
 b=KQPm8fm8gJs3ElQm2vTRViL0EzUriPyQi/goWgZY08OywcTEhY29OjLkIwUD5v7PO5Zxyl
 L4qBFqV174Srxaeu3btihPPTOxQozxSF6/pBcW4+xzfWWeUnH46mwp98xig8TIjosUuQbx
 xwQB+khqJCQDutRptT21In4wC4cUUE4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-ZSwIK7UYOPOy_9jMsvFPOg-1; Mon, 06 Jan 2020 13:01:32 -0500
Received: by mail-qt1-f199.google.com with SMTP id m8so34744149qta.20
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 10:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FO74gwITbjqfC+ehuIaJ56yBiHHC9icHowe6YRnKTuU=;
 b=VYWdt/+vlhqLXcA64i/VhAzX7jnLdO8Fg84TMMDs7INs3RraLppaV+/zMHDwVnMAiO
 2U0oSGt0WRefGbvQhPyPxRl+a1YmXlteMkK1629GDfImn9VImYdfDluKzvMwF2vo9oRx
 HPD5PdX/ifEbkFr7WfUsfwjQvZzpZEIb7eQqSTvH/x0rrCvEZa1n++zR4GHAyM0zSng8
 fZgn9v8A7ejvp63ud5RXDBJucpO5BeBEsKk/47OSwHJHqLvE/3ULckJVQ7VBBEStEuKc
 SlJVU0QODYd4wIMXpXv7kdtkNGOtSGG+XUlpIGLmVRZvQ4bOFYY4a4uNeJBmVL55GAlf
 ixAQ==
X-Gm-Message-State: APjAAAUHClMrSRYAEXsrI3HycBTgCS1e2LE19XBehRgs3/l70yXSiiv7
 8mcw8/1qwdk2W51KmWpt6JPharljn9z/74iRbwD6pHXZyoQWDFyvWkxT3ymlT4eQFCdPgrlo3eD
 XI4yORHVRb2dCqeQ=
X-Received: by 2002:a37:a795:: with SMTP id q143mr34679179qke.86.1578333691962; 
 Mon, 06 Jan 2020 10:01:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqy78KUqg+kBiOkQdy91Syb2mA7XDtCw85SQ31x36ViU9FvZxuKKViN4/KGuzP3HnAAtZgh3DQ==
X-Received: by 2002:a37:a795:: with SMTP id q143mr34679158qke.86.1578333691744; 
 Mon, 06 Jan 2020 10:01:31 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id t73sm21211699qke.71.2020.01.06.10.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:01:31 -0800 (PST)
Date: Mon, 6 Jan 2020 13:01:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/iothread: Always connect iothread GSource to a
 GMainContext
Message-ID: <20200106180129.GD219677@xz-x1>
References: <20200106144552.7205-1-peter.maydell@linaro.org>
 <20200106172808.GB219677@xz-x1>
 <CAFEAcA89VHAyQKCeV6exxzDjLCEGUyg59um7w-VZ2K6s4ZV31g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA89VHAyQKCeV6exxzDjLCEGUyg59um7w-VZ2K6s4ZV31g@mail.gmail.com>
X-MC-Unique: ZSwIK7UYOPOy_9jMsvFPOg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 06, 2020 at 05:40:15PM +0000, Peter Maydell wrote:

[...]

> So we're OK to not do this because tests/iothread.c's
> main loop doesn't call g_main_loop_run(), and it doesn't
> provide an iothread_get_g_main_context() ?
>=20
> I'm kind of inclined towards being lazy and sticking with
> what this patch has, because:
>  * it matches the real iothread.c, which reduces the possiblity
>    of future surprise bugs due to things not matching up
>  * it's already been reviewed
>  * it saves me having to do a respin and retest
>=20
> But if people would prefer these bits deleted I'll stop
> being lazy :-)

Please feel free to be lazy and fix the test sooner (and that's why I
offered my r-b :).

Thanks,

--=20
Peter Xu


