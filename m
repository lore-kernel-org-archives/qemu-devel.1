Received: from eggs.gnu.org ([209.51.188.92]:56922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJflt-0006j0-0J
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJflr-0003Mo-Oy
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:54:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hJflr-0003Ke-GF
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:54:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC21D7C852
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 14:54:42 +0000 (UTC)
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-4-ehabkost@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <a1529434-54e0-0d2e-4275-1c6080c1cffe@redhat.com>
Date: Thu, 25 Apr 2019 11:54:34 -0300
MIME-Version: 1.0
In-Reply-To: <20190423212246.3542-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>

Hi Eduardo,

On 04/23/2019 06:22 PM, Eduardo Habkost wrote:
> Export machine type deprecation information through the
> query-machines QMP command.  With this, libvirt and management
> software will be able to show this information to users and/or
> suggest changes to VM configuration to avoid deprecated machines.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   qapi/misc.json                     |  5 ++++-
>   vl.c                               |  6 ++++++
>   tests/acceptance/query_machines.py | 27 +++++++++++++++++++++++++++
>   3 files changed, 37 insertions(+), 1 deletion(-)
>   create mode 100644 tests/acceptance/query_machines.py
>
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 8b3ca4fdd3..941d251d17 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2018,12 +2018,15 @@
>   #
>   # @hotpluggable-cpus: cpu hotplug via -device is supported (since 2.7.0)
>   #
> +# @support-status: Support/deprecation status information (since 4.1.0)
> +#
>   # Since: 1.2.0
>   ##
>   { 'struct': 'MachineInfo',
>     'data': { 'name': 'str', '*alias': 'str',
>               '*is-default': 'bool', 'cpu-max': 'int',
> -            'hotpluggable-cpus': 'bool'} }
> +            'hotpluggable-cpus': 'bool',
> +            'support-status': 'SupportStatusInfo' } }
>   
>   ##
>   # @query-machines:
> diff --git a/vl.c b/vl.c
> index 99b857ed2a..ca23d2a404 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1530,6 +1530,12 @@ MachineInfoList *qmp_query_machines(Error **errp)
>           info->name = g_strdup(mc->name);
>           info->cpu_max = !mc->max_cpus ? 1 : mc->max_cpus;
>           info->hotpluggable_cpus = mc->has_hotpluggable_cpus;
> +        assert(!mc->support_status.status_message ||
> +               mc->support_status.has_status_message);
> +        assert(!mc->support_status.suggested_alternative ||
> +               mc->support_status.has_suggested_alternative);
> +        info->support_status =
> +            QAPI_CLONE(SupportStatusInfo, &mc->support_status);
>   
>           entry = g_malloc0(sizeof(*entry));
>           entry->value = info;
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

I suggest to use a meaning test case name as it will be displayed with 
Avocado output. Something like 'test_status_information'.

> +        self.vm.launch()
> +        machines = self.vm.command('query-machines')

Also I suggest to assert you got at least on machine, so ensure 
'query-machines' returning nothing doesn't pass unnoticed.

- Wainer

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
