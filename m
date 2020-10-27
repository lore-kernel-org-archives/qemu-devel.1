Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104ACC5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DB1206FA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEyAkk9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DB1206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPnv-0001ga-Kh
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXPkO-0006bH-J0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXPkJ-00078J-Ah
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603808081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGeB9oSplaxgvLPj0yAFvuTqgP3v8Vuunik/wjHt0aY=;
 b=PEyAkk9Wz8OpmUUPwQC9G9Qg4Sgz5M3i7IDM6TscfzXN+HRpIr6CoIGaPXQmig/nMcoJO5
 +VskKlta40VVEKDFB1ak+Ce+BAeKFLqcQTCYyNJapv5ixbQidlOQXsCJN3bZ9awZsoO8K9
 VMsgivznAbBAzg5vjZ1+eFTKshBKSX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-KlQpddmVNNS71t4ZGPxskQ-1; Tue, 27 Oct 2020 10:14:38 -0400
X-MC-Unique: KlQpddmVNNS71t4ZGPxskQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6FAB1019657
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 14:14:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68AA560C11;
 Tue, 27 Oct 2020 14:14:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E4354113865F; Tue, 27 Oct 2020 15:14:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 3/3] console: make QMP/HMP screendump run in coroutine
References: <20201010204106.1368710-1-marcandre.lureau@redhat.com>
 <20201010204106.1368710-4-marcandre.lureau@redhat.com>
 <87o8koysb8.fsf@dusky.pond.sub.org>
 <CAMxuvayGxrcCDV0wDVE1Pv=TeE26fief2eZfvva6AUsVT6wgGg@mail.gmail.com>
Date: Tue, 27 Oct 2020 15:14:13 +0100
In-Reply-To: <CAMxuvayGxrcCDV0wDVE1Pv=TeE26fief2eZfvva6AUsVT6wgGg@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 27 Oct 2020
 16:07:09 +0400")
Message-ID: <87a6w77o3u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Tue, Oct 27, 2020 at 12:41 PM Markus Armbruster <armbru@redhat.com> wr=
ote:
>>
>> marcandre.lureau@redhat.com writes:
>>
>> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >
>> > Thanks to the monitors coroutine support, the screendump handler can
>>
>> monitors'
>>
>> Suggest to add (merge commit b7092cda1b3) right before the comma.
>>
>> > trigger a graphic_hw_update(), yield and let the main loop run until
>> > update is done. Then the handler is resumed, and ppm_save() will write
>> > the screen image to disk in the coroutine context (thus non-blocking).
>> >
>> > Potentially, during non-blocking write, some new graphic update could
>> > happen, and thus the image may have some glitches. Whether that
>> > behaviour is acceptable is discutable. Allocating new memory may not b=
e
>>
>> s/discutable/debatable/
>>
>> > a good idea, as framebuffers can be quite large. Even then, QEMU may
>> > become less responsive as it requires paging in etc.
>>
>> Tradeoff.  I'm okay with "simple & efficient, but might glitch".  It
>> should be documented, though.  Followup patch is fine.
>>
>> > Related to:
>> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
>> Let's revisit the experiment I did for v1: "observe the main loop keeps
>> running while the screendump does its work".
>>
>> Message-ID: <87a74ueudt.fsf@dusky.pond.sub.org>
>> https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg01235.html
>>
>> I repeated the first experiment "does the main loop continue to run when
>> writing out the screendump blocks / would block?"  Same result: main
>> loop remains blocked.
>>
>> Back then, you replied
>>
>>     Right, the goal was rather originally to fix rhbz#1230527. We got
>>     coroutine IO by accident, and I was too optimistic about default
>>     behaviour change ;) I will update the patch.
>>
>> I'm unsure what exactly the update is.  Is it the change from
>>
>>     Fixes:
>>     https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527
>>
>> to
>>
>>     Related to:
>>     https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527
>>
>> ?
>
> Right, qmp_screendump() calls qemu_open_old(filename, O_WRONLY |
> O_CREAT | O_TRUNC | O_BINARY, 0666), so opened in blocking mode.
>
> So simply opening a FS file with O_NONBLOCK or calling
> qemu_try_set_nonblock(fd) with the resulting fd doesn't really help to
> check it's async (unless I am missing a trick to slow down disk IO
> somehow...?)
>
> It's annoying that it also does O_TRUNC: even if you pass a
> socket/pipe to add-fd, it will fail to ftruncate() (via the
> "/dev/fdset" path). Furthermore, access mode check seems kinda
> incomplete. Afaict, in monitor_fdset_dup_fd_add(), F_GETFL may return
> O_RDWR which is different than O_RDONLY or O_WRONLY, yet should be
> considered compatible for the caller I think..
>
> With some little hacks though, I could check passing a pipe does
> indeed make PPM save async, and the main loop is reentered. I don't
> know if it's enough to convince you it's not really the problem of
> this code change though. We get coroutine IO by accident here, I think
> we already said that.

I'm okay with this patch "only" getting us closer to the goal of having
screendump not block the main loop.  I just want the commit message to
be clear on how close.

>> The commit message says "ppm_save() will write the screen image to disk
>> in the coroutine context (thus non-blocking)."  Sure reads like a claim
>> the main loop is no longer blocked.  It is blocked, at least for me.
>> Please clarify.
>
> Let's clarify it by saying it's still blocking then, and tackle that
> in a future change.

Works for me!

>> Back then, I proposed a second experiment: "does the main loop continue
>> to run while we wait for graphic_hw_update_done()?"  I don't know the
>> result.  Do you?
>>
>> The commit message claims "the screendump handler can trigger a
>> graphic_hw_update(), yield and let the main loop run until update is
>> done."
>
> Isn't it clearly the case with the BH being triggered after main loop?

Yes, but have you *tested* the main loop keeps running?


