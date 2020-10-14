Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BF4C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7A520B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSv5/R/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7A520B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjan-0002hV-2A
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSjZy-00023a-TE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSjZv-00044f-OI
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602692678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LZvwp8ROlXpeN2YrsnESCzqU8h6gQSdwb83sw8EDG5k=;
 b=gSv5/R/QI4aYvJqb17nOlbUJhgQJaU48M7yX2r9cSTXKzpngGpNyNFByEeEzCI//DaBrfd
 llHCDMr7qJ3vMdcy9wHj3UF1VwPgDoT5jBNOpNmVUK5aTSw2IjAUzWwaMk76wpR1V/VTZG
 92jCF4dNe88QFwnDS33R4HOtraY8Dkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-ghwSUOlXPFSJQncDjxwUsw-1; Wed, 14 Oct 2020 12:24:34 -0400
X-MC-Unique: ghwSUOlXPFSJQncDjxwUsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CF318030CD;
 Wed, 14 Oct 2020 16:24:33 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C36227512E;
 Wed, 14 Oct 2020 16:24:23 +0000 (UTC)
Subject: Re: [PATCH v11 13/13] block: apply COR-filter to block-stream jobs
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-14-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <6074273c-088f-069b-2a6c-aee812c3bad6@redhat.com>
Date: Wed, 14 Oct 2020 18:24:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1602524605-481160-14-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KmHazf8hsX750c2AY63SnLD9z6gX4Vfkl"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KmHazf8hsX750c2AY63SnLD9z6gX4Vfkl
Content-Type: multipart/mixed; boundary="hhdytaURa6iyfHC1ttE0bAkIWv7TNIHDd"

--hhdytaURa6iyfHC1ttE0bAkIWv7TNIHDd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.10.20 19:43, Andrey Shinkevich wrote:
> This patch completes the series with the COR-filter insertion for
> block-stream operations. Adding the filter makes it possible for copied
> regions to be discarded in backing files during the block-stream job,
> what will reduce the disk overuse.
> The COR-filter insertion incurs changes in the iotests case
> 245:test_block_stream_4 that reopens the backing chain during a
> block-stream job. There are changes in the iotests #030 as well.
> The iotests case 030:test_stream_parallel was deleted due to multiple
> conflicts between the concurrent job operations over the same backing
> chain. The base backing node for one job is the top node for another
> job. It may change due to the filter node inserted into the backing
> chain while both jobs are running. Another issue is that the parts of
> the backing chain are being frozen by the running job and may not be
> changed by the concurrent job when needed. The concept of the parallel
> jobs with common nodes is considered vital no more.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/stream.c             | 93 +++++++++++++++++++++++++++++-----------=
------
>  tests/qemu-iotests/030     | 51 +++----------------------
>  tests/qemu-iotests/030.out |  4 +-
>  tests/qemu-iotests/141.out |  2 +-
>  tests/qemu-iotests/245     | 19 +++++++---
>  5 files changed, 81 insertions(+), 88 deletions(-)

Looks like stream_run() could be a bit streamlined now (the allocation
checking should be unnecessary, unconditionally calling
stream_populate() should be sufficient), but not necessary now.

> diff --git a/block/stream.c b/block/stream.c
> index d3e1812..93564db 100644
> --- a/block/stream.c
> +++ b/block/stream.c

[...]

> @@ -94,13 +94,14 @@ static void stream_clean(Job *job)
>  {
>      StreamBlockJob *s =3D container_of(job, StreamBlockJob, common.job);
>      BlockJob *bjob =3D &s->common;
> -    BlockDriverState *bs =3D blk_bs(bjob->blk);
> +
> +    bdrv_cor_filter_drop(s->cor_filter_bs);
> =20
>      /* Reopen the image back in read-only mode if necessary */
>      if (s->bs_read_only) {
>          /* Give up write permissions before making it read-only */
>          blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);

Perhaps it would be good to do so even before the filter is dropped.  I
don=E2=80=99t know whether moving bjob->blk from cor_filter_bs to target_bs
might cause problems otherwise.

> -        bdrv_reopen_set_read_only(bs, true, NULL);
> +        bdrv_reopen_set_read_only(s->target_bs, true, NULL);
>      }
>  }

[...]

> @@ -262,17 +249,48 @@ void stream_start(const char *job_id, BlockDriverSt=
ate *bs,
>          }
>      }
> =20
> -    /* Prevent concurrent jobs trying to modify the graph structure here=
, we
> -     * already have our own plans. Also don't allow resize as the image =
size is
> -     * queried only at the job start and then cached. */
> -    s =3D block_job_create(job_id, &stream_job_driver, NULL, bs,
> -                         basic_flags | BLK_PERM_GRAPH_MOD,
> -                         basic_flags | BLK_PERM_WRITE,
> +    QDict *opts =3D qdict_new();

Declaration should be done at the start of the block.

> +
> +    qdict_put_str(opts, "driver", "copy-on-read");
> +    qdict_put_str(opts, "file", bdrv_get_node_name(bs));
> +    if (base_overlay) {

@base_overlay is always non-NULL, this condition should check @base, I
think.

> +        /* Pass the base_overlay rather than base */
> +        qdict_put_str(opts, "base", base_overlay->node_name);
> +    }
> +    if (filter_node_name) {
> +        qdict_put_str(opts, "node-name", filter_node_name);
> +    }
> +
> +    cor_filter_bs =3D bdrv_cor_filter_append(bs, opts, BDRV_O_RDWR, errp=
);
> +    if (cor_filter_bs =3D=3D NULL) {
> +        goto fail;
> +    }
> +
> +    if (bdrv_freeze_backing_chain(cor_filter_bs, bs, errp) < 0) {

Is there a reason why we can=E2=80=99t combine this with the
bdrv_free_backing_chain() from bs down to above_base?  I mean, the
effect should be the same, just asking.

> +        bdrv_cor_filter_drop(cor_filter_bs);
> +        cor_filter_bs =3D NULL;
> +        goto fail;
> +    }
> +
> +    s =3D block_job_create(job_id, &stream_job_driver, NULL, cor_filter_=
bs,
> +                         BLK_PERM_CONSISTENT_READ,
> +                         basic_flags | BLK_PERM_WRITE | BLK_PERM_GRAPH_M=
OD,

Not that I=E2=80=99m an expert on the GRAPH_MOD permission, but why is this
shared here but not below?  Shouldn=E2=80=99t it be the same in both cases?
(Same for taking it as a permission.)

>                           speed, creation_flags, NULL, NULL, errp);
>      if (!s) {
>          goto fail;
>      }
> =20
> +    /*
> +     * Prevent concurrent jobs trying to modify the graph structure here=
, we
> +     * already have our own plans. Also don't allow resize as the image =
size is
> +     * queried only at the job start and then cached.
> +     */
> +    if (block_job_add_bdrv(&s->common, "active node", bs,
> +                           basic_flags | BLK_PERM_GRAPH_MOD,
> +                           basic_flags | BLK_PERM_WRITE, &error_abort)) =
{
> +        goto fail;
> +    }
> +
>      /* Block all intermediate nodes between bs and base, because they wi=
ll
>       * disappear from the chain after this operation. The streaming job =
reads
>       * every block only once, assuming that it doesn't change, so forbid=
 writes

[...]

> diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
> index e60c832..940e85a 100755
> --- a/tests/qemu-iotests/245
> +++ b/tests/qemu-iotests/245
> @@ -899,17 +899,26 @@ class TestBlockdevReopen(iotests.QMPTestCase):
>          # make hd1 read-only and block-stream requires it to be read-wri=
te
>          # (Which error message appears depends on whether the stream job=
 is
>          # already done with copying at this point.)

Hm.  Let=E2=80=99s look at the set of messages below... [1]

> -        self.reopen(opts, {},
> +        # As the COR-filter node is inserted into the backing chain with=
 the
> +        # 'block-stream' operation, we move the options to their proper =
nodes.
> +        opts =3D hd_opts(1)

Oh, so this patch changes it so that only the subtree below hd1 is
reopened, and we don=E2=80=99t have to deal with the filter options.  Got i=
t.
(I think.)

> +        opts['backing'] =3D hd_opts(2)
> +        opts['backing']['backing'] =3D None
> +        self.reopen(opts, {'read-only': True},
>              ["Can't set node 'hd1' to r/o with copy-on-read enabled",

[1]

This isn=E2=80=99t done anymore as of this patch.  So I don=E2=80=99t think=
 this error
message can still appear.  Will some other message appear in its stead,
or is it always going to be the second one?

>               "Cannot make block node read-only, there is a writer on it"=
])
> =20
>          # We can't remove hd2 while the stream job is ongoing
> -        opts['backing']['backing'] =3D None
> -        self.reopen(opts, {'backing.read-only': False}, "Cannot change '=
backing' link from 'hd1' to 'hd2'")
> +        opts['backing'] =3D None
> +        self.reopen(opts, {'read-only': False},
> +                    "Cannot change 'backing' link from 'hd1' to 'hd2'")
> =20
> -        # We can detach hd1 from hd0 because it doesn't affect the strea=
m job
> +        # We can't detach hd1 from hd0 because there is the COR-filter i=
mplicit
> +        # node in between.
> +        opts =3D hd_opts(0)
>          opts['backing'] =3D None
> -        self.reopen(opts)
> +        self.reopen(opts, {},
> +                    "Cannot change backing link if 'hd0' has an implicit=
 backing file")

Does =E2=80=9Chas an implicit backing file=E2=80=9D mean that hd0 has an im=
plicit node
(the COR filter) as its backing file?  And then reopening isn=E2=80=99t all=
owed
because the user supposedly doesn=E2=80=99t know about that implicit node? =
 If
so, makes sense.

Max

> =20
>          self.vm.run_job('stream0', auto_finalize =3D False, auto_dismiss=
 =3D True)
> =20
>=20



--hhdytaURa6iyfHC1ttE0bAkIWv7TNIHDd--

--KmHazf8hsX750c2AY63SnLD9z6gX4Vfkl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+HJjUACgkQ9AfbAGHV
z0BtMwf+JwaV6gADjNJoxkKmZLlTUT5XideSFIq/61DcrQ9l4eo+UJCf1HtonR8A
PGLlvoG5Rf98Zw5ub95NyKoIVYc0+us5Mr5Eru5djmRZUbFkLVl7qcr3r3xy7o8b
uHg35oWliU/YWTE0B7Sd6cShGYAgRnocsqAsXIM51wE4KDw42Wxt8qmmJrDEVt+9
frcZZh/GczFgzk5Xq78zXgO04Qv8+vorXPmYxQslQha33I1ZzthHkJmNVBW7ATJ+
RoyCapsIF5jYzDyMmpqACrkS7tdEdvKz4Off1yYxquW9RJMzfSI1fhtuZb5HOTEE
51VpliRu22v0xxdgFdeN+OBbj9QpQA==
=WfQ7
-----END PGP SIGNATURE-----

--KmHazf8hsX750c2AY63SnLD9z6gX4Vfkl--


