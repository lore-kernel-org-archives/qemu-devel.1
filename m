Received: from eggs.gnu.org ([2001:4830:134:3::10]:43976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g6uVM-0004Pj-Fi
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g6uVC-0000Fq-PC
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:28:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g6uV8-0000Ap-Qj
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:28:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1AA530014C2
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 09:28:19 +0000 (UTC)
References: <20180925160248.30801-1-kchamart@redhat.com>
	<20180925160248.30801-2-kchamart@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <07ccc2c0-10e2-3456-3124-5aa2d87158f0@redhat.com>
Date: Mon, 1 Oct 2018 11:28:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180925160248.30801-2-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Deprecate QMP `cpu-add`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, armbru@redhat.com, ehabkost@redhat.com

On 2018-09-25 18:02, Kashyap Chamarthy wrote:
> The intended functionality of QMP `cpu-add` is replaced with
> `device_add` (and `query-hotpluggable-cpus`).  So let's deprecate
> `cpu-add`.
> 
> A complete example of vCPU hotplug with the recommended way (using
> `device_add`) is provided as part of a seperate docs patch.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
> ---
>  qapi/misc.json       | 8 +++++++-
>  qemu-deprecated.texi | 5 +++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/misc.json b/qapi/misc.json
> index d450cfef21..6479b8f8a6 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1104,7 +1104,11 @@
>  ##
>  # @cpu-add:
>  #
> -# Adds CPU with specified ID
> +# Adds CPU with specified ID.
> +#
> +# Notes: This command is deprecated.  The `device_add` command should be

s/Notes/Note/ ?

> +#        used instead.  See the `query-hotpluggable-cpus` command for
> +#        details.
>  #
>  # @id: ID of CPU to be created, valid values [0..max_cpus)
>  #
> @@ -3213,6 +3217,8 @@
>  ##
>  # @query-hotpluggable-cpus:
>  #
> +# TODO: Better documentation; currently there is none.
> +#
>  # Returns: a list of HotpluggableCPU objects.
>  #
>  # Since: 2.7
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 1b9c007f12..c86924ad9a 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -155,6 +155,11 @@ The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
>  The ``arch'' output member of the ``query-cpus-fast'' command is
>  replaced by the ``target'' output member.
>  
> +@subsection cpu-add (since 3.1)
> +
> +Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
> +documentation of ``query-hotpluggable-cpus'' for additional details.
> +
>  @section System emulator devices
>  
>  @subsection ivshmem (since 2.6.0)
> 

Do you plan to keep the "cpu-add" HMP command? hmp_cpu_add() currently
is only a wrapper for qmp_cpu_add(), so if you plan to get rid of the
QMP command, it might make sense to deprecate the HMP command in the
same breath, too.

 Thomas
