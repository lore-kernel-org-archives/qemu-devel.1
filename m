Received: from eggs.gnu.org ([2001:4830:134:3::10]:51858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1coYoo-00038x-IG
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1coYok-0000rS-ED
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:04:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1coYok-0000rI-8g
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:04:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CE093DBE6
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 17:04:02 +0000 (UTC)
Date: Thu, 16 Mar 2017 17:03:58 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170316170358.GS30978@redhat.com>
References: <20170316163640.5597-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170316163640.5597-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-ga: obey LISTEN_PID when using
 systemd socket activation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Mar 16, 2017 at 05:36:40PM +0100, Paolo Bonzini wrote:
> qemu-ga's socket activation support was not obeying the LISTEN_PID
> environment variable, which avoids that a process uses a socket-activation
> file descriptor meant for its parent.
> 
> Mess can for example ensue if a process forks a children before consuming
> the socket-activation file descriptor and therefore setting O_CLOEXEC
> on it.
> 
> Luckily, qemu-nbd also got socket activation code, and its copy does
> support LISTEN_PID.  Some extra fixups are needed to ensure that the
> code can be used for both, but that's what this patch does.  The
> main change is to replace get_listen_fds's "consume" argument with
> the FIRST_SOCKET_ACTIVATION_FD macro from the qemu-nbd code.
> 
> @@ -1388,7 +1363,7 @@ int main(int argc, char **argv)
>          config->method = NULL;
>          config->channel_path = NULL;
>  
> -        addr = socket_local_address(listen_fd, NULL);
> +        addr = socket_local_address(FIRST_SOCKET_ACTIVATION_FD , NULL);

There's an extra space before the comma here.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
