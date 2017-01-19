Received: from eggs.gnu.org ([2001:4830:134:3::10]:42273)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cUEvp-0008RE-LH
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cUEvm-0005CB-JL
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:47:21 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:48530 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cUEvm-0005Bs-9g
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:47:18 -0500
References: <1477926350-15869-1-git-send-email-ashijeetacharya@gmail.com>
	<20161031172022.GD12558@noname.redhat.com>
	<50472f2d-4a71-5f6b-1037-bbefd2d8f4f4@kamp.de>
	<20170118095952.GA5258@noname.str.redhat.com>
	<566d163c-eb70-718f-b04b-a86d6370a007@kamp.de>
	<43209b10-7760-8df6-d5a9-d6b66bebc292@redhat.com>
	<20170119152029.GA5443@noname.redhat.com>
	<772ba40f-7748-6d6a-8d7f-28ebeab14ff4@kamp.de>
	<20170119154202.GB5443@noname.redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <751aef4c-f68e-d251-cabe-257a3fbc7233@kamp.de>
Date: Thu, 19 Jan 2017 16:47:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170119154202.GB5443@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 0/2] allow blockdev-add for NFS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 19.01.2017 um 16:42 schrieb Kevin Wolf:
> Am 19.01.2017 um 16:34 hat Peter Lieven geschrieben:
>> Am 19.01.2017 um 16:20 schrieb Kevin Wolf:
>>> Am 19.01.2017 um 15:59 hat Eric Blake geschrieben:
>>>> On 01/19/2017 08:30 AM, Peter Lieven wrote:
>>>>>>> qemu-img: Could not open
>>>>>>> 'nfs://172.21.200.61/vcore-dev-cdrom/templates/VC_debian8-20170116.qcow2,linux?readahead=131072':
>>>>>>> Block protocol 'nfs' doesn't support the option 'readahead-size'
>>>>>>>
>>>>>>> Please let me know if the below fix would be correct:
>>>>>> No, this needs to be fixed the other way round: runtime_opts must use
>>>>>> the names as specified in the schema, and nfs_client_open() must access
>>>>>> them as such. Without that, blockdev-add can't work (and the command
>>>>>> line only with the "wrong" old option names from the URL, whereas it
>>>>>> should be using the same names as the QAPI schema).
>>>>> Shouldn't we support both for backwards compatiblity.?
>>>> blockdev-add only needs to support the modern naming.  But yes,
>>>> preserving back-compat spelling of the command-line spellings, as well
>>>> as matching blockdev-add spellings, is desirable.
>>> We only just added the individual command line options, previously it
>>> only supported the URL.
>>>
>>> It's true that we have the messed up version of the options in 2.8, so
>>> strictly speaking we would break compatibility with a release, but it's
>>> only one release, it's only the nfs driver, and the documentation of the
>>> options is the schema, which had the right option names even in 2.8
>>> (they just didn't work).
>>>
>>> So I wouldn't feel bad about removing the wrong names in this specific
>>> case.
>> So want exactly do you want to do? Fix the names in the QAPI schema
>> to use the old naming?
> No, fix the command line to use the names in the QAPI schema.
>
> The option names from the URL were never supposed to be supported on the
> command line.
>
> Kevin

This is what I wanted to do (before I asked ;-)):

diff --git a/block/nfs.c b/block/nfs.c
index baaecff..7c997cd 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -119,19 +119,24 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
                         qp->p[i].name);
              goto out;
          }
-        if (!strcmp(qp->p[i].name, "uid")) {
+        if (!strcmp(qp->p[i].name, "uid") ||
+            !strcmp(qp->p[i].name, "user")) {
              qdict_put(options, "user",
                        qstring_from_str(qp->p[i].value));
-        } else if (!strcmp(qp->p[i].name, "gid")) {
+        } else if (!strcmp(qp->p[i].name, "gid") ||
+                   !strcmp(qp->p[i].name, "group")) {
              qdict_put(options, "group",
                        qstring_from_str(qp->p[i].value));
-        } else if (!strcmp(qp->p[i].name, "tcp-syncnt")) {
+        } else if (!strcmp(qp->p[i].name, "tcp-syncnt") ||
+                   !strcmp(qp->p[i].name, "tcp-syn-count")) {
              qdict_put(options, "tcp-syn-count",
                        qstring_from_str(qp->p[i].value));
-        } else if (!strcmp(qp->p[i].name, "readahead")) {
+        } else if (!strcmp(qp->p[i].name, "readahead") ||
+                   !strcmp(qp->p[i].name, "readahead-size")) {
              qdict_put(options, "readahead-size",
                        qstring_from_str(qp->p[i].value));
-        } else if (!strcmp(qp->p[i].name, "pagecache")) {
+        } else if (!strcmp(qp->p[i].name, "pagecache") ||
+                   !strcmp(qp->p[i].name, "page-cache-size")) {
              qdict_put(options, "page-cache-size",
                        qstring_from_str(qp->p[i].value));
          } else if (!strcmp(qp->p[i].name, "debug")) {
@@ -359,27 +364,27 @@ static QemuOptsList runtime_opts = {
              .help = "Path of the image on the host",
          },
          {
-            .name = "uid",
+            .name = "user",
              .type = QEMU_OPT_NUMBER,
              .help = "UID value to use when talking to the server",
          },
          {
-            .name = "gid",
+            .name = "group",
              .type = QEMU_OPT_NUMBER,
              .help = "GID value to use when talking to the server",
          },
          {
-            .name = "tcp-syncnt",
+            .name = "tcp-syn-count",
              .type = QEMU_OPT_NUMBER,
              .help = "Number of SYNs to send during the session establish",
          },
          {
-            .name = "readahead",
+            .name = "readahead-size",
              .type = QEMU_OPT_NUMBER,
              .help = "Set the readahead size in bytes",
          },
          {
-            .name = "pagecache",
+            .name = "page-cache-size",
              .type = QEMU_OPT_NUMBER,
              .help = "Set the pagecache size in bytes",
          },
@@ -508,29 +513,29 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
          goto fail;
      }

-    if (qemu_opt_get(opts, "uid")) {
-        client->uid = qemu_opt_get_number(opts, "uid", 0);
+    if (qemu_opt_get(opts, "user")) {
+        client->uid = qemu_opt_get_number(opts, "user", 0);
          nfs_set_uid(client->context, client->uid);
      }

-    if (qemu_opt_get(opts, "gid")) {
-        client->gid = qemu_opt_get_number(opts, "gid", 0);
+    if (qemu_opt_get(opts, "group")) {
+        client->gid = qemu_opt_get_number(opts, "group", 0);
          nfs_set_gid(client->context, client->gid);
      }

-    if (qemu_opt_get(opts, "tcp-syncnt")) {
-        client->tcp_syncnt = qemu_opt_get_number(opts, "tcp-syncnt", 0);
+    if (qemu_opt_get(opts, "tcp-syn-count")) {
+        client->tcp_syncnt = qemu_opt_get_number(opts, "tcp-syn-count", 0);
          nfs_set_tcp_syncnt(client->context, client->tcp_syncnt);
      }

  #ifdef LIBNFS_FEATURE_READAHEAD
-    if (qemu_opt_get(opts, "readahead")) {
+    if (qemu_opt_get(opts, "readahead-size")) {
          if (open_flags & BDRV_O_NOCACHE) {
              error_setg(errp, "Cannot enable NFS readahead "
                               "if cache.direct = on");
              goto fail;
          }
-        client->readahead = qemu_opt_get_number(opts, "readahead", 0);
+        client->readahead = qemu_opt_get_number(opts, "readahead-size", 0);
          if (client->readahead > QEMU_NFS_MAX_READAHEAD_SIZE) {
              error_report("NFS Warning: Truncating NFS readahead "
                           "size to %d", QEMU_NFS_MAX_READAHEAD_SIZE);
@@ -545,13 +550,13 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
  #endif

  #ifdef LIBNFS_FEATURE_PAGECACHE
-    if (qemu_opt_get(opts, "pagecache")) {
+    if (qemu_opt_get(opts, "page-cache-size")) {
          if (open_flags & BDRV_O_NOCACHE) {
              error_setg(errp, "Cannot enable NFS pagecache "
                               "if cache.direct = on");
              goto fail;
          }
-        client->pagecache = qemu_opt_get_number(opts, "pagecache", 0);
+        client->pagecache = qemu_opt_get_number(opts, "page-cache-size", 0);
          if (client->pagecache > QEMU_NFS_MAX_PAGECACHE_SIZE) {
              error_report("NFS Warning: Truncating NFS pagecache "
                           "size to %d pages", QEMU_NFS_MAX_PAGECACHE_SIZE);


Peter
