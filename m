Received: from eggs.gnu.org ([209.51.188.92]:55394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grdbZ-0004QX-BU
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 01:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grdbY-0006f4-F7
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 01:56:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190206195551.28893-1-mreitz@redhat.com>
	<20190206195551.28893-2-mreitz@redhat.com>
Date: Thu, 07 Feb 2019 07:56:07 +0100
In-Reply-To: <20190206195551.28893-2-mreitz@redhat.com> (Max Reitz's message
	of "Wed, 6 Feb 2019 20:55:44 +0100")
Message-ID: <87mun8jddk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/8] qapi: Add default-variant for flat
 unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Max Reitz <mreitz@redhat.com> writes:

> This patch allows specifying a discriminator that is an optional member
> of the base struct.  In such a case, a default value must be provided
> that is used when no value is given.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/introspect.json           |  8 +++++
>  scripts/qapi/common.py         | 58 ++++++++++++++++++++++++++++------
>  scripts/qapi/doc.py            | 10 ++++--
>  scripts/qapi/introspect.py     | 10 ++++--
>  scripts/qapi/visit.py          | 13 ++++++++
>  tests/qapi-schema/test-qapi.py |  2 ++
>  6 files changed, 86 insertions(+), 15 deletions(-)
>
> diff --git a/qapi/introspect.json b/qapi/introspect.json
> index 3d22166b2b..e4740aa7a0 100644
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
> +#                   (Since: 4.0)
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

I'm afraid this could become awkward later on.  Let me explain.

In many programming languages, absent optional arguments / members
default to a default value specified in the declaration.  Simple.

In others, 'absent' is effectively an additional value.  The code
consuming the argument / member can interpret 'absent' however it wants.
It may eliminate the additional value by mapping it to a default value,
but it can also interpret 'absent' unlike any value.  If there's more
than one consumer, their interpretations need not be consistent.  The
declaration provides no clue on semantics of 'absent'.

QAPI is in the latter camp.  I trust you can already sense how much I
like that.

Now you want to permit optional variant discriminators.  As per general
rule, their interpretation is left to the code consuming it.  One
instance of such code is the generated union visitor, which needs to
decide which variant to visit.  Your default-variant tells it which
variant to visit.  Other code interpreting the discriminator better be
consistent with that, but that's the other code's problem.  Hmm.

If I could go back in time, I'd flip QAPI to "'absent' defaults to a
default value".  Lacking a time machine, we're stuck with cases of
"'absent' means something you can't express with a value" and "'absent'
means different things in different contexts" that have been enshrined
in external interfaces.  Is there anything we could do to improve
matters for saner cases?

I think there is: we could provide for an *optional* default value.  If
the schema specifies it, that's what 'absent' means.  If it doesn't, all
bets are off, just like they are now.

Say we do that (for what it's worth, introspect.json is already prepared
for it).  How would it play with your default-variant?

If an optional discriminator specifies a default value, then that's the
default variant.  But wait, if there's also a default-variant, *that's*
the default variant!  Awkward clash.  To resolve it, we could either
forbid combining the two, or rule default-variant overrides the default.
Feels needlessly complicated.

Could we get away with "if you want a default variant, the discriminator
must specify a default"?

[...]
