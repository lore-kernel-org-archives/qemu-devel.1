Received: from eggs.gnu.org ([2001:4830:134:3::10]:54564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctcJ1-0005mv-Ad
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctcIz-0007Ld-Fz
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:48:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<20170330152913.orppqht62xrl2rmw@eukaryote>
Date: Thu, 30 Mar 2017 17:47:59 +0200
In-Reply-To: <20170330152913.orppqht62xrl2rmw@eukaryote> (Kashyap Chamarthy's
	message of "Thu, 30 Mar 2017 17:29:13 +0200")
Message-ID: <87efxeu5ow.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [RFC v2 for-2.9 00/10] Fixes and
 cleanups around SocketAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, qemu-devel@nongnu.org, mreitz@redhat.com, namei.unix@gmail.com, pbonzini@redhat.com

Kashyap Chamarthy <kchamart@redhat.com> writes:

> On Thu, Mar 30, 2017 at 03:14:57PM +0200, Markus Armbruster wrote:
>> What makes this 2.9 material is the crash bug fixed in PATCH 2 and the
>> QAPI/QMP interface cleanups in PATCH 7+8.
>> 
>> This is RFC because:
>> 
>> 1. To give you one more chance to ask for undocumented -drive
>>    driver=nbd usage compatibility [PATCH 08+09].
>> 
>> 2. Another round of sheepdog tests is still in progress (with
>>    Kashyap's help).
>> 
>> Max, please have a close look at PATCH 11, I hope this is what you
>> meant when you asked for "parsing @server".
>> 
>> v2:
>> * PATCH 01+02+04+05 unchanged.
>> * PATCH 03 error message improved, blank line [Max]
>> * PATCH 06 commit message typo [Max]
>> * PATCH 07 new, factored out of old PATCH 7
>> * PATCH 08-10 updated, please re-review
>> 
>> Markus Armbruster (10):
>>   nbd sockets vnc: Mark problematic address family tests TODO
>>   char: Fix socket with "type": "vsock" address
>>   io vnc sockets: Clean up SocketAddressKind switches
>>   block: Document -drive problematic code and bugs
>>   gluster: Prepare for SocketAddressFlat extension
>>   qapi-schema: SocketAddressFlat variants 'vsock' and 'fd'
>>   sockets: New helper socket_address_crumple()
>>   nbd: Tidy up blockdev-add interface
>>   squash! nbd: Tidy up blockdev-add interface
>>   sheepdog: Fix blockdev-add
>
> FWIW:
>
> Tested-by: Kashyap Chamarthy <kchamart@redhat.com>
>
> Details:
>
> Env
> ~~~
>
> I prepared a two-node Sheepdog cluster with Corosync.  Setup info:
>
> 	https://kashyapc.fedorapeople.org/virt/sheepdog-qemu-corosync.txt
>
> And used Markus' branch 'blockdev-fixes-debug':

blockdev-fixes-dbg, actually.  Its this series plus a few debug prints,
diffs appended.

>
>     http://repo.or.cz/qemu/armbru.git/tree/refs/heads/blockdev-fixes-dbg
>
>     $ git describe
>     pull-misc-2017-03-28-27-g885750d
>     
>     $ ./qemu-system-x86_64 -version
>     QEMU emulator version 2.8.92 (v2.9.0-rc1-110-g885750d)
>     Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
>
> Tests
> ~~~~~
>
> There are four of them (thanks Markus):
>
> [OK] Test-1: Syntax: sheepdog:hostname:port:Alice

The old -drive pseudo-filename syntax.

> [OK] Test-2: Syntax: sheepdog://hostname:port/Alice

The new -drive pseudo-filename syntax.

> [OK] Test-3: Syntax: -drive if=none,driver=sheepdog,server.type=inet,server.host=hostname,server.port=port,vdi=Alice

Unsugared -drive syntax.

> [OK] Test-4: Syntax: -blockdev node-name=nn,driver=sheepdog,server.type=inet,server.host=host,server.port=port,vdi=Alice

-blockdev, obviously.

> Complete test invocation 
> ~~~~~~~~~~~~~~~~~~~~~~~~
>
> Test-1: Syntax: sheepdog:hostname:port:Alice
> -----------------------------------------------------------------------
> $ ./qemu-system-x86_64 -display none -nodefconfig -nodefaults sheepdog:192.168.122.84:7000:Alice
> @@@ server.host=192.168.122.84
> @@@ server.port=7000
> @@@ tag=
> @@@ server.type=inet
> @@@ vdi=Alice
> ### vdi=Alice addr=192.168.122.84:7000 snap-id=(null) tag=
> WARNING: Image format was not specified for 'json:{"server.host": "192.168.122.84", "server.port": "7000", "tag": "", "driver": "sheepdog", "server.type": "inet", "vdi": "Alice"}' and probing guessed raw.
>          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
>          Specify the 'raw' format explicitly to remove the restrictions.
> -----------------------------------------------------------------------
>
> Test-2: Syntax: sheepdog://hostname:port/Alice
> -----------------------------------------------------------------------
> $ ./qemu-system-x86_64 -display none -nodefconfig -nodefaults sheepdog://192.168.122.84:7000/Alice
> @@@ server.host=192.168.122.84
> @@@ server.port=7000
> @@@ tag=
> @@@ server.type=inet
> @@@ vdi=Alice
> ### vdi=Alice addr=192.168.122.84:7000 snap-id=(null) tag=
> WARNING: Image format was not specified for 'json:{"server.host": "192.168.122.84", "server.port": "7000", "tag": "", "driver": "sheepdog", "server.type": "inet", "vdi": "Alice"}' and probing guessed raw.
>          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
>          Specify the 'raw' format explicitly to remove the restrictions.
> -----------------------------------------------------------------------
>
> Test-3: Syntax: -drive \
> if=none,driver=sheepdog,server.type=inet,server.host=hostname,server.port=port,vdi=Alice
> -----------------------------------------------------------------------
> $ ./qemu-system-x86_64 -display none -nodefconfig -nodefaults -drive if=none,driver=sheepdog,server.type=inet,server.host=192.168.122.84,server.port=7000,vdi=Alice
> @@@ server.host=192.168.122.84
> @@@ server.port=7000
> @@@ server.type=inet
> @@@ vdi=Alice
> ### vdi=Alice addr=192.168.122.84:7000 snap-id=(null) tag=
> -----------------------------------------------------------------------
>
> Test-4: Syntax: -blockdev \
> node-name=nn,driver=sheepdog,server.type=inet,server.host=host,server.port=port,vdi=Alice
> -----------------------------------------------------------------------
> $ ./qemu-system-x86_64 -display none -nodefconfig -nodefaults -blockdev node-name=nn,driver=sheepdog,server.type=inet,server.host=192.168.122.84,server.port=7000,vdi=Alice
> @@@ server.port=7000
> @@@ server.host=192.168.122.84
> @@@ server.type=inet
> @@@ vdi=Alice
> ### vdi=Alice addr=192.168.122.84:7000 snap-id=(null) tag=
> -----------------------------------------------------------------------

Thanks a lot for your help with testing!


diff --git a/block/nbd.c b/block/nbd.c
index 8bb29a9..9b3e361 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -41,6 +41,44 @@
 #include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
 
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qfloat.h"
+
+static void qdict_print(QDict *qdict)
+{
+    const QDictEntry *entry;
+    for (entry = qdict_first(qdict); entry; entry = qdict_next(qdict, entry)) {
+        printf("@@@ %s=", entry->key);
+        switch (qobject_type(entry->value)) {
+        default:
+            printf("crap\n");
+            break;
+        case QTYPE_QNULL:
+            printf("null\n");
+            break;
+        case QTYPE_QINT:
+            printf("%" PRId64 "\n", qint_get_int(qobject_to_qint(entry->value)));
+            break;
+        case QTYPE_QSTRING:
+            printf("%s\n", qstring_get_str(qobject_to_qstring(entry->value)));
+            break;
+        case QTYPE_QDICT:
+            printf("dict\n");
+            break;
+        case QTYPE_QLIST:
+            printf("list\n");
+            break;
+        case QTYPE_QFLOAT:
+            printf("%g\n", qfloat_get_double(qobject_to_qfloat(entry->value)));
+            break;
+        case QTYPE_QBOOL:
+            printf("%s\n", qbool_get_bool(qobject_to_qbool(entry->value)) ? "true" : "false");
+            break;
+        }
+    }
+
+}
+
 #define EN_OPTSTR ":exportname="
 
 typedef struct BDRVNBDState {
@@ -405,6 +443,8 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     const char *hostname = NULL;
     int ret = -EINVAL;
 
+    qdict_print(options);
+
     opts = qemu_opts_create(&nbd_runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
@@ -449,6 +489,23 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto error;
     }
 
+    printf("### type=%u\n", s->saddr->type);
+    switch (s->saddr->type) {
+    case SOCKET_ADDRESS_KIND_INET:
+        printf("    host=%s\n    port=%s\n",
+               s->saddr->u.inet.host,
+               s->saddr->u.inet.port);
+        break;
+    case SOCKET_ADDRESS_KIND_UNIX:
+        printf("    path=%s\n",
+               s->saddr->u.q_unix.path);
+        break;
+    default:
+        ;
+    }
+    printf("    export=%s\n    tls-creds=%s\n",
+           s->export, s->tlscredsid);
+
     /* NBD handshake */
     ret = nbd_client_init(bs, sioc, s->export,
                           tlscreds, hostname, errp);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index c81013d..a9ed709 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -26,6 +26,47 @@
 #include "qemu/bitops.h"
 #include "qemu/cutils.h"
 
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qint.h"
+#include "qapi/qmp/qfloat.h"
+#include "qapi/qmp/qstring.h"
+
+static void qdict_print(QDict *qdict)
+{
+    const QDictEntry *entry;
+    for (entry = qdict_first(qdict); entry; entry = qdict_next(qdict, entry)) {
+        printf("@@@ %s=", entry->key);
+        switch (qobject_type(entry->value)) {
+        default:
+            printf("crap\n");
+            break;
+        case QTYPE_QNULL:
+            printf("null\n");
+            break;
+        case QTYPE_QINT:
+            printf("%" PRId64 "\n", qint_get_int(qobject_to_qint(entry->value)));
+            break;
+        case QTYPE_QSTRING:
+            printf("%s\n", qstring_get_str(qobject_to_qstring(entry->value)));
+            break;
+        case QTYPE_QDICT:
+            printf("dict\n");
+            break;
+        case QTYPE_QLIST:
+            printf("list\n");
+            break;
+        case QTYPE_QFLOAT:
+            printf("%g\n", qfloat_get_double(qobject_to_qfloat(entry->value)));
+            break;
+        case QTYPE_QBOOL:
+            printf("%s\n", qbool_get_bool(qobject_to_qbool(entry->value)) ? "true" : "false");
+            break;
+        }
+    }
+
+}
+
+
 #define SD_PROTO_VER 0x01
 
 #define SD_DEFAULT_ADDR "localhost"
@@ -1582,6 +1623,8 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     QemuOpts *opts;
     Error *local_err = NULL;
 
+    qdict_print(options);
+
     s->bs = bs;
     s->aio_context = bdrv_get_aio_context(bs);
 
@@ -1634,6 +1677,13 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
         goto err_no_fd;
     }
 
+    {
+        char *addr = socket_address_to_string(s->addr, &error_abort);
+        printf("### vdi=%s addr=%s snap-id=%s tag=%s\n",
+           vdi, addr, snap_id_str, tag);
+        g_free(addr);
+    }
+
     QLIST_INIT(&s->inflight_aio_head);
     QLIST_INIT(&s->failed_aio_head);
     QLIST_INIT(&s->inflight_aiocb_head);
