Received: from eggs.gnu.org ([2001:4830:134:3::10]:42061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fsx1W-0004oR-U3
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 17:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fsx0I-00059u-Hd
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 17:18:58 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1fsx0H-00058s-3k
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 17:18:53 -0400
Received: by mail-oi0-x244.google.com with SMTP id z185-v6so11366192oia.5
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 14:18:52 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180810011348.8952-1-chen_han_xiao@126.com>
References: <20180810011348.8952-1-chen_han_xiao@126.com>
Message-ID: <153505572849.24497.6708545614556650264@sif>
Date: Thu, 23 Aug 2018 15:22:08 -0500
Subject: Re: [Qemu-devel] [resend][PATCH] qga-win: add support for
 qmp_guest_fsfreeze_freeze_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>, qemu-devel@nongnu.org

Quoting Chen Hanxiao (2018-08-09 20:13:48)
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

Some small nits below, but looks good otherwise.

> ---
>  qga/commands-win32.c        | 21 ++++++--------
>  qga/main.c                  |  2 +-
>  qga/vss-win32.c             |  5 ++--
>  qga/vss-win32.h             |  3 +-
>  qga/vss-win32/requester.cpp | 56 +++++++++++++++++++++++++++++++------
>  qga/vss-win32/requester.h   | 13 +++++++--
>  6 files changed, 72 insertions(+), 28 deletions(-)
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
> index 87372d40ef..098c783f1f 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -152,7 +152,7 @@ static void quit_handler(int sig)
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
> index 3d9c9716c0..0bd170eddc 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -234,7 +234,7 @@ out:
>      }
>  }
> =

> -void requester_freeze(int *num_vols, ErrorSet *errset)
> +void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)

Does this need to be declared as void *, or can we use the direct VolList*
type? Maybe even const VolList * const, since it is read-only?

>  {
>      COMPointer<IVssAsync> pAsync;
>      HANDLE volume;
> @@ -245,7 +245,9 @@ void requester_freeze(int *num_vols, ErrorSet *errset)
>      SECURITY_ATTRIBUTES sa;
>      WCHAR short_volume_name[64], *display_name =3D short_volume_name;
>      DWORD wait_status;
> +    PWCHAR WStr =3D NULL;
>      int num_fixed_drives =3D 0, i;
> +    int num_mount_points =3D 0;
> =

>      if (vss_ctx.pVssbc) { /* already frozen */
>          *num_vols =3D 0;
> @@ -337,12 +339,42 @@ void requester_freeze(int *num_vols, ErrorSet *errs=
et)
>          goto out;
>      }
> =

> -    volume =3D FindFirstVolumeW(short_volume_name, sizeof(short_volume_n=
ame));
> -    if (volume =3D=3D INVALID_HANDLE_VALUE) {
> -        err_set(errset, hr, "failed to find first volume");
> +    if (mountpoints) {
> +        for (volList *list =3D (volList *)mountpoints; list; list =3D li=
st->next) {
> +            size_t len =3D strlen(list->value) + 1;
> +            size_t converted =3D 0;
> +            VSS_ID pid;
> +
> +            WStr =3D new wchar_t[len];
> +            mbstowcs_s(&converted, WStr, len, list->value, _TRUNCATE);
> +
> +            hr =3D vss_ctx.pVssbc->AddToSnapshotSet(WStr,
> +                                                  g_gProviderId, &pid);
> +            if (FAILED(hr)) {
> +                err_set(errset, hr, "failed to add %S to snapshot set", =
WStr);
> +                goto out;

WStr is only needed within this block, so I'd prefer declaring it here
and then just adding an additional "delete WStr;" before the "goto out;".

Also I know the APIs force us to differ from the QEMU coding guidelines
with regard to CamelCase and whatnot, but I'd still prefer we stick to
it when possible. WStr also isn't very descriptive, maybe
volume_name_wchar?

> +            }
> +            num_mount_points++;
> +
> +            delete WStr;
> +        }
> +    }
> +
> +    if (mountpoints && num_mount_points =3D=3D 0) {
> +        /* If there is no valid mount points, just exit. */
>          goto out;
>      }

Logic might be a little cleaner if you move this block after the for
loop above.

> -    for (;;) {
> +
> +
> +    if (!mountpoints) {
> +        volume =3D FindFirstVolumeW(short_volume_name, sizeof(short_volu=
me_name));
> +        if (volume =3D=3D INVALID_HANDLE_VALUE) {
> +            err_set(errset, hr, "failed to find first volume");
> +            goto out;
> +        }
> +    }
> +
> +    while (!mountpoints) {

mountpoints is read-only in this function, so this is basically an
unconditional loop. I'd rather we do for(;;) like it was previously
and nest that in the "if (!mountpoints)" above to keep the logic
more contained.

>          if (GetDriveTypeW(short_volume_name) =3D=3D DRIVE_FIXED) {
>              VSS_ID pid;
>              hr =3D vss_ctx.pVssbc->AddToSnapshotSet(short_volume_name,
> @@ -355,7 +387,7 @@ void requester_freeze(int *num_vols, ErrorSet *errset)
>                      display_name =3D volume_path_name;
>                  }
>                  err_set(errset, hr, "failed to add %S to snapshot set",
> -                                 display_name);
> +                        display_name);
>                  FindVolumeClose(volume);
>                  goto out;
>              }
> @@ -368,7 +400,7 @@ void requester_freeze(int *num_vols, ErrorSet *errset)
>          }
>      }
> =

> -    if (num_fixed_drives =3D=3D 0) {
> +    if (!mountpoints && num_fixed_drives =3D=3D 0) {
>          goto out; /* If there is no fixed drive, just exit. */
>      }

and also nest this the same "if (!mountpoints)" block above.

> =

> @@ -435,13 +467,19 @@ void requester_freeze(int *num_vols, ErrorSet *errs=
et)
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
>      if (vss_ctx.pVssbc) {
>          vss_ctx.pVssbc->AbortBackup();
>      }
> +    delete WStr;
> =

>  out1:
>      requester_cleanup();
> @@ -449,7 +487,7 @@ out1:
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
