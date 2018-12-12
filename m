Received: from eggs.gnu.org ([2001:4830:134:3::10]:52275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MZ-0000qJ-DH
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MX-0000Ep-FB
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:51 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:46532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MX-00008l-2R
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:49 -0500
Received: by mail-wr1-x434.google.com with SMTP id l9so18047851wrt.13
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:42 +0100
Message-Id: <1544628195-37728-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/54] RFC: qga: drop < Vista compatibility
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Building QGA for XP seems possible so far: the dependency on
libqemuutil.a implies building qemu-thread-win32.c, which requires
Vista API since commit 12f8def0 (v2.9). But qemu-thread isn't being
used in QGA, the resulting binary may still work on XP.  XP is no
longer supported for the past 4.5y, it's time to drop support for it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181122110039.15972-5-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/commands-win32.c | 64 ----------------------------------------------------
 1 file changed, 64 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index f03b9c1..989b93e 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -466,13 +466,11 @@ static STORAGE_BUS_TYPE win2qemu[] = {
     [BusTypeFibre] = GUEST_DISK_BUS_TYPE_SSA,
     [BusTypeUsb] = GUEST_DISK_BUS_TYPE_USB,
     [BusTypeRAID] = GUEST_DISK_BUS_TYPE_RAID,
-#if (_WIN32_WINNT >= 0x0600)
     [BusTypeiScsi] = GUEST_DISK_BUS_TYPE_ISCSI,
     [BusTypeSas] = GUEST_DISK_BUS_TYPE_SAS,
     [BusTypeSata] = GUEST_DISK_BUS_TYPE_SATA,
     [BusTypeSd] =  GUEST_DISK_BUS_TYPE_SD,
     [BusTypeMmc] = GUEST_DISK_BUS_TYPE_MMC,
-#endif
 #if (_WIN32_WINNT >= 0x0601)
     [BusTypeVirtual] = GUEST_DISK_BUS_TYPE_VIRTUAL,
     [BusTypeFileBackedVirtual] = GUEST_DISK_BUS_TYPE_FILE_BACKED_VIRTUAL,
@@ -724,10 +722,8 @@ static void get_single_disk_info(GuestDiskAddress *disk, Error **errp)
     if (disk->bus_type == GUEST_DISK_BUS_TYPE_SCSI
             || disk->bus_type == GUEST_DISK_BUS_TYPE_IDE
             || disk->bus_type == GUEST_DISK_BUS_TYPE_RAID
-#if (_WIN32_WINNT >= 0x0600)
             /* This bus type is not supported before Windows Server 2003 SP1 */
             || disk->bus_type == GUEST_DISK_BUS_TYPE_SAS
-#endif
         ) {
         /* We are able to use the same ioctls for different bus types
          * according to Microsoft docs
@@ -1322,7 +1318,6 @@ static char *guest_addr_to_str(IP_ADAPTER_UNICAST_ADDRESS *ip_addr,
     return NULL;
 }
 
-#if (_WIN32_WINNT >= 0x0600)
 static int64_t guest_ip_prefix(IP_ADAPTER_UNICAST_ADDRESS *ip_addr)
 {
     /* For Windows Vista/2008 and newer, use the OnLinkPrefixLength
@@ -1330,60 +1325,6 @@ static int64_t guest_ip_prefix(IP_ADAPTER_UNICAST_ADDRESS *ip_addr)
      */
     return ip_addr->OnLinkPrefixLength;
 }
-#else
-/* When using the Windows XP and 2003 build environment, do the best we can to
- * figure out the prefix.
- */
-static IP_ADAPTER_INFO *guest_get_adapters_info(void)
-{
-    IP_ADAPTER_INFO *adptr_info = NULL;
-    ULONG adptr_info_len = 0;
-    DWORD ret;
-
-    /* Call the first time to get the adptr_info_len. */
-    GetAdaptersInfo(adptr_info, &adptr_info_len);
-
-    adptr_info = g_malloc(adptr_info_len);
-    ret = GetAdaptersInfo(adptr_info, &adptr_info_len);
-    if (ret != ERROR_SUCCESS) {
-        g_free(adptr_info);
-        adptr_info = NULL;
-    }
-    return adptr_info;
-}
-
-static int64_t guest_ip_prefix(IP_ADAPTER_UNICAST_ADDRESS *ip_addr)
-{
-    int64_t prefix = -1; /* Use for AF_INET6 and unknown/undetermined values. */
-    IP_ADAPTER_INFO *adptr_info, *info;
-    IP_ADDR_STRING *ip;
-    struct in_addr *p;
-
-    if (ip_addr->Address.lpSockaddr->sa_family != AF_INET) {
-        return prefix;
-    }
-    adptr_info = guest_get_adapters_info();
-    if (adptr_info == NULL) {
-        return prefix;
-    }
-
-    /* Match up the passed in ip_addr with one found in adaptr_info.
-     * The matching one in adptr_info will have the netmask.
-     */
-    p = &((struct sockaddr_in *)ip_addr->Address.lpSockaddr)->sin_addr;
-    for (info = adptr_info; info; info = info->Next) {
-        for (ip = &info->IpAddressList; ip; ip = ip->Next) {
-            if (p->S_un.S_addr == inet_addr(ip->IpAddress.String)) {
-                prefix = ctpop32(inet_addr(ip->IpMask.String));
-                goto out;
-            }
-        }
-    }
-out:
-    g_free(adptr_info);
-    return prefix;
-}
-#endif
 
 #define INTERFACE_PATH_BUF_SZ 512
 
@@ -1904,7 +1845,6 @@ typedef struct _GA_WTSINFOA {
 
 GuestUserList *qmp_guest_get_users(Error **err)
 {
-#if (_WIN32_WINNT >= 0x0600)
 #define QGA_NANOSECONDS 10000000
 
     GHashTable *cache = NULL;
@@ -1974,10 +1914,6 @@ GuestUserList *qmp_guest_get_users(Error **err)
     }
     g_hash_table_destroy(cache);
     return head;
-#else
-    error_setg(err, QERR_UNSUPPORTED);
-    return NULL;
-#endif
 }
 
 typedef struct _ga_matrix_lookup_t {
-- 
1.8.3.1
