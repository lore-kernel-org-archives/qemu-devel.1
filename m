Received: from eggs.gnu.org ([2001:4830:134:3::10]:37967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1erKoU-0001mN-U3
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1erKoT-0000TW-ED
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:47:47 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1erKoT-0000T4-49
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:47:45 -0500
Received: by mail-wr0-x242.google.com with SMTP id v18so4749758wrv.0
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 01:47:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519888086-4207-1-git-send-email-jusual@mail.ru>
References: <1519888086-4207-1-git-send-email-jusual@mail.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 1 Mar 2018 10:47:42 +0100
Message-ID: <CAJ+F1CJVyrK5PtpavMKuGwus9RC_KDjx9i2csduW9JMdV8tRbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] use g_path_get_basename instead of basename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Cornelia Huck <cohuck@redhat.com>, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Thu, Mar 1, 2018 at 8:08 AM, Julia Suvorova via Qemu-devel
<qemu-devel@nongnu.org> wrote:
> basename(3) and dirname(3) modify their argument and may return
> pointers to statically allocated memory which may be overwritten by
> subsequent calls.
> g_path_get_basename and g_path_get_dirname have no such issues, and
> therefore more preferable.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>

What about adding a warning for basename()/dirname() usage in
scripts/checkpatch.pl ?

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  fsdev/virtfs-proxy-helper.c |  6 +++++-
>  hw/s390x/s390-ccw.c         | 17 +++++++++++------
>  hw/vfio/ccw.c               |  7 +++++--
>  hw/vfio/pci.c               |  6 ++++--
>  hw/vfio/platform.c          |  6 ++++--
>  qemu-io.c                   |  8 +++++++-
>  qemu-nbd.c                  |  5 ++++-
>  qga/commands-posix.c        |  4 ++--
>  8 files changed, 42 insertions(+), 17 deletions(-)
>
> diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
> index 8e48500..da3452f 100644
> --- a/fsdev/virtfs-proxy-helper.c
> +++ b/fsdev/virtfs-proxy-helper.c
> @@ -787,6 +787,8 @@ error:
>
>  static void usage(char *prog)
>  {
> +    char *base_filename =3D g_path_get_basename(prog);
> +
>      fprintf(stderr, "usage: %s\n"
>              " -p|--path <path> 9p path to export\n"
>              " {-f|--fd <socket-descriptor>} socket file descriptor to be=
 used\n"
> @@ -795,7 +797,9 @@ static void usage(char *prog)
>              " access to this socket\n"
>              " \tNote: -s & -f can not be used together\n"
>              " [-n|--nodaemon] Run as a normal program\n",
> -            basename(prog));
> +            base_filename);
> +
> +    g_free(base_filename);
>  }
>
>  static int process_reply(int sock, int type,
> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> index 7fc1c60..460dbab 100644
> --- a/hw/s390x/s390-ccw.c
> +++ b/hw/s390x/s390-ccw.c
> @@ -34,7 +34,7 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
>                                    Error **errp)
>  {
>      unsigned int cssid, ssid, devid;
> -    char dev_path[PATH_MAX] =3D {0}, *tmp;
> +    char dev_path[PATH_MAX] =3D {0}, *dir_name, *dir_path;
>
>      if (!sysfsdev) {
>          error_setg(errp, "No host device provided");
> @@ -48,18 +48,23 @@ static void s390_ccw_get_dev_info(S390CCWDevice *cdev=
,
>          return;
>      }
>
> -    cdev->mdevid =3D g_strdup(basename(dev_path));
> +    cdev->mdevid =3D g_path_get_basename(dev_path);
>
> -    tmp =3D basename(dirname(dev_path));
> -    if (sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid) !=3D 3) {
> -        error_setg_errno(errp, errno, "Failed to read %s", tmp);
> -        return;
> +    dir_path =3D g_path_get_dirname(dev_path);
> +    dir_name =3D g_path_get_basename(dir_path);
> +    if (sscanf(dir_name, "%2x.%1x.%4x", &cssid, &ssid, &devid) !=3D 3) {
> +        error_setg_errno(errp, errno, "Failed to read %s", dir_name);
> +        goto out;
>      }
>
>      cdev->hostid.cssid =3D cssid;
>      cdev->hostid.ssid =3D ssid;
>      cdev->hostid.devid =3D devid;
>      cdev->hostid.valid =3D true;
> +
> +out:
> +    g_free(dir_path);
> +    g_free(dir_name);
>  }
>
>  static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error =
**errp)
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 16713f2..c0566a9 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -300,7 +300,7 @@ static void vfio_put_device(VFIOCCWDevice *vcdev)
>
>  static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
>  {
> -    char *tmp, group_path[PATH_MAX];
> +    char *tmp, *group_name, group_path[PATH_MAX];
>      ssize_t len;
>      int groupid;
>
> @@ -317,10 +317,13 @@ static VFIOGroup *vfio_ccw_get_group(S390CCWDevice =
*cdev, Error **errp)
>
>      group_path[len] =3D 0;
>
> -    if (sscanf(basename(group_path), "%d", &groupid) !=3D 1) {
> +    group_name =3D g_path_get_basename(group_path);
> +    if (sscanf(group_name, "%d", &groupid) !=3D 1) {
>          error_setg(errp, "vfio: failed to read %s", group_path);
> +        g_free(group_name);
>          return NULL;
>      }
> +    g_free(group_name);
>
>      return vfio_get_group(groupid, &address_space_memory, errp);
>  }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 033cc8d..ba03136 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2807,7 +2807,7 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
>          return;
>      }
>
> -    vdev->vbasedev.name =3D g_strdup(basename(vdev->vbasedev.sysfsdev));
> +    vdev->vbasedev.name =3D g_path_get_basename(vdev->vbasedev.sysfsdev)=
;
>      vdev->vbasedev.ops =3D &vfio_pci_ops;
>      vdev->vbasedev.type =3D VFIO_DEVICE_TYPE_PCI;
>      vdev->vbasedev.dev =3D &vdev->pdev.qdev;
> @@ -2824,11 +2824,13 @@ static void vfio_realize(PCIDevice *pdev, Error *=
*errp)
>
>      group_path[len] =3D 0;
>
> -    group_name =3D basename(group_path);
> +    group_name =3D g_path_get_basename(group_path);
>      if (sscanf(group_name, "%d", &groupid) !=3D 1) {
>          error_setg_errno(errp, errno, "failed to read %s", group_path);
> +        g_free(group_name);
>          goto error;
>      }
> +    g_free(group_name);
>
>      trace_vfio_realize(vdev->vbasedev.name, groupid);
>
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 0d4bc0a..15dbae8 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -561,7 +561,7 @@ static int vfio_base_device_init(VFIODevice *vbasedev=
, Error **errp)
>      /* @sysfsdev takes precedence over @host */
>      if (vbasedev->sysfsdev) {
>          g_free(vbasedev->name);
> -        vbasedev->name =3D g_strdup(basename(vbasedev->sysfsdev));
> +        vbasedev->name =3D g_path_get_basename(vbasedev->sysfsdev);
>      } else {
>          if (!vbasedev->name || strchr(vbasedev->name, '/')) {
>              error_setg(errp, "wrong host device name");
> @@ -590,11 +590,13 @@ static int vfio_base_device_init(VFIODevice *vbased=
ev, Error **errp)
>
>      group_path[len] =3D 0;
>
> -    group_name =3D basename(group_path);
> +    group_name =3D g_path_get_basename(group_path);
>      if (sscanf(group_name, "%d", &groupid) !=3D 1) {
>          error_setg_errno(errp, errno, "failed to read %s", group_path);
> +        g_free(group_name);
>          return -errno;
>      }
> +    g_free(group_name);
>
>      trace_vfio_platform_base_device_init(vbasedev->name, groupid);
>
> diff --git a/qemu-io.c b/qemu-io.c
> index 2c00ea0..1de5fc7 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -308,6 +308,11 @@ static char *get_prompt(void)
>      return prompt;
>  }
>
> +static void free_progname(void)
> +{
> +    g_free(progname);
> +}
> +
>  static void GCC_FMT_ATTR(2, 3) readline_printf_func(void *opaque,
>                                                      const char *fmt, ...=
)
>  {
> @@ -504,7 +509,8 @@ int main(int argc, char **argv)
>  #endif
>
>      module_call_init(MODULE_INIT_TRACE);
> -    progname =3D basename(argv[0]);
> +    progname =3D g_path_get_basename(argv[0]);
> +    atexit(free_progname);
>      qemu_init_exec_dir(argv[0]);
>
>      qcrypto_init(&error_fatal);
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index ed5d9b5..36bafe7 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -893,8 +893,11 @@ int main(int argc, char **argv)
>      }
>
>      if (device !=3D NULL && sockpath =3D=3D NULL) {
> +        char *base_filename =3D g_path_get_basename(device);
> +
>          sockpath =3D g_malloc(128);
> -        snprintf(sockpath, 128, SOCKET_PATH, basename(device));
> +        snprintf(sockpath, 128, SOCKET_PATH, base_filename);
> +        g_free(base_filename);
>      }
>
>      server =3D qio_net_listener_new();
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 9670614..53a29e3 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -808,7 +808,7 @@ static char *get_pci_driver(char const *syspath, int =
pathlen, Error **errp)
>      len =3D readlink(dpath, buf, sizeof(buf) - 1);
>      if (len !=3D -1) {
>          buf[len] =3D 0;
> -        driver =3D g_strdup(basename(buf));
> +        driver =3D g_path_get_basename(buf);
>      }
>      g_free(dpath);
>      g_free(path);
> @@ -1053,7 +1053,7 @@ static void build_guest_fsinfo_for_device(char cons=
t *devpath,
>      }
>
>      if (!fs->name) {
> -        fs->name =3D g_strdup(basename(syspath));
> +        fs->name =3D g_path_get_basename(syspath);
>      }
>
>      g_debug("  parse sysfs path '%s'", syspath);
> --
> 2.1.4
>
>



--=20
Marc-Andr=C3=A9 Lureau
