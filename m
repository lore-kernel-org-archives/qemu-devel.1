Received: from eggs.gnu.org ([2001:4830:134:3::10]:44919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCRGM-0004jQ-EV
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCRGL-0006oI-IA
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:28:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gCRGL-0006mX-BG
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:28:01 -0400
References: <20181015115309.17089-1-armbru@redhat.com>
	<20181015115309.17089-9-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c9a97f7-1a86-4bc4-6127-ac05232b7a99@redhat.com>
Date: Mon, 15 Oct 2018 14:00:24 -0500
MIME-Version: 1.0
In-Reply-To: <20181015115309.17089-9-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/35] 9pfs: Fix CLI parsing crash on
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

On 10/15/18 6:52 AM, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  9p-handle.c's handle_parse_opts() does that, and then
> fails without setting an error.  Wrong.  Its caller crashes when it
> tries to report the error:
> 
>      $ qemu-system-x86_64 -nodefaults -fsdev id=foo,fsdriver=handle
>      qemu-system-x86_64: -fsdev id=foo,fsdriver=handle: warning: handle backend is deprecated
>      qemu-system-x86_64: -fsdev id=foo,fsdriver=handle: fsdev: No path specified
>      Segmentation fault (core dumped)
> 
> Screwed up when commit 91cda4e8f37 (v2.12.0) converted the function to
> Error.  Fix by calling error_setg() instead of error_report().
> 
> Fixes: 91cda4e8f372602795e3a2f4bd2e3adaf9f82255
> Cc: Greg Kurz <groug@kaod.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/9pfs/9p-handle.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
