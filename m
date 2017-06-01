Received: from eggs.gnu.org ([2001:4830:134:3::10]:44578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dGOUw-0007s6-IF
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dGOUr-0002DA-LN
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:42:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40181
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dGOUr-0002D6-EO
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:42:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51Bd7nU123847
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 07:42:32 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2at896kheg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:42:32 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 1 Jun 2017 12:42:30 +0100
Date: Thu, 1 Jun 2017 13:42:24 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170529135520.101429-5-pasic@linux.vnet.ibm.com>
References: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
	<20170529135520.101429-5-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170601134224.62b1a079.cornelia.huck@de.ibm.com>
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

On Mon, 29 May 2017 15:55:17 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Although we have recently vmstatified the migration of some css
> infrastructure,  for some css entities there is still state to be
> migrated left, because the focus was keeping migration stream
> compatibility (that is basically everything as-is).
> 
> Let us add vmstate helpers and extend existing vmstate descriptions so
> that we have everything we need. Let us guard the added state with via

Either 'with' or 'via' ;)

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
> 
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index 7e7546a576..b889e74571 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -139,6 +139,22 @@ static void qemu_s390_flic_register_types(void)
> 
>  type_init(qemu_s390_flic_register_types)
> 
> +static bool adapter_info_so_needed(void *opaque)
> +{
> +    return css_migration_enabled();
> +}
> +
> +const VMStateDescription vmstate_adapter_info_so = {
> +    .name = "s390_adapter_info/summary_offset",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = adapter_info_so_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(summary_offset, AdapterInfo),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VMStateDescription vmstate_adapter_info = {
>      .name = "s390_adapter_info",
>      .version_id = 1,
> @@ -152,6 +168,10 @@ const VMStateDescription vmstate_adapter_info = {
>           */
>          VMSTATE_END_OF_LIST()
>      },
> +    .subsections = (const VMStateDescription * []) {
> +        &vmstate_adapter_info_so,
> +        NULL
> +    }
>  };
> 
>  const VMStateDescription vmstate_adapter_routes = {
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 15517a16e4..a15b58d303 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -27,12 +27,45 @@ typedef struct CrwContainer {
>      QTAILQ_ENTRY(CrwContainer) sibling;
>  } CrwContainer;
> 
> +static const VMStateDescription vmstate_crw = {
> +    .name = "s390_crw",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT16(flags, CRW),
> +        VMSTATE_UINT16(rsid, CRW),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_crw_container = {
> +    .name = "s390_crw_container",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_STRUCT(crw, CrwContainer, 0, vmstate_crw, CRW),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  typedef struct ChpInfo {
>      uint8_t in_use;
>      uint8_t type;
>      uint8_t is_virtual;
>  } ChpInfo;
> 
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
> +
>  typedef struct IoAdapter {
>      uint32_t id;
>      uint8_t type;
> @@ -232,10 +278,34 @@ typedef struct ChannelSubSys {
>      uint64_t chnmon_area;
>      CssImage *css[MAX_CSSID + 1];
>      uint8_t default_cssid;
> +    /* don't migrate */
>      IoAdapter *io_adapters[CSS_IO_ADAPTER_TYPE_NUMS][MAX_ISC + 1];
> +    /* don't migrate */
>      QTAILQ_HEAD(, IndAddr) indicator_addresses;
>  } ChannelSubSys;

I think a couple of words as to _why_ they are not migrated would be
nice. Imagine revisiting this in a few years :)

> 
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
> +        VMSTATE_UINT8(default_cssid, ChannelSubSys),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static ChannelSubSys channel_subsys = {
>      .pending_crws = QTAILQ_HEAD_INITIALIZER(channel_subsys.pending_crws),
>      .do_crw_mchk = true,
> @@ -275,6 +345,10 @@ static int subch_dev_post_load(void *opaque, int version_id)
>          css_subch_assign(s->cssid, s->ssid, s->schid, s->devno, s);
>      }
> 
> +    if (css_migration_enabled()) {
> +        /* No compat voodoo to do ;) */
> +        return 0;
> +    }
>      /*
>       * Hack alert. If we don't migrate the channel subsystem status
>       * we still need to find out if the guest enabled mss/mcss-e.

Other than the nits,

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
