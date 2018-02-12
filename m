Received: from eggs.gnu.org ([2001:4830:134:3::10]:37165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1elIdV-0005SA-Jf
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1elIdQ-0003Sl-SU
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:15:29 -0500
Date: Mon, 12 Feb 2018 13:15:04 -0500
From: Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <20180212131504.1243e696@redhat.com>
In-Reply-To: <1518437672-7724-4-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518437672-7724-4-git-send-email-mihajlov@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] qmp: add architecture specific cpu
 data for query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, dgilbert@redhat.com, rth@twiddle.net, cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

On Mon, 12 Feb 2018 13:14:32 +0100
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> -{ 'struct': 'CpuInfoFast',
> -  'data': {'cpu-index': 'int', 'qom-path': 'str',
> -           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }
> +{ 'union': 'CpuInfoFast',
> +  'base': {'cpu-index': 'int', 'qom-path': 'str',
> +           'thread-id': 'int', '*props': 'CpuInstanceProperties',
> +           'arch': 'CpuInfoArch' },
> +  'discriminator': 'arch',
> +  'data': { 'x86': 'CpuInfoOther',
> +            'sparc': 'CpuInfoOther',
> +            'ppc': 'CpuInfoOther',
> +            'mips': 'CpuInfoOther',
> +            'tricore': 'CpuInfoOther',
> +            's390': 'CpuInfoS390Fast',
> +            'other': 'CpuInfoOther' } }

Consider this a minor comment (and QMP maintainers can give a much
better advice than me), but I think this arch list has problems. For
one thing, it's incomplete. And the second problem is the 'other'
field. What happens when QEMU starts supporting a new arch? 'other'
becomes the new arch. Is this compatible? I don't know.

I don't know if this would work with the QAPI, but you could have
a '*arch-data' field in the CpuInfoFast definition, like:

'data': { ..., '*arch-data': 'CpuInfoFastArchData' }

where 'CpuInfoFastArchData' is defined by each arch that supports
the field. An arch supporting the field could also export a
query_cpus_fast_arch() function, which is called by qmp_query_cpus_fast().
