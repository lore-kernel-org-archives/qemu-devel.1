Received: from eggs.gnu.org ([2001:4830:134:3::10]:39783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gBzo1-00063v-E7
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gBzny-00024o-AZ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:08:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:34308 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gBznx-00023Y-Vh
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:08:54 -0400
References: <20181012115013.29555-1-fli@suse.com>
	<87zhvf3al5.fsf@dusky.pond.sub.org>
From: Fei Li <fli@suse.com>
Message-ID: <6170c07f-f722-dce4-02a3-42b62ef1d2e0@suse.com>
Date: Mon, 15 Oct 2018 18:08:47 +0800
MIME-Version: 1.0
In-Reply-To: <87zhvf3al5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2] ui/vnc.c: polish vnc_init_func
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org



On 10/15/2018 03:58 PM, Markus Armbruster wrote:
> Fei Li <fli@suse.com> writes:
>
>> Add a new Error parameter for vnc_display_init() to handle errors
>> in its caller: vnc_init_func(), just like vnc_display_open() does.
>> And let its callees propagate the Error, like init_keyboard_layout().
>>
>> Signed-off-by: Fei Li <fli@suse.com>
>> ---
>>   include/ui/console.h |  2 +-
>>   ui/curses.c          |  4 +++-
>>   ui/keymaps.c         | 11 ++++++-----
>>   ui/keymaps.h         |  2 +-
>>   ui/sdl.c             |  4 +++-
>>   ui/vnc.c             | 16 +++++++++++-----
>>   6 files changed, 25 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/ui/console.h b/include/ui/console.h
>> index fb969caf70..c17803c530 100644
>> --- a/include/ui/console.h
>> +++ b/include/ui/console.h
>> @@ -453,7 +453,7 @@ void qemu_display_early_init(DisplayOptions *opts);
>>   void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
>>   
>>   /* vnc.c */
>> -void vnc_display_init(const char *id);
>> +void vnc_display_init(const char *id, Error **errp);
>>   void vnc_display_open(const char *id, Error **errp);
>>   void vnc_display_add_client(const char *id, int csock, bool skipauth);
>>   int vnc_display_password(const char *id, const char *password);
>> diff --git a/ui/curses.c b/ui/curses.c
>> index 59d819fd4d..60c0962334 100644
>> --- a/ui/curses.c
>> +++ b/ui/curses.c
>> @@ -28,6 +28,7 @@
>>   #include <termios.h>
>>   #endif
>>   
>> +#include "qapi/error.h"
>>   #include "qemu-common.h"
>>   #include "ui/console.h"
>>   #include "ui/input.h"
>> @@ -421,7 +422,8 @@ static void curses_keyboard_setup(void)
>>           keyboard_layout = "en-us";
>>   #endif
>>       if(keyboard_layout) {
>> -        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout);
>> +        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
>> +                                          &error_fatal);
>>           if (!kbd_layout)
>>               exit(1);
> As Philippe pointed out, this exit() is now unreachable.
Right, should be deleted along with the below one.
>
>>       }
>> diff --git a/ui/keymaps.c b/ui/keymaps.c
>> index 43fe604724..52d432e856 100644
>> --- a/ui/keymaps.c
>> +++ b/ui/keymaps.c
>> @@ -27,6 +27,7 @@
>>   #include "sysemu/sysemu.h"
>>   #include "trace.h"
>>   #include "qemu/error-report.h"
>> +#include "qapi/error.h"
>>   
>>   struct keysym2code {
>>       uint32_t count;
>> @@ -81,7 +82,7 @@ static void add_keysym(char *line, int keysym, int keycode, kbd_layout_t *k)
>>   
>>   static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
>>                                              const char *language,
> `> -                                           kbd_layout_t *k)
>> +                                           kbd_layout_t *k, Error **errp)
>>   {
>>       FILE *f;
>>       char * filename;
>> @@ -94,7 +95,7 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
>>       f = filename ? fopen(filename, "r") : NULL;
>>       g_free(filename);
>>       if (!f) {
>> -        fprintf(stderr, "Could not read keymap file: '%s'\n", language);
>> +        error_setg(errp, "could not read keymap file: '%s'", language);
>>           return NULL;
>>       }
>>   
>> @@ -118,7 +119,7 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
>>               continue;
>>           }
>>           if (!strncmp(line, "include ", 8)) {
>> -            parse_keyboard_layout(table, line + 8, k);
>> +            parse_keyboard_layout(table, line + 8, k, errp);
> Lacks error checking.
>
> Before this patch, an error in an included file is reported to stderr,
> but is otherwise ignored:
>
>      $ cat kbd-layout
>      include bad
>      include worse
>      $ qemu-system-x86_64 -nodefaults -S -monitor stdio -display vnc=:0 -k kbd-layout
>      QEMU 3.0.50 monitor - type 'help' for more information
>      (qemu) Could not read keymap file: 'bad'
>      Could not read keymap file: 'worse'
>
> Afterwards, the error gets stored in errp.  If a second include fails,
> we attempt to store another one, which fails the error_setv()'s
> assertion:
>
>      $ qemu-system-x86_64 -nodefaults -S -display vnc=:0 -k kbd-layout
>      qemu-system-x86_64: /work/armbru/qemu/util/error.c:57: error_setv: Assertion `*errp == NULL' failed.
>      Aborted (core dumped)
>
> If it's the only failed include, parse_keyboard_layout() sets an error
> and returns succes, which is a no-no.  Callers using the return value to
> determine success are prone to leak the error, or run into
> error_setv()'s assertion.  Callers using the error are prone to leak the
> returned kbd_layout_t.
Oh, sorry! My fault.. I mistook the passed errp in 
parse_keyboard_layout() for &error_fatal,
in this case once the first fails, qemu will exit(1) directly and no 
second include will be read.
But the truth is we use a *local_err=NULL in vnc_init_func to propagate 
to the &error_abort.
> Let's address this in a separate patch before this one.
>
>                 if (!parse_keyboard_layout(table, line + 8, k, errp))
Ok.
I have another thought, that is pass the &error_fatal directly to 
vnc_display_init/open(),
and exit() in the callee parse_keyboard_layout. But the side effect is 
drooping the obvious
error message: "Failed to init/start VNC server: ".
>
>>           } else {
>>               int offset = 0;
>>               while (line[offset] != 0 &&
>> @@ -170,9 +171,9 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
>>   
>>   
>>   kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
>> -                                   const char *language)
>> +                                   const char *language, Error **errp)
>>   {
>> -    return parse_keyboard_layout(table, language, NULL);
>> +    return parse_keyboard_layout(table, language, NULL, errp);
>>   }
>>   
>>   
>> diff --git a/ui/keymaps.h b/ui/keymaps.h
>> index 0693588225..98213a4191 100644
>> --- a/ui/keymaps.h
>> +++ b/ui/keymaps.h
>> @@ -53,7 +53,7 @@ typedef struct {
>>   typedef struct kbd_layout_t kbd_layout_t;
>>   
>>   kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
>> -                                   const char *language);
>> +                                   const char *language, Error **errp);
>>   int keysym2scancode(kbd_layout_t *k, int keysym,
>>                       bool shift, bool altgr, bool ctrl);
>>   int keycode_is_keypad(kbd_layout_t *k, int keycode);
>> diff --git a/ui/sdl.c b/ui/sdl.c
>> index a5fd503c25..b33df70f4d 100644
>> --- a/ui/sdl.c
>> +++ b/ui/sdl.c
>> @@ -29,6 +29,7 @@
>>   #include <SDL.h>
>>   #include <SDL_syswm.h>
>>   
>> +#include "qapi/error.h"
>>   #include "qemu-common.h"
>>   #include "qemu/cutils.h"
>>   #include "ui/console.h"
>> @@ -917,7 +918,8 @@ static void sdl1_display_init(DisplayState *ds, DisplayOptions *o)
>>           keyboard_layout = "en-us";
>>   #endif
>>       if(keyboard_layout) {
>> -        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout);
>> +        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
>> +                                          &error_fatal);
>>           if (!kbd_layout)
>>               exit(1);
> Again, exit() is now unreachable.
Yes.
>>       }
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index cf221c83cc..03c70b16f6 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -3205,7 +3205,7 @@ static const DisplayChangeListenerOps dcl_ops = {
>>       .dpy_cursor_define    = vnc_dpy_cursor_define,
>>   };
>>   
>> -void vnc_display_init(const char *id)
>> +void vnc_display_init(const char *id, Error **errp)
>>   {
>>       VncDisplay *vd;
>>   
>> @@ -3222,13 +3222,14 @@ void vnc_display_init(const char *id)
>>   
>>       if (keyboard_layout) {
>>           trace_vnc_key_map_init(keyboard_layout);
>> -        vd->kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout);
>> +        vd->kbd_layout = init_keyboard_layout(name2keysym,
>> +                                              keyboard_layout, errp);
>>       } else {
>> -        vd->kbd_layout = init_keyboard_layout(name2keysym, "en-us");
>> +        vd->kbd_layout = init_keyboard_layout(name2keysym, "en-us", errp);
>>       }
>>   
>>       if (!vd->kbd_layout) {
>> -        exit(1);
>> +        return;
>>       }
>>   
>>       vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
>> @@ -4079,7 +4080,12 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
>>       char *id = (char *)qemu_opts_id(opts);
>>   
>>       assert(id);
>> -    vnc_display_init(id);
>> +    vnc_display_init(id, &local_err);
>> +    if (local_err) {
>> +        error_prepend(&local_err, "Failed to init VNC server: ");
>> +        error_propagate(errp, local_err);
>> +        return -1;
>> +    }
> Works, but is inconsistent with the handling of vnc_display_open()
> errors, visible below.  Let's match that, and convert both to
> error_propagate() in a followup patch.
>
>>       vnc_display_open(id, &local_err);
>>       if (local_err != NULL) {
>>           error_reportf_err(local_err, "Failed to start VNC server: ");
> I think the easiest way forward is for me to pick a touched up version
> of this patch into a v2 of my "Replace some unwise uses of
> error_report() & friends" series.  You'll receive a copy, of course.
>
> Thanks!
Deal, that will be consistent and much easier. :)

Have a nice day, thanks
Fei
