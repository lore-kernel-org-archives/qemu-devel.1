Received: from eggs.gnu.org ([2001:4830:134:3::10]:41073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faI8a-0001v9-Mn
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faI8V-0002qb-QE
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:02:20 -0400
References: <c791ba035f26ea957e8f3602e3009b621769b1ba.1530611283.git.mprivozn@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc0d0005-d2bc-e466-5b99-072ddadd7110@redhat.com>
Date: Tue, 3 Jul 2018 12:01:54 +0200
MIME-Version: 1.0
In-Reply-To: <c791ba035f26ea957e8f3602e3009b621769b1ba.1530611283.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pr-helper: Rework socket path handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org

On 03/07/2018 11:51, Michal Privoznik wrote:
> When reviewing Paolo's pr-helper patches I've noticed couple of
> problems:
> 
> 1) socket_path needs to be calculated at two different places
> (one for printing out help, the other if socket activation is NOT
> used),
> 
> 2) even though the default socket_path is allocated in
> compute_default_paths() it is the only default path the function
> handles. For instance, pidfile is allocated outside of this
> function. And yet again, at different places than 1)
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>

Queued, thanks.

Paolo

> ---
>  scsi/qemu-pr-helper.c | 36 ++++++++++--------------------------
>  1 file changed, 10 insertions(+), 26 deletions(-)
> 
> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> index 0218d65bbf..59df3fd608 100644
> --- a/scsi/qemu-pr-helper.c
> +++ b/scsi/qemu-pr-helper.c
> @@ -76,14 +76,12 @@ static int gid = -1;
>  
>  static void compute_default_paths(void)
>  {
> -    if (!socket_path) {
> -        socket_path = qemu_get_local_state_pathname("run/qemu-pr-helper.sock");
> -    }
> +    socket_path = qemu_get_local_state_pathname("run/qemu-pr-helper.sock");
> +    pidfile = qemu_get_local_state_pathname("run/qemu-pr-helper.pid");
>  }
>  
>  static void usage(const char *name)
>  {
> -    compute_default_paths();
>      (printf) (
>  "Usage: %s [OPTIONS] FILE\n"
>  "Persistent Reservation helper program for QEMU\n"
> @@ -844,19 +842,6 @@ static gboolean accept_client(QIOChannel *ioc, GIOCondition cond, gpointer opaqu
>      return TRUE;
>  }
>  
> -
> -/*
> - * Check socket parameters compatibility when socket activation is used.
> - */
> -static const char *socket_activation_validate_opts(void)
> -{
> -    if (socket_path != NULL) {
> -        return "Unix socket can't be set when using socket activation";
> -    }
> -
> -    return NULL;
> -}
> -
>  static void termsig_handler(int signum)
>  {
>      atomic_cmpxchg(&state, RUNNING, TERMINATE);
> @@ -930,6 +915,7 @@ int main(int argc, char **argv)
>      char *trace_file = NULL;
>      bool daemonize = false;
>      bool pidfile_specified = false;
> +    bool socket_path_specified = false;
>      unsigned socket_activation;
>  
>      struct sigaction sa_sigterm;
> @@ -946,12 +932,14 @@ int main(int argc, char **argv)
>      qemu_add_opts(&qemu_trace_opts);
>      qemu_init_exec_dir(argv[0]);
>  
> -    pidfile = qemu_get_local_state_pathname("run/qemu-pr-helper.pid");
> +    compute_default_paths();
>  
>      while ((ch = getopt_long(argc, argv, sopt, lopt, &opt_ind)) != -1) {
>          switch (ch) {
>          case 'k':
> -            socket_path = optarg;
> +            g_free(socket_path);
> +            socket_path = g_strdup(optarg);
> +            socket_path_specified = true;
>              if (socket_path[0] != '/') {
>                  error_report("socket path must be absolute");
>                  exit(EXIT_FAILURE);
> @@ -1042,10 +1030,9 @@ int main(int argc, char **argv)
>      socket_activation = check_socket_activation();
>      if (socket_activation == 0) {
>          SocketAddress saddr;
> -        compute_default_paths();
>          saddr = (SocketAddress){
>              .type = SOCKET_ADDRESS_TYPE_UNIX,
> -            .u.q_unix.path = g_strdup(socket_path)
> +            .u.q_unix.path = socket_path,
>          };
>          server_ioc = qio_channel_socket_new();
>          if (qio_channel_socket_listen_sync(server_ioc, &saddr, &local_err) < 0) {
> @@ -1053,12 +1040,10 @@ int main(int argc, char **argv)
>              error_report_err(local_err);
>              return 1;
>          }
> -        g_free(saddr.u.q_unix.path);
>      } else {
>          /* Using socket activation - check user didn't use -p etc. */
> -        const char *err_msg = socket_activation_validate_opts();
> -        if (err_msg != NULL) {
> -            error_report("%s", err_msg);
> +        if (socket_path_specified) {
> +            error_report("Unix socket can't be set when using socket activation");
>              exit(EXIT_FAILURE);
>          }
>  
> @@ -1075,7 +1060,6 @@ int main(int argc, char **argv)
>                           error_get_pretty(local_err));
>              exit(EXIT_FAILURE);
>          }
> -        socket_path = NULL;
>      }
>  
>      if (qemu_init_main_loop(&local_err)) {
> 
