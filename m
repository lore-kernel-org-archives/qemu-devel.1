Received: from eggs.gnu.org ([2001:4830:134:3::10]:38704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdG6V-0007XK-Ru
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdG6R-0007HS-0i
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:28:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fdG6Q-0007GY-LN
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:28:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id a3-v6so9171795wrt.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 07:28:22 -0700 (PDT)
Date: Wed, 11 Jul 2018 15:28:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711142819.GM31228@stefanha-x1.localdomain>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-2-e.emanuelegiuseppe@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xtx0sNU5lZ46KfgK"
Content-Disposition: inline
In-Reply-To: <20180709091136.28849-2-e.emanuelegiuseppe@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/7] tests: qgraph API for the qtest driver
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, 2018 at 11:11:30AM +0200, Emanuele Giuseppe Esposito wrote:
> +/* Graph Edge.*/
> +struct QOSGraphEdge {
> +    QOSEdgeType type;
> +    char *dest;
> +    char *arg; /* just for CONTAIS and CONSUMED_BY */

CONTAINS?

> +/**
> + * remove_node(): removes a node @val from the nodes hash table.
> + * Note that node->name is not free'd since it will represent the
> + * hash table key
> + */
> +static void remove_node(void *val)

This is a confusing function name and doc comment.  It does not remove
the node from a hash table, it just frees it.

Please call this destroy_node().  The g_hash_table_new_full() argument
is GDestroyNotify value_destroy_func, so that would be consistent with
glib naming too.

> +{
> +    QOSGraphNode *node = (QOSGraphNode *) val;

There is no need to cast void pointers in C.  Just "QOSGraphNode *node =
val;" will do.

> +/**
> + * build_driver_cmd_line(): builds the command line for the driver
> + * @node. The node name must be a valid qemu identifier, since it
> + * will be used to build the command line.
> + *
> + * It is also possible to pass an optional @args that will be
> + * concatenated to the command line.
> + *
> + * For drivers, prepend -device to the driver name.
> + */
> +static void build_driver_cmd_line(QOSGraphNode *node, const char *args)

Why is this called "driver" instead of "device"?

> +{
> +    if (args) {
> +        node->command_line = g_strconcat("-device ", node->name, ",",
> +                                          args, NULL);
> +    } else {
> +        node->command_line = g_strconcat("-device ", node->name, NULL);
> +    }
> +}
> +
> +/**
> + * build_test_cmd_line(): builds the command line for the test
> + * @node. The node name need not to be a valid qemu identifier, since it
> + * will not be used to build the command line.
> + *
> + * It is also possible to pass an optional @args that will be
> + * used as additional command line.
> + */
> +static void build_test_cmd_line(QOSGraphNode *node, const char *args)
> +{
> +    if (args) {
> +        node->command_line = g_strdup(args);
> +    } else {
> +        node->command_line = NULL;
> +    }

This is equivalent to:

  node->command_line = g_strdup(args);

https://developer.gnome.org/glib/stable/glib-String-Utility-Functions.html#g-strdup

> diff --git a/tests/libqos/qgraph.h b/tests/libqos/qgraph.h
> new file mode 100644
> index 0000000000..54a1786c1e
> --- /dev/null
> +++ b/tests/libqos/qgraph.h
> @@ -0,0 +1,259 @@
> +/*
> + * libqos driver framework

The per-function doc comment are good.  Please also include higher-level
examples of how to use this.  At first glance all these functions are
overwhelming and it's not clear how to implement new tests, drivers,
interfaces, or machines.

See include/qom/object.h for inspiration.

> +/* edge types*/
> +enum QOSEdgeType {
> +    CONTAINS,
> +    PRODUCES,
> +    CONSUMED_BY
> +};
> +
> +/* node types*/
> +enum QOSNodeType {
> +    MACHINE,
> +    DRIVER,
> +    INTERFACE,
> +    TEST
> +};

The QOSEdgeType and QOSNodeType enum constants use commonly-used names
in the global namespace.  Please prefix them since this is a header
file that will be included from many source files.

> +
> +/**
> + * Each driver, test or machine will have this as first field.
> + * Depending on the edge, the node will call the corresponding
> + * function when walking the path.
> + *
> + * QOSGraphObject also provides a destructor, used to deallocate the
> + * after the test has been executed.
> + */
> +struct QOSGraphObject {
> +    /* for produces, returns void * */
> +    QOSGetDriver get_driver;

Unused?

> +    /* for contains, returns a QOSGraphObject * */
> +    QOSGetDevice get_device;

Unused?

> diff --git a/tests/libqos/qgraph_extra.h b/tests/libqos/qgraph_extra.h
> new file mode 100644
> index 0000000000..22850c0368
> --- /dev/null
> +++ b/tests/libqos/qgraph_extra.h
> @@ -0,0 +1,155 @@
> +/*
> + * libqos driver framework
> + *
> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2 as published by the Free Software Foundation.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + */
> +
> +#ifndef QGRAPH_EXTRA_H
> +#define QGRAPH_EXTRA_H
> +
> +#include "qgraph.h"
> +#define PRINT_DEBUG 0

I would expect the #ifdef to be in the C file that uses it.  PRINT_DEBUG
is too generic a name for a .h file, it may cause namespace collisions.

--xtx0sNU5lZ46KfgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRhQDAAoJEJykq7OBq3PIk70H+gJwpoS4KbWT/GaumW1aQJFW
TbgS38vajtToNwu8ptAUqp3h9gg+VK1mNIzXW3iYeuACFFlqhij56SdWGMf2mf++
Yw48FHCtMMugygpPCIIKCTktwQKz5qoUz3NRBjkghks4VU+E4yy+j9k0DxpIqRSn
w3HvPPhy8GyleqECbn4U86Fs0JN2c+xq5ANKWYXAexCrJUk/ObHdcBy8AmIGlE8y
6sJSqR1yCo+frSeqbT4wk8Pe2cHCj7LSG899yFmh/FmLXqegjReTDoEeR9AeqLy5
tQq5hJ7QWNAXhASTu36bxRm33gG4AloIDbtUI8ji7W9VhZuN1u2dfxdZuwSqfxY=
=z748
-----END PGP SIGNATURE-----

--xtx0sNU5lZ46KfgK--
