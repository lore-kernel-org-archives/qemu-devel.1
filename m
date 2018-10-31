Received: from eggs.gnu.org ([2001:4830:134:3::10]:50626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHsCo-0005F9-7x
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHsCl-0002zl-Gn
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:14:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31755)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHsCl-0002zd-A9
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:14:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EA3530C13A9
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:14:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181030123526.26415-1-kchamart@redhat.com>
	<20181030123526.26415-3-kchamart@redhat.com>
Date: Wed, 31 Oct 2018 16:14:44 +0100
In-Reply-To: <20181030123526.26415-3-kchamart@redhat.com> (Kashyap Chamarthy's
	message of "Tue, 30 Oct 2018 13:35:25 +0100")
Message-ID: <87pnvqqhaz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/3] Deprecate HMP `cpu-add`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, ehabkost@redhat.com, armbru@redhat.com, imammedo@redhat.com

Kashyap Chamarthy <kchamart@redhat.com> writes:

> Since we're deprecating the QMP `cpu-add`, let's deprecate its HMP
> equivalent, too.
>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>  hmp-commands.hx | 6 ++++--
>  hmp.c           | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index db0c681f74..ba71558c25 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1849,14 +1849,16 @@ ETEXI
>          .name       = "cpu-add",
>          .args_type  = "id:i",
>          .params     = "id",
> -        .help       = "add cpu",
> +        .help       = "add cpu (deprecated, use device_add instead)",
>          .cmd        = hmp_cpu_add,
>      },
>  
>  STEXI
>  @item cpu-add @var{id}
>  @findex cpu-add
> -Add CPU with id @var{id}
> +Add CPU with id @var{id}.  This command is deprecated, please
> ++use @code{device_add} instead. For details, refer to
> +'docs/cpu-hotplug.rst'.

File gets created only in PATCH 3.  Let's apply PATCH 3 before 1 & 2.
Perhaps the maintainer is willing to do that for you, so you don't have
to respin.

>  ETEXI
>  
>      {
> diff --git a/hmp.c b/hmp.c
> index 4975fa56b0..c3f3db7795 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2353,6 +2353,8 @@ void hmp_cpu_add(Monitor *mon, const QDict *qdict)
>      int cpuid;
>      Error *err = NULL;
>  
> +    error_report("cpu_add is deprecated, please use device_add instead");
> +
>      cpuid = qdict_get_int(qdict, "id");
>      qmp_cpu_add(cpuid, &err);
>      hmp_handle_error(mon, &err);
