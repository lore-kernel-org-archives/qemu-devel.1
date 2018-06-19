Received: from eggs.gnu.org ([2001:4830:134:3::10]:36910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVA38-00044y-Ix
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVA34-00007O-Lk
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:23:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fVA34-00007G-HJ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:23:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BB51401EF00
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 06:23:26 +0000 (UTC)
Date: Tue, 19 Jun 2018 08:23:23 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180619062323.t6hbpvmcsrcgwmmm@sirius.home.kraxel.org>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-11-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618161729.334-11-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 10/26] vhost-user: split
 vhost_user_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com

> @@ -237,7 +251,7 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
>          error_report("Failed to read msg header."
>                  " Size %d exceeds the maximum %zu.", msg->hdr.size,
>                  VHOST_USER_PAYLOAD_SIZE);
> -        goto fail;
> +        return -1;

Hmm?  Looks like a pointless indirection ...

>      }
>  
>      if (msg->hdr.size) {
> @@ -247,14 +261,11 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
>          if (r != size) {
>              error_report("Failed to read msg payload."
>                           " Read %d instead of %d.", r, msg->hdr.size);
> -            goto fail;
> +            return -1;
>          }
>      }
>  
>      return 0;
> -
> -fail:
> -    return -1;

... if there is nothing to cleanup here.

cheers,
  Gerd
