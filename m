Received: from eggs.gnu.org ([2001:4830:134:3::10]:35665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eung3-0007qz-ER
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 18:13:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eung0-0005vQ-8k
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 18:13:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49346 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eung0-0005vG-48
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 18:13:20 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-7-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ca4d08d-44ea-75c4-f13f-0b1a3dfb1e03@redhat.com>
Date: Sat, 10 Mar 2018 17:13:10 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-7-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 06/23] monitor: move the cur_mon hack
 deeper for QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/09/2018 02:59 AM, Peter Xu wrote:
> In monitor_qmp_read(), we have the hack to temporarily replace the
> cur_mon pointer.  Now we move this hack deeper inside the QMP dispatcher
> routine since the Monitor pointer can be actually obtained using
> container_of() upon the parser object, just like most of the other JSON
> parser users do.
> 
> This does not make much sense as a single patch.  However, this will be
> a big step for the next patch, when the QMP dispatcher routine will be
> split from the QMP parser.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   monitor.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 

>   
> +    cur_mon = old_mon;
> +
>       if (mon->qmp.commands == &qmp_cap_negotiation_commands) {
>           qdict = qdict_get_qdict(qobject_to_qdict(rsp), "error");

More conflict fun with the qobject_to() series.  Sadly, 'git am -3' had 
a tough time, even though the conflict was only in the context, but I 
managed to get it all sorted out.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
