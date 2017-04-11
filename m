Received: from eggs.gnu.org ([2001:4830:134:3::10]:38252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxm4m-0004ZJ-VZ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 23:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxm4i-00028X-2c
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 23:02:41 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxm4h-00028J-V8
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 23:02:36 -0400
Received: by mail-qk0-x241.google.com with SMTP id p68so22514229qke.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 20:02:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
	<20170316092121.25672-3-marcandre.lureau@redhat.com>
	<1b1cce3c-5a0c-13a2-413a-e96cf08a6b7a@amsat.org>
	<1383568703.20466358.1491323484821.JavaMail.zimbra@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2f6c91d7-f9fb-70b8-281a-2974576bd139@amsat.org>
Date: Tue, 11 Apr 2017 00:02:32 -0300
MIME-Version: 1.0
In-Reply-To: <1383568703.20466358.1491323484821.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 02/21] mux: simplfy muxes_realize_done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

On 04/04/2017 01:31 PM, Marc-André Lureau wrote:
> Hi Philippe
>
> ----- Original Message -----
>> Hi Marc-André,
>>
>> On 03/16/2017 06:21 AM, Marc-André Lureau wrote:
>>> mux_chr_event() already send events to all backends, rename it,
>>> export it, and use it from muxes_realize_done. This should help abstract
>>> away mux implementation.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>  chardev/char-mux.h |  2 +-
>>>  chardev/char-mux.c | 11 ++++++++---
>>>  chardev/char.c     |  9 ++-------
>>>  3 files changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/chardev/char-mux.h b/chardev/char-mux.h
>>> index 9a2fffce91..3f41dfcfd2 100644
>>> --- a/chardev/char-mux.h
>>> +++ b/chardev/char-mux.h
>>> @@ -58,6 +58,6 @@ typedef struct MuxChardev {
>>>
>>>  void mux_chr_set_handlers(Chardev *chr, GMainContext *context);
>>>  void mux_set_focus(Chardev *chr, int focus);
>>> -void mux_chr_send_event(MuxChardev *d, int mux_nr, int event);
>>> +void mux_chr_send_all_event(Chardev *chr, int event);
>>>
>>>  #endif /* CHAR_MUX_H */
>>> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
>>> index 5547a36a0a..37d42c65c6 100644
>>> --- a/chardev/char-mux.c
>>> +++ b/chardev/char-mux.c
>>> @@ -114,7 +114,7 @@ static void mux_print_help(Chardev *chr)
>>>      }
>>>  }
>>>
>>> -void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
>>> +static void mux_chr_send_event(MuxChardev *d, int mux_nr, int event)
>>>  {
>>>      CharBackend *be = d->backends[mux_nr];
>>>
>>> @@ -222,9 +222,9 @@ static void mux_chr_read(void *opaque, const uint8_t
>>> *buf, int size)
>>>
>>>  bool muxes_realized;
>>>
>>> -static void mux_chr_event(void *opaque, int event)
>>> +void mux_chr_send_all_event(Chardev *chr, int event)
>>>  {
>>> -    MuxChardev *d = MUX_CHARDEV(opaque);
>>> +    MuxChardev *d = MUX_CHARDEV(chr);
>>>      int i;
>>>
>>>      if (!muxes_realized) {
>>> @@ -237,6 +237,11 @@ static void mux_chr_event(void *opaque, int event)
>>>      }
>>>  }
>>>
>>> +static void mux_chr_event(void *opaque, int event)
>>
>> Why use an opaque pointer and not Chardev *chr here? Not a big deal but
>> it eases debugging sessions.
>> Anyway it'll be correctly displayed single-stepping in :)
>
> It's the signature of IOEventHandler, avoiding casting.

Sorry I missed qemu_chr_fe_set_handlers() use my bad!

>>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>>> +{
>>> +    mux_chr_send_all_event(CHARDEV(opaque), event);
>>> +}
>>> +
>>>  static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
>>>  {
>>>      MuxChardev *d = MUX_CHARDEV(s);
>>> diff --git a/chardev/char.c b/chardev/char.c
>>> index aad639b620..674c097fbe 100644
>>> --- a/chardev/char.c
>>> +++ b/chardev/char.c
>>> @@ -451,22 +451,17 @@ static void muxes_realize_done(Notifier *notifier,
>>> void *unused)
>>>  {
>>>      Chardev *chr;
>>>
>>> +    muxes_realized = true;
>>>      QTAILQ_FOREACH(chr, &chardevs, next) {
>>>          if (CHARDEV_IS_MUX(chr)) {
>>> -            MuxChardev *d = MUX_CHARDEV(chr);
>>> -            int i;
>>> -
>>>              /* send OPENED to all already-attached FEs */
>>> -            for (i = 0; i < d->mux_cnt; i++) {
>>> -                mux_chr_send_event(d, i, CHR_EVENT_OPENED);
>>> -            }
>>> +            mux_chr_send_all_event(CHARDEV(chr), CHR_EVENT_OPENED);
>>>              /* mark mux as OPENED so any new FEs will immediately receive
>>>               * OPENED event
>>>               */
>>>              qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>>>          }
>>>      }
>>> -    muxes_realized = true;
>>>  }
>>>
>>>  static Notifier muxes_realize_notify = {
>>>
>>
>
