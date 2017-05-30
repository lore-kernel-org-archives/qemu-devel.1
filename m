Received: from eggs.gnu.org ([2001:4830:134:3::10]:49737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFduv-0007KL-M9
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFdur-0006e2-N0
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:58:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFdur-0006de-Db
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:58:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27D0E5D68D
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:58:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495649128-10529-2-git-send-email-vyasevic@redhat.com>
	(Vladislav Yasevich's message of "Wed, 24 May 2017 14:05:17 -0400")
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-2-git-send-email-vyasevic@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 11:58:09 +0200
Message-ID: <87poeqhdji.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 01/12] migration: Introduce announce
 parameters
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
> Add parameters that control RARP/GARP announcement timeouts.
> The parameters structure is added to the QAPI and a qmp command
> is added to set/get the parameter data.
>
> Based on work by "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>

Hi

> diff --git a/migration/savevm.c b/migration/savevm.c
> index f5e8194..cee2837 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -78,6 +78,104 @@ static struct mig_cmd_args {
>      [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
>  };
>  

Once that you are touching this, shouldn't it be better to be in
net/<somewhere>?
They have nothing to do with migration really.


> +#define QEMU_ANNOUNCE_INITIAL    50
> +#define QEMU_ANNOUNCE_MAX       550
> +#define QEMU_ANNOUNCE_ROUNDS      5
> +#define QEMU_ANNOUNCE_STEP      100
> +
> +AnnounceParameters *qemu_get_announce_params(void)
> +{
> +    static AnnounceParameters announce = {
> +        .initial = QEMU_ANNOUNCE_INITIAL,
> +        .max = QEMU_ANNOUNCE_MAX,
> +        .rounds = QEMU_ANNOUNCE_ROUNDS,
> +        .step = QEMU_ANNOUNCE_STEP,
> +    };
> +
> +    return &announce;
> +}
> +
> +void qemu_fill_announce_parameters(AnnounceParameters **to,
> +                                   AnnounceParameters *from)
> +{
> +    AnnounceParameters *params;
> +
> +    params = *to = g_malloc0(sizeof(*params));
> +    params->has_initial = true;
> +    params->initial = from->initial;
> +    params->has_max = true;
> +    params->max = from->max;
> +    params->has_rounds = true;
> +    params->rounds = from->rounds;
> +    params->has_step = true;
> +    params->step = from->step;
> +}
> +
> +bool qemu_validate_announce_parameters(AnnounceParameters *params, Error **errp)
> +{
> +    if (params->has_initial &&
> +        (params->initial < 1 || params->initial > 100000)) {

This is independent of this patch, but we really need a macro:
  CHECK(field, mininum, maximum)

We repeat this left and right.

> +void qemu_set_announce_parameters(AnnounceParameters *announce_params,
> +                                  AnnounceParameters *params)

> +void qmp_announce_set_parameters(AnnounceParameters *params, Error **errp)

Really similar functions name.  I assume by know that the 1st function
is used somewhere else in the series.
