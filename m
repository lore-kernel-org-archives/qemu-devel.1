Received: from eggs.gnu.org ([209.51.188.92]:41225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gkXBK-0002B0-Dl
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gkXBI-0008UV-Ri
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:39:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gkXBI-0008Pl-DL
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:39:44 -0500
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
	<1547576349-13337-6-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a4424580-d38d-492f-e996-f58a58485e81@redhat.com>
Date: Fri, 18 Jan 2019 17:39:41 +0100
MIME-Version: 1.0
In-Reply-To: <1547576349-13337-6-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/5] tests: qgraph API for the qtest driver
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

On 2019-01-15 19:19, Paolo Bonzini wrote:
> From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
>=20
> Add qgraph API that allows to add/remove nodes and edges from the graph=
,
> implementation of Depth First Search to discover the paths and basic un=
it
> test to check correctness of the API.
> Included also a main executable that takes care of starting the framewo=
rk,
> create the nodes, set the available drivers/machines, discover the path=
 and
> run tests.
>=20
> graph.h provides the public API to manage the graph nodes/edges
> graph_extra.h provides a more private API used successively by the gtes=
t integration part
> qos-test.c provides the main executable
>=20
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com=
>
> [Paolo's changes compared to the Google Summer of Code submission:
>  * added subprocess to test options
>  * refactored object creation to support live migration tests
>  * removed driver .before callback (unused)
>  * removed test .after callbacks (replaced by GTest destruction queue)]
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
[...]
> +static void add_edge(const char *source, const char *dest,
> +                     QOSEdgeType type, QOSGraphEdgeOptions *opts)
> +{
> +    char *key;
> +    QOSGraphEdgeList *list =3D g_hash_table_lookup(edge_table, source)=
;
> +
> +    if (!list) {
> +        list =3D g_new0(QOSGraphEdgeList, 1);
> +        key =3D g_strdup(source);
> +        g_hash_table_insert(edge_table, key, list);
> +    }
> +
> +    if (!opts) {
> +        opts =3D &(QOSGraphEdgeOptions) { };

Not sure, but this part looks suspicious to me ... isn't that pointer
going to be invalid as soon as the if-statement scope is over in the
next line?

> +    }
> +
> +    QOSGraphEdge *edge =3D g_new0(QOSGraphEdge, 1);
> +    edge->type =3D type;
> +    edge->dest =3D g_strdup(dest);
> +    edge->edge_name =3D g_strdup(opts->edge_name ? : dest);

I think I'd write the elvis operator rather as "?:", without the space
inbetween. (or does our checkpatch script dislike that?)

> +    edge->arg =3D g_memdup(opts->arg, opts->size_arg);
> +
> +    edge->before_cmd_line =3D
> +        opts->before_cmd_line ? g_strconcat(" ", opts->before_cmd_line=
, NULL) : NULL;
> +    edge->extra_device_opts =3D
> +        opts->extra_device_opts ? g_strconcat(",", opts->extra_device_=
opts, NULL) : NULL;
> +    edge->after_cmd_line =3D
> +        opts->after_cmd_line ? g_strconcat(" ", opts->after_cmd_line, =
NULL) : NULL;
> +
> +    QSLIST_INSERT_HEAD(list, edge, edge_list);
> +}
[...]
> +bool qos_graph_has_edge(const char *start, const char *dest)
> +{
> +    QOSGraphEdgeList *list =3D get_edgelist(start);
> +    QOSGraphEdge *e =3D search_list_edges(list, dest);
> +    if (e) {
> +        return TRUE;
> +    }
> +    return FALSE;
> +}

I'm surprised that TRUE and FALSE are also still available with capital
letters these days ... The spelling from stdbool.h is lowercase.

Anyway, maybe rather:

    return e !=3D NULL;

?

[...]
> +void qos_add_test(const char *name, const char *interface,
> +                  QOSTestFunc test_func, QOSGraphTestOptions *opts)
> +{
> +    QOSGraphNode *node;
> +    char *test_name =3D g_strdup_printf("%s-tests/%s", interface, name=
);;
> +
> +    if (!opts) {
> +        opts =3D &(QOSGraphTestOptions) { };

Same as above ... is the pointer still valid after the next curly brace?

> +    }
> +    node =3D create_node(test_name, QNODE_TEST);
> +    node->u.test.function =3D test_func;
> +    node->u.test.arg =3D opts->arg;
> +    assert(!opts->edge.arg);
> +    assert(!opts->edge.size_arg);
> +
> +    node->u.test.before =3D opts->before;
> +    node->u.test.subprocess =3D opts->subprocess;
> +    node->available =3D TRUE;
> +    add_edge(interface, test_name, QEDGE_CONSUMED_BY, &opts->edge);
> +    g_free(test_name);
> +}
[...]
> + * There are three types of command line arguments:
> + * - in node      : created from the node name. For example, machines =
will
> + *                  have "-M <machine>" to its command line, while dev=
ices
> + *                  "-device <device>". It is automatically done by th=
e
> + *                   framework.
> + * - after node   : added as additional argument to the node name.
> + *                  This argument is added optionally when creating ed=
ges,
> + *                  by setting the parameter @after_cmd_line and
> + *                  @extra_edge_opts in #QOSGraphEdgeOptions.
> + *                  The framework automatically adds
> + *                  a comma before @extra_edge_opts,
> + *                  because it is going to add attibutes

attributes

> + *                  after the destination node pointed by
> + *                  the edge containing these options, and automatical=
ly
> + *                  adds a space before @after_cmd_line, because it
> + *                  adds an additional device, not an attribute.
> + * - before node  : added as additional argument to the node name.
> + *                  This argument is added optionally when creating ed=
ges,
> + *                  by setting the parameter @before_cmd_line in
> + *                  #QOSGraphEdgeOptions. This attribute
> + *                  is going to add attibutes before the destination n=
ode
> + *                  pointed by the edge containing these options. It i=
s
> + *                  helpful to commands that are not node-representabl=
e,
> + *                  such as "-fdsev" or "-netdev".
> + *
> + * While adding command line in edges is always used, not all nodes na=
mes are
> + * used in every path walk: this is because the contained or produced =
ones
> + * are already added by QEMU, so only nodes that "consumes" will be us=
ed to
> + * build the command line. Also, nodes that will have { "abstract" : t=
rue }
> + * as QMP attribute will loose their command line, since they are not =
proper
> + * devices to be added in QEMU.
[...]
> + * - destructor: Opposite to the node constructor, destroys the object=
.
> + * This function is called after the test has been executed, and perfo=
rms
> + * a complete cleanup of each node allocated field. In case no constuc=
tor

constructor

> + * is provided, no destructor will be called.
> + *
> + */
> +struct QOSGraphObject {
> +    /* for produces edges, returns void * */
> +    QOSGetDriver get_driver;
> +    /* for contains edges, returns a QOSGraphObject * */
> +    QOSGetDevice get_device;
> +    /* start the hw, get ready for the test */
> +    QOSStartFunct start_hw;
> +    /* destroy this QOSGraphObject */
> +    QOSDestructorFunc destructor;
> +    /* free the memory associated to the QOSGraphObject and its contai=
ned
> +     * children */
> +    GDestroyNotify free;
> +};
[...]
> +static void apply_to_node(const char *name, bool is_machine, bool is_a=
bstract)
> +{
> +    char *machine_name =3D NULL;
> +    if (is_machine) {
> +        const char *arch =3D qtest_get_arch();
> +        machine_name =3D g_strconcat(arch, "/", name, NULL);
> +        name =3D machine_name;
> +    }
> +    qos_graph_node_set_availability(name, TRUE);

true

> +    if (is_abstract) {
> +        qos_delete_cmd_line(name);
> +    }
> +    g_free(machine_name);
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
> +    bool abstract;
> +    QDict *minfo;
> +    QObject *qobj;
> +    QString *qstr;
> +    QBool *qbool;
> +
> +    for (p =3D qlist_first(list); p; p =3D qlist_next(p)) {
> +        minfo =3D qobject_to(QDict, qlist_entry_obj(p));
> +        qobj =3D qdict_get(minfo, "name");
> +        qstr =3D qobject_to(QString, qobj);
> +        name =3D qstring_get_str(qstr);
> +
> +        qobj =3D qdict_get(minfo, "abstract");
> +        if (qobj) {
> +            qbool =3D qobject_to(QBool, qobj);
> +            abstract =3D qbool_get_bool(qbool);
> +        } else {
> +            abstract =3D false;
> +        }
> +
> +        apply_to_node(name, is_machine, abstract);
> +        qobj =3D qdict_get(minfo, "alias");
> +        if (qobj) {
> +            qstr =3D qobject_to(QString, qobj);
> +            name =3D qstring_get_str(qstr);
> +            apply_to_node(name, is_machine, abstract);
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
> + * setting it as available. The list currently returns all devices tha=
t
> + * are either machines or QEDGE_CONSUMED_BY other nodes.
> + * Therefore, in order to mark all other nodes, it recursively sets
> + * all its QEDGE_CONTAINS and QEDGE_PRODUCES child as available too.
> + */
> +static void qos_set_machines_devices_available(void)
> +{
> +    QDict *response;
> +    QDict *args =3D qdict_new();
> +    QList *list;
> +
> +    qtest_start("-machine none");
> +    response =3D qmp("{ 'execute': 'query-machines' }");
> +    list =3D qdict_get_qlist(response, "return");
> +
> +    apply_to_qlist(list, TRUE);

true

> +    qobject_unref(response);
> +
> +    qdict_put_bool(args, "abstract", TRUE);
true

> +    qdict_put_str(args, "implements", "device");
> +
> +    response =3D qmp("{'execute': 'qom-list-types',"
> +                   " 'arguments': %p }", args);
> +    g_assert(qdict_haskey(response, "return"));
> +    list =3D qdict_get_qlist(response, "return");
> +
> +    apply_to_qlist(list, FALSE);

false

> +    qtest_end();
> +    qobject_unref(response);
> +

Remove superfluous empty line?

> +}
> +
> +static QGuestAllocator *get_machine_allocator(QOSGraphObject *obj)
> +{
> +    if (obj->get_driver) {
> +        return obj->get_driver(obj, "memory");
> +    } else {
> +        return NULL;
> +    }
> +}

Maybe remove the "else" like this:

   if (obj->get_driver) {
       return obj->get_driver(obj, "memory");
   }
   return NULL;

?

 Thomas
