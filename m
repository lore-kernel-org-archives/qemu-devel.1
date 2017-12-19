Received: from eggs.gnu.org ([2001:4830:134:3::10]:60751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eREtV-0003HX-NK
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eREtS-0000NY-GS
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:13:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eREtS-0000Mv-8I
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:13:02 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171218184428.15074-1-danielhb@linux.vnet.ibm.com>
	<20171218184428.15074-2-danielhb@linux.vnet.ibm.com>
Date: Tue, 19 Dec 2017 11:12:59 +0100
In-Reply-To: <20171218184428.15074-2-danielhb@linux.vnet.ibm.com> (Daniel
	Henrique Barboza's message of "Mon, 18 Dec 2017 16:44:28 -0200")
Message-ID: <87efnr81qs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qmp: marking qmp_cpu as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:

> qmp_cpu is a nop that was created a while ago in commit 755f196898
> ("qapi: Convert the cpu command") for the sake of compatibility,
> due to the existence of hmp_cpu.

The compatibility argument makes no sense to me, but it's the reason the
commit documented.

> Today, there is no need or requirement to keep it as is. QMP is
> meant to be as stateless as possible, thus any QMP command that
> needs a specific monitor CPU setup should provide it in its

s/should/must/

> arguments, instead of relying in the current QMP monitor state.
>
> This patch flags qmp_cpu as deprecated in qemu-doc.texi,
> qapi-schema.json and changes qmp_cpu body to show a deprecation
> message if used.
>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

The "deprecation message" is actually a hard error.  This is unusual.
When we deprecate an interface, we don't normally make its use fail, we
just warn.  QMP doesn't provide a good way to warn, though.

Let's compare behavior:

0. Status quo                       do nothing and succeed
1. Your patch                       fail with GenericError
2. Your patch less error_setg()     do nothing and succeed
3. Immediate removal                fail with CommandNotFound

Does the difference between 1. and 3. matter at all?  Or is it just
deprecation cargo cult?

Here's my take on it.  I'd prefer 3. Immediate removal.  I'd also be
fine with 2. Your patch less error_setg(), followed by removal after the
customary deprecation period.  1. plus later removal just doesn't make
sense to me, but it's really no big deal, so if you guys want it...

> ---
>  qapi-schema.json |  5 ++++-
>  qemu-doc.texi    | 10 ++++++++++
>  qmp.c            |  2 +-
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 18457954a8..b51b89e19b 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -1052,7 +1052,10 @@
>  #
>  # Since: 0.14.0
>  #
> -# Notes: Do not use this command.
> +# Notes: Do not use this command. It was deprecated in release 2.12.0 and will
> +#        be removed, with no replacement, at any time in the future. QMP
> +#        commands that rely on the current CPU monitor should specify it as a
> +#        parameter.
>  ##
>  { 'command': 'cpu', 'data': {'index': 'int'} }
>  
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index f7317dfc66..09e6c5046a 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2516,6 +2516,16 @@ subsystem image.
>  The ``convert -s snapshot_id_or_name'' argument is obsoleted
>  by the ``convert -l snapshot_param'' argument instead.
>  
> +@section System emulator machine protocol commands
> +
> +@subsection qmp_cpu (since 2.12.0)
> +
> +The ``qmp_cpu'' command was implemented in release 0.14.0 as a functional
> +no-op, remaining as such up to release 2.12.0 when it was deprecated and
> +flagged for future removal. No replacement will be provided: any QMP command
> +that uses the current CPU monitor should, instead, specify the CPU in its
> +parameters.
> +
>  @section System emulator human monitor commands
>  
>  @subsection host_net_add (since 2.10.0)
> diff --git a/qmp.c b/qmp.c
> index e8c303116a..d8543d713d 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -115,7 +115,7 @@ void qmp_system_powerdown(Error **erp)
>  
>  void qmp_cpu(int64_t index, Error **errp)
>  {
> -    /* Just do nothing */
> +    error_setg(errp, "qmp_cpu is deprecated, do not use this command");
>  }
>  
>  void qmp_cpu_add(int64_t id, Error **errp)
