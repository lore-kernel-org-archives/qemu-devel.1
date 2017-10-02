Received: from eggs.gnu.org ([2001:4830:134:3::10]:43180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dywP0-000643-SX
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dywOx-0002XK-Ns
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:48:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dywOx-0002Wt-Ex
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 04:48:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39A5F13A5D
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 08:48:34 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170927203225.30896-1-ehabkost@redhat.com>
	<20170927203225.30896-3-ehabkost@redhat.com>
Date: Mon, 02 Oct 2017 10:48:32 +0200
In-Reply-To: <20170927203225.30896-3-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Wed, 27 Sep 2017 17:32:25 -0300")
Message-ID: <873772q6jj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-options: Deprecate -nodefconfig
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> Since 2012 (commit ba6212d8 "Eliminate cpus-x86_64.conf file") we
> have no default config files that would be disabled using
> -nodefconfig.  Update documentation and document -nodefconfig as
> deprecated.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qemu-options.hx | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 39225ae6c3..bc52e79184 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4069,24 +4069,25 @@ output to stdout. This can be later used as input file for @code{-readconfig} op
>  ETEXI
>  DEF("nodefconfig", 0, QEMU_OPTION_nodefconfig,
>      "-nodefconfig\n"
> -    "                do not load default config files at startup\n",
> +    "                do not load default config files at startup (deprecated)\n",
>      QEMU_ARCH_ALL)

Suggest to go one step farther:

   HXCOMM Deprecated, same as -no-user-config
   DEF("nodefconfig", 0, QEMU_OPTION_nodefconfig, "", QEMU_ARCH_ALL)

If you do, STEXI ... ETEXI needs to go, too.

>  STEXI
>  @item -nodefconfig
>  @findex -nodefconfig
> -Normally QEMU loads configuration files from @var{sysconfdir} and @var{datadir} at startup.
> -The @code{-nodefconfig} option will prevent QEMU from loading any of those config files.
> +This option was used to disable loading of config files from @var{sysconfdir}
> +and @var{datadir}, but it is deprecated as QEMU doesn't load any config files
> +from @var{datadir} anymore.  To disable loading of config files from
> +@var{sysconfdir}, use @code{-no-user-config} instead.
>  ETEXI

This information needs should (also) go into appendix "Deprecated
features", as Daniel pointed out.

>  DEF("no-user-config", 0, QEMU_OPTION_nouserconfig,
>      "-no-user-config\n"
> -    "                do not load user-provided config files at startup\n",
> +    "                do not load default user-provided config files at startup\n",
>      QEMU_ARCH_ALL)
>  STEXI
>  @item -no-user-config
>  @findex -no-user-config
>  The @code{-no-user-config} option makes QEMU not load any of the user-provided
> -config files on @var{sysconfdir}, but won't make it skip the QEMU-provided config
> -files from @var{datadir}.
> +config files on @var{sysconfdir}.

s/on/in/

>  ETEXI
>  DEF("trace", HAS_ARG, QEMU_OPTION_trace,
>      "-trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
