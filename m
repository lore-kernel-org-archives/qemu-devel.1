Received: from eggs.gnu.org ([209.51.188.92]:34625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hC4bw-0004nn-Ey
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hC4bv-0002ww-8o
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:49:04 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:52325
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hC4bu-0002td-Rz
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:49:03 -0400
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-4-marcandre.lureau@redhat.com>
	<08893010-9018-65df-bbcc-56796bba5062@adacore.com>
	<CAMxuvazK7YcFm0fORScBfcv+=_kqbexvU5Dvwke8fb8uFkY-eg@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <c1d595db-dcc1-0742-0771-3ed6c6195932@adacore.com>
Date: Thu, 4 Apr 2019 17:49:00 +0200
MIME-Version: 1.0
In-Reply-To: <CAMxuvazK7YcFm0fORScBfcv+=_kqbexvU5Dvwke8fb8uFkY-eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/9] chardev: use a child source for qio
 input source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>



Le 4/4/19 =C3=A0 5:44 PM, Marc-Andr=C3=A9 Lureau a =C3=A9crit=C2=A0:
> Hi
>=20
> On Thu, Apr 4, 2019 at 5:18 PM KONRAD Frederic
> <frederic.konrad@adacore.com> wrote:
>>
>> Hi guys,
>>
>> We have some random delays with gdbstub since this commit under Window=
s.
>> Basically while debugging the next command can sometimes take more tha=
n 5
>> seconds while it usually tooks 30ms before. It is not target dependent=
 I see
>> that happening with sparc, ppc, riscv, etc.. but only on Windows host.
>>
>> Does that ring a bell?
>=20
> No, is this with a socket chardev or other kind?

It's connecting through the TCP socket. '-s -S' option.

>=20
> Could you check the chardev behaviour with the HMP monitor for ex:
> qemu -chardev socket,id=3Dfoo,server,host=3Dlocalhost,port=3D9999 -moni=
tor chardev:foo
>=20
> Is this also taking a few seconds to reply?
>=20
> Have you checked running tests/test-char on windows? Is this also
> taking long (>2sec)?

I'll try to test that.

Thanks!
Fred

>=20
>>
>> Cheers,
>> Fred
>>
>> Le 8/28/18 =C3=A0 12:23 AM, Marc-Andr=C3=A9 Lureau a =C3=A9crit :
>>> GLib child source were added with version 2.28. We can use them now
>>> that we bumped our requirement to 2.40.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    chardev/char-io.c | 48 +++++--------------------------------------=
----
>>>    1 file changed, 5 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/chardev/char-io.c b/chardev/char-io.c
>>> index f81052481a..8ced184160 100644
>>> --- a/chardev/char-io.c
>>> +++ b/chardev/char-io.c
>>> @@ -33,7 +33,6 @@ typedef struct IOWatchPoll {
>>>        IOCanReadHandler *fd_can_read;
>>>        GSourceFunc fd_read;
>>>        void *opaque;
>>> -    GMainContext *context;
>>>    } IOWatchPoll;
>>>
>>>    static IOWatchPoll *io_watch_poll_from_source(GSource *source)
>>> @@ -55,47 +54,24 @@ static gboolean io_watch_poll_prepare(GSource *so=
urce,
>>>            iwp->src =3D qio_channel_create_watch(
>>>                iwp->ioc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL);
>>>            g_source_set_callback(iwp->src, iwp->fd_read, iwp->opaque,=
 NULL);
>>> -        g_source_attach(iwp->src, iwp->context);
>>> -    } else {
>>> -        g_source_destroy(iwp->src);
>>> +        g_source_add_child_source(source, iwp->src);
>>>            g_source_unref(iwp->src);
>>> +    } else {
>>> +        g_source_remove_child_source(source, iwp->src);
>>>            iwp->src =3D NULL;
>>>        }
>>>        return FALSE;
>>>    }
>>>
>>> -static gboolean io_watch_poll_check(GSource *source)
>>> -{
>>> -    return FALSE;
>>> -}
>>> -
>>>    static gboolean io_watch_poll_dispatch(GSource *source, GSourceFun=
c callback,
>>>                                           gpointer user_data)
>>>    {
>>> -    abort();
>>> -}
>>> -
>>> -static void io_watch_poll_finalize(GSource *source)
>>> -{
>>> -    /* Due to a glib bug, removing the last reference to a source
>>> -     * inside a finalize callback causes recursive locking (and a
>>> -     * deadlock).  This is not a problem inside other callbacks,
>>> -     * including dispatch callbacks, so we call io_remove_watch_poll
>>> -     * to remove this source.  At this point, iwp->src must
>>> -     * be NULL, or we would leak it.
>>> -     *
>>> -     * This would be solved much more elegantly by child sources,
>>> -     * but we support older glib versions that do not have them.
>>> -     */
>>> -    IOWatchPoll *iwp =3D io_watch_poll_from_source(source);
>>> -    assert(iwp->src =3D=3D NULL);
>>> +    return G_SOURCE_CONTINUE;
>>>    }
>>>
>>>    static GSourceFuncs io_watch_poll_funcs =3D {
>>>        .prepare =3D io_watch_poll_prepare,
>>> -    .check =3D io_watch_poll_check,
>>>        .dispatch =3D io_watch_poll_dispatch,
>>> -    .finalize =3D io_watch_poll_finalize,
>>>    };
>>>
>>>    GSource *io_add_watch_poll(Chardev *chr,
>>> @@ -115,7 +91,6 @@ GSource *io_add_watch_poll(Chardev *chr,
>>>        iwp->ioc =3D ioc;
>>>        iwp->fd_read =3D (GSourceFunc) fd_read;
>>>        iwp->src =3D NULL;
>>> -    iwp->context =3D context;
>>>
>>>        name =3D g_strdup_printf("chardev-iowatch-%s", chr->label);
>>>        g_source_set_name((GSource *)iwp, name);
>>> @@ -126,23 +101,10 @@ GSource *io_add_watch_poll(Chardev *chr,
>>>        return (GSource *)iwp;
>>>    }
>>>
>>> -static void io_remove_watch_poll(GSource *source)
>>> -{
>>> -    IOWatchPoll *iwp;
>>> -
>>> -    iwp =3D io_watch_poll_from_source(source);
>>> -    if (iwp->src) {
>>> -        g_source_destroy(iwp->src);
>>> -        g_source_unref(iwp->src);
>>> -        iwp->src =3D NULL;
>>> -    }
>>> -    g_source_destroy(&iwp->parent);
>>> -}
>>> -
>>>    void remove_fd_in_watch(Chardev *chr)
>>>    {
>>>        if (chr->gsource) {
>>> -        io_remove_watch_poll(chr->gsource);
>>> +        g_source_destroy(chr->gsource);
>>>            chr->gsource =3D NULL;
>>>        }
>>>    }
>>>
