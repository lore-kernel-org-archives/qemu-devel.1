Received: from eggs.gnu.org ([209.51.188.92]:43579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1ghtr3-0007Iq-8m
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1ghtr2-0004Oe-0b
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:15:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1ghtr1-0004NZ-Oe
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:15:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so14564495wrp.3
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 02:15:54 -0800 (PST)
Message-ID: <1547201752.3768.256.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Fri, 11 Jan 2019 11:15:52 +0100
In-Reply-To: <98b89b44cdba6e7128381a5216ec955771c4caaa.camel@redhat.com>
References: <20190108152648.32537-1-lhrazky@redhat.com>
	<20190108152648.32537-2-lhrazky@redhat.com>
	<98b89b44cdba6e7128381a5216ec955771c4caaa.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Spice-devel] [PATCH spice 1/3] QXL interface: add
 a function to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonathon Jongsma <jjongsma@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

On Wed, 2019-01-09 at 11:36 -0600, Jonathon Jongsma wrote:
> On Tue, 2019-01-08 at 16:26 +0100, Lukáš Hrázký wrote:
> > Adds a function to let QEMU provide information to identify graphics
> > devices and their monitors in the guest. The function
> > (spice_qxl_set_device_info) sets the device address (e.g. a PCI path)
> > and monitor ID -> device display ID mapping of displays exposed by
> > given
> > QXL interface.
> 
> 
> In my previous review, I asked for a slightly more explicit explanation
> of the phrase "monitor ID" in the commit log. In this case, "monitor
> ID" is an ID specific to the QXL instance starting at 0 and represents
> the displays that are associated with that particular QXL instance.
> 
> Perhaps it makes sense to rename this "Qxl monitor ID"?

Sorry, I might have forgotten to incorporate some comments on the old
series :/

To reiterate, though, what do you find unclear about the "monitor ID"?
I mean maybe it should be spelled "monitor_id" to make it clearer what
it refers to... Not sure if "Qxl monitor ID" helps, since it is not
strictly related to QXL, but more to the QXL interface (which is used
for all graphic cards, which makes it more confusing)...

> > Signed-off-by: Lukáš Hrázký <lhrazky@redhat.com>
> > ---
> >  server/red-qxl.c         | 44 ++++++++++++++++++++++++++++++++++++++
> >  server/spice-qxl.h       | 46
> > ++++++++++++++++++++++++++++++++++++++++
> >  server/spice-server.syms |  5 +++++
> >  3 files changed, 95 insertions(+)
> > 
> > diff --git a/server/red-qxl.c b/server/red-qxl.c
> > index 97940611..0ea424cd 100644
> > --- a/server/red-qxl.c
> > +++ b/server/red-qxl.c
> > @@ -41,6 +41,9 @@
> >  #include "red-qxl.h"
> >  
> >  
> > +#define MAX_DEVICE_ADDRESS_LEN 256
> > +#define MAX_MONITORS_COUNT 16
> > +
> >  struct QXLState {
> >      QXLWorker qxl_worker;
> >      QXLInstance *qxl;
> > @@ -53,6 +56,9 @@ struct QXLState {
> >      unsigned int max_monitors;
> >      RedsState *reds;
> >      RedWorker *worker;
> > +    char device_address[MAX_DEVICE_ADDRESS_LEN];
> > +    uint32_t device_display_ids[MAX_MONITORS_COUNT];
> > +    size_t monitors_count;  // length of ^^^
> >  
> >      pthread_mutex_t scanout_mutex;
> >      SpiceMsgDisplayGlScanoutUnix scanout;
> > @@ -846,6 +852,44 @@ void red_qxl_gl_draw_async_complete(QXLInstance
> > *qxl)
> >      red_qxl_async_complete(qxl, cookie);
> >  }
> >  
> > +SPICE_GNUC_VISIBLE
> > +void spice_qxl_set_device_info(QXLInstance *instance,
> > +                               const char *device_address,
> > +                               uint32_t device_display_id_start,
> > +                               uint32_t device_display_id_count)
> > +{
> > +    g_return_if_fail(device_address != NULL);
> 
> Just a thought: what if qemu calls this function twice for the same
> instance. In theory this shouldn't happen, but should we be defensive
> and handle it somehow? Print a warning? Just overwrite the previous
> mapping? Right now it looks like we would just overwrite.

I'm pretty sure overwriting is the correct behavior here, no logging
needed? There may be a situation where the info changes in the future,
for whatever reasons. At least this part of the code should be fine
with it (though I'm not sure atm. if e.g. the client would cope well).

> > +
> > +    size_t da_len = strnlen(device_address, MAX_DEVICE_ADDRESS_LEN);
> > +    if (da_len >= MAX_DEVICE_ADDRESS_LEN) {
> > +        spice_error("Device address too long: %lu > %u", da_len,
> > MAX_DEVICE_ADDRESS_LEN);
> 
> Technically, I think the format string for a size_t variable is %zu,
> not %lu

You're right, didn't know that. I think I have some fixing to do :)

> > +        return;
> > +    }
> > +
> > +    if (device_display_id_count > MAX_MONITORS_COUNT) {
> > +        spice_error("Device display ID count (%u) is greater than
> > limit %u",
> > +                    device_display_id_count,
> > +                    MAX_MONITORS_COUNT);
> > +        return;
> > +    }
> > +
> > +    strncpy(instance->st->device_address, device_address,
> > MAX_DEVICE_ADDRESS_LEN);
> > +
> > +    g_debug("QXL Instance %d setting device address \"%s\" and
> > monitor -> device display mapping:",
> > +            instance->id,
> > +            device_address);
> > +
> > +    // store the mapping monitor_id -> device_display_id
> > +    for (uint32_t monitor_id = 0; monitor_id <
> > device_display_id_count; ++monitor_id) {
> > +        uint32_t device_display_id = device_display_id_start +
> > monitor_id;
> > +        instance->st->device_display_ids[monitor_id] =
> > device_display_id;
> > +        g_debug("   monitor ID %u -> device display ID %u",
> > +                monitor_id, device_display_id);
> > +    }
> > +
> > +    instance->st->monitors_count = device_display_id_count;
> > +}
> > +
> >  void red_qxl_init(RedsState *reds, QXLInstance *qxl)
> >  {
> >      QXLState *qxl_state;
> > diff --git a/server/spice-qxl.h b/server/spice-qxl.h
> > index 0c4e75fc..547d3d93 100644
> > --- a/server/spice-qxl.h
> > +++ b/server/spice-qxl.h
> > @@ -115,6 +115,52 @@ void spice_qxl_gl_draw_async(QXLInstance
> > *instance,
> >                               uint32_t w, uint32_t h,
> >                               uint64_t cookie);
> >  
> > +/* since spice 0.14.2 */
> > +
> > +/**
> > + * spice_qxl_set_device_info:
> > + * @instance the QXL instance to set the path to
> > + * @device_address the path of the device this QXL instance belongs
> > to
> > + * @device_display_id_start the starting device display ID of this
> > interface,
> > + *                          i.e. the one monitor ID 0 maps to
> 
> perhaps reword this last line:
> i.e. the device display ID of monitor ID 0

Will do.

> > + * @device_display_id_count the total number of device display IDs
> > on this
> > + *                          interface
> > + *
> > + * Sets the device information for this QXL interface, i.e. the
> > hardware
> > + * address (e.g. PCI) of the graphics device and the IDs of the
> > displays of the
> > + * graphics device that are exposed by this interface (device
> > display IDs).
> > + *
> > + * The supported device address format is:
> > + * "pci/<DOMAIN>/<SLOT>.<FUNCTION>/.../<SLOT>.<FUNCTION>"
> > + *
> > + * The "pci" identifies the rest of the string as a PCI address. It
> > is the only
> > + * supported address at the moment, other identifiers can be
> > introduced later.
> > + * <DOMAIN> is the PCI domain, followed by <SLOT>.<FUNCTION> of any
> > PCI bridges
> > + * in the chain leading to the device. The last <SLOT>.<FUNCTION> is
> > the
> > + * graphics device. All of <DOMAIN>, <SLOT>, <FUNCTION> are
> > hexadecimal numbers
> > + * with the following number of digits:
> > + *   <DOMAIN>: 4
> > + *   <SLOT>: 2
> > + *   <FUNCTION>: 1
> > + *
> > + * The device_display_id_{start,count} denotes the sequence of
> > device display
> > + * IDs that map to the zero-based sequence of monitor IDs provided
> > by monitors
> > + * config on this interface. For example with
> > device_display_id_start = 2 and
> > + * device_display_id_count = 3 you get the following mapping:
> > + * monitor_id  ->  device_display_id
> > + *          0  ->  2
> > + *          1  ->  3
> > + *          2  ->  4
> > + *
> > + * Note this example is unsupported in practice. The only supported
> > cases are
> > + * either a single device display ID (count = 1) or multiple device
> > display IDs
> > + * in a sequence starting from 0.
> > + */
> 
> Gerd previously objected to using an example of an unsupported
> scenario. But it doesn't seem that you changed anything here. I don't
> care too much, myself.

Right, forgot about that.

Thanks,
Lukas

> > +void spice_qxl_set_device_info(QXLInstance *instance,
> > +                               const char *device_address,
> > +                               uint32_t device_display_id_start,
> > +                               uint32_t device_display_id_count);
> > +
> >  typedef struct QXLDevInitInfo {
> >      uint32_t num_memslots_groups;
> >      uint32_t num_memslots;
> > diff --git a/server/spice-server.syms b/server/spice-server.syms
> > index edf04a42..ac4d9b14 100644
> > --- a/server/spice-server.syms
> > +++ b/server/spice-server.syms
> > @@ -173,3 +173,8 @@ SPICE_SERVER_0.13.2 {
> >  global:
> >      spice_server_set_video_codecs;
> >  } SPICE_SERVER_0.13.1;
> > +
> > +SPICE_SERVER_0.14.2 {
> > +global:
> > +    spice_qxl_set_device_info;
> > +} SPICE_SERVER_0.13.2;
> 
> 
