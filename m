Received: from eggs.gnu.org ([2001:4830:134:3::10]:47418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr9g7-0002Zo-Nq
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr9g2-00020L-S2
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:49:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cr9g2-00020G-N4
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:49:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B31E3B713
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:49:46 +0000 (UTC)
Date: Thu, 23 Mar 2017 21:49:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170323204941.GA28118@noname.redhat.com>
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-2-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490266548-22500-2-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/5] rbd: Clean up runtime_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com, eblake@redhat.com

Am 23.03.2017 um 11:55 hat Markus Armbruster geschrieben:
> runtime_opts is used for three different purposes:
> 
> * qemu_rbd_open() uses it to accept options it recognizes, such as
>   "pool" and "image".  Other .bdrv_open() methods do it similarly.
> 
> * qemu_rbd_open() accepts additional list-valued options
>   auth-supported and server, with the help of qemu_rbd_array_opts().
>   The list elements are again dictionaries.  qemu_rbd_array_opts()
>   uses runtime_opts to accept their members.  Thus, runtime_opts
>   contains recognized sub-sub-options "auth", "host", "port" in
>   addition to recognized options.  No other block driver does that.
> 
> * qemu_rbd_create() uses it to converts the QDict produced by
>   qemu_rbd_parse_filename() to QemuOpts.  No other block driver does
>   that.  The keys produced by qemu_rbd_parse_filename() are "pool",
>   "image", "snapshot", "conf", "user" and "keyvalue-pairs".
>   qemu_rbd_open() accepts these, so no additional ones here.
> 
> This is a confusing mess.  Dates back to commit 0f9d252.  First step
> to clean it up is documenting runtime_opts.desc[]:
> 
> * Reorder entries to match the QAPI schema, like we do in other block
>   drivers.
> 
> * Document why the schema's "server" and "auth-supported" aren't in
>   .desc[].
> 
> * Document why "keyvalue-pairs", "host", "port" and "auth" are in
>   .desc[], but not the schema.
> 
> * Delete "filename", because none of the three users actually uses it.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
