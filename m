Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D698C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1352A2072A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+WUqknF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1352A2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJB8i-0006mw-5s
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 03:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJB7R-0005Fl-2V
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJB7P-0003KE-9Z
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:15:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39689
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJB7P-0003Jr-5Y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585638926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gNpP9DXLxJv8ckOM9cL3t4TDUQkcBA9Jmrv0WI0E3DY=;
 b=R+WUqknFd6pdEsm5t9ONS2X4ikTOziSaKbIfpCzn7vZNJMQ+HzBtE3qaECQ+2UTJhesM48
 vE7L571+ffU9iLCaQE4waTAgM7QDSI4qpLFQDB/IFbMUdzzUbwKB26mvxrUFnqRyxHDm4C
 evu6e4NMEm2SDdwGi443CyQuIfUbaZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-2OtuOL_9OHmrN69lymw6ng-1; Tue, 31 Mar 2020 03:15:20 -0400
X-MC-Unique: 2OtuOL_9OHmrN69lymw6ng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 957331005509;
 Tue, 31 Mar 2020 07:15:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 488DC5C1C5;
 Tue, 31 Mar 2020 07:15:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE6AB11385E2; Tue, 31 Mar 2020 09:15:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: deprecation of in-tree builds
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
Date: Tue, 31 Mar 2020 09:15:17 +0200
In-Reply-To: <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 (Peter Maydell's message of "Mon, 30 Mar 2020 14:31:52 +0100")
Message-ID: <875zel5722.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 30 Mar 2020 at 14:26, Markus Armbruster <armbru@redhat.com> wrote=
:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > AIUI from Paolo, the intention is to deprecate and eventually
>> > stop supporting "in-tree" builds, so that the only option is
>> > building in a separate build directory. I thought we should
>> > probably mention that in the 5.0 changelog, so I wrote up some
>> > text:
>> >
>> > https://wiki.qemu.org/ChangeLog/5.0#Build_Information
>>
>> Overdue.  Thanks for doing this!
>>
>> > Suggestions for changes/comments etc welcome.
>>
>> Looks fine to me.
>
> Consensus in the thread seemed to lean towards having
> the 'configure/make' runes auto-create a build directory;
> if we want to do that we should probably not say anything in
> the release notes, because we'll cause people to change
> unnecessarily. Or at least have them say "We recommend
> out-of-tree builds. In future we might make the commands
> that currently do an in-tree build automatically create
> and use a build directory for you." rather than a blanket
> "we're going to drop this and you should change what you
> do now".
>
> Thoughts?

I'm wary of complicating the build system to save developers a minor
change of habits.

We will have to ask developers to change habits anyway when we switch to
Meson.  I agree with Daniel's recommendation to delay changes requiring
habit-changes until then.  However, telling people to stay clear of the
unloved and brittle in-tree build is simply good advice we should not
withhold.  When you can't make the obvious way to do things the way that
has the best chance of actually working, at least have the courtesy to
point people to the way that has the best chance of actually working.

If some developers want to avoid a change of habits badly enough, surely
one or more of them will volunteer to contribute / maintain the
complications needed for that with Meson.

Whatever it takes to get rid of in-tree-only build breakages :)


