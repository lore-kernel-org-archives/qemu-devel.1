Received: from eggs.gnu.org ([2001:4830:134:3::10]:34360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv08H-0004DY-Rv
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cv08E-0001VU-1O
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:26:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cv08D-0001UN-Rc
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:26:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B31F62E6043
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 11:26:42 +0000 (UTC)
Date: Mon, 3 Apr 2017 12:26:34 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170403112634.GP2768@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1490268208-23368-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1490268208-23368-1-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] sockets: Fix
 socket_address_to_string() hostname truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com

On Thu, Mar 23, 2017 at 12:23:28PM +0100, Markus Armbruster wrote:
> We first snprintf() to a fixed buffer, then g_strdup() the result
> *boggle*.
> 
> Worse, the size of the fixed buffer INET6_ADDRSTRLEN + 5 + 4 is bogus:
> the 4 correctly accounts for '[', ']', ':' and '\0', but
> INET6_ADDRSTRLEN is not a suitable limit for inet->host, and 5 is not
> one for inet->port!  They are for host and port in *numeric* form
> (exploiting that INET6_ADDRSTRLEN > INET_ADDRSTRLEN), but inet->host
> can also be a hostname, and inet->port can be a service name, to be
> resolved with getaddrinfo().
> 
> Fortunately, the only user so far is the "socket" network backend's
> net_socket_connected(), which uses it to initialize a NetSocketState's
> info_str[].  info_str[] has considerable more space: 256 instead of
> 55.  So the bug's impact appears to be limited to truncated "info
> networks" with the "socket" network backend.
> 
> The fix is obvious: use g_strdup_printf().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/qemu-sockets.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
