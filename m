Received: from eggs.gnu.org ([2001:4830:134:3::10]:41653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSlAk-0006fW-IS
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSlAi-0001d5-8m
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:25:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180611205203.2624-1-mreitz@redhat.com>
	<20180611205203.2624-2-mreitz@redhat.com>
Date: Tue, 12 Jun 2018 17:25:14 +0200
In-Reply-To: <20180611205203.2624-2-mreitz@redhat.com> (Max Reitz's message of
	"Mon, 11 Jun 2018 22:51:54 +0200")
Message-ID: <87efhct4bp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 01/10] qapi: Add default-variant for
 flat unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>

Max Reitz <mreitz@redhat.com> writes:

> This patch allows specifying a discriminator that is an optional member
> of the base struct.  In such a case, a default value must be provided
> that is used when no value is given.

Hmm.  Can you explain why you need this feature?

> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/introspect.json           |  8 +++++
>  scripts/qapi/common.py         | 57 ++++++++++++++++++++++++++++------
>  scripts/qapi/doc.py            |  8 +++--
>  scripts/qapi/introspect.py     | 10 ++++--
>  scripts/qapi/visit.py          | 13 ++++++++
>  tests/qapi-schema/test-qapi.py |  2 ++
>  6 files changed, 83 insertions(+), 15 deletions(-)

The documentation update is in the next patch, and tests are in the
patch after next.  I'd squash all three.

>
> diff --git a/qapi/introspect.json b/qapi/introspect.json
> index 80a0a3e656..b43c87fe8d 100644
> --- a/qapi/introspect.json
> +++ b/qapi/introspect.json
> @@ -168,6 +168,13 @@
>  # @tag: the name of the member serving as type tag.
>  #       An element of @members with this name must exist.
>  #
> +# @default-variant: if the @tag element of @members is optional, this
> +#                   is the default value for choosing a variant.  Its
> +#                   value will be a valid value for @tag.
> +#                   Present exactly when @tag is present and the
> +#                   associated element of @members is optional.
> +#                   (Since: 3.0)
> +#
>  # @variants: variant members, i.e. additional members that
>  #            depend on the type tag's value.  Present exactly when
>  #            @tag is present.  The variants are in no particular order,
> @@ -181,6 +188,7 @@
>  { 'struct': 'SchemaInfoObject',
>    'data': { 'members': [ 'SchemaInfoObjectMember' ],
>              '*tag': 'str',
> +            '*default-variant': 'str',
>              '*variants': [ 'SchemaInfoObjectVariant' ] } }
>  
>  ##

Until now, the QAPI schema doesn't let you specify default values.
Instead, code sees "absent", and does whatever needs to be done.
Sometimes, it supplies a default value.  "Absent" is shorthand for this
value then.  Sometimes, it behaves differently than for any value.
"Absent" is a distinct additional case then.  I'm not too fond of the
latter case, but it's what we have, and it's not going away.

We've discussed extending the QAPI schema to let you specify default
values.  Two advantages: the default value is *specified* rather than
just documented (or not, when documentation sucks), and we can supply
the default value in generated code.  The introspection schema is even
prepared for this:

    ##
    # @SchemaInfoObjectMember:
    #
    # An object member.
    #
    # @name: the member's name, as defined in the QAPI schema.
    #
    # @type: the name of the member's type.
    #
--> # @default: default when used as command parameter.
    #           If absent, the parameter is mandatory.
    #           If present, the value must be null.  The parameter is
    #           optional, and behavior when it's missing is not specified
    #           here.
    #           Future extension: if present and non-null, the parameter
    #           is optional, and defaults to this value.
    #
    # Since: 2.5
    ##

The idea was to turn

    '*name': 'type'

into sugar for

     'name': { 'type': 'type', 'optional': true }

then extend it to

     'name': { 'type': 'type', 'optional': true, 'default': JSON-VALUE }

where JSON-VALUE null means behavior for "absent" is not specified.

Your patch adds default values in a different way, and for just for
union tags.  For the QAPI language, that's not necessarily a deal
breaker, as we don't need to maintain backward compatibility there.  But
for the introspection schema, we do.  Once we add @default-variant,
we're stuck with it.  Even though it's redundant with
SchemaInfoObjectMember's @default.

I'm skipping review of the implementation for now.
