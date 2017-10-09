Received: from eggs.gnu.org ([2001:4830:134:3::10]:40206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1Qtx-0003jj-6Q
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 01:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e1Qtu-0001VB-2w
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 01:46:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1e1Qtt-0001Uh-RN
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 01:46:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507133891-26013-8-git-send-email-ian.jackson@eu.citrix.com>
Date: Mon, 09 Oct 2017 07:46:45 +0200
In-Reply-To: <1507133891-26013-8-git-send-email-ian.jackson@eu.citrix.com>
	(Ian Jackson's message of "Wed, 4 Oct 2017 17:18:10 +0100")
Message-ID: <877ew4ub3u.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, xen-devel@nongnu.org

Ian Jackson <ian.jackson@eu.citrix.com> writes:

> This allows the caller to specify a uid and gid to use, even if there
> is no corresponding password entry.  This will be useful in certain
> Xen configurations.
>
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
[...]
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
> +@findex -runasid
> +Immediately before starting guest execution, drop root privileges, switching
> +to the specified uid and gid.
> +ETEXI
> +
>  DEF("prom-env", HAS_ARG, QEMU_OPTION_prom_env,
>      "-prom-env variable=value\n"
>      "                set OpenBIOS nvram variables\n",

The last thing the QEMU command line needs is more exotic options.  Are
you sure we need a new one here?  Can we make existing -runas serve?
Precedence: Coreutils[*].  Pseudo-code:

    if argument is a decimal number starting with '+':
        user ID
    else if argument is a valid user name:
        user name
    else if argument is a valid user ID:
        user ID
    else:
        error

[*] https://www.gnu.org/software/coreutils/manual/html_node/Disambiguating-names-and-IDs.html
