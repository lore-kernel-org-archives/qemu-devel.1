Received: from eggs.gnu.org ([2001:4830:134:3::10]:54916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr5G6-0001zW-Dp
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr5G0-0000Jh-Dy
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:06:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170322144525.18964-1-eblake@redhat.com>
	<20170322144525.18964-3-eblake@redhat.com>
	<20170323153753.GF13825@redhat.com>
Date: Thu, 23 Mar 2017 17:06:32 +0100
In-Reply-To: <20170323153753.GF13825@redhat.com> (Richard W. M. Jones's
	message of "Thu, 23 Mar 2017 15:37:53 +0000")
Message-ID: <877f3gf053.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Possible regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, lvivier@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org, Andreas =?utf-8?Q?F?= =?utf-8?Q?=C3=A4rber?= <afaerber@suse.de>

"Richard W.M. Jones" <rjones@redhat.com> writes:

> On Wed, Mar 22, 2017 at 09:45:24AM -0500, Eric Blake wrote:
>> A regression in commit 15c2f669e caused us to silently ignore
>> excess input to the QemuOpts visitor.  Later, commit ea4641
>> accidentally abused that situation, by removing "qom-type" and
>> "id" from the corresponding QDict but leaving them defined in
>> the QemuOpts, when using the pair of containers to create a
>> user-defined object. Note that since we are already traversing
>> two separate items (a QDict and a QemuOpts), we are already
>> able to flag bogus arguments, as in:
>> 
>> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio -object memory-backend-ram,id=mem1,size=4k,bogus=huh
>> qemu-system-x86_64: -object memory-backend-ram,id=mem1,size=4k,bogus=huh: Property '.bogus' not found
>> 
>> So the only real concern is that when we re-enable strict checking
>> in the QemuOpts visitor, we do not want to start flagging the two
>> leftover keys as unvisited.  Rearrange the code to clean out the
>> QemuOpts listing in advance, rather than removing items from the
>> QDict.  Since "qom-type" is usually an automatic implicit default,
>> we don't have to restore it (this does mean that once instantiated,
>> QemuOpts is not necessarily an accurate representation of the
>> original command line - but this is not the first place to do that);
>> however "id" has to be put back (requiring us to cast away a const).
>> 
>> [As a side note, hmp_object_add() turns a QDict into a QemuOpts,
>> then calls user_creatable_add_opts() which converts QemuOpts into
>> a new QDict. There are probably a lot of wasteful conversions like
>> this, but cleaning them up is a much bigger task than the immediate
>> regression fix.]
>> 
>> CC: qemu-stable@nongnu.org
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> This commit causes a problem for libguestfs:
>
>   [02192ms] /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64 \
>   [...]
>       -object rng-random,filename=/dev/urandom,id=rng0 \
>       -device virtio-rng-pci,rng=rng0 \
>   [...]
>   qemu-system-x86_64: -object rng-random,filename=/dev/urandom,id=rng0: Parameter 'qom-type' is missing
>
> (The full log is attached).  I don't know if we should be including
> the qom-type parameter here, and if we should what it should be set to.
>
> Rich.

Does the appended patch fix it for you?


diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 9c271ad..4d03665 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -134,6 +134,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
     visit_free(v);
 
     qemu_opts_set_id(opts, (char *) id);
+    qemu_opt_set(opts, "qom-type", type, &error_abort);
     g_free(type);
     QDECREF(pdict);
     return obj;
