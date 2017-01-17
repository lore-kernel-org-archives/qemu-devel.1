Received: from eggs.gnu.org ([2001:4830:134:3::10]:54993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cTS9N-0006kM-4i
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cTS9K-00029e-1w
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:42:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cTS9J-00029A-RV
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:42:01 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAACEC056790
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 11:42:01 +0000 (UTC)
Date: Tue, 17 Jan 2017 11:41:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170117114156.GE2053@work-vm>
References: <CANHSq5CmdwQUFxXGRsyWUNs-_AN19zEhXwZtj6p807Cr3Us3ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANHSq5CmdwQUFxXGRsyWUNs-_AN19zEhXwZtj6p807Cr3Us3ng@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] migration: expose qemu_announce_self() via
 qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Germano Veit Michel <germano@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, quintela@redhat.com

* Germano Veit Michel (germano@redhat.com) wrote:
> qemu_announce_self() is triggered by qemu at the end of migrations
> to update the network regarding the path to the guest l2addr.
> 
> however it is also useful when there is a network change such as
> an active bond slave swap. Essentially, it's the same as a migration
> from a network perspective - the guest moves to a different point
> in the network topology.
> 
> this exposes the function via qmp.
> 
> Signed-off-by: Germano Veit Michel <germano@redhat.com>

Hi Germano,
  I think there are a couple of problems which mean it's
not quite this simple.

   a) The 'count' variable in qemu_announce_self_once is static
    initialised; so I think qemu will only ever run the announce
    series once; so it would do it after migrate, but then I think
    if you did a qemu_announce_self again I think it would send
    one packet and then not repeat it.
    Similarly if you called qemu_announce_self from qmp twice I'm
    not sure the 2nd time would only send the one packet.

   b) The static *time in qemu_announce_self means I'm worried about
    what happens if someone was to call qmp_announce_self before the
    previous round of qmp_announce_self had finished; I think you'd
    end up with 2 timers racing on one pointer.

Dave


> ---
>  migration/savevm.c |  5 +++++
>  qapi-schema.json   | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f9c06e9..7a817dc 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -143,6 +143,11 @@ void qemu_announce_self(void)
>      qemu_announce_self_once(&timer);
>  }
> 
> +void qmp_announce_self(Error **errp)
> +{
> +    qemu_announce_self();
> +}
> +
>  /***********************************************************/
>  /* savevm/loadvm support */
> 
> diff --git a/qapi-schema.json b/qapi-schema.json
> index ce20f16..6854266 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4786,3 +4786,21 @@
>  # Since: 2.7
>  ##
>  { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
> +
> +##
> +# @announce-self:
> +#
> +# Trigger generation of broadcast RARP frames to update network switches.
> +# This can be useful when network bonds fail-over the active slave.
> +#
> +# Arguments: None.
> +#
> +# Example:
> +#
> +# -> { "execute": "announce-self" }
> +# <- { "return": {} }
> +#
> +# Since: 2.9
> +##
> +{ 'command': 'announce-self' }
> +
> -- 
> 2.9.3
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
