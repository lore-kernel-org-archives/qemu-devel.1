Received: from eggs.gnu.org ([2001:4830:134:3::10]:52184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFe7u-0003kK-7b
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFe7r-0001bK-3m
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:11:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFe7q-0001b2-UE
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:11:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D81D3C049D5B
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 10:11:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495649128-10529-7-git-send-email-vyasevic@redhat.com>
	(Vladislav Yasevich's message of "Wed, 24 May 2017 14:05:22 -0400")
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-7-git-send-email-vyasevic@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 12:11:35 +0200
Message-ID: <87bmqahcx4.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 06/12] qmp: Expose qemu_announce_self as a
 qmp command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladislav Yasevich <vyasevic@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com

Vladislav Yasevich <vyasevic@redhat.com> wrote:
> Add a qmp command that can trigger guest announcements.
>
> Based on work of Germano Veit Michel <germano@redhat.com>
>
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
> ---
>  migration/savevm.c | 14 ++++++++++++++
>  qapi-schema.json   | 19 +++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index a4097c9..b55ce6a 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -265,6 +265,20 @@ void qemu_announce_self(AnnounceParameters *params)
>      qemu_announce_self_once(timer);
>  }
>  
> +void qmp_announce_self(bool has_params, AnnounceParameters *params,
> +                       Error **errp)
> +{
> +    AnnounceParameters announce_params;
> +
> +    memcpy(&announce_params, qemu_get_announce_params(),
> +           sizeof(announce_params));
> +
> +    if (has_params)
> +        qemu_set_announce_parameters(&announce_params, params);
> +
> +    qemu_announce_self(&announce_params);

Are I missreading qemu_annouce_self()?
My reading is that it passes announce_params to a timer (i.e. async
function), but here announce_params is a local variable here, no?
