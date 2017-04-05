Received: from eggs.gnu.org ([2001:4830:134:3::10]:33784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cvqy8-0005u3-DK
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cvqy5-0001q1-4y
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:51:52 -0400
Date: Wed, 5 Apr 2017 20:51:35 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170405195135.GM30620@redhat.com>
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170405194741.18956-8-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/13] block: Use simpler QDict/QList
 scalar insertion macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Weil <sw@weilnetz.de>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Alberto Garcia <berto@igalia.com>, Josh Durgin <jdurgin@redhat.com>, "open list:blkdebug" <qemu-block@nongnu.org>

On Wed, Apr 05, 2017 at 02:47:35PM -0500, Eric Blake wrote:
> We now have macros in place to make it less verbose to add a scalar
> to QDict and QList, so use them.
> 
> Patch created mechanically via:
>   spatch --sp-file scripts/coccinelle/qobject.cocci \
>     --macro-file scripts/cocci-macro-file.h --dir block --in-place
> then touched up manually to fix a couple of '?:' back to original spacing.

It seems a trivial change to me, ACK.

Rich.

> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/blkdebug.c   |  6 +++---
>  block/blkverify.c  |  6 +++---
>  block/curl.c       |  2 +-
>  block/file-posix.c |  8 ++++----
>  block/file-win32.c |  4 ++--
>  block/iscsi.c      |  2 +-
>  block/nbd.c        | 41 ++++++++++++++++++++---------------------
>  block/nfs.c        | 43 +++++++++++++++++--------------------------
>  block/null.c       |  2 +-
>  block/qcow2.c      |  4 ++--
>  block/quorum.c     |  8 ++++----
>  block/rbd.c        | 16 ++++++++--------
>  block/ssh.c        | 16 +++++++---------
>  block/vvfat.c      | 10 +++++-----
>  14 files changed, 78 insertions(+), 90 deletions(-)
> 
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index c5d4772..f69e136 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -301,7 +301,7 @@ static void blkdebug_parse_filename(const char *filename, QDict *options,
>      if (!strstart(filename, "blkdebug:", &filename)) {
>          /* There was no prefix; therefore, all options have to be already
>             present in the QDict (except for the filename) */
> -        qdict_put(options, "x-image", qstring_from_str(filename));
> +        qdict_put_str(options, "x-image", filename);
>          return;
>      }
> 
> @@ -320,7 +320,7 @@ static void blkdebug_parse_filename(const char *filename, QDict *options,
> 
>      /* TODO Allow multi-level nesting and set file.filename here */
>      filename = c + 1;
> -    qdict_put(options, "x-image", qstring_from_str(filename));
> +    qdict_put_str(options, "x-image", filename);
>  }
> 
>  static QemuOptsList runtime_opts = {
> @@ -695,7 +695,7 @@ static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
>      }
> 
>      opts = qdict_new();
> -    qdict_put(opts, "driver", qstring_from_str("blkdebug"));
> +    qdict_put_str(opts, "driver", "blkdebug");
> 
>      QINCREF(bs->file->bs->full_open_options);
>      qdict_put(opts, "image", bs->file->bs->full_open_options);
> diff --git a/block/blkverify.c b/block/blkverify.c
> index 79c8914..5c7d506 100644
> --- a/block/blkverify.c
> +++ b/block/blkverify.c
> @@ -67,7 +67,7 @@ static void blkverify_parse_filename(const char *filename, QDict *options,
>      if (!strstart(filename, "blkverify:", &filename)) {
>          /* There was no prefix; therefore, all options have to be already
>             present in the QDict (except for the filename) */
> -        qdict_put(options, "x-image", qstring_from_str(filename));
> +        qdict_put_str(options, "x-image", filename);
>          return;
>      }
> 
> @@ -84,7 +84,7 @@ static void blkverify_parse_filename(const char *filename, QDict *options,
> 
>      /* TODO Allow multi-level nesting and set file.filename here */
>      filename = c + 1;
> -    qdict_put(options, "x-image", qstring_from_str(filename));
> +    qdict_put_str(options, "x-image", filename);
>  }
> 
>  static QemuOptsList runtime_opts = {
> @@ -291,7 +291,7 @@ static void blkverify_refresh_filename(BlockDriverState *bs, QDict *options)
>          && s->test_file->bs->full_open_options)
>      {
>          QDict *opts = qdict_new();
> -        qdict_put(opts, "driver", qstring_from_str("blkverify"));
> +        qdict_put_str(opts, "driver", "blkverify");
> 
>          QINCREF(bs->file->bs->full_open_options);
>          qdict_put(opts, "raw", bs->file->bs->full_open_options);
> diff --git a/block/curl.c b/block/curl.c
> index 2708d57..aa6e8cc 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -548,7 +548,7 @@ static void curl_clean_state(CURLState *s)
>  static void curl_parse_filename(const char *filename, QDict *options,
>                                  Error **errp)
>  {
> -    qdict_put(options, CURL_BLOCK_OPT_URL, qstring_from_str(filename));
> +    qdict_put_str(options, CURL_BLOCK_OPT_URL, filename);
>  }
> 
>  static void curl_detach_aio_context(BlockDriverState *bs)
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 5370ba0..9431ad1 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -377,7 +377,7 @@ static void raw_parse_filename(const char *filename, QDict *options,
>       * function call can be ignored. */
>      strstart(filename, "file:", &filename);
> 
> -    qdict_put(options, "filename", qstring_from_str(filename));
> +    qdict_put_str(options, "filename", filename);
>  }
> 
>  static QemuOptsList raw_runtime_opts = {
> @@ -2150,7 +2150,7 @@ static void hdev_parse_filename(const char *filename, QDict *options,
>      /* The prefix is optional, just as for "file". */
>      strstart(filename, "host_device:", &filename);
> 
> -    qdict_put(options, "filename", qstring_from_str(filename));
> +    qdict_put_str(options, "filename", filename);
>  }
> 
>  static bool hdev_is_sg(BlockDriverState *bs)
> @@ -2239,7 +2239,7 @@ static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
>              goto hdev_open_Mac_error;
>          }
> 
> -        qdict_put(options, "filename", qstring_from_str(bsd_path));
> +        qdict_put_str(options, "filename", bsd_path);
> 
>  hdev_open_Mac_error:
>          g_free(mediaType);
> @@ -2449,7 +2449,7 @@ static void cdrom_parse_filename(const char *filename, QDict *options,
>      /* The prefix is optional, just as for "file". */
>      strstart(filename, "host_cdrom:", &filename);
> 
> -    qdict_put(options, "filename", qstring_from_str(filename));
> +    qdict_put_str(options, "filename", filename);
>  }
>  #endif
> 
> diff --git a/block/file-win32.c b/block/file-win32.c
> index 57c4a78..0d455d1 100644
> --- a/block/file-win32.c
> +++ b/block/file-win32.c
> @@ -282,7 +282,7 @@ static void raw_parse_filename(const char *filename, QDict *options,
>       * function call can be ignored. */
>      strstart(filename, "file:", &filename);
> 
> -    qdict_put(options, "filename", qstring_from_str(filename));
> +    qdict_put_str(options, "filename", filename);
>  }
> 
>  static QemuOptsList raw_runtime_opts = {
> @@ -669,7 +669,7 @@ static void hdev_parse_filename(const char *filename, QDict *options,
>      /* The prefix is optional, just as for "file". */
>      strstart(filename, "host_device:", &filename);
> 
> -    qdict_put(options, "filename", qstring_from_str(filename));
> +    qdict_put_str(options, "filename", filename);
>  }
> 
>  static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 716e74a..1534ab6 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -2102,7 +2102,7 @@ static int iscsi_create(const char *filename, QemuOpts *opts, Error **errp)
>      iscsilun = bs->opaque;
> 
>      bs_options = qdict_new();
> -    qdict_put(bs_options, "filename", qstring_from_str(filename));
> +    qdict_put_str(bs_options, "filename", filename);
>      ret = iscsi_open(bs, bs_options, 0, NULL);
>      QDECREF(bs_options);
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 814ab26d..b3545f5 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -79,7 +79,7 @@ static int nbd_parse_uri(const char *filename, QDict *options)
>      p = uri->path ? uri->path : "/";
>      p += strspn(p, "/");
>      if (p[0]) {
> -        qdict_put(options, "export", qstring_from_str(p));
> +        qdict_put_str(options, "export", p);
>      }
> 
>      qp = query_params_parse(uri->query);
> @@ -94,9 +94,8 @@ static int nbd_parse_uri(const char *filename, QDict *options)
>              ret = -EINVAL;
>              goto out;
>          }
> -        qdict_put(options, "server.type", qstring_from_str("unix"));
> -        qdict_put(options, "server.path",
> -                  qstring_from_str(qp->p[0].value));
> +        qdict_put_str(options, "server.type", "unix");
> +        qdict_put_str(options, "server.path", qp->p[0].value);
>      } else {
>          QString *host;
>          char *port_str;
> @@ -115,11 +114,11 @@ static int nbd_parse_uri(const char *filename, QDict *options)
>              host = qstring_from_str(uri->server);
>          }
> 
> -        qdict_put(options, "server.type", qstring_from_str("inet"));
> +        qdict_put_str(options, "server.type", "inet");
>          qdict_put(options, "server.host", host);
> 
>          port_str = g_strdup_printf("%d", uri->port ?: NBD_DEFAULT_PORT);
> -        qdict_put(options, "server.port", qstring_from_str(port_str));
> +        qdict_put_str(options, "server.port", port_str);
>          g_free(port_str);
>      }
> 
> @@ -181,7 +180,7 @@ static void nbd_parse_filename(const char *filename, QDict *options,
>          export_name[0] = 0; /* truncate 'file' */
>          export_name += strlen(EN_OPTSTR);
> 
> -        qdict_put(options, "export", qstring_from_str(export_name));
> +        qdict_put_str(options, "export", export_name);
>      }
> 
>      /* extract the host_spec - fail if it's not nbd:... */
> @@ -196,8 +195,8 @@ static void nbd_parse_filename(const char *filename, QDict *options,
> 
>      /* are we a UNIX or TCP socket? */
>      if (strstart(host_spec, "unix:", &unixpath)) {
> -        qdict_put(options, "server.type", qstring_from_str("unix"));
> -        qdict_put(options, "server.path", qstring_from_str(unixpath));
> +        qdict_put_str(options, "server.type", "unix");
> +        qdict_put_str(options, "server.path", unixpath);
>      } else {
>          InetSocketAddress *addr = NULL;
> 
> @@ -206,9 +205,9 @@ static void nbd_parse_filename(const char *filename, QDict *options,
>              goto out;
>          }
> 
> -        qdict_put(options, "server.type", qstring_from_str("inet"));
> -        qdict_put(options, "server.host", qstring_from_str(addr->host));
> -        qdict_put(options, "server.port", qstring_from_str(addr->port));
> +        qdict_put_str(options, "server.type", "inet");
> +        qdict_put_str(options, "server.host", addr->host);
> +        qdict_put_str(options, "server.port", addr->port);
>          qapi_free_InetSocketAddress(addr);
>      }
> 
> @@ -247,13 +246,13 @@ static bool nbd_process_legacy_socket_options(QDict *output_options,
>              return false;
>          }
> 
> -        qdict_put(output_options, "server.type", qstring_from_str("unix"));
> -        qdict_put(output_options, "server.path", qstring_from_str(path));
> +        qdict_put_str(output_options, "server.type", "unix");
> +        qdict_put_str(output_options, "server.path", path);
>      } else if (host) {
> -        qdict_put(output_options, "server.type", qstring_from_str("inet"));
> -        qdict_put(output_options, "server.host", qstring_from_str(host));
> -        qdict_put(output_options, "server.port",
> -                  qstring_from_str(port ?: stringify(NBD_DEFAULT_PORT)));
> +        qdict_put_str(output_options, "server.type", "inet");
> +        qdict_put_str(output_options, "server.host", host);
> +        qdict_put_str(output_options, "server.port",
> +                      port ?: stringify(NBD_DEFAULT_PORT));
>      }
> 
>      return true;
> @@ -528,7 +527,7 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
>          path = s->saddr->u.q_unix.path;
>      } /* else can't represent as pseudo-filename */
> 
> -    qdict_put(opts, "driver", qstring_from_str("nbd"));
> +    qdict_put_str(opts, "driver", "nbd");
> 
>      if (path && s->export) {
>          snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> @@ -551,10 +550,10 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
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
> index 0816678..bfeebc1 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -104,9 +104,9 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
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
>      for (i = 0; i < qp->n; i++) {
>          unsigned long long val;
> @@ -121,23 +121,17 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
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
> @@ -811,7 +805,7 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
>      QObject *server_qdict;
>      Visitor *ov;
> 
> -    qdict_put(opts, "driver", qstring_from_str("nfs"));
> +    qdict_put_str(opts, "driver", "nfs");
> 
>      if (client->uid && !client->gid) {
>          snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> @@ -834,28 +828,25 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
>      visit_type_NFSServer(ov, NULL, &client->server, &error_abort);
>      visit_complete(ov, &server_qdict);
>      qdict_put_obj(opts, "server", server_qdict);
> -    qdict_put(opts, "path", qstring_from_str(client->path));
> +    qdict_put_str(opts, "path", client->path);
> 
>      if (client->uid) {
> -        qdict_put(opts, "user", qint_from_int(client->uid));
> +        qdict_put_int(opts, "user", client->uid);
>      }
>      if (client->gid) {
> -        qdict_put(opts, "group", qint_from_int(client->gid));
> +        qdict_put_int(opts, "group", client->gid);
>      }
>      if (client->tcp_syncnt) {
> -        qdict_put(opts, "tcp-syn-cnt",
> -                  qint_from_int(client->tcp_syncnt));
> +        qdict_put_int(opts, "tcp-syn-cnt", client->tcp_syncnt);
>      }
>      if (client->readahead) {
> -        qdict_put(opts, "readahead-size",
> -                  qint_from_int(client->readahead));
> +        qdict_put_int(opts, "readahead-size", client->readahead);
>      }
>      if (client->pagecache) {
> -        qdict_put(opts, "page-cache-size",
> -                  qint_from_int(client->pagecache));
> +        qdict_put_int(opts, "page-cache-size", client->pagecache);
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
> @@ -232,7 +232,7 @@ static void null_refresh_filename(BlockDriverState *bs, QDict *opts)
>                   bs->drv->format_name);
>      }
> 
> -    qdict_put(opts, "driver", qstring_from_str(bs->drv->format_name));
> +    qdict_put_str(opts, "driver", bs->drv->format_name);
>      bs->full_open_options = opts;
>  }
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6a92d2e..49c737f 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2265,7 +2265,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
>       * table)
>       */
>      options = qdict_new();
> -    qdict_put(options, "driver", qstring_from_str("qcow2"));
> +    qdict_put_str(options, "driver", "qcow2");
>      blk = blk_new_open(filename, NULL, options,
>                         BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_NO_FLUSH,
>                         &local_err);
> @@ -2327,7 +2327,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
> 
>      /* Reopen the image without BDRV_O_NO_FLUSH to flush it before returning */
>      options = qdict_new();
> -    qdict_put(options, "driver", qstring_from_str("qcow2"));
> +    qdict_put_str(options, "driver", "qcow2");
>      blk = blk_new_open(filename, NULL, options,
>                         BDRV_O_RDWR | BDRV_O_NO_BACKING, &local_err);
>      if (blk == NULL) {
> diff --git a/block/quorum.c b/block/quorum.c
> index f7949e2..1b2a8c3 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -1100,10 +1100,10 @@ static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
>      }
> 
>      opts = qdict_new();
> -    qdict_put(opts, "driver", qstring_from_str("quorum"));
> -    qdict_put(opts, QUORUM_OPT_VOTE_THRESHOLD, qint_from_int(s->threshold));
> -    qdict_put(opts, QUORUM_OPT_BLKVERIFY, qbool_from_bool(s->is_blkverify));
> -    qdict_put(opts, QUORUM_OPT_REWRITE, qbool_from_bool(s->rewrite_corrupted));
> +    qdict_put_str(opts, "driver", "quorum");
> +    qdict_put_int(opts, QUORUM_OPT_VOTE_THRESHOLD, s->threshold);
> +    qdict_put_bool(opts, QUORUM_OPT_BLKVERIFY, s->is_blkverify);
> +    qdict_put_bool(opts, QUORUM_OPT_REWRITE, s->rewrite_corrupted);
>      qdict_put(opts, "children", children);
> 
>      bs->full_open_options = opts;
> diff --git a/block/rbd.c b/block/rbd.c
> index 1ceeeb5..2354ffc 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -154,20 +154,20 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
>          goto done;
>      }
>      qemu_rbd_unescape(found_str);
> -    qdict_put(options, "pool", qstring_from_str(found_str));
> +    qdict_put_str(options, "pool", found_str);
> 
>      if (strchr(p, '@')) {
>          found_str = qemu_rbd_next_tok(p, '@', &p);
>          qemu_rbd_unescape(found_str);
> -        qdict_put(options, "image", qstring_from_str(found_str));
> +        qdict_put_str(options, "image", found_str);
> 
>          found_str = qemu_rbd_next_tok(p, ':', &p);
>          qemu_rbd_unescape(found_str);
> -        qdict_put(options, "snapshot", qstring_from_str(found_str));
> +        qdict_put_str(options, "snapshot", found_str);
>      } else {
>          found_str = qemu_rbd_next_tok(p, ':', &p);
>          qemu_rbd_unescape(found_str);
> -        qdict_put(options, "image", qstring_from_str(found_str));
> +        qdict_put_str(options, "image", found_str);
>      }
>      if (!p) {
>          goto done;
> @@ -189,9 +189,9 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
>          qemu_rbd_unescape(value);
> 
>          if (!strcmp(name, "conf")) {
> -            qdict_put(options, "conf", qstring_from_str(value));
> +            qdict_put_str(options, "conf", value);
>          } else if (!strcmp(name, "id")) {
> -            qdict_put(options, "user" , qstring_from_str(value));
> +            qdict_put_str(options, "user", value);
>          } else {
>              /*
>               * We pass these internally to qemu_rbd_set_keypairs(), so
> @@ -204,8 +204,8 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
>              if (!keypairs) {
>                  keypairs = qlist_new();
>              }
> -            qlist_append(keypairs, qstring_from_str(name));
> -            qlist_append(keypairs, qstring_from_str(value));
> +            qlist_append_str(keypairs, name);
> +            qlist_append_str(keypairs, value);
>          }
>      }
> 
> diff --git a/block/ssh.c b/block/ssh.c
> index 471ba8a..34a2f79 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -227,24 +227,23 @@ static int parse_uri(const char *filename, QDict *options, Error **errp)
>      }
> 
>      if(uri->user && strcmp(uri->user, "") != 0) {
> -        qdict_put(options, "user", qstring_from_str(uri->user));
> +        qdict_put_str(options, "user", uri->user);
>      }
> 
> -    qdict_put(options, "server.host", qstring_from_str(uri->server));
> +    qdict_put_str(options, "server.host", uri->server);
> 
>      port_str = g_strdup_printf("%d", uri->port ?: 22);
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
>      for (i = 0; i < qp->n; ++i) {
>          if (strcmp(qp->p[i].name, "host_key_check") == 0) {
> -            qdict_put(options, "host_key_check",
> -                      qstring_from_str(qp->p[i].value));
> +            qdict_put_str(options, "host_key_check", qp->p[i].value);
>          }
>      }
> 
> @@ -574,9 +573,8 @@ static bool ssh_process_legacy_socket_options(QDict *output_opts,
>      }
> 
>      if (host) {
> -        qdict_put(output_opts, "server.host", qstring_from_str(host));
> -        qdict_put(output_opts, "server.port",
> -                  qstring_from_str(port ?: stringify(22)));
> +        qdict_put_str(output_opts, "server.host", host);
> +        qdict_put_str(output_opts, "server.port", port ?: stringify(22));
>      }
> 
>      return true;
> diff --git a/block/vvfat.c b/block/vvfat.c
> index af5153d..8b4e4eb 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1057,10 +1057,10 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
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
> @@ -3040,7 +3040,7 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
>      }
> 
>      options = qdict_new();
> -    qdict_put(options, "write-target.driver", qstring_from_str("qcow"));
> +    qdict_put_str(options, "write-target.driver", "qcow");
>      s->qcow = bdrv_open_child(s->qcow_filename, options, "write-target", bs,
>                                &child_vvfat_qcow, false, errp);
>      QDECREF(options);
> -- 
> 2.9.3

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
