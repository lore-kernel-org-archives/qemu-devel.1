Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6403AC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2453E206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RK8OM0vE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2453E206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCe9U-0004E1-Ba
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 03:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kCe6H-0006vb-SX
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:19:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27297
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kCe6C-00066N-Dl
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598858367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdeAaVut09UT8eEDpG+qFLrjobpw+cimu2nuwbBoMas=;
 b=RK8OM0vEJxHScn//SV+rEvn6aTkrRQf0AwALolL70oMBav462E4ICGcEw4njERgEDfejeB
 mS0A0XAxK2E71O3slgdY6wkFnOpZXQxKdWzBKk6CVt6SgKkFzdjp21islBO80UtP2Sz/+i
 NrlodAL+W3Y36RBN/gGZcvtSBEXhTO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-wpWkGDYuPIyZJTtIY2QUfQ-1; Mon, 31 Aug 2020 03:19:25 -0400
X-MC-Unique: wpWkGDYuPIyZJTtIY2QUfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A5E518BE160;
 Mon, 31 Aug 2020 07:19:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96B3D1055813;
 Mon, 31 Aug 2020 07:19:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1BA8E113864A; Mon, 31 Aug 2020 09:19:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 (BROKEN) 0/6] migration: bring improved
 savevm/loadvm/delvm to QMP
References: <20200727150843.3419256-1-berrange@redhat.com>
 <877dtls8ux.fsf@dusky.pond.sub.org>
 <20200826182824.GA190807@redhat.com>
 <20200826183425.GA191632@redhat.com>
 <87zh6gmjq1.fsf@dusky.pond.sub.org>
 <20200827131301.GA5520@linux.fritz.box>
 <87sgc747hb.fsf@dusky.pond.sub.org>
 <20200828084627.GA10263@linux.fritz.box>
Date: Mon, 31 Aug 2020 09:19:22 +0200
In-Reply-To: <20200828084627.GA10263@linux.fritz.box> (Kevin Wolf's message of
 "Fri, 28 Aug 2020 10:46:27 +0200")
Message-ID: <87eenne0zp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Krempa <pkrempa@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 28.08.2020 um 08:20 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > Am 27.08.2020 um 13:06 hat Markus Armbruster geschrieben:
>> >> Daniel P. Berrang=C3=83=C6=92=C3=82=C2=A9 <berrange@redhat.com> write=
s:
>> >>=20
>> >> > On Wed, Aug 26, 2020 at 07:28:24PM +0100, Daniel P. Berrang=C3=83=
=C6=92=C3=82=C2=A9 wrote:
>> >> >> On Wed, Aug 26, 2020 at 05:52:06PM +0200, Markus Armbruster wrote:
>> >> >> > Open questions:
>> >> >> >=20
>> >> >> > * Do we want the QMP command to delete existing snapshots with
>> >> >> >   conflicting tag / ID, like HMP savevm does?  Or do we want it =
to fail
>> >> >> >   the transaction?
>> >> >>=20
>> >> >> The intent is for the QMP commands to operate exclusively on
>> >> >> 'tags', and never consider "ID".
>> >> >
>> >> > I forgot that even HMP ignores "ID" now and works exclusively in te=
rms
>> >> > of tags since:
>> >> >
>> >> >
>> >> >   commit 6ca080453ea403959ccde661030ca16264acc181
>> >> >   Author: Daniel Henrique Barboza <danielhb413@gmail.com>
>> >> >   Date:   Wed Nov 7 11:09:58 2018 -0200
>> >> >
>> >> >     block/snapshot.c: eliminate use of ID input in snapshot operati=
ons
>> >>=20
>> >> Almost a year after I sent the memo I quoted.  It's an incompatible
>> >> change, but nobody complained, and I'm glad we got this issue out of =
the
>> >> way.
>> >
>> > FWIW, I would have ignored any complaint about incompatible changes in
>> > HMP. It's not supposed to be a stable API, but UI.
>>=20
>> The iffy part is actually the loss of ability to access snapshots that
>> lack a name.  Complaints about that would have been valid, I think.
>> Fortunately, there have been none.
>
> 'loadvm ""' should do the trick for these.

As long as you have at most one.

>                                            The same way as you have to
> use with 'savevm' to create them in non-prehistoric versions of QEMU.
> We stopped creating snapshots with empty names by default in 0.14, so
> they are probably not very relevant any more. (Versioned machine types
> go back "only" to 1.0, so good luck loading a snapshot from an older
> version. And I wouldn't bet money either on a 1.0 snapshot still working
> with that machine type...)

No argument.


