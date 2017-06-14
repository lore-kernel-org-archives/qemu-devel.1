Received: from eggs.gnu.org ([2001:4830:134:3::10]:50501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dL86P-0006FU-9D
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dL86O-0005UT-5P
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:12:53 -0400
References: <1497421359-32660-1-git-send-email-sochin.jiang@huawei.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <76e5666c-ecbf-5c7d-5dbb-e1fa845d2150@redhat.com>
Date: Wed, 14 Jun 2017 15:12:40 +0200
MIME-Version: 1.0
In-Reply-To: <1497421359-32660-1-git-send-email-sochin.jiang@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RH75r2iFdUk9V7bPHTRMap6ot8BqwM83S"
Subject: Re: [Qemu-devel] [PATCH] fix: avoid infinite loop when blockjob
 encountering failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sochin.jiang" <sochin.jiang@huawei.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RH75r2iFdUk9V7bPHTRMap6ot8BqwM83S
From: Max Reitz <mreitz@redhat.com>
To: "sochin.jiang" <sochin.jiang@huawei.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com,
 subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com,
 zhangshuai13@huawei.com, lizhengui@huawei.com
Message-ID: <76e5666c-ecbf-5c7d-5dbb-e1fa845d2150@redhat.com>
Subject: Re: [PATCH] fix: avoid infinite loop when blockjob encountering
 failure
References: <1497421359-32660-1-git-send-email-sochin.jiang@huawei.com>
In-Reply-To: <1497421359-32660-1-git-send-email-sochin.jiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for your patch! The issue can be reproduced as follows:

$ qemu-img create -f qcow2 -b \
    "json:{'driver':'raw','file':{
        'driver':'blkdebug','inject-error':[{'event':'write_aio'}],
        'image':{'driver':'null-co'}}}" \
     overlay.qcow2
$ qemu-io -c 'write 0 64k' overlay.qcow2
$ qemu-img commit overlay.qcow2

While your patch fixes that issue, I still have some comments:

On 2017-06-14 08:22, sochin.jiang wrote:
> From: "sochin.jiang" <sochin.jiang@huawei.com>
>=20
> img_commit could fall into infinite loop if it's blockjob

This should be "into an infinite loop" and "its" instead if "it's".

>=20

This empty line should be omitted.

> fail encountering any I/O error. Try to fix it.

Should be "fails on any I/O error" or "fails on encountering any I/O
error". Also, you're not trying to fix it but let's all hope you really
are fixing it. :-)

(So "Fix it." instead of "Try to fix it.")

>=20
> Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
> ---
>  qemu-img.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 0ad698d..6ba565d 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -895,8 +895,11 @@ static void run_block_job(BlockJob *job, Error **e=
rrp)
>          aio_poll(aio_context, true);
>          qemu_progress_print(job->len ?
>                              ((float)job->offset / job->len * 100.f) : =
0.0f, 0);
> -    } while (!job->ready);
> +    } while (!job->ready && !job->ret);

I think it would be better to test job->completed instead of job->ret.

> =20
> +    if (job->ret) {
> +        return;
> +    }

We shouldn't just return here but still do all the deinitialization like
call aio_context_release(). I guess the best would be to just skip the
block_job_complete_sync() call if job->completed is true.

>      block_job_complete_sync(job, errp);
>      aio_context_release(aio_context);

Then, there are three more issues I found while reviewing this patch:

First, if the block job is completed before block_job_complete_sync() is
called (i.e. if an error occurred), it is automatically freed. This is
bad because this means we'll have some instances of use-after-free here.
Therefore, we need to invoke block_job_ref() before run_block_job() and
block_job_unref() afterwards. (And since these functions are currenctly
static in blockjob.c, we'll have to make them global.)

Secondly, run_block_job() doesn't evaluate job->ret. Therefore it will
report success even if the commit failed (it is expecting
block_job_complete_sync() to put an error into errp, but it will not do
that). So we'll have to do that (manually check job->ret and if it's
negative, put an error message into errp; also, assert that
job->cancelled is false).

Thirdly, we have segfault in bdrv_reopen_prepare() if the image has
non-string options... I'll handle this one.

I can also handle the other two issues, if you'd like me to.


Finally, an iotest would be nice (see my reproducer above). But I can
handle that as well, if you decide not to write one.

Max


--RH75r2iFdUk9V7bPHTRMap6ot8BqwM83S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZQTZIEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQCtk
CACzr5ZSmZ8bFx2VfJmVMdziG83odPTrAhyEwDEJvu71wNPMLWio5BA+GxZ6/tob
MFXWnVufHegkW+SMkbuwO/Md07nYfHWbwbOpQv/HcHW+YuUlHi7TIwHqdUUhvjpT
+0N8GYP3Wv8HOaaYbUDsADqRh6YQxTJYEr7dTWwpDNlrqtkbf6ZVVzNigKOzPHwR
m9inL2CSa3fCCYIwcmcSQ1PhN+s9fucHavDXWCNjYuZWan/0wbD4mkyZCxT4Wa+Q
pZczVyYY5lkBoVwWUZTis1+Nv6tQPDsz0zF2DA9Lp46AKLNEbjnnGtRNPnnuCjUj
saCK1TeFq+R7D+4y0DR0n6eU
=3/8J
-----END PGP SIGNATURE-----

--RH75r2iFdUk9V7bPHTRMap6ot8BqwM83S--
