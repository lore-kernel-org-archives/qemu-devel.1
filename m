Received: from eggs.gnu.org ([2001:4830:134:3::10]:50466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abenetopoulos@gmail.com>) id 1cqlW8-0001V8-CN
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abenetopoulos@gmail.com>) id 1cqlW5-0000Wv-4f
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:01:56 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <abenetopoulos@gmail.com>)
	id 1cqlW4-0000WS-Qx
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:01:53 -0400
Received: by mail-wm0-x22f.google.com with SMTP id n11so44992066wma.1
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 12:01:52 -0700 (PDT)
References: <74f647b8-a890-6635-278a-ce55fbbb5537@gmail.com>
	<7cfc0f3b-2cd3-32b7-0274-90b2bcfc2efa@redhat.com>
From: Achilles Benetopoulos <abenetopoulos@gmail.com>
Message-ID: <dfda7306-0003-7e3c-f596-9f04586b6b8c@gmail.com>
Date: Wed, 22 Mar 2017 21:01:48 +0200
MIME-Version: 1.0
In-Reply-To: <7cfc0f3b-2cd3-32b7-0274-90b2bcfc2efa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qemu/thread: Add support for error
 reporting in qemu_thread_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, quintela@redhat.com, armbru@redhat.com, crosthwaite.peter@gmail.com

Thank you for the detailed review. The indentation errors mentioned
were pure carelesness on my part, sorry about that.

On 3/22/17 2:20 PM, Eric Blake wrote:
>> @@ -342,13 +343,19 @@ static void pci_edu_realize(PCIDevice *pdev, Err=
or **errp) >>  { >>      EduState *edu =3D DO_UPCAST(EduState, pdev, pdev=
); >>      uint8_t *pci_conf =3D pdev->config; >> +    Error *local_err =3D=
 NULL; >> >>      timer_init_ms(&edu->dma_timer, QEMU_CLOCK_VIRTUAL, edu_=
dma_timer, edu); >> >>      qemu_mutex_init(&edu->thr_mutex); >>      qem=
u_cond_init(&edu->thr_cond); >>      qemu_thread_create(&edu->thread, "ed=
u", edu_fact_thread, >> -                       edu, QEMU_THREAD_JOINABLE=
); >> +                       edu, QEMU_THREAD_JOINABLE, &local_err); >> =
+ >> +    if (local_err) { >> +        error_propagate(errp, local_err); =
>> +        return; >> +    } > > Looking at code like this, I wonder if =
it would be easier to make > qemu_thread_create() return a value, rather =
than being void.  Then you > could write: > > if (qemu_thread_create(...,=
 errp) < 0) { >     return; > } > > instead of having to futz around with=
 local_err and error_propagate(). >

I don't know about it being easier, but it does seem like it would
make the code at the call site cleaner, when the function calling
qemu_thread_create was passed an error variable itself. However, in
all but four cases there is no preexisting error variable, so the code
would stay pretty much the same.

>> +++ b/hw/usb/ccid-card-emulated.c >> @@ -34,6 +34,7 @@ >> >>  #include=
 "qemu/thread.h" >>  #include "sysemu/char.h" >> +#include "qapi/error.h"=
 >>  #include "ccid.h" >> >>  #define DPRINTF(card, lvl, fmt, ...) \ >> @=
@ -485,6 +486,7 @@ static int emulated_initfn(CCIDCardState *base) >>    =
  EmulatedState *card =3D EMULATED_CCID_CARD(base); >>      VCardEmulErro=
r ret; >>      const EnumTable *ptable; >> +    Error *err =3D NULL, *loc=
al_err =3D NULL; > > Huh? Why do you need two local error objects? One is=
 generally sufficient. > >> >>      QSIMPLEQ_INIT(&card->event_list); >> =
     QSIMPLEQ_INIT(&card->guest_apdu_list); >> @@ -541,9 +543,17 @@ stati=
c int emulated_initfn(CCIDCardState *base) >>          return -1; >>     =
 } >>      qemu_thread_create(&card->event_thread_id, "ccid/event", event=
_thread, >> -                       card, QEMU_THREAD_JOINABLE); >> +    =
                   card, QEMU_THREAD_JOINABLE, &err); >> + >>      qemu_t=
hread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread, >>
-                       card, QEMU_THREAD_JOINABLE); >> +                =
       card, QEMU_THREAD_JOINABLE, &local_err); >> +    error_propagate(&=
err, local_err); >> + >> +    if (err) { >> +        error_report_err(err=
); >> +        return -1; >> +    } > > > If you used the return value, y=
ou could write: > > if (qemu_thread_create(..., &err) < 0 || >     qemu_t=
hread_create(..., &err) < 0) { >     error_report_err(err); >     return =
-1; > } > > without needing the second object.

Well, I wrote it this way because of a recommendation in the error.h
header, but yes, if we were to change the return type of
qemu_thread_create, then this would make sense.

>> +++ b/include/qemu/thread.h >> @@ -55,7 +55,7 @@ void qemu_event_destr=
oy(QemuEvent *ev); >> >>  void qemu_thread_create(QemuThread *thread, con=
st char *name, >>                          void *(*start_routine)(void *)=
, >> -                        void *arg, int mode); >> +                 =
       void *arg, int mode, Error **errp); > > Hmm, we still haven't made=
 it official recommended practice, but it's a > good idea to use 'git con=
fig diff.orderFile /path/to/file' in order to > hoist .h changes to the f=
ront of a diff (it makes diffs easier to review > when you see the interf=
ace change prior to the clients of the > interface).  I wish I had a bett=
er URL to point to on the topic, but > didn't want to spend time finding =
it in the mailing list archives at > this time.

Noted for future submissions.

>> +++ b/migration/ram.c >> @@ -357,6 +357,7 @@ void migrate_compress_thr=
eads_join(void) >>  void migrate_compress_threads_create(void) >>  { >>  =
    int i, thread_count; >> +    Error *err =3D NULL, *local_err =3D NULL=
; >> >>      if (!migrate_use_compression()) { >>          return; >> @@ =
-378,7 +379,16 @@ void migrate_compress_threads_create(void) >>          =
qemu_cond_init(&comp_param[i].cond); >>          qemu_thread_create(compr=
ess_threads + i, "compress", >>                             do_data_compr=
ess, comp_param + i, >> -                           QEMU_THREAD_JOINABLE)=
; >> +                           QEMU_THREAD_JOINABLE, &local_err); >> + =
>> +        if (local_err) { >> +            error_propagate(&err, local_=
err); >> +            local_err =3D NULL; >> +        } >> +    } >> + >>=
 +    if (err) { >> +        error_report_err(err); >>      } > > Another=
 place that looks weird with two error variables.

I was on the fence about this one. I wrote it this way thinking that
we would want to know the 'first' time the call to qemu_thread_create
failed, but proceed to try and create subsequent threads, which might
also fail. Seeing it now, it might be more reasonable to catch the
first error, report it then return?

>> +++ b/tests/iothread.c >> @@ -69,11 +69,18 @@ void iothread_join(IOThr=
ead *iothread) >>  IOThread *iothread_new(void) >>  { >>      IOThread *i=
othread =3D g_new0(IOThread, 1); >> +    Error *local_err =3D NULL; >> >>=
      qemu_mutex_init(&iothread->init_done_lock); >>      qemu_cond_init(=
&iothread->init_done_cond); >>      qemu_thread_create(&iothread->thread,=
 NULL, iothread_run, >> -                       iothread, QEMU_THREAD_JOI=
NABLE); >> +                       iothread, QEMU_THREAD_JOINABLE, &local=
_err); > > In a test, you can just assert success, by using: > > qemu_thr=
ead_create(..., &error_abort); > >> + >> +    if (local_err) { >> +      =
  error_report_err(local_err); >> +        /*what makes sense here as a r=
eturn value?*/ >> +        return NULL; > > Doing that will get rid of th=
is fishy comment. > >> +++ b/tests/rcutorture.c >> @@ -64,6 +64,7 @@ >>  =
#include "qemu/atomic.h" >>  #include "qemu/rcu.h" >>  #include "qemu/thr=
ead.h" >> +#include "qapi/error.h" >> >>  long long n_reads =3D 0LL; >>=20
long n_updates =3D 0L; >> @@ -85,12 +86,20 @@ static int n_threads; >> >>=
  static void create_thread(void *(*func)(void *)) >>  { >> +    Error *l=
ocal_err =3D NULL; >> + >>      if (n_threads >=3D NR_THREADS) { >>      =
    fprintf(stderr, "Thread limit of %d exceeded!\n", NR_THREADS); >>    =
      exit(-1); >>      } >>      qemu_thread_create(&threads[n_threads],=
 "test", func, &data[n_threads], >> -                       QEMU_THREAD_J=
OINABLE); >> +                       QEMU_THREAD_JOINABLE, &local_err); >=
> + >> +    if (local_err) { >> +        error_report_err(local_err); >> =
+        exit(1); > > Again, in a test, if you're just going to exit anyw=
ay, then it's easier > to pass &error_abort to the original call, than it=
 is to post-process > and report the error. >

OK, I will change the code in the tests.

Achilles
