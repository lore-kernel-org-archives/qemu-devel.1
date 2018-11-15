Received: from eggs.gnu.org ([2001:4830:134:3::10]:39524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNHT4-0006ZJ-5Y
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNHT0-0001e9-SF
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:13:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gNHSy-0001RW-PF
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:13:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so8291937wrt.13
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 05:13:32 -0800 (PST)
References: <20181110134548.14741-1-marcandre.lureau@redhat.com>
	<20181110134548.14741-5-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <80982de0-f822-bfe3-0a08-772cad8254ac@redhat.com>
Date: Thu, 15 Nov 2018 14:13:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181110134548.14741-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 04/13] slirp: use a dedicated field
 for chardev pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On 10/11/2018 14:45, Marc-André Lureau wrote:
> Let's not mix command line and chardev pointers.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

This would probably be a good place to implement the suggestion I have
just sent.

Paolo

> ---
>  slirp/libslirp.h |  2 +-
>  slirp/misc.h     |  4 ++--
>  net/slirp.c      |  8 ++++----
>  slirp/misc.c     | 11 +++++++----
>  slirp/slirp.c    |  5 +++--
>  slirp/tcp_subr.c |  2 +-
>  6 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> index 52dbb9feb5..3e88dbaa01 100644
> --- a/slirp/libslirp.h
> +++ b/slirp/libslirp.h
> @@ -35,7 +35,7 @@ int slirp_add_hostfwd(Slirp *slirp, int is_udp,
>                        struct in_addr guest_addr, int guest_port);
>  int slirp_remove_hostfwd(Slirp *slirp, int is_udp,
>                           struct in_addr host_addr, int host_port);
> -int slirp_add_exec(Slirp *slirp, int do_pty, const void *args,
> +int slirp_add_exec(Slirp *slirp, void *chardev, const char *cmdline,
>                     struct in_addr *guest_addr, int guest_port);
>  
>  void slirp_connection_info(Slirp *slirp, Monitor *mon);
> diff --git a/slirp/misc.h b/slirp/misc.h
> index 1f8d11def6..64ca88c3b7 100644
> --- a/slirp/misc.h
> +++ b/slirp/misc.h
> @@ -9,7 +9,7 @@
>  #define MISC_H
>  
>  struct ex_list {
> -	int ex_chardev;
> +	void *ex_chardev;
>  	struct in_addr ex_addr;		/* Server address */
>  	int ex_fport;                   /* Port to telnet to */
>  	const char *ex_exec;            /* Command line of what to exec */
> @@ -52,7 +52,7 @@ struct slirp_quehead {
>  
>  void slirp_insque(void *, void *);
>  void slirp_remque(void *);
> -int add_exec(struct ex_list **, int, char *, struct in_addr, int);
> +int add_exec(struct ex_list **, void *, const char *, struct in_addr, int);
>  int fork_exec(struct socket *so, const char *ex);
>  
>  #endif
> diff --git a/net/slirp.c b/net/slirp.c
> index 1dbd34a9da..0bb12567fe 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -709,8 +709,8 @@ static int slirp_smb(SlirpState* s, const char *exported_dir,
>               CONFIG_SMBD_COMMAND, s->smb_dir, smb_conf);
>      g_free(smb_conf);
>  
> -    if (slirp_add_exec(s->slirp, 0, smb_cmdline, &vserver_addr, 139) < 0 ||
> -        slirp_add_exec(s->slirp, 0, smb_cmdline, &vserver_addr, 445) < 0) {
> +    if (slirp_add_exec(s->slirp, NULL, smb_cmdline, &vserver_addr, 139) < 0 ||
> +        slirp_add_exec(s->slirp, NULL, smb_cmdline, &vserver_addr, 445) < 0) {
>          slirp_smb_cleanup(s);
>          g_free(smb_cmdline);
>          error_setg(errp, "Conflicting/invalid smbserver address");
> @@ -774,7 +774,7 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str, Error **errp)
>      snprintf(buf, sizeof(buf), "guestfwd.tcp.%d", port);
>  
>      if ((strlen(p) > 4) && !strncmp(p, "cmd:", 4)) {
> -        if (slirp_add_exec(s->slirp, 0, &p[4], &server, port) < 0) {
> +        if (slirp_add_exec(s->slirp, NULL, &p[4], &server, port) < 0) {
>              error_setg(errp, "Conflicting/invalid host:port in guest "
>                         "forwarding rule '%s'", config_str);
>              return -1;
> @@ -801,7 +801,7 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str, Error **errp)
>              return -1;
>          }
>  
> -        if (slirp_add_exec(s->slirp, 3, &fwd->hd, &server, port) < 0) {
> +        if (slirp_add_exec(s->slirp, &fwd->hd, NULL, &server, port) < 0) {
>              error_setg(errp, "Conflicting/invalid host:port in guest "
>                         "forwarding rule '%s'", config_str);
>              g_free(fwd);
> diff --git a/slirp/misc.c b/slirp/misc.c
> index aa3c4b9771..1e9415e729 100644
> --- a/slirp/misc.c
> +++ b/slirp/misc.c
> @@ -37,7 +37,7 @@ remque(void *a)
>    element->qh_rlink = NULL;
>  }
>  
> -int add_exec(struct ex_list **ex_ptr, int do_pty, char *exec,
> +int add_exec(struct ex_list **ex_ptr, void *chardev, const char *cmdline,
>               struct in_addr addr, int port)
>  {
>  	struct ex_list *tmp_ptr;
> @@ -50,11 +50,14 @@ int add_exec(struct ex_list **ex_ptr, int do_pty, char *exec,
>  	}
>  
>  	tmp_ptr = *ex_ptr;
> -	*ex_ptr = g_new(struct ex_list, 1);
> +	*ex_ptr = g_new0(struct ex_list, 1);
>  	(*ex_ptr)->ex_fport = port;
>  	(*ex_ptr)->ex_addr = addr;
> -	(*ex_ptr)->ex_chardev = do_pty == 3;
> -	(*ex_ptr)->ex_exec = (do_pty == 3) ? exec : g_strdup(exec);
> +	if (chardev) {
> +		(*ex_ptr)->ex_chardev = chardev;
> +	} else {
> +		(*ex_ptr)->ex_exec = g_strdup(cmdline);
> +	}
>  	(*ex_ptr)->ex_next = tmp_ptr;
>  	return 0;
>  }
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index eb468facb1..58d1ef64e9 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -1068,7 +1068,7 @@ int slirp_add_hostfwd(Slirp *slirp, int is_udp, struct in_addr host_addr,
>      return 0;
>  }
>  
> -int slirp_add_exec(Slirp *slirp, int do_pty, const void *args,
> +int slirp_add_exec(Slirp *slirp, void *chardev, const char *cmdline,
>                     struct in_addr *guest_addr, int guest_port)
>  {
>      if (!guest_addr->s_addr) {
> @@ -1081,7 +1081,8 @@ int slirp_add_exec(Slirp *slirp, int do_pty, const void *args,
>          guest_addr->s_addr == slirp->vnameserver_addr.s_addr) {
>          return -1;
>      }
> -    return add_exec(&slirp->exec_list, do_pty, (char *)args, *guest_addr,
> +
> +    return add_exec(&slirp->exec_list, chardev, cmdline, *guest_addr,
>                      htons(guest_port));
>  }
>  
> diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
> index c534b0224b..e0bf7ad070 100644
> --- a/slirp/tcp_subr.c
> +++ b/slirp/tcp_subr.c
> @@ -967,7 +967,7 @@ int tcp_ctl(struct socket *so)
>                  so->so_faddr.s_addr == ex_ptr->ex_addr.s_addr) {
>                  if (ex_ptr->ex_chardev) {
>                      so->s = -1;
> -                    so->extra = (void *)ex_ptr->ex_exec;
> +                    so->extra = ex_ptr->ex_chardev;
>                      return 1;
>                  }
>                  DEBUG_MISC((dfd, " executing %s\n", ex_ptr->ex_exec));
> 
