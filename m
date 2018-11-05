Received: from eggs.gnu.org ([2001:4830:134:3::10]:53596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gJZDe-0001Rz-1S
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 02:22:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gJZDb-00029U-83
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 02:22:40 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gJZDY-0001Zz-EG
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 02:22:37 -0500
Received: by mail-oi1-x243.google.com with SMTP id v83-v6so6594462oia.5
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 23:22:25 -0800 (PST)
MIME-Version: 1.0
References: <0084f7223c080cdbdfc2c5a2d132f8d6c0eff866.1541083966.git.artem.k.pisarenko@gmail.com>
	<CAMxuvazxmYdvn_0aTH0ETt_Eeo7rxCLXvZ_oANfcKhgGW92+ng@mail.gmail.com>
In-Reply-To: <CAMxuvazxmYdvn_0aTH0ETt_Eeo7rxCLXvZ_oANfcKhgGW92+ng@mail.gmail.com>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Mon, 5 Nov 2018 13:22:12 +0600
Message-ID: <CANzW0mspj-xxYw5qXLvnQp-uNdLwJ+ztU2Ho-fR10_VXKQVkjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] chardev: fix mess in OPENED/CLOSED events
 when muxed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>

Sorry, I forgot to check unit tests. Although, it's very strange that this
specific test failed while things work functionally...

> I am a bit reluctant to take patches that don't actually "fix" things.
>
> Could you add some tests to demonstrate the problems?

Ok

>> @@ -257,6 +257,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>>  {
>>      Chardev *s;
>>      int fe_open;
>> +    static __thread bool mux_reentered;
>
> Not very elegant. Maybe mux_chr_set_handlers() could call a refactored
> internal chr_fe_set_handlers() with an extra arg "no_open_event" ?

Agree. It would make this hack more elegant. Although, it may become
irrelevant as soon as I'll find soultion for failed docker test...

>> @@ -272,21 +272,24 @@ static void char_mux_finalize(Object *obj)
>>      for (i = 0; i < d->mux_cnt; i++) {
>>          CharBackend *be = d->backends[i];
>>          if (be) {
>> +            if (be->chr && be->chr->be_open) {
>> +                qemu_chr_be_event(be->chr, CHR_EVENT_CLOSED);
>> +            }
>
> It looks like this could be a seperate patch, with a seperate test.

Why this should be separate ? Do you mean that overall "opened/closed"
pairing fix should be separated to "opened" fix+test and "closed" fix+test ?

Since in next version it cannot be single patch anymore, how should I
proceed with it ? Should I publish it as patch series with same subject
marked as V2 or start new patch series?
