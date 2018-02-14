Received: from eggs.gnu.org ([2001:4830:134:3::10]:54261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elvuS-00082I-7e
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 07:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elvuN-0005Ln-86
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 07:11:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1elvuN-0005LS-2m
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 07:11:31 -0500
References: <1518598187-27169-1-git-send-email-whois.zihan.yang@gmail.com>
	<4f4fd107-e836-ad27-0778-aa13c9f93b23@redhat.com>
	<CAKwiv-gm39NU0Y5sWaWHoKq6_LBo2FR1RopXLSoi0tC_Ray71w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6681bcc4-d9f9-8b14-4463-9e93ec422f06@redhat.com>
Date: Wed, 14 Feb 2018 13:11:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAKwiv-gm39NU0Y5sWaWHoKq6_LBo2FR1RopXLSoi0tC_Ray71w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RAMList: replace QemuMutex with
 CompatGMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>
Cc: qemu-devel@nongnu.org

On 14/02/2018 12:43, Zihan Yang wrote:
>=20
>> I'm not sure what is the advantage of this change.=C2=A0 QEMU is more =
or less
>> uniformly using QemuMutex and QemuCond.
>=20
> I see. QEMU uses some glib functions, like g_new, g_free, g_hash_table =
,
> g_assert and g_poll, so I thought there was a trend for making more use
> of glib.
> I get the point now.

There are some plans about using priority inheritance mutexes for
QemuMutex.  GLib does not support anymore pluggable thread functions, so
we are stuck with our own implementation.

Paolo

> 2018-02-14 18:13 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>>:
>=20
>     On 14/02/2018 09:49, Zihan Yang wrote:
>     > change the mutex member in RAMList structure from QemuMutex to Co=
mpatGMutex.
>     > qemu_mutex_init() is just deleted instead of being replaced with =
g_mutex_init()
>     > because there is no need to do initialize a mutex that is statica=
lly allocated.
>     >
>     > Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com <mailto:who=
is.zihan.yang@gmail.com>>
>=20
>     I'm not sure what is the advantage of this change.=C2=A0 QEMU is mo=
re or less
>     uniformly using QemuMutex and QemuCond.
>=20
>     Paolo
>=20
>     > ---
>     >=C2=A0 exec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 5 ++---
>     >=C2=A0 include/exec/ramlist.h | 2 +-
>     >=C2=A0 2 files changed, 3 insertions(+), 4 deletions(-)
>     >
>     > diff --git a/exec.c b/exec.c
>     > index e8d7b33..90cdd05 100644
>     > --- a/exec.c
>     > +++ b/exec.c
>     > @@ -1423,12 +1423,12 @@ void qemu_flush_coalesced_mmio_buffer(voi=
d)
>     >
>     >=C2=A0 void qemu_mutex_lock_ramlist(void)
>     >=C2=A0 {
>     > -=C2=A0 =C2=A0 qemu_mutex_lock(&ram_list.mutex);
>     > +=C2=A0 =C2=A0 g_mutex_lock(&ram_list.mutex);
>     >=C2=A0 }
>     >
>     >=C2=A0 void qemu_mutex_unlock_ramlist(void)
>     >=C2=A0 {
>     > -=C2=A0 =C2=A0 qemu_mutex_unlock(&ram_list.mutex);
>     > +=C2=A0 =C2=A0 g_mutex_unlock(&ram_list.mutex);
>     >=C2=A0 }
>     >
>     >=C2=A0 void ram_block_dump(Monitor *mon)
>     > @@ -3331,7 +3331,6 @@ void cpu_register_map_client(QEMUBH *bh)
>     >
>     >=C2=A0 void cpu_exec_init_all(void)
>     >=C2=A0 {
>     > -=C2=A0 =C2=A0 qemu_mutex_init(&ram_list.mutex);
>     >=C2=A0 =C2=A0 =C2=A0 /* The data structures we set up here depend =
on knowing the
>     page size,
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0* so no more changes can be made after =
this point.
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0* In an ideal world, nothing we did bef=
ore we had finished the
>     > diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
>     > index 2e2ac6c..24be5e4 100644
>     > --- a/include/exec/ramlist.h
>     > +++ b/include/exec/ramlist.h
>     > @@ -45,7 +45,7 @@ typedef struct {
>     >=C2=A0 } DirtyMemoryBlocks;
>     >
>     >=C2=A0 typedef struct RAMList {
>     > -=C2=A0 =C2=A0 QemuMutex mutex;
>     > +=C2=A0 =C2=A0 CompatGMutex mutex;
>     >=C2=A0 =C2=A0 =C2=A0 RAMBlock *mru_block;
>     >=C2=A0 =C2=A0 =C2=A0 /* RCU-enabled, writes protected by the ramli=
st lock. */
>     >=C2=A0 =C2=A0 =C2=A0 QLIST_HEAD(, RAMBlock) blocks;
>     >
>=20
>=20
