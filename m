Received: from eggs.gnu.org ([2001:4830:134:3::10]:55691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dG8jT-0006hn-Nw
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dG8jQ-0006AT-LL
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:52:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dG8jQ-00069i-BU
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:52:32 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170529135520.101429-5-pasic@linux.vnet.ibm.com> (Halil Pasic's
	message of "Mon, 29 May 2017 15:55:17 +0200")
References: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
	<20170529135520.101429-5-pasic@linux.vnet.ibm.com>
Reply-To: quintela@redhat.com
Date: Wed, 31 May 2017 20:52:29 +0200
Message-ID: <87a85sc102.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/7] s390x/css: add missing css state
 conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> Although we have recently vmstatified the migration of some css
> infrastructure,  for some css entities there is still state to be
> migrated left, because the focus was keeping migration stream
> compatibility (that is basically everything as-is).
>
> Let us add vmstate helpers and extend existing vmstate descriptions so
> that we have everything we need. Let us guard the added state with via
> css_migration_enabled, so we keep the compatible behavior if css
> migration is disabled.
>
> Let's also annotate the bits which do not need to be migrated for better
> readability.
>
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/intc/s390_flic.c | 20 +++++++++++++++
>  hw/s390x/css.c      | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)

Reviewed-by: Juan Quintela <quintela@redhat.com>


For the vmstate bits.  I have exactly zero clue about s390

> +static const VMStateDescription vmstate_chp_info = {
> +    .name = "s390_chp_info",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(in_use, ChpInfo),
> +        VMSTATE_UINT8(type, ChpInfo),
> +        VMSTATE_UINT8(is_virtual, ChpInfo),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  typedef struct SubchSet {
>      SubchDev *sch[MAX_SCHID + 1];
>      unsigned long schids_used[BITS_TO_LONGS(MAX_SCHID + 1)];
> @@ -215,6 +248,19 @@ typedef struct CssImage {
>      ChpInfo chpids[MAX_CHPID + 1];
>  } CssImage;
>  
> +static const VMStateDescription vmstate_css_img = {
> +    .name = "s390_css_img",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        /* Subchannel sets have no relevant state. */
> +        VMSTATE_STRUCT_ARRAY(chpids, CssImage, MAX_CHPID + 1, 0,
> +                             vmstate_chp_info, ChpInfo),
> +        VMSTATE_END_OF_LIST()
> +    }
> +
> +};

> +static const VMStateDescription vmstate_css = {
> +    .name = "s390_css",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_QTAILQ_V(pending_crws, ChannelSubSys, 1, vmstate_crw_container,
> +                         CrwContainer, sibling),
> +        VMSTATE_BOOL(sei_pending, ChannelSubSys),
> +        VMSTATE_BOOL(do_crw_mchk, ChannelSubSys),
> +        VMSTATE_BOOL(crws_lost, ChannelSubSys),
> +        /* These were kind of migrated by virtio */
> +        VMSTATE_UINT8(max_cssid, ChannelSubSys),
> +        VMSTATE_UINT8(max_ssid, ChannelSubSys),
> +        VMSTATE_BOOL(chnmon_active, ChannelSubSys),
> +        VMSTATE_UINT64(chnmon_area, ChannelSubSys),
> +        VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(css, ChannelSubSys, MAX_CSSID + 1,
> +                0, vmstate_css_img, CssImage),

I was about to suggest to move css from pointer to an embedded struct,
and then noticed that MAX_CSSID is .... 65535.  I guess that this is
going to be sparse, very sparse.  Perhaps there is an easier way to
transmit it?

You are transmiting:

65000 structs each of size MAX_CHPID (255) and each element is byte +
byte +byte = 65000 * 255 * 3 = 47 MB.

If it is really sparse, I think that sending something like a list
of <index in array> <contents> could make sense, no?

Or I am missunderstanding something?

Later, Juan.
