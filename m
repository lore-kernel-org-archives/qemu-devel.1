Received: from eggs.gnu.org ([2001:4830:134:3::10]:32808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYuV9-0002lh-Ij
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYuV7-0008JH-F6
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:59:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cYuV7-0008J8-8t
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:59:05 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 503BBC0567B2
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 12:59:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170109201340.16593-4-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 9 Jan 2017 20:13:40 +0000")
References: <20170109201340.16593-1-dgilbert@redhat.com>
	<20170109201340.16593-4-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 01 Feb 2017 13:58:59 +0100
Message-ID: <87o9ymqd7w.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/3] vmstate registration: check return
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, amit.shah@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Check qdev's call to vmstate_register_with_alias_id; that gets
> most of the common uses; there's hundreds of calls via vmstate_register
> which could get fixed over time.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/core/qdev.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index ea97b15..df633d0 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -933,10 +933,12 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>          }
>  
>          if (qdev_get_vmsd(dev)) {
> -            vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(dev), dev,
> +            if (vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(dev), dev,
>                                             dev->instance_id_alias,

Indent this correctly, please.

>                                             dev->alias_required_for_version,
> -                                           NULL);
> +                                           &local_err) < 0) {
> +                goto post_realize_fail;
> +            }
>          }
>  
>          QLIST_FOREACH(bus, &dev->child_bus, sibling) {

Once that is fixed, I am ok with it.

Reviewed-by: Juan Quintela <quintela@redhat.com>
