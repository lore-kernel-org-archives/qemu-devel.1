Received: from eggs.gnu.org ([2001:4830:134:3::10]:38426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gIFCH-0004bi-D1
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gIFCD-0002LG-B0
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:47:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gIFCD-0002Gr-3z
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:47:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id b203-v6so1710267wme.5
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 08:47:33 -0700 (PDT)
Message-ID: <1541087251.16655.419.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Thu, 01 Nov 2018 16:47:31 +0100
In-Reply-To: <1540208764.16655.240.camel@redhat.com>
References: <20181017143604.5194-1-lhrazky@redhat.com>
	<20181017143604.5194-2-lhrazky@redhat.com>
	<1506037511.34884353.1539846969311.JavaMail.zimbra@redhat.com>
	<1540208764.16655.240.camel@redhat.com>
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

On Mon, 2018-10-22 at 13:46 +0200, Lukáš Hrázký wrote:
> Hello,
> 
> On Thu, 2018-10-18 at 03:16 -0400, Frediano Ziglio wrote:
> > > 
> > > Adds two functions to let QEMU provide information to identify graphics
> > > devices and their monitors in the guest:
> > > 
> > > * device address - The path identifying the device on the system (e.g. PCI
> > >   path):
> > >   spice_qxl_set_device_address(...)
> > > 
> > > * device display ID - The index of the monitor on the graphics device:
> > >   spice_qxl_monitor_set_device_display_id(...)
> > 
> > This seems to indicate that this device is bound in some way to the previous
> > information but having 2 APIs make more fragile, potentially one could
> > call a function and not the other or in different order or mismatch them.
> 
> Not sure what you mean by "previous information".
> 
> Yes, you need to call both functions... The order doesn't matter and
> you can always send wrong data in a single function as well. I agree in
> this regard a single function would be better but don't find it a big
> issue. Note that the functions are called in different places in QEMU
> too.
> 
> ...
> 
> > > +SPICE_GNUC_VISIBLE
> > > +void spice_qxl_set_device_address(QXLInstance *instance, const char
> > > *device_address)
> > > +{
> > > 
> > > ...
> > > 
> > > + */
> > > +SPICE_GNUC_VISIBLE
> > > +void spice_qxl_monitor_set_device_display_id(QXLInstance *instance,
> > > +                                             uint32_t monitor_id,
> > > +                                             uint32_t device_display_id)
> > 
> > I still don't understand why, as suggested by Gerd, we need another function
> > instead of 2 additional parameters to the above API specifying start and
> > number, this API looks much more prone to errors.
> 
> Possibly. I (and I think Jonathon too?) didn't like the start and
> number API, this was proposed as an alternative.

this topic of the API functions should be resolved. I think the options
are:


1. Keep the two functions proposed in this patch:

void spice_qxl_set_device_address(QXLInstance *instance,
                                  const char *device_address);

void spice_qxl_monitor_set_device_display_id(QXLInstance *instance,
                                             uint32_t monitor_id,
                                             uint32_t device_display_id);


2. Have a single function as follows:

void spice_qxl_set_device_info(QXLInstance *instance,
                               const char *device_address,
                               uint32_t device_display_id_start,
                               uint32_t device_display_id_count);


The semantics of the single function in 2. (with a sort-of placeholder
name) would be setting the device_address for the QXLInstance as well
as setting a mapping of monitor IDs to device display IDs of
[0, count-1] -> [start, start+count-1].

The usage of 1. in QEMU is what's in patch 2/2. The usage of 2. would
mean calling the new single function in the two places where
spice_qxl_monitor_set_device_display_id() is now called in patch 2/2.
The code that composes the device_address would need to be put in a
function somewhere in QEMU (not sure where yet) that can then be called
from the two places where it's needed.

I'm still somewhat more inclined to keep the two functions, as their
API seems a bit cleaner to me and you can call/not call a single
function in a wrong way too. Frediano prefers a single function.
Jonathon, Gerd?

Thanks,
Lukas
