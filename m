Received: from eggs.gnu.org ([2001:4830:134:3::10]:58898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBxom-0005ii-C4
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBxoi-0001wq-40
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:29:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48584 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fBxoh-0001wS-WC
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:29:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9996240252F3
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 07:29:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180426183404.3756-1-lersek@redhat.com>
	<20180426183404.3756-5-lersek@redhat.com>
Date: Fri, 27 Apr 2018 09:29:14 +0200
In-Reply-To: <20180426183404.3756-5-lersek@redhat.com> (Laszlo Ersek's message
	of "Thu, 26 Apr 2018 20:34:04 +0200")
Message-ID: <87vacdt8dx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/4] qapi: discriminate CpuInfoFast on
 SysEmuTarget, not CpuInfoArch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>

Laszlo Ersek <lersek@redhat.com> writes:

> Add a new field @target (of type @SysEmuTarget) to the output of the
> @query-cpus-fast command, which provides more information about the
> emulation target than the field @arch (of type @CpuInfoArch). Make @target
> the new discriminator for the @CpuInfoFast return structure. Keep @arch
> for compatibility.
>
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>
> Notes:
>     PATCHv2:
>     
>     - drop patch v1 5/6 with the CpuInfoCommon refactoring / extraction, as
>       @CpuInfo / @query-cpus are deprecated [Eric, Markus]
>     
>     - for the same reason, add @target to @CpuInfoFast / @query-cpus-fast
>       only [Eric, Markus]
>     
>     - Can't set @arch compatibly from a QAPI enum lookup of the proposed
>       TARGET_BASE_ARCH macro, because TARGET_BASE_ARCH=s390x is not
>       identical to the @s390 @CpuInfoArch constant -- see more at
>       <http://mid.mail-archive.com/f0c9c7ca-3dcf-4f74-9812-5dea5b6376cd@redhat.com>.
>       Keep sysemu_target_to_cpuinfo_arch() instead. [Markus, Eric]
>     
>     - update CC list
>     
>     PATCHv1:
>     
>     - new patch
>
>  qapi/misc.json | 63 ++++++++++++++++++++++++++++++++----------
>  cpus.c         | 87 ++++++++++++++++++++++++++++++++++++++++++----------------
>  2 files changed, 111 insertions(+), 39 deletions(-)
>
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 460866cf542f..74e5c2e3b8f7 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -550,41 +550,72 @@
>  # Information about a virtual CPU
>  #
>  # @cpu-index: index of the virtual CPU
>  #
>  # @qom-path: path to the CPU object in the QOM tree
>  #
>  # @thread-id: ID of the underlying host thread
>  #
>  # @props: properties describing to which node/socket/core/thread
>  #         virtual CPU belongs to, provided if supported by board
>  #
> -# @arch: architecture of the cpu, which determines which additional fields
> -#        will be listed
> +# @arch: base architecture of the cpu

Let's deprecate this misbegotten enumeration, as I proposed in
Message-ID: <87bme5uolc.fsf@dusky.pond.sub.org>.  Could be done as a
follow-up patch.

> +#
> +# @target: the QEMU system emulation target, which is more specific than
> +#          @arch and determines which additional fields will be listed
> +#          (since 2.13)
> +#

May want to drop "is more specific than @arch and" then.

>  #
>  # Since: 2.12
>  #
>  ##
[...]

In case we decide not to deprecate @arch right away:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
