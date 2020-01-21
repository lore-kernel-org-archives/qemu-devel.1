Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1326BC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D036120882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 10:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfTJPl6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D036120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrAj-0003bU-TT
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 05:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itr8c-00013g-Gb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itr8Y-0004tX-V2
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:52:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48121
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itr8Y-0004tK-RR
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 05:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579603918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+FMCOhPWa429O8oUFcMcpIx5MbfD373zJIB/rxQ30s=;
 b=IfTJPl6qRUa+t2ojiWbLBq0fYodwSnS3CcA6sClRNVQnXNirjCfsseub6dtOhspRGSgzft
 NXKpbctze/tFzMwzzM3McHdnxuJojjO+qZftLMcuFw0p3KQdiitp7jBCNovaCkArIgdNRh
 6Ig4VdXZaRmtpHXVhqidteF2JXfbgZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-R2auFKsMPMWIikOUGz6eXQ-1; Tue, 21 Jan 2020 05:51:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D7561005516;
 Tue, 21 Jan 2020 10:51:54 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B62DF860EC;
 Tue, 21 Jan 2020 10:51:50 +0000 (UTC)
Date: Tue, 21 Jan 2020 10:51:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: Re: [PATCH 006/104] virtiofsd: Trim down imported files
Message-ID: <20200121105148.GC2929@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-7-dgilbert@redhat.com>
 <5E26CB57.7060804@cn.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <5E26CB57.7060804@cn.fujitsu.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: R2auFKsMPMWIikOUGz6eXQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Xiao Yang (yangx.jy@cn.fujitsu.com) wrote:
> On 2019/12/13 0:37, Dr. David Alan Gilbert (git) wrote:
> > -=09res =3D fuse_buf_copy(&pipe_buf, buf,
> > -=09=09=09    FUSE_BUF_FORCE_SPLICE | FUSE_BUF_SPLICE_NONBLOCK);
> > -=09if (res<  0) {
> > -=09=09if (res =3D=3D -EAGAIN || res =3D=3D -EINVAL) {
> > -=09=09=09/*
> > -=09=09=09 * Should only get EAGAIN on kernels with
> > -=09=09=09 * broken SPLICE_F_NONBLOCK support (<=3D
> > -=09=09=09 * 2.6.35) where this error or a short read is
> > -=09=09=09 * returned even if the pipe itself is not
> > -=09=09=09 * full
> > -=09=09=09 *
> > -=09=09=09 * EINVAL might mean that splice can't handle
> > -=09=09=09 * this combination of input and output.
> > -=09=09=09 */
> > -=09=09=09if (res =3D=3D -EAGAIN)
> > -=09=09=09=09se->broken_splice_nonblock =3D 1;
> > -
> > -=09=09=09pthread_setspecific(se->pipe_key, NULL);
> > -=09=09=09fuse_ll_pipe_free(llp);
> > -=09=09=09goto fallback;
> > -=09=09}
> > -=09=09res =3D -res;
> > -=09=09goto clear_pipe;
> > -=09}
> > -
> > -=09if (res !=3D 0&&  res<  len) {
> > -=09=09struct fuse_bufvec mem_buf =3D FUSE_BUFVEC_INIT(len);
> > -=09=09void *mbuf;
> > -=09=09size_t now_len =3D res;
> > -=09=09/*
> > -=09=09 * For regular files a short count is either
> > -=09=09 *  1) due to EOF, or
> > -=09=09 *  2) because of broken SPLICE_F_NONBLOCK (see above)
> > -=09=09 *
> > -=09=09 * For other inputs it's possible that we overflowed
> > -=09=09 * the pipe because of small buffer fragments.
> > -=09=09 */
> > -
> > -=09=09res =3D posix_memalign(&mbuf, pagesize, len);
> > -=09=09if (res !=3D 0)
> > -=09=09=09goto clear_pipe;
> > -
> > -=09=09mem_buf.buf[0].mem =3D mbuf;
> > -=09=09mem_buf.off =3D now_len;
> > -=09=09res =3D fuse_buf_copy(&mem_buf, buf, 0);
> > -=09=09if (res>  0) {
> > -=09=09=09char *tmpbuf;
> > -=09=09=09size_t extra_len =3D res;
> > -=09=09=09/*
> > -=09=09=09 * Trickiest case: got more data.  Need to get
> > -=09=09=09 * back the data from the pipe and then fall
> > -=09=09=09 * back to regular write.
> > -=09=09=09 */
> > -=09=09=09tmpbuf =3D malloc(headerlen);
> > -=09=09=09if (tmpbuf =3D=3D NULL) {
> > -=09=09=09=09free(mbuf);
> > -=09=09=09=09res =3D ENOMEM;
> > -=09=09=09=09goto clear_pipe;
> > -=09=09=09}
> > -=09=09=09res =3D read_back(llp->pipe[0], tmpbuf, headerlen);
> > -=09=09=09free(tmpbuf);
> > -=09=09=09if (res !=3D 0) {
> > -=09=09=09=09free(mbuf);
> > -=09=09=09=09goto clear_pipe;
> > -=09=09=09}
> > -=09=09=09res =3D read_back(llp->pipe[0], mbuf, now_len);
> > -=09=09=09if (res !=3D 0) {
> > -=09=09=09=09free(mbuf);
> > -=09=09=09=09goto clear_pipe;
> > -=09=09=09}
> > -=09=09=09len =3D now_len + extra_len;
> > -=09=09=09iov[iov_count].iov_base =3D mbuf;
> > -=09=09=09iov[iov_count].iov_len =3D len;
> > -=09=09=09iov_count++;
> > -=09=09=09res =3D fuse_send_msg(se, ch, iov, iov_count);
> > -=09=09=09free(mbuf);
> > -=09=09=09return res;
> > -=09=09}
> > -=09=09free(mbuf);
> > -=09=09res =3D now_len;
> > -=09}
> > -=09len =3D res;
> > -=09out->len =3D headerlen + len;
> > -
> > -=09if (se->debug) {
> > -=09=09fuse_log(FUSE_LOG_DEBUG,
> > -=09=09=09"   unique: %llu, success, outsize: %i (splice)\n",
> > -=09=09=09(unsigned long long) out->unique, out->len);
> > -=09}
> > -
> > -=09splice_flags =3D 0;
> > -=09if ((flags&  FUSE_BUF_SPLICE_MOVE)&&
> > -=09    (se->conn.want&  FUSE_CAP_SPLICE_MOVE))
> > -=09=09splice_flags |=3D SPLICE_F_MOVE;
> > -
> > -=09res =3D splice(llp->pipe[0], NULL, ch ? ch->fd : se->fd,
> > -=09=09     NULL, out->len, splice_flags);
> Hi,
>=20
> 1) In buffer.c, fuse_buf_splice() uses splice(2) to copy/move data in som=
e
> cases if the syscall is supported.
> 2) One pipe needs to be passed to splice(2) so splice(2) without one pipe
> fails and then go back to use other ways(e.g. use fuse_buf_fd_to_fd()).
> 3) fuse_buf_copy() calls fuse_buf_splice() indirectly and this patch has
> removed all pipes used by fuse_buf_copy().
>=20
> Is it necessary to leave the code related to splice(2)?  Is it going to b=
e
> used in future?
> We have to use splice(2) by the correct CONFIG_SPLICE macro If necessary.

Yes, I think we never set HAVE_SPLICE; so that code can go.
I'll change this patch to remove that as well.

Dave

> Best Regards,
> Xiao Yang
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


