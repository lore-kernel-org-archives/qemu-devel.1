Received: from eggs.gnu.org ([2001:4830:134:3::10]:41128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dDwok-0005Ne-3u
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dDwof-00042X-59
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:44:58 -0400
Received: from mail-eopbgr20090.outbound.protection.outlook.com
	([40.107.2.90]:44145
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dDwoe-000408-DL
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:44:53 -0400
References: <1495198042-124203-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495198042-124203-4-git-send-email-anton.nefedov@virtuozzo.com>
	<CAJ+F1CKHOsDjf8_+vkAT8A5Onz+pbP8xwsLT2rOA4wg2UqX5EA@mail.gmail.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <c4f4bf39-871c-1f7d-ebf7-165fc795ddac@virtuozzo.com>
Date: Thu, 25 May 2017 20:44:43 +0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKHOsDjf8_+vkAT8A5Onz+pbP8xwsLT2rOA4wg2UqX5EA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/9] char: chardevice hotswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com

> Hi
>=20

Hi Marc-Andr=C3=A9, thanks for reviewing, pls see answers below

> On Fri, May 19, 2017 at 4:51 PM Anton Nefedov <address@hidden>
> wrote:
>=20
>> This patch adds a possibility to change a char device without a frontend
>> removal.
>>
>> 1. Ideally, it would have to happen transparently to a frontend, i.e.
>> frontend would continue its regular operation.
>> However, backends are not stateless and are set up by the frontends
>> via qemu_chr_fe_<> functions, and it's not (generally) possible to repla=
y
>> that setup entirely in a backend code, as different chardevs respond
>> to the setup calls differently, so do frontends work differently basing
>> on those setup responses.
>> Moreover, some frontend can generally get and save the backend pointer
>> (qemu_chr_fe_get_driver()), and it will become invalid after backend
>> change.
>>
>> So, a frontend which would like to support chardev hotswap has to regist=
er
>> a "backend change" handler, and redo its backend setup there.
>>
>> 2. Write path can be used by multiple threads and thus protected with
>> chr_write_lock.
>> So hotswap also has to be protected so write functions won't access
>> a backend being replaced.
>>
>>
> Why not use the chr_write_lock then? (rename it chr_lock?)
>=20

chr_write_lock is a Chardev property, it will be gone together with a
swapped device.

We could remove chr_write_lock and leave only the new be->chr_lock,=20
since it covers everything; I guess the only problem is mux, where
multiple CharBackends share the same Chardev.

Would smth like this be better?:

static void char_lock(CharBackend *be)
{
     qemu_mutex_lock(be->chr && CHARDEV_IS_MUX(be->chr) ?
                     &be->chr->chr_lock : &be->chr_lock);
}

and use this instead of lock(be->chr_lock) and remove chr_write_lock.
(This would rely on a fact that mux is never hotswapped so be->chr_lock
is not needed).


>=20
>> 3. Hotswap function can be called from e.g. a read handler of a monitor
>> socket. This can cause troubles so it's safer to defer execution to
>> a bottom-half (however, it means we cannot return some of the errors
>> synchronously - but most of them we can)
>>
>=20
> What kind of troubles?
>=20

if someone tried to hotswap monitor, it would look like:

(gdb) bt
#0 qmp_chardev_change (id=3Did@entry=3D0x7fc24bee7a60 "charmonitor",
backend=3Dbackend@entry=3D0x7fc24cc28290, errp=3Derrp@entry=3D0x7ffde4d8d4f=
0)
at /mnt/code/us-qemu/chardev/char.c:1438
#1 0x00007fc249fd914b in hmp_chardev_change (mon=3D<optimized out>,
qdict=3D<optimized out>) at /mnt/code/us-qemu/hmp.c:2252
#2 0x00007fc249edeece in handle_hmp_command (mon=3Dmon@entry=3D0x7fc24bef87=
c0,
cmdline=3D0x7fc24bf2345f "charmonitor
socket,path=3D/vz/vmprivate/centosos/mon.socket,server,nowait") at
/mnt/code/us-qemu/monitor.c:3100
#3 0x00007fc249ee02fa in monitor_command_cb (opaque=3D0x7fc24bef87c0,
cmdline=3D<optimized out>, readline_opaque=3D<optimized out>)
at /mnt/code/us-qemu/monitor.c:3897
#4 0x00007fc24a242428 in readline_handle_byte (rs=3D0x7fc24bf23450,
ch=3D<optimized out>) at /mnt/code/us-qemu/util/readline.c:393
#5 0x00007fc249edf0e2 in monitor_read (opaque=3D<optimized out>,
buf=3D<optimized out>, size=3D<optimized out>)
at /mnt/code/us-qemu/monitor.c:3880
#6 0x00007fc24a1deb2b in tcp_chr_read (chan=3D<optimized out>,
cond=3D<optimized out>, opaque=3D<optimized out>)
at /mnt/code/us-qemu/chardev/char-socket.c:441
#7 0x00007fc240997d7a in g_main_dispatch (context=3D0x7fc24beda950) at
gmain.c:3152
#8 g_main_context_dispatch (context=3Dcontext@entry=3D0x7fc24beda950) at
gmain.c:3767
#9 0x00007fc24a22fe7c in glib_pollfds_poll () at
/mnt/code/us-qemu/util/main-loop.c:213
#10 os_host_main_loop_wait (timeout=3D<optimized out>) at
/mnt/code/us-qemu/util/main-loop.c:261
#11 main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at
/mnt/code/us-qemu/util/main-loop.c:517
#12 0x00007fc249e9a19a in main_loop () at /mnt/code/us-qemu/vl.c:1900
#13 main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<optimized
out>) at /mnt/code/us-qemu/vl.c:4732

i.e. hotswap the device that is in tcp_chr_read (frame #6), and can
potentially be accessed (with old pointer on a stack) after it is
destroyed by qmp_chardev_change()

however, there is no support for monitor hotswap in the patchset. Maybe
it's not worth to mess with bottom-halves at all? It causes problems,
like those mentioned in your further comments


>>
>> Signed-off-by: Anton Nefedov <address@hidden>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <address@hidden>
>> ---
>>  chardev/char.c        | 147
>> ++++++++++++++++++++++++++++++++++++++++++++++----
>>  include/sysemu/char.h |  10 ++++
>>  qapi-schema.json      |  40 ++++++++++++++
>>  3 files changed, 187 insertions(+), 10 deletions(-)
>>
>> -bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
>> +static bool fe_connect(CharBackend *b, Chardev *s, Error **errp)
>>  {
>>
>=20
> I would rather keep a qemu_chr prefix for consistency
>=20

Done.

>=20
>>      int tag =3D 0;
>>
>> @@ -507,6 +516,17 @@ unavailable:
>>      return false;
>>  }
>>
>> +bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
>> +{
>> +    if (!fe_connect(b, s, errp)) {
>> +        return false;
>> +    }
>> +
>> +    qemu_mutex_init(&b->chr_lock);
>> +    b->hotswap_bh =3D NULL;
>> +    return true;
>> +}
>> +
>>  static bool qemu_chr_is_busy(Chardev *s)
>>  {
>>      if (CHARDEV_IS_MUX(s)) {
>> @@ -531,6 +551,10 @@ void qemu_chr_fe_deinit(CharBackend *b)
>>              d->backends[b->tag] =3D NULL;
>>          }
>>          b->chr =3D NULL;
>> +        qemu_mutex_destroy(&b->chr_lock);
>> +        if (b->hotswap_bh) {
>> +            qemu_bh_delete(b->hotswap_bh);
>>
>=20
> Could there be a chr_new leak here?
>=20
>=20

Yes you're right it can leak.
Maybe we don't need this asynchrony, see above, otherwise I will think
how to fix

>> +        }
>>      }
>>  }
>>
>> @@ -1308,6 +1332,109 @@ ChardevReturn *qmp_chardev_add(const char *id,
>> ChardevBackend *backend,
>>      return ret;
>>  }
>>
>> +static void chardev_change_bh(void *opaque)
>> +{
>> +    Chardev *chr_new =3D opaque;
>> +    const char *id =3D chr_new->label;
>> +    Chardev *chr =3D qemu_chr_find(id);
>>
>=20
> Could chr be gone in the meantime? potentially
>=20
>=20

Potentially yes. Will fix (clean chr_new and bail out).


>> +
>> +    chr_new =3D qemu_chardev_new(NULL,
>> object_class_get_name(OBJECT_CLASS(cc)),
>> +                               backend, errp);
>> +    chr_new->label =3D g_strdup(id);
>>
>=20
> move it below the check for !chr_new
>=20
>=20

my bad, thanks

>> +    if (!chr_new) {
>> +        return NULL;
>> +    }
>> +
>> +    if (chr->be->hotswap_bh) {
>> +        qemu_bh_delete(chr->be->hotswap_bh);
>> +    }
>>
>=20
> Is it necessary to delete and recreate the bh? Could there be a chr_new
> leak if the bh didn't run? It's probably best to deny backend change whil=
e
> one is going on.
>=20
>=20

Hmm probably not, but new() is the only function that sets the argument.
Will think how to fix this if we decide to keep the bh.

>> +    chr->be->hotswap_bh =3D qemu_bh_new(chardev_change_bh, chr_new);
>> +    qemu_bh_schedule(chr->be->hotswap_bh);
>> +
>> +    ret =3D g_new0(ChardevReturn, 1);
>> +    if (CHARDEV_IS_PTY(chr_new)) {
>> +        ret->pty =3D g_strdup(chr_new->filename + 4);
>> +        ret->has_pty =3D true;
>> +    }
>> +
>> +    return ret;
>>
>=20
> ah, potentially a case where qmp-async would be better..
>=20
> +}
>> +
>>  void qmp_chardev_remove(const char *id, Error **errp)
>>  {
>>      Chardev *chr;
>> diff --git a/include/sysemu/char.h b/include/sysemu/char.h
>> index 9f8df07..68c7876 100644
>> --- a/include/sysemu/char.h
>> +++ b/include/sysemu/char.h
>> @@ -92,6 +92,8 @@ typedef struct CharBackend {
>>      void *opaque;
>>      int tag;
>>      int fe_open;
>> +    QemuMutex chr_lock;
>> +    QEMUBH *hotswap_bh;
>>  } CharBackend;
>>
>>  struct Chardev {
>> @@ -141,6 +143,14 @@ void qemu_chr_parse_common(QemuOpts *opts,
>> ChardevCommon *backend);
>>   */
>>  Chardev *qemu_chr_new(const char *label, const char *filename);
>>
>> +/**
>> + * @qemu_chr_change:
>> + *
>> + * Change an existing character backend
>> + *
>> + * @opts the new backend options
>> + */
>> +void qemu_chr_change(QemuOpts *opts, Error **errp);
>>
>>
> This patch needs some test-char.c tests.
>=20
>=20

Will do

/Anton
