Received: from eggs.gnu.org ([2001:4830:134:3::10]:36158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gReVk-0005bJ-UP
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gReVg-000646-St
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:38:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gReVg-00061B-JP
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:38:44 -0500
Date: Tue, 27 Nov 2018 15:38:09 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181127153809.3fae7754@redhat.com>
In-Reply-To: <1542049690-12826-7-git-send-email-thuth@redhat.com>
References: <1542049690-12826-1-git-send-email-thuth@redhat.com>
	<1542049690-12826-7-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 6/7] tests/vmgenid: Make test
 independent of global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ben Warren <ben@skyportsystems.com>

On Mon, 12 Nov 2018 20:08:09 +0100
Thomas Huth <thuth@redhat.com> wrote:

> The biggest part has already been done in the previous patch, we now
> only have to replace some few qmp() and readb() calls with the
> corresponding qtest_*() functions to get there.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/vmgenid-test.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> index c9c4f8c..84449ce 100644
> --- a/tests/vmgenid-test.c
> +++ b/tests/vmgenid-test.c
> @@ -95,17 +95,17 @@ static uint32_t acpi_find_vgia(QTestState *qts)
>      return guid_offset;
>  }
>  
> -static void read_guid_from_memory(QemuUUID *guid)
> +static void read_guid_from_memory(QTestState *qts, QemuUUID *guid)
>  {
>      uint32_t vmgenid_addr;
>      int i;
>  
> -    vmgenid_addr = acpi_find_vgia(global_qtest);
> +    vmgenid_addr = acpi_find_vgia(qts);
>      g_assert(vmgenid_addr);
>  
>      /* Read the GUID directly from guest memory */
>      for (i = 0; i < 16; i++) {
> -        guid->data[i] = readb(vmgenid_addr + i);
> +        guid->data[i] = qtest_readb(qts, vmgenid_addr + i);
>      }
>      /* The GUID is in little-endian format in the guest, while QEMU
>       * uses big-endian.  Swap after reading.
> @@ -113,12 +113,12 @@ static void read_guid_from_memory(QemuUUID *guid)
>      qemu_uuid_bswap(guid);
>  }
>  
> -static void read_guid_from_monitor(QemuUUID *guid)
> +static void read_guid_from_monitor(QTestState *qts, QemuUUID *guid)
>  {
>      QDict *rsp, *rsp_ret;
>      const char *guid_str;
>  
> -    rsp = qmp("{ 'execute': 'query-vm-generation-id' }");
> +    rsp = qtest_qmp(qts, "{ 'execute': 'query-vm-generation-id' }");
>      if (qdict_haskey(rsp, "return")) {
>          rsp_ret = qdict_get_qdict(rsp, "return");
>          g_assert(qdict_haskey(rsp_ret, "guid"));
> @@ -139,45 +139,48 @@ static char disk[] = "tests/vmgenid-test-disk-XXXXXX";
>  static void vmgenid_set_guid_test(void)
>  {
>      QemuUUID expected, measured;
> +    QTestState *qts;
>  
>      g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);
>  
> -    global_qtest = qtest_initf(GUID_CMD(VGID_GUID));
> +    qts = qtest_initf(GUID_CMD(VGID_GUID));
>  
>      /* Read the GUID from accessing guest memory */
> -    read_guid_from_memory(&measured);
> +    read_guid_from_memory(qts, &measured);
>      g_assert(memcmp(measured.data, expected.data, sizeof(measured.data)) == 0);
>  
> -    qtest_quit(global_qtest);
> +    qtest_quit(qts);
>  }
>  
>  static void vmgenid_set_guid_auto_test(void)
>  {
>      QemuUUID measured;
> +    QTestState *qts;
>  
> -    global_qtest = qtest_initf(GUID_CMD("auto"));
> +    qts = qtest_initf(GUID_CMD("auto"));
>  
> -    read_guid_from_memory(&measured);
> +    read_guid_from_memory(qts, &measured);
>  
>      /* Just check that the GUID is non-null */
>      g_assert(!qemu_uuid_is_null(&measured));
>  
> -    qtest_quit(global_qtest);
> +    qtest_quit(qts);
>  }
>  
>  static void vmgenid_query_monitor_test(void)
>  {
>      QemuUUID expected, measured;
> +    QTestState *qts;
>  
>      g_assert(qemu_uuid_parse(VGID_GUID, &expected) == 0);
>  
> -    global_qtest = qtest_initf(GUID_CMD(VGID_GUID));
> +    qts = qtest_initf(GUID_CMD(VGID_GUID));
>  
>      /* Read the GUID via the monitor */
> -    read_guid_from_monitor(&measured);
> +    read_guid_from_monitor(qts, &measured);
>      g_assert(memcmp(measured.data, expected.data, sizeof(measured.data)) == 0);
>  
> -    qtest_quit(global_qtest);
> +    qtest_quit(qts);
>  }
>  
>  int main(int argc, char **argv)
