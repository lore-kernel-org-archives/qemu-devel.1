Received: from eggs.gnu.org ([2001:4830:134:3::10]:35072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSl0q-00023k-AK
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSl0m-000372-87
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:47:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gSl0l-00034P-VH
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:47:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5D9F3082E23
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 15:47:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181130122844.29103-1-ehabkost@redhat.com>
	<87in0ek8du.fsf@dusky.pond.sub.org>
	<20181130142742.GG18284@habkost.net>
Date: Fri, 30 Nov 2018 16:47:17 +0100
In-Reply-To: <20181130142742.GG18284@habkost.net> (Eduardo Habkost's message
	of "Fri, 30 Nov 2018 12:27:42 -0200")
Message-ID: <87in0eftyy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] hostmem: Validate host-nodes before
 setting bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> I don't understand yet if there's a leak at
> host_memory_backend_get_host_nodes().  Won't
> visit_type_uint16List() take ownership of the list on that case?

Nope.  I checked with valgrind:

    $ valgrind --leak-check=full upstream-qemu -nodefaults -S -display none -qmp stdio -object memory-backend-file,id=mem0,mem-path=x,size=4096,host-nodes=1,policy=bind
    [...]
    {"QMP": {"version": {"qemu": {"micro": 92, "minor": 0, "major": 3}, "package": "v3.1.0-rc2-48-g039d4e3df0-dirty"}, "capabilities": []}}
    {"execute": "qmp_capabilities"}
    {"return": {}}
    { "execute": "qom-get", "arguments": { "path": "mem0", "property": "host-nodes" {"execute": "qom-get", "arguments": {"path": "mem0", "property": "host-nodes"}}
    {"return": [1]}
    {"execute": "quit"}
    {"return": {}}
    {"timestamp": {"seconds": 1543592652, "microseconds": 950994}, "event": "SHUTDOWN", "data": {"guest": false}}
    ==4954== 
    ==4954== HEAP SUMMARY:
    ==4954==     in use at exit: 3,631,673 bytes in 14,706 blocks
    ==4954==   total heap usage: 51,347 allocs, 36,641 frees, 24,195,921 bytes allocated
    [...]
    ==4954== 16 bytes in 1 blocks are definitely lost in loss record 1,964 of 5,297
    ==4954==    at 0x4C3111A: calloc (vg_replace_malloc.c:752)
    ==4954==    by 0x574948D: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.5600.3)
    ==4954==    by 0x9E1CE0: opts_start_list (opts-visitor.c:228)
    ==4954==    by 0x9DAB35: visit_start_list (qapi-visit-core.c:78)
    ==4954==    by 0x99BA3A: visit_type_uint16List (qapi-builtin-visit.c:272)
    ==4954==    by 0x5F911B: host_memory_backend_set_host_nodes (hostmem.c:108)
    ==4954==    by 0x8AC7D4: object_property_set (object.c:1183)
    ==4954==    by 0x8AFC82: user_creatable_add_type (object_interfaces.c:73)
    ==4954==    by 0x8AFED2: user_creatable_add_opts (object_interfaces.c:131)
    ==4954==    by 0x8AFFCD: user_creatable_add_opts_foreach (object_interfaces.c:154)
    ==4954==    by 0xA0B9B9: qemu_opts_foreach (qemu-option.c:1171)
    ==4954==    by 0x5C6C44: main (vl.c:4415)
    ==4954== 
    ==4954== 16 bytes in 1 blocks are definitely lost in loss record 1,965 of 5,297
    ==4954==    at 0x4C3111A: calloc (vg_replace_malloc.c:752)
    ==4954==    by 0x574948D: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.5600.3)
    ==4954==    by 0x5F8FF5: host_memory_backend_get_host_nodes (hostmem.c:82)
    ==4954==    by 0x8AC739: object_property_get (object.c:1168)
    ==4954==    by 0x8AF910: object_property_get_qobject (qom-qobject.c:39)
    ==4954==    by 0x5E1736: qmp_qom_get (qmp.c:249)
    ==4954==    by 0x5D872F: qmp_marshal_qom_get (qapi-commands-misc.c:1284)
    ==4954==    by 0x9DF5C1: do_qmp_dispatch (qmp-dispatch.c:129)
    ==4954==    by 0x9DF788: qmp_dispatch (qmp-dispatch.c:171)
    ==4954==    by 0x42C0C1: monitor_qmp_dispatch (monitor.c:4085)
    ==4954==    by 0x42C3E1: monitor_qmp_bh_dispatcher (monitor.c:4157)
    ==4954==    by 0x9EEDB1: aio_bh_call (async.c:90)
    [...]
    ==4954== LEAK SUMMARY:
    ==4954==    definitely lost: 32 bytes in 2 blocks
    ==4954==    indirectly lost: 0 bytes in 0 blocks
    ==4954==      possibly lost: 2,504 bytes in 20 blocks
    ==4954==    still reachable: 3,629,137 bytes in 14,684 blocks
    ==4954==                       of which reachable via heuristic:
    ==4954==                         newarray           : 1,536 bytes in 16 blocks
    ==4954==         suppressed: 0 bytes in 0 blocks
    ==4954== Reachable blocks (those to which a pointer was found) are not shown.
    ==4954== To see them, rerun with: --leak-check=full --show-leak-kinds=all
    ==4954== 
    ==4954== For counts of detected and suppressed errors, rerun with: -v
    ==4954== Use --track-origins=yes to see where uninitialised values come from
    ==4954== ERROR SUMMARY: 24 errors from 24 contexts (suppressed: 0 from 0)

The first block shown is leaked in host_memory_backend_set_host_nodes()
on behalf of -object, the second block in
host_memory_backend_get_host_nodes() on behalf of qom-get.

Full disclosure: I hacked host_memory_backend_complete() to skip
mbind():

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 1a89342039..0e40bb1ad4 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -333,7 +333,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
         assert(sizeof(backend->host_nodes) >=
                BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
         assert(maxnode <= MAX_NODES);
-        if (mbind(ptr, sz, backend->policy,
+        if (0 && mbind(ptr, sz, backend->policy,
                   maxnode ? backend->host_nodes : NULL, maxnode + 1, flags)) {
             if (backend->policy != MPOL_DEFAULT || errno != ENOSYS) {
                 error_setg_errno(errp, errno,
