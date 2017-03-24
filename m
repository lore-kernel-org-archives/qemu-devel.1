Received: from eggs.gnu.org ([2001:4830:134:3::10]:53356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1crUBJ-0005Qt-ND
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1crUBG-0005tw-MS
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:43:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:41259)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1crUBG-0005tn-DQ
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:43:22 -0400
References: <20170316141953.16161-1-jgross@suse.com>
	<20170316141953.16161-3-jgross@suse.com>
	<alpine.DEB.2.10.1703161306380.15430@sstabellini-ThinkPad-X260>
	<214bc24d-1c0c-16d6-9c33-e20962b150d2@suse.com>
	<alpine.DEB.2.10.1703171123520.22036@sstabellini-ThinkPad-X260>
	<da852b5f-2490-c483-984d-c7be4f83b9a7@suse.com>
	<alpine.DEB.2.10.1703211152240.11679@sstabellini-ThinkPad-X260>
	<f1f79b77-f3bf-4bb0-135c-802bd5829de5@suse.com>
	<alpine.DEB.2.10.1703221120530.13499@sstabellini-ThinkPad-X260>
	<2fb1da9d14c14eb4826a87657f7d0eb1@AMSPEX02CL03.citrite.net>
	<550ea61e-c9ba-5afc-12b5-438a2a57af6e@suse.com>
	<7208ddd9b76b4196be0a3d3cd12aee71@AMSPEX02CL03.citrite.net>
	<20f2b3ce-218b-4d61-6af1-8c70b751ed18@suse.com>
	<0103d60e-cd96-ab48-70fb-f75ba1273f39@suse.com>
	<1bd386167cff4ef9a281139afb9308dc@AMSPEX02CL03.citrite.net>
From: Juergen Gross <jgross@suse.com>
Message-ID: <0426b870-b23c-85f6-160c-f5df8db753d0@suse.com>
Date: Fri, 24 Mar 2017 19:43:18 +0100
MIME-Version: 1.0
In-Reply-To: <1bd386167cff4ef9a281139afb9308dc@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 2/2] configure: use pkg-config
 for obtaining xen version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com" <kraxel@redhat.com>

On 24/03/17 17:42, Paul Durrant wrote:
>> -----Original Message-----
> [snip]
>>>> That's a change in behaviour that I, and probably others, have long been
>> used to. What we really want, presumably, is to have pkg-config just look
>> under tools/pkgconfig when querying for the version of xencontrol. Could
>> that not be done by simply setting PKG_CONFIG_LIBDIR in QEMU's configure
>> script, or would it still mean picking up installed libraries before ones just
>> built?
>>>
>>> I guess this would break qemu's configure badly as it wouldn't find all
>>> the other library informations it is looking for via pkg-config.
>>
>> Aah, wait, you mean just for the Xen query?
>>
>> This might complicate things for my qemu stubdom plans...
>>
> 
> How about this patch to QEMU configure?
> 
> diff --git a/configure b/configure
> index fdf47e4..6ef5980 100755
> --- a/configure
> +++ b/configure
> @@ -1974,6 +1974,10 @@ fi
>  ##########################################
>  # xen probe
> 
> +xen_query_pkg_config() {
> +    PKG_CONFIG_LIBDIR= ${pkg_config_exe} "$@"
> +}
> +
>  if test "$xen" != "no" ; then
>    xen_libs="-lxenstore -lxenctrl -lxenguest"
>    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
> @@ -1997,9 +2001,9 @@ EOF
>      xen=no
> 
>    # Xen version via pkg-config (Xen 4.9.0 and newer)
> -  elif $pkg_config --exists xencontrol ; then
> +  elif xen_query_pkg_config --exists xencontrol; then
>      xen_ctrl_version="$(printf '%d%02d%02d' \
> -      $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
> +      $(xen_query_pkg_config --modversion xencontrol | sed 's/\./ /g') )"
>      xen=yes
> 
>    elif
> @@ -2216,8 +2220,8 @@ EOF
>      if test $xen_ctrl_version -ge 40900 ; then
>        xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab xenevtchn"
>        xen_pc="$xen_pc xendevicemodel"
> -      xen_libs="$($pkg_config --libs $xen_pc)"
> -      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
> +      xen_libs="$(xen_query_pkg_config --libs $xen_pc)"
> +      QEMU_CFLAGS="$QEMU_CFLAGS $(xen_query_pkg_config --cflags $xen_pc)"
>      elif test $xen_ctrl_version -ge 40701 ; then
>        libs_softmmu="$xen_stable_libs $libs_softmmu"
>      fi
> 
> This appears to DTRT for me when switching between versions of Xen.

But not for someone trying to build qemu outside of Xen trying to use
the properly installed pkg-config files of Xen. They wouldn't be
found any more.

You are breaking a feature for the majority of users just to make
live easier for a handful of developers unwilling to change their
workflow.


Juergen
