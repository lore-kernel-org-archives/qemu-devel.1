Received: from eggs.gnu.org ([2001:4830:134:3::10]:34450)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cTVTT-0002x5-Bi
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cTVTQ-0005Rt-5c
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:15:03 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:33006 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cTVTP-0005HM-SB
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:15:00 -0500
References: <1477926350-15869-1-git-send-email-ashijeetacharya@gmail.com>
	<20161031172022.GD12558@noname.redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <50472f2d-4a71-5f6b-1037-bbefd2d8f4f4@kamp.de>
Date: Tue, 17 Jan 2017 16:14:55 +0100
MIME-Version: 1.0
In-Reply-To: <20161031172022.GD12558@noname.redhat.com>
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
To: Kevin Wolf <kwolf@redhat.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: eblake@redhat.com, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 31.10.2016 um 18:20 schrieb Kevin Wolf:
> Am 31.10.2016 um 16:05 hat Ashijeet Acharya geschrieben:
>> Previously posted series patches:
>> v5: https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07580.html
>> v4: https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07449.html
>> v3: https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg06903.html
>> v2: https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg05844.html
>> v1: https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg04487.html
>>
>> This series adds blockdev-add support for NFS block driver.
> Thanks, fixed as commented on patch 1 and applied.

Hi,

it seems this series breaks passing options via URI.

1) in nfs_parse_uri

parse_uint_full(qp->p[i].value, NULL, 0)

segfaults, as the routine wants to set *NULL = val.

Program received signal SIGSEGV, Segmentation fault.
parse_uint (s=0x555555d0ead0 "131072", value=value@entry=0x0, endptr=endptr@entry=0x7fffffffd870, base=base@entry=0) at util/cutils.c:475
475        *value = val;
(gdb) bt full
#0  parse_uint (s=0x555555d0ead0 "131072", value=value@entry=0x0, endptr=endptr@entry=0x7fffffffd870, base=base@entry=0) at util/cutils.c:475
         r = 0
         endp = 0x555555d0ead6 ""
         val = 131072
#1  0x0000555555655ff2 in parse_uint_full (s=<optimized out>, value=value@entry=0x0, base=base@entry=0) at util/cutils.c:499
         endp = 0x555555d093f0 "\004"
         r = <optimized out>
#2  0x0000555555603425 in nfs_parse_uri (filename=<optimized out>, options=0x555555d093f0, errp=0x7fffffffd980) at block/nfs.c:116
         uri = 0x555555d0e920
         qp = 0x555555d0ea30
         ret = -22
         i = 0
         __func__ = "nfs_parse_uri"
#3  0x000055555559c7bb in bdrv_fill_options (errp=0x7fffffffd968, flags=0x7fffffffd95c, filename=<optimized out>, options=<synthetischer Zeiger>) at block.c:1278
         drvname = <optimized out>
         protocol = <optimized out>
         local_err = 0x0
         parse_filename = true
         drv = 0x5555558e3140 <bdrv_nfs>


2) all parameters that have a different names in options and qdict
e.g. readahead-size vs. readahead cannot be passed via URI.

$ qemu-img convert -p nfs://172.21.200.61/templates/VC_debian8-20170116.qcow2,linux\?readahead=131072 iscsi://172.21.200.56:3260/iqn.2001-05.com.equallogic:0-8a0906-69d384e0a-aa3004e55e15878d-XXX/0

qemu-img: Could not open 'nfs://172.21.200.61/vcore-dev-cdrom/templates/VC_debian8-20170116.qcow2,linux?readahead=131072': Block protocol 'nfs' doesn't support the option 'readahead-size'

Please let me know if the below fix would be correct:

lieven@lieven-pc:~/git/qemu$ git diff
diff --git a/block/nfs.c b/block/nfs.c
index a564340..0ff8268 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -108,30 +108,31 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
      qdict_put(options, "path", qstring_from_str(uri->path));

      for (i = 0; i < qp->n; i++) {
+        unsigned long long val;
          if (!qp->p[i].value) {
              error_setg(errp, "Value for NFS parameter expected: %s",
                         qp->p[i].name);
              goto out;
          }
-        if (parse_uint_full(qp->p[i].value, NULL, 0)) {
+        if (parse_uint_full(qp->p[i].value, &val, 0)) {
              error_setg(errp, "Illegal value for NFS parameter: %s",
                         qp->p[i].name);
              goto out;
          }
          if (!strcmp(qp->p[i].name, "uid")) {
-            qdict_put(options, "user",
+            qdict_put(options, "uid",
                        qstring_from_str(qp->p[i].value));
          } else if (!strcmp(qp->p[i].name, "gid")) {
-            qdict_put(options, "group",
+            qdict_put(options, "gid",
                        qstring_from_str(qp->p[i].value));
          } else if (!strcmp(qp->p[i].name, "tcp-syncnt")) {
-            qdict_put(options, "tcp-syn-count",
+            qdict_put(options, "tcp-syncnt",
                        qstring_from_str(qp->p[i].value));
          } else if (!strcmp(qp->p[i].name, "readahead")) {
-            qdict_put(options, "readahead-size",
+            qdict_put(options, "readahead",
                        qstring_from_str(qp->p[i].value));
          } else if (!strcmp(qp->p[i].name, "pagecache")) {
-            qdict_put(options, "page-cache-size",
+            qdict_put(options, "pagecache",
                        qstring_from_str(qp->p[i].value));
          } else if (!strcmp(qp->p[i].name, "debug")) {
              qdict_put(options, "debug",


Thanks,
Peter
