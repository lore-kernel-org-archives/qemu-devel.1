Received: from eggs.gnu.org ([2001:4830:134:3::10]:34129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gXEJB-0002Gx-UI
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 18:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1gXEJ4-0005tK-SI
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 18:52:52 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1gXEJ0-0005lD-Mu
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 18:52:44 -0500
Received: by mail-ua1-f68.google.com with SMTP id d21so73103uap.9
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 15:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20181212220410.569069-1-eblake@redhat.com>
In-Reply-To: <20181212220410.569069-1-eblake@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 13 Dec 2018 01:52:29 +0200
Message-ID: <CAMRbyyuZ81fyHYTQSHPXhjYoLFz6nzsxc30PNJdWRkqm=14RRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC] qemu-io: Prefer stderr
 for error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, Dec 13, 2018 at 12:13 AM Eric Blake <eblake@redhat.com> wrote:
>
> When a qemu-io command fails, it's best if the failure message
> goes to stderr rather than stdout.

This makes sense, but it will break users like this:

https://github.com/oVirt/vdsm/blob/a2836b1d58ffaa0f48cc9c814b6002161a81f044/tests/storage/qemuio.py#L45

We need a way to detect qemu-io verification failures, maybe a special
exit code?

0 - verification succeeded
1 - verification failed
2 - other error (e.g no such file)

Or, if qemu-io had a way to read data and write it to stdout, we could
compare the data and avoid the need for special exit code.

Nir

>
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> RFC because at least iotest 60 (found by -qcow2 -g quick) breaks due
> to reordering of output lines, and I'd rather know if we like this
> idea before bothering to revisit all affected iotests (including
> discovering if other slower ones have similar problems).
>
>  qemu-io-cmds.c | 120 ++++++++++++++++++++++++++-----------------------
>  qemu-io.c      |   3 +-
>  2 files changed, 67 insertions(+), 56 deletions(-)
>
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 5363482213b..e4f3925b5c9 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -184,14 +184,14 @@ static void print_cvtnum_err(int64_t rc, const char *arg)
>  {
>      switch (rc) {
>      case -EINVAL:
> -        printf("Parsing error: non-numeric argument,"
> -               " or extraneous/unrecognized suffix -- %s\n", arg);
> +        fprintf(stderr, "Parsing error: non-numeric argument,"
> +                " or extraneous/unrecognized suffix -- %s\n", arg);
>          break;
>      case -ERANGE:
> -        printf("Parsing error: argument too large -- %s\n", arg);
> +        fprintf(stderr, "Parsing error: argument too large -- %s\n", arg);
>          break;
>      default:
> -        printf("Parsing error: %s\n", arg);
> +        fprintf(stderr, "Parsing error: %s\n", arg);
>      }
>  }
>
> @@ -312,7 +312,7 @@ static int parse_pattern(const char *arg)
>
>      pattern = strtol(arg, &endptr, 0);
>      if (pattern < 0 || pattern > UCHAR_MAX || *endptr != '\0') {
> -        printf("%s is not a valid pattern byte\n", arg);
> +        fprintf(stderr, "%s is not a valid pattern byte\n", arg);
>          return -1;
>      }
>
> @@ -421,14 +421,16 @@ create_iovec(BlockBackend *blk, QEMUIOVector *qiov, char **argv, int nr_iov,
>          }
>
>          if (len > BDRV_REQUEST_MAX_BYTES) {
> -            printf("Argument '%s' exceeds maximum size %" PRIu64 "\n", arg,
> -                   (uint64_t)BDRV_REQUEST_MAX_BYTES);
> +            fprintf(stderr,
> +                    "Argument '%s' exceeds maximum size %" PRIu64 "\n", arg,
> +                    (uint64_t)BDRV_REQUEST_MAX_BYTES);
>              goto fail;
>          }
>
>          if (count > BDRV_REQUEST_MAX_BYTES - len) {
> -            printf("The total number of bytes exceed the maximum size %" PRIu64
> -                   "\n", (uint64_t)BDRV_REQUEST_MAX_BYTES);
> +            fprintf(stderr,
> +                    "The total number of bytes exceed the maximum size %" PRIu64
> +                    "\n", (uint64_t)BDRV_REQUEST_MAX_BYTES);
>              goto fail;
>          }
>
> @@ -723,8 +725,8 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>          print_cvtnum_err(count, argv[optind]);
>          return count;
>      } else if (count > BDRV_REQUEST_MAX_BYTES) {
> -        printf("length cannot exceed %" PRIu64 ", given %s\n",
> -               (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
> +        fprintf(stderr, "length cannot exceed %" PRIu64 ", given %s\n",
> +                (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
>          return -EINVAL;
>      }
>
> @@ -738,19 +740,22 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>      }
>
>      if ((pattern_count < 0) || (pattern_count + pattern_offset > count))  {
> -        printf("pattern verification range exceeds end of read data\n");
> +        fprintf(stderr,
> +                "pattern verification range exceeds end of read data\n");
>          return -EINVAL;
>      }
>
>      if (bflag) {
>          if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
> -            printf("%" PRId64 " is not a sector-aligned value for 'offset'\n",
> -                   offset);
> +            fprintf(stderr,
> +                    "%" PRId64 " is not a sector-aligned value for 'offset'\n",
> +                    offset);
>              return -EINVAL;
>          }
>          if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
> -            printf("%"PRId64" is not a sector-aligned value for 'count'\n",
> -                   count);
> +            fprintf(stderr,
> +                    "%"PRId64" is not a sector-aligned value for 'count'\n",
> +                    count);
>              return -EINVAL;
>          }
>      }
> @@ -766,7 +771,7 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>      gettimeofday(&t2, NULL);
>
>      if (ret < 0) {
> -        printf("read failed: %s\n", strerror(-ret));
> +        fprintf(stderr, "read failed: %s\n", strerror(-ret));
>          goto out;
>      }
>      cnt = ret;
> @@ -777,9 +782,9 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
>          void *cmp_buf = g_malloc(pattern_count);
>          memset(cmp_buf, pattern, pattern_count);
>          if (memcmp(buf + pattern_offset, cmp_buf, pattern_count)) {
> -            printf("Pattern verification failed at offset %"
> -                   PRId64 ", %"PRId64" bytes\n",
> -                   offset + pattern_offset, pattern_count);
> +            fprintf(stderr, "Pattern verification failed at offset %"
> +                    PRId64 ", %"PRId64" bytes\n",
> +                    offset + pattern_offset, pattern_count);
>              ret = -EINVAL;
>          }
>          g_free(cmp_buf);
> @@ -895,7 +900,7 @@ static int readv_f(BlockBackend *blk, int argc, char **argv)
>      gettimeofday(&t2, NULL);
>
>      if (ret < 0) {
> -        printf("readv failed: %s\n", strerror(-ret));
> +        fprintf(stderr, "readv failed: %s\n", strerror(-ret));
>          goto out;
>      }
>      cnt = ret;
> @@ -906,8 +911,8 @@ static int readv_f(BlockBackend *blk, int argc, char **argv)
>          void *cmp_buf = g_malloc(qiov.size);
>          memset(cmp_buf, pattern, qiov.size);
>          if (memcmp(buf, cmp_buf, qiov.size)) {
> -            printf("Pattern verification failed at offset %"
> -                   PRId64 ", %zu bytes\n", offset, qiov.size);
> +            fprintf(stderr, "Pattern verification failed at offset %"
> +                    PRId64 ", %zu bytes\n", offset, qiov.size);
>              ret = -EINVAL;
>          }
>          g_free(cmp_buf);
> @@ -1027,22 +1032,23 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
>      }
>
>      if (bflag && zflag) {
> -        printf("-b and -z cannot be specified at the same time\n");
> +        fprintf(stderr, "-b and -z cannot be specified at the same time\n");
>          return -EINVAL;
>      }
>
>      if ((flags & BDRV_REQ_FUA) && (bflag || cflag)) {
> -        printf("-f and -b or -c cannot be specified at the same time\n");
> +        fprintf(stderr,
> +                "-f and -b or -c cannot be specified at the same time\n");
>          return -EINVAL;
>      }
>
>      if ((flags & BDRV_REQ_MAY_UNMAP) && !zflag) {
> -        printf("-u requires -z to be specified\n");
> +        fprintf(stderr, "-u requires -z to be specified\n");
>          return -EINVAL;
>      }
>
>      if (zflag && Pflag) {
> -        printf("-z and -P cannot be specified at the same time\n");
> +        fprintf(stderr, "-z and -P cannot be specified at the same time\n");
>          return -EINVAL;
>      }
>
> @@ -1058,21 +1064,23 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
>          print_cvtnum_err(count, argv[optind]);
>          return count;
>      } else if (count > BDRV_REQUEST_MAX_BYTES) {
> -        printf("length cannot exceed %" PRIu64 ", given %s\n",
> -               (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
> +        fprintf(stderr, "length cannot exceed %" PRIu64 ", given %s\n",
> +                (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
>          return -EINVAL;
>      }
>
>      if (bflag || cflag) {
>          if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
> -            printf("%" PRId64 " is not a sector-aligned value for 'offset'\n",
> -                   offset);
> +            fprintf(stderr,
> +                    "%" PRId64 " is not a sector-aligned value for 'offset'\n",
> +                    offset);
>              return -EINVAL;
>          }
>
>          if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
> -            printf("%"PRId64" is not a sector-aligned value for 'count'\n",
> -                   count);
> +            fprintf(stderr,
> +                    "%"PRId64" is not a sector-aligned value for 'count'\n",
> +                    count);
>              return -EINVAL;
>          }
>      }
> @@ -1094,7 +1102,7 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
>      gettimeofday(&t2, NULL);
>
>      if (ret < 0) {
> -        printf("write failed: %s\n", strerror(-ret));
> +        fprintf(stderr, "write failed: %s\n", strerror(-ret));
>          goto out;
>      }
>      cnt = ret;
> @@ -1208,7 +1216,7 @@ static int writev_f(BlockBackend *blk, int argc, char **argv)
>      gettimeofday(&t2, NULL);
>
>      if (ret < 0) {
> -        printf("writev failed: %s\n", strerror(-ret));
> +        fprintf(stderr, "writev failed: %s\n", strerror(-ret));
>          goto out;
>      }
>      cnt = ret;
> @@ -1252,7 +1260,7 @@ static void aio_write_done(void *opaque, int ret)
>
>
>      if (ret < 0) {
> -        printf("aio_write failed: %s\n", strerror(-ret));
> +        fprintf(stderr, "aio_write failed: %s\n", strerror(-ret));
>          block_acct_failed(blk_get_stats(ctx->blk), &ctx->acct);
>          goto out;
>      }
> @@ -1283,7 +1291,7 @@ static void aio_read_done(void *opaque, int ret)
>      gettimeofday(&t2, NULL);
>
>      if (ret < 0) {
> -        printf("readv failed: %s\n", strerror(-ret));
> +        fprintf(stderr, "readv failed: %s\n", strerror(-ret));
>          block_acct_failed(blk_get_stats(ctx->blk), &ctx->acct);
>          goto out;
>      }
> @@ -1293,8 +1301,8 @@ static void aio_read_done(void *opaque, int ret)
>
>          memset(cmp_buf, ctx->pattern, ctx->qiov.size);
>          if (memcmp(ctx->buf, cmp_buf, ctx->qiov.size)) {
> -            printf("Pattern verification failed at offset %"
> -                   PRId64 ", %zu bytes\n", ctx->offset, ctx->qiov.size);
> +            fprintf(stderr, "Pattern verification failed at offset %"
> +                    PRId64 ", %zu bytes\n", ctx->offset, ctx->qiov.size);
>          }
>          g_free(cmp_buf);
>      }
> @@ -1513,19 +1521,19 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv)
>      }
>
>      if (ctx->zflag && optind != argc - 2) {
> -        printf("-z supports only a single length parameter\n");
> +        fprintf(stderr, "-z supports only a single length parameter\n");
>          g_free(ctx);
>          return -EINVAL;
>      }
>
>      if ((flags & BDRV_REQ_MAY_UNMAP) && !ctx->zflag) {
> -        printf("-u requires -z to be specified\n");
> +        fprintf(stderr, "-u requires -z to be specified\n");
>          g_free(ctx);
>          return -EINVAL;
>      }
>
>      if (ctx->zflag && ctx->Pflag) {
> -        printf("-z and -P cannot be specified at the same time\n");
> +        fprintf(stderr, "-z and -P cannot be specified at the same time\n");
>          g_free(ctx);
>          return -EINVAL;
>      }
> @@ -1637,7 +1645,7 @@ static int length_f(BlockBackend *blk, int argc, char **argv)
>
>      size = blk_getlength(blk);
>      if (size < 0) {
> -        printf("getlength: %s\n", strerror(-size));
> +        fprintf(stderr, "getlength: %s\n", strerror(-size));
>          return size;
>      }
>
> @@ -1767,9 +1775,9 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
>          print_cvtnum_err(bytes, argv[optind]);
>          return bytes;
>      } else if (bytes >> BDRV_SECTOR_BITS > BDRV_REQUEST_MAX_SECTORS) {
> -        printf("length cannot exceed %"PRIu64", given %s\n",
> -               (uint64_t)BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS,
> -               argv[optind]);
> +        fprintf(stderr, "length cannot exceed %"PRIu64", given %s\n",
> +                (uint64_t)BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS,
> +                argv[optind]);
>          return -EINVAL;
>      }
>
> @@ -1778,7 +1786,7 @@ static int discard_f(BlockBackend *blk, int argc, char **argv)
>      gettimeofday(&t2, NULL);
>
>      if (ret < 0) {
> -        printf("discard failed: %s\n", strerror(-ret));
> +        fprintf(stderr, "discard failed: %s\n", strerror(-ret));
>          return ret;
>      }
>
> @@ -1820,7 +1828,7 @@ static int alloc_f(BlockBackend *blk, int argc, char **argv)
>      while (remaining) {
>          ret = bdrv_is_allocated(bs, offset, remaining, &num);
>          if (ret < 0) {
> -            printf("is_allocated failed: %s\n", strerror(-ret));
> +            fprintf(stderr, "is_allocated failed: %s\n", strerror(-ret));
>              return ret;
>          }
>          offset += num;
> @@ -2069,7 +2077,7 @@ static int break_f(BlockBackend *blk, int argc, char **argv)
>
>      ret = bdrv_debug_breakpoint(blk_bs(blk), argv[1], argv[2]);
>      if (ret < 0) {
> -        printf("Could not set breakpoint: %s\n", strerror(-ret));
> +        fprintf(stderr, "Could not set breakpoint: %s\n", strerror(-ret));
>          return ret;
>      }
>
> @@ -2082,7 +2090,8 @@ static int remove_break_f(BlockBackend *blk, int argc, char **argv)
>
>      ret = bdrv_debug_remove_breakpoint(blk_bs(blk), argv[1]);
>      if (ret < 0) {
> -        printf("Could not remove breakpoint %s: %s\n", argv[1], strerror(-ret));
> +        fprintf(stderr, "Could not remove breakpoint %s: %s\n",
> +                argv[1], strerror(-ret));
>          return ret;
>      }
>
> @@ -2114,7 +2123,7 @@ static int resume_f(BlockBackend *blk, int argc, char **argv)
>
>      ret = bdrv_debug_resume(blk_bs(blk), argv[1]);
>      if (ret < 0) {
> -        printf("Could not resume request: %s\n", strerror(-ret));
> +        fprintf(stderr, "Could not resume request: %s\n", strerror(-ret));
>          return ret;
>      }
>
> @@ -2193,8 +2202,9 @@ static int sigraise_f(BlockBackend *blk, int argc, char **argv)
>          print_cvtnum_err(sig, argv[1]);
>          return sig;
>      } else if (sig > NSIG) {
> -        printf("signal argument '%s' is too large to be a valid signal\n",
> -               argv[1]);
> +        fprintf(stderr,
> +                "signal argument '%s' is too large to be a valid signal\n",
> +                argv[1]);
>          return -EINVAL;
>      }
>
> @@ -2224,7 +2234,7 @@ static int sleep_f(BlockBackend *blk, int argc, char **argv)
>
>      ms = strtol(argv[1], &endptr, 0);
>      if (ms < 0 || *endptr != '\0') {
> -        printf("%s is not a valid number\n", argv[1]);
> +        fprintf(stderr, "%s is not a valid number\n", argv[1]);
>          return -EINVAL;
>      }
>
> @@ -2294,7 +2304,7 @@ static int help_f(BlockBackend *blk, int argc, char **argv)
>
>      ct = find_command(argv[1]);
>      if (ct == NULL) {
> -        printf("command %s not found\n", argv[1]);
> +        fprintf(stderr, "command %s not found\n", argv[1]);
>          return -EINVAL;
>      }
>
> diff --git a/qemu-io.c b/qemu-io.c
> index 6df7731af49..36308abb0cc 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -206,7 +206,8 @@ static int open_f(BlockBackend *blk, int argc, char **argv)
>              break;
>          case 'o':
>              if (imageOpts) {
> -                printf("--image-opts and 'open -o' are mutually exclusive\n");
> +                fprintf(stderr,
> +                        "--image-opts and 'open -o' are mutually exclusive\n");
>                  qemu_opts_reset(&empty_opts);
>                  return -EINVAL;
>              }
> --
> 2.17.2
>
>
