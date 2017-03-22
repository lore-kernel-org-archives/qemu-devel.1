Received: from eggs.gnu.org ([2001:4830:134:3::10]:49050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqZyb-00046O-HT
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 02:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqZyX-00082G-Es
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 02:42:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170322023820.10772-1-eblake@redhat.com>
	<20170322023820.10772-3-eblake@redhat.com>
Date: Wed, 22 Mar 2017 07:42:24 +0100
In-Reply-To: <20170322023820.10772-3-eblake@redhat.com> (Eric Blake's message
	of "Tue, 21 Mar 2017 21:38:19 -0500")
Message-ID: <87efxpersf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qom: Avoid unvisited
 'id'/'qom-type' in user_creatable_add_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, Andreas =?utf-8?Q?F=C3=A4?= =?utf-8?Q?rber?= <afaerber@suse.de>, qemu-stable@nongnu.org, Eduardo Otubo <eduardo.otubo@profitbricks.com>, David Alan Gilbert <dgilbert@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> A regression in commit 15c2f669e caused us to silently ignore
> excess input to the QemuOpts visitor.  Later, commit ea4641
> accidentally abused that situation, by removing "qom-type" and
> "id" from the corresponding QDict but leaving them defined in
> the QemuOpts, when using the pair of containers to create a
> user-defined object. Note that since we are already traversing
> two separate items (a QDict and a QemuOpts), we are already
> able to flag bogus arguments, as in:
>
> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio -object memory-backend-ram,id=mem1,size=4k,bogus=huh
> qemu-system-x86_64: -object memory-backend-ram,id=mem1,size=4k,bogus=huh: Property '.bogus' not found
>
> So the only real concern is that when we re-enable strict checking
> in the QemuOpts visitor, we do not want to start flagging the two
> leftover keys as unvisited.  Rearrange the code to clean out the
> QemuOpts listing in advance, rather than removing items from the
> QDict.  Since "qom-type" is usually an automatic implicit default,
> we don't have to restore it; but "id" has to be put back (requiring
> us to cast away a const).

This is a yet another example of how actual configuration can easily
diverge from the one in QemuOpts.  Discussed recently in:

Subject: Re: [PATCH 0/2] add writeconfig command on monitor
Message-ID: <87k28qlca9.fsf@dusky.pond.sub.org>
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03476.html

Not putting "qom-type" back here is okay.  Putting it back would also be
okay.  I guess what you prefer depends on your level of OCD.

> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v2: new patch
> ---
>  qom/object_interfaces.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 03a95c3..cc9a694 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -114,7 +114,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
>      QDict *pdict;
>      Object *obj;
>      const char *id = qemu_opts_id(opts);
> -    const char *type = qemu_opt_get(opts, "qom-type");
> +    char *type = qemu_opt_get_del(opts, "qom-type");
>
>      if (!type) {
>          error_setg(errp, QERR_MISSING_PARAMETER, "qom-type");
> @@ -125,14 +125,15 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
>          return NULL;
>      }
>
> +    qemu_opts_set_id(opts, NULL);
>      pdict = qemu_opts_to_qdict(opts, NULL);
> -    qdict_del(pdict, "qom-type");
> -    qdict_del(pdict, "id");
>
>      v = opts_visitor_new(opts);
>      obj = user_creatable_add_type(type, id, pdict, v, errp);
>      visit_free(v);
>
> +    qemu_opts_set_id(opts, (char *) id);
> +    g_free(type);
>      QDECREF(pdict);
>      return obj;
>  }

Aside: I dislike how this converts QemuOpts to QDict so
user_creatable_add_type() can use the QDict to guide the visit.
Awkward, as so much code that uses QemuOpts in not entirely
straightforward ways.
