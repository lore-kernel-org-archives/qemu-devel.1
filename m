Received: from eggs.gnu.org ([209.51.188.92]:42131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtbLK-0001Rb-OC
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtbLJ-0000TZ-4Y
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:55:34 -0500
Date: Tue, 12 Feb 2019 17:55:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190212165522.GH5283@localhost.localdomain>
References: <cover.1547739122.git.berto@igalia.com>
	<f112a3019e4e1dfc2de6c275edadb5fc3a58ade0.1547739122.git.berto@igalia.com>
	<20190212162806.GF5283@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212162806.GF5283@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 06/13] block: Handle child
 references in bdrv_reopen_queue()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 12.02.2019 um 17:28 hat Kevin Wolf geschrieben:
> > -        child_key_dot = g_strdup_printf("%s.", child->name);
> > -        qdict_extract_subqdict(explicit_options, NULL, child_key_dot);
> > -        qdict_extract_subqdict(options, &new_child_options, child_key_dot);
> > -        g_free(child_key_dot);
> > +        /* Check if the options contain a child reference */
> > +        if (qdict_haskey(options, child->name)) {
> > +            const char *childref = qdict_get_try_str(options, child->name);
> > +            /*
> > +             * The current child must not be reopened if the child
> > +             * reference does not point to it.
> > +             */
> > +            if (g_strcmp0(childref, child->bs->node_name)) {
> 
> This is where we would break the inheritance relationship.

Oops, correcting myself: It's not. We may only do that in the commit
stage, of course.

Kevin
