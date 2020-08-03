Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697CEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346C52068F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSiwQBKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346C52068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2WTI-00032m-4q
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2WSA-0001XN-5B
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:08:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29707
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2WS6-0003GW-Nn
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596445692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfec+xwTu7KrIb4hCgBIsmzKJRTtU4FfH+EPTDE2JOw=;
 b=RSiwQBKWcahtgtw+whV4UdLUESPXuLAotv2rRhOk+Ps6AUtFcv9/8nVL6caNn9U5hDsMUq
 J6rnRVaIGXbDY2lJBaSroXG4MsYjvYPA5M/shomdbp9QhT9dbk2r6I+72Efuf0yee0ETKV
 QDuxu787wNRp8Vt/gyKC+7MmjuSMWLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-inIUWHx9PVWZlTX2bHSGhA-1; Mon, 03 Aug 2020 05:08:11 -0400
X-MC-Unique: inIUWHx9PVWZlTX2bHSGhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8D89101C8A9;
 Mon,  3 Aug 2020 09:08:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BF581001B2C;
 Mon,  3 Aug 2020 09:08:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 217761132FD2; Mon,  3 Aug 2020 11:08:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Josh DuBois <josh@joshdubois.com>
Subject: Re: [PATCH] trace/simple: Allow enabling simple traces from command
 line
References: <20200723053359.256928-1-josh@joshdubois.com>
 <20200729130535.GI37763@stefanha-x1.localdomain>
 <e08651bd-f775-eb85-817c-44d27ff072dc@joshdubois.com>
Date: Mon, 03 Aug 2020 11:08:08 +0200
In-Reply-To: <e08651bd-f775-eb85-817c-44d27ff072dc@joshdubois.com> (Josh
 DuBois's message of "Thu, 30 Jul 2020 17:50:09 -0500")
Message-ID: <87h7tkm70n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:56:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Josh DuBois <duboisj@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Josh DuBois <josh@joshdubois.com> writes:

> Well, this is a bit embarrassing.=C3=82=C2=A0 The patch below simply
> re-introduced the bug which the Fixes: line was trying to fix in the
> first place.
>
> I.e, :
>
> - with my patch (just committed as
> 1b7157be3a8c4300fc8044d40f4b2e64a152a1b4) applied, a QEMU built with
> simple tracing will always produce a trace-<pid> file, regardless of
> whether traces were asked for.
>
> - after db25d56c014aa1a96319c663e0a60346a223b31e, which my patch was
> supposed to "fix," QEMU will not produce a trace file unless asked, I
> believe, via the monitor.=C3=82=C2=A0 Enabling traces is, near as I can t=
ell,
> simply impossible via the command-line in that case.
>
> - prior to db25d56c014aa1a96319c663e0a60346a223b31e, just like today,
> QEMU built with simple tracing will always produce a trace-<pid> file,
> regardless of whether the user asks for traces at runtime.

When you send a patch with a Fixes: tag, consider cc'ing people involved
in the commit being fixed.  I might have spotted the regression.

> I'm sorry for the mess.=C3=82=C2=A0 Having stepped in it already, I'm=C3=
=82=C2=A0 open to
> trying to track it down and fix it properly.=C3=82=C2=A0 I imagine perhap=
s few
> people truly care, since traces require a special build and are
> probably only being done by developers anyway.=C3=82=C2=A0 (And the origi=
nal
> message for db25d56c014aa1a96319c663e0a60346a223b31e said it had been
> "broken" for an unknown period of time).
>
> I'm brand new around here so I'll leave it to others whether it's
> better to revert and have traces impossible to enable from the cli (as
> I say, I think they're only possible from the monitor prior to my
> "fix" ) or to leave it be.
>
> If I resubmit, I'll try to test a little more next time.=C3=82=C2=A0 I ju=
st
> wanted my traces to work. ;)

I missed the CLI issue.  I just wanted my directories not littered with
trace files ;)

Stefan, what shall we do for 5.1?

If we keep littering, the annoyance will make me drop the trace backend
"simple" from my build tests.  I might even remember to put it back when
the fix arrives.


