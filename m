Received: from eggs.gnu.org ([2001:4830:134:3::10]:38889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLjN5-0000gU-3f
	for qemu-devel@nongnu.org; Thu, 24 May 2018 02:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLjN0-0007jW-3R
	for qemu-devel@nongnu.org; Thu, 24 May 2018 02:05:06 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fLjMz-0007jK-U7
	for qemu-devel@nongnu.org; Thu, 24 May 2018 02:05:02 -0400
Received: by mail-pf0-f181.google.com with SMTP id w129-v6so307026pfd.3
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 23:05:01 -0700 (PDT)
References: <152646971421.34839.18198173866060880395.stgit@bahia.lan>
	<20180518153246.GE31915@stefanha-x1.localdomain>
	<20180523164610.09ec083b@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ede94233-e969-0de4-c8ee-a9ff91ce808a@redhat.com>
Date: Thu, 24 May 2018 08:04:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180523164610.09ec083b@bahia.lan>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: fix QEMU crash with scsi-hd and
 drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On 23/05/2018 16:46, Greg Kurz wrote:
> Maybe change bdrv_root_unref_child() to ensure we don't call
> bdrv_close() with pending I/O requests ?
> 
>  void bdrv_root_unref_child(BdrvChild *child)
>  {
>      BlockDriverState *child_bs;
>  
>      child_bs = child->bs;
> +    bdrv_drained_begin(child_bs);
>      bdrv_detach_child(child);
> +    bdrv_drained_end(child_bs);
>      bdrv_unref(child_bs);
>  }

Maybe bdrv_detach_child should do it.

Paolo
