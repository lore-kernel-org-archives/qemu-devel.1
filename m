Received: from eggs.gnu.org ([2001:4830:134:3::10]:52263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gEYf3-0005gV-WD
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gEYex-0000Wp-OP
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:46:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gEYew-0000VF-8Z
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:46:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22-v6so2137578wmc.2
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 04:46:07 -0700 (PDT)
Message-ID: <1540208764.16655.240.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Mon, 22 Oct 2018 13:46:04 +0200
In-Reply-To: <1506037511.34884353.1539846969311.JavaMail.zimbra@redhat.com>
References: <20181017143604.5194-1-lhrazky@redhat.com>
	<20181017143604.5194-2-lhrazky@redhat.com>
	<1506037511.34884353.1539846969311.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH spice v2 1/2] QXL interface: add
 functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org, kraxel@redhat.com

Hello,

On Thu, 2018-10-18 at 03:16 -0400, Frediano Ziglio wrote:
> > 
> > Adds two functions to let QEMU provide information to identify graphics
> > devices and their monitors in the guest:
> > 
> > * device address - The path identifying the device on the system (e.g. PCI
> >   path):
> >   spice_qxl_set_device_address(...)
> > 
> > * device display ID - The index of the monitor on the graphics device:
> >   spice_qxl_monitor_set_device_display_id(...)
> 
> This seems to indicate that this device is bound in some way to the previous
> information but having 2 APIs make more fragile, potentially one could
> call a function and not the other or in different order or mismatch them.

Not sure what you mean by "previous information".

Yes, you need to call both functions... The order doesn't matter and
you can always send wrong data in a single function as well. I agree in
this regard a single function would be better but don't find it a big
issue. Note that the functions are called in different places in QEMU
too.

> > 
> > Signed-off-by: Lukáš Hrázký <lhrazky@redhat.com>
> > ---
> >  server/red-qxl.c         | 89 ++++++++++++++++++++++++++++++++++++++++
> >  server/spice-qxl.h       |  5 +++
> >  server/spice-server.syms |  6 +++
> >  3 files changed, 100 insertions(+)
> > 
> > diff --git a/server/red-qxl.c b/server/red-qxl.c
> > index 97940611..0b2043e1 100644
> > --- a/server/red-qxl.c
> > +++ b/server/red-qxl.c
> > @@ -41,6 +41,9 @@
> >  #include "red-qxl.h"
> >  
> >  
> > +#define MAX_PATH_LEN 256
> 
> Different OSes uses MAX_PATH/MAXPATH to specify filename limit so this sounds
> confusing, maybe MAX_DEVICE_PATH_LEN would be better.

Will do.

> > +#define MAX_MONITORS_COUNT 16
> > +
> >  struct QXLState {
> >      QXLWorker qxl_worker;
> >      QXLInstance *qxl;
> > @@ -53,6 +56,9 @@ struct QXLState {
> >      unsigned int max_monitors;
> >      RedsState *reds;
> >      RedWorker *worker;
> > +    char device_address[MAX_PATH_LEN];
> > +    uint32_t device_display_ids[MAX_MONITORS_COUNT];
> > +    size_t monitors_count;  // length of ^^^
> 
> size_t look a bit too much for a number of item in a small array.

It's the go-to type for indexes for me, I'm not used to doing these
little optimizations. If you think it matters, I can change it to like
uint8_t...

> >  
> >      pthread_mutex_t scanout_mutex;
> >      SpiceMsgDisplayGlScanoutUnix scanout;
> > @@ -846,6 +852,89 @@ void red_qxl_gl_draw_async_complete(QXLInstance *qxl)
> >      red_qxl_async_complete(qxl, cookie);
> >  }
> >  
> > +/**
> > + * spice_qxl_set_device_address:
> > + * @instance the QXL instance to set the path to
> > + * @device_address the path of the device this QXL instance belongs to
> > + *
> > + * Sets the hardware address (e.g. PCI) of the graphics device represented
> > by
> > + * this QXL interface instance.
> > + *
> > + * The supported format is:
> > + * "pci/<DOMAIN>/<SLOT>.<FUNCTION>/.../<SLOT>.<FUNCTION>"
> > + *
> > + * The "pci" identifies the rest of the string as a PCI adress. It is the
> > only
> 
> typo: adress
> 
> > + * supported address at the moment, other identifiers can be introduced
> > later.
> > + * <DOMAIN> is the PCI domain, followed by <SLOT>.<FUNCTION> of any PCI
> > bridges
> > + * in the chain leading to the device. The last <SLOT>.<FUNCTION> is the
> > + * graphics device.
> 
> Maybe better to specify also the encoding, like decimal/hexadecimal and number
> of digits.

Right, I'll improve on that.

> > + */
> 
> I would prefer documentation in the header so people don't have to open
> the source to get it, also considering the the header is public.

Sure, makes sense. I just did it the same way as it's done in spice-
gtk, which has the docstrings in .c files for some reason...

> > +SPICE_GNUC_VISIBLE
> > +void spice_qxl_set_device_address(QXLInstance *instance, const char
> > *device_address)
> > +{
> > +    g_return_if_fail(device_address != NULL);
> > +
> > +    size_t dp_len = strnlen(device_address, MAX_PATH_LEN);
> > +    if (dp_len >= MAX_PATH_LEN) {
> > +        spice_error("PCI device path too long: %lu > %u", dp_len,
> > MAX_PATH_LEN);
> > +        return;
> > +    }
> > +
> > +    strncpy(instance->st->device_address, device_address, MAX_PATH_LEN);
> > +
> > +    g_debug("QXL Instance %d setting device address \"%s\"", instance->id,
> > device_address);
> > +}
> > +
> > +/**
> > + * spice_qxl_monitor_set_device_display_id:
> > + * @instance the QXL instance to set the device display ID to
> > + * @monitor_id the SPICE monitor ID to set the device display ID to
> > + * @device_display_id the actual ID of the display (output) on the graphics
> > device
> > + *
> > + * Sets the device display ID for a given monitor ID in a QXL instance. The
> > + * monitor IDs are expected and required to be a consecutive sequence
> > starting
> > + * at 0. The function requires the calls to be made in the sequence to
> > prevent
> > + * holes.
> > + *
> > + * The requirement for the monitor ID to be a sequence starting from 0 comes
> > + * from the mechanism of generating a single display_id from channel_id and
> > + * monitor_id on the client:
> > + *
> > + * display_id = channel_id + monitor_id
> > + *
> 
> No, the monitor_id sequence is defined as a sequence from 0, has nothing
> to do with display_id. Also this comment seems to indicate that this new
> interface is bad designed having the same limit, which is not.

I don't think monitor_id is defined anywhere to be a sequence starting
from 0. If it is, please point me to it. From what I understand,
monitor_id is an arbitrary identifier without further specification
which happens to always be a sequence starting from 0. The thing is
that the way display_id is calculated depends on it, so it is
practically required to start from 0. That's what the docstring is
trying to say.

If I understood correctly, Gerd actually at some point suggested to use
device_display_id as monitor_id, which would not always be a sequence
starting from 0 and that would break the display_id calculation.

Not sure if I can improve the documentation in any way, suggestions
welcome.

> > + * This is unambiguous either if there is only a single channel with
> > multiple
> > + * monitors ("legacy" QXL on linux case) or multiple channels with only a
> > + * single monitor. Also both channel_id and monitor_id need to be a sequence
> > + * starting from 0, otherwise there is still a possibility of collisions.
> 
> They are both defined (channel_id and monitor_id) as sequences starting from 0.
> I don't see why need to be specified here.

As I said, I don't know of such a definition...

> > + */
> > +SPICE_GNUC_VISIBLE
> > +void spice_qxl_monitor_set_device_display_id(QXLInstance *instance,
> > +                                             uint32_t monitor_id,
> > +                                             uint32_t device_display_id)
> 
> I still don't understand why, as suggested by Gerd, we need another function
> instead of 2 additional parameters to the above API specifying start and
> number, this API looks much more prone to errors.

Possibly. I (and I think Jonathon too?) didn't like the start and
number API, this was proposed as an alternative.

> Also there's no much documentation for this "device display ID" in the code,
> potentially can be generated with something like:

I'll add it to the documentation. I think we do agree it's the index of
the actual monitor output on the graphics device?

Cheers,
Lukas

> uint32_t next_device_display_id(void)
> {
>    static unsigned id = 0;
>    return (id++ + 0xf00) * 0xbeef;
> }
> 
> which probably won't work for you.
> 
> > +{
> > +    if (instance->st->monitors_count >= MAX_MONITORS_COUNT) {
> > +        spice_error("Cannot register more than %u monitors per QXL
> > interface", MAX_MONITORS_COUNT);
> > +        return;
> > +    }
> > +
> > +    if (monitor_id > instance->st->monitors_count) {
> > +        spice_error("Monitor ID %u is not inside a consecutive sequence of
> > monitor IDs "
> > +                    "starting from zero. Needs to be lower than or equal to
> > %lu.",
> > +                    monitor_id, instance->st->monitors_count);
> > +        return;
> > +    }
> > +
> > +    instance->st->device_display_ids[monitor_id] = device_display_id;
> > +
> > +    g_debug("QXL Instance %d setting device display ID %u for monitor ID
> > %u",
> > +        instance->id, device_display_id, monitor_id);
> > +
> > +    // if we're adding a new ID (and not resetting an existing one),
> > increment the array length
> > +    if (monitor_id == instance->st->monitors_count) {
> > +        instance->st->monitors_count++;
> > +    }
> > +}
> > +
> >  void red_qxl_init(RedsState *reds, QXLInstance *qxl)
> >  {
> >      QXLState *qxl_state;
> > diff --git a/server/spice-qxl.h b/server/spice-qxl.h
> > index 0c4e75fc..c9ea6564 100644
> > --- a/server/spice-qxl.h
> > +++ b/server/spice-qxl.h
> > @@ -114,6 +114,11 @@ void spice_qxl_gl_draw_async(QXLInstance *instance,
> >                               uint32_t x, uint32_t y,
> >                               uint32_t w, uint32_t h,
> >                               uint64_t cookie);
> > +/* since spice 0.14.2 */
> > +void spice_qxl_set_device_address(QXLInstance *instance, const char
> > *device_path);
> > +void spice_qxl_monitor_set_device_display_id(QXLInstance *instance,
> > +                                             uint32_t monitor_id,
> > +                                             uint32_t device_display_id);
> >  
> >  typedef struct QXLDevInitInfo {
> >      uint32_t num_memslots_groups;
> > diff --git a/server/spice-server.syms b/server/spice-server.syms
> > index edf04a42..6e9ffa93 100644
> > --- a/server/spice-server.syms
> > +++ b/server/spice-server.syms
> > @@ -173,3 +173,9 @@ SPICE_SERVER_0.13.2 {
> >  global:
> >      spice_server_set_video_codecs;
> >  } SPICE_SERVER_0.13.1;
> > +
> > +SPICE_SERVER_0.14.2 {
> > +global:
> > +    spice_qxl_set_device_address;
> > +    spice_qxl_monitor_set_device_display_id;
> > +} SPICE_SERVER_0.13.2;
> 
> Frediano
