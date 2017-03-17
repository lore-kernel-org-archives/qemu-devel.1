Received: from eggs.gnu.org ([2001:4830:134:3::10]:45850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1coprK-00050V-9r
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1coprH-0003LO-HM
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:15:50 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:50066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1coprH-0003K9-44
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:15:47 -0400
Received: from player738.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 9C7DE1DED3
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 12:15:45 +0100 (CET)
Date: Fri, 17 Mar 2017 12:15:38 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170317121538.46c3ca53@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1489694518-16978-2-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703161241220.14378@sstabellini-ThinkPad-X260>
	<1489694518-16978-1-git-send-email-sstabellini@kernel.org>
	<1489694518-16978-2-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/sKOH=wKTDoLZ3Z4o7MSfb/V";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 2/9] xen: import ring.h from xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, jgross@suse.com, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com

--Sig_/sKOH=wKTDoLZ3Z4o7MSfb/V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Mar 2017 13:01:51 -0700
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Do not use the ring.h header installed on the system. Instead, import
> the header into the QEMU codebase. This avoids problems when QEMU is
> built against a Xen version too old to provide all the ring macros.
>=20
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> CC: anthony.perard@citrix.com
> CC: jgross@suse.com
> ---
> NB: The new macros have not been committed to Xen yet. Do not apply this
> patch until they do.
> ---

There are many trailing spaces in include/hw/xen/io/ring.h, but I guess this
is acceptable for an imported header.

Reviewed-by: Greg Kurz <groug@kaod.org>

> ---
>  hw/block/xen_blkif.h     |   2 +-
>  hw/usb/xen-usb.c         |   2 +-
>  include/hw/xen/io/ring.h | 455 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 457 insertions(+), 2 deletions(-)
>  create mode 100644 include/hw/xen/io/ring.h
>=20
> diff --git a/hw/block/xen_blkif.h b/hw/block/xen_blkif.h
> index 3300b6f..3e6e1ea 100644
> --- a/hw/block/xen_blkif.h
> +++ b/hw/block/xen_blkif.h
> @@ -1,7 +1,7 @@
>  #ifndef XEN_BLKIF_H
>  #define XEN_BLKIF_H
> =20
> -#include <xen/io/ring.h>
> +#include "hw/xen/io/ring.h"
>  #include <xen/io/blkif.h>
>  #include <xen/io/protocols.h>
> =20
> diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
> index 8e676e6..370b3d9 100644
> --- a/hw/usb/xen-usb.c
> +++ b/hw/usb/xen-usb.c
> @@ -33,7 +33,7 @@
>  #include "qapi/qmp/qint.h"
>  #include "qapi/qmp/qstring.h"
> =20
> -#include <xen/io/ring.h>
> +#include "hw/xen/io/ring.h"
>  #include <xen/io/usbif.h>
> =20
>  /*
> diff --git a/include/hw/xen/io/ring.h b/include/hw/xen/io/ring.h
> new file mode 100644
> index 0000000..cf01fc3
> --- /dev/null
> +++ b/include/hw/xen/io/ring.h
> @@ -0,0 +1,455 @@
> +/***********************************************************************=
*******
> + * ring.h
> + *=20
> + * Shared producer-consumer ring macros.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to
> + * deal in the Software without restriction, including without limitatio=
n the
> + * rights to use, copy, modify, merge, publish, distribute, sublicense, =
and/or
> + * sell copies of the Software, and to permit persons to whom the Softwa=
re is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> + * DEALINGS IN THE SOFTWARE.
> + *
> + * Tim Deegan and Andrew Warfield November 2004.
> + */
> +
> +#ifndef __XEN_PUBLIC_IO_RING_H__
> +#define __XEN_PUBLIC_IO_RING_H__
> +
> +#if __XEN_INTERFACE_VERSION__ < 0x00030208
> +#define xen_mb()  mb()
> +#define xen_rmb() rmb()
> +#define xen_wmb() wmb()
> +#endif
> +
> +typedef unsigned int RING_IDX;
> +
> +/* Round a 32-bit unsigned constant down to the nearest power of two. */
> +#define __RD2(_x)  (((_x) & 0x00000002) ? 0x2                  : ((_x) &=
 0x1))
> +#define __RD4(_x)  (((_x) & 0x0000000c) ? __RD2((_x)>>2)<<2    : __RD2(_=
x))
> +#define __RD8(_x)  (((_x) & 0x000000f0) ? __RD4((_x)>>4)<<4    : __RD4(_=
x))
> +#define __RD16(_x) (((_x) & 0x0000ff00) ? __RD8((_x)>>8)<<8    : __RD8(_=
x))
> +#define __RD32(_x) (((_x) & 0xffff0000) ? __RD16((_x)>>16)<<16 : __RD16(=
_x))
> +
> +/*
> + * Calculate size of a shared ring, given the total available space for =
the
> + * ring and indexes (_sz), and the name tag of the request/response stru=
cture.
> + * A ring contains as many entries as will fit, rounded down to the near=
est=20
> + * power of two (so we can mask with (size-1) to loop around).
> + */
> +#define __CONST_RING_SIZE(_s, _sz) \
> +    (__RD32(((_sz) - offsetof(struct _s##_sring, ring)) / \
> +	    sizeof(((struct _s##_sring *)0)->ring[0])))
> +/*
> + * The same for passing in an actual pointer instead of a name tag.
> + */
> +#define __RING_SIZE(_s, _sz) \
> +    (__RD32(((_sz) - (long)(_s)->ring + (long)(_s)) / sizeof((_s)->ring[=
0])))
> +
> +/*
> + * Macros to make the correct C datatypes for a new kind of ring.
> + *=20
> + * To make a new ring datatype, you need to have two message structures,
> + * let's say request_t, and response_t already defined.
> + *
> + * In a header where you want the ring datatype declared, you then do:
> + *
> + *     DEFINE_RING_TYPES(mytag, request_t, response_t);
> + *
> + * These expand out to give you a set of types, as you can see below.
> + * The most important of these are:
> + *=20
> + *     mytag_sring_t      - The shared ring.
> + *     mytag_front_ring_t - The 'front' half of the ring.
> + *     mytag_back_ring_t  - The 'back' half of the ring.
> + *
> + * To initialize a ring in your code you need to know the location and s=
ize
> + * of the shared memory area (PAGE_SIZE, for instance). To initialise
> + * the front half:
> + *
> + *     mytag_front_ring_t front_ring;
> + *     SHARED_RING_INIT((mytag_sring_t *)shared_page);
> + *     FRONT_RING_INIT(&front_ring, (mytag_sring_t *)shared_page, PAGE_S=
IZE);
> + *
> + * Initializing the back follows similarly (note that only the front
> + * initializes the shared ring):
> + *
> + *     mytag_back_ring_t back_ring;
> + *     BACK_RING_INIT(&back_ring, (mytag_sring_t *)shared_page, PAGE_SIZ=
E);
> + */
> +
> +#define DEFINE_RING_TYPES(__name, __req_t, __rsp_t)                     \
> +                                                                        \
> +/* Shared ring entry */                                                 \
> +union __name##_sring_entry {                                            \
> +    __req_t req;                                                        \
> +    __rsp_t rsp;                                                        \
> +};                                                                      \
> +                                                                        \
> +/* Shared ring page */                                                  \
> +struct __name##_sring {                                                 \
> +    RING_IDX req_prod, req_event;                                       \
> +    RING_IDX rsp_prod, rsp_event;                                       \
> +    union {                                                             \
> +        struct {                                                        \
> +            uint8_t smartpoll_active;                                   \
> +        } netif;                                                        \
> +        struct {                                                        \
> +            uint8_t msg;                                                \
> +        } tapif_user;                                                   \
> +        uint8_t pvt_pad[4];                                             \
> +    } pvt;                                                              \
> +    uint8_t __pad[44];                                                  \
> +    union __name##_sring_entry ring[1]; /* variable-length */           \
> +};                                                                      \
> +                                                                        \
> +/* "Front" end's private variables */                                   \
> +struct __name##_front_ring {                                            \
> +    RING_IDX req_prod_pvt;                                              \
> +    RING_IDX rsp_cons;                                                  \
> +    unsigned int nr_ents;                                               \
> +    struct __name##_sring *sring;                                       \
> +};                                                                      \
> +                                                                        \
> +/* "Back" end's private variables */                                    \
> +struct __name##_back_ring {                                             \
> +    RING_IDX rsp_prod_pvt;                                              \
> +    RING_IDX req_cons;                                                  \
> +    unsigned int nr_ents;                                               \
> +    struct __name##_sring *sring;                                       \
> +};                                                                      \
> +                                                                        \
> +/* Syntactic sugar */                                                   \
> +typedef struct __name##_sring __name##_sring_t;                         \
> +typedef struct __name##_front_ring __name##_front_ring_t;               \
> +typedef struct __name##_back_ring __name##_back_ring_t
> +
> +/*
> + * Macros for manipulating rings.
> + *=20
> + * FRONT_RING_whatever works on the "front end" of a ring: here=20
> + * requests are pushed on to the ring and responses taken off it.
> + *=20
> + * BACK_RING_whatever works on the "back end" of a ring: here=20
> + * requests are taken off the ring and responses put on.
> + *=20
> + * N.B. these macros do NO INTERLOCKS OR FLOW CONTROL.=20
> + * This is OK in 1-for-1 request-response situations where the=20
> + * requestor (front end) never has more than RING_SIZE()-1
> + * outstanding requests.
> + */
> +
> +/* Initialising empty rings */
> +#define SHARED_RING_INIT(_s) do {                                       \
> +    (_s)->req_prod  =3D (_s)->rsp_prod  =3D 0;                          =
    \
> +    (_s)->req_event =3D (_s)->rsp_event =3D 1;                          =
    \
> +    (void)memset((_s)->pvt.pvt_pad, 0, sizeof((_s)->pvt.pvt_pad));      \
> +    (void)memset((_s)->__pad, 0, sizeof((_s)->__pad));                  \
> +} while(0)
> +
> +#define FRONT_RING_INIT(_r, _s, __size) do {                            \
> +    (_r)->req_prod_pvt =3D 0;                                           =
  \
> +    (_r)->rsp_cons =3D 0;                                               =
  \
> +    (_r)->nr_ents =3D __RING_SIZE(_s, __size);                          =
  \
> +    (_r)->sring =3D (_s);                                               =
  \
> +} while (0)
> +
> +#define BACK_RING_INIT(_r, _s, __size) do {                             \
> +    (_r)->rsp_prod_pvt =3D 0;                                           =
  \
> +    (_r)->req_cons =3D 0;                                               =
  \
> +    (_r)->nr_ents =3D __RING_SIZE(_s, __size);                          =
  \
> +    (_r)->sring =3D (_s);                                               =
  \
> +} while (0)
> +
> +/* How big is this ring? */
> +#define RING_SIZE(_r)                                                   \
> +    ((_r)->nr_ents)
> +
> +/* Number of free requests (for use on front side only). */
> +#define RING_FREE_REQUESTS(_r)                                          \
> +    (RING_SIZE(_r) - ((_r)->req_prod_pvt - (_r)->rsp_cons))
> +
> +/* Test if there is an empty slot available on the front ring.
> + * (This is only meaningful from the front. )
> + */
> +#define RING_FULL(_r)                                                   \
> +    (RING_FREE_REQUESTS(_r) =3D=3D 0)
> +
> +/* Test if there are outstanding messages to be processed on a ring. */
> +#define RING_HAS_UNCONSUMED_RESPONSES(_r)                               \
> +    ((_r)->sring->rsp_prod - (_r)->rsp_cons)
> +
> +#ifdef __GNUC__
> +#define RING_HAS_UNCONSUMED_REQUESTS(_r) ({                             \
> +    unsigned int req =3D (_r)->sring->req_prod - (_r)->req_cons;        =
  \
> +    unsigned int rsp =3D RING_SIZE(_r) -                                =
  \
> +        ((_r)->req_cons - (_r)->rsp_prod_pvt);                          \
> +    req < rsp ? req : rsp;                                              \
> +})
> +#else
> +/* Same as above, but without the nice GCC ({ ... }) syntax. */
> +#define RING_HAS_UNCONSUMED_REQUESTS(_r)                                \
> +    ((((_r)->sring->req_prod - (_r)->req_cons) <                        \
> +      (RING_SIZE(_r) - ((_r)->req_cons - (_r)->rsp_prod_pvt))) ?        \
> +     ((_r)->sring->req_prod - (_r)->req_cons) :                         \
> +     (RING_SIZE(_r) - ((_r)->req_cons - (_r)->rsp_prod_pvt)))
> +#endif
> +
> +/* Direct access to individual ring elements, by index. */
> +#define RING_GET_REQUEST(_r, _idx)                                      \
> +    (&((_r)->sring->ring[((_idx) & (RING_SIZE(_r) - 1))].req))
> +
> +/*
> + * Get a local copy of a request.
> + *
> + * Use this in preference to RING_GET_REQUEST() so all processing is
> + * done on a local copy that cannot be modified by the other end.
> + *
> + * Note that https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D58145 may ca=
use this
> + * to be ineffective where _req is a struct which consists of only bitfi=
elds.
> + */
> +#define RING_COPY_REQUEST(_r, _idx, _req) do {				\
> +	/* Use volatile to force the copy into _req. */			\
> +	*(_req) =3D *(volatile typeof(_req))RING_GET_REQUEST(_r, _idx);	\
> +} while (0)
> +
> +#define RING_GET_RESPONSE(_r, _idx)                                     \
> +    (&((_r)->sring->ring[((_idx) & (RING_SIZE(_r) - 1))].rsp))
> +
> +/* Loop termination condition: Would the specified index overflow the ri=
ng? */
> +#define RING_REQUEST_CONS_OVERFLOW(_r, _cons)                           \
> +    (((_cons) - (_r)->rsp_prod_pvt) >=3D RING_SIZE(_r))
> +
> +/* Ill-behaved frontend determination: Can there be this many requests? =
*/
> +#define RING_REQUEST_PROD_OVERFLOW(_r, _prod)                           \
> +    (((_prod) - (_r)->rsp_prod_pvt) > RING_SIZE(_r))
> +
> +#define RING_PUSH_REQUESTS(_r) do {                                     \
> +    xen_wmb(); /* back sees requests /before/ updated producer index */ \
> +    (_r)->sring->req_prod =3D (_r)->req_prod_pvt;                       =
  \
> +} while (0)
> +
> +#define RING_PUSH_RESPONSES(_r) do {                                    \
> +    xen_wmb(); /* front sees resps /before/ updated producer index */   \
> +    (_r)->sring->rsp_prod =3D (_r)->rsp_prod_pvt;                       =
  \
> +} while (0)
> +
> +/*
> + * Notification hold-off (req_event and rsp_event):
> + *=20
> + * When queueing requests or responses on a shared ring, it may not alwa=
ys be
> + * necessary to notify the remote end. For example, if requests are in f=
light
> + * in a backend, the front may be able to queue further requests without
> + * notifying the back (if the back checks for new requests when it queues
> + * responses).
> + *=20
> + * When enqueuing requests or responses:
> + *=20
> + *  Use RING_PUSH_{REQUESTS,RESPONSES}_AND_CHECK_NOTIFY(). The second ar=
gument
> + *  is a boolean return value. True indicates that the receiver requires=
 an
> + *  asynchronous notification.
> + *=20
> + * After dequeuing requests or responses (before sleeping the connection=
):
> + *=20
> + *  Use RING_FINAL_CHECK_FOR_REQUESTS() or RING_FINAL_CHECK_FOR_RESPONSE=
S().
> + *  The second argument is a boolean return value. True indicates that t=
here
> + *  are pending messages on the ring (i.e., the connection should not be=
 put
> + *  to sleep).
> + *=20
> + *  These macros will set the req_event/rsp_event field to trigger a
> + *  notification on the very next message that is enqueued. If you want =
to
> + *  create batches of work (i.e., only receive a notification after seve=
ral
> + *  messages have been enqueued) then you will need to create a customis=
ed
> + *  version of the FINAL_CHECK macro in your own code, which sets the ev=
ent
> + *  field appropriately.
> + */
> +
> +#define RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(_r, _notify) do {           \
> +    RING_IDX __old =3D (_r)->sring->req_prod;                           =
  \
> +    RING_IDX __new =3D (_r)->req_prod_pvt;                              =
  \
> +    xen_wmb(); /* back sees requests /before/ updated producer index */ \
> +    (_r)->sring->req_prod =3D __new;                                    =
  \
> +    xen_mb(); /* back sees new requests /before/ we check req_event */  \
> +    (_notify) =3D ((RING_IDX)(__new - (_r)->sring->req_event) <         =
  \
> +                 (RING_IDX)(__new - __old));                            \
> +} while (0)
> +
> +#define RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(_r, _notify) do {          \
> +    RING_IDX __old =3D (_r)->sring->rsp_prod;                           =
  \
> +    RING_IDX __new =3D (_r)->rsp_prod_pvt;                              =
  \
> +    xen_wmb(); /* front sees resps /before/ updated producer index */   \
> +    (_r)->sring->rsp_prod =3D __new;                                    =
  \
> +    xen_mb(); /* front sees new resps /before/ we check rsp_event */    \
> +    (_notify) =3D ((RING_IDX)(__new - (_r)->sring->rsp_event) <         =
  \
> +                 (RING_IDX)(__new - __old));                            \
> +} while (0)
> +
> +#define RING_FINAL_CHECK_FOR_REQUESTS(_r, _work_to_do) do {             \
> +    (_work_to_do) =3D RING_HAS_UNCONSUMED_REQUESTS(_r);                 =
  \
> +    if (_work_to_do) break;                                             \
> +    (_r)->sring->req_event =3D (_r)->req_cons + 1;                      =
  \
> +    xen_mb();                                                           \
> +    (_work_to_do) =3D RING_HAS_UNCONSUMED_REQUESTS(_r);                 =
  \
> +} while (0)
> +
> +#define RING_FINAL_CHECK_FOR_RESPONSES(_r, _work_to_do) do {            \
> +    (_work_to_do) =3D RING_HAS_UNCONSUMED_RESPONSES(_r);                =
  \
> +    if (_work_to_do) break;                                             \
> +    (_r)->sring->rsp_event =3D (_r)->rsp_cons + 1;                      =
  \
> +    xen_mb();                                                           \
> +    (_work_to_do) =3D RING_HAS_UNCONSUMED_RESPONSES(_r);                =
  \
> +} while (0)
> +
> +
> +/*
> + * DEFINE_XEN_FLEX_RING_AND_INTF defines two monodirectional rings and
> + * functions to check if there is data on the ring, and to read and
> + * write to them.
> + *
> + * DEFINE_XEN_FLEX_RING is similar to DEFINE_XEN_FLEX_RING_AND_INTF, but
> + * does not define the indexes page. As different protocols can have
> + * extensions to the basic format, this macro allow them to define their
> + * own struct.
> + *
> + * XEN_FLEX_RING_SIZE
> + *   Convenience macro to calculate the size of one of the two rings
> + *   from the overall order.
> + *
> + * $NAME_mask
> + *   Function to apply the size mask to an index, to reduce the index
> + *   within the range [0-size].
> + *
> + * $NAME_read_packet
> + *   Function to read data from the ring. The amount of data to read is
> + *   specified by the "size" argument.
> + *
> + * $NAME_write_packet
> + *   Function to write data to the ring. The amount of data to write is
> + *   specified by the "size" argument.
> + *
> + * $NAME_get_ring_ptr
> + *   Convenience function that returns a pointer to read/write to the
> + *   ring at the right location.
> + *
> + * $NAME_data_intf
> + *   Indexes page, shared between frontend and backend. It also
> + *   contains the array of grant refs.
> + *
> + * $NAME_queued
> + *   Function to calculate how many bytes are currently on the ring,
> + *   ready to be read. It can also be used to calculate how much free
> + *   space is currently on the ring (ring_size - $NAME_queued()).
> + */
> +#define XEN_FLEX_RING_SIZE(order)                                       =
      \
> +    (1UL << (order + PAGE_SHIFT - 1))
> +
> +#define DEFINE_XEN_FLEX_RING_AND_INTF(name)                             =
      \
> +struct name##_data_intf {                                               =
      \
> +    RING_IDX in_cons, in_prod;                                          =
      \
> +                                                                        =
      \
> +    uint8_t pad1[56];                                                   =
      \
> +                                                                        =
      \
> +    RING_IDX out_cons, out_prod;                                        =
      \
> +                                                                        =
      \
> +    uint8_t pad2[56];                                                   =
      \
> +                                                                        =
      \
> +    RING_IDX ring_order;                                                =
      \
> +    grant_ref_t ref[];                                                  =
      \
> +};                                                                      =
      \
> +DEFINE_XEN_FLEX_RING(name);
> +
> +#define DEFINE_XEN_FLEX_RING(name)                                      =
      \
> +static inline RING_IDX name##_mask(RING_IDX idx, RING_IDX ring_size)    =
      \
> +{                                                                       =
      \
> +    return (idx & (ring_size - 1));                                     =
      \
> +}                                                                       =
      \
> +                                                                        =
      \
> +static inline RING_IDX name##_mask_order(RING_IDX idx, RING_IDX ring_ord=
er)   \
> +{                                                                       =
      \
> +    return (idx & (XEN_FLEX_RING_SIZE(ring_order) - 1));                =
      \
> +}                                                                       =
      \
> +                                                                        =
      \
> +static inline unsigned char* name##_get_ring_ptr(unsigned char *buf,    =
      \
> +                                                 RING_IDX idx,          =
      \
> +                                                 RING_IDX ring_order)   =
      \
> +{                                                                       =
      \
> +    return buf + name##_mask_order(idx, ring_order);                    =
      \
> +}                                                                       =
      \
> +                                                                        =
      \
> +static inline void name##_read_packet(const unsigned char *buf,         =
      \
> +        RING_IDX masked_prod, RING_IDX *masked_cons,                    =
      \
> +        RING_IDX ring_size, void *opaque, size_t size) {                =
      \
> +    if (*masked_cons < masked_prod ||                                   =
      \
> +            size <=3D ring_size - *masked_cons) {                       =
        \
> +        memcpy(opaque, buf + *masked_cons, size);                       =
      \
> +    } else {                                                            =
      \
> +        memcpy(opaque, buf + *masked_cons, ring_size - *masked_cons);   =
      \
> +        memcpy((unsigned char *)opaque + ring_size - *masked_cons, buf, =
      \
> +                size - (ring_size - *masked_cons));                     =
      \
> +    }                                                                   =
      \
> +    *masked_cons =3D name##_mask(*masked_cons + size, ring_size);       =
        \
> +}                                                                       =
      \
> +                                                                        =
      \
> +static inline void name##_write_packet(unsigned char *buf,              =
      \
> +        RING_IDX *masked_prod, RING_IDX masked_cons,                    =
      \
> +        RING_IDX ring_size, const void *opaque, size_t size) {          =
      \
> +    if (*masked_prod < masked_cons ||                                   =
      \
> +        size <=3D ring_size - *masked_prod) {                           =
        \
> +        memcpy(buf + *masked_prod, opaque, size);                       =
      \
> +    } else {                                                            =
      \
> +        memcpy(buf + *masked_prod, opaque, ring_size - *masked_prod);   =
      \
> +        memcpy(buf, (unsigned char *)opaque + (ring_size - *masked_prod)=
,     \
> +                size - (ring_size - *masked_prod));                     =
      \
> +    }                                                                   =
      \
> +    *masked_prod =3D name##_mask(*masked_prod + size, ring_size);       =
        \
> +}                                                                       =
      \
> +                                                                        =
      \
> +struct name##_data {                                                    =
      \
> +    unsigned char *in; /* half of the allocation */                     =
      \
> +    unsigned char *out; /* half of the allocation */                    =
      \
> +};                                                                      =
      \
> +                                                                        =
      \
> +                                                                        =
      \
> +static inline RING_IDX name##_queued(RING_IDX prod,                     =
      \
> +        RING_IDX cons, RING_IDX ring_size)                              =
      \
> +{                                                                       =
      \
> +    RING_IDX size;                                                      =
      \
> +                                                                        =
      \
> +    if (prod =3D=3D cons)                                               =
          \
> +        return 0;                                                       =
      \
> +                                                                        =
      \
> +    prod =3D name##_mask(prod, ring_size);                              =
        \
> +    cons =3D name##_mask(cons, ring_size);                              =
        \
> +                                                                        =
      \
> +    if (prod =3D=3D cons)                                               =
          \
> +        return ring_size;                                               =
      \
> +                                                                        =
      \
> +    if (prod > cons)                                                    =
      \
> +        size =3D prod - cons;                                           =
        \
> +    else                                                                =
      \
> +        size =3D ring_size - (cons - prod);                             =
        \
> +    return size;                                                        =
      \
> +};
> +
> +#endif /* __XEN_PUBLIC_IO_RING_H__ */
> +
> +/*
> + * Local variables:
> + * mode: C
> + * c-file-style: "BSD"
> + * c-basic-offset: 4
> + * tab-width: 4
> + * indent-tabs-mode: nil
> + * End:
> + */


--Sig_/sKOH=wKTDoLZ3Z4o7MSfb/V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljLxVoACgkQAvw66wEB28L9QACgmh3mVXbOQS4GIrruyvaKaJGH
THQAoJi5pv01eJ21GGCdfsDRD/V5W38Q
=+Ixl
-----END PGP SIGNATURE-----

--Sig_/sKOH=wKTDoLZ3Z4o7MSfb/V--
