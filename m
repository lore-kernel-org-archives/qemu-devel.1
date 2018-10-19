Received: from eggs.gnu.org ([2001:4830:134:3::10]:37901)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1gDKLQ-0004RI-Cr
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 22:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1gDKLK-0007Hu-Sj
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 22:16:56 -0400
Received: from mail2.static.mailgun.info ([104.130.122.2]:35557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1gDKLK-0007E9-5W
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 22:16:50 -0400
Sender: cst=tolva.net@mg-relay.tolva.net
Received: by mail-wm1-f48.google.com with SMTP id y11-v6so2101810wma.3
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 19:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181008163521.17341-1-cst@tolva.net>
	<20181008163521.17341-4-cst@tolva.net>
	<ab7987e7-0cf9-7bde-12d3-52dba3b16713@vivier.eu>
In-Reply-To: <ab7987e7-0cf9-7bde-12d3-52dba3b16713@vivier.eu>
From: =?UTF-8?Q?Cortland_Setlow_T=C3=B6lva?= <cst@tolva.net>
Date: Thu, 18 Oct 2018 19:16:32 -0700
Message-ID: <CALQmfgOEAsowdHNAUVzfL_GosQbhPMwQk9zP+d0B8kAC_Ex4Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] linux-user: Implement special usbfs
 ioctls.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Cortland_T=C3=B6lva?= <cst@tolva.net>, qemu-devel@nongnu.org

On Thu, Oct 18, 2018 at 11:48 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 08/10/2018 =C3=A0 18:35, Cortland T=C3=B6lva a =C3=A9crit :
> > Userspace submits a USB Request Buffer to the kernel, optionally
> > discards it, and finally reaps the URB.  Thunk buffers from target
> > to host and back.
> >
> > Tested by running an i386 scanner driver on ARMv7 and by running
> > the PowerPC lsusb utility on x86_64.  The discardurb ioctl is
> > not exercised in these tests.
> >
> > Signed-off-by: Cortland T=C3=B6lva <cst@tolva.net>
> > ---
> > There are two alternatives for the strategy of holding lock_user on
> > memory from submit until reap.  v3 of this series tries to determine
> > the access permissions for user memory from endpoint direction, but
> > the logic for this is complex.  The first alternative is to request
> > write access.  If that fails, request read access.  If that fails, try
> > to submit the ioctl with no buffer - perhaps the user code filled in
> > fields the kernel will ignore.  The second alternative is to read user
> > memory into an allocated buffer, pass it to the kernel, and write back
> > to target memory only if the kernel indicates that writes occurred.
> >
> > Changes from v1:
> >   improve pointer cast to int compatibility
> >   remove unimplemented types for usb streams
> >   struct definitions moved to this patch where possible
> >
> > Changes from v2:
> >  organize urb thunk metadata in a struct
> >  hold lock_user from submit until discard
> >  fixes for 64-bit hosts
> >
> >  linux-user/ioctls.h        |   8 ++
> >  linux-user/syscall.c       | 177 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  linux-user/syscall_defs.h  |   4 +
> >  linux-user/syscall_types.h |  20 +++++
> >  4 files changed, 209 insertions(+)
> >
> > diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> > index 92f6177f1d..ae8951625f 100644
> ...
> > index 2641260186..9b7ea96cfb 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -96,6 +96,7 @@
> >  #include <linux/fb.h>
> >  #if defined(CONFIG_USBFS)
> >  #include <linux/usbdevice_fs.h>
> > +#include <linux/usb/ch9.h>
> >  #endif
> >  #include <linux/vt.h>
> >  #include <linux/dm-ioctl.h>
> > @@ -4199,6 +4200,182 @@ static abi_long do_ioctl_ifconf(const IOCTLEntr=
y *ie, uint8_t *buf_temp,
> >      return ret;
> >  }
> >
> > +#if defined(CONFIG_USBFS)
> > +#if HOST_LONG_BITS > 64
> > +#error USBDEVFS thunks do not support >64 bit hosts yet.
> > +#endif
> > +struct live_urb {
> > +    uint64_t target_urb_adr;
> > +    uint64_t target_buf_adr;
> > +    char *target_buf_ptr;
> > +    struct usbdevfs_urb host_urb;
> > +};
> > +
> > +static GHashTable *usbdevfs_urb_hashtable(void)
> > +{
> > +    static GHashTable *urb_hashtable;
> > +
> > +    if (!urb_hashtable) {
> > +        urb_hashtable =3D g_hash_table_new(g_int64_hash, g_int64_equal=
);

g_int64_hash means this GHashTable expects to be given a pointer to an int6=
4_t,
and the int64_t is used as the key.

> > +    }
> > +    return urb_hashtable;
> > +}
> > +
> > +static void urb_hashtable_insert(struct live_urb *urb)
> > +{
> > +    GHashTable *urb_hashtable =3D usbdevfs_urb_hashtable();
> > +    g_hash_table_insert(urb_hashtable, urb, urb);
>
> Here the key of the hashtable seems to be the pointer to the host live_ur=
b.
>

The key is pointed to by urb. It is the first member of the struct,
target_urb_adr.

> > +}
> > +
> > +static struct live_urb *urb_hashtable_lookup(uint64_t target_urb_adr)
> > +{
> > +    GHashTable *urb_hashtable =3D usbdevfs_urb_hashtable();
> > +    return g_hash_table_lookup(urb_hashtable, &target_urb_adr);
>
> And here the key is the pointer to the target_urb_adr
>

target_urb_adr is on the stack here, and it contains the key.  Both
g_hash_table_lookup
and g_hash_table_insert take a pointer to the key, which is an int64_t
in this code.

> So I think urb_hashtable_insert()  should be:
>
>     g_hash_table_insert(urb_hashtable, urb->target_urb_adr, urb);
>
> and urb_hashtable_lookup() should be:
>
>     return g_hash_table_lookup(urb_hashtable, target_urb_adr);
> ...
> Did I miss something?

My code might have been clearer if urb_hashtable_insert and
urb_hashtable_lookup had the same argument type.  However,
I did not want to treat target_urb_adr as the first element in a
struct live_urb until checking that it was tracked in the hashtable.

The thing we are looking up has to be a target-sized pointer, so I
cannot use the g_direct_hash with host-sized pointers as keys.
The next best option was to use int64_t as the key.

>
> Thanks,
> Laurent

Thanks,
Cortland.
