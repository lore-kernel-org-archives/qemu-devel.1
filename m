Received: from eggs.gnu.org ([2001:4830:134:3::10]:58384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJcDj-0001y3-K4
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJcDi-0006VE-JI
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:34:59 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJcDh-0005yf-L9
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 05:34:58 -0500
Received: by mail-oi1-x244.google.com with SMTP id x63-v6so3272306oix.9
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 02:34:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f5c4263e-658a-8742-6536-da0a74f353f7@redhat.com>
References: <20181005143802.18412-1-peter.maydell@linaro.org>
	<CAFEAcA8-FvVG7XBLrd7NQfRcKrvo6GtPEjfqJzkjd68iP9=TeQ@mail.gmail.com>
	<20181005161739.GC4606@localhost.localdomain>
	<CAFEAcA-SWRHwnwsa+QiHXfdBRB6u2u0paV9HsEqfjR6nZvAHSg@mail.gmail.com>
	<20181005180901.GA32677@localhost.localdomain>
	<CAFEAcA80cys-98QwJgAk_2LXfAeMHgCUS2L3Z+NgY4ZsCFhSPw@mail.gmail.com>
	<CAFEAcA8gYwFZynMyiEHf+VPbaBerA9JTUPAHsipEvOqkBjHxMQ@mail.gmail.com>
	<20181008164026.GD4604@localhost.localdomain>
	<e2efa1f8-7ada-d5c4-9719-491d9b5f477b@redhat.com>
	<CAFEAcA8eB8zZnS1G1FHWo=ix4uoO_-NCh3qfkkNLtyMDpTOPsg@mail.gmail.com>
	<f5c4263e-658a-8742-6536-da0a74f353f7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 10:34:35 +0000
Message-ID: <CAFEAcA-D9HWCQg27aRjuh9yoGeJRwDigowrkitm+EU1ZvYcoZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests: Disable test-bdrv-drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 4 November 2018 at 22:03, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 02/11/2018 14:33, Peter Maydell wrote:
>> On 9 October 2018 at 12:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> Yup, we have to stop using pthread_key_create.  Luckily, these days
>>> there is always qemu_thread_start that wraps the thread, so we can call
>>> qemu_thread_atexit_run from there, and change exit_key to a thread-local
>>> NotifierList.
>>
>> We would also need to catch exits via qemu_thread_exit(), right?
>> We probably also need to handle the main thread specially, via
>> atexit(). This seems to be pretty much what we already do in
>> util/qemu-thread-win32.c...
>
> There's only one caller of qemu_thread_exit and it can be removed easily.
>
> However, an improvement on the idea is to use pthread_cleanup_push/pop
> in qemu_thread_start.  This does handle qemu_thread_exit.

Interesting. (I have a patch I put together on Friday and haven't
tested yet that just uses the win32-style "explicitly run notifiers
in exit and at end of thread_start".)

thanks
-- PMM
