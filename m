Received: from eggs.gnu.org ([2001:4830:134:3::10]:36490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cU8i1-0004Er-IJ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cU8hq-00019P-7q
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:08:41 -0500
MIME-Version: 1.0
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-3-eblake@redhat.com>
In-Reply-To: <20170118161653.19296-3-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Jan 2017 09:08:18 +0000
Message-ID: <CAJ+F1CLaoAvSd5y7A0jrr7+GHmJU6Kji97T85dGa0qni2hQP8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qdict: Add convenience helpers for
 wrapped puts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>, armbru@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, Anthony Perard <anthony.perard@citrix.com>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Chrysostomos Nanakos <chris@include.gr>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:X86" <xen-devel@lists.xensource.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Wed, Jan 18, 2017 at 8:44 PM Eric Blake <eblake@redhat.com> wrote:

> Quite a few users of qdict_put() were manually wrapping a
> non-QObject. We can make such call-sites shorter, by providing
> common macros to do the tedious work.  Also shorten nearby
> qdict_put_obj(,,QOBJECT()) sequences.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
>
> ---
>
> v2: rebase to current master
>
> I'm okay if you want me to break this patch into smaller pieces.
> ---
>  include/qapi/qmp/qdict.h            |   8 +++
>  block.c                             |  59 +++++++---------
>  block/archipelago.c                 |   4 +-
>  block/blkdebug.c                    |   6 +-
>  block/blkverify.c                   |  11 ++-
>  block/curl.c                        |   2 +-
>  block/file-posix.c                  |   8 +--
>  block/file-win32.c                  |   4 +-
>  block/iscsi.c                       |   2 +-
>  block/nbd.c                         |  41 ++++++-----
>  block/nfs.c                         |  43 +++++-------
>  block/null.c                        |   2 +-
>  block/qcow2.c                       |   4 +-
>  block/quorum.c                      |  13 ++--
>  block/ssh.c                         |  16 ++---
>  block/vvfat.c                       |  10 +--
>  blockdev.c                          |  28 ++++----
>  hw/block/xen_disk.c                 |   2 +-
>  hw/usb/xen-usb.c                    |  12 ++--
>  monitor.c                           |  18 ++---
>  qapi/qmp-event.c                    |   2 +-
>  qemu-img.c                          |   6 +-
>  qemu-io.c                           |   2 +-
>  qemu-nbd.c                          |   2 +-
>  qobject/qdict.c                     |   2 +-
>  target/s390x/cpu_models.c           |   4 +-
>  tests/check-qdict.c                 | 132
> ++++++++++++++++++------------------
>  tests/test-qmp-commands.c           |  30 ++++----
>  tests/test-qmp-event.c              |  30 ++++----
>  tests/test-qobject-output-visitor.c |   6 +-
>  util/qemu-option.c                  |   6 +-
>  31 files changed, 245 insertions(+), 270 deletions(-)
>
> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
> index fe9a4c5..9d9f9a3 100644
> --- a/include/qapi/qmp/qdict.h
> +++ b/include/qapi/qmp/qdict.h
> @@ -52,6 +52,14 @@ void qdict_destroy_obj(QObject *obj);
>  #define qdict_put(qdict, key, obj) \
>          qdict_put_obj(qdict, key, QOBJECT(obj))
>
> +/* Helpers for int, bool, and const char*. */
> +#define qdict_put_int(qdict, key, value) \
> +        qdict_put(qdict, key, qint_from_int(value))
> +#define qdict_put_bool(qdict, key, value) \
> +        qdict_put(qdict, key, qbool_from_bool(value))
> +#define qdict_put_str(qdict, key, value) \
> +        qdict_put(qdict, key, qstring_from_str(value))
> +
>  /* High level helpers */
>  double qdict_get_double(const QDict *qdict, const char *key);
>  int64_t qdict_get_int(const QDict *qdict, const char *key);
> diff --git a/block.c b/block.c
> index 39ddea3..e816657 100644
> --- a/block.c
> +++ b/block.c
> @@ -876,16 +876,16 @@ static void update_flags_from_options(int *flags,
> QemuOpts *opts)
>  static void update_options_from_flags(QDict *options, int flags)
>  {
>      if (!qdict_haskey(options, BDRV_OPT_CACHE_DIRECT)) {
> -        qdict_put(options, BDRV_OPT_CACHE_DIRECT,
> -                  qbool_from_bool(flags & BDRV_O_NOCACHE));
> +        qdict_put_bool(options, BDRV_OPT_CACHE_DIRECT,
> +                       flags & BDRV_O_NOCACHE);
>      }
>      if (!qdict_haskey(options, BDRV_OPT_CACHE_NO_FLUSH)) {
> -        qdict_put(options, BDRV_OPT_CACHE_NO_FLUSH,
> -                  qbool_from_bool(flags & BDRV_O_NO_FLUSH));
> +        qdict_put_bool(options, BDRV_OPT_CACHE_NO_FLUSH,
> +                       flags & BDRV_O_NO_FLUSH);
>      }
>      if (!qdict_haskey(options, BDRV_OPT_READ_ONLY)) {
> -        qdict_put(options, BDRV_OPT_READ_ONLY,
> -                  qbool_from_bool(!(flags & BDRV_O_RDWR)));
> +        qdict_put_bool(options, BDRV_OPT_READ_ONLY,
> +                       !(flags & BDRV_O_RDWR));
>      }
>  }
>
> @@ -1244,7 +1244,7 @@ static int bdrv_fill_options(QDict **options, const
> char *filename,
>      /* Fetch the file name from the options QDict if necessary */
>      if (protocol && filename) {
>          if (!qdict_haskey(*options, "filename")) {
> -            qdict_put(*options, "filename", qstring_from_str(filename));
> +            qdict_put_str(*options, "filename", filename);
>              parse_filename =3D true;
>          } else {
>              error_setg(errp, "Can't specify 'file' and 'filename' option=
s
> at "
> @@ -1264,7 +1264,7 @@ static int bdrv_fill_options(QDict **options, const
> char *filename,
>              }
>
>              drvname =3D drv->format_name;
> -            qdict_put(*options, "driver", qstring_from_str(drvname));
> +            qdict_put_str(*options, "driver", drvname);
>          } else {
>              error_setg(errp, "Must specify either driver or file");
>              return -EINVAL;
> @@ -1517,7 +1517,7 @@ int bdrv_open_backing_file(BlockDriverState *bs,
> QDict *parent_options,
>      }
>
>      if (bs->backing_format[0] !=3D '\0' && !qdict_haskey(options,
> "driver")) {
> -        qdict_put(options, "driver",
> qstring_from_str(bs->backing_format));
> +        qdict_put_str(options, "driver", bs->backing_format);
>      }
>
>      backing_hd =3D bdrv_open_inherit(*backing_filename ? backing_filenam=
e :
> NULL,
> @@ -1607,7 +1607,7 @@ static BlockDriverState
> *bdrv_append_temp_snapshot(BlockDriverState *bs,
>      char *tmp_filename =3D g_malloc0(PATH_MAX + 1);
>      int64_t total_size;
>      QemuOpts *opts =3D NULL;
> -    BlockDriverState *bs_snapshot;
> +    BlockDriverState *bs_snapshot =3D NULL;
>      int ret;
>
>      /* if snapshot, we create a temporary backing file and open it
> @@ -1639,12 +1639,9 @@ static BlockDriverState
> *bdrv_append_temp_snapshot(BlockDriverState *bs,
>      }
>
>      /* Prepare options QDict for the temporary file */
> -    qdict_put(snapshot_options, "file.driver",
> -              qstring_from_str("file"));
> -    qdict_put(snapshot_options, "file.filename",
> -              qstring_from_str(tmp_filename));
> -    qdict_put(snapshot_options, "driver",
> -              qstring_from_str("qcow2"));
> +    qdict_put_str(snapshot_options, "file.driver", "file");
> +    qdict_put_str(snapshot_options, "file.filename", tmp_filename);
> +    qdict_put_str(snapshot_options, "driver", "qcow2");
>
>      bs_snapshot =3D bdrv_open(NULL, NULL, snapshot_options, flags, errp)=
;
>      snapshot_options =3D NULL;
> @@ -1659,13 +1656,10 @@ static BlockDriverState
> *bdrv_append_temp_snapshot(BlockDriverState *bs,
>      bdrv_ref(bs_snapshot);
>      bdrv_append(bs_snapshot, bs);
>
> +out:
> +    QDECREF(snapshot_options);
>      g_free(tmp_filename);
>      return bs_snapshot;
> -
> -out:
> -    QDECREF(snapshot_options);
> -    g_free(tmp_filename);
> -    return NULL;
>  }
>

that could be a seperate cleanup


>
>  /*
> @@ -1816,8 +1810,8 @@ static BlockDriverState *bdrv_open_inherit(const
> char *filename,
>           * sure to update both bs->options (which has the full effective
>           * options for bs) and options (which has file.* already removed=
).
>           */
> -        qdict_put(bs->options, "driver",
> qstring_from_str(drv->format_name));
> -        qdict_put(options, "driver", qstring_from_str(drv->format_name))=
;
> +        qdict_put_str(bs->options, "driver", drv->format_name);
> +        qdict_put_str(options, "driver", drv->format_name);
>      } else if (!drv) {
>          error_setg(errp, "Must specify either driver or file");
>          goto fail;
> @@ -2191,12 +2185,12 @@ int bdrv_reopen_prepare(BDRVReopenState
> *reopen_state, BlockReopenQueue *queue,
>       * that they are checked at the end of this function. */
>      value =3D qemu_opt_get(opts, "node-name");
>      if (value) {
> -        qdict_put(reopen_state->options, "node-name",
> qstring_from_str(value));
> +        qdict_put_str(reopen_state->options, "node-name", value);
>      }
>
>      value =3D qemu_opt_get(opts, "driver");
>      if (value) {
> -        qdict_put(reopen_state->options, "driver",
> qstring_from_str(value));
> +        qdict_put_str(reopen_state->options, "driver", value);
>      }
>
>      /* if we are to stay read-only, do not allow permission change
> @@ -3606,8 +3600,7 @@ void bdrv_img_create(const char *filename, const
> char *fmt,
>
>              if (backing_fmt) {
>                  backing_options =3D qdict_new();
> -                qdict_put(backing_options, "driver",
> -                          qstring_from_str(backing_fmt));
> +                qdict_put_str(backing_options, "driver", backing_fmt);
>              }
>
>              bs =3D bdrv_open(full_backing, NULL, backing_options,
> back_flags,
> @@ -3997,11 +3990,9 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>           * contain a representation of the filename, therefore the
> following
>           * suffices without querying the (exact_)filename of this BDS. *=
/
>          if (bs->file->bs->full_open_options) {
> -            qdict_put_obj(opts, "driver",
> -                          QOBJECT(qstring_from_str(drv->format_name)));
> +            qdict_put_str(opts, "driver", drv->format_name);
>              QINCREF(bs->file->bs->full_open_options);
> -            qdict_put_obj(opts, "file",
> -                          QOBJECT(bs->file->bs->full_open_options));
> +            qdict_put(opts, "file", bs->file->bs->full_open_options);
>
>              bs->full_open_options =3D opts;
>          } else {
> @@ -4017,8 +4008,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>
>          opts =3D qdict_new();
>          append_open_options(opts, bs);
> -        qdict_put_obj(opts, "driver",
> -                      QOBJECT(qstring_from_str(drv->format_name)));
> +        qdict_put_str(opts, "driver", drv->format_name);
>
>          if (bs->exact_filename[0]) {
>              /* This may not work for all block protocol drivers (some ma=
y
> @@ -4028,8 +4018,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>               * needs some special format of the options QDict, it needs =
to
>               * implement the driver-specific bdrv_refresh_filename()
> function.
>               */
> -            qdict_put_obj(opts, "filename",
> -                          QOBJECT(qstring_from_str(bs->exact_filename)))=
;
> +            qdict_put_str(opts, "filename", bs->exact_filename);
>          }
>
>          bs->full_open_options =3D opts;
> diff --git a/block/archipelago.c b/block/archipelago.c
> index 2449cfc..bf20c61 100644
> --- a/block/archipelago.c
> +++ b/block/archipelago.c
> @@ -432,10 +432,10 @@ static void archipelago_parse_filename(const char
> *filename, QDict *options,
>          g_free(segment_name);
>      }
>      if (mport !=3D NoPort) {
> -        qdict_put(options, ARCHIPELAGO_OPT_MPORT, qint_from_int(mport));
> +        qdict_put_int(options, ARCHIPELAGO_OPT_MPORT, mport);
>      }
>      if (vport !=3D NoPort) {
> -        qdict_put(options, ARCHIPELAGO_OPT_VPORT, qint_from_int(vport));
> +        qdict_put_int(options, ARCHIPELAGO_OPT_VPORT, vport);
>      }
>  }
>
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index acccf85..073c8ec 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -301,7 +301,7 @@ static void blkdebug_parse_filename(const char
> *filename, QDict *options,
>      if (!strstart(filename, "blkdebug:", &filename)) {
>          /* There was no prefix; therefore, all options have to be alread=
y
>             present in the QDict (except for the filename) */
> -        qdict_put(options, "x-image", qstring_from_str(filename));
> +        qdict_put_str(options, "x-image", filename);
>          return;
>      }
>
> @@ -320,7 +320,7 @@ static void blkdebug_parse_filename(const char
> *filename, QDict *options,
>
>      /* TODO Allow multi-level nesting and set file.filename here */
>      filename =3D c + 1;
> -    qdict_put(options, "x-image", qstring_from_str(filename));
> +    qdict_put_str(options, "x-image", filename);
>  }
>
>  static QemuOptsList runtime_opts =3D {
> @@ -702,7 +702,7 @@ static void blkdebug_refresh_filename(BlockDriverStat=
e
> *bs, QDict *options)
>      }
>
>      opts =3D qdict_new();
> -    qdict_put_obj(opts, "driver", QOBJECT(qstring_from_str("blkdebug")))=
;
> +    qdict_put_str(opts, "driver", "blkdebug");
>
>      QINCREF(bs->file->bs->full_open_options);
>      qdict_put_obj(opts, "image",
> QOBJECT(bs->file->bs->full_open_options));
> diff --git a/block/blkverify.c b/block/blkverify.c
> index 43a940c..de928ca 100644
> --- a/block/blkverify.c
> +++ b/block/blkverify.c
> @@ -67,7 +67,7 @@ static void blkverify_parse_filename(const char
> *filename, QDict *options,
>      if (!strstart(filename, "blkverify:", &filename)) {
>          /* There was no prefix; therefore, all options have to be alread=
y
>             present in the QDict (except for the filename) */
> -        qdict_put(options, "x-image", qstring_from_str(filename));
> +        qdict_put_str(options, "x-image", filename);
>          return;
>      }
>
> @@ -84,7 +84,7 @@ static void blkverify_parse_filename(const char
> *filename, QDict *options,
>
>      /* TODO Allow multi-level nesting and set file.filename here */
>      filename =3D c + 1;
> -    qdict_put(options, "x-image", qstring_from_str(filename));
> +    qdict_put_str(options, "x-image", filename);
>  }
>
>  static QemuOptsList runtime_opts =3D {
> @@ -291,13 +291,12 @@ static void
> blkverify_refresh_filename(BlockDriverState *bs, QDict *options)
>          && s->test_file->bs->full_open_options)
>      {
>          QDict *opts =3D qdict_new();
> -        qdict_put_obj(opts, "driver",
> QOBJECT(qstring_from_str("blkverify")));
> +        qdict_put_str(opts, "driver", "blkverify");
>
>          QINCREF(bs->file->bs->full_open_options);
> -        qdict_put_obj(opts, "raw",
> QOBJECT(bs->file->bs->full_open_options));
> +        qdict_put(opts, "raw", bs->file->bs->full_open_options);
>          QINCREF(s->test_file->bs->full_open_options);
> -        qdict_put_obj(opts, "test",
> -                      QOBJECT(s->test_file->bs->full_open_options));
> +        qdict_put(opts, "test", s->test_file->bs->full_open_options);
>
>          bs->full_open_options =3D opts;
>      }
> diff --git a/block/curl.c b/block/curl.c
> index 792fef8..5ec659f 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -531,7 +531,7 @@ static void curl_clean_state(CURLState *s)
>  static void curl_parse_filename(const char *filename, QDict *options,
>                                  Error **errp)
>  {
> -    qdict_put(options, CURL_BLOCK_OPT_URL, qstring_from_str(filename));
> +    qdict_put_str(options, CURL_BLOCK_OPT_URL, filename);
>  }
>
>  static void curl_detach_aio_context(BlockDriverState *bs)
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 28b47d9..38a009b 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -376,7 +376,7 @@ static void raw_parse_filename(const char *filename,
> QDict *options,
>       * function call can be ignored. */
>      strstart(filename, "file:", &filename);
>
> -    qdict_put_obj(options, "filename",
> QOBJECT(qstring_from_str(filename)));
> +    qdict_put_str(options, "filename", filename);
>  }
>
>  static QemuOptsList raw_runtime_opts =3D {
> @@ -2061,7 +2061,7 @@ static void hdev_parse_filename(const char
> *filename, QDict *options,
>      /* The prefix is optional, just as for "file". */
>      strstart(filename, "host_device:", &filename);
>
> -    qdict_put_obj(options, "filename",
> QOBJECT(qstring_from_str(filename)));
> +    qdict_put_str(options, "filename", filename);
>  }
>
>  static bool hdev_is_sg(BlockDriverState *bs)
> @@ -2144,7 +2144,7 @@ static int hdev_open(BlockDriverState *bs, QDict
> *options, int flags,
>              goto hdev_open_Mac_error;
>          }
>
> -        qdict_put(options, "filename", qstring_from_str(bsd_path));
> +        qdict_put_str(options, "filename", bsd_path);
>
>  hdev_open_Mac_error:
>          g_free(mediaType);
> @@ -2354,7 +2354,7 @@ static void cdrom_parse_filename(const char
> *filename, QDict *options,
>      /* The prefix is optional, just as for "file". */
>      strstart(filename, "host_cdrom:", &filename);
>
> -    qdict_put_obj(options, "filename",
> QOBJECT(qstring_from_str(filename)));
> +    qdict_put_str(options, "filename", filename);
>  }
>  #endif
>
> diff --git a/block/file-win32.c b/block/file-win32.c
> index 800fabd..0d455d1 100644
> --- a/block/file-win32.c
> +++ b/block/file-win32.c
> @@ -282,7 +282,7 @@ static void raw_parse_filename(const char *filename,
> QDict *options,
>       * function call can be ignored. */
>      strstart(filename, "file:", &filename);
>
> -    qdict_put_obj(options, "filename",
> QOBJECT(qstring_from_str(filename)));
> +    qdict_put_str(options, "filename", filename);
>  }
>
>  static QemuOptsList raw_runtime_opts =3D {
> @@ -669,7 +669,7 @@ static void hdev_parse_filename(const char *filename,
> QDict *options,
>      /* The prefix is optional, just as for "file". */
>      strstart(filename, "host_device:", &filename);
>
> -    qdict_put_obj(options, "filename",
> QOBJECT(qstring_from_str(filename)));
> +    qdict_put_str(options, "filename", filename);
>  }
>
>  static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 6aeeb9e..e2864e6 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -1966,7 +1966,7 @@ static int iscsi_create(const char *filename,
> QemuOpts *opts, Error **errp)
>      iscsilun =3D bs->opaque;
>
>      bs_options =3D qdict_new();
> -    qdict_put(bs_options, "filename", qstring_from_str(filename));
> +    qdict_put_str(bs_options, "filename", filename);
>      ret =3D iscsi_open(bs, bs_options, 0, NULL);
>      QDECREF(bs_options);
>
> diff --git a/block/nbd.c b/block/nbd.c
> index 35f24be..334748d 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -79,7 +79,7 @@ static int nbd_parse_uri(const char *filename, QDict
> *options)
>      p =3D uri->path ? uri->path : "/";
>      p +=3D strspn(p, "/");
>      if (p[0]) {
> -        qdict_put(options, "export", qstring_from_str(p));
> +        qdict_put_str(options, "export", p);
>      }
>
>      qp =3D query_params_parse(uri->query);
> @@ -94,9 +94,8 @@ static int nbd_parse_uri(const char *filename, QDict
> *options)
>              ret =3D -EINVAL;
>              goto out;
>          }
> -        qdict_put(options, "server.type", qstring_from_str("unix"));
> -        qdict_put(options, "server.data.path",
> -                  qstring_from_str(qp->p[0].value));
> +        qdict_put_str(options, "server.type", "unix");
> +        qdict_put_str(options, "server.data.path", qp->p[0].value);
>      } else {
>          QString *host;
>          char *port_str;
> @@ -115,11 +114,11 @@ static int nbd_parse_uri(const char *filename, QDic=
t
> *options)
>              host =3D qstring_from_str(uri->server);
>          }
>
> -        qdict_put(options, "server.type", qstring_from_str("inet"));
> +        qdict_put_str(options, "server.type", "inet");
>          qdict_put(options, "server.data.host", host);
>
>          port_str =3D g_strdup_printf("%d", uri->port ?: NBD_DEFAULT_PORT=
);
> -        qdict_put(options, "server.data.port",
> qstring_from_str(port_str));
> +        qdict_put_str(options, "server.data.port", port_str);
>          g_free(port_str);
>      }
>
> @@ -181,7 +180,7 @@ static void nbd_parse_filename(const char *filename,
> QDict *options,
>          export_name[0] =3D 0; /* truncate 'file' */
>          export_name +=3D strlen(EN_OPTSTR);
>
> -        qdict_put(options, "export", qstring_from_str(export_name));
> +        qdict_put_str(options, "export", export_name);
>      }
>
>      /* extract the host_spec - fail if it's not nbd:... */
> @@ -196,8 +195,8 @@ static void nbd_parse_filename(const char *filename,
> QDict *options,
>
>      /* are we a UNIX or TCP socket? */
>      if (strstart(host_spec, "unix:", &unixpath)) {
> -        qdict_put(options, "server.type", qstring_from_str("unix"));
> -        qdict_put(options, "server.data.path",
> qstring_from_str(unixpath));
> +        qdict_put_str(options, "server.type", "unix");
> +        qdict_put_str(options, "server.data.path", unixpath);
>      } else {
>          InetSocketAddress *addr =3D NULL;
>
> @@ -206,9 +205,9 @@ static void nbd_parse_filename(const char *filename,
> QDict *options,
>              goto out;
>          }
>
> -        qdict_put(options, "server.type", qstring_from_str("inet"));
> -        qdict_put(options, "server.data.host",
> qstring_from_str(addr->host));
> -        qdict_put(options, "server.data.port",
> qstring_from_str(addr->port));
> +        qdict_put_str(options, "server.type", "inet");
> +        qdict_put_str(options, "server.data.host", addr->host);
> +        qdict_put_str(options, "server.data.port", addr->port);
>          qapi_free_InetSocketAddress(addr);
>      }
>
> @@ -247,13 +246,13 @@ static bool nbd_process_legacy_socket_options(QDict
> *output_options,
>              return false;
>          }
>
> -        qdict_put(output_options, "server.type",
> qstring_from_str("unix"));
> -        qdict_put(output_options, "server.data.path",
> qstring_from_str(path));
> +        qdict_put_str(output_options, "server.type", "unix");
> +        qdict_put_str(output_options, "server.data.path", path);
>      } else if (host) {
> -        qdict_put(output_options, "server.type",
> qstring_from_str("inet"));
> -        qdict_put(output_options, "server.data.host",
> qstring_from_str(host));
> -        qdict_put(output_options, "server.data.port",
> -                  qstring_from_str(port ?: stringify(NBD_DEFAULT_PORT)))=
;
> +        qdict_put_str(output_options, "server.type", "inet");
> +        qdict_put_str(output_options, "server.data.host", host);
> +        qdict_put_str(output_options, "server.data.port",
> +                      port ?: stringify(NBD_DEFAULT_PORT));
>      }
>
>      return true;
> @@ -517,7 +516,7 @@ static void nbd_refresh_filename(BlockDriverState *bs=
,
> QDict *options)
>          path =3D s->saddr->u.q_unix.data->path;
>      }
>
> -    qdict_put(opts, "driver", qstring_from_str("nbd"));
> +    qdict_put_str(opts, "driver", "nbd");
>
>      if (path && s->export) {
>          snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> @@ -542,10 +541,10 @@ static void nbd_refresh_filename(BlockDriverState
> *bs, QDict *options)
>      qdict_put_obj(opts, "server", saddr_qdict);
>
>      if (s->export) {
> -        qdict_put(opts, "export", qstring_from_str(s->export));
> +        qdict_put_str(opts, "export", s->export);
>      }
>      if (s->tlscredsid) {
> -        qdict_put(opts, "tls-creds", qstring_from_str(s->tlscredsid));
> +        qdict_put_str(opts, "tls-creds", s->tlscredsid);
>      }
>
>      qdict_flatten(opts);
> diff --git a/block/nfs.c b/block/nfs.c
> index a564340..aaeabd0 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -103,9 +103,9 @@ static int nfs_parse_uri(const char *filename, QDict
> *options, Error **errp)
>          goto out;
>      }
>
> -    qdict_put(options, "server.host", qstring_from_str(uri->server));
> -    qdict_put(options, "server.type", qstring_from_str("inet"));
> -    qdict_put(options, "path", qstring_from_str(uri->path));
> +    qdict_put_str(options, "server.host", uri->server);
> +    qdict_put_str(options, "server.type", "inet");
> +    qdict_put_str(options, "path", uri->path);
>
>      for (i =3D 0; i < qp->n; i++) {
>          if (!qp->p[i].value) {
> @@ -119,23 +119,17 @@ static int nfs_parse_uri(const char *filename, QDic=
t
> *options, Error **errp)
>              goto out;
>          }
>          if (!strcmp(qp->p[i].name, "uid")) {
> -            qdict_put(options, "user",
> -                      qstring_from_str(qp->p[i].value));
> +            qdict_put_str(options, "user", qp->p[i].value);
>          } else if (!strcmp(qp->p[i].name, "gid")) {
> -            qdict_put(options, "group",
> -                      qstring_from_str(qp->p[i].value));
> +            qdict_put_str(options, "group", qp->p[i].value);
>          } else if (!strcmp(qp->p[i].name, "tcp-syncnt")) {
> -            qdict_put(options, "tcp-syn-count",
> -                      qstring_from_str(qp->p[i].value));
> +            qdict_put_str(options, "tcp-syn-count", qp->p[i].value);
>          } else if (!strcmp(qp->p[i].name, "readahead")) {
> -            qdict_put(options, "readahead-size",
> -                      qstring_from_str(qp->p[i].value));
> +            qdict_put_str(options, "readahead-size", qp->p[i].value);
>          } else if (!strcmp(qp->p[i].name, "pagecache")) {
> -            qdict_put(options, "page-cache-size",
> -                      qstring_from_str(qp->p[i].value));
> +            qdict_put_str(options, "page-cache-size", qp->p[i].value);
>          } else if (!strcmp(qp->p[i].name, "debug")) {
> -            qdict_put(options, "debug",
> -                      qstring_from_str(qp->p[i].value));
> +            qdict_put_str(options, "debug", qp->p[i].value);
>          } else {
>              error_setg(errp, "Unknown NFS parameter name: %s",
>                         qp->p[i].name);
> @@ -775,7 +769,7 @@ static void nfs_refresh_filename(BlockDriverState *bs=
,
> QDict *options)
>      QObject *server_qdict;
>      Visitor *ov;
>
> -    qdict_put(opts, "driver", qstring_from_str("nfs"));
> +    qdict_put_str(opts, "driver", "nfs");
>
>      if (client->uid && !client->gid) {
>          snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> @@ -800,28 +794,25 @@ static void nfs_refresh_filename(BlockDriverState
> *bs, QDict *options)
>      assert(qobject_type(server_qdict) =3D=3D QTYPE_QDICT);
>
>      qdict_put_obj(opts, "server", server_qdict);
> -    qdict_put(opts, "path", qstring_from_str(client->path));
> +    qdict_put_str(opts, "path", client->path);
>
>      if (client->uid) {
> -        qdict_put(opts, "uid", qint_from_int(client->uid));
> +        qdict_put_int(opts, "uid", client->uid);
>      }
>      if (client->gid) {
> -        qdict_put(opts, "gid", qint_from_int(client->gid));
> +        qdict_put_int(opts, "gid", client->gid);
>      }
>      if (client->tcp_syncnt) {
> -        qdict_put(opts, "tcp-syncnt",
> -                      qint_from_int(client->tcp_syncnt));
> +        qdict_put_int(opts, "tcp-syncnt", client->tcp_syncnt);
>      }
>      if (client->readahead) {
> -        qdict_put(opts, "readahead",
> -                      qint_from_int(client->readahead));
> +        qdict_put_int(opts, "readahead", client->readahead);
>      }
>      if (client->pagecache) {
> -        qdict_put(opts, "pagecache",
> -                      qint_from_int(client->pagecache));
> +        qdict_put_int(opts, "pagecache", client->pagecache);
>      }
>      if (client->debug) {
> -        qdict_put(opts, "debug", qint_from_int(client->debug));
> +        qdict_put_int(opts, "debug", client->debug);
>      }
>
>      visit_free(ov);
> diff --git a/block/null.c b/block/null.c
> index b300390..876f909 100644
> --- a/block/null.c
> +++ b/block/null.c
> @@ -232,7 +232,7 @@ static void null_refresh_filename(BlockDriverState
> *bs, QDict *opts)
>                   bs->drv->format_name);
>      }
>
> -    qdict_put(opts, "driver", qstring_from_str(bs->drv->format_name));
> +    qdict_put_str(opts, "driver", bs->drv->format_name);
>      bs->full_open_options =3D opts;
>  }
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 96fb8a8..5bf50af 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2252,7 +2252,7 @@ static int qcow2_create2(const char *filename,
> int64_t total_size,
>       * table)
>       */
>      options =3D qdict_new();
> -    qdict_put(options, "driver", qstring_from_str("qcow2"));
> +    qdict_put_str(options, "driver", "qcow2");
>      blk =3D blk_new_open(filename, NULL, options,
>                         BDRV_O_RDWR | BDRV_O_NO_FLUSH, &local_err);
>      if (blk =3D=3D NULL) {
> @@ -2313,7 +2313,7 @@ static int qcow2_create2(const char *filename,
> int64_t total_size,
>
>      /* Reopen the image without BDRV_O_NO_FLUSH to flush it before
> returning */
>      options =3D qdict_new();
> -    qdict_put(options, "driver", qstring_from_str("qcow2"));
> +    qdict_put_str(options, "driver", "qcow2");
>      blk =3D blk_new_open(filename, NULL, options,
>                         BDRV_O_RDWR | BDRV_O_NO_BACKING, &local_err);
>      if (blk =3D=3D NULL) {
> diff --git a/block/quorum.c b/block/quorum.c
> index 86e2072..6a426ef 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -1094,14 +1094,11 @@ static void
> quorum_refresh_filename(BlockDriverState *bs, QDict *options)
>      }
>
>      opts =3D qdict_new();
> -    qdict_put_obj(opts, "driver", QOBJECT(qstring_from_str("quorum")));
> -    qdict_put_obj(opts, QUORUM_OPT_VOTE_THRESHOLD,
> -                  QOBJECT(qint_from_int(s->threshold)));
> -    qdict_put_obj(opts, QUORUM_OPT_BLKVERIFY,
> -                  QOBJECT(qbool_from_bool(s->is_blkverify)));
> -    qdict_put_obj(opts, QUORUM_OPT_REWRITE,
> -                  QOBJECT(qbool_from_bool(s->rewrite_corrupted)));
> -    qdict_put_obj(opts, "children", QOBJECT(children));
> +    qdict_put_str(opts, "driver", "quorum");
> +    qdict_put_int(opts, QUORUM_OPT_VOTE_THRESHOLD, s->threshold);
> +    qdict_put_bool(opts, QUORUM_OPT_BLKVERIFY, s->is_blkverify);
> +    qdict_put_bool(opts, QUORUM_OPT_REWRITE, s->rewrite_corrupted);
> +    qdict_put(opts, "children", children);
>
>      bs->full_open_options =3D opts;
>  }
> diff --git a/block/ssh.c b/block/ssh.c
> index e0edf20..3f76d53 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -227,24 +227,23 @@ static int parse_uri(const char *filename, QDict
> *options, Error **errp)
>      }
>
>      if(uri->user && strcmp(uri->user, "") !=3D 0) {
> -        qdict_put(options, "user", qstring_from_str(uri->user));
> +        qdict_put_str(options, "user", uri->user);
>      }
>
> -    qdict_put(options, "server.host", qstring_from_str(uri->server));
> +    qdict_put_str(options, "server.host", uri->server);
>
>      port_str =3D g_strdup_printf("%d", uri->port ?: 22);
> -    qdict_put(options, "server.port", qstring_from_str(port_str));
> +    qdict_put_str(options, "server.port", port_str);
>      g_free(port_str);
>
> -    qdict_put(options, "path", qstring_from_str(uri->path));
> +    qdict_put_str(options, "path", uri->path);
>
>      /* Pick out any query parameters that we understand, and ignore
>       * the rest.
>       */
>      for (i =3D 0; i < qp->n; ++i) {
>          if (strcmp(qp->p[i].name, "host_key_check") =3D=3D 0) {
> -            qdict_put(options, "host_key_check",
> -                      qstring_from_str(qp->p[i].value));
> +            qdict_put_str(options, "host_key_check", qp->p[i].value);
>          }
>      }
>
> @@ -574,9 +573,8 @@ static bool ssh_process_legacy_socket_options(QDict
> *output_opts,
>      }
>
>      if (host) {
> -        qdict_put(output_opts, "server.host", qstring_from_str(host));
> -        qdict_put(output_opts, "server.port",
> -                  qstring_from_str(port ?: stringify(22)));
> +        qdict_put_str(output_opts, "server.host", host);
> +        qdict_put_str(output_opts, "server.port", port ?: stringify(22))=
;
>      }
>
>      return true;
> diff --git a/block/vvfat.c b/block/vvfat.c
> index ded2109..cf2e109 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1057,10 +1057,10 @@ static void vvfat_parse_filename(const char
> *filename, QDict *options,
>      }
>
>      /* Fill in the options QDict */
> -    qdict_put(options, "dir", qstring_from_str(filename));
> -    qdict_put(options, "fat-type", qint_from_int(fat_type));
> -    qdict_put(options, "floppy", qbool_from_bool(floppy));
> -    qdict_put(options, "rw", qbool_from_bool(rw));
> +    qdict_put_str(options, "dir", filename);
> +    qdict_put_int(options, "fat-type", fat_type);
> +    qdict_put_bool(options, "floppy", floppy);
> +    qdict_put_bool(options, "rw", rw);
>  }
>
>  static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
> @@ -3019,7 +3019,7 @@ static int enable_write_target(BlockDriverState *bs=
,
> Error **errp)
>      }
>
>      options =3D qdict_new();
> -    qdict_put(options, "write-target.driver", qstring_from_str("qcow"));
> +    qdict_put_str(options, "write-target.driver", "qcow");
>      s->qcow =3D bdrv_open_child(s->qcow_filename, options, "write-target=
",
> bs,
>                                &child_vvfat_qcow, false, errp);
>      QDECREF(options);
> diff --git a/blockdev.c b/blockdev.c
> index 245e1e1..2802cea 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -523,7 +523,7 @@ static BlockBackend *blockdev_init(const char *file,
> QDict *bs_opts,
>              error_setg(errp, "Cannot specify both 'driver' and 'format'"=
);
>              goto early_err;
>          }
> -        qdict_put(bs_opts, "driver", qstring_from_str(buf));
> +        qdict_put_str(bs_opts, "driver", buf);
>      }
>
>      on_write_error =3D BLOCKDEV_ON_ERROR_ENOSPC;
> @@ -899,10 +899,8 @@ DriveInfo *drive_new(QemuOpts *all_opts,
> BlockInterfaceType block_default_type)
>          copy_on_read =3D false;
>      }
>
> -    qdict_put(bs_opts, BDRV_OPT_READ_ONLY,
> -              qstring_from_str(read_only ? "on" : "off"));
> -    qdict_put(bs_opts, "copy-on-read",
> -              qstring_from_str(copy_on_read ? "on" :"off"));
> +    qdict_put_str(bs_opts, BDRV_OPT_READ_ONLY, read_only ? "on" : "off")=
;
> +    qdict_put_str(bs_opts, "copy-on-read", copy_on_read ? "on" : "off");
>
>      /* Controller type */
>      value =3D qemu_opt_get(legacy_opts, "if");
> @@ -1063,7 +1061,7 @@ DriveInfo *drive_new(QemuOpts *all_opts,
> BlockInterfaceType block_default_type)
>              error_report("werror is not supported by this bus type");
>              goto fail;
>          }
> -        qdict_put(bs_opts, "werror", qstring_from_str(werror));
> +        qdict_put_str(bs_opts, "werror", werror);
>      }
>
>      rerror =3D qemu_opt_get(legacy_opts, "rerror");
> @@ -1073,7 +1071,7 @@ DriveInfo *drive_new(QemuOpts *all_opts,
> BlockInterfaceType block_default_type)
>              error_report("rerror is not supported by this bus type");
>              goto fail;
>          }
> -        qdict_put(bs_opts, "rerror", qstring_from_str(rerror));
> +        qdict_put_str(bs_opts, "rerror", rerror);
>      }
>
>      /* Actual block device init: Functionality shared with blockdev-add =
*/
> @@ -1732,10 +1730,9 @@ static void
> external_snapshot_prepare(BlkActionState *common,
>
>          options =3D qdict_new();
>          if (s->has_snapshot_node_name) {
> -            qdict_put(options, "node-name",
> -                      qstring_from_str(snapshot_node_name));
> +            qdict_put_str(options, "node-name", snapshot_node_name);
>          }
> -        qdict_put(options, "driver", qstring_from_str(format));
> +        qdict_put_str(options, "driver", format);
>
>          flags |=3D BDRV_O_NO_BACKING;
>      }
> @@ -2544,11 +2541,10 @@ void qmp_blockdev_change_medium(bool has_device,
> const char *device,
>
>      options =3D qdict_new();
>      detect_zeroes =3D blk_get_detect_zeroes_from_root_state(blk);
> -    qdict_put(options, "detect-zeroes",
> -              qstring_from_str(detect_zeroes ? "on" : "off"));
> +    qdict_put_str(options, "detect-zeroes", detect_zeroes ? "on" : "off"=
);
>
>      if (has_format) {
> -        qdict_put(options, "driver", qstring_from_str(format));
> +        qdict_put_str(options, "driver", format);
>      }
>
>      medium_bs =3D bdrv_open(filename, NULL, options, bdrv_flags, errp);
> @@ -3204,7 +3200,7 @@ static BlockJob *do_drive_backup(DriveBackup
> *backup, BlockJobTxn *txn,
>
>      if (backup->format) {
>          options =3D qdict_new();
> -        qdict_put(options, "driver", qstring_from_str(backup->format));
> +        qdict_put_str(options, "driver", backup->format);
>      }
>
>      target_bs =3D bdrv_open(backup->target, NULL, options, flags, errp);
> @@ -3502,10 +3498,10 @@ void qmp_drive_mirror(DriveMirror *arg, Error
> **errp)
>
>      options =3D qdict_new();
>      if (arg->has_node_name) {
> -        qdict_put(options, "node-name", qstring_from_str(arg->node_name)=
);
> +        qdict_put_str(options, "node-name", arg->node_name);
>      }
>      if (format) {
> -        qdict_put(options, "driver", qstring_from_str(format));
> +        qdict_put_str(options, "driver", format);
>      }
>
>      /* Mirroring takes care of copy-on-write using the source's backing
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index 456a2d5..47b2ca1 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -1082,7 +1082,7 @@ static int blk_connect(struct XenDevice *xendev)
>
>          if (strcmp(blkdev->fileproto, "<unset>")) {
>              options =3D qdict_new();
> -            qdict_put(options, "driver",
> qstring_from_str(blkdev->fileproto));
> +            qdict_put_str(options, "driver", blkdev->fileproto);
>          }
>
>          /* setup via xenbus -> create new block driver instance */
> diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
> index 8e676e6..6659415 100644
> --- a/hw/usb/xen-usb.c
> +++ b/hw/usb/xen-usb.c
> @@ -746,16 +746,16 @@ static void usbback_portid_add(struct usbback_info
> *usbif, unsigned port,
>      portname++;
>
>      qdict =3D qdict_new();
> -    qdict_put(qdict, "driver", qstring_from_str("usb-host"));
> +    qdict_put_str(qdict, "driver", "usb-host");
>      tmp =3D g_strdup_printf("%s.0", usbif->xendev.qdev.id);
> -    qdict_put(qdict, "bus", qstring_from_str(tmp));
> +    qdict_put_str(qdict, "bus", tmp);
>      g_free(tmp);
>      tmp =3D g_strdup_printf("%s-%u", usbif->xendev.qdev.id, port);
> -    qdict_put(qdict, "id", qstring_from_str(tmp));
> +    qdict_put_str(qdict, "id", tmp);
>      g_free(tmp);
> -    qdict_put(qdict, "port", qint_from_int(port));
> -    qdict_put(qdict, "hostbus", qint_from_int(atoi(busid)));
> -    qdict_put(qdict, "hostport", qstring_from_str(portname));
> +    qdict_put_int(qdict, "port", port);
> +    qdict_put_int(qdict, "hostbus", atoi(busid));
> +    qdict_put_str(qdict, "hostport", portname);
>      opts =3D qemu_opts_from_qdict(qemu_find_opts("device"), qdict,
> &local_err);
>      if (local_err) {
>          goto err;
> diff --git a/monitor.c b/monitor.c
> index 0841d43..2a877ef 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -2618,7 +2618,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                      }
>                      goto fail;
>                  }
> -                qdict_put(qdict, key, qstring_from_str(buf));
> +                qdict_put_str(qdict, key, buf);
>              }
>              break;
>          case 'O':
> @@ -2720,9 +2720,9 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                          size =3D -1;
>                      }
>                  }
> -                qdict_put(qdict, "count", qint_from_int(count));
> -                qdict_put(qdict, "format", qint_from_int(format));
> -                qdict_put(qdict, "size", qint_from_int(size));
> +                qdict_put_int(qdict, "count", count);
> +                qdict_put_int(qdict, "format", format);
> +                qdict_put_int(qdict, "size", size);
>              }
>              break;
>          case 'i':
> @@ -2765,7 +2765,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                      }
>                      val <<=3D 20;
>                  }
> -                qdict_put(qdict, key, qint_from_int(val));
> +                qdict_put_int(qdict, key, val);
>              }
>              break;
>          case 'o':
> @@ -2787,7 +2787,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                      monitor_printf(mon, "invalid size\n");
>                      goto fail;
>                  }
> -                qdict_put(qdict, key, qint_from_int(val));
> +                qdict_put_int(qdict, key, val);
>                  p =3D end;
>              }
>              break;
> @@ -2843,7 +2843,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                      monitor_printf(mon, "Expected 'on' or 'off'\n");
>                      goto fail;
>                  }
> -                qdict_put(qdict, key, qbool_from_bool(val));
> +                qdict_put_bool(qdict, key, val);
>              }
>              break;
>          case '-':
> @@ -2874,7 +2874,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                      } else {
>                          /* has option */
>                          p++;
> -                        qdict_put(qdict, key, qbool_from_bool(true));
> +                        qdict_put_bool(qdict, key, true);
>                      }
>                  }
>              }
> @@ -2900,7 +2900,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                                     cmd->name);
>                      goto fail;
>                  }
> -                qdict_put(qdict, key, qstring_from_str(p));
> +                qdict_put_str(qdict, key, p);
>                  p +=3D len;
>              }
>              break;
> diff --git a/qapi/qmp-event.c b/qapi/qmp-event.c
> index 802ede4..ba3029c 100644
> --- a/qapi/qmp-event.c
> +++ b/qapi/qmp-event.c
> @@ -51,7 +51,7 @@ static void timestamp_put(QDict *qdict)
>  QDict *qmp_event_build_dict(const char *event_name)
>  {
>      QDict *dict =3D qdict_new();
> -    qdict_put(dict, "event", qstring_from_str(event_name));
> +    qdict_put_str(dict, "event", event_name);
>      timestamp_put(dict);
>      return dict;
>  }
> diff --git a/qemu-img.c b/qemu-img.c
> index 5df66fe..f9cedd0 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -298,7 +298,7 @@ static BlockBackend *img_open_file(const char
> *filename,
>
>      if (fmt) {
>          options =3D qdict_new();
> -        qdict_put(options, "driver", qstring_from_str(fmt));
> +        qdict_put_str(options, "driver", fmt);
>      }
>
>      blk =3D blk_new_open(filename, NULL, options, flags, &local_err);
> @@ -2953,7 +2953,7 @@ static int img_rebase(int argc, char **argv)
>
>          if (bs->backing_format[0] !=3D '\0') {
>              options =3D qdict_new();
> -            qdict_put(options, "driver",
> qstring_from_str(bs->backing_format));
> +            qdict_put_str(options, "driver", bs->backing_format);
>          }
>
>          bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name)=
);
> @@ -2970,7 +2970,7 @@ static int img_rebase(int argc, char **argv)
>          if (out_baseimg[0]) {
>              if (out_basefmt) {
>                  options =3D qdict_new();
> -                qdict_put(options, "driver",
> qstring_from_str(out_basefmt));
> +                qdict_put_str(options, "driver", out_basefmt);
>              } else {
>                  options =3D NULL;
>              }
> diff --git a/qemu-io.c b/qemu-io.c
> index 23a229f..97fe99d 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -599,7 +599,7 @@ int main(int argc, char **argv)
>          } else {
>              if (format) {
>                  opts =3D qdict_new();
> -                qdict_put(opts, "driver", qstring_from_str(format));
> +                qdict_put_str(opts, "driver", format);
>              }
>              openfile(argv[optind], flags, writethrough, opts);
>          }
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index c734f62..8f5ac8d 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -882,7 +882,7 @@ int main(int argc, char **argv)
>      } else {
>          if (fmt) {
>              options =3D qdict_new();
> -            qdict_put(options, "driver", qstring_from_str(fmt));
> +            qdict_put_str(options, "driver", fmt);
>          }
>          blk =3D blk_new_open(srcpath, NULL, options, flags, &local_err);
>      }
> diff --git a/qobject/qdict.c b/qobject/qdict.c
> index 197b0fb..51f0ef6 100644
> --- a/qobject/qdict.c
> +++ b/qobject/qdict.c
> @@ -487,7 +487,7 @@ void qdict_set_default_str(QDict *dst, const char
> *key, const char *val)
>          return;
>      }
>
> -    qdict_put(dst, key, qstring_from_str(val));
> +    qdict_put_str(dst, key, val);
>  }
>
>  static void qdict_flatten_qdict(QDict *qdict, QDict *target,
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 5b66d33..034e904 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -376,12 +376,12 @@ static void cpu_model_from_info(S390CPUModel *model=
,
> const CpuModelInfo *info,
>
>  static void qdict_add_disabled_feat(const char *name, void *opaque)
>  {
> -    qdict_put((QDict *) opaque, name, qbool_from_bool(false));
> +    qdict_put_bool((QDict *) opaque, name, false);
>  }
>
>  static void qdict_add_enabled_feat(const char *name, void *opaque)
>  {
> -    qdict_put((QDict *) opaque, name, qbool_from_bool(true));
> +    qdict_put_bool((QDict *) opaque, name, true);
>  }
>
>  /* convert S390CPUDef into a static CpuModelInfo */
> diff --git a/tests/check-qdict.c b/tests/check-qdict.c
> index 07b1c79..d00b411 100644
> --- a/tests/check-qdict.c
> +++ b/tests/check-qdict.c
> @@ -47,7 +47,7 @@ static void qdict_put_obj_test(void)
>      qdict =3D qdict_new();
>
>      // key "" will have tdb hash 12345
> -    qdict_put_obj(qdict, "", QOBJECT(qint_from_int(num)));
> +    qdict_put_int(qdict, "", num);
>
>      g_assert(qdict_size(qdict) =3D=3D 1);
>      ent =3D QLIST_FIRST(&qdict->table[12345 % QDICT_BUCKET_MAX]);
> @@ -66,8 +66,8 @@ static void qdict_destroy_simple_test(void)
>      QDict *qdict;
>
>      qdict =3D qdict_new();
> -    qdict_put_obj(qdict, "num", QOBJECT(qint_from_int(0)));
> -    qdict_put_obj(qdict, "str", QOBJECT(qstring_from_str("foo")));
> +    qdict_put_int(qdict, "num", 0);
> +    qdict_put_str(qdict, "str", "foo");
>
>      QDECREF(qdict);
>  }
> @@ -80,7 +80,7 @@ static void qdict_get_test(void)
>      const char *key =3D "test";
>      QDict *tests_dict =3D qdict_new();
>
> -    qdict_put(tests_dict, key, qint_from_int(value));
> +    qdict_put_int(tests_dict, key, value);
>
>      obj =3D qdict_get(tests_dict, key);
>      g_assert(obj !=3D NULL);
> @@ -98,7 +98,7 @@ static void qdict_get_int_test(void)
>      const char *key =3D "int";
>      QDict *tests_dict =3D qdict_new();
>
> -    qdict_put(tests_dict, key, qint_from_int(value));
> +    qdict_put_int(tests_dict, key, value);
>
>      ret =3D qdict_get_int(tests_dict, key);
>      g_assert(ret =3D=3D value);
> @@ -113,7 +113,7 @@ static void qdict_get_try_int_test(void)
>      const char *key =3D "int";
>      QDict *tests_dict =3D qdict_new();
>
> -    qdict_put(tests_dict, key, qint_from_int(value));
> +    qdict_put_int(tests_dict, key, value);
>
>      ret =3D qdict_get_try_int(tests_dict, key, 0);
>      g_assert(ret =3D=3D value);
> @@ -128,7 +128,7 @@ static void qdict_get_str_test(void)
>      const char *str =3D "string";
>      QDict *tests_dict =3D qdict_new();
>
> -    qdict_put(tests_dict, key, qstring_from_str(str));
> +    qdict_put_str(tests_dict, key, str);
>
>      p =3D qdict_get_str(tests_dict, key);
>      g_assert(p !=3D NULL);
> @@ -144,7 +144,7 @@ static void qdict_get_try_str_test(void)
>      const char *str =3D "string";
>      QDict *tests_dict =3D qdict_new();
>
> -    qdict_put(tests_dict, key, qstring_from_str(str));
> +    qdict_put_str(tests_dict, key, str);
>
>      p =3D qdict_get_try_str(tests_dict, key);
>      g_assert(p !=3D NULL);
> @@ -188,7 +188,7 @@ static void qdict_haskey_test(void)
>      const char *key =3D "test";
>      QDict *tests_dict =3D qdict_new();
>
> -    qdict_put(tests_dict, key, qint_from_int(0));
> +    qdict_put_int(tests_dict, key, 0);
>      g_assert(qdict_haskey(tests_dict, key) =3D=3D 1);
>
>      QDECREF(tests_dict);
> @@ -199,7 +199,7 @@ static void qdict_del_test(void)
>      const char *key =3D "key test";
>      QDict *tests_dict =3D qdict_new();
>
> -    qdict_put(tests_dict, key, qstring_from_str("foo"));
> +    qdict_put_str(tests_dict, key, "foo");
>      g_assert(qdict_size(tests_dict) =3D=3D 1);
>
>      qdict_del(tests_dict, key);
> @@ -226,9 +226,9 @@ static void qdict_iterapi_test(void)
>
>      g_assert(qdict_first(tests_dict) =3D=3D NULL);
>
> -    qdict_put(tests_dict, "key1", qint_from_int(1));
> -    qdict_put(tests_dict, "key2", qint_from_int(2));
> -    qdict_put(tests_dict, "key3", qint_from_int(3));
> +    qdict_put_int(tests_dict, "key1", 1);
> +    qdict_put_int(tests_dict, "key2", 2);
> +    qdict_put_int(tests_dict, "key3", 3);
>
>      count =3D 0;
>      for (ent =3D qdict_first(tests_dict); ent; ent =3D qdict_next(tests_=
dict,
> ent)){
> @@ -294,8 +294,8 @@ static void qdict_flatten_test(void)
>       * }
>       */
>
> -    qdict_put(dict1, "a", qint_from_int(0));
> -    qdict_put(dict1, "b", qint_from_int(1));
> +    qdict_put_int(dict1, "a", 0);
> +    qdict_put_int(dict1, "b", 1);
>
>      qlist_append_obj(list1, QOBJECT(qint_from_int(23)));
>      qlist_append_obj(list1, QOBJECT(qint_from_int(66)));
> @@ -303,11 +303,11 @@ static void qdict_flatten_test(void)
>      qlist_append_obj(list2, QOBJECT(qint_from_int(42)));
>      qlist_append_obj(list2, QOBJECT(list1));
>
> -    qdict_put(dict2, "c", qint_from_int(2));
> -    qdict_put(dict2, "d", qint_from_int(3));
> -    qdict_put_obj(dict3, "e", QOBJECT(list2));
> -    qdict_put_obj(dict3, "f", QOBJECT(dict2));
> -    qdict_put(dict3, "g", qint_from_int(4));
> +    qdict_put_int(dict2, "c", 2);
> +    qdict_put_int(dict2, "d", 3);
> +    qdict_put(dict3, "e", list2);
> +    qdict_put(dict3, "f", dict2);
> +    qdict_put_int(dict3, "g", 4);
>
>      qdict_flatten(dict3);
>
> @@ -369,12 +369,12 @@ static void qdict_array_split_test(void)
>       * This example is given in the comment of qdict_array_split().
>       */
>
> -    qdict_put(test_dict, "1.x", qint_from_int(0));
> -    qdict_put(test_dict, "4.y", qint_from_int(1));
> -    qdict_put(test_dict, "0.a", qint_from_int(42));
> -    qdict_put(test_dict, "o.o", qint_from_int(7));
> -    qdict_put(test_dict, "0.b", qint_from_int(23));
> -    qdict_put(test_dict, "2", qint_from_int(66));
> +    qdict_put_int(test_dict, "1.x", 0);
> +    qdict_put_int(test_dict, "4.y", 1);
> +    qdict_put_int(test_dict, "0.a", 42);
> +    qdict_put_int(test_dict, "o.o", 7);
> +    qdict_put_int(test_dict, "0.b", 23);
> +    qdict_put_int(test_dict, "2", 66);
>
>      qdict_array_split(test_dict, &test_list);
>
> @@ -441,9 +441,9 @@ static void qdict_array_split_test(void)
>
>      test_dict =3D qdict_new();
>
> -    qdict_put(test_dict, "0", qint_from_int(42));
> -    qdict_put(test_dict, "1", qint_from_int(23));
> -    qdict_put(test_dict, "1.x", qint_from_int(84));
> +    qdict_put_int(test_dict, "0", 42);
> +    qdict_put_int(test_dict, "1", 23);
> +    qdict_put_int(test_dict, "1.x", 84);
>
>      qdict_array_split(test_dict, &test_list);
>
> @@ -472,38 +472,38 @@ static void qdict_array_entries_test(void)
>
>      g_assert_cmpint(qdict_array_entries(dict, "foo."), =3D=3D, 0);
>
> -    qdict_put(dict, "bar", qint_from_int(0));
> -    qdict_put(dict, "baz.0", qint_from_int(0));
> +    qdict_put_int(dict, "bar", 0);
> +    qdict_put_int(dict, "baz.0", 0);
>      g_assert_cmpint(qdict_array_entries(dict, "foo."), =3D=3D, 0);
>
> -    qdict_put(dict, "foo.1", qint_from_int(0));
> +    qdict_put_int(dict, "foo.1", 0);
>      g_assert_cmpint(qdict_array_entries(dict, "foo."), =3D=3D, -EINVAL);
> -    qdict_put(dict, "foo.0", qint_from_int(0));
> +    qdict_put_int(dict, "foo.0", 0);
>      g_assert_cmpint(qdict_array_entries(dict, "foo."), =3D=3D, 2);
> -    qdict_put(dict, "foo.bar", qint_from_int(0));
> +    qdict_put_int(dict, "foo.bar", 0);
>      g_assert_cmpint(qdict_array_entries(dict, "foo."), =3D=3D, -EINVAL);
>      qdict_del(dict, "foo.bar");
>
> -    qdict_put(dict, "foo.2.a", qint_from_int(0));
> -    qdict_put(dict, "foo.2.b", qint_from_int(0));
> -    qdict_put(dict, "foo.2.c", qint_from_int(0));
> +    qdict_put_int(dict, "foo.2.a", 0);
> +    qdict_put_int(dict, "foo.2.b", 0);
> +    qdict_put_int(dict, "foo.2.c", 0);
>      g_assert_cmpint(qdict_array_entries(dict, "foo."), =3D=3D, 3);
>      g_assert_cmpint(qdict_array_entries(dict, ""), =3D=3D, -EINVAL);
>
>      QDECREF(dict);
>
>      dict =3D qdict_new();
> -    qdict_put(dict, "1", qint_from_int(0));
> +    qdict_put_int(dict, "1", 0);
>      g_assert_cmpint(qdict_array_entries(dict, ""), =3D=3D, -EINVAL);
> -    qdict_put(dict, "0", qint_from_int(0));
> +    qdict_put_int(dict, "0", 0);
>      g_assert_cmpint(qdict_array_entries(dict, ""), =3D=3D, 2);
> -    qdict_put(dict, "bar", qint_from_int(0));
> +    qdict_put_int(dict, "bar", 0);
>      g_assert_cmpint(qdict_array_entries(dict, ""), =3D=3D, -EINVAL);
>      qdict_del(dict, "bar");
>
> -    qdict_put(dict, "2.a", qint_from_int(0));
> -    qdict_put(dict, "2.b", qint_from_int(0));
> -    qdict_put(dict, "2.c", qint_from_int(0));
> +    qdict_put_int(dict, "2.a", 0);
> +    qdict_put_int(dict, "2.b", 0);
> +    qdict_put_int(dict, "2.c", 0);
>      g_assert_cmpint(qdict_array_entries(dict, ""), =3D=3D, 3);
>
>      QDECREF(dict);
> @@ -529,7 +529,7 @@ static void qdict_join_test(void)
>
>          /* First iteration: Test movement */
>          /* Second iteration: Test empty source and non-empty destination
> */
> -        qdict_put(dict2, "foo", qint_from_int(42));
> +        qdict_put_int(dict2, "foo", 42);
>
>          for (i =3D 0; i < 2; i++) {
>              qdict_join(dict1, dict2, overwrite);
> @@ -541,7 +541,7 @@ static void qdict_join_test(void)
>          }
>
>          /* Test non-empty source and destination without conflict */
> -        qdict_put(dict2, "bar", qint_from_int(23));
> +        qdict_put_int(dict2, "bar", 23);
>
>          qdict_join(dict1, dict2, overwrite);
>
> @@ -552,7 +552,7 @@ static void qdict_join_test(void)
>          g_assert(qdict_get_int(dict1, "bar") =3D=3D 23);
>
>          /* Test conflict */
> -        qdict_put(dict2, "foo", qint_from_int(84));
> +        qdict_put_int(dict2, "foo", 84);
>
>          qdict_join(dict1, dict2, overwrite);
>
> @@ -595,15 +595,15 @@ static void qdict_crumple_test_recursive(void)
>      QList *rules;
>
>      src =3D qdict_new();
> -    qdict_put(src, "vnc.listen.addr", qstring_from_str("127.0.0.1"));
> -    qdict_put(src, "vnc.listen.port", qstring_from_str("5901"));
> -    qdict_put(src, "vnc.acl.rules.0.match", qstring_from_str("fred"));
> -    qdict_put(src, "vnc.acl.rules.0.policy", qstring_from_str("allow"));
> -    qdict_put(src, "vnc.acl.rules.1.match", qstring_from_str("bob"));
> -    qdict_put(src, "vnc.acl.rules.1.policy", qstring_from_str("deny"));
> -    qdict_put(src, "vnc.acl.default", qstring_from_str("deny"));
> -    qdict_put(src, "vnc.acl..name", qstring_from_str("acl0"));
> -    qdict_put(src, "vnc.acl.rule..name", qstring_from_str("acl0"));
> +    qdict_put_str(src, "vnc.listen.addr", "127.0.0.1");
> +    qdict_put_str(src, "vnc.listen.port", "5901");
> +    qdict_put_str(src, "vnc.acl.rules.0.match", "fred");
> +    qdict_put_str(src, "vnc.acl.rules.0.policy", "allow");
> +    qdict_put_str(src, "vnc.acl.rules.1.match", "bob");
> +    qdict_put_str(src, "vnc.acl.rules.1.policy", "deny");
> +    qdict_put_str(src, "vnc.acl.default", "deny");
> +    qdict_put_str(src, "vnc.acl..name", "acl0");
> +    qdict_put_str(src, "vnc.acl.rule..name", "acl0");
>
>      res =3D qdict_crumple(src, &error_abort);
>
> @@ -676,8 +676,8 @@ static void qdict_crumple_test_bad_inputs(void)
>
>      src =3D qdict_new();
>      /* rule.0 can't be both a string and a dict */
> -    qdict_put(src, "rule.0", qstring_from_str("fred"));
> -    qdict_put(src, "rule.0.policy", qstring_from_str("allow"));
> +    qdict_put_str(src, "rule.0", "fred");
> +    qdict_put_str(src, "rule.0.policy", "allow");
>
>      g_assert(qdict_crumple(src, &error) =3D=3D NULL);
>      g_assert(error !=3D NULL);
> @@ -687,8 +687,8 @@ static void qdict_crumple_test_bad_inputs(void)
>
>      src =3D qdict_new();
>      /* rule can't be both a list and a dict */
> -    qdict_put(src, "rule.0", qstring_from_str("fred"));
> -    qdict_put(src, "rule.a", qstring_from_str("allow"));
> +    qdict_put_str(src, "rule.0", "fred");
> +    qdict_put_str(src, "rule.a", "allow");
>
>      g_assert(qdict_crumple(src, &error) =3D=3D NULL);
>      g_assert(error !=3D NULL);
> @@ -699,7 +699,7 @@ static void qdict_crumple_test_bad_inputs(void)
>      src =3D qdict_new();
>      /* The input should be flat, ie no dicts or lists */
>      qdict_put(src, "rule.a", qdict_new());
> -    qdict_put(src, "rule.b", qstring_from_str("allow"));
> +    qdict_put_str(src, "rule.b", "allow");
>
>      g_assert(qdict_crumple(src, &error) =3D=3D NULL);
>      g_assert(error !=3D NULL);
> @@ -709,8 +709,8 @@ static void qdict_crumple_test_bad_inputs(void)
>
>      src =3D qdict_new();
>      /* List indexes must not have gaps */
> -    qdict_put(src, "rule.0", qstring_from_str("deny"));
> -    qdict_put(src, "rule.3", qstring_from_str("allow"));
> +    qdict_put_str(src, "rule.0", "deny");
> +    qdict_put_str(src, "rule.3", "allow");
>
>      g_assert(qdict_crumple(src, &error) =3D=3D NULL);
>      g_assert(error !=3D NULL);
> @@ -720,8 +720,8 @@ static void qdict_crumple_test_bad_inputs(void)
>
>      src =3D qdict_new();
>      /* List indexes must be in %zu format */
> -    qdict_put(src, "rule.0", qstring_from_str("deny"));
> -    qdict_put(src, "rule.+1", qstring_from_str("allow"));
> +    qdict_put_str(src, "rule.0", "deny");
> +    qdict_put_str(src, "rule.+1", "allow");
>
>      g_assert(qdict_crumple(src, &error) =3D=3D NULL);
>      g_assert(error !=3D NULL);
> @@ -740,8 +740,8 @@ static void qdict_put_exists_test(void)
>      const char *key =3D "exists";
>      QDict *tests_dict =3D qdict_new();
>
> -    qdict_put(tests_dict, key, qint_from_int(1));
> -    qdict_put(tests_dict, key, qint_from_int(2));
> +    qdict_put_int(tests_dict, key, 1);
> +    qdict_put_int(tests_dict, key, 2);
>
>      value =3D qdict_get_int(tests_dict, key);
>      g_assert(value =3D=3D 2);
> diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
> index ff94481..660a9e8 100644
> --- a/tests/test-qmp-commands.c
> +++ b/tests/test-qmp-commands.c
> @@ -92,7 +92,7 @@ static void test_dispatch_cmd(void)
>      QDict *req =3D qdict_new();
>      QObject *resp;
>
> -    qdict_put_obj(req, "execute",
> QOBJECT(qstring_from_str("user_def_cmd")));
> +    qdict_put_str(req, "execute", "user_def_cmd");
>
>      resp =3D qmp_dispatch(QOBJECT(req));
>      assert(resp !=3D NULL);
> @@ -109,7 +109,7 @@ static void test_dispatch_cmd_failure(void)
>      QDict *args =3D qdict_new();
>      QObject *resp;
>
> -    qdict_put_obj(req, "execute",
> QOBJECT(qstring_from_str("user_def_cmd2")));
> +    qdict_put_str(req, "execute", "user_def_cmd2");
>
>      resp =3D qmp_dispatch(QOBJECT(req));
>      assert(resp !=3D NULL);
> @@ -120,10 +120,10 @@ static void test_dispatch_cmd_failure(void)
>
>      /* check that with extra arguments it throws an error */
>      req =3D qdict_new();
> -    qdict_put(args, "a", qint_from_int(66));
> +    qdict_put_int(args, "a", 66);
>      qdict_put(req, "arguments", args);
>
> -    qdict_put_obj(req, "execute",
> QOBJECT(qstring_from_str("user_def_cmd")));
> +    qdict_put_str(req, "execute", "user_def_cmd");
>
>      resp =3D qmp_dispatch(QOBJECT(req));
>      assert(resp !=3D NULL);
> @@ -162,14 +162,14 @@ static void test_dispatch_cmd_io(void)
>      QDict *ret_dict_dict2, *ret_dict_dict2_userdef;
>      QInt *ret3;
>
> -    qdict_put_obj(ud1a, "integer", QOBJECT(qint_from_int(42)));
> -    qdict_put_obj(ud1a, "string", QOBJECT(qstring_from_str("hello")));
> -    qdict_put_obj(ud1b, "integer", QOBJECT(qint_from_int(422)));
> -    qdict_put_obj(ud1b, "string", QOBJECT(qstring_from_str("hello2")));
> -    qdict_put_obj(args, "ud1a", QOBJECT(ud1a));
> -    qdict_put_obj(args, "ud1b", QOBJECT(ud1b));
> -    qdict_put_obj(req, "arguments", QOBJECT(args));
> -    qdict_put_obj(req, "execute",
> QOBJECT(qstring_from_str("user_def_cmd2")));
> +    qdict_put_int(ud1a, "integer", 42);
> +    qdict_put_str(ud1a, "string", "hello");
> +    qdict_put_int(ud1b, "integer", 422);
> +    qdict_put_str(ud1b, "string", "hello2");
> +    qdict_put(args, "ud1a", ud1a);
> +    qdict_put(args, "ud1b", ud1b);
> +    qdict_put(req, "arguments", args);
> +    qdict_put_str(req, "execute", "user_def_cmd2");
>
>      ret =3D qobject_to_qdict(test_qmp_dispatch(req));
>
> @@ -188,9 +188,9 @@ static void test_dispatch_cmd_io(void)
>      assert(!strcmp(qdict_get_str(ret_dict_dict2, "string"), "blah4"));
>      QDECREF(ret);
>
> -    qdict_put(args3, "a", qint_from_int(66));
> +    qdict_put_int(args3, "a", 66);
>      qdict_put(req, "arguments", args3);
> -    qdict_put(req, "execute", qstring_from_str("guest-get-time"));
> +    qdict_put_str(req, "execute", "guest-get-time");
>
>      ret3 =3D qobject_to_qint(test_qmp_dispatch(req));
>      assert(qint_get_int(ret3) =3D=3D 66);
> @@ -242,7 +242,7 @@ static void test_dealloc_partial(void)
>          Visitor *v;
>
>          ud2_dict =3D qdict_new();
> -        qdict_put_obj(ud2_dict, "string0",
> QOBJECT(qstring_from_str(text)));
> +        qdict_put_str(ud2_dict, "string0", text);
>
>          v =3D qobject_input_visitor_new(QOBJECT(ud2_dict), true);
>          visit_type_UserDefTwo(v, NULL, &ud2, &err);
> diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
> index 633dc87..cf58104 100644
> --- a/tests/test-qmp-event.c
> +++ b/tests/test-qmp-event.c
> @@ -159,7 +159,7 @@ static void test_event_a(TestEventData *data,
>  {
>      QDict *d;
>      d =3D data->expect;
> -    qdict_put(d, "event", qstring_from_str("EVENT_A"));
> +    qdict_put_str(d, "event", "EVENT_A");
>      qapi_event_send_event_a(&error_abort);
>  }
>
> @@ -168,7 +168,7 @@ static void test_event_b(TestEventData *data,
>  {
>      QDict *d;
>      d =3D data->expect;
> -    qdict_put(d, "event", qstring_from_str("EVENT_B"));
> +    qdict_put_str(d, "event", "EVENT_B");
>      qapi_event_send_event_b(&error_abort);
>  }
>
> @@ -183,16 +183,16 @@ static void test_event_c(TestEventData *data,
>      b.has_enum1 =3D false;
>
>      d_b =3D qdict_new();
> -    qdict_put(d_b, "integer", qint_from_int(2));
> -    qdict_put(d_b, "string", qstring_from_str("test1"));
> +    qdict_put_int(d_b, "integer", 2);
> +    qdict_put_str(d_b, "string", "test1");
>
>      d_data =3D qdict_new();
> -    qdict_put(d_data, "a", qint_from_int(1));
> +    qdict_put_int(d_data, "a", 1);
>      qdict_put(d_data, "b", d_b);
> -    qdict_put(d_data, "c", qstring_from_str("test2"));
> +    qdict_put_str(d_data, "c", "test2");
>
>      d =3D data->expect;
> -    qdict_put(d, "event", qstring_from_str("EVENT_C"));
> +    qdict_put_str(d, "event", "EVENT_C");
>      qdict_put(d, "data", d_data);
>
>      qapi_event_send_event_c(true, 1, true, &b, "test2", &error_abort);
> @@ -219,22 +219,22 @@ static void test_event_d(TestEventData *data,
>      a.enum2 =3D ENUM_ONE_VALUE2;
>
>      d_struct1 =3D qdict_new();
> -    qdict_put(d_struct1, "integer", qint_from_int(2));
> -    qdict_put(d_struct1, "string", qstring_from_str("test1"));
> -    qdict_put(d_struct1, "enum1", qstring_from_str("value1"));
> +    qdict_put_int(d_struct1, "integer", 2);
> +    qdict_put_str(d_struct1, "string", "test1");
> +    qdict_put_str(d_struct1, "enum1", "value1");
>
>      d_a =3D qdict_new();
>      qdict_put(d_a, "struct1", d_struct1);
> -    qdict_put(d_a, "string", qstring_from_str("test2"));
> -    qdict_put(d_a, "enum2", qstring_from_str("value2"));
> +    qdict_put_str(d_a, "string", "test2");
> +    qdict_put_str(d_a, "enum2", "value2");
>
>      d_data =3D qdict_new();
>      qdict_put(d_data, "a", d_a);
> -    qdict_put(d_data, "b", qstring_from_str("test3"));
> -    qdict_put(d_data, "enum3", qstring_from_str("value3"));
> +    qdict_put_str(d_data, "b", "test3");
> +    qdict_put_str(d_data, "enum3", "value3");
>
>      d =3D data->expect;
> -    qdict_put(d, "event", qstring_from_str("EVENT_D"));
> +    qdict_put_str(d, "event", "EVENT_D");
>      qdict_put(d, "data", d_data);
>
>      qapi_event_send_event_d(&a, "test3", false, NULL, true,
> ENUM_ONE_VALUE3,
> diff --git a/tests/test-qobject-output-visitor.c
> b/tests/test-qobject-output-visitor.c
> index 4e2d79c..22d148a 100644
> --- a/tests/test-qobject-output-visitor.c
> +++ b/tests/test-qobject-output-visitor.c
> @@ -356,9 +356,9 @@ static void test_visitor_out_any(TestOutputVisitorDat=
a
> *data,
>
>      visitor_reset(data);
>      qdict =3D qdict_new();
> -    qdict_put(qdict, "integer", qint_from_int(-42));
> -    qdict_put(qdict, "boolean", qbool_from_bool(true));
> -    qdict_put(qdict, "string", qstring_from_str("foo"));
> +    qdict_put_int(qdict, "integer", -42);
> +    qdict_put_bool(qdict, "boolean", true);
> +    qdict_put_str(qdict, "string", "foo");
>      qobj =3D QOBJECT(qdict);
>      visit_type_any(data->ov, NULL, &qobj, &error_abort);
>      qobject_decref(qobj);
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 3467dc2..b061fb0 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -1056,17 +1056,15 @@ void qemu_opts_absorb_qdict(QemuOpts *opts, QDict
> *qdict, Error **errp)
>  QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
>  {
>      QemuOpt *opt;
> -    QObject *val;
>
>      if (!qdict) {
>          qdict =3D qdict_new();
>      }
>      if (opts->id) {
> -        qdict_put(qdict, "id", qstring_from_str(opts->id));
> +        qdict_put_str(qdict, "id", opts->id);
>      }
>      QTAILQ_FOREACH(opt, &opts->head, next) {
> -        val =3D QOBJECT(qstring_from_str(opt->str));
> -        qdict_put_obj(qdict, opt->name, val);
> +        qdict_put_str(qdict, opt->name, opt->str);
>      }
>      return qdict;
>  }
> --
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
