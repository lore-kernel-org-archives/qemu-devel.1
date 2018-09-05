Received: from eggs.gnu.org ([2001:4830:134:3::10]:48546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fxLwt-0002ZV-2c
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fxLwp-00006x-Mg
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:45:34 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1fxLwp-0008Ud-5M
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:45:31 -0400
Received: by mail-oi0-x242.google.com with SMTP id p84-v6so10435070oic.4
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 17:45:31 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180831062250.12425-1-chen_han_xiao@126.com>
References: <20180831062250.12425-1-chen_han_xiao@126.com>
Message-ID: <153610831907.28231.17025032673420402691@sif>
Date: Tue, 04 Sep 2018 19:45:19 -0500
Subject: Re: [Qemu-devel] [PATCH v2] qga-win: add support for
 qmp_guest_fsfreeze_freeze_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>
Cc: qemu-devel@nongnu.org

Quoting Chen Hanxiao (2018-08-31 01:22:50)
> From: Chen Hanxiao <chenhanxiao@gmail.com>
> =

> This patch add support for freeze specified fs.
> =

> The valid mountpoints list member are [1]:
> =

>   The path of a mounted folder, for example, Y:\MountX\
>   A drive letter, for example, D:\
>   A volume GUID path of the form \\?\Volume{GUID}\,
>       where GUID identifies the volume
>   A UNC path that specifies a remote file share,
>       for example, \\Clusterx\Share1\
> =

> [1] https://docs.microsoft.com/en-us/windows/desktop/api/vsbackup/nf-vsba=
ckup-ivssbackupcomponents-addtosnapshotset
> =

> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>

Thanks, applied to qga tree:
  https://github.com/mdroth/qemu/commits/qga

> ---
> v2:
>   optimize internal logic blocks
> =

>  qga/commands-win32.c        | 21 ++++-----
>  qga/main.c                  |  2 +-
>  qga/vss-win32.c             |  5 +-
>  qga/vss-win32.h             |  3 +-
>  qga/vss-win32/requester.cpp | 92 ++++++++++++++++++++++++++-----------
>  qga/vss-win32/requester.h   | 13 ++++--
>  6 files changed, 91 insertions(+), 45 deletions(-)
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 98d9735389..1d627f73c1 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -776,6 +776,13 @@ GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error =
**errp)
>   * The frozen state is limited for up to 10 seconds by VSS.
>   */
>  int64_t qmp_guest_fsfreeze_freeze(Error **errp)
> +{
> +    return qmp_guest_fsfreeze_freeze_list(false, NULL, errp);
> +}
> +
> +int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
> +                                       strList *mountpoints,
> +                                       Error **errp)
>  {
>      int i;
>      Error *local_err =3D NULL;
> @@ -790,7 +797,7 @@ int64_t qmp_guest_fsfreeze_freeze(Error **errp)
>      /* cannot risk guest agent blocking itself on a write in this state =
*/
>      ga_set_frozen(ga_state);
> =

> -    qga_vss_fsfreeze(&i, true, &local_err);
> +    qga_vss_fsfreeze(&i, true, mountpoints, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          goto error;
> @@ -808,15 +815,6 @@ error:
>      return 0;
>  }
> =

> -int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
> -                                       strList *mountpoints,
> -                                       Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -
> -    return 0;
> -}
> -
>  /*
>   * Thaw local file systems using Volume Shadow-copy Service.
>   */
> @@ -829,7 +827,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>          return 0;
>      }
> =

> -    qga_vss_fsfreeze(&i, false, errp);
> +    qga_vss_fsfreeze(&i, false, NULL, errp);
> =

>      ga_unset_frozen(ga_state);
>      return i;
> @@ -1646,7 +1644,6 @@ GList *ga_command_blacklist_init(GList *blacklist)
>          "guest-set-vcpus",
>          "guest-get-memory-blocks", "guest-set-memory-blocks",
>          "guest-get-memory-block-size",
> -        "guest-fsfreeze-freeze-list",
>          NULL};
>      char **p =3D (char **)list_unsupported;
> =

> diff --git a/qga/main.c b/qga/main.c
> index 6d70242d05..13bfff5f0a 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -151,7 +151,7 @@ static void quit_handler(int sig)
>              WaitForSingleObject(hEventTimeout, 0);
>              CloseHandle(hEventTimeout);
>          }
> -        qga_vss_fsfreeze(&i, false, &err);
> +        qga_vss_fsfreeze(&i, false, NULL, &err);
>          if (err) {
>              g_debug("Error unfreezing filesystems prior to exiting: %s",
>                  error_get_pretty(err));
> diff --git a/qga/vss-win32.c b/qga/vss-win32.c
> index a541f3ae01..f444a25a70 100644
> --- a/qga/vss-win32.c
> +++ b/qga/vss-win32.c
> @@ -147,7 +147,8 @@ void ga_uninstall_vss_provider(void)
>  }
> =

>  /* Call VSS requester and freeze/thaw filesystems and applications */
> -void qga_vss_fsfreeze(int *nr_volume, bool freeze, Error **errp)
> +void qga_vss_fsfreeze(int *nr_volume, bool freeze,
> +                      strList *mountpoints, Error **errp)
>  {
>      const char *func_name =3D freeze ? "requester_freeze" : "requester_t=
haw";
>      QGAVSSRequesterFunc func;
> @@ -164,5 +165,5 @@ void qga_vss_fsfreeze(int *nr_volume, bool freeze, Er=
ror **errp)
>          return;
>      }
> =

> -    func(nr_volume, &errset);
> +    func(nr_volume, mountpoints, &errset);
>  }
> diff --git a/qga/vss-win32.h b/qga/vss-win32.h
> index 4f8e39aa5c..ce2abe5a72 100644
> --- a/qga/vss-win32.h
> +++ b/qga/vss-win32.h
> @@ -22,6 +22,7 @@ bool vss_initialized(void);
>  int ga_install_vss_provider(void);
>  void ga_uninstall_vss_provider(void);
> =

> -void qga_vss_fsfreeze(int *nr_volume, bool freeze, Error **errp);
> +void qga_vss_fsfreeze(int *nr_volume, bool freeze,
> +                      strList *mountpints, Error **errp);
> =

>  #endif
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 3d9c9716c0..5378c55d23 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -234,7 +234,7 @@ out:
>      }
>  }
> =

> -void requester_freeze(int *num_vols, ErrorSet *errset)
> +void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
>  {
>      COMPointer<IVssAsync> pAsync;
>      HANDLE volume;
> @@ -246,6 +246,7 @@ void requester_freeze(int *num_vols, ErrorSet *errset)
>      WCHAR short_volume_name[64], *display_name =3D short_volume_name;
>      DWORD wait_status;
>      int num_fixed_drives =3D 0, i;
> +    int num_mount_points =3D 0;
> =

>      if (vss_ctx.pVssbc) { /* already frozen */
>          *num_vols =3D 0;
> @@ -337,39 +338,73 @@ void requester_freeze(int *num_vols, ErrorSet *errs=
et)
>          goto out;
>      }
> =

> -    volume =3D FindFirstVolumeW(short_volume_name, sizeof(short_volume_n=
ame));
> -    if (volume =3D=3D INVALID_HANDLE_VALUE) {
> -        err_set(errset, hr, "failed to find first volume");
> -        goto out;
> -    }
> -    for (;;) {
> -        if (GetDriveTypeW(short_volume_name) =3D=3D DRIVE_FIXED) {
> +    if (mountpoints) {
> +        PWCHAR volume_name_wchar;
> +        for (volList *list =3D (volList *)mountpoints; list; list =3D li=
st->next) {
> +            size_t len =3D strlen(list->value) + 1;
> +            size_t converted =3D 0;
>              VSS_ID pid;
> -            hr =3D vss_ctx.pVssbc->AddToSnapshotSet(short_volume_name,
> +
> +            volume_name_wchar =3D new wchar_t[len];
> +            mbstowcs_s(&converted, volume_name_wchar, len,
> +                       list->value, _TRUNCATE);
> +
> +            hr =3D vss_ctx.pVssbc->AddToSnapshotSet(volume_name_wchar,
>                                                    g_gProviderId, &pid);
>              if (FAILED(hr)) {
> -                WCHAR volume_path_name[PATH_MAX];
> -                if (GetVolumePathNamesForVolumeNameW(
> -                        short_volume_name, volume_path_name,
> -                        sizeof(volume_path_name), NULL) && *volume_path_=
name) {
> -                    display_name =3D volume_path_name;
> -                }
>                  err_set(errset, hr, "failed to add %S to snapshot set",
> -                                 display_name);
> -                FindVolumeClose(volume);
> +                        volume_name_wchar);
> +                delete volume_name_wchar;
>                  goto out;
>              }
> -            num_fixed_drives++;
> +            num_mount_points++;
> +
> +            delete volume_name_wchar;
>          }
> -        if (!FindNextVolumeW(volume, short_volume_name,
> -                             sizeof(short_volume_name))) {
> -            FindVolumeClose(volume);
> -            break;
> +
> +        if (num_mount_points =3D=3D 0) {
> +            /* If there is no valid mount points, just exit. */
> +            goto out;
>          }
>      }
> =

> -    if (num_fixed_drives =3D=3D 0) {
> -        goto out; /* If there is no fixed drive, just exit. */
> +    if (!mountpoints) {
> +        volume =3D FindFirstVolumeW(short_volume_name, sizeof(short_volu=
me_name));
> +        if (volume =3D=3D INVALID_HANDLE_VALUE) {
> +            err_set(errset, hr, "failed to find first volume");
> +            goto out;
> +        }
> +
> +        for (;;) {
> +            if (GetDriveTypeW(short_volume_name) =3D=3D DRIVE_FIXED) {
> +                VSS_ID pid;
> +                hr =3D vss_ctx.pVssbc->AddToSnapshotSet(short_volume_nam=
e,
> +                                                      g_gProviderId, &pi=
d);
> +                if (FAILED(hr)) {
> +                    WCHAR volume_path_name[PATH_MAX];
> +                    if (GetVolumePathNamesForVolumeNameW(
> +                            short_volume_name, volume_path_name,
> +                            sizeof(volume_path_name), NULL) &&
> +                            *volume_path_name) {
> +                        display_name =3D volume_path_name;
> +                    }
> +                    err_set(errset, hr, "failed to add %S to snapshot se=
t",
> +                            display_name);
> +                    FindVolumeClose(volume);
> +                    goto out;
> +                }
> +                num_fixed_drives++;
> +            }
> +            if (!FindNextVolumeW(volume, short_volume_name,
> +                                 sizeof(short_volume_name))) {
> +                FindVolumeClose(volume);
> +                break;
> +            }
> +        }
> +
> +        if (num_fixed_drives =3D=3D 0) {
> +            goto out; /* If there is no fixed drive, just exit. */
> +        }
>      }
> =

>      hr =3D vss_ctx.pVssbc->PrepareForBackup(pAsync.replace());
> @@ -435,7 +470,12 @@ void requester_freeze(int *num_vols, ErrorSet *errse=
t)
>          goto out;
>      }
> =

> -    *num_vols =3D vss_ctx.cFrozenVols =3D num_fixed_drives;
> +    if (mountpoints) {
> +        *num_vols =3D vss_ctx.cFrozenVols =3D num_mount_points;
> +    } else {
> +        *num_vols =3D vss_ctx.cFrozenVols =3D num_fixed_drives;
> +    }
> +
>      return;
> =

>  out:
> @@ -449,7 +489,7 @@ out1:
>  }
> =

> =

> -void requester_thaw(int *num_vols, ErrorSet *errset)
> +void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
>  {
>      COMPointer<IVssAsync> pAsync;
> =

> diff --git a/qga/vss-win32/requester.h b/qga/vss-win32/requester.h
> index 2a39d734a2..5a8e8faf0c 100644
> --- a/qga/vss-win32/requester.h
> +++ b/qga/vss-win32/requester.h
> @@ -34,9 +34,16 @@ typedef struct ErrorSet {
>  STDAPI requester_init(void);
>  STDAPI requester_deinit(void);
> =

> -typedef void (*QGAVSSRequesterFunc)(int *, ErrorSet *);
> -void requester_freeze(int *num_vols, ErrorSet *errset);
> -void requester_thaw(int *num_vols, ErrorSet *errset);
> +typedef struct volList volList;
> +
> +struct volList {
> +    volList *next;
> +    char *value;
> +};
> +
> +typedef void (*QGAVSSRequesterFunc)(int *, void *, ErrorSet *);
> +void requester_freeze(int *num_vols, void *volList, ErrorSet *errset);
> +void requester_thaw(int *num_vols, void *volList, ErrorSet *errset);
> =

>  #ifdef __cplusplus
>  }
> -- =

> 2.17.1
>=20
