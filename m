Received: from eggs.gnu.org ([2001:4830:134:3::10]:54116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eQt9P-0000Z9-HB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eQt9L-0008Mr-I2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:00:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eQt9L-0008Md-C9
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:59:59 -0500
Date: Mon, 18 Dec 2017 10:59:54 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171218105954.GE13493@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171218105318.30367-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171218105318.30367-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/1] qmp: marking qmp_cpu as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com

On Mon, Dec 18, 2017 at 08:53:18AM -0200, Daniel Henrique Barboza wrote:
> qmp_cpu is a nop that was created a while ago in commit 755f196898
> ("qapi: Convert the cpu command") for the sake of compatibility,
> due to the existence of hmp_cpu.
> 
> Today, there is no need or requirement to keep it as is. QMP is
> meant to be as stateless as possible, thus any QMP command that
> needs a specific monitor CPU setup should provide it in its
> arguments, instead of relying in the current QMP monitor state.
> 
> This patch flags qmp_cpu as deprecated in qemu-doc.texi and changes
> qmp_cpu body to show a deprecation message if used.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
> Although I've changed the behavior of qmp_cpu to return an error
> instead of doing nothing, no errors were found in the Travis
> build of the patch. Code inspection confirms that qmp_cpu isn't
> being used in QEMU.
> 
> A quick inspection in Libvirt code shows that there is no reference
> to 'qmp_cpu' there either, but to be sure I've CCed Daniel here
> so he can comment/confirm if Libvirt does not care for this change.
> 
>  qemu-doc.texi | 6 ++++++
>  qmp.c         | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index f7317dfc66..2b63f9a325 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2516,6 +2516,12 @@ subsystem image.
>  The ``convert -s snapshot_id_or_name'' argument is obsoleted
>  by the ``convert -l snapshot_param'' argument instead.
>  
> +@section System emulator machine protocol commands
> +
> +@subsection qmp_cpu (since 2.12.0)
> +
> +The ``qmp_cpu'' command is deprecated. Do not use this command.

Just saying it is deprecated doesn't add any useful info, rather
explain why it is deprecated & what (if anything) to use instead.
e.g.

  The ``qmp_cpu'' command is a functional no-op. There is no reason
  to invoke this command and it will be removed with no replacement.

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

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
