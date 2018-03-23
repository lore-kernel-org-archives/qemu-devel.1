Received: from eggs.gnu.org ([2001:4830:134:3::10]:50351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ezJUY-0003zX-J5
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ezJUX-0006Ld-Hl
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:00:10 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:37322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ezJUX-0006Kh-AQ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:00:09 -0400
Received: by mail-wr0-x22d.google.com with SMTP id l49so2346167wrl.4
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 03:00:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180323054932.GL32362@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-20-peterx@redhat.com>
	<CAJ+F1CLhE+rMrvWAAJVjsq7_hFn5sRiNiehvnnX6Z1Q9bA27iA@mail.gmail.com>
	<20180323054932.GL32362@xz-mi>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Mar 2018 11:00:06 +0100
Message-ID: <CAJ+F1CL_4SycvNhRjCamzQY9hCuATgXiA_9TL3HQbT8Jp-2AAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 19/23] qmp: isolate responses into io
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Fri, Mar 23, 2018 at 6:50 AM, Peter Xu <peterx@redhat.com> wrote:
> On Thu, Mar 22, 2018 at 01:00:19PM +0100, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Fri, Mar 9, 2018 at 10:00 AM, Peter Xu <peterx@redhat.com> wrote:
>> > For those monitors who have enabled IO thread, we'll offload the
>> > responding procedure into IO thread.  The main reason is that chardev =
is
>> > not thread safe, and we need to do all the read/write IOs in the same
>> > thread.  For use_io_thr=3Dtrue monitors, that thread is the IO thread.
>>
>> Actually, the chr write path is suppose to be somewhat thread safe
>> (chr_write_lock).
>>
>> Secondly, the function responsible to write monitor data has some
>> thread-safety, it's called monitor_flush_locked(), because you need
>> the mon->out_lock.
>>
>> I think that patch is making things more complicated than they need to
>> be. You should be able to call monitor_json_emitter/monitor_puts()
>> directly from any thread, it will queue the data, start writing, and
>> add a watch if necessary in the appropriate context.
>>
>> Am I missing something?
>
> Yes there are the locks either in monitor code and chardev code to
> protect write operations.  However I don't know enough to be sure of
> its safety.  Considering that, having the whole chardev operations
> separated into the other IOThread seems to be the only safe approach
> to me for now.

I have studied the code in more details, and I'll propose to revert
this patch early in 2.13. I'll send a 2.13 RFC qmp series shortly.



--=20
Marc-Andr=C3=A9 Lureau
