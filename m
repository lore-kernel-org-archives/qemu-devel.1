Received: from eggs.gnu.org ([2001:4830:134:3::10]:41959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cju2M-0004EM-7n
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cju2H-0005Ak-KP
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:42:50 -0500
Received: from mail.kernel.org ([198.145.29.136]:59056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cju2H-0005AM-74
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:42:45 -0500
Date: Fri, 3 Mar 2017 12:42:38 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <05365905529b4fd78ff67989743a8dfb@AMSPEX02CL03.citrite.net>
Message-ID: <alpine.DEB.2.10.1703031209090.17906@sstabellini-ThinkPad-X260>
References: <1488452986-24501-1-git-send-email-paul.durrant@citrix.com>
	<1488452986-24501-6-git-send-email-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1703021426050.17906@sstabellini-ThinkPad-X260>
	<05365905529b4fd78ff67989743a8dfb@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-528009471-1488573759=:17906"
Subject: Re: [Qemu-devel] [PATCH v2 5/5] xen: use libxendevicemodel when
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: 'Stefano Stabellini' <sstabellini@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-528009471-1488573759=:17906
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 3 Mar 2017, Paul Durrant wrote:
> > -----Original Message-----
> > From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> > Sent: 02 March 2017 22:50
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; Stefano
> > Stabellini <sstabellini@kernel.org>; Anthony Perard
> > <anthony.perard@citrix.com>
> > Subject: Re: [PATCH v2 5/5] xen: use libxendevicemodel when available
> > 
> > On Thu, 2 Mar 2017, Paul Durrant wrote:
> > > This patch modifies the wrapper functions in xen_common.h to use the
> > > new xendevicemodel interface if it is available along with compatibility
> > > code to use the old libxenctrl interface if it is not.
> > >
> > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > > ---
> > > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > > Cc: Anthony Perard <anthony.perard@citrix.com>
> > >
> > > v2:
> > > - Add a compat define for xenforeignmemory_close() since this is now
> > >   used.
> > > ---
> > >  include/hw/xen/xen_common.h | 115
> > +++++++++++++++++++++++++++++++-------------
> > >  xen-common.c                |   8 +++
> > >  2 files changed, 90 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/include/hw/xen/xen_common.h
> > b/include/hw/xen/xen_common.h
> > > index 31cf25f..48444e5 100644
> > > --- a/include/hw/xen/xen_common.h
> > > +++ b/include/hw/xen/xen_common.h
> > > @@ -9,6 +9,7 @@
> > >  #undef XC_WANT_COMPAT_EVTCHN_API
> > >  #undef XC_WANT_COMPAT_GNTTAB_API
> > >  #undef XC_WANT_COMPAT_MAP_FOREIGN_API
> > > +#undef XC_WANT_COMPAT_DEVICEMODEL_API
> > >
> > >  #include <xenctrl.h>
> > >  #include <xenstore.h>
> > > @@ -26,48 +27,95 @@ extern xc_interface *xen_xc;
> > >   * We don't support Xen prior to 4.2.0.
> > >   */
> > >
> > > +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 490
> > > +
> > > +typedef xc_interface xendevicemodel_handle;
> > > +
> > > +#define xendevicemodel_open(l, f) xen_xc
> > > +
> > > +#define xendevicemodel_map_io_range_to_ioreq_server \
> > > +    xc_hvm_map_io_range_to_ioreq_server
> > > +#define xendevicemodel_unmap_io_range_from_ioreq_server \
> > > +    xc_hvm_unmap_io_range_from_ioreq_server
> > > +#define xendevicemodel_map_pcidev_to_ioreq_server \
> > > +    xc_hvm_map_pcidev_to_ioreq_server
> > > +#define xendevicemodel_unmap_pcidev_from_ioreq_server \
> > > +    xc_hvm_unmap_pcidev_from_ioreq_server
> > > +#define xendevicemodel_create_ioreq_server \
> > > +    xc_hvm_create_ioreq_server
> > > +#define xendevicemodel_destroy_ioreq_server \
> > > +    xc_hvm_destroy_ioreq_server
> > > +#define xendevicemodel_get_ioreq_server_info \
> > > +    xc_hvm_get_ioreq_server_info
> > > +#define xendevicemodel_set_ioreq_server_state \
> > > +    xc_hvm_set_ioreq_server_state
> > > +#define xendevicemodel_set_pci_intx_level \
> > > +    xc_hvm_set_pci_intx_level
> > > +#define xendevicemodel_set_pci_link_route \
> > > +    xc_hvm_set_pci_link_route
> > > +#define xendevicemodel_set_isa_irq_level \
> > > +    xc_hvm_set_isa_irq_level
> > > +#define xendevicemodel_inject_msi \
> > > +    xc_hvm_inject_msi
> > > +#define xendevicemodel_set_mem_type \
> > > +    xc_hvm_set_mem_type
> > > +#define xendevicemodel_track_dirty_vram \
> > > +    xc_hvm_track_dirty_vram
> > > +#define xendevicemodel_modified_memory \
> > > +    xc_hvm_modified_memory
> > 
> > It does build correctly now for Xen < 4.9, however it breaks against
> > xen-unstable:
> > 
> >   ERROR: configure test passed without -Werror but failed with -Werror.
> >          This is probably a bug in the configure script. The failing command
> >          will be at the bottom of config.log.
> >          You can run configure with --disable-werror to bypass this check.
> > 
> > and config.log says:
> > 
> >   config-temp/qemu-conf.c: In function 'main':
> >   config-temp/qemu-conf.c:32:3: error: implicit declaration of function
> > 'xc_hvm_set_mem_type' [-Werror=implicit-function-declaration]
> >   config-temp/qemu-conf.c:32:3: error: nested extern declaration of
> > 'xc_hvm_set_mem_type' [-Werror=nested-externs]
> >   config-temp/qemu-conf.c:34:3: error: implicit declaration of function
> > 'xc_hvm_inject_msi' [-Werror=implicit-function-declaration]
> >   config-temp/qemu-conf.c:34:3: error: nested extern declaration of
> > 'xc_hvm_inject_msi' [-Werror=nested-externs]
> >   config-temp/qemu-conf.c:35:3: error: implicit declaration of function
> > 'xc_hvm_create_ioreq_server' [-Werror=implicit-function-declaration]
> >   config-temp/qemu-conf.c:35:3: error: nested extern declaration of
> > 'xc_hvm_create_ioreq_server' [-Werror=nested-externs]
> > 
> > 
> > With -DXC_WANT_COMPAT_DEVICEMODEL_API=1:
> > 
> >   In file included from /local/qemu-
> > upstream/include/hw/xen/xen_backend.h:4:0,
> >                    from hw/block/xen_disk.c:27:
> >   /local/qemu-upstream/include/hw/xen/xen_common.h: In function
> > 'xen_set_mem_type':
> >   /local/qemu-upstream/include/hw/xen/xen_common.h:78:5: error: implicit
> > declaration of function 'xc_hvm_set_mem_type' [-Werror=implicit-function-
> > declaration]
> > 
> 
> Ah... Do you have Anthony's patch?
> 
> http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=9970e98ace48574701f7e2286fb67090481a3fec
> 
> I suspect that may be the problem you're seeing above.

Yes, I do have it. I am still having build troubles with v5 too. I am
attaching my build test script: feel free to use it to test the build of
a single QEMU branch against multiple Xen versions. It requires one Xen
repository checked out and built for each Xen version. I have just
added the Xen 4.9 tests, so they might be wrong somehow, but the others
are known to work.
--8323329-528009471-1488573759=:17906
Content-Type: APPLICATION/x-sh; name=test_qemu_all.sh
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.10.1703031242380.17906@sstabellini-ThinkPad-X260>
Content-Description: 
Content-Disposition: attachment; filename=test_qemu_all.sh

IyEvYmluL2Jhc2gKCiNUUkFDRT0iLS1lbmFibGUtdHJhY2UtYmFja2VuZHM9
c3lzbG9nLHNpbXBsZSIKVFJBQ0U9CgpnaXQgY2xlYW4gLWZkeCAmPi9kZXYv
bnVsbAplY2hvICJDb21waWxlIFFFTVUgd2l0aCBubyBYZW4gc3VwcG9ydCIK
Li9jb25maWd1cmUgLS1kaXNhYmxlLXhlbiAtLXRhcmdldC1saXN0PWkzODYt
c29mdG1tdSAmPi9kZXYvbnVsbAptYWtlIC1qNSAmPi9kZXYvbnVsbAppZiBb
ICQ/IC1uZSAwIF07IHRoZW4KICAgIGVjaG8gIlFFTVUgbm8gWGVuIGZhaWxl
ZCEiCmVsc2UKICAgIGVjaG8gIlFFTVUgbm8gWGVuIHN1Y2NlZWRlZCEiCmZp
CmdpdCBjbGVhbiAtZmR4ICY+L2Rldi9udWxsCgpmb3IgaSBpbiA0LjMgNC40
CmRvCiAgICBlY2hvICJDb21waWxlIFFFTVUgd2l0aCBYZW4gJGkiCiAgICBE
SVI9Ii9sb2NhbC94ZW4tJGktdGVzdGluZyIKICAgIGlmIHRlc3QgXCEgLWQg
IiRESVIiIDsgdGhlbgogICAgICAgIGVjaG8gIiRESVIgdW5hdmFpbGFibGUi
CiAgICBmaQogICAgLi9jb25maWd1cmUgLS1lbmFibGUteGVuIC0tdGFyZ2V0
LWxpc3Q9aTM4Ni1zb2Z0bW11IC0tZXh0cmEtY2ZsYWdzPSItSSRESVIvdG9v
bHMvaW5jbHVkZSAtSSRESVIvdG9vbHMvbGlieGMgLUkkRElSL3Rvb2xzL3hl
bnN0b3JlIiAgLS1leHRyYS1sZGZsYWdzPSItTCRESVIvdG9vbHMvbGlieGMg
LUwkRElSL3Rvb2xzL3hlbnN0b3JlIiAtLWRpc2FibGUta3ZtICY+L2Rldi9u
dWxsCiAgICBtYWtlIC1qNSAmPi9kZXYvbnVsbAogICAgaWYgWyAkPyAtbmUg
MCBdOyB0aGVuCiAgICAgICAgZWNobyAiUUVNVSB3aXRoICRpIFhlbiBmYWls
ZWQhIgogICAgZWxzZQogICAgICAgIGVjaG8gIlFFTVUgd2l0aCAkaSBYZW4g
c3VjY2VlZGVkISIKICAgIGZpCiAgICBnaXQgY2xlYW4gLWZkeCAmPi9kZXYv
bnVsbApkb25lCgpmb3IgaSBpbiA0LjUgNC42CmRvCiAgICBlY2hvICJDb21w
aWxlIFFFTVUgd2l0aCBYZW4gJGkiCiAgICBESVI9Ii9sb2NhbC94ZW4tJGkt
dGVzdGluZyIKICAgIGlmIHRlc3QgXCEgLWQgIiRESVIiIDsgdGhlbgogICAg
ICAgIGVjaG8gIiRESVIgdW5hdmFpbGFibGUiCiAgICBmaQogICAgLi9jb25m
aWd1cmUgLS1lbmFibGUteGVuIC0tdGFyZ2V0LWxpc3Q9aTM4Ni1zb2Z0bW11
IC0tZXh0cmEtY2ZsYWdzPSItSSRESVIvdG9vbHMvaW5jbHVkZSAtSSRESVIv
dG9vbHMvbGlieGMvaW5jbHVkZSAtSSRESVIvdG9vbHMveGVuc3RvcmUvaW5j
bHVkZSIgIC0tZXh0cmEtbGRmbGFncz0iLUwkRElSL3Rvb2xzL2xpYnhjIC1M
JERJUi90b29scy94ZW5zdG9yZSIgLS1kaXNhYmxlLWt2bSAmPi9kZXYvbnVs
bAogICAgbWFrZSAtajUgJj4vZGV2L251bGwKICAgIGlmIFsgJD8gLW5lIDAg
XTsgdGhlbgogICAgICAgIGVjaG8gIlFFTVUgd2l0aCBYZW4gJGkgZmFpbGVk
ISIKICAgIGVsc2UKICAgICAgICBlY2hvICJRRU1VIHdpdGggWGVuICRpIHN1
Y2NlZWRlZCEiCiAgICBmaQogICAgZ2l0IGNsZWFuIC1mZHggJj4vZGV2L251
bGwKZG9uZQoKZm9yIGkgaW4gNC43CmRvCiAgICBlY2hvICJDb21waWxlIFFF
TVUgd2l0aCBYZW4gJGkiCiAgICBESVI9Ii9sb2NhbC94ZW4tJGktdGVzdGlu
ZyIKICAgIGlmIHRlc3QgXCEgLWQgIiRESVIiIDsgdGhlbgogICAgICAgIGVj
aG8gIiRESVIgdW5hdmFpbGFibGUiCiAgICBmaQogICAgLi9jb25maWd1cmUg
LS1lbmFibGUteGVuIC0tdGFyZ2V0LWxpc3Q9aTM4Ni1zb2Z0bW11IFwKICAg
IAkJLS1leHRyYS1jZmxhZ3M9Ii1EWENfV0FOVF9DT01QQVRfRVZUQ0hOX0FQ
ST0xIFwKICAgIAkJLURYQ19XQU5UX0NPTVBBVF9HTlRUQUJfQVBJPTEgXAog
ICAgCQktRFhDX1dBTlRfQ09NUEFUX01BUF9GT1JFSUdOX0FQST0xIFwKICAg
IAkJLUkkRElSL3Rvb2xzL2luY2x1ZGUgXAogICAgCQktSSRESVIvdG9vbHMv
bGlicy90b29sbG9nL2luY2x1ZGUgXAogICAgCQktSSRESVIvdG9vbHMvbGli
cy9ldnRjaG4vaW5jbHVkZSBcCiAgICAJCS1JJERJUi90b29scy9saWJzL2du
dHRhYi9pbmNsdWRlIFwKICAgIAkJLUkkRElSL3Rvb2xzL2xpYnMvZm9yZWln
bm1lbW9yeS9pbmNsdWRlIFwKICAgIAkJLUkkRElSL3Rvb2xzL2xpYnhjL2lu
Y2x1ZGUgXAogICAgCQktSSRESVIvdG9vbHMveGVuc3RvcmUvaW5jbHVkZSBc
CiAgICAJCS1JJERJUi90b29scy94ZW5zdG9yZS9jb21wYXQvaW5jbHVkZSIg
XAogICAgCQktLWV4dHJhLWxkZmxhZ3M9Ii1MJERJUi90b29scy9saWJ4YyBc
CiAgICAJCS1MJERJUi90b29scy94ZW5zdG9yZSBcCiAgICAJCS1MJERJUi90
b29scy9saWJzL2V2dGNobiBcCiAgICAJCS1MJERJUi90b29scy9saWJzL2du
dHRhYiBcCiAgICAJCS1MJERJUi90b29scy9saWJzL2ZvcmVpZ25tZW1vcnkg
XAogICAgCQktV2wsLXJwYXRoLWxpbms9JERJUi90b29scy9saWJzL3Rvb2xs
b2cgXAogICAgCQktV2wsLXJwYXRoLWxpbms9JERJUi90b29scy9saWJzL2V2
dGNobiBcCiAgICAJCS1XbCwtcnBhdGgtbGluaz0kRElSL3Rvb2xzL2xpYnMv
Z250dGFiIFwKICAgIAkJLVdsLC1ycGF0aC1saW5rPSRESVIvdG9vbHMvbGli
cy9jYWxsIFwKICAgIAkJLVdsLC1ycGF0aC1saW5rPSRESVIvdG9vbHMvbGli
cy9mb3JlaWdubWVtb3J5IiBcCiAgICAgICAgICAgIC0tZGlzYWJsZS1rdm0g
Jj4vZGV2L251bGwKICAgIG1ha2UgLWo1ICY+L2Rldi9udWxsCiAgICBpZiBb
ICQ/IC1uZSAwIF07IHRoZW4KICAgICAgICBlY2hvICJRRU1VIHdpdGggWGVu
ICRpIGZhaWxlZCEiCiAgICBlbHNlCiAgICAgICAgZWNobyAiUUVNVSB3aXRo
IFhlbiAkaSBzdWNjZWVkZWQhIgogICAgZmkKICAgIGdpdCBjbGVhbiAtZmR4
ICY+L2Rldi9udWxsCmRvbmUKCmZvciBpIGluIDQuOApkbwogICAgZWNobyAi
Q29tcGlsZSBRRU1VIHdpdGggWGVuICRpIgogICAgRElSPSIvbG9jYWwveGVu
LSRpLXRlc3RpbmciCiAgICBpZiB0ZXN0IFwhIC1kICIkRElSIiA7IHRoZW4K
ICAgICAgICBlY2hvICIkRElSIHVuYXZhaWxhYmxlIgogICAgZmkKICAgIC4v
Y29uZmlndXJlIC0tZW5hYmxlLXhlbiAtLXRhcmdldC1saXN0PWkzODYtc29m
dG1tdSBcCiAgICAJCS0tZXh0cmEtY2ZsYWdzPSItSSRESVIvdG9vbHMvaW5j
bHVkZSBcCiAgICAJCS1JJERJUi90b29scy9saWJzL3Rvb2xsb2cvaW5jbHVk
ZSBcCiAgICAJCS1JJERJUi90b29scy9saWJzL2V2dGNobi9pbmNsdWRlIFwK
ICAgIAkJLUkkRElSL3Rvb2xzL2xpYnMvZ250dGFiL2luY2x1ZGUgXAogICAg
CQktSSRESVIvdG9vbHMvbGlicy9mb3JlaWdubWVtb3J5L2luY2x1ZGUgXAog
ICAgCQktSSRESVIvdG9vbHMvbGlieGMvaW5jbHVkZSBcCiAgICAJCS1JJERJ
Ui90b29scy94ZW5zdG9yZS9pbmNsdWRlIFwKICAgIAkJLUkkRElSL3Rvb2xz
L3hlbnN0b3JlL2NvbXBhdC9pbmNsdWRlIiBcCiAgICAJCS0tZXh0cmEtbGRm
bGFncz0iLUwkRElSL3Rvb2xzL2xpYnhjIFwKICAgIAkJLUwkRElSL3Rvb2xz
L3hlbnN0b3JlIFwKICAgIAkJLUwkRElSL3Rvb2xzL2xpYnMvZXZ0Y2huIFwK
ICAgIAkJLUwkRElSL3Rvb2xzL2xpYnMvZ250dGFiIFwKICAgIAkJLUwkRElS
L3Rvb2xzL2xpYnMvZm9yZWlnbm1lbW9yeSBcCiAgICAJCS1XbCwtcnBhdGgt
bGluaz0kRElSL3Rvb2xzL2xpYnMvdG9vbGxvZyBcCiAgICAJCS1XbCwtcnBh
dGgtbGluaz0kRElSL3Rvb2xzL2xpYnMvZXZ0Y2huIFwKICAgIAkJLVdsLC1y
cGF0aC1saW5rPSRESVIvdG9vbHMvbGlicy9nbnR0YWIgXAogICAgCQktV2ws
LXJwYXRoLWxpbms9JERJUi90b29scy9saWJzL2NhbGwgXAogICAgCQktV2ws
LXJwYXRoLWxpbms9JERJUi90b29scy9saWJzL2ZvcmVpZ25tZW1vcnkiIFwK
ICAgICAgICAgICAgLS1kaXNhYmxlLWt2bSAmPi9kZXYvbnVsbAogICAgbWFr
ZSAtajUgJj4vZGV2L251bGwKICAgIGlmIFsgJD8gLW5lIDAgXTsgdGhlbgog
ICAgICAgIGVjaG8gIlFFTVUgd2l0aCBYZW4gJGkgZmFpbGVkISIKICAgIGVs
c2UKICAgICAgICBlY2hvICJRRU1VIHdpdGggWGVuICRpIHN1Y2NlZWRlZCEi
CiAgICBmaQogICAgZ2l0IGNsZWFuIC1mZHggJj4vZGV2L251bGwKZG9uZQoK
Zm9yIGkgaW4gNC45CmRvCiAgICBlY2hvICJDb21waWxlIFFFTVUgd2l0aCBY
ZW4gJGkgKENPTVBBVF9ERVZJQ0VNT0RFTCkiCiAgICBESVI9Ii9sb2NhbC94
ZW4tJGktdGVzdGluZyIKICAgIGlmIHRlc3QgXCEgLWQgIiRESVIiIDsgdGhl
bgogICAgICAgIGVjaG8gIiRESVIgdW5hdmFpbGFibGUiCiAgICBmaQogICAg
Li9jb25maWd1cmUgLS1lbmFibGUteGVuIC0tdGFyZ2V0LWxpc3Q9aTM4Ni1z
b2Z0bW11IFwKICAgIAkJLS1leHRyYS1jZmxhZ3M9Ii1EWENfV0FOVF9DT01Q
QVRfREVWSUNFTU9ERUxfQVBJPTEgXAogICAgICAgICAgICAtSSRESVIvdG9v
bHMvaW5jbHVkZSBcCiAgICAJCS1JJERJUi90b29scy9saWJzL3Rvb2xsb2cv
aW5jbHVkZSBcCiAgICAJCS1JJERJUi90b29scy9saWJzL2V2dGNobi9pbmNs
dWRlIFwKICAgIAkJLUkkRElSL3Rvb2xzL2xpYnMvZ250dGFiL2luY2x1ZGUg
XAogICAgCQktSSRESVIvdG9vbHMvbGlicy9mb3JlaWdubWVtb3J5L2luY2x1
ZGUgXAogICAgCQktSSRESVIvdG9vbHMvbGlieGMvaW5jbHVkZSBcCiAgICAJ
CS1JJERJUi90b29scy94ZW5zdG9yZS9pbmNsdWRlIFwKICAgIAkJLUkkRElS
L3Rvb2xzL3hlbnN0b3JlL2NvbXBhdC9pbmNsdWRlIiBcCiAgICAJCS0tZXh0
cmEtbGRmbGFncz0iLUwkRElSL3Rvb2xzL2xpYnhjIFwKICAgIAkJLUwkRElS
L3Rvb2xzL3hlbnN0b3JlIFwKICAgIAkJLUwkRElSL3Rvb2xzL2xpYnMvZXZ0
Y2huIFwKICAgIAkJLUwkRElSL3Rvb2xzL2xpYnMvZ250dGFiIFwKICAgIAkJ
LUwkRElSL3Rvb2xzL2xpYnMvZm9yZWlnbm1lbW9yeSBcCiAgICAJCS1MJERJ
Ui90b29scy9saWJzL2RldmljZW1vZGVsIFwKICAgIAkJLVdsLC1ycGF0aC1s
aW5rPSRESVIvdG9vbHMvbGlicy90b29sbG9nIFwKICAgIAkJLVdsLC1ycGF0
aC1saW5rPSRESVIvdG9vbHMvbGlicy9ldnRjaG4gXAogICAgCQktV2wsLXJw
YXRoLWxpbms9JERJUi90b29scy9saWJzL2dudHRhYiBcCiAgICAJCS1XbCwt
cnBhdGgtbGluaz0kRElSL3Rvb2xzL2xpYnMvY2FsbCBcCiAgICAJCS1XbCwt
cnBhdGgtbGluaz0kRElSL3Rvb2xzL2xpYnMvZm9yZWlnbm1lbW9yeSBcCiAg
ICAJCS1XbCwtcnBhdGgtbGluaz0kRElSL3Rvb2xzL2xpYnMvZGV2aWNlbW9k
ZWwiIFwKICAgICAgICAgICAgLS1kaXNhYmxlLWt2bSAmPi9kZXYvbnVsbAog
ICAgbWFrZSAtajUgJj4vZGV2L251bGwKICAgIGlmIFsgJD8gLW5lIDAgXTsg
dGhlbgogICAgICAgIGVjaG8gIlFFTVUgd2l0aCBYZW4gJGkgZmFpbGVkISIK
ICAgIGVsc2UKICAgICAgICBlY2hvICJRRU1VIHdpdGggWGVuICRpIHN1Y2Nl
ZWRlZCEiCiAgICBmaQogICAgZ2l0IGNsZWFuIC1mZHggJj4vZGV2L251bGwK
ZG9uZQoKZm9yIGkgaW4gNC45CmRvCiAgICBlY2hvICJDb21waWxlIFFFTVUg
d2l0aCBYZW4gJGkiCiAgICBESVI9Ii9sb2NhbC94ZW4tJGktdGVzdGluZyIK
ICAgIGlmIHRlc3QgXCEgLWQgIiRESVIiIDsgdGhlbgogICAgICAgIGVjaG8g
IiRESVIgdW5hdmFpbGFibGUiCiAgICBmaQogICAgLi9jb25maWd1cmUgLS1l
bmFibGUteGVuIC0tdGFyZ2V0LWxpc3Q9aTM4Ni1zb2Z0bW11IFwKICAgIAkJ
LS1leHRyYS1jZmxhZ3M9Ii1JJERJUi90b29scy9pbmNsdWRlIFwKICAgIAkJ
LUkkRElSL3Rvb2xzL2xpYnMvdG9vbGxvZy9pbmNsdWRlIFwKICAgIAkJLUkk
RElSL3Rvb2xzL2xpYnMvZXZ0Y2huL2luY2x1ZGUgXAogICAgCQktSSRESVIv
dG9vbHMvbGlicy9nbnR0YWIvaW5jbHVkZSBcCiAgICAJCS1JJERJUi90b29s
cy9saWJzL2ZvcmVpZ25tZW1vcnkvaW5jbHVkZSBcCiAgICAJCS1JJERJUi90
b29scy9saWJ4Yy9pbmNsdWRlIFwKICAgIAkJLUkkRElSL3Rvb2xzL3hlbnN0
b3JlL2luY2x1ZGUgXAogICAgCQktSSRESVIvdG9vbHMveGVuc3RvcmUvY29t
cGF0L2luY2x1ZGUiIFwKICAgIAkJLS1leHRyYS1sZGZsYWdzPSItTCRESVIv
dG9vbHMvbGlieGMgXAogICAgCQktTCRESVIvdG9vbHMveGVuc3RvcmUgXAog
ICAgCQktTCRESVIvdG9vbHMvbGlicy9ldnRjaG4gXAogICAgCQktTCRESVIv
dG9vbHMvbGlicy9nbnR0YWIgXAogICAgCQktTCRESVIvdG9vbHMvbGlicy9m
b3JlaWdubWVtb3J5IFwKICAgIAkJLUwkRElSL3Rvb2xzL2xpYnMvZGV2aWNl
bW9kZWwgXAogICAgCQktV2wsLXJwYXRoLWxpbms9JERJUi90b29scy9saWJz
L3Rvb2xsb2cgXAogICAgCQktV2wsLXJwYXRoLWxpbms9JERJUi90b29scy9s
aWJzL2V2dGNobiBcCiAgICAJCS1XbCwtcnBhdGgtbGluaz0kRElSL3Rvb2xz
L2xpYnMvZ250dGFiIFwKICAgIAkJLVdsLC1ycGF0aC1saW5rPSRESVIvdG9v
bHMvbGlicy9jYWxsIFwKICAgIAkJLVdsLC1ycGF0aC1saW5rPSRESVIvdG9v
bHMvbGlicy9mb3JlaWdubWVtb3J5IFwKICAgIAkJLVdsLC1ycGF0aC1saW5r
PSRESVIvdG9vbHMvbGlicy9kZXZpY2Vtb2RlbCIgXAogICAgICAgICAgICAt
LWRpc2FibGUta3ZtICY+L2Rldi9udWxsCiAgICBtYWtlIC1qNSAmPi9kZXYv
bnVsbAogICAgaWYgWyAkPyAtbmUgMCBdOyB0aGVuCiAgICAgICAgZWNobyAi
UUVNVSB3aXRoIFhlbiAkaSBmYWlsZWQhIgogICAgZWxzZQogICAgICAgIGVj
aG8gIlFFTVUgd2l0aCBYZW4gJGkgc3VjY2VlZGVkISIKICAgIGZpCiAgICBn
aXQgY2xlYW4gLWZkeCAmPi9kZXYvbnVsbApkb25lCg==

--8323329-528009471-1488573759=:17906--
