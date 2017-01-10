Received: from eggs.gnu.org ([2001:4830:134:3::10]:56282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQtjb-00057M-D1
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQtjY-0002e5-7Y
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:32:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cQtjX-0002dr-V3
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:32:52 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6D3A61B8A
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 10:32:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
	<20170109143437.30554-8-marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 11:32:48 +0100
In-Reply-To: <20170109143437.30554-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 9 Jan 2017 15:34:23 +0100")
Message-ID: <877f63tdbj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 07/21] qapi: avoid interleaving sections
 and parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Follow documentation guideline, body, parameters then additional
> sections.

Commit message wording nit: we don't have a concept of "sections", yet.

I don't think the guidelines demand such an order at this point.  Here's
the applicable paragraph from docs/qapi-code-gen.txt:

    Comments are allowed; anything between an unquoted # and the following
    newline is ignored.  Although there is not yet a documentation
    generator, a form of stylized comments has developed for consistently
    documenting details about an expression and when it was added to the
    schema.  The documentation is delimited between two lines of ##, then
    the first line names the expression, an optional overview is provided,
    then individual documentation about each member of 'data' is provided,
    and finally, a 'Since: x.y.z' tag lists the release that introduced
    the expression.  Optional members are tagged with the phrase
    '#optional', often with their default value; and extensions added
    after the expression was first released are also given a '(since
    x.y.z)' comment.  For example:

A pedantical reader would conclude only "Since" can follow the "members
of 'data'".

I'm feeling less pedantical, and conclude that additional information
not mentioned in this paragraph can be stuck wherever it reads well.
Matches existing practice.

That said, I don't mind moving stuff around if it helps the doc
generator later on, and doesn't make things less readable.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi-schema.json     | 10 +++++-----
>  qapi/event.json      |  4 ++--
>  qapi/introspect.json |  3 +--
>  3 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index ac6352fcf9..10a3506528 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4729,17 +4729,17 @@
>  # it should be passed by management with device_add command when
>  # a CPU is being hotplugged.
>  #
> +# @node-id: #optional NUMA node ID the CPU belongs to
> +# @socket-id: #optional socket number within node/board the CPU belongs =
to
> +# @core-id: #optional core number within socket the CPU belongs to
> +# @thread-id: #optional thread number within core the CPU belongs to
> +#
>  # Note: currently there are 4 properties that could be present
>  # but management should be prepared to pass through other
>  # properties with device_add command to allow for future
>  # interface extension. This also requires the filed names to be kept in
>  # sync with the properties passed to -device/device_add.
>  #
> -# @node-id: #optional NUMA node ID the CPU belongs to
> -# @socket-id: #optional socket number within node/board the CPU belongs =
to
> -# @core-id: #optional core number within socket the CPU belongs to
> -# @thread-id: #optional thread number within core the CPU belongs to
> -#
>  # Since: 2.7
>  ##
>  { 'struct': 'CpuInstanceProperties',

No objection.

> diff --git a/qapi/event.json b/qapi/event.json
> index 37bf34ed6d..c7689b211d 100644
> --- a/qapi/event.json
> +++ b/qapi/event.json
> @@ -272,9 +272,9 @@
>  #
>  # Emitted when guest executes ACPI _OST method.
>  #
> -# Since: 2.1
> -#
>  # @info: ACPIOSTInfo type as described in qapi-schema.json
> +#
> +# Since: 2.1
>  ##
>  { 'event': 'ACPI_DEVICE_OST',
>       'data': { 'info': 'ACPIOSTInfo' } }

Consistency improvement.

> diff --git a/qapi/introspect.json b/qapi/introspect.json
> index 464097a235..f6adc439bb 100644
> --- a/qapi/introspect.json
> +++ b/qapi/introspect.json
> @@ -78,14 +78,13 @@
>  # @SchemaInfo:
>  #
>  # @name: the entity's name, inherited from @base.
> +#        The SchemaInfo is always referenced by this name.
>  #        Commands and events have the name defined in the QAPI schema.
>  #        Unlike command and event names, type names are not part of
>  #        the wire ABI.  Consequently, type names are meaningless
>  #        strings here, although they are still guaranteed unique
>  #        regardless of @meta-type.
>  #
> -# All references to other SchemaInfo are by name.
> -#
>  # @meta-type: the entity's meta type, inherited from @base.
>  #
>  # Additional members depend on the value of @meta-type.

Okay.

PATCH 02 "qapi: move QKeyCode doc body at the top" could be squashed
into this one, I think.

Overall, no objections, except the commit message's first line
forward-references the "sections" concept, and its rationale is a bit
weak.

What about this:

    qapi: Reorder doc comments for future doc generator

    The doc generator we're going to add expects a fairly rigid doc
    comment structure.  Reorder / rephrase some to please it.

To be clear: I still doubt this rigid order is a good idea.  But as long
as I can't point to actual harm, I'm willing to accept it, in the
interest of getting stuff done.
