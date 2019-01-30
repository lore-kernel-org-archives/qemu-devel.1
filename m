Received: from eggs.gnu.org ([209.51.188.92]:60850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gonPK-0007Ix-GB
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gonPI-0000t1-PH
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:47:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gonPI-0000lP-Fi
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:47:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E79CC804F4
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 10:47:27 +0000 (UTC)
Date: Wed, 30 Jan 2019 10:47:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190130104717.GH15904@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190130103236.18302-1-dgilbert@redhat.com>
	<20190130103236.18302-5-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130103236.18302-5-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/9] migration: Switch to using announce
 timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, quintela@redhat.com, mst@redhat.com, eblake@redhat.com, armbru@redhat.com, germano@redhat.com

On Wed, Jan 30, 2019 at 10:32:31AM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Switch the announcements to using the new announce timer.
> Move the code that does it to announce.c rather than savevm
> because it really has nothing to do with the actual migration.
> 
> Migration starts the announce from bh's and so they're all
> in the main thread/bql, and so there's never any racing with
> the timers themselves.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/migration/misc.h | 10 ------
>  include/net/announce.h   |  2 ++
>  include/sysemu/sysemu.h  |  2 --
>  migration/migration.c    |  2 +-
>  migration/migration.h    |  4 +++
>  migration/savevm.c       | 72 ++--------------------------------------
>  migration/trace-events   |  1 -
>  net/announce.c           | 67 +++++++++++++++++++++++++++++++++++++
>  net/trace-events         |  4 +++
>  9 files changed, 81 insertions(+), 83 deletions(-)


> +#ifndef ETH_P_RARP
> +#define ETH_P_RARP 0x8035
> +#endif
> +#define ARP_HTYPE_ETH 0x0001
> +#define ARP_PTYPE_IP 0x0800
> +#define ARP_OP_REQUEST_REV 0x3
> +
> +static int announce_self_create(uint8_t *buf,
> +                                uint8_t *mac_addr)
> +{
> +    /* Ethernet header. */
> +    memset(buf, 0xff, 6);         /* destination MAC addr */
> +    memcpy(buf + 6, mac_addr, 6); /* source MAC addr */
> +    *(uint16_t *)(buf + 12) = htons(ETH_P_RARP); /* ethertype */
> +
> +    /* RARP header. */
> +    *(uint16_t *)(buf + 14) = htons(ARP_HTYPE_ETH); /* hardware addr space */
> +    *(uint16_t *)(buf + 16) = htons(ARP_PTYPE_IP); /* protocol addr space */
> +    *(buf + 18) = 6; /* hardware addr length (ethernet) */
> +    *(buf + 19) = 4; /* protocol addr length (IPv4) */
> +    *(uint16_t *)(buf + 20) = htons(ARP_OP_REQUEST_REV); /* opcode */
> +    memcpy(buf + 22, mac_addr, 6); /* source hw addr */
> +    memset(buf + 28, 0x00, 4);     /* source protocol addr */
> +    memcpy(buf + 32, mac_addr, 6); /* target hw addr */
> +    memset(buf + 38, 0x00, 4);     /* target protocol addr */
> +
> +    /* Padding to get up to 60 bytes (ethernet min packet size, minus FCS). */
> +    memset(buf + 42, 0x00, 18);
> +
> +    return 60; /* len (FCS will be added by hardware) */
> +}

I think I would suggest defining a packed struct for the ethernet
packet we're sending, so we can just reference named fields instead
of magic offsets. Then I realized this patch is just moving some
pre-existing code, so it is probably better to leave it as it is
in this patch, as mixing code movement with refactoring is bad
practice. If anyone fancies doing a latter patch to use a struct
though, it might be nice.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
