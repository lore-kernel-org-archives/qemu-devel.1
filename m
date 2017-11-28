Received: from eggs.gnu.org ([2001:4830:134:3::10]:45674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJiYo-0006Nn-Ke
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJiYn-0004pP-KV
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:16:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eJiYn-0004ox-Ef
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:16:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5AC06CB22
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 16:16:36 +0000 (UTC)
Date: Tue, 28 Nov 2017 18:16:32 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171128181306-mutt-send-email-mst@kernel.org>
References: <20171128133123.17372-1-vkaplans@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128133123.17372-1-vkaplans@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-user spec: Clarify policy on setting
 log_base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Victor Kaplansky <vkaplans@redhat.com>
Cc: qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>

On Tue, Nov 28, 2017 at 03:46:44PM +0200, Victor Kaplansky wrote:
> From: Victor Kaplansky <vkaplans@dell9020.localdomain>
> 
> If we allow qemu to change logging area after it was already established,
> it may require from the backend to acquire a lock on each access to
> the log_base, which has a potential quite a big performance hit.
> 
> Thus we would like to clarify in the spec, that qemu is not expected
> to resize or remap the logging area, and backend implementations
> can safely ignore subsequent requests to log_base modifications.
> 
> Signed-off-by: Victor Kaplansky <vkaplans@redhat.com>
> Suggested-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  docs/interop/vhost-user.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index 954771d0d8..7ab31e57ef 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -257,6 +257,12 @@ Where addr is the guest physical address.
>  
>  Use atomic operations, as the log may be concurrently manipulated.
>  
> +Note that master is not expected to issue more than one VHOST_USER_SET_LOG_BASE
> +request before the rings are fully stopped by the master. Thus no modifications
> +to log_base address are allowed before the rings are restated and the client
> +can ignore all subsequent VHOST_USER_SET_LOG_BASE requests after the log_base
> +address has been established.
> +

Do we actually issue VHOST_USER_SET_LOG_BASE when ring is started?

Can we put it simpler:

	master must not send VHOST_USER_SET_LOG_BASE when ring
	is started and logging of used ring writes is started.

?

>  Note that when logging modifications to the used ring (when VHOST_VRING_F_LOG
>  is set for this ring), log_guest_addr should be used to calculate the log
>  offset: the write to first byte of the used ring is logged at this offset from
> -- 
> 2.14.2
