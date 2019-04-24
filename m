Received: from eggs.gnu.org ([209.51.188.92]:33686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJDLa-00083L-1U
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJDGT-0000zu-A8
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:28:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hJDGT-0000z0-1q
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:28:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4078F3145729
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 08:28:24 +0000 (UTC)
Date: Wed, 24 Apr 2019 09:28:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190424082816.GD28615@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423212246.3542-4-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qmp: Add deprecation information to
 query-machines
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

On Tue, Apr 23, 2019 at 06:22:46PM -0300, Eduardo Habkost wrote:
> Export machine type deprecation information through the
> query-machines QMP command.  With this, libvirt and management
> software will be able to show this information to users and/or
> suggest changes to VM configuration to avoid deprecated machines.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qapi/misc.json                     |  5 ++++-
>  vl.c                               |  6 ++++++
>  tests/acceptance/query_machines.py | 27 +++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
>  create mode 100644 tests/acceptance/query_machines.py
> 
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 8b3ca4fdd3..941d251d17 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2018,12 +2018,15 @@
>  #
>  # @hotpluggable-cpus: cpu hotplug via -device is supported (since 2.7.0)
>  #
> +# @support-status: Support/deprecation status information (since 4.1.0)
> +#
>  # Since: 1.2.0
>  ##
>  { 'struct': 'MachineInfo',
>    'data': { 'name': 'str', '*alias': 'str',
>              '*is-default': 'bool', 'cpu-max': 'int',
> -            'hotpluggable-cpus': 'bool'} }
> +            'hotpluggable-cpus': 'bool',
> +            'support-status': 'SupportStatusInfo' } }

With my comment on the first patch this would become

    "deprecation-info": "*DeprecationInfo"

> diff --git a/vl.c b/vl.c
> index 99b857ed2a..ca23d2a404 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1530,6 +1530,12 @@ MachineInfoList *qmp_query_machines(Error **errp)
>          info->name = g_strdup(mc->name);
>          info->cpu_max = !mc->max_cpus ? 1 : mc->max_cpus;
>          info->hotpluggable_cpus = mc->has_hotpluggable_cpus;
> +        assert(!mc->support_status.status_message ||
> +               mc->support_status.has_status_message);
> +        assert(!mc->support_status.suggested_alternative ||
> +               mc->support_status.has_suggested_alternative);
> +        info->support_status =
> +            QAPI_CLONE(SupportStatusInfo, &mc->support_status);
>  
>          entry = g_malloc0(sizeof(*entry));
>          entry->value = info;
> diff --git a/tests/acceptance/query_machines.py b/tests/acceptance/query_machines.py
> new file mode 100644
> index 0000000000..23a56ea617
> --- /dev/null
> +++ b/tests/acceptance/query_machines.py
> @@ -0,0 +1,27 @@
> +# Sanity check query-machines QMP command results
> +#
> +# Copyright (c) 2019 Red Hat, Inc.
> +#
> +# Author:
> +#  Eduardo Habkost <ehabkost@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from avocado_qemu import Test
> +
> +class QueryMachines(Test):
> +    def test(self):
> +        self.vm.launch()
> +        machines = self.vm.command('query-machines')
> +        machinesdict = dict((m['name'], m) for m in machines)
> +        machinesdict.update((m['alias'], m) for m in machines if 'alias' in m)
> +        for machine in machines:
> +            status = machine['support-status']
> +            if status['deprecated']:
> +                self.assertTrue(status.get('status-message') or \
> +                                status.get('suggested-alternative'),
> +                                "Deprecated machine (%s) must have status-message or suggested-alternative" % (machine['name']))
> +            if 'suggested-alternative' in status:
> +                self.assertTrue(status['suggested-alternative'] in machinesdict,
> +                                "suggested-alternative of %s must point to a valid machine type" % (machine['name']))
> -- 
> 2.18.0.rc1.1.g3f1ff2140
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
