Received: from eggs.gnu.org ([209.51.188.92]:33686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJDLe-00083L-Hx
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJDF4-0007xT-AZ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:26:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hJDF4-0007wG-4b
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:26:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5709AC0842D4
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 08:26:57 +0000 (UTC)
Date: Wed, 24 Apr 2019 09:26:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190424082652.GC28615@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423212246.3542-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi: SupportStatusInfo struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>

On Tue, Apr 23, 2019 at 06:22:44PM -0300, Eduardo Habkost wrote:
> This struct will be used to represent support and deprecation
> status of QEMU features.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qapi/common.json | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/qapi/common.json b/qapi/common.json
> index 99d313ef3b..b59d0dc66b 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -193,3 +193,27 @@
>               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }
> +
> +##
> +# @SupportStatusInfo:
> +#
> +# Information on support status of a given feature
> +# (e.g. machine type)
> +#
> +# @deprecated: if true, the given feature is deprecated and may be removed
> +#              in future versions of QEMU according to the QEMU deprecation
> +#              policy.
> +#
> +# @status-message: Human readable message describing support status
> +#                  of the feature.
> +#
> +# @suggested-alternative: Optional.  Suggested alternative for a deprecated
> +#                         feature.  For machine types, this should be the name
> +#                         of an available machine-type.
> +#
> +# Since: 4.1
> +##
> +{ 'struct': 'SupportStatusInfo',
> +  'data': { 'deprecated': 'bool',
> +            '*status-message': 'str',
> +            '*suggested-alternative': 'str' } }

I see status-message has to be optional, since you're embedding the
struct into another struct and want deprecated==false by default.

I'd be inclined to change it to embed a pointer to the struct and
drop the deprecated field, and make both status-message and
suggested-alternative be mandatory. ie a struct  "DeprecationInfo" 
the pointer to which is NULL if not deprecated.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
