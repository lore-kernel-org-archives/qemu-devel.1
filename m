Received: from eggs.gnu.org ([2001:4830:134:3::10]:42148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e84EX-00085v-ST
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e84EU-0007qE-Pb
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:59:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e84EU-0007j9-Fm
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:59:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D907CC0587C4
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 12:59:26 +0000 (UTC)
Date: Fri, 27 Oct 2017 13:59:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171027125920.GA2401@work-vm>
References: <20171027085548.3472-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171027085548.3472-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] net: detect errors from probing vnet hdr
 flag for TAP devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

* Daniel P. Berrange (berrange@redhat.com) wrote:
> When QEMU sets up a tap based network device backend, it mostly ignores errors
> reported from various ioctl() calls it makes, assuming the TAP file descriptor
> is valid. This assumption can easily be violated when the user is passing in a
> pre-opened file descriptor. At best, the ioctls may fail with a -EBADF, but if
> the user passes in a bogus FD number that happens to clash with a FD number that
> QEMU has opened internally for another reason, a wide variety of errnos may
> result, as the TUNGETIFF ioctl number may map to a completely different command
> on a different type of file.
> 
> By ignoring all these errors, QEMU sets up a zombie network backend that will
> never pass any data. Even worse, when QEMU shuts down, or that network backend
> is hot-removed, it will close this bogus file descriptor, which could belong to
> another QEMU device backend.
> 
> There's no obvious guaranteed reliable way to detect that a FD genuinely is a
> TAP device, as opposed to a UNIX socket, or pipe, or something else. Checking
> the errno from probing vnet hdr flag though, does catch the big common cases.
> ie calling TUNGETIFF will return EBADF for an invalid FD, and ENOTTY when FD is
> a UNIX socket, or pipe which catches accidental collisions with FDs used for
> stdio, or monitor socket.
> 
> Previously the example below where bogus fd 9 collides with the FD used for the
> chardev saw:
> 
> $ ./x86_64-softmmu/qemu-system-x86_64 -netdev tap,id=hostnet0,fd=9 \
>   -chardev socket,id=charchannel0,path=/tmp/qga,server,nowait \
>   -monitor stdio -vnc :0
> qemu-system-x86_64: -netdev tap,id=hostnet0,fd=9: TUNGETIFF ioctl() failed: Inappropriate ioctl for device
> TUNSETOFFLOAD ioctl() failed: Bad address
> QEMU 2.9.1 monitor - type 'help' for more information
> (qemu) Warning: netdev hostnet0 has no peer
> 
> which gives a running QEMU with a zombie network backend.
> 
> With this change applied we get an error message and QEMU immediately exits
> before carrying on and making a bigger disaster:

Right, that does make a better error so;

Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Is there anyway we could get that error before the -chardev goes and
allocates the fd 9?

Dave


> 
> $ ./x86_64-softmmu/qemu-system-x86_64 -netdev tap,id=hostnet0,fd=9 \
>   -chardev socket,id=charchannel0,path=/tmp/qga,server,nowait \
>   -monitor stdio -vnc :0
> qemu-system-x86_64: -netdev tap,id=hostnet0,vhost=on,fd=9: Unable to query TUNGETIFF on FD 9: Inappropriate ioctl for device
> 
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  net/tap-bsd.c     |  2 +-
>  net/tap-linux.c   | 12 +++++++++---
>  net/tap-solaris.c |  2 +-
>  net/tap-stub.c    |  2 +-
>  net/tap.c         | 25 ++++++++++++++++++++-----
>  net/tap_int.h     |  2 +-
>  6 files changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/net/tap-bsd.c b/net/tap-bsd.c
> index 6c9692263d..4f1d633b08 100644
> --- a/net/tap-bsd.c
> +++ b/net/tap-bsd.c
> @@ -211,7 +211,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
>  {
>  }
>  
> -int tap_probe_vnet_hdr(int fd)
> +int tap_probe_vnet_hdr(int fd, Error **errp)
>  {
>      return 0;
>  }
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index 535b1ddb61..de74928407 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -147,13 +147,19 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
>      }
>  }
>  
> -int tap_probe_vnet_hdr(int fd)
> +int tap_probe_vnet_hdr(int fd, Error **errp)
>  {
>      struct ifreq ifr;
>  
>      if (ioctl(fd, TUNGETIFF, &ifr) != 0) {
> -        error_report("TUNGETIFF ioctl() failed: %s", strerror(errno));
> -        return 0;
> +        /* Kernel pre-dates TUNGETIFF support */
> +        if (errno == -EINVAL) {
> +            return 0;
> +        } else {
> +            error_setg_errno(errp, errno,
> +                             "Unable to query TUNGETIFF on FD %d", fd);
> +            return -1;
> +        }
>      }
>  
>      return ifr.ifr_flags & IFF_VNET_HDR;
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index a2a92356c1..3437838a92 100644
> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -206,7 +206,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
>  {
>  }
>  
> -int tap_probe_vnet_hdr(int fd)
> +int tap_probe_vnet_hdr(int fd, Error **errp)
>  {
>      return 0;
>  }
> diff --git a/net/tap-stub.c b/net/tap-stub.c
> index a9ab8f8293..de525a2e69 100644
> --- a/net/tap-stub.c
> +++ b/net/tap-stub.c
> @@ -37,7 +37,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp)
>  {
>  }
>  
> -int tap_probe_vnet_hdr(int fd)
> +int tap_probe_vnet_hdr(int fd, Error **errp)
>  {
>      return 0;
>  }
> diff --git a/net/tap.c b/net/tap.c
> index 979e622e60..763fd2d9b2 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -592,7 +592,11 @@ int net_init_bridge(const Netdev *netdev, const char *name,
>      }
>  
>      fcntl(fd, F_SETFL, O_NONBLOCK);
> -    vnet_hdr = tap_probe_vnet_hdr(fd);
> +    vnet_hdr = tap_probe_vnet_hdr(fd, errp);
> +    if (vnet_hdr < 0) {
> +        close(fd);
> +        return -1;
> +    }
>      s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
>  
>      snprintf(s->nc.info_str, sizeof(s->nc.info_str), "helper=%s,br=%s", helper,
> @@ -779,7 +783,11 @@ int net_init_tap(const Netdev *netdev, const char *name,
>  
>          fcntl(fd, F_SETFL, O_NONBLOCK);
>  
> -        vnet_hdr = tap_probe_vnet_hdr(fd);
> +        vnet_hdr = tap_probe_vnet_hdr(fd, errp);
> +        if (vnet_hdr < 0) {
> +            close(fd);
> +            return -1;
> +        }
>  
>          net_init_tap_one(tap, peer, "tap", name, NULL,
>                           script, downscript,
> @@ -825,8 +833,11 @@ int net_init_tap(const Netdev *netdev, const char *name,
>              fcntl(fd, F_SETFL, O_NONBLOCK);
>  
>              if (i == 0) {
> -                vnet_hdr = tap_probe_vnet_hdr(fd);
> -            } else if (vnet_hdr != tap_probe_vnet_hdr(fd)) {
> +                vnet_hdr = tap_probe_vnet_hdr(fd, errp);
> +                if (vnet_hdr < 0) {
> +                    goto free_fail;
> +                }
> +            } else if (vnet_hdr != tap_probe_vnet_hdr(fd, NULL)) {
>                  error_setg(errp,
>                             "vnet_hdr not consistent across given tap fds");
>                  goto free_fail;
> @@ -870,7 +881,11 @@ free_fail:
>          }
>  
>          fcntl(fd, F_SETFL, O_NONBLOCK);
> -        vnet_hdr = tap_probe_vnet_hdr(fd);
> +        vnet_hdr = tap_probe_vnet_hdr(fd, errp);
> +        if (vnet_hdr < 0) {
> +            close(fd);
> +            return -1;
> +        }
>  
>          net_init_tap_one(tap, peer, "bridge", name, ifname,
>                           script, downscript, vhostfdname,
> diff --git a/net/tap_int.h b/net/tap_int.h
> index ae6888f74a..0d13768615 100644
> --- a/net/tap_int.h
> +++ b/net/tap_int.h
> @@ -35,7 +35,7 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
>  ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
>  
>  void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
> -int tap_probe_vnet_hdr(int fd);
> +int tap_probe_vnet_hdr(int fd, Error **errp);
>  int tap_probe_vnet_hdr_len(int fd, int len);
>  int tap_probe_has_ufo(int fd);
>  void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo);
> -- 
> 2.13.6
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
