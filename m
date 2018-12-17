Received: from eggs.gnu.org ([2001:4830:134:3::10]:43461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ292-0000hG-3E
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ290-0003t5-TB
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ290-0003se-KL
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DDED27FDE5
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:17:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:46 +0100
Message-Id: <20181217231700.24482-22-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/35] qga: drop < Vista compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Building QGA for XP seems possible so far: the dependency on
libqemuutil.a implies building qemu-thread-win32.c, which requires
Vista API since commit 12f8def0 (v2.9). But qemu-thread isn't being
used in QGA, the resulting binary may still work on XP.  XP is no
longer supported for the past 4.5y, it's time to drop support for it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181122110039.15972-5-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/commands-win32.c | 64 --------------------------------------------
 1 file changed, 64 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index f03b9c1d89..989b93e702 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -466,13 +466,11 @@ static STORAGE_BUS_TYPE win2qemu[] =3D {
     [BusTypeFibre] =3D GUEST_DISK_BUS_TYPE_SSA,
     [BusTypeUsb] =3D GUEST_DISK_BUS_TYPE_USB,
     [BusTypeRAID] =3D GUEST_DISK_BUS_TYPE_RAID,
-#if (_WIN32_WINNT >=3D 0x0600)
     [BusTypeiScsi] =3D GUEST_DISK_BUS_TYPE_ISCSI,
     [BusTypeSas] =3D GUEST_DISK_BUS_TYPE_SAS,
     [BusTypeSata] =3D GUEST_DISK_BUS_TYPE_SATA,
     [BusTypeSd] =3D  GUEST_DISK_BUS_TYPE_SD,
     [BusTypeMmc] =3D GUEST_DISK_BUS_TYPE_MMC,
-#endif
 #if (_WIN32_WINNT >=3D 0x0601)
     [BusTypeVirtual] =3D GUEST_DISK_BUS_TYPE_VIRTUAL,
     [BusTypeFileBackedVirtual] =3D GUEST_DISK_BUS_TYPE_FILE_BACKED_VIRTU=
AL,
@@ -724,10 +722,8 @@ static void get_single_disk_info(GuestDiskAddress *d=
isk, Error **errp)
     if (disk->bus_type =3D=3D GUEST_DISK_BUS_TYPE_SCSI
             || disk->bus_type =3D=3D GUEST_DISK_BUS_TYPE_IDE
             || disk->bus_type =3D=3D GUEST_DISK_BUS_TYPE_RAID
-#if (_WIN32_WINNT >=3D 0x0600)
             /* This bus type is not supported before Windows Server 2003=
 SP1 */
             || disk->bus_type =3D=3D GUEST_DISK_BUS_TYPE_SAS
-#endif
         ) {
         /* We are able to use the same ioctls for different bus types
          * according to Microsoft docs
@@ -1322,7 +1318,6 @@ static char *guest_addr_to_str(IP_ADAPTER_UNICAST_A=
DDRESS *ip_addr,
     return NULL;
 }
=20
-#if (_WIN32_WINNT >=3D 0x0600)
 static int64_t guest_ip_prefix(IP_ADAPTER_UNICAST_ADDRESS *ip_addr)
 {
     /* For Windows Vista/2008 and newer, use the OnLinkPrefixLength
@@ -1330,60 +1325,6 @@ static int64_t guest_ip_prefix(IP_ADAPTER_UNICAST_=
ADDRESS *ip_addr)
      */
     return ip_addr->OnLinkPrefixLength;
 }
-#else
-/* When using the Windows XP and 2003 build environment, do the best we =
can to
- * figure out the prefix.
- */
-static IP_ADAPTER_INFO *guest_get_adapters_info(void)
-{
-    IP_ADAPTER_INFO *adptr_info =3D NULL;
-    ULONG adptr_info_len =3D 0;
-    DWORD ret;
-
-    /* Call the first time to get the adptr_info_len. */
-    GetAdaptersInfo(adptr_info, &adptr_info_len);
-
-    adptr_info =3D g_malloc(adptr_info_len);
-    ret =3D GetAdaptersInfo(adptr_info, &adptr_info_len);
-    if (ret !=3D ERROR_SUCCESS) {
-        g_free(adptr_info);
-        adptr_info =3D NULL;
-    }
-    return adptr_info;
-}
-
-static int64_t guest_ip_prefix(IP_ADAPTER_UNICAST_ADDRESS *ip_addr)
-{
-    int64_t prefix =3D -1; /* Use for AF_INET6 and unknown/undetermined =
values. */
-    IP_ADAPTER_INFO *adptr_info, *info;
-    IP_ADDR_STRING *ip;
-    struct in_addr *p;
-
-    if (ip_addr->Address.lpSockaddr->sa_family !=3D AF_INET) {
-        return prefix;
-    }
-    adptr_info =3D guest_get_adapters_info();
-    if (adptr_info =3D=3D NULL) {
-        return prefix;
-    }
-
-    /* Match up the passed in ip_addr with one found in adaptr_info.
-     * The matching one in adptr_info will have the netmask.
-     */
-    p =3D &((struct sockaddr_in *)ip_addr->Address.lpSockaddr)->sin_addr=
;
-    for (info =3D adptr_info; info; info =3D info->Next) {
-        for (ip =3D &info->IpAddressList; ip; ip =3D ip->Next) {
-            if (p->S_un.S_addr =3D=3D inet_addr(ip->IpAddress.String)) {
-                prefix =3D ctpop32(inet_addr(ip->IpMask.String));
-                goto out;
-            }
-        }
-    }
-out:
-    g_free(adptr_info);
-    return prefix;
-}
-#endif
=20
 #define INTERFACE_PATH_BUF_SZ 512
=20
@@ -1904,7 +1845,6 @@ typedef struct _GA_WTSINFOA {
=20
 GuestUserList *qmp_guest_get_users(Error **err)
 {
-#if (_WIN32_WINNT >=3D 0x0600)
 #define QGA_NANOSECONDS 10000000
=20
     GHashTable *cache =3D NULL;
@@ -1974,10 +1914,6 @@ GuestUserList *qmp_guest_get_users(Error **err)
     }
     g_hash_table_destroy(cache);
     return head;
-#else
-    error_setg(err, QERR_UNSUPPORTED);
-    return NULL;
-#endif
 }
=20
 typedef struct _ga_matrix_lookup_t {
--=20
2.20.1
