Received: from eggs.gnu.org ([2001:4830:134:3::10]:48473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1elKpN-0002QI-Ap
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1elKpI-0005mS-Cf
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:35:53 -0500
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518437672-7724-3-git-send-email-mihajlov@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c43ef4e7-7e51-1510-f382-47a8d4292023@redhat.com>
Date: Mon, 12 Feb 2018 21:35:28 +0100
MIME-Version: 1.0
In-Reply-To: <1518437672-7724-3-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, lcapitulino@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, dgilbert@redhat.com, rth@twiddle.net, cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

On 12.02.2018 13:14, Viktor Mihajlovski wrote:
> From: Luiz Capitulino <lcapitulino@redhat.com>
> 
> The query-cpus command has an extremely serious side effect:
> it always interrupts all running vCPUs so that they can run
> ioctl calls. This can cause a huge performance degradation for
> some workloads. And most of the information retrieved by the
> ioctl calls are not even used by query-cpus.
> 
> This commit introduces a replacement for query-cpus called
> query-cpus-fast, which has the following features:
> 
>  o Never interrupt vCPUs threads. query-cpus-fast only returns
>    vCPU information maintained by QEMU itself, which should be
>    sufficient for most management software needs
> 
>  o Make "halted" field optional: we only return it if the
>    halted state is maintained by QEMU. But this also gives
>    the option of dropping the field in the future (see below)
> 

If I'm not wrong, this comment is superseded by ...

>  o Drop irrelevant fields such as "current", "pc" and "arch"
> 
>  o Drop field "halted" since it can't be provided fast reliably
>    and is too volatile on most architectures to be really useful
> 

this comment :)

>  o Rename some fields for better clarification & proper naming
>    standard>
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

Wondering if we could tweak the old interface with a simple flag "fast =
true".


-- 

Thanks,

David / dhildenb
