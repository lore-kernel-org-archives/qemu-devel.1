Received: from eggs.gnu.org ([2001:4830:134:3::10]:48187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1elvT2-0002AY-VK
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:43:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1elvT1-0004yh-Mt
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:43:17 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:45958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1elvT1-0004xp-Aq
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:43:15 -0500
Received: by mail-lf0-x243.google.com with SMTP id x196so28997708lfd.12
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 03:43:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4f4fd107-e836-ad27-0778-aa13c9f93b23@redhat.com>
References: <1518598187-27169-1-git-send-email-whois.zihan.yang@gmail.com>
	<4f4fd107-e836-ad27-0778-aa13c9f93b23@redhat.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Wed, 14 Feb 2018 19:43:13 +0800
Message-ID: <CAKwiv-gm39NU0Y5sWaWHoKq6_LBo2FR1RopXLSoi0tC_Ray71w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

> I'm not sure what is the advantage of this change.  QEMU is more or less
> uniformly using QemuMutex and QemuCond.

I see. QEMU uses some glib functions, like g_new, g_free, g_hash_table ,
g_assert and g_poll, so I thought there was a trend for making more use of
glib.
I get the point now.


2018-02-14 18:13 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:

> On 14/02/2018 09:49, Zihan Yang wrote:
> > change the mutex member in RAMList structure from QemuMutex to
> CompatGMutex.
> > qemu_mutex_init() is just deleted instead of being replaced with
> g_mutex_init()
> > because there is no need to do initialize a mutex that is statically
> allocated.
> >
> > Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
>
> I'm not sure what is the advantage of this change.  QEMU is more or less
> uniformly using QemuMutex and QemuCond.
>
> Paolo
>
> > ---
> >  exec.c                 | 5 ++---
> >  include/exec/ramlist.h | 2 +-
> >  2 files changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/exec.c b/exec.c
> > index e8d7b33..90cdd05 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -1423,12 +1423,12 @@ void qemu_flush_coalesced_mmio_buffer(void)
> >
> >  void qemu_mutex_lock_ramlist(void)
> >  {
> > -    qemu_mutex_lock(&ram_list.mutex);
> > +    g_mutex_lock(&ram_list.mutex);
> >  }
> >
> >  void qemu_mutex_unlock_ramlist(void)
> >  {
> > -    qemu_mutex_unlock(&ram_list.mutex);
> > +    g_mutex_unlock(&ram_list.mutex);
> >  }
> >
> >  void ram_block_dump(Monitor *mon)
> > @@ -3331,7 +3331,6 @@ void cpu_register_map_client(QEMUBH *bh)
> >
> >  void cpu_exec_init_all(void)
> >  {
> > -    qemu_mutex_init(&ram_list.mutex);
> >      /* The data structures we set up here depend on knowing the page
> size,
> >       * so no more changes can be made after this point.
> >       * In an ideal world, nothing we did before we had finished the
> > diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
> > index 2e2ac6c..24be5e4 100644
> > --- a/include/exec/ramlist.h
> > +++ b/include/exec/ramlist.h
> > @@ -45,7 +45,7 @@ typedef struct {
> >  } DirtyMemoryBlocks;
> >
> >  typedef struct RAMList {
> > -    QemuMutex mutex;
> > +    CompatGMutex mutex;
> >      RAMBlock *mru_block;
> >      /* RCU-enabled, writes protected by the ramlist lock. */
> >      QLIST_HEAD(, RAMBlock) blocks;
> >
>
>
