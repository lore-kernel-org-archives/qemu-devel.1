Received: from eggs.gnu.org ([2001:4830:134:3::10]:55080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBE6-0007P8-KV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBE1-00045S-RV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:37:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpBE1-00044s-Jo
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:36:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94FB3129A
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 10:36:56 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-19-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9e3d6358-fda6-edac-fa02-1bdbb30a8a91@redhat.com>
Date: Tue, 5 Sep 2017 12:36:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-19-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 18/29] ivshmem-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com

On 01.09.2017 20:03, Eric Blake wrote:
> Managing parallel connections to two different monitors via
> the implicit global_qtest makes it hard to copy-and-paste code
> to tests that are not aware of the implicit state.  Since we
> have already fixed qpci to avoid global_qtest, we can now
> simplify by not using global_qtest anywhere in ivshmem-test.
> 
> We can assert that the conversion is correct by checking that
> global_qtest remains NULL throughout the test (a later patch
> that changes global_qtest to not be a public global variable
> will drop the assertions).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/ivshmem-test.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
> index 37763425ee..b9e0f573f6 100644
> --- a/tests/ivshmem-test.c
> +++ b/tests/ivshmem-test.c
> @@ -71,13 +71,10 @@ static const char* reg2str(enum Reg reg) {
>  static inline unsigned in_reg(IVState *s, enum Reg reg)
>  {
>      const char *name = reg2str(reg);
> -    QTestState *qtest = global_qtest;
>      unsigned res;
> 
> -    global_qtest = s->qs->qts;
>      res = qpci_io_readl(s->dev, s->reg_bar, reg);
>      g_test_message("*%s -> %x\n", name, res);
> -    global_qtest = qtest;
> 
>      return res;
>  }
> @@ -85,35 +82,25 @@ static inline unsigned in_reg(IVState *s, enum Reg reg)
>  static inline void out_reg(IVState *s, enum Reg reg, unsigned v)
>  {
>      const char *name = reg2str(reg);
> -    QTestState *qtest = global_qtest;
> 
> -    global_qtest = s->qs->qts;
>      g_test_message("%x -> *%s\n", v, name);
>      qpci_io_writel(s->dev, s->reg_bar, reg, v);
> -    global_qtest = qtest;
>  }
> 
>  static inline void read_mem(IVState *s, uint64_t off, void *buf, size_t len)
>  {
> -    QTestState *qtest = global_qtest;
> -
> -    global_qtest = s->qs->qts;
>      qpci_memread(s->dev, s->mem_bar, off, buf, len);
> -    global_qtest = qtest;
>  }
> 
>  static inline void write_mem(IVState *s, uint64_t off,
>                               const void *buf, size_t len)
>  {
> -    QTestState *qtest = global_qtest;
> -
> -    global_qtest = s->qs->qts;
>      qpci_memwrite(s->dev, s->mem_bar, off, buf, len);
> -    global_qtest = qtest;
>  }
> 
>  static void cleanup_vm(IVState *s)
>  {
> +    assert(!global_qtest);
>      g_free(s->dev);
>      qtest_shutdown(s->qs);
>  }
> @@ -131,6 +118,7 @@ static void setup_vm_cmd(IVState *s, const char *cmd, bool msix)
>          g_printerr("ivshmem-test tests are only available on x86 or ppc64\n");
>          exit(EXIT_FAILURE);
>      }
> +    global_qtest = NULL;
>      s->dev = get_device(s->qs->pcibus);
> 
>      s->reg_bar = qpci_iomap(s->dev, 0, &barsize);
> @@ -353,7 +341,6 @@ static void test_ivshmem_server(bool msi)
>      g_assert_cmpint(vm1, !=, vm2);
> 
>      /* check number of MSI-X vectors */
> -    global_qtest = s1->qs->qts;
>      if (msi) {
>          ret = qpci_msix_table_size(s1->dev);
>          g_assert_cmpuint(ret, ==, nvectors);
> @@ -376,7 +363,6 @@ static void test_ivshmem_server(bool msi)
>      g_assert_cmpuint(ret, !=, 0);
> 
>      /* ping vm1 -> vm2 on vector 1 */
> -    global_qtest = s2->qs->qts;
>      if (msi) {
>          ret = qpci_msix_pending(s2->dev, 1);
>          g_assert_cmpuint(ret, ==, 0);
> 

OMG, now I see why you want to get rid of this global_test stuff ...
that was really ugly!

Reviewed-by: Thomas Huth <thuth@redhat.com>
