Received: from eggs.gnu.org ([2001:4830:134:3::10]:42394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOjPm-0006jH-LS
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOjPl-00018T-QQ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:44:18 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOjPl-00017h-Cm
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:44:17 -0400
Received: by mail-ot0-x244.google.com with SMTP id n3-v6so29106070ota.5
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 05:44:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601122815.lh46wcg6rfpcooyk@dritchie>
References: <20180531074601.10647-1-slp@redhat.com>
	<20180531074601.10647-4-slp@redhat.com>
	<CAJ+F1CKfpATgpFpHa85Esvv9k_T3FG_pY4rsz_C5a20CWfUgiQ@mail.gmail.com>
	<20180601115212.GU3458@redhat.com>
	<20180601120538.guwfrzojgabnpofb@dritchie>
	<c543d390-c034-ce60-5699-aa78186eb51d@redhat.com>
	<20180601122815.lh46wcg6rfpcooyk@dritchie>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Jun 2018 13:43:56 +0100
Message-ID: <CAFEAcA_eiyQ-eYV-9DZcfXC61L2V_tWhMtLG3gkiDyjoR22C_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/char/serial: Don't retry on
 serial_xmit if errno == EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 1 June 2018 at 13:28, Sergio Lopez <slp@redhat.com> wrote:
> On Fri, Jun 01, 2018 at 02:16:59PM +0200, Paolo Bonzini wrote:
>> On 01/06/2018 14:05, Sergio Lopez wrote:
>> >>> Instead of adding explicit handling of EPIPE, shouldn't the code be
>> >>> rewritten to treat -1 return && errno != EAGAIN as fatal?
>> >> Yes, exactly this code is already broken for every single errno
>> >> value, not simply EPIPE. It needs fixing to treat '-1' return code
>> >> correctly instead of retrying everything.
>> > Given that EAGAIN is already taken care of in
>> > chardev/char.c:qemu_chr_write_buffer, in which cases should we retry? Or
>> > should we just drop all the tsr_retry logic?
>>
>> It's not handled there, the call from qemu_chr_fe_write has write_all ==
>> false.
>
> You're right. So should we just retry only for -1 && errno == EAGAIN and
> just ignore the error otherwise?

I don't think we should make all of qemu_chr_fe_write()'s callers
have to handle EAGAIN. That function already has a way to tell
the caller that it didn't consume any data, which is to return 0.

(EAGAIN is a curse and we should strive to avoid it spreading its
poison into areas of the codebase that we can keep it out of.)

In general there are three cases I think qemu_chr_fe_write() callers
might care about:
 * data was consumed (return >0)
 * data wasn't consumed, try again later (return 0)
 * data wasn't consumed, and a later attempt won't work either
   (return -1)

NB that hw/char/serial.c is not the only serial device using
this pattern and probably needing adjustment (though I think it's
the only one with the complicated tsr_retry logic).

In the patch that started this thread the report is that we
use lots of CPU. Can you explain why that happens? I was expecting
that we would set up the qemu_chr_fe_add_watch() on the dead
chr FE and it would just never fire since the FE can never
accept further data...

thanks
-- PMM
