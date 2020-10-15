Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E08C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E962C21D41
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dW9eLNTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E962C21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5fb-0000lf-QN
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT5du-0008Ey-Hc
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23908)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT5ds-0002Xb-MF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602777491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yaJBa0ccXSqbtLnPR7PASJL2oVQ5gKekBojF6R1YgPA=;
 b=dW9eLNTzUtymBgZPBEKyvSid+6tzkOvdoHCWHuxr1uqAWEf/ZrB0wiRnV4zXiioRUT8KwQ
 VvcOAQjhsf/flfP9WvVz9qQiv/l0OEArakqaTwNUyDRmR4uuketlmQ+imA8Jsvtb75xTe6
 a7NBDEdAIEPZ41bL9nnsvjJr44Dv7sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-F3OcC09jNQ-kiPY01TMmPw-1; Thu, 15 Oct 2020 11:58:07 -0400
X-MC-Unique: F3OcC09jNQ-kiPY01TMmPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CC681084CB6;
 Thu, 15 Oct 2020 15:58:06 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 103FF1002C00;
 Thu, 15 Oct 2020 15:58:01 +0000 (UTC)
Date: Thu, 15 Oct 2020 17:58:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 03/20] fuse: Implement standard FUSE operations
Message-ID: <20201015155800.GL4610@merkur.fritz.box>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-4-mreitz@redhat.com>
 <20201015094622.GC4610@merkur.fritz.box>
 <34828933-5ac1-ba04-39e8-eeaef604f5b0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <34828933-5ac1-ba04-39e8-eeaef604f5b0@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.10.2020 um 17:18 hat Max Reitz geschrieben:
> On 15.10.20 11:46, Kevin Wolf wrote:
> > Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:
> >> This makes the export actually useful instead of only producing errors
> >> whenever it is accessed.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>

> >> +/**
> >> + * Handle client reads from the exported image.
> >> + */
> >> +static void fuse_read(fuse_req_t req, fuse_ino_t inode,
> >> +                      size_t size, off_t offset, struct fuse_file_inf=
o *fi)
> >> +{
> >> +    FuseExport *exp =3D fuse_req_userdata(req);
> >> +    int64_t length;
> >> +    void *buf;
> >> +    int ret;
> >> +
> >> +    /**
> >> +     * Clients will expect short reads at EOF, so we have to limit
> >> +     * offset+size to the image length.
> >> +     */
> >> +    length =3D blk_getlength(exp->common.blk);
> >> +    if (length < 0) {
> >> +        fuse_reply_err(req, -length);
> >> +        return;
> >> +    }
> >> +
> >> +    size =3D MIN(size, FUSE_MAX_BOUNCE_BYTES);
> >=20
> > "Read should send exactly the number of bytes requested except on EOF o=
r
> > error, otherwise the rest of the data will be substituted with zeroes."
>=20
> :(
>=20
> > Do we corrupt huge reads with this, so that read() succeeds, but the
> > buffer is zeroed above 64M instead of containing the correct data? Mayb=
e
> > we should return an error instead?
>=20
> Hm.  It looks like there is a max_read option obeyed by the kernel
> driver, and it appears it=E2=80=99s set by implementing .init() and setti=
ng
> fuse_conn_info.max_read (also, =E2=80=9Cfor the time being=E2=80=9D it ha=
s to also set
> in the mount options passed to fuse_session_new()).
>=20
> I=E2=80=99m not sure whether that does anything, though.  It appears that
> whenever I do a cached read, it caps out at 128k (which is what
> cuse_prep_data() in libfuse sets; though increasing that number there
> doesn=E2=80=99t change anything, so I think that=E2=80=99s just a coincid=
ence), and with
> O_DIRECT, it caps out at 1M.
>=20
> But at least that would be grounds to return an error for >64M requests.
>  (Limiting max_read to 64k does limit all read requests to 64k.)

Yes, setting max_read and making larger requests an error seems like a
good solution.

> Further investigation is needed.

If you want :-)

> > (It's kind of sad that we need a bounce buffer from which data is later
> > copied instead of being provided the right memory by the kernel.)
>=20
> Yes, it is.
>=20
> >> +    if (offset + size > length) {
> >> +        size =3D length - offset;
> >> +    }
> >> +
> >> +    buf =3D qemu_try_blockalign(blk_bs(exp->common.blk), size);
> >> +    if (!buf) {
> >> +        fuse_reply_err(req, ENOMEM);
> >> +        return;
> >> +    }
> >> +
> >> +    ret =3D blk_pread(exp->common.blk, offset, buf, size);
> >> +    if (ret >=3D 0) {
> >> +        fuse_reply_buf(req, buf, size);
> >> +    } else {
> >> +        fuse_reply_err(req, -ret);
> >> +    }
> >> +
> >> +    qemu_vfree(buf);
> >> +}
> >> +
> >> +/**
> >> + * Handle client writes to the exported image.
> >> + */
> >> +static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *=
buf,
> >> +                       size_t size, off_t offset, struct fuse_file_in=
fo *fi)
> >> +{
> >> +    FuseExport *exp =3D fuse_req_userdata(req);
> >> +    int64_t length;
> >> +    int ret;
> >> +
> >> +    if (!exp->writable) {
> >> +        fuse_reply_err(req, EACCES);
> >> +        return;
> >> +    }
> >> +
> >> +    /**
> >> +     * Clients will expect short writes at EOF, so we have to limit
> >> +     * offset+size to the image length.
> >> +     */
> >> +    length =3D blk_getlength(exp->common.blk);
> >> +    if (length < 0) {
> >> +        fuse_reply_err(req, -length);
> >> +        return;
> >> +    }
> >> +
> >> +    size =3D MIN(size, BDRV_REQUEST_MAX_BYTES);
> >=20
> > We're only supposed to do short writes on EOF, so this has a similar
> > problem as in fuse_read, except that BDRV_REQUEST_MAX_BYTES is much
> > higher and it's not specified what the resulting misbehaviour could be
> > (possibly the kernel not retrying write for the rest of the buffer?)
>=20
> As for reading above, we can (and should) probably set max_write.

Yes.

> >> +    if (offset + size > length) {
> >> +        size =3D length - offset;
> >> +    }
> >> +
> >> +    ret =3D blk_pwrite(exp->common.blk, offset, buf, size, 0);
> >> +    if (ret >=3D 0) {
> >> +        fuse_reply_write(req, size);
> >> +    } else {
> >> +        fuse_reply_err(req, -ret);
> >> +    }
> >> +}
> >> +
> >> +/**
> >> + * Let clients flush the exported image.
> >> + */
> >> +static void fuse_flush(fuse_req_t req, fuse_ino_t inode,
> >> +                       struct fuse_file_info *fi)
> >> +{
> >> +    FuseExport *exp =3D fuse_req_userdata(req);
> >> +    int ret;
> >> +
> >> +    ret =3D blk_flush(exp->common.blk);
> >> +    fuse_reply_err(req, ret < 0 ? -ret : 0);
> >> +}
> >=20
> > This seems to be an implementation for .fsync rather than for .flush.
>=20
> Wouldn=E2=80=99t fsync entail a drain?

Hm, the libfuse documentation doesn't say anything about draining. I
suppose this is because if requests need to be drained, it will do so in
the kernel. But I haven't checked the code.

So I expect that calling fsync() on the lower layer does everything that
is needed. Which is bdrv_flush() in QEMU.

> Or is it the opposite, flush should just drain and not invoke
> blk_flush()?  (Sorry, this all gets me confused every time.)

I'm just relying on the libfuse documentation there for flush:

"This is called on each close() of the opened file."

and

"NOTE: the name of the method is misleading, since (unlike fsync) the
filesystem is not forced to flush pending writes. One reason to flush
data is if the filesystem wants to return write errors during close.
However, such use is non-portable because POSIX does not require close
to wait for delayed I/O to complete."

> (Though I do think .fsync should both flush and drain.)
>=20
> > Hmm, or maybe actually for both? We usually do bdrv_flush() during
> > close, so it would be consistent to do the same here. It's our last
> > chance to report an error to the user before the file is closed.
>=20
> I don=E2=80=99t understand what you mean.  What is =E2=80=9Cthe same=E2=
=80=9D?  Closing the
> image?  Or indeed having .flush() be implemented with blk_flush()?

Implementing .flush(), which will be called when the image is closed,
with blk_flush().

And still doing blk_flush() for .fsync, of course.

> Do you mean that other parties may do the same as qemu does, i.e.
> flush files before they are closed, which is why we should anticipate
> the same and give users a chance to see errors?

I'm not exactly sure what failure of .flush() would look like for users.
Probably close() failing, so they don't have to do anything special,
just check their return values.

Kevin

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl+IcYgACgkQfwmycsiP
L9aJ0hAAiPGuXVET+nuVr6ePd2n7rv88rvT0wsL4h0uOW1dv/eRPPdEQgbRGXYZG
10tM2tNIcuiqYjHHZNs7KVScnIszLU4j0Kh9HjPIEsjKNIpDl26cH7UbF8sxpdMh
6ErS5TFCCE8Md6iPnE2TgWvV/78Yj6RPGh1YHAJt4FYK1eutRVEnzWSTp37GDwKv
tLQDBU4GIpNw6Ohd1wfWDMlZ+GKNAAeV4PtQMYHfWzr8hZVe5tXH6Juu61rG4/eq
A4A116JxvmMvN9+8IV6R6TJwe1zU7OOPceonH0z6DGWOEs5kfW3IsxtEzPNZgbPO
YAT0BDtuYesaun9Bj6aBqEv+tw9uRAlZftlMghDAcapa94DMAB+On/mFwUBXyyN+
JWrTKl2cES/Zlt/V+BeXsBI7gKEnRst/w4yFmv6ISGiwzekjnLBW3EoqvjodSIse
kE6iC+bzqRAx3Sw0jrm68lLVpoMapGeMJTmj6xv+yW0UFGbwvjdryIYfBJvxdTaJ
VxxecQ95TSw3Snm2jkBuvqN9pY1y72t3SVSArpA9BpVBCoLirwY0Tqe2hSf66xtG
T5sbH4jMLlbOOqeUgJpoBtHTH4InZFlg6nw4qUK/AZgMY3JyStq+1FlHtqT9eP3a
Rkuka9r5ojq1nfAHFjFbP4NvpXDqrLX7ZRACEXCUBGnp1EkCGWI=
=Q77R
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--


