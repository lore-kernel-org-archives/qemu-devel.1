Received: from eggs.gnu.org ([2001:4830:134:3::10]:49983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdGdC-0000yD-S8
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdGd7-0005ZV-TI
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:02:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fdGd7-0005ZM-Ht
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:02:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id h10-v6so18509859wre.6
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 08:02:09 -0700 (PDT)
Date: Wed, 11 Jul 2018 16:02:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711150206.GP31228@stefanha-x1.localdomain>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-7-e.emanuelegiuseppe@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKpLca3blcvhMJ0W"
Content-Disposition: inline
In-Reply-To: <20180709091136.28849-7-e.emanuelegiuseppe@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 6/7] tests/qgraph: gtest integration
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


--QKpLca3blcvhMJ0W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 11:11:35AM +0200, Emanuele Giuseppe Esposito wrote:
> Add main executable that takes care of starting the framework, create the
> nodes, set the available drivers/machines, discover the path and run test=
s.

This is elegant, I like it.

> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> ---
>  tests/Makefile.include |   3 +
>  tests/qos-test.c       | 310 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 313 insertions(+)
>  create mode 100644 tests/qos-test.c
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 706ac39ea5..e2db3e9d09 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -776,6 +776,9 @@ libqgraph-pc-obj-y +=3D tests/libqos/raspi2-machine.o=
 tests/libqos/x86_64_pc-machi
>  check-unit-y +=3D tests/test-qgraph$(EXESUF)
>  tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
> =20
> +check-qtest-pci-y +=3D tests/qos-test$(EXESUF)
> +tests/qos-test$(EXESUF): tests/qos-test.o $(libqgraph-pc-obj-y)
> +
>  tests/qmp-test$(EXESUF): tests/qmp-test.o
>  tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
>  tests/rtc-test$(EXESUF): tests/rtc-test.o
> diff --git a/tests/qos-test.c b/tests/qos-test.c
> new file mode 100644
> index 0000000000..f4748c44a4
> --- /dev/null
> +++ b/tests/qos-test.c
> @@ -0,0 +1,310 @@
> +/*
> + * libqos driver framework
> + *
> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gma=
il.com>
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
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qstring.h"
> +#include "qapi/qmp/qlist.h"
> +#include "libqos/qgraph.h"
> +#include "libqos/qgraph_extra.h"
> +
> +/**
> + * create_machine_name(): appends the architecture to @name if
> + * @is_machine is valid.
> + */
> +static void create_machine_name(const char **name, bool is_machine)
> +{
> +    const char *arch;
> +    if (!is_machine) {
> +        return;
> +    }
> +    arch =3D qtest_get_arch();
> +    *name =3D g_strconcat(arch, "/", *name, NULL);
> +}
> +
> +/**
> + * destroy_machine_name(): frees the given @name if
> + * @is_machine is valid.
> + */
> +static void destroy_machine_name(const char *name, bool is_machine)
> +{
> +    if (!is_machine) {
> +        return;
> +    }
> +    g_free((char *)name);
> +}
> +
> +/**
> + * apply_to_qlist(): using QMP queries QEMU for a list of
> + * machines and devices available, and sets the respective node
> + * as TRUE. If a node is found, also all its produced and contained
> + * child are marked available.
> + *
> + * See qos_graph_node_set_availability() for more info
> + */
> +static void apply_to_qlist(QList *list, bool is_machine)
> +{
> +    const QListEntry *p;
> +    const char *name;
> +    QDict *minfo;
> +    QObject *qobj;
> +    QString *qstr;
> +
> +    for (p =3D qlist_first(list); p; p =3D qlist_next(p)) {
> +        minfo =3D qobject_to(QDict, qlist_entry_obj(p));
> +        g_assert(minfo);
> +        qobj =3D qdict_get(minfo, "name");
> +        g_assert(qobj);
> +        qstr =3D qobject_to(QString, qobj);
> +        g_assert(qstr);
> +        name =3D qstring_get_str(qstr);
> +        create_machine_name(&name, is_machine);
> +        qos_graph_node_set_availability(name, TRUE);
> +        destroy_machine_name(name, is_machine);
> +        qobj =3D qdict_get(minfo, "alias");
> +        if (qobj) {
> +            g_assert(qobj);
> +            qstr =3D qobject_to(QString, qobj);
> +            g_assert(qstr);
> +            name =3D qstring_get_str(qstr);
> +            create_machine_name(&name, is_machine);
> +            qos_graph_node_set_availability(name, TRUE);
> +            destroy_machine_name(name, is_machine);
> +        }
> +    }
> +}
> +
> +/**
> + * qos_set_machines_devices_available(): sets availability of qgraph
> + * machines and devices.
> + *
> + * This function firstly starts QEMU with "-machine none" option,
> + * and then executes the QMP protocol asking for the list of devices
> + * and machines available.
> + *
> + * for each of these items, it looks up the corresponding qgraph node,
> + * setting it as available. The list currently returns all devices that
> + * are either machines or CONSUMED_BY other nodes.
> + * Therefore, in order to mark all other nodes, it recursively sets
> + * all its CONTAINS and PRODUCES child as available too.
> + */
> +static void qos_set_machines_devices_available(void)
> +{
> +    QDict *response;
> +    QDict *args =3D qdict_new();
> +    QList *list;
> +
> +    qtest_start("-machine none");
> +    response =3D qmp("{ 'execute': 'query-machines' }");
> +    g_assert(response);
> +    list =3D qdict_get_qlist(response, "return");
> +    g_assert(list);
> +
> +    apply_to_qlist(list, TRUE);
> +
> +    qobject_unref(response);
> +
> +    qdict_put_bool(args, "abstract", TRUE);
> +    qdict_put_str(args, "implements", "device");
> +
> +    response =3D qmp("{'execute': 'qom-list-types',"
> +               " 'arguments': %p }", args);
> +    g_assert(qdict_haskey(response, "return"));
> +    list =3D qdict_get_qlist(response, "return");
> +
> +    apply_to_qlist(list, FALSE);
> +
> +    qtest_end();
> +    qobject_unref(response);
> +
> +}
> +
> +/**
> + * allocate_objects(): given an array of nodes @arg,
> + * walks the path invoking all constructors and
> + * passing the corresponding parameter in order to
> + * continue the objects allocation.
> + * Once the test is reached, its function is executed.
> + *
> + * Since only the machine and CONSUMED_BY nodes actually
> + * allocate something in the constructor, a garbage collector
> + * saves their pointer in an array, so that after execution
> + * they can be safely free'd.
> + *
> + * Note: as specified in walk_path() too, @arg is an array of
> + * char *, where arg[0] is a pointer to the command line
> + * string that will be used to properly start QEMU when executing
> + * the test, and the remaining elements represent the actual objects
> + * that will be allocated.
> + */
> +static void allocate_objects(const void *arg)
> +{
> +    QOSGraphObject *garbage_collector[(QOS_PATH_MAX_ELEMENT_SIZE * 2)];
> +    int garbage_size =3D 0;
> +    QOSEdgeType etype;
> +    QOSGraphNode *node;
> +    QOSGraphObject *o;
> +    int current =3D 1, has_to_allocate =3D 0;
> +    void *obj =3D NULL;
> +    char **path =3D (char **) arg;
> +
> +    node =3D qos_graph_get_node(path[current]);
> +
> +    while (current < QOS_PATH_MAX_ELEMENT_SIZE) {
> +
> +        if (node->type =3D=3D MACHINE) {
> +            global_qtest =3D qtest_start(path[0]);
> +
> +            obj =3D node->u.machine.constructor();
> +            garbage_collector[garbage_size++] =3D obj;
> +
> +        } else if (has_to_allocate && node->type =3D=3D DRIVER) {
> +            obj =3D node->u.driver.constructor(obj, NULL);
> +            garbage_collector[garbage_size++] =3D obj;
> +
> +        } else if (!path[(current + 1)] && node->type =3D=3D TEST) {
> +            node->u.test.function(obj, node->u.test.arg);
> +            break;
> +        }
> +
> +        etype =3D qos_graph_get_edge_type(path[current], path[(current +=
 1)]);
> +        current++;
> +        node =3D qos_graph_get_node(path[current]);
> +
> +        o =3D obj;
> +
> +        switch (etype) {
> +        case PRODUCES:
> +            obj =3D o->get_driver(obj, path[current]);
> +            break;
> +        case CONSUMED_BY:
> +            has_to_allocate =3D 1;
> +            break;
> +        case CONTAINS:
> +            obj =3D o->get_device(obj, path[current]);
> +            break;
> +        }
> +
> +    }
> +
> +    g_free(path[0]);
> +    g_free(path);
> +    for (int i =3D 0; i < garbage_size; i++) {
> +        garbage_collector[i]->destructor(garbage_collector[i]);
> +    }
> +    qtest_end();
> +}
> +
> +/*
> + * in this function, 2 path will be built:
> + * str_path, a one-string path (ex "pc/i440FX-pcihost/...")
> + * ro_path, a string-array path (ex [0] =3D "pc", [1] =3D "i440FX-pcihos=
t").
> + *
> + * str_path will be only used to build the test name, and won't need the
> + * architecture name at beginning, since it will be added by qtest_add_f=
unc().
> + *
> + * ro_path is used to allocate all constructors of the path nodes.
> + * Each name in this array except position 0 must correspond to a valid
> + * QOSGraphNode name.
> + * Position 0 is special, initially contains just the <machine> name of
> + * the node, (ex for "x86_64/pc" it will be "pc"), used to build the test
> + * path (see below). After it will contain the command line used to start
> + * qemu with all required devices.
> + *
> + * Note that the machine node name must be with format <arch>/<machine>
> + * (ex "x86_64/pc"), because it will identify the node "x86_64/pc"
> + * and start QEMU with "-M pc". For this reason,
> + * when building str_path, ro_path
> + * initially contains the <machine> at position 0 ("pc"),
> + * and the node name at position 1 (<arch>/<machine>)
> + * ("x86_64/pc"), followed by the rest of the nodes.
> + */
> +static void walk_path(QOSGraphNode *orig_path, int len)
> +{
> +    QOSGraphNode *path;
> +    /* twice QOS_PATH_MAX_ELEMENT_SIZE since each edge can have its arg =
*/
> +    char **ro_path =3D g_new0(char *, (QOS_PATH_MAX_ELEMENT_SIZE * 2));
> +    int ro_path_size =3D 0;
> +    char *machine =3D NULL, *arch =3D NULL, *tmp_cmd =3D NULL, *str_path;
> +    char *tmp =3D orig_path->name, *gfreed;
> +    GString *cmd_line =3D g_string_new("");
> +
> +    do {
> +        path =3D qos_graph_get_node(tmp);
> +        tmp =3D qos_graph_get_edge_dest(path->path_edge);
> +
> +        /* append node command line + previous edge command line */
> +        if (path->command_line && tmp_cmd) {
> +            g_string_append(cmd_line, path->command_line);
> +            g_string_append_printf(cmd_line, "%s ", tmp_cmd);
> +        }
> +
> +        if (path->type =3D=3D MACHINE) {
> +            qos_separate_arch_machine(path->name, &arch, &machine);
> +            ro_path[ro_path_size++] =3D arch;
> +            ro_path[ro_path_size++] =3D machine;
> +            g_string_append_printf(cmd_line, "%s ", path->command_line);
> +        } else {
> +            /* detect if edge has command line args */
> +            ro_path[ro_path_size++] =3D path->name;
> +            tmp_cmd =3D qos_graph_get_edge_arg(path->path_edge);
> +        }
> +
> +    } while (path->path_edge);
> +
> +
> +    /* here position 0 has <arch>/<machine>, position 1 <machine>.
> +     * the path must not have the <arch>, that's why ro_path  + 1
> +     */
> +    str_path =3D g_strjoinv("/", (ro_path + 1));
> +    gfreed =3D g_string_free(cmd_line, FALSE);
> +    /* put arch/machine in position 1 so allocate_objects can do its work
> +     * and add the command line at position 0.
> +     */
> +    ro_path[0] =3D g_strdup(gfreed);
> +    ro_path[1] =3D arch;
> +
> +    qtest_add_data_func(str_path, ro_path, allocate_objects);
> +    g_free(str_path);
> +}
> +
> +/**
> + * main(): heart of the qgraph framework.
> + *
> + * - Initializes the glib test framework
> + * - Creates the graph by invoking the various _init constructors
> + * - Starts QEMU to mark the available devices
> + * - Walks the graph, and each path is added to
> + *   the glib test framework (walk_path)
> + * - Runs the tests, calling allocate_object() and allocating the
> + *   machine/drivers/test objects
> + * - Cleans up everything
> + */
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qos_graph_init();
> +    module_call_init(MODULE_INIT_LIBQOS);
> +    qos_set_machines_devices_available();
> +
> +    qos_graph_foreach_test_path(walk_path);
> +    g_test_run();
> +    qos_graph_destroy();
> +    return 0;
> +}
> --=20
> 2.17.1
>=20
>=20

--QKpLca3blcvhMJ0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRhvuAAoJEJykq7OBq3PITMwH/A2OEpzs1RjmBzdsXFUkX6lv
edWAZR0EcIEdTtvHN0fRPMye62ehx2PjN6IFt/yNMoML6CGFW30x5muYJ5ESkg39
oCa1dFRnBlpWF4yD+tP+UEXl5SRK2n7OWLxYlxkJXL3S5QT1piu3L/MEVELrCFY3
kX2bfe0P7nvaaK0WTkUmOlu9Qmd54GiGepuVuXyO+rAVcjr2VSC+xMq20hbHcMMo
zj+0LUJIua3KdslU1ErcZrl9FL2ndOAL+gfS94OXapX63DRvDeZwxh9Z7sfsWNFD
9ak41OjEey1MbgXLzya+PXjQl/rJ44TBf4LprUctTovU7daxEYS0NjJWZKZP2Og=
=QLoZ
-----END PGP SIGNATURE-----

--QKpLca3blcvhMJ0W--
