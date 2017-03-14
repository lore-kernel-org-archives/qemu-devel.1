Received: from eggs.gnu.org ([2001:4830:134:3::10]:43073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnjHe-0002sB-Va
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnjHb-0002Qg-2g
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:02:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnjHa-0002QS-QK
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:02:23 -0400
References: <alpine.DEB.2.10.1703131650550.21520@sstabellini-ThinkPad-X260>
	<1489449360-14411-1-git-send-email-sstabellini@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b077b13-2464-224a-3942-db0015951c32@redhat.com>
Date: Tue, 14 Mar 2017 11:02:18 +0100
MIME-Version: 1.0
In-Reply-To: <1489449360-14411-1-git-send-email-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/9] configure: change
 CONFIG_XEN_BACKEND to be a target property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, anthony.perard@citrix.com, groug@kaod.org, Stefano Stabellini <stefano@aporeto.com>, peter.maydell@linaro.org, rth@twiddle.net, stefanha@redhat.com



On 14/03/2017 00:55, Stefano Stabellini wrote:
> CONFIG_XEN_BACKEND is currently set when the host supports Xen,
> regardless of the chosen targets. As a consequence, Xen backends can be
> enabled even on targets that don't support Xen.
>=20
> Fix the issue by setting CONFIG_XEN_BACKEND only for targets that
> support Xen.
>=20
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> CC: groug@kaod.org
> CC: groug@kaod.org
> CC: pbonzini@redhat.com
> CC: peter.maydell@linaro.org
> CC: rth@twiddle.net
> CC: stefanha@redhat.com
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 6c21975..6d8f752 100755
> --- a/configure
> +++ b/configure
> @@ -5442,7 +5442,6 @@ if test "$virglrenderer" =3D "yes" ; then
>    echo "VIRGL_LIBS=3D$virgl_libs" >> $config_host_mak
>  fi
>  if test "$xen" =3D "yes" ; then
> -  echo "CONFIG_XEN_BACKEND=3Dy" >> $config_host_mak
>    echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=3D$xen_ctrl_version" >> $con=
fig_host_mak
>    if test "$xen_pv_domain_build" =3D "yes" ; then
>      echo "CONFIG_XEN_PV_DOMAIN_BUILD=3Dy" >> $config_host_mak
> @@ -6028,6 +6027,7 @@ case "$target_name" in
>    i386|x86_64)
>      if test "$xen" =3D "yes" -a "$target_softmmu" =3D "yes" ; then
>        echo "CONFIG_XEN=3Dy" >> $config_target_mak
> +      echo "CONFIG_XEN_BACKEND=3Dy" >> $config_target_mak
>        if test "$xen_pci_passthrough" =3D yes; then
>          echo "CONFIG_XEN_PCI_PASSTHROUGH=3Dy" >> "$config_target_mak"
>        fi
>=20

This messes up a bit the way xen_nic.o and friends are compiled, I
think, because they are common-obj-y but they are only found when
compiling in the target subdirectories.  So you end up building
x86_64-softmmu/../hw/net/xen_nic.o

If you're unlucky, I believe this can lead to a link failure where a
target is building xen_nic.o, while the other tries to link to a
partially written object file.

I think the files should be changed from
common-obj-$(CONFIG_XEN_BACKEND) to common-obj-$(CONFIG_XEN).  Then you
add to Makefile:

 CONFIG_SOFTMMU :=3D $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
 CONFIG_USER_ONLY :=3D $(if $(filter %-user,$(TARGET_DIRS)),y)
+CONFIG_XEN :=3D $(CONFIG_XEN_BACKEND)
 CONFIG_ALL=3Dy
 -include config-all-devices.mak
 -include config-all-disas.mak

The Makefile change ensures that they are built before descending in the
target-specific directories.  The Makefile.objs change ensures that Xen
backends are not enabled on targets that support Xen.

Paolo
