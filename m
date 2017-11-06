Received: from eggs.gnu.org ([2001:4830:134:3::10]:52129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eBgWr-0000Wc-KG
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:29:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eBgWm-00019Z-RU
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:29:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eBgWm-00019A-Ih
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:29:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1507314444-30835-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507314444-30835-8-git-send-email-ian.jackson@eu.citrix.com>
Date: Mon, 06 Nov 2017 13:29:17 +0100
In-Reply-To: <1507314444-30835-8-git-send-email-ian.jackson@eu.citrix.com>
	(Ian Jackson's message of "Fri, 6 Oct 2017 19:27:23 +0100")
Message-ID: <87inenfv4y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Sorry for the slooooow response.

Ian Jackson <ian.jackson@eu.citrix.com> writes:

> This allows the caller to specify a uid and gid to use, even if there
> is no corresponding password entry.  This will be useful in certain
> Xen configurations.
>
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> ---
> v3: Error messages fixed.  Thanks to Peter Maydell and Ross Lagerwall.
> v2: Coding style fixes.
> ---
>  os-posix.c      | 49 ++++++++++++++++++++++++++++++++++++++++---------
>  qemu-options.hx | 12 ++++++++++++
>  2 files changed, 52 insertions(+), 9 deletions(-)
>
> diff --git a/os-posix.c b/os-posix.c
> index 92e9d85..6cc5868 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -43,6 +43,8 @@
>  #endif
>  
>  static struct passwd *user_pwd;
> +static uid_t user_uid = (uid_t)-1;
> +static gid_t user_gid = (gid_t)-1;
>  static const char *chroot_dir;
>  static int daemonize;
>  static int daemon_pipe;
> @@ -134,6 +136,9 @@ void os_set_proc_name(const char *s)
>   */
>  void os_parse_cmd_args(int index, const char *optarg)
>  {
> +    unsigned long lv;
> +    char *ep;
> +    int rc;
>      switch (index) {
>  #ifdef CONFIG_SLIRP
>      case QEMU_OPTION_smb:
> @@ -150,6 +155,22 @@ void os_parse_cmd_args(int index, const char *optarg)
>              exit(1);
>          }
>          break;
> +    case QEMU_OPTION_runasid:
> +        errno = 0;
> +        lv = strtoul(optarg, &ep, 0); /* can't qemu_strtoul, want *ep=='.' */

I'm afraid I can't see why qemu_strtoul() wouldn't work here.  Can you
enlighten me?

> +        user_uid = lv; /* overflow here is ID in C99 */

I don't get the comment.  You check for overflow the obvious way below.
Sure you need a comment?

> +        if (errno || *ep != '.' || user_uid != lv || user_uid == (uid_t)-1) {
> +            fprintf(stderr, "Could not obtain uid from \"%s\"", optarg);
> +            exit(1);
> +        }
> +        lv = 0;
> +        rc = qemu_strtoul(ep + 1, 0, 0, &lv);
> +        user_gid = lv; /* overflow here is ID in C99 */

Likewise.

> +        if (rc || user_gid != lv || user_gid == (gid_t)-1) {
> +            fprintf(stderr, "Could not obtain gid from \"%s\"", optarg);
> +            exit(1);
> +        }
> +        break;
>      case QEMU_OPTION_chroot:
>          chroot_dir = optarg;
>          break;
> @@ -166,18 +187,28 @@ void os_parse_cmd_args(int index, const char *optarg)
>  
>  static void change_process_uid(void)
>  {
> -    if (user_pwd) {
> -        if (setgid(user_pwd->pw_gid) < 0) {
> -            fprintf(stderr, "Failed to setgid(%d)\n", user_pwd->pw_gid);
> +    if (user_pwd || user_uid != (uid_t)-1) {
> +        gid_t intended_gid = user_pwd ? user_pwd->pw_gid : user_gid;
> +        uid_t intended_uid = user_pwd ? user_pwd->pw_uid : user_uid;
> +        if (setgid(intended_gid) < 0) {
> +            fprintf(stderr, "Failed to setgid(%d)\n", intended_gid);
>              exit(1);
>          }
> -        if (initgroups(user_pwd->pw_name, user_pwd->pw_gid) < 0) {
> -            fprintf(stderr, "Failed to initgroups(\"%s\", %d)\n",
> -                    user_pwd->pw_name, user_pwd->pw_gid);
> -            exit(1);
> +        if (user_pwd) {
> +            if (initgroups(user_pwd->pw_name, user_pwd->pw_gid) < 0) {
> +                fprintf(stderr, "Failed to initgroups(\"%s\", %d)\n",
> +                        user_pwd->pw_name, user_pwd->pw_gid);
> +                exit(1);
> +            }
> +        } else {
> +            if (setgroups(1, &user_gid) < 0) {
> +                fprintf(stderr, "Failed to setgroups(1, [%d])",
> +                        user_gid);
> +                exit(1);
> +            }
>          }
> -        if (setuid(user_pwd->pw_uid) < 0) {
> -            fprintf(stderr, "Failed to setuid(%d)\n", user_pwd->pw_uid);
> +        if (setuid(intended_uid) < 0) {
> +            fprintf(stderr, "Failed to setuid(%d)\n", intended_uid);
>              exit(1);
>          }
>          if (setuid(0) != -1) {
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9f6e2ad..34a5329 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3968,6 +3968,18 @@ Immediately before starting guest execution, drop root privileges, switching
>  to the specified user.
>  ETEXI
>  
> +#ifndef _WIN32
> +DEF("runasid", HAS_ARG, QEMU_OPTION_runasid, \
> +    "-runasid uid.gid     change to numeric uid and gid just before starting the VM\n",
> +    QEMU_ARCH_ALL)
> +#endif
> +STEXI
> +@item -runasid @var{uid}.@var{gid}

Didn't we agree on using ':' instead of '.' as separator?

Sure we need yet another option?  Why can't we compatibly extend -runas?

If we truly need both, the rationale belongs into the commit message,
and we need to consider how they interact.  I'd recommend left-to-right
semantics, i.e. if you specify both, the last one wins.  Not what your
current code does, if I read it correctly.

> +@findex -runasid
> +Immediately before starting guest execution, drop root privileges, switching
> +to the specified uid and gid.
> +ETEXI
> +
>  DEF("prom-env", HAS_ARG, QEMU_OPTION_prom_env,
>      "-prom-env variable=value\n"
>      "                set OpenBIOS nvram variables\n",
