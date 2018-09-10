Received: from eggs.gnu.org ([2001:4830:134:3::10]:57377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fzMih-0002Qr-FG
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 09:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fzMV9-0000ZT-C5
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 09:45:17 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:53226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fzMV9-0000Yc-2R
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 09:45:15 -0400
Received: by mail-wm0-x241.google.com with SMTP id y139-v6so21488846wmc.2
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 06:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <1536238314-108139-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1536238314-108139-1-git-send-email-imammedo@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Sep 2018 17:45:00 +0400
Message-ID: <CAJ+F1CKC5dgFHpemc7qhR3i2sZhpmne5VB0K+YLHf00pWWtp4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qga: ignore non present cpus when
 handling qmp_guest_get_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, Sep 6, 2018 at 5:00 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> If VM has VCPUs plugged sparselly (for example a VM started with
> 3 VCPUs (cpu0, cpu1 and cpu2) and then cpu1 was hotunplugged so
> only cpu0 and cpu2 are present), QGA will rise a error
>   error: internal error: unable to execute QEMU agent command 'guest-get-=
vcpus':
>   open("/sys/devices/system/cpu/cpu1/"): No such file or directory
> when
>   virsh vcpucount FOO --guest
> is executed.
> Fix it by ignoring non present CPUs when fetching CPUs status from sysfs.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> v2:
>   do not create CPU entry if cpu isn't present
>   (Laszlo Ersek <lersek@redhat.com>)
> ---
>  qga/commands-posix.c | 115 ++++++++++++++++++++++++++-------------------=
------
>  1 file changed, 59 insertions(+), 56 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 37e8a2d..42d30f0 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2035,61 +2035,56 @@ static long sysconf_exact(int name, const char *n=
ame_str, Error **errp)
>   * Written members remain unmodified on error.
>   */
>  static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,
> -                          Error **errp)
> +                          char *dirpath, Error **errp)
>  {
> -    char *dirpath;
> +    int fd;
> +    int res;
>      int dirfd;
> +    static const char fn[] =3D "online";
>
> -    dirpath =3D g_strdup_printf("/sys/devices/system/cpu/cpu%" PRId64 "/=
",
> -                              vcpu->logical_id);
>      dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);
>      if (dirfd =3D=3D -1) {
>          error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
> -    } else {
> -        static const char fn[] =3D "online";
> -        int fd;
> -        int res;
> -
> -        fd =3D openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);
> -        if (fd =3D=3D -1) {
> -            if (errno !=3D ENOENT) {
> -                error_setg_errno(errp, errno, "open(\"%s/%s\")", dirpath=
, fn);
> -            } else if (sys2vcpu) {
> -                vcpu->online =3D true;
> -                vcpu->can_offline =3D false;
> -            } else if (!vcpu->online) {
> -                error_setg(errp, "logical processor #%" PRId64 " can't b=
e "
> -                           "offlined", vcpu->logical_id);
> -            } /* otherwise pretend successful re-onlining */
> -        } else {
> -            unsigned char status;
> -
> -            res =3D pread(fd, &status, 1, 0);
> -            if (res =3D=3D -1) {
> -                error_setg_errno(errp, errno, "pread(\"%s/%s\")", dirpat=
h, fn);
> -            } else if (res =3D=3D 0) {
> -                error_setg(errp, "pread(\"%s/%s\"): unexpected EOF", dir=
path,
> -                           fn);
> -            } else if (sys2vcpu) {
> -                vcpu->online =3D (status !=3D '0');
> -                vcpu->can_offline =3D true;
> -            } else if (vcpu->online !=3D (status !=3D '0')) {
> -                status =3D '0' + vcpu->online;
> -                if (pwrite(fd, &status, 1, 0) =3D=3D -1) {
> -                    error_setg_errno(errp, errno, "pwrite(\"%s/%s\")", d=
irpath,
> -                                     fn);
> -                }
> -            } /* otherwise pretend successful re-(on|off)-lining */
> +        return;
> +    }
>
> -            res =3D close(fd);
> -            g_assert(res =3D=3D 0);
> -        }
> +    fd =3D openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);
> +    if (fd =3D=3D -1) {
> +        if (errno !=3D ENOENT) {
> +            error_setg_errno(errp, errno, "open(\"%s/%s\")", dirpath, fn=
);
> +        } else if (sys2vcpu) {
> +            vcpu->online =3D true;
> +            vcpu->can_offline =3D false;
> +        } else if (!vcpu->online) {
> +            error_setg(errp, "logical processor #%" PRId64 " can't be "
> +                       "offlined", vcpu->logical_id);
> +        } /* otherwise pretend successful re-onlining */
> +    } else {
> +        unsigned char status;
> +
> +        res =3D pread(fd, &status, 1, 0);
> +        if (res =3D=3D -1) {
> +            error_setg_errno(errp, errno, "pread(\"%s/%s\")", dirpath, f=
n);
> +        } else if (res =3D=3D 0) {
> +            error_setg(errp, "pread(\"%s/%s\"): unexpected EOF", dirpath=
,
> +                       fn);
> +        } else if (sys2vcpu) {
> +            vcpu->online =3D (status !=3D '0');
> +            vcpu->can_offline =3D true;
> +        } else if (vcpu->online !=3D (status !=3D '0')) {
> +            status =3D '0' + vcpu->online;
> +            if (pwrite(fd, &status, 1, 0) =3D=3D -1) {
> +                error_setg_errno(errp, errno, "pwrite(\"%s/%s\")", dirpa=
th,
> +                                 fn);
> +            }
> +        } /* otherwise pretend successful re-(on|off)-lining */
>
> -        res =3D close(dirfd);
> +        res =3D close(fd);
>          g_assert(res =3D=3D 0);
>      }
>
> -    g_free(dirpath);
> +    res =3D close(dirfd);
> +    g_assert(res =3D=3D 0);
>  }
>
>  GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
> @@ -2107,17 +2102,21 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Er=
ror **errp)
>      while (local_err =3D=3D NULL && current < sc_max) {
>          GuestLogicalProcessor *vcpu;
>          GuestLogicalProcessorList *entry;
> -
> -        vcpu =3D g_malloc0(sizeof *vcpu);
> -        vcpu->logical_id =3D current++;
> -        vcpu->has_can_offline =3D true; /* lolspeak ftw */
> -        transfer_vcpu(vcpu, true, &local_err);
> -
> -        entry =3D g_malloc0(sizeof *entry);
> -        entry->value =3D vcpu;
> -
> -        *link =3D entry;
> -        link =3D &entry->next;
> +        int64_t id =3D current++;
> +        char *path =3D g_strdup_printf("/sys/devices/system/cpu/cpu%" PR=
Id64 "/",
> +                                     id);
> +
> +        if (g_file_test(path, G_FILE_TEST_EXISTS)) {
> +            vcpu =3D g_malloc0(sizeof *vcpu);
> +            vcpu->logical_id =3D id;
> +            vcpu->has_can_offline =3D true; /* lolspeak ftw */
> +            transfer_vcpu(vcpu, true, path, &local_err);
> +            entry =3D g_malloc0(sizeof *entry);
> +            entry->value =3D vcpu;
> +            *link =3D entry;
> +            link =3D &entry->next;
> +        }
> +        g_free(path);
>      }
>
>      if (local_err =3D=3D NULL) {
> @@ -2138,7 +2137,11 @@ int64_t qmp_guest_set_vcpus(GuestLogicalProcessorL=
ist *vcpus, Error **errp)
>
>      processed =3D 0;
>      while (vcpus !=3D NULL) {
> -        transfer_vcpu(vcpus->value, false, &local_err);
> +        char *path =3D g_strdup_printf("/sys/devices/system/cpu/cpu%" PR=
Id64 "/",
> +                                     vcpus->value->logical_id);
> +
> +        transfer_vcpu(vcpus->value, false, path, &local_err);
> +        g_free(path);
>          if (local_err !=3D NULL) {
>              break;
>          }
> --
> 2.7.4
>
>


--=20
Marc-Andr=C3=A9 Lureau
