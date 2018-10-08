Received: from eggs.gnu.org ([2001:4830:134:3::10]:49051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9cS7-0006Gm-Po
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9cS2-0003MD-3C
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:48:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g9cS1-0003JW-9F
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:48:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7944E31649BD
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 20:48:20 +0000 (UTC)
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-31-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6913910d-f406-6e8b-bf5d-327754491fa8@redhat.com>
Date: Mon, 8 Oct 2018 15:48:10 -0500
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-31-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 30/31] blockdev: Convert drive_new() to
 Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 10/8/18 12:31 PM, Markus Armbruster wrote:
> Calling error_report() from within a a function that takes an Error **

s/a a/a/

> argument is suspicious.  drive_new() does that, and its caller
> drive_init_func() then exit()s.  Its caller main(), via
> qemu_opts_foreach(), is fine with it, but clean it up anyway:
> 
> * Convert drive_new() to Error
> 
> * Update add_init_drive() to report the error received from
>    drive_new().
> 
> * Make main() pass &error_fatal through qemu_opts_foreach(),
>    drive_init_func() to drive_new()
> 
> * Make default_drive() pass &error_abort through qemu_opts_foreach(),
>    drive_init_func() to drive_new()
> 
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   blockdev.c                | 27 ++++++++++++++-------------
>   device-hotplug.c          |  5 ++++-
>   include/sysemu/blockdev.h |  3 ++-
>   vl.c                      | 11 ++++-------
>   4 files changed, 24 insertions(+), 22 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
