Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A1AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 14:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E3520BED
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 14:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwHIORoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E3520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMBMJ-0005MM-DF
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 10:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kMBJj-00035R-7l
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 10:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kMBJg-00017A-Sl
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 10:36:50 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601131007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oecpNUsjvR04vetNWifGHrHOhZMqkYWvEnSOBwYKK2U=;
 b=fwHIORoa57CovLbBDyQrXQLTwcGSXTbAT7zZpN9e/ipz8RH8d8maWEDJvWaeLdwLaA0XzF
 5kuSbAZBeJ21jeUk6by72Q4MPFQ5FOX3yRXMwCFm7w/+YoFb3L+fRjTQXJC/g3xi4/pBo2
 KunDRUvm8kZy7nnKoOKE8MaVDIs/HFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-iJJ9WBTNM0yac2R3hYiucg-1; Sat, 26 Sep 2020 10:36:46 -0400
X-MC-Unique: iJJ9WBTNM0yac2R3hYiucg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1062F1074644;
 Sat, 26 Sep 2020 14:36:45 +0000 (UTC)
Received: from pick.home.annexia.org (ovpn-112-51.ams2.redhat.com
 [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E54C055765;
 Sat, 26 Sep 2020 14:36:43 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: libguestfs@redhat.com
Subject: [PATCH nbdinfo proposal] info: Add a --map option for displaying
 allocation metadata.
Date: Sat, 26 Sep 2020 15:36:37 +0100
Message-Id: <20200926143637.1936793-2-rjones@redhat.com>
In-Reply-To: <20200926143637.1936793-1-rjones@redhat.com>
References: <20200926143637.1936793-1-rjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 10:36:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: vsementsov@virtuozzo.com, pkrempa@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---
 info/nbdinfo.c   | 132 ++++++++++++++++++++++++++++++++++++++++++++---
 info/nbdinfo.pod |  39 +++++++++++++-
 2 files changed, 164 insertions(+), 7 deletions(-)

diff --git a/info/nbdinfo.c b/info/nbdinfo.c
index 647a24c..d1648b8 100644
--- a/info/nbdinfo.c
+++ b/info/nbdinfo.c
@@ -34,6 +34,7 @@
 static bool list_all = false;
 static bool probe_content, content_flag, no_content_flag;
 static bool json_output = false;
+static const char *map = NULL;
 static bool size_only = false;
 
 static struct export_list {
@@ -49,6 +50,10 @@ static void list_one_export (struct nbd_handle *nbd, const char *desc,
 static void list_all_exports (struct nbd_handle *nbd1, const char *uri);
 static void print_json_string (const char *);
 static char *get_content (struct nbd_handle *, int64_t size);
+static int extent_callback (void *user_data, const char *metacontext,
+                            uint64_t offset,
+                            uint32_t *entries, size_t nr_entries,
+                            int *error);
 
 static void __attribute__((noreturn))
 usage (FILE *fp, int exitcode)
@@ -60,6 +65,7 @@ usage (FILE *fp, int exitcode)
 "    nbdinfo nbd://localhost\n"
 "    nbdinfo \"nbd+unix:///?socket=/tmp/unixsock\"\n"
 "    nbdinfo --size nbd://example.com\n"
+"    nbdinfo --map nbd://example.com\n"
 "    nbdinfo --json nbd://example.com\n"
 "    nbdinfo --list nbd://example.com\n"
 "\n"
@@ -85,6 +91,7 @@ main (int argc, char *argv[])
     CONTENT_OPTION,
     NO_CONTENT_OPTION,
     JSON_OPTION,
+    MAP_OPTION,
     SIZE_OPTION,
   };
   const char *short_options = "LV";
@@ -95,6 +102,7 @@ main (int argc, char *argv[])
     { "json",               no_argument,       NULL, JSON_OPTION },
     { "list",               no_argument,       NULL, 'L' },
     { "long-options",       no_argument,       NULL, LONG_OPTIONS },
+    { "map",                optional_argument, NULL, MAP_OPTION },
     { "short-options",      no_argument,       NULL, SHORT_OPTIONS },
     { "size",               no_argument,       NULL, SIZE_OPTION },
     { "version",            no_argument,       NULL, 'V' },
@@ -143,6 +151,10 @@ main (int argc, char *argv[])
       no_content_flag = true;
       break;
 
+    case MAP_OPTION:
+      map = optarg ? optarg : "base:allocation";
+      break;
+
     case SIZE_OPTION:
       size_only = true;
       break;
@@ -164,10 +176,11 @@ main (int argc, char *argv[])
   if (argc - optind != 1)
     usage (stderr, EXIT_FAILURE);
 
-  /* You can combine certain options. */
-  if (list_all && size_only) {
-    fprintf (stderr, "%s: you cannot use %s and %s together.\n",
-             argv[0], "--list", "--size");
+  /* You cannot combine certain options. */
+  if (!!list_all + !!map + !!size_only > 1) {
+    fprintf (stderr,
+             "%s: you cannot use --list, --map and --size together.\n",
+             argv[0]);
     exit (EXIT_FAILURE);
   }
   if (content_flag && no_content_flag) {
@@ -182,6 +195,8 @@ main (int argc, char *argv[])
     probe_content = true;
   if (no_content_flag)
     probe_content = false;
+  if (map)
+    probe_content = false;
 
   /* Open the NBD side. */
   nbd = nbd_create ();
@@ -191,11 +206,13 @@ main (int argc, char *argv[])
   }
   nbd_set_uri_allow_local_file (nbd, true); /* Allow ?tls-psk-file. */
 
-  /* If using --list then we need opt mode in the handle. */
+  /* Set optional modes in the handle. */
   if (list_all)
     nbd_set_opt_mode (nbd, true);
-  if (!size_only)
+  if (!map && !size_only)
     nbd_set_full_info (nbd, true);
+  if (map)
+    nbd_add_meta_context (nbd, map);
 
   if (nbd_connect_uri (nbd, argv[optind]) == -1) {
     fprintf (stderr, "%s\n", nbd_get_error ());
@@ -225,6 +242,43 @@ main (int argc, char *argv[])
 
     printf ("%" PRIi64 "\n", size);
   }
+  else if (map) {
+    uint64_t offset, prev_offset;
+
+    /* Did we get the requested map? */
+    if (!nbd_can_meta_context (nbd, map)) {
+      fprintf (stderr,
+               "%s: --map: server does not support metadata context \"%s\"\n",
+               argv[0], map);
+      exit (EXIT_FAILURE);
+    }
+
+    size = nbd_get_size (nbd);
+    if (size == -1) {
+      fprintf (stderr, "%s\n", nbd_get_error ());
+      exit (EXIT_FAILURE);
+    }
+
+    for (offset = 0; offset < size;) {
+      prev_offset = offset;
+      if (nbd_block_status (nbd, size - offset, offset,
+                            (nbd_extent_callback) { .callback = extent_callback,
+                                                    .user_data = &offset },
+                            0) == -1) {
+        fprintf (stderr, "%s\n", nbd_get_error ());
+        exit (EXIT_FAILURE);
+      }
+      /* We expect extent_callback to increment the offset.  If it did
+       * not then probably the server is not returning any extents.
+       */
+      if (offset <= prev_offset) {
+        fprintf (stderr, "%s: --map: server did not return any extents\n",
+                 argv[0]);
+        exit (EXIT_FAILURE);
+      }
+    }
+    if (json_output) printf ("\n");
+  }
   else {
     /* Print per-connection fields. */
     protocol = nbd_get_protocol (nbd);
@@ -591,3 +645,69 @@ get_content (struct nbd_handle *nbd, int64_t size)
   free (cmd);
   return ret;                   /* caller frees */
 }
+
+/* Callback handling --map. */
+static const char *
+extent_description (const char *metacontext, uint32_t type)
+{
+  if (strcmp (metacontext, "base:allocation") == 0) {
+    switch (type) {
+    case 0: return "allocated";
+    case 1: return "zero";
+    case 2: return "hole";
+    case 3: return "hole,zero";
+    }
+  }
+  else if (strcmp (metacontext, "qemu:dirty-bitmap") == 0) {
+    switch (type) {
+    case 0: return "dirty";
+    case 1: return "clean";
+    }
+  }
+
+  return "unknown";
+}
+
+static int
+extent_callback (void *user_data, const char *metacontext,
+                 uint64_t offset,
+                 uint32_t *entries, size_t nr_entries,
+                 int *error)
+{
+  size_t i;
+  uint64_t *ret_offset = user_data;
+  static bool comma = false;
+
+  if (strcmp (metacontext, map) != 0)
+    return 0;
+
+  /* Print the entries received. */
+  for (i = 0; i < nr_entries; i += 2) {
+    const char *descr = extent_description (map, entries[i+1]);
+
+    if (!json_output) {
+      printf ("%" PRIu64 "  "
+              "%" PRIu32 "  "
+              "%" PRIu32 "  "
+              "%s\n",
+              offset, entries[i], entries[i+1], descr);
+    }
+    else {
+      if (comma)
+        printf (",\n");
+
+      printf ("[%" PRIu64 ", "
+              "%" PRIu32 ", "
+              "%" PRIu32 ", ",
+              offset, entries[i], entries[i+1]);
+      print_json_string (descr);
+      printf ("]");
+      comma = true;
+    }
+
+    offset += entries[i];
+  }
+
+  *ret_offset = offset;
+  return 0;
+}
diff --git a/info/nbdinfo.pod b/info/nbdinfo.pod
index 19305bf..dbfb62f 100644
--- a/info/nbdinfo.pod
+++ b/info/nbdinfo.pod
@@ -4,7 +4,7 @@ nbdinfo - display information and metadata about NBD servers and exports
 
 =head1 SYNOPSIS
 
- nbdinfo [--json] [--size] NBD-URI
+ nbdinfo [--json] [--map] [--size] NBD-URI
 
  nbdinfo -L|--list NBD-URI
 
@@ -20,6 +20,8 @@ nbdinfo - display information and metadata about NBD servers and exports
 
  nbdinfo --size nbd://example.com
 
+ nbdinfo --map nbd://example.com
+
  nbdinfo --json nbd://example.com
 
  nbdinfo --list nbd://example.com
@@ -84,6 +86,32 @@ the I<--json> parameter:
    ]
  }
 
+=head3 Map
+
+To show a map which areas of the disk are allocated and sparse, use
+the I<--map> option:
+
+ $ nbdinfo --map nbd://localhost/
+ 0        1048576  0  allocated
+ 1048576  2097152  3  hole,zero
+
+The fields are: start size type description.
+
+The type field is an integer showing the raw value from the NBD
+protocol.  For some maps nbdinfo knows how to translate the type into
+a printable description.
+
+By default this shows the C<"base:allocation"> map, but you can show
+other maps too:
+
+ $ nbdinfo --map=qemu:dirty-bitmap nbd://localhost/
+ 0  1048576  dirty
+
+For more information on NBD maps, see I<Metadata querying> in the NBD
+protocol.  I<--json> can also be used here for parsable JSON output.
+
+=head3 List of exports
+
 To list all the exports available on an NBD server use the I<--list>
 (I<-L>) option.
 
@@ -122,6 +150,15 @@ use I<--list --content>.
 
 The output is displayed in JSON format.
 
+=item B<--map>
+
+=item B<--map=>MAP
+
+Display the map (usually whether parts of the disk are allocated or
+sparse) of the given export.  This displays the C<"base:allocation">
+map by default, you can choose a different map with the optional
+parameter.
+
 =item B<-L>
 
 =item B<--list>
-- 
2.27.0


