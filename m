Received: from eggs.gnu.org ([2001:4830:134:3::10]:47360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5vkj-0008WI-6C
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5vki-0000o5-JD
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:59:41 -0400
Date: Wed, 3 May 2017 11:59:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170503145935.GN3482@thinpad.lan.raisama.net>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493816238-33120-6-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/24] numa: move source of default CPUs
 to NUMA node mapping into boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Wed, May 03, 2017 at 02:56:59PM +0200, Igor Mammedov wrote:
[...]
> @@ -378,14 +379,16 @@ void parse_numa_opts(MachineClass *mc)
>           * rule grouping VCPUs by socket so that VCPUs from the same socket
>           * would be on the same node.
>           */
> +        if (!mc->cpu_index_to_instance_props) {
> +            error_report("default CPUs to NUMA node mapping isn't supported");
> +            exit(1);
> +        }

This will make people trying to use -numa on unsupported machines
see a misleading error message: instead of telling them that the
machine doesn't support NUMA at all, the message seems to imply
that NUMA may be supported and we just don't have default NUMA node
mapping support.

Probably a more generic "NUMA is not supported by this
machine-type" message before even trying to parse -numa would be
clearer. (I don't know if another patch in this series already
does that.)

-- 
Eduardo
