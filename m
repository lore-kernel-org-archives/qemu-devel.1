Received: from eggs.gnu.org ([209.51.188.92]:36995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gk7ys-000402-Or
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gk7yr-0003z8-Qx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:45:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gk7yn-0003m1-R1
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:45:13 -0500
Date: Thu, 17 Jan 2019 08:44:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190117084350-mutt-send-email-mst@kernel.org>
References: <20190115200252.25911-1-mst@redhat.com>
	<CAFEAcA_CurRe0i7pU10OkNBFi53ayA4Y01HtF27qN1xo5nJqxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_CurRe0i7pU10OkNBFi53ayA4Y01HtF27qN1xo5nJqxg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 00/49] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 17, 2019 at 12:48:22PM +0000, Peter Maydell wrote:
> On Tue, 15 Jan 2019 at 20:03, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Changes from v1:
> > - fix an out of tree build by unmangling a patch I mangled when applying
> > - fix a gcc 8 build by applying philippe's patches
> >
> >
> > The following changes since commit 89bd861c2b470e3fb45596945509079c72af3ac2:
> >
> >   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2019-01-14 17:35:00 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 64ed76db175f7ccb5f47195a7617d0106bf01245:
> >
> >   migration: Use strnlen() for fixed-size string (2019-01-15 14:56:57 -0500)
> >
> > ----------------------------------------------------------------
> > pci, pc, virtio: fixes, features
> >
> > tpm physical presence interface
> > rsc support in virtio net
> > ivshmem is removed
> > misc cleanups and fixes all over the place
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> This fails 'make check' on s390x host:
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
> QTEST_QEMU_IMG=qemu-img tests/bios-tables-test -m=quick -k --tap <
> /dev/null | ./scripts/tap-driver.pl --test-name="bios-tables-test"
> 
> Looking for expected file 'tests/data/acpi/pc/FACP'
> Using expected file 'tests/data/acpi/pc/FACP'
> **
> ERROR:/home/linux1/qemu/tests/bios-tables-test.c:314:load_expected_aml:
> assertion failed: (exp_sdt.aml_len)
> ERROR - too few tests run (expected 15, got 0)
> Aborted (core dumped)
> /home/linux1/qemu/tests/Makefile.include:856: recipe for target
> 'check-qtest-i386' failed
> 
> 
> (all the other build hosts passed)
> 
> thanks
> -- PMM


Oh. I am pretty sure it's endian-ness :(

Any chance you can quickly test the below?

That would be appreciated ...


diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 0bf7164590..a506dcbb29 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -274,6 +274,7 @@ static GArray *load_expected_aml(test_data *data)
     AcpiSdtTable *sdt;
     GError *error = NULL;
     gboolean ret;
+    gsize aml_len;
 
     GArray *exp_tables = g_array_new(false, true, sizeof(AcpiSdtTable));
     if (getenv("V")) {
@@ -307,7 +308,8 @@ try_again:
             fprintf(stderr, "Using expected file '%s'\n", aml_file);
         }
         ret = g_file_get_contents(aml_file, (gchar **)&exp_sdt.aml,
-                                  (gsize *)&exp_sdt.aml_len, &error);
+                                  &aml_len, &error);
+        exp_sdt.aml_len = aml_len;
         g_assert(ret);
         g_assert_no_error(error);
         g_assert(exp_sdt.aml);
