Received: from eggs.gnu.org ([2001:4830:134:3::10]:38045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drh4g-0005sI-70
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drh4a-0002zR-UA
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:01:41 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-15-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <35e6815c-79d7-1ffe-eece-82b035d00e85@redhat.com>
Date: Tue, 12 Sep 2017 11:01:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170911172022.4738-15-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 14/38] libqos: Use explicit QTestState
 for rtas operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:sPAPR" <qemu-ppc@nongnu.org>

On 11.09.2017 19:19, Eric Blake wrote:
> Drop one more client of global_qtest by teaching all rtas test
> functionality to pass in an explicit QTestState, adjusting all
> callers.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v7: catch a couple more operations, drop R-b
> ---
>  tests/libqos/rtas.h      |  9 ++++++---
>  tests/libqos/pci-spapr.c | 18 ++++++++++++------
>  tests/libqos/rtas.c      | 36 ++++++++++++++++++++----------------
>  tests/rtas-test.c        |  2 +-
>  4 files changed, 39 insertions(+), 26 deletions(-)
> 
> diff --git a/tests/libqos/rtas.h b/tests/libqos/rtas.h
> index 498eb19230..e3d0f850a7 100644
> --- a/tests/libqos/rtas.h
> +++ b/tests/libqos/rtas.h
> @@ -7,9 +7,12 @@
>  #define LIBQOS_RTAS_H
>  #include "libqos/malloc.h"
> 
> -int qrtas_get_time_of_day(QGuestAllocator *alloc, struct tm *tm, uint32_t *ns);
> -uint32_t qrtas_ibm_read_pci_config(QGuestAllocator *alloc, uint64_t buid,
> +int qrtas_get_time_of_day(QTestState *qts, QGuestAllocator *alloc,
> +                          struct tm *tm, uint32_t *ns);
> +uint32_t qrtas_ibm_read_pci_config(QTestState *qts, QGuestAllocator *alloc,
> +                                   uint64_t buid,
>                                     uint32_t addr, uint32_t size);
> -int qrtas_ibm_write_pci_config(QGuestAllocator *alloc, uint64_t buid,
> +int qrtas_ibm_write_pci_config(QTestState *qts, QGuestAllocator *alloc,
> +                               uint64_t buid,
>                                 uint32_t addr, uint32_t size, uint32_t val);

Nit: I'd prefer if you rather put hte "uint32_t val" on a separate line
instead of the "buid".

[...]
> @@ -92,7 +95,8 @@ uint32_t qrtas_ibm_read_pci_config(QGuestAllocator *alloc, uint64_t buid,
>      return ret[1];
>  }
> 
> -int qrtas_ibm_write_pci_config(QGuestAllocator *alloc, uint64_t buid,
> +int qrtas_ibm_write_pci_config(QTestState *qts, QGuestAllocator *alloc,
> +                               uint64_t buid,
>                                 uint32_t addr, uint32_t size, uint32_t val)

dito

>  {
>      int res;
> @@ -103,7 +107,7 @@ int qrtas_ibm_write_pci_config(QGuestAllocator *alloc, uint64_t buid,
>      args[2] = buid & 0xffffffff;
>      args[3] = size;
>      args[4] = val;
> -    res = qrtas_call(alloc, "ibm,write-pci-config", 5, args, 1, ret);
> +    res = qrtas_call(qts, alloc, "ibm,write-pci-config", 5, args, 1, ret);
>      if (res != 0) {
>          return -1;
>      }
> diff --git a/tests/rtas-test.c b/tests/rtas-test.c
> index 276c87ef84..34a692163f 100644
> --- a/tests/rtas-test.c
> +++ b/tests/rtas-test.c
> @@ -16,7 +16,7 @@ static void test_rtas_get_time_of_day(void)
>      qs = qtest_spapr_boot("-machine pseries");
> 
>      t1 = time(NULL);
> -    ret = qrtas_get_time_of_day(qs->alloc, &tm, &ns);
> +    ret = qrtas_get_time_of_day(qs->qts, qs->alloc, &tm, &ns);
>      g_assert_cmpint(ret, ==, 0);
>      t2 = mktimegm(&tm);
>      g_assert(t2 - t1 < 5); /* 5 sec max to run the test */
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
