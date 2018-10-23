Received: from eggs.gnu.org ([2001:4830:134:3::10]:35013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEp8i-0003kk-7w
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 01:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEowf-0000Fi-3r
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 01:09:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181022140204.15791-1-famz@redhat.com>
Date: Tue, 23 Oct 2018 07:09:21 +0200
In-Reply-To: <20181022140204.15791-1-famz@redhat.com> (Fam Zheng's message of
	"Mon, 22 Oct 2018 22:02:04 +0800")
Message-ID: <87efch9rlq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] file-posix: Use error API properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Fam Zheng <famz@redhat.com> writes:

> Use error_report for situations that affect user operation (i.e.  we're
> actually returning error), and warn_report/warn_report_err when some
> less critical error happened but the user operation can still carry on.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 2da3a76355..2a46899313 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -214,8 +214,7 @@ static int raw_normalize_devicepath(const char **filename)
>      fname = *filename;
>      dp = strrchr(fname, '/');
>      if (lstat(fname, &sb) < 0) {
> -        fprintf(stderr, "%s: stat failed: %s\n",
> -            fname, strerror(errno));
> +        error_report("%s: stat failed: %s", fname, strerror(errno));
>          return -errno;
>      }

raw_normalize_devicepath() is called from functions taking an Error
** argument, like this:

    ret = raw_normalize_devicepath(&filename);
    if (ret != 0) {
        error_setg_errno(errp, -ret, "Could not normalize device path");
        goto fail;
    }

If it fails, we get two error messages, first a specific one from
raw_normalize_devicepath(), then a generic one from whatever reports the
Error created by its caller.

The first message goes to stderr or the current HMP monitor.

The second could go to QMP instead, or be suppressed entirely.

You should convert raw_normalize_devicepath() to Error so you can create
just an Error.  This patch is an improvement even without that, of
course, and I'm therefore not withholding my r-by just for that.

Please also check the other functions that use error_report().

>  
> @@ -229,9 +228,8 @@ static int raw_normalize_devicepath(const char **filename)
>          snprintf(namebuf, PATH_MAX, "%.*s/r%s",
>              (int)(dp - fname), fname, dp + 1);
>      }
> -    fprintf(stderr, "%s is a block device", fname);
>      *filename = namebuf;
> -    fprintf(stderr, ", using %s\n", *filename);
> +    warn_report("%s is a block device, using %s", fname, *filename);
>  
>      return 0;
>  }
> @@ -492,11 +490,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>      case ON_OFF_AUTO_ON:
>          s->use_lock = true;
>          if (!qemu_has_ofd_lock()) {
> -            fprintf(stderr,
> +            warn_report(
>                      "File lock requested but OFD locking syscall is "
> -                    "unavailable, falling back to POSIX file locks.\n"
> +                    "unavailable, falling back to POSIX file locks. "
>                      "Due to the implementation, locks can be lost "
> -                    "unexpectedly.\n");
> +                    "unexpectedly.");

warn_report()'s contract stipulates "The resulting message should be a
single phrase, with no newline or trailing punctuation."  The message
should be split into a warning that complies with the contract and
additional hints.  For an example see my "[PATCH v4 04/38] cpus hw
target: Use warn_report() & friends to report warnings".

>          }
>          break;
>      case ON_OFF_AUTO_OFF:
> @@ -805,7 +803,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
>              /* Theoretically the above call only unlocks bytes and it cannot
>               * fail. Something weird happened, report it.
>               */
> -            error_report_err(local_err);
> +            warn_report_err(local_err);
>          }
>          break;
>      case RAW_PL_COMMIT:
> @@ -815,7 +813,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
>              /* Theoretically the above call only unlocks bytes and it cannot
>               * fail. Something weird happened, report it.
>               */
> -            error_report_err(local_err);
> +            warn_report_err(local_err);
>          }
>          break;
>      }
> @@ -1775,7 +1773,7 @@ static int aio_worker(void *arg)
>          ret = handle_aiocb_truncate(aiocb);
>          break;
>      default:
> -        fprintf(stderr, "invalid aio request (0x%x)\n", aiocb->aio_type);
> +        error_report("invalid aio request (0x%x)", aiocb->aio_type);
>          ret = -EINVAL;
>          break;
>      }
> @@ -2263,7 +2261,7 @@ out_unlock:
>           * not mean the whole creation operation has failed.  So
>           * report it the user for their convenience, but do not report
>           * it to the caller. */
> -        error_report_err(local_err);
> +        warn_report_err(local_err);
>      }
>  
>  out_close:
