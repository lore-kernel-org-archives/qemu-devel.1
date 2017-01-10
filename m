Received: from eggs.gnu.org ([2001:4830:134:3::10]:48974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQtOB-0005dJ-D6
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQtOA-0001Ds-G3
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:10:47 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:36723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQtOA-0001Cs-9r
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:10:46 -0500
Received: by mail-ua0-x22f.google.com with SMTP id 96so58980611uaq.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 02:10:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170110092602.GB2423@work-vm>
References: <20170109201340.16593-1-dgilbert@redhat.com>
	<20170109201340.16593-4-dgilbert@redhat.com>
	<CAFEAcA_5+WJtRSdOjTw+43Y6R_khLcQu5=yG7Hgu1v+KKbr8Rw@mail.gmail.com>
	<20170110092602.GB2423@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jan 2017 10:10:25 +0000
Message-ID: <CAFEAcA8rZa7qxFeog=wj2n4umCsjOCqM46m7MDR3PW=Rh8sBug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 3/3] vmstate registration: check return
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>

On 10 January 2017 at 09:26, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> On 9 January 2017 at 20:13, Dr. David Alan Gilbert (git)
>> <dgilbert@redhat.com> wrote:
>> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> >
>> > Check qdev's call to vmstate_register_with_alias_id; that gets
>> > most of the common uses; there's hundreds of calls via vmstate_register
>> > which could get fixed over time.
>>
>> Not quite that bad, I think -- I make it just over 50 calls.
>
> Well kind of; it seems to be a bit more complicated than that.
> I'd grep'd for vmstate_register and that gives me ~180 (including
> stuff in headers).

Yes, I was specifically looking at the vmstate_register and
vmstate_register_with_alias_id ones.

> Only 56 of those are vmstate_register() calls though, 117 are
> vmstate_register_ram calls which I'd not previously looked at,
> those call qemu_ram_set_idstr which looks like it suffers from
> the same problem though.

They call qemu_ram_set_idstr with the memory region name string,
though, which is "used for debugging; not visible to the user
or ABI", so we can just say it's a bug to use a silly name
and assert if it's too big, right?

thanks
-- PMM
