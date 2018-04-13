Received: from eggs.gnu.org ([2001:4830:134:3::10]:54321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f6zUs-000673-1E
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f6zUq-0007yU-Ir
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:16:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f6zUq-0007xc-DF
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:16:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180303002504.25142-1-aik@ozlabs.ru>
	<20180303002504.25142-3-aik@ozlabs.ru>
Date: Fri, 13 Apr 2018 16:16:10 +0200
In-Reply-To: <20180303002504.25142-3-aik@ozlabs.ru> (Alexey Kardashevskiy's
	message of "Sat, 3 Mar 2018 11:25:04 +1100")
Message-ID: <87o9inxkd1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH qemu v4 2/2] qmp: Add qom-list-properties
 to list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Andrea Bolognani <abologna@redhat.com>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> There is already 'device-list-properties' which does most of the job,
> however it does not handle everything returned by qom-list-types such
> as machines as they inherit directly from TYPE_OBJECT and not TYPE_DEVICE.
> It does not handle abstract classes either.
>
> This adds a new qom-list-properties command which prints properties
> of a specific class and its instance. It is pretty much a simplified copy
> of the device-list-properties handler.
>
> Since it creates an object instance, device properties should appear
> in the output as they are copied to QOM properties at the instance_init
> hook.
>
> This adds a object_class_property_iter_init() helper to allow class
> properties enumeration uses it in the new QMP command to allow properties
> listing for abstract classes.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v3:
> * Used ObjectPropertyInfo instead of QOMPropertyInfo
>
> v2:
> * added abstract classes support, now things like "pci-device" or
> "spapr-machine" show properties, previously these would produce
> an "abstract class" error
>
> # Conflicts:
> #	qapi-schema.json
> ---
>  qapi-schema.json     | 15 +++++++++++++++
>  include/qom/object.h | 16 ++++++++++++++++
>  qmp.c                | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  qom/object.c         |  7 +++++++
>  4 files changed, 87 insertions(+)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 5cdf89a..3021e90 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -1442,6 +1442,21 @@
>    'returns': [ 'ObjectPropertyInfo' ] }
>  
>  ##
> +# @qom-list-properties:
> +#
> +# List properties associated with a QOM object.
> +#
> +# @typename: the type name of an object
> +#
> +# Returns: a list of ObjectPropertyInfo describing object properties

Quoting my review of the RFC PATCH,
Message-ID: <871si6vt8n.fsf@dusky.pond.sub.org>:

    qom-list-properties is like instantiate with default configuration
    and without realizing + qom-list + destroy.

    We need to instantiate because QOM properties are dynamic: they
    aren't specified by data (which qom-list-properties could simply
    read), they are created by (instantiation) code (which
    qom-list-properties has to run).

    Properties created only after instantiation (by realize, perhaps)
    aren't visible in qom-list-properties.  Do such properties exist?

    Properties created only in non-default configuration aren't visible
    either.  Such properties have to exist, or else dynamic property
    creation would be idiotic.

    Likewise for properties created differently (say with a different
    type) in non-default configuration.  We can hope that no such beasts
    exist.  Since properties get created by code, and code can do
    anything, we're reduced to hope.  Data is so much easier to reason
    about than code.

And Message-ID: <87r2q3n8oe.fsf@dusky.pond.sub.org>:

    Thus, qom-list-properties design limitation: the result need not
    reflect properties of instantiated objects.  It usually does, as
    most QOM properties behave as if they were static.  But when it
    doesn't, what then?  How are users of qom-list-properties supposed
    to deal with such inaccurate / incorrect information?  Do they just
    have to know which properties aren't visible in qom-list-properties,
    and which properties are, but cannot be trusted?

Please document the design limitation in a followup patch.

> +#
> +# Since: 2.12
> +##
> +{ 'command': 'qom-list-properties',
> +  'data': { 'typename': 'str'},
> +  'returns': [ 'ObjectPropertyInfo' ] }
> +
> +##
>  # @xen-set-global-dirty-log:
>  #
>  # Enable or disable the global dirty log mode.
[...]
