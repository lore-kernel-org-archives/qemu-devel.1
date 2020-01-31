Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E28DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED857206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEKf510h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED857206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZOo-0007WQ-3S
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1ixZNq-0005rc-FL
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1ixZNm-0004XQ-RW
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:43:04 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:44553)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1ixZNm-0004R1-Ib
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:43:02 -0500
Received: by mail-lf1-x144.google.com with SMTP id v201so5291470lfa.11
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2NJ7+pD0h4sZmQQe5JLGTr4tfFzdLBq4YsIMfqKARZ0=;
 b=pEKf510hdAdwEjC9NLANGgd8R3WIdNKXYo4amiUtSVr1KQ+spydENMDSUDc2zeTOCV
 YASX5qDPYEddwz9CKtp7xPSRRUx/PCOgiUVqp20SaKYHq1oUemTww2JYkTDhLmbS1AhX
 EO0mk0W9xxomvxKvMtqER7YwuIo6iPH7+dAi+L2AlvT7utkPjq3/hdstOuU0/CGPBQeD
 WPclqwdClFx4n74xQG78y4xqQQ7/0dVPOyBCL8dL3IEw6X/Ik5GpI89hc8FtrT2snLDD
 2bexNa5LDXvEGR2ep5qZuiDrW98Zpm2AzCpu1lGE9NOJvWqzv7c9jvNrPgn6BvnQXKR8
 g+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2NJ7+pD0h4sZmQQe5JLGTr4tfFzdLBq4YsIMfqKARZ0=;
 b=RMUsoT/SFdajs/ykgGpiUfXWDnwU/m5OYbt2RJc0Wy7PNkzZQlym+ZyaT/C8yD09L/
 5QZ9TL5kTO0e2956gkjSOmFlleyuWSyC4bw6xGiDVl4VLLmNYYJ8TujNXZgwpchFelfP
 YN6H11ZkxS4+eAvbbm9hPHKdpyqgesl7W7KzZeaq3iRJfX01pwZ5oNtgVy4HyF4CZ1u+
 GjSpl5kvH6pZQFYtXohqI4A6kZfS5rIaLxWJ/9my2eSN/8KZr8ldM8wr7lHOcRZ8xdMe
 CDbJPHqY3xpsY57EC0AXVT6KWXbmmrGoYWVfz4JxAOy3/J3GlOxEiNzFP62R+CjVlTr2
 w/VA==
X-Gm-Message-State: APjAAAXLKUjZzJyLY2S/wS4mOhZkwIP29Y/48w7wOlUBFyuD7E2NXALM
 cQpgVSzS6/H3UBXvSr+eyvM0QLKdDAIRlBCFtV8=
X-Google-Smtp-Source: APXvYqzjY4CbuBVdx3WjRsrE20bVeeezHYaq8KFa2e0YuGrWPv+Q7pX+tu2neU49Met9i/bAcav8xirJnRq2cUUQTH8=
X-Received: by 2002:a19:748:: with SMTP id 69mr6015140lfh.40.1580488980767;
 Fri, 31 Jan 2020 08:43:00 -0800 (PST)
MIME-Version: 1.0
References: <20200114140620.10385-1-coiby.xu@gmail.com>
 <20200114140620.10385-4-coiby.xu@gmail.com>
 <20200116140429.GJ163546@stefanha-x1.localdomain>
 <CAJAkqrVhvi-8MZ-mPjZ67yfjOaick5Gu_g3GxYAeYvH3Cp6QVw@mail.gmail.com>
 <20200117101158.GC7394@dhcp-200-226.str.redhat.com>
In-Reply-To: <20200117101158.GC7394@dhcp-200-226.str.redhat.com>
From: Coiby Xu <coiby.xu@gmail.com>
Date: Sat, 1 Feb 2020 00:42:24 +0800
Message-ID: <CAJAkqrUYp7uCH80Ui0S4GXnAaKasNGPAYM5oJEjC2LuJ02cfPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] a standone-alone tool to directly share disk image
 file via vhost-user protocol
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kevin,

> Yes, I think at least for the moment it should work fine this way.
> Eventually, I'd like to integrate it with --export (and associated QMP
> commands, which are still to be created), too. Maybe at that point we
> want to make the QOM object not user creatable any more.

Does it mean TYPE_USER_CREATABLE interface in QOM will become
deprecated in the future? I'm curious what are the reasons for making
QOM object no user creatable? Because we may still need to start
vhost-user block device backend through HMP or QMP instead of stating
it as a standalone-alone daemon.

> As for test cases, do you think it would be hard to just modify the
> tests to send an explicit 'quit' command to the daemon?

Accroding to https://patchew.org/QEMU/20191017130204.16131-1-kwolf@redhat.com/20191017130204.16131-10-kwolf@redhat.com/,

> +static bool exit_requested = false;
> +
> +void qemu_system_killed(int signal, pid_t pid)
> +{
> +    exit_requested = true;
> +}

if exit_requested = true, qemu-storage-daemon will exit the main loop
and then quit. So is calling qemu_system_killed by what you means "to
send an explicit 'quit' command to the daemon"?

On Fri, Jan 17, 2020 at 6:12 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 17.01.2020 um 09:12 hat Coiby Xu geschrieben:
> > Excellent! I will add an option (or object property) for
> > vhost-user-blk server oject which will tell the daemon process to exit
> > when the client disconnects, thus "make check-qtest" will not get held
> > by this daemon process. After that since Kevin's qemu-storage-daemon
> > support "-object" option
> > (https://patchew.org/QEMU/20191017130204.16131-1-kwolf@redhat.com/20191017130204.16131-3-kwolf@redhat.com/)
> > and vhost-user-server is a user-creatable QOM object, it will work out
> > of the box.
>
> Yes, I think at least for the moment it should work fine this way.
> Eventually, I'd like to integrate it with --export (and associated QMP
> commands, which are still to be created), too. Maybe at that point we
> want to make the QOM object not user creatable any more.
>
> Would it make sense to prefix the object type name with "x-" so we can
> later retire it from the external user interface without a deprecation
> period?
>
> As for test cases, do you think it would be hard to just modify the
> tests to send an explicit 'quit' command to the daemon?
>
> > I'm curious when will be formal version of qemu-storage-daemon
> > finished so I can take advantage of it? Or should I apply the RFC
> > PATCHes to my working branch directly and submit them together with
> > the patches on vhost-user-blk server feature when posting v3?
>
> It's the next thing I'm planning to work on after completing the
> coroutine-base QMP handlers (which I hope to get finished very soon).
>
> For the time being I would suggest that you put any patches that depend
> on qemu-storage-daemon (if you do need it) at the end of your series so
> that we could apply the first part even if the storage daemon isn't in
> yet.
>
> The latest version of my patches is at:
>
>     git://repo.or.cz/qemu/kevin.git storage-daemon
>
> But if you just need something for testing your code, I think it would
> even make sense if you kept your standalone tool around (even though
> we'll never merge it) and we'll deal with integration in the storage
> daemon once both parts are ready.
>
> Kevin
>


-- 
Best regards,
Coiby

