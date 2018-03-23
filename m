Received: from eggs.gnu.org ([2001:4830:134:3::10]:35427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ezNfj-0001dy-03
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ezNfe-0000fj-2W
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:27:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58154 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ezNfd-0000fb-Ti
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:27:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9E48818B123
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 14:27:49 +0000 (UTC)
Date: Fri, 23 Mar 2018 17:27:42 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180323172707-mutt-send-email-mst@kernel.org>
References: <20180323124637.11220-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323124637.11220-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vhost: Allow abutting regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com

On Fri, Mar 23, 2018 at 12:46:37PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> My rework of section adding combines overlapping or abutting regions,
> but checks they're actually the same underlying RAM block.
> Fix the case where two blocks abut but don't overlap; that new region
> should get added (but not combined), but my previous patch was disallowing it.
> 
> Fixes: c1ece84e7c9
> 
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Can we replace abutting with adjacent pls?

> ---
>  hw/virtio/vhost.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 250f886acb..fc9062a89f 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -595,10 +595,15 @@ static void vhost_region_add_section(struct vhost_dev *dev,
>                                          prev_sec->offset_within_address_space,
>                                          prev_sec->offset_within_region);
>              } else {
> -                error_report("%s: Overlapping but not coherent sections "
> -                             "at %"PRIx64,
> -                             __func__, mrs_gpa);
> -                return;
> +                /* abutting regions are fine, but overlapping ones with
> +                 * different blocks/offsets shouldn't happen
> +                 */
> +                if (mrs_gpa != prev_gpa_end + 1) {
> +                    error_report("%s: Overlapping but not coherent sections "
> +                                 "at %"PRIx64,
> +                                 __func__, mrs_gpa);
> +                    return;
> +                }
>              }
>          }
>      }
> -- 
> 2.14.3
