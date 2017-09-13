Received: from eggs.gnu.org ([2001:4830:134:3::10]:55275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsEVV-0007PO-0l
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 16:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsEVR-0006wF-Rf
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 16:43:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dsEVR-0006v3-Iu
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 16:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90DEF4E4CA
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 20:43:31 +0000 (UTC)
References: <20170913120937.5645-1-kraxel@redhat.com>
	<20170913120937.5645-3-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47d72e62-8ebb-3b45-3efe-ab5f98ed4f39@redhat.com>
Date: Wed, 13 Sep 2017 22:43:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170913120937.5645-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] Add --firmwarepath to configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 13/09/2017 14:09, Gerd Hoffmann wrote:
> Add a firmware path config option to configure.  Multiple directories
> are accepted, with the usual colon as separator.  Default value is
> ${prefix}/share/qemu-firmware.  The path is searched in addition to the
> current search path (typically ${prefix}/share/qemu).
> 
> This prepares qemu for the planned split of the prebuilt firmware blobs
> into a separate project.
> 
> Distributions can also use this to get rid of the firmware symlink farm
> and add -- for example -- /usr/share/seabios to the firmware path
> instead.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure             |  6 ++++++
>  vl.c                  | 12 +++++++++---
>  scripts/create_config |  2 +-
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/configure b/configure
> index fd7e3a5e81..870bdbd3e4 100755
> --- a/configure
> +++ b/configure
> @@ -332,6 +332,7 @@ modules="no"
>  prefix="/usr/local"
>  mandir="\${prefix}/share/man"
>  datadir="\${prefix}/share"
> +firmwarepath="\${prefix}/share/qemu-firmware"
>  qemu_docdir="\${prefix}/share/doc/qemu"
>  bindir="\${prefix}/bin"
>  libdir="\${prefix}/lib"
> @@ -915,6 +916,8 @@ for opt do
>    ;;
>    --localstatedir=*) local_statedir="$optarg"
>    ;;
> +  --firmwarepath=*) firmwarepath="$optarg"
> +  ;;
>    --sbindir=*|--sharedstatedir=*|\
>    --oldincludedir=*|--datarootdir=*|--infodir=*|--localedir=*|\
>    --htmldir=*|--dvidir=*|--pdfdir=*|--psdir=*)
> @@ -1418,6 +1421,7 @@ Advanced options (experts only):
>    --libdir=PATH            install libraries in PATH
>    --sysconfdir=PATH        install config in PATH$confsuffix
>    --localstatedir=PATH     install local state in PATH (set at runtime on win32)
> +  --firmwarepath=PATH      search PATH for firmware files

Maybe --firmwaredir or --with-firmwaredir (because firmwaredir is not
one of the "standard" directories)?

> @@ -4232,11 +4233,16 @@ int main(int argc, char **argv, char **envp)
>          qemu_set_log(0);
>      }
>  
> -    /* If no data_dir is specified then try to find it relative to the
> -       executable path.  */
> +    /* add configured firmware directories */
> +    dirs = g_strsplit(CONFIG_QEMU_FIRMWAREPATH, ":", 0);

Windows probably wants to use ; here, so you can use
G_SEARCHPATH_SEPARATOR_S instead of ":".

Thanks,

Paolo

> +    for (i = 0; dirs[i] != NULL; i++) {
> +        qemu_add_data_dir(dirs[i]);
> +    }
> +
> +    /* try to find datadir relative to the executable path */
>      qemu_add_data_dir(os_find_datadir());
>  
> -    /* If all else fails use the install path specified when building. */
> +    /* add the datadir specified when building */
>      qemu_add_data_dir(CONFIG_QEMU_DATADIR);
>  
>      /* -L help lists the data directories and exits. */
> diff --git a/scripts/create_config b/scripts/create_config
> index e6929dd61e..603b826886 100755
> --- a/scripts/create_config
> +++ b/scripts/create_config
> @@ -15,7 +15,7 @@ case $line in
>      echo "#define QEMU_VERSION_MINOR $minor"
>      echo "#define QEMU_VERSION_MICRO $micro"
>      ;;
> - qemu_*dir=*) # qemu-specific directory configuration
> + qemu_*dir=* | qemu_*path=*) # qemu-specific directory configuration
>      name=${line%=*}
>      value=${line#*=}
>      define_name=$(echo $name | LC_ALL=C tr '[a-z]' '[A-Z]')
> 
