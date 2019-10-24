Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9CEC47E49
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45A720650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkbO+PRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45A720650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfrx-0002mi-Rm
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNepg-0004w5-8I
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNepX-0000vJ-VJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:15:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35223
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNepX-0000u1-89
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571930111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obQZTydp/d2tJ9vXj2S1Pg/1OzOpj1a51qziznxXjbo=;
 b=VkbO+PRn3zZQTnyE6nrSFsWc+gG8sogxNDXodIOS5xS32Kdpms7Tc9UOu00ZO40TsniUFz
 zDorMt1qSgnlHFvf3P6wouUTt8gmJi1CqYNY279g0PnzLfB9+WADzHngYPZeA87xDt9nCC
 h3VpzTEhCbaPgPhB+2bszrVa253QkjM=
Received: from mimecast-mx01.redhat.com (209.132.183.4 [209.132.183.4])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-A400gCK2OGiSF13CGlaqww-1; Thu, 24 Oct 2019 10:49:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5E3A61C;
 Thu, 24 Oct 2019 14:31:31 +0000 (UTC)
Received: from work-vm (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2755D60BF3;
 Thu, 24 Oct 2019 14:31:19 +0000 (UTC)
Date: Thu, 24 Oct 2019 15:31:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 04/30] virtiofsd: Add fuse_lowlevel.c
Message-ID: <20191024143116.GI2877@work-vm>
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <20191021105832.36574-5-dgilbert@redhat.com>
 <20191024071037-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191024071037-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: A400gCK2OGiSF13CGlaqww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org, piaojun@huawei.com, stefanha@redhat.com,
 marcandre.lureau@redhat.com, eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Mon, Oct 21, 2019 at 11:58:06AM +0100, Dr. David Alan Gilbert (git) wr=
ote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > fuse_lowlevel is one of the largest files from the library
> > and does most of the work.  Add it separately to keep the diff
> > sizes small.
> > Again this is from upstream a0d713619d4f21e8240ede38eefe6101ea580724
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  contrib/virtiofsd/fuse_lowlevel.c | 3104 +++++++++++++++++++++++++++++
> >  1 file changed, 3104 insertions(+)
> >  create mode 100644 contrib/virtiofsd/fuse_lowlevel.c
> >=20
> > diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse=
_lowlevel.c
> > new file mode 100644
> > index 0000000000..f7fbc8f5db
> > --- /dev/null
> > +++ b/contrib/virtiofsd/fuse_lowlevel.c
> > @@ -0,0 +1,3104 @@
> > +/*
> > +  FUSE: Filesystem in Userspace
> > +  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
> > +
> > +  Implementation of (most of) the low-level FUSE API. The session loop
> > +  functions are implemented in separate files.
> > +
> > +  This program can be distributed under the terms of the GNU LGPLv2.
> > +  See the file COPYING.LIB
>=20
> I guess we need COPYING.LIB then?

We already do; it has GPL 2.1 in (again libfuse's is called LGPL2.txt
but ours matches).

Dave

> > +*/
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include "config.h"
> > +#include "fuse_i.h"
> > +#include "fuse_kernel.h"
> > +#include "fuse_opt.h"
> > +#include "fuse_misc.h"
> > +#include "mount_util.h"
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <stddef.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <limits.h>
> > +#include <errno.h>
> > +#include <assert.h>
> > +#include <sys/file.h>
> > +
> > +#ifndef F_LINUX_SPECIFIC_BASE
> > +#define F_LINUX_SPECIFIC_BASE       1024
> > +#endif
> > +#ifndef F_SETPIPE_SZ
> > +#define F_SETPIPE_SZ=09(F_LINUX_SPECIFIC_BASE + 7)
> > +#endif
> > +
> > +
> > +#define PARAM(inarg) (((char *)(inarg)) + sizeof(*(inarg)))
> > +#define OFFSET_MAX 0x7fffffffffffffffLL
> > +
> > +#define container_of(ptr, type, member) ({=09=09=09=09\
> > +=09=09=09const typeof( ((type *)0)->member ) *__mptr =3D (ptr); \
> > +=09=09=09(type *)( (char *)__mptr - offsetof(type,member) );})
> > +
> > +struct fuse_pollhandle {
> > +=09uint64_t kh;
> > +=09struct fuse_session *se;
> > +};
> > +
> > +static size_t pagesize;
> > +
> > +static __attribute__((constructor)) void fuse_ll_init_pagesize(void)
> > +{
> > +=09pagesize =3D getpagesize();
> > +}
> > +
> > +static void convert_stat(const struct stat *stbuf, struct fuse_attr *a=
ttr)
> > +{
> > +=09attr->ino=09=3D stbuf->st_ino;
> > +=09attr->mode=09=3D stbuf->st_mode;
> > +=09attr->nlink=09=3D stbuf->st_nlink;
> > +=09attr->uid=09=3D stbuf->st_uid;
> > +=09attr->gid=09=3D stbuf->st_gid;
> > +=09attr->rdev=09=3D stbuf->st_rdev;
> > +=09attr->size=09=3D stbuf->st_size;
> > +=09attr->blksize=09=3D stbuf->st_blksize;
> > +=09attr->blocks=09=3D stbuf->st_blocks;
> > +=09attr->atime=09=3D stbuf->st_atime;
> > +=09attr->mtime=09=3D stbuf->st_mtime;
> > +=09attr->ctime=09=3D stbuf->st_ctime;
> > +=09attr->atimensec =3D ST_ATIM_NSEC(stbuf);
> > +=09attr->mtimensec =3D ST_MTIM_NSEC(stbuf);
> > +=09attr->ctimensec =3D ST_CTIM_NSEC(stbuf);
> > +}
> > +
> > +static void convert_attr(const struct fuse_setattr_in *attr, struct st=
at *stbuf)
> > +{
> > +=09stbuf->st_mode=09       =3D attr->mode;
> > +=09stbuf->st_uid=09       =3D attr->uid;
> > +=09stbuf->st_gid=09       =3D attr->gid;
> > +=09stbuf->st_size=09       =3D attr->size;
> > +=09stbuf->st_atime=09       =3D attr->atime;
> > +=09stbuf->st_mtime=09       =3D attr->mtime;
> > +=09stbuf->st_ctime        =3D attr->ctime;
> > +=09ST_ATIM_NSEC_SET(stbuf, attr->atimensec);
> > +=09ST_MTIM_NSEC_SET(stbuf, attr->mtimensec);
> > +=09ST_CTIM_NSEC_SET(stbuf, attr->ctimensec);
> > +}
> > +
> > +static=09size_t iov_length(const struct iovec *iov, size_t count)
> > +{
> > +=09size_t seg;
> > +=09size_t ret =3D 0;
> > +
> > +=09for (seg =3D 0; seg < count; seg++)
> > +=09=09ret +=3D iov[seg].iov_len;
> > +=09return ret;
> > +}
> > +
> > +static void list_init_req(struct fuse_req *req)
> > +{
> > +=09req->next =3D req;
> > +=09req->prev =3D req;
> > +}
> > +
> > +static void list_del_req(struct fuse_req *req)
> > +{
> > +=09struct fuse_req *prev =3D req->prev;
> > +=09struct fuse_req *next =3D req->next;
> > +=09prev->next =3D next;
> > +=09next->prev =3D prev;
> > +}
> > +
> > +static void list_add_req(struct fuse_req *req, struct fuse_req *next)
> > +{
> > +=09struct fuse_req *prev =3D next->prev;
> > +=09req->next =3D next;
> > +=09req->prev =3D prev;
> > +=09prev->next =3D req;
> > +=09next->prev =3D req;
> > +}
> > +
> > +static void destroy_req(fuse_req_t req)
> > +{
> > +=09pthread_mutex_destroy(&req->lock);
> > +=09free(req);
> > +}
> > +
> > +void fuse_free_req(fuse_req_t req)
> > +{
> > +=09int ctr;
> > +=09struct fuse_session *se =3D req->se;
> > +
> > +=09pthread_mutex_lock(&se->lock);
> > +=09req->u.ni.func =3D NULL;
> > +=09req->u.ni.data =3D NULL;
> > +=09list_del_req(req);
> > +=09ctr =3D --req->ctr;
> > +=09fuse_chan_put(req->ch);
> > +=09req->ch =3D NULL;
> > +=09pthread_mutex_unlock(&se->lock);
> > +=09if (!ctr)
> > +=09=09destroy_req(req);
> > +}
> > +
> > +static struct fuse_req *fuse_ll_alloc_req(struct fuse_session *se)
> > +{
> > +=09struct fuse_req *req;
> > +
> > +=09req =3D (struct fuse_req *) calloc(1, sizeof(struct fuse_req));
> > +=09if (req =3D=3D NULL) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate request\n");
> > +=09} else {
> > +=09=09req->se =3D se;
> > +=09=09req->ctr =3D 1;
> > +=09=09list_init_req(req);
> > +=09=09fuse_mutex_init(&req->lock);
> > +=09}
> > +
> > +=09return req;
> > +}
> > +
> > +/* Send data. If *ch* is NULL, send via session master fd */
> > +static int fuse_send_msg(struct fuse_session *se, struct fuse_chan *ch=
,
> > +=09=09=09 struct iovec *iov, int count)
> > +{
> > +=09struct fuse_out_header *out =3D iov[0].iov_base;
> > +
> > +=09out->len =3D iov_length(iov, count);
> > +=09if (se->debug) {
> > +=09=09if (out->unique =3D=3D 0) {
> > +=09=09=09fuse_log(FUSE_LOG_DEBUG, "NOTIFY: code=3D%d length=3D%u\n",
> > +=09=09=09=09out->error, out->len);
> > +=09=09} else if (out->error) {
> > +=09=09=09fuse_log(FUSE_LOG_DEBUG,
> > +=09=09=09=09"   unique: %llu, error: %i (%s), outsize: %i\n",
> > +=09=09=09=09(unsigned long long) out->unique, out->error,
> > +=09=09=09=09strerror(-out->error), out->len);
> > +=09=09} else {
> > +=09=09=09fuse_log(FUSE_LOG_DEBUG,
> > +=09=09=09=09"   unique: %llu, success, outsize: %i\n",
> > +=09=09=09=09(unsigned long long) out->unique, out->len);
> > +=09=09}
> > +=09}
> > +
> > +=09ssize_t res =3D writev(ch ? ch->fd : se->fd,
> > +=09=09=09     iov, count);
> > +=09int err =3D errno;
> > +
> > +=09if (res =3D=3D -1) {
> > +=09=09assert(se !=3D NULL);
> > +
> > +=09=09/* ENOENT means the operation was interrupted */
> > +=09=09if (!fuse_session_exited(se) && err !=3D ENOENT)
> > +=09=09=09perror("fuse: writing device");
> > +=09=09return -err;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +
> > +int fuse_send_reply_iov_nofree(fuse_req_t req, int error, struct iovec=
 *iov,
> > +=09=09=09       int count)
> > +{
> > +=09struct fuse_out_header out;
> > +
> > +=09if (error <=3D -1000 || error > 0) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: bad error value: %i\n",=09error);
> > +=09=09error =3D -ERANGE;
> > +=09}
> > +
> > +=09out.unique =3D req->unique;
> > +=09out.error =3D error;
> > +
> > +=09iov[0].iov_base =3D &out;
> > +=09iov[0].iov_len =3D sizeof(struct fuse_out_header);
> > +
> > +=09return fuse_send_msg(req->se, req->ch, iov, count);
> > +}
> > +
> > +static int send_reply_iov(fuse_req_t req, int error, struct iovec *iov=
,
> > +=09=09=09  int count)
> > +{
> > +=09int res;
> > +
> > +=09res =3D fuse_send_reply_iov_nofree(req, error, iov, count);
> > +=09fuse_free_req(req);
> > +=09return res;
> > +}
> > +
> > +static int send_reply(fuse_req_t req, int error, const void *arg,
> > +=09=09      size_t argsize)
> > +{
> > +=09struct iovec iov[2];
> > +=09int count =3D 1;
> > +=09if (argsize) {
> > +=09=09iov[1].iov_base =3D (void *) arg;
> > +=09=09iov[1].iov_len =3D argsize;
> > +=09=09count++;
> > +=09}
> > +=09return send_reply_iov(req, error, iov, count);
> > +}
> > +
> > +int fuse_reply_iov(fuse_req_t req, const struct iovec *iov, int count)
> > +{
> > +=09int res;
> > +=09struct iovec *padded_iov;
> > +
> > +=09padded_iov =3D malloc((count + 1) * sizeof(struct iovec));
> > +=09if (padded_iov =3D=3D NULL)
> > +=09=09return fuse_reply_err(req, ENOMEM);
> > +
> > +=09memcpy(padded_iov + 1, iov, count * sizeof(struct iovec));
> > +=09count++;
> > +
> > +=09res =3D send_reply_iov(req, 0, padded_iov, count);
> > +=09free(padded_iov);
> > +
> > +=09return res;
> > +}
> > +
> > +
> > +/* `buf` is allowed to be empty so that the proper size may be
> > +   allocated by the caller */
> > +size_t fuse_add_direntry(fuse_req_t req, char *buf, size_t bufsize,
> > +=09=09=09 const char *name, const struct stat *stbuf, off_t off)
> > +{
> > +=09(void)req;
> > +=09size_t namelen;
> > +=09size_t entlen;
> > +=09size_t entlen_padded;
> > +=09struct fuse_dirent *dirent;
> > +
> > +=09namelen =3D strlen(name);
> > +=09entlen =3D FUSE_NAME_OFFSET + namelen;
> > +=09entlen_padded =3D FUSE_DIRENT_ALIGN(entlen);
> > +
> > +=09if ((buf =3D=3D NULL) || (entlen_padded > bufsize))
> > +=09  return entlen_padded;
> > +
> > +=09dirent =3D (struct fuse_dirent*) buf;
> > +=09dirent->ino =3D stbuf->st_ino;
> > +=09dirent->off =3D off;
> > +=09dirent->namelen =3D namelen;
> > +=09dirent->type =3D (stbuf->st_mode & S_IFMT) >> 12;
> > +=09memcpy(dirent->name, name, namelen);
> > +=09memset(dirent->name + namelen, 0, entlen_padded - entlen);
> > +
> > +=09return entlen_padded;
> > +}
> > +
> > +static void convert_statfs(const struct statvfs *stbuf,
> > +=09=09=09   struct fuse_kstatfs *kstatfs)
> > +{
> > +=09kstatfs->bsize=09 =3D stbuf->f_bsize;
> > +=09kstatfs->frsize=09 =3D stbuf->f_frsize;
> > +=09kstatfs->blocks=09 =3D stbuf->f_blocks;
> > +=09kstatfs->bfree=09 =3D stbuf->f_bfree;
> > +=09kstatfs->bavail=09 =3D stbuf->f_bavail;
> > +=09kstatfs->files=09 =3D stbuf->f_files;
> > +=09kstatfs->ffree=09 =3D stbuf->f_ffree;
> > +=09kstatfs->namelen =3D stbuf->f_namemax;
> > +}
> > +
> > +static int send_reply_ok(fuse_req_t req, const void *arg, size_t argsi=
ze)
> > +{
> > +=09return send_reply(req, 0, arg, argsize);
> > +}
> > +
> > +int fuse_reply_err(fuse_req_t req, int err)
> > +{
> > +=09return send_reply(req, -err, NULL, 0);
> > +}
> > +
> > +void fuse_reply_none(fuse_req_t req)
> > +{
> > +=09fuse_free_req(req);
> > +}
> > +
> > +static unsigned long calc_timeout_sec(double t)
> > +{
> > +=09if (t > (double) ULONG_MAX)
> > +=09=09return ULONG_MAX;
> > +=09else if (t < 0.0)
> > +=09=09return 0;
> > +=09else
> > +=09=09return (unsigned long) t;
> > +}
> > +
> > +static unsigned int calc_timeout_nsec(double t)
> > +{
> > +=09double f =3D t - (double) calc_timeout_sec(t);
> > +=09if (f < 0.0)
> > +=09=09return 0;
> > +=09else if (f >=3D 0.999999999)
> > +=09=09return 999999999;
> > +=09else
> > +=09=09return (unsigned int) (f * 1.0e9);
> > +}
> > +
> > +static void fill_entry(struct fuse_entry_out *arg,
> > +=09=09       const struct fuse_entry_param *e)
> > +{
> > +=09arg->nodeid =3D e->ino;
> > +=09arg->generation =3D e->generation;
> > +=09arg->entry_valid =3D calc_timeout_sec(e->entry_timeout);
> > +=09arg->entry_valid_nsec =3D calc_timeout_nsec(e->entry_timeout);
> > +=09arg->attr_valid =3D calc_timeout_sec(e->attr_timeout);
> > +=09arg->attr_valid_nsec =3D calc_timeout_nsec(e->attr_timeout);
> > +=09convert_stat(&e->attr, &arg->attr);
> > +}
> > +
> > +/* `buf` is allowed to be empty so that the proper size may be
> > +   allocated by the caller */
> > +size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsiz=
e,
> > +=09=09=09      const char *name,
> > +=09=09=09      const struct fuse_entry_param *e, off_t off)
> > +{
> > +=09(void)req;
> > +=09size_t namelen;
> > +=09size_t entlen;
> > +=09size_t entlen_padded;
> > +
> > +=09namelen =3D strlen(name);
> > +=09entlen =3D FUSE_NAME_OFFSET_DIRENTPLUS + namelen;
> > +=09entlen_padded =3D FUSE_DIRENT_ALIGN(entlen);
> > +=09if ((buf =3D=3D NULL) || (entlen_padded > bufsize))
> > +=09  return entlen_padded;
> > +
> > +=09struct fuse_direntplus *dp =3D (struct fuse_direntplus *) buf;
> > +=09memset(&dp->entry_out, 0, sizeof(dp->entry_out));
> > +=09fill_entry(&dp->entry_out, e);
> > +
> > +=09struct fuse_dirent *dirent =3D &dp->dirent;
> > +=09dirent->ino =3D e->attr.st_ino;
> > +=09dirent->off =3D off;
> > +=09dirent->namelen =3D namelen;
> > +=09dirent->type =3D (e->attr.st_mode & S_IFMT) >> 12;
> > +=09memcpy(dirent->name, name, namelen);
> > +=09memset(dirent->name + namelen, 0, entlen_padded - entlen);
> > +
> > +=09return entlen_padded;
> > +}
> > +
> > +static void fill_open(struct fuse_open_out *arg,
> > +=09=09      const struct fuse_file_info *f)
> > +{
> > +=09arg->fh =3D f->fh;
> > +=09if (f->direct_io)
> > +=09=09arg->open_flags |=3D FOPEN_DIRECT_IO;
> > +=09if (f->keep_cache)
> > +=09=09arg->open_flags |=3D FOPEN_KEEP_CACHE;
> > +=09if (f->cache_readdir)
> > +=09=09arg->open_flags |=3D FOPEN_CACHE_DIR;
> > +=09if (f->nonseekable)
> > +=09=09arg->open_flags |=3D FOPEN_NONSEEKABLE;
> > +}
> > +
> > +int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
> > +{
> > +=09struct fuse_entry_out arg;
> > +=09size_t size =3D req->se->conn.proto_minor < 9 ?
> > +=09=09FUSE_COMPAT_ENTRY_OUT_SIZE : sizeof(arg);
> > +
> > +=09/* before ABI 7.4 e->ino =3D=3D 0 was invalid, only ENOENT meant
> > +=09   negative entry */
> > +=09if (!e->ino && req->se->conn.proto_minor < 4)
> > +=09=09return fuse_reply_err(req, ENOENT);
> > +
> > +=09memset(&arg, 0, sizeof(arg));
> > +=09fill_entry(&arg, e);
> > +=09return send_reply_ok(req, &arg, size);
> > +}
> > +
> > +int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e=
,
> > +=09=09      const struct fuse_file_info *f)
> > +{
> > +=09char buf[sizeof(struct fuse_entry_out) + sizeof(struct fuse_open_ou=
t)];
> > +=09size_t entrysize =3D req->se->conn.proto_minor < 9 ?
> > +=09=09FUSE_COMPAT_ENTRY_OUT_SIZE : sizeof(struct fuse_entry_out);
> > +=09struct fuse_entry_out *earg =3D (struct fuse_entry_out *) buf;
> > +=09struct fuse_open_out *oarg =3D (struct fuse_open_out *) (buf + entr=
ysize);
> > +
> > +=09memset(buf, 0, sizeof(buf));
> > +=09fill_entry(earg, e);
> > +=09fill_open(oarg, f);
> > +=09return send_reply_ok(req, buf,
> > +=09=09=09     entrysize + sizeof(struct fuse_open_out));
> > +}
> > +
> > +int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
> > +=09=09    double attr_timeout)
> > +{
> > +=09struct fuse_attr_out arg;
> > +=09size_t size =3D req->se->conn.proto_minor < 9 ?
> > +=09=09FUSE_COMPAT_ATTR_OUT_SIZE : sizeof(arg);
> > +
> > +=09memset(&arg, 0, sizeof(arg));
> > +=09arg.attr_valid =3D calc_timeout_sec(attr_timeout);
> > +=09arg.attr_valid_nsec =3D calc_timeout_nsec(attr_timeout);
> > +=09convert_stat(attr, &arg.attr);
> > +
> > +=09return send_reply_ok(req, &arg, size);
> > +}
> > +
> > +int fuse_reply_readlink(fuse_req_t req, const char *linkname)
> > +{
> > +=09return send_reply_ok(req, linkname, strlen(linkname));
> > +}
> > +
> > +int fuse_reply_open(fuse_req_t req, const struct fuse_file_info *f)
> > +{
> > +=09struct fuse_open_out arg;
> > +
> > +=09memset(&arg, 0, sizeof(arg));
> > +=09fill_open(&arg, f);
> > +=09return send_reply_ok(req, &arg, sizeof(arg));
> > +}
> > +
> > +int fuse_reply_write(fuse_req_t req, size_t count)
> > +{
> > +=09struct fuse_write_out arg;
> > +
> > +=09memset(&arg, 0, sizeof(arg));
> > +=09arg.size =3D count;
> > +
> > +=09return send_reply_ok(req, &arg, sizeof(arg));
> > +}
> > +
> > +int fuse_reply_buf(fuse_req_t req, const char *buf, size_t size)
> > +{
> > +=09return send_reply_ok(req, buf, size);
> > +}
> > +
> > +static int fuse_send_data_iov_fallback(struct fuse_session *se,
> > +=09=09=09=09       struct fuse_chan *ch,
> > +=09=09=09=09       struct iovec *iov, int iov_count,
> > +=09=09=09=09       struct fuse_bufvec *buf,
> > +=09=09=09=09       size_t len)
> > +{
> > +=09struct fuse_bufvec mem_buf =3D FUSE_BUFVEC_INIT(len);
> > +=09void *mbuf;
> > +=09int res;
> > +
> > +=09/* Optimize common case */
> > +=09if (buf->count =3D=3D 1 && buf->idx =3D=3D 0 && buf->off =3D=3D 0 &=
&
> > +=09    !(buf->buf[0].flags & FUSE_BUF_IS_FD)) {
> > +=09=09/* FIXME: also avoid memory copy if there are multiple buffers
> > +=09=09   but none of them contain an fd */
> > +
> > +=09=09iov[iov_count].iov_base =3D buf->buf[0].mem;
> > +=09=09iov[iov_count].iov_len =3D len;
> > +=09=09iov_count++;
> > +=09=09return fuse_send_msg(se, ch, iov, iov_count);
> > +=09}
> > +
> > +=09res =3D posix_memalign(&mbuf, pagesize, len);
> > +=09if (res !=3D 0)
> > +=09=09return res;
> > +
> > +=09mem_buf.buf[0].mem =3D mbuf;
> > +=09res =3D fuse_buf_copy(&mem_buf, buf, 0);
> > +=09if (res < 0) {
> > +=09=09free(mbuf);
> > +=09=09return -res;
> > +=09}
> > +=09len =3D res;
> > +
> > +=09iov[iov_count].iov_base =3D mbuf;
> > +=09iov[iov_count].iov_len =3D len;
> > +=09iov_count++;
> > +=09res =3D fuse_send_msg(se, ch, iov, iov_count);
> > +=09free(mbuf);
> > +
> > +=09return res;
> > +}
> > +
> > +struct fuse_ll_pipe {
> > +=09size_t size;
> > +=09int can_grow;
> > +=09int pipe[2];
> > +};
> > +
> > +static void fuse_ll_pipe_free(struct fuse_ll_pipe *llp)
> > +{
> > +=09close(llp->pipe[0]);
> > +=09close(llp->pipe[1]);
> > +=09free(llp);
> > +}
> > +
> > +#ifdef HAVE_SPLICE
> > +#if !defined(HAVE_PIPE2) || !defined(O_CLOEXEC)
> > +static int fuse_pipe(int fds[2])
> > +{
> > +=09int rv =3D pipe(fds);
> > +
> > +=09if (rv =3D=3D -1)
> > +=09=09return rv;
> > +
> > +=09if (fcntl(fds[0], F_SETFL, O_NONBLOCK) =3D=3D -1 ||
> > +=09    fcntl(fds[1], F_SETFL, O_NONBLOCK) =3D=3D -1 ||
> > +=09    fcntl(fds[0], F_SETFD, FD_CLOEXEC) =3D=3D -1 ||
> > +=09    fcntl(fds[1], F_SETFD, FD_CLOEXEC) =3D=3D -1) {
> > +=09=09close(fds[0]);
> > +=09=09close(fds[1]);
> > +=09=09rv =3D -1;
> > +=09}
> > +=09return rv;
> > +}
> > +#else
> > +static int fuse_pipe(int fds[2])
> > +{
> > +=09return pipe2(fds, O_CLOEXEC | O_NONBLOCK);
> > +}
> > +#endif
> > +
> > +static struct fuse_ll_pipe *fuse_ll_get_pipe(struct fuse_session *se)
> > +{
> > +=09struct fuse_ll_pipe *llp =3D pthread_getspecific(se->pipe_key);
> > +=09if (llp =3D=3D NULL) {
> > +=09=09int res;
> > +
> > +=09=09llp =3D malloc(sizeof(struct fuse_ll_pipe));
> > +=09=09if (llp =3D=3D NULL)
> > +=09=09=09return NULL;
> > +
> > +=09=09res =3D fuse_pipe(llp->pipe);
> > +=09=09if (res =3D=3D -1) {
> > +=09=09=09free(llp);
> > +=09=09=09return NULL;
> > +=09=09}
> > +
> > +=09=09/*
> > +=09=09 *the default size is 16 pages on linux
> > +=09=09 */
> > +=09=09llp->size =3D pagesize * 16;
> > +=09=09llp->can_grow =3D 1;
> > +
> > +=09=09pthread_setspecific(se->pipe_key, llp);
> > +=09}
> > +
> > +=09return llp;
> > +}
> > +#endif
> > +
> > +static void fuse_ll_clear_pipe(struct fuse_session *se)
> > +{
> > +=09struct fuse_ll_pipe *llp =3D pthread_getspecific(se->pipe_key);
> > +=09if (llp) {
> > +=09=09pthread_setspecific(se->pipe_key, NULL);
> > +=09=09fuse_ll_pipe_free(llp);
> > +=09}
> > +}
> > +
> > +#if defined(HAVE_SPLICE) && defined(HAVE_VMSPLICE)
> > +static int read_back(int fd, char *buf, size_t len)
> > +{
> > +=09int res;
> > +
> > +=09res =3D read(fd, buf, len);
> > +=09if (res =3D=3D -1) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: internal error: failed to read bac=
k from pipe: %s\n", strerror(errno));
> > +=09=09return -EIO;
> > +=09}
> > +=09if (res !=3D len) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: internal error: short read back fr=
om pipe: %i from %zi\n", res, len);
> > +=09=09return -EIO;
> > +=09}
> > +=09return 0;
> > +}
> > +
> > +static int grow_pipe_to_max(int pipefd)
> > +{
> > +=09int max;
> > +=09int res;
> > +=09int maxfd;
> > +=09char buf[32];
> > +
> > +=09maxfd =3D open("/proc/sys/fs/pipe-max-size", O_RDONLY);
> > +=09if (maxfd < 0)
> > +=09=09return -errno;
> > +
> > +=09res =3D read(maxfd, buf, sizeof(buf) - 1);
> > +=09if (res < 0) {
> > +=09=09int saved_errno;
> > +
> > +=09=09saved_errno =3D errno;
> > +=09=09close(maxfd);
> > +=09=09return -saved_errno;
> > +=09}
> > +=09close(maxfd);
> > +=09buf[res] =3D '\0';
> > +
> > +=09max =3D atoi(buf);
> > +=09res =3D fcntl(pipefd, F_SETPIPE_SZ, max);
> > +=09if (res < 0)
> > +=09=09return -errno;
> > +=09return max;
> > +}
> > +
> > +static int fuse_send_data_iov(struct fuse_session *se, struct fuse_cha=
n *ch,
> > +=09=09=09       struct iovec *iov, int iov_count,
> > +=09=09=09       struct fuse_bufvec *buf, unsigned int flags)
> > +{
> > +=09int res;
> > +=09size_t len =3D fuse_buf_size(buf);
> > +=09struct fuse_out_header *out =3D iov[0].iov_base;
> > +=09struct fuse_ll_pipe *llp;
> > +=09int splice_flags;
> > +=09size_t pipesize;
> > +=09size_t total_fd_size;
> > +=09size_t idx;
> > +=09size_t headerlen;
> > +=09struct fuse_bufvec pipe_buf =3D FUSE_BUFVEC_INIT(len);
> > +
> > +=09if (se->broken_splice_nonblock)
> > +=09=09goto fallback;
> > +
> > +=09if (flags & FUSE_BUF_NO_SPLICE)
> > +=09=09goto fallback;
> > +
> > +=09total_fd_size =3D 0;
> > +=09for (idx =3D buf->idx; idx < buf->count; idx++) {
> > +=09=09if (buf->buf[idx].flags & FUSE_BUF_IS_FD) {
> > +=09=09=09total_fd_size =3D buf->buf[idx].size;
> > +=09=09=09if (idx =3D=3D buf->idx)
> > +=09=09=09=09total_fd_size -=3D buf->off;
> > +=09=09}
> > +=09}
> > +=09if (total_fd_size < 2 * pagesize)
> > +=09=09goto fallback;
> > +
> > +=09if (se->conn.proto_minor < 14 ||
> > +=09    !(se->conn.want & FUSE_CAP_SPLICE_WRITE))
> > +=09=09goto fallback;
> > +
> > +=09llp =3D fuse_ll_get_pipe(se);
> > +=09if (llp =3D=3D NULL)
> > +=09=09goto fallback;
> > +
> > +
> > +=09headerlen =3D iov_length(iov, iov_count);
> > +
> > +=09out->len =3D headerlen + len;
> > +
> > +=09/*
> > +=09 * Heuristic for the required pipe size, does not work if the
> > +=09 * source contains less than page size fragments
> > +=09 */
> > +=09pipesize =3D pagesize * (iov_count + buf->count + 1) + out->len;
> > +
> > +=09if (llp->size < pipesize) {
> > +=09=09if (llp->can_grow) {
> > +=09=09=09res =3D fcntl(llp->pipe[0], F_SETPIPE_SZ, pipesize);
> > +=09=09=09if (res =3D=3D -1) {
> > +=09=09=09=09res =3D grow_pipe_to_max(llp->pipe[0]);
> > +=09=09=09=09if (res > 0)
> > +=09=09=09=09=09llp->size =3D res;
> > +=09=09=09=09llp->can_grow =3D 0;
> > +=09=09=09=09goto fallback;
> > +=09=09=09}
> > +=09=09=09llp->size =3D res;
> > +=09=09}
> > +=09=09if (llp->size < pipesize)
> > +=09=09=09goto fallback;
> > +=09}
> > +
> > +
> > +=09res =3D vmsplice(llp->pipe[1], iov, iov_count, SPLICE_F_NONBLOCK);
> > +=09if (res =3D=3D -1)
> > +=09=09goto fallback;
> > +
> > +=09if (res !=3D headerlen) {
> > +=09=09res =3D -EIO;
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: short vmsplice to pipe: %u/%zu\n",=
 res,
> > +=09=09=09headerlen);
> > +=09=09goto clear_pipe;
> > +=09}
> > +
> > +=09pipe_buf.buf[0].flags =3D FUSE_BUF_IS_FD;
> > +=09pipe_buf.buf[0].fd =3D llp->pipe[1];
> > +
> > +=09res =3D fuse_buf_copy(&pipe_buf, buf,
> > +=09=09=09    FUSE_BUF_FORCE_SPLICE | FUSE_BUF_SPLICE_NONBLOCK);
> > +=09if (res < 0) {
> > +=09=09if (res =3D=3D -EAGAIN || res =3D=3D -EINVAL) {
> > +=09=09=09/*
> > +=09=09=09 * Should only get EAGAIN on kernels with
> > +=09=09=09 * broken SPLICE_F_NONBLOCK support (<=3D
> > +=09=09=09 * 2.6.35) where this error or a short read is
> > +=09=09=09 * returned even if the pipe itself is not
> > +=09=09=09 * full
> > +=09=09=09 *
> > +=09=09=09 * EINVAL might mean that splice can't handle
> > +=09=09=09 * this combination of input and output.
> > +=09=09=09 */
> > +=09=09=09if (res =3D=3D -EAGAIN)
> > +=09=09=09=09se->broken_splice_nonblock =3D 1;
> > +
> > +=09=09=09pthread_setspecific(se->pipe_key, NULL);
> > +=09=09=09fuse_ll_pipe_free(llp);
> > +=09=09=09goto fallback;
> > +=09=09}
> > +=09=09res =3D -res;
> > +=09=09goto clear_pipe;
> > +=09}
> > +
> > +=09if (res !=3D 0 && res < len) {
> > +=09=09struct fuse_bufvec mem_buf =3D FUSE_BUFVEC_INIT(len);
> > +=09=09void *mbuf;
> > +=09=09size_t now_len =3D res;
> > +=09=09/*
> > +=09=09 * For regular files a short count is either
> > +=09=09 *  1) due to EOF, or
> > +=09=09 *  2) because of broken SPLICE_F_NONBLOCK (see above)
> > +=09=09 *
> > +=09=09 * For other inputs it's possible that we overflowed
> > +=09=09 * the pipe because of small buffer fragments.
> > +=09=09 */
> > +
> > +=09=09res =3D posix_memalign(&mbuf, pagesize, len);
> > +=09=09if (res !=3D 0)
> > +=09=09=09goto clear_pipe;
> > +
> > +=09=09mem_buf.buf[0].mem =3D mbuf;
> > +=09=09mem_buf.off =3D now_len;
> > +=09=09res =3D fuse_buf_copy(&mem_buf, buf, 0);
> > +=09=09if (res > 0) {
> > +=09=09=09char *tmpbuf;
> > +=09=09=09size_t extra_len =3D res;
> > +=09=09=09/*
> > +=09=09=09 * Trickiest case: got more data.  Need to get
> > +=09=09=09 * back the data from the pipe and then fall
> > +=09=09=09 * back to regular write.
> > +=09=09=09 */
> > +=09=09=09tmpbuf =3D malloc(headerlen);
> > +=09=09=09if (tmpbuf =3D=3D NULL) {
> > +=09=09=09=09free(mbuf);
> > +=09=09=09=09res =3D ENOMEM;
> > +=09=09=09=09goto clear_pipe;
> > +=09=09=09}
> > +=09=09=09res =3D read_back(llp->pipe[0], tmpbuf, headerlen);
> > +=09=09=09free(tmpbuf);
> > +=09=09=09if (res !=3D 0) {
> > +=09=09=09=09free(mbuf);
> > +=09=09=09=09goto clear_pipe;
> > +=09=09=09}
> > +=09=09=09res =3D read_back(llp->pipe[0], mbuf, now_len);
> > +=09=09=09if (res !=3D 0) {
> > +=09=09=09=09free(mbuf);
> > +=09=09=09=09goto clear_pipe;
> > +=09=09=09}
> > +=09=09=09len =3D now_len + extra_len;
> > +=09=09=09iov[iov_count].iov_base =3D mbuf;
> > +=09=09=09iov[iov_count].iov_len =3D len;
> > +=09=09=09iov_count++;
> > +=09=09=09res =3D fuse_send_msg(se, ch, iov, iov_count);
> > +=09=09=09free(mbuf);
> > +=09=09=09return res;
> > +=09=09}
> > +=09=09free(mbuf);
> > +=09=09res =3D now_len;
> > +=09}
> > +=09len =3D res;
> > +=09out->len =3D headerlen + len;
> > +
> > +=09if (se->debug) {
> > +=09=09fuse_log(FUSE_LOG_DEBUG,
> > +=09=09=09"   unique: %llu, success, outsize: %i (splice)\n",
> > +=09=09=09(unsigned long long) out->unique, out->len);
> > +=09}
> > +
> > +=09splice_flags =3D 0;
> > +=09if ((flags & FUSE_BUF_SPLICE_MOVE) &&
> > +=09    (se->conn.want & FUSE_CAP_SPLICE_MOVE))
> > +=09=09splice_flags |=3D SPLICE_F_MOVE;
> > +
> > +=09res =3D splice(llp->pipe[0], NULL, ch ? ch->fd : se->fd,
> > +=09=09     NULL, out->len, splice_flags);
> > +=09if (res =3D=3D -1) {
> > +=09=09res =3D -errno;
> > +=09=09perror("fuse: splice from pipe");
> > +=09=09goto clear_pipe;
> > +=09}
> > +=09if (res !=3D out->len) {
> > +=09=09res =3D -EIO;
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: short splice from pipe: %u/%u\n",
> > +=09=09=09res, out->len);
> > +=09=09goto clear_pipe;
> > +=09}
> > +=09return 0;
> > +
> > +clear_pipe:
> > +=09fuse_ll_clear_pipe(se);
> > +=09return res;
> > +
> > +fallback:
> > +=09return fuse_send_data_iov_fallback(se, ch, iov, iov_count, buf, len=
);
> > +}
> > +#else
> > +static int fuse_send_data_iov(struct fuse_session *se, struct fuse_cha=
n *ch,
> > +=09=09=09       struct iovec *iov, int iov_count,
> > +=09=09=09       struct fuse_bufvec *buf, unsigned int flags)
> > +{
> > +=09size_t len =3D fuse_buf_size(buf);
> > +=09(void) flags;
> > +
> > +=09return fuse_send_data_iov_fallback(se, ch, iov, iov_count, buf, len=
);
> > +}
> > +#endif
> > +
> > +int fuse_reply_data(fuse_req_t req, struct fuse_bufvec *bufv,
> > +=09=09    enum fuse_buf_copy_flags flags)
> > +{
> > +=09struct iovec iov[2];
> > +=09struct fuse_out_header out;
> > +=09int res;
> > +
> > +=09iov[0].iov_base =3D &out;
> > +=09iov[0].iov_len =3D sizeof(struct fuse_out_header);
> > +
> > +=09out.unique =3D req->unique;
> > +=09out.error =3D 0;
> > +
> > +=09res =3D fuse_send_data_iov(req->se, req->ch, iov, 1, bufv, flags);
> > +=09if (res <=3D 0) {
> > +=09=09fuse_free_req(req);
> > +=09=09return res;
> > +=09} else {
> > +=09=09return fuse_reply_err(req, res);
> > +=09}
> > +}
> > +
> > +int fuse_reply_statfs(fuse_req_t req, const struct statvfs *stbuf)
> > +{
> > +=09struct fuse_statfs_out arg;
> > +=09size_t size =3D req->se->conn.proto_minor < 4 ?
> > +=09=09FUSE_COMPAT_STATFS_SIZE : sizeof(arg);
> > +
> > +=09memset(&arg, 0, sizeof(arg));
> > +=09convert_statfs(stbuf, &arg.st);
> > +
> > +=09return send_reply_ok(req, &arg, size);
> > +}
> > +
> > +int fuse_reply_xattr(fuse_req_t req, size_t count)
> > +{
> > +=09struct fuse_getxattr_out arg;
> > +
> > +=09memset(&arg, 0, sizeof(arg));
> > +=09arg.size =3D count;
> > +
> > +=09return send_reply_ok(req, &arg, sizeof(arg));
> > +}
> > +
> > +int fuse_reply_lock(fuse_req_t req, const struct flock *lock)
> > +{
> > +=09struct fuse_lk_out arg;
> > +
> > +=09memset(&arg, 0, sizeof(arg));
> > +=09arg.lk.type =3D lock->l_type;
> > +=09if (lock->l_type !=3D F_UNLCK) {
> > +=09=09arg.lk.start =3D lock->l_start;
> > +=09=09if (lock->l_len =3D=3D 0)
> > +=09=09=09arg.lk.end =3D OFFSET_MAX;
> > +=09=09else
> > +=09=09=09arg.lk.end =3D lock->l_start + lock->l_len - 1;
> > +=09}
> > +=09arg.lk.pid =3D lock->l_pid;
> > +=09return send_reply_ok(req, &arg, sizeof(arg));
> > +}
> > +
> > +int fuse_reply_bmap(fuse_req_t req, uint64_t idx)
> > +{
> > +=09struct fuse_bmap_out arg;
> > +
> > +=09memset(&arg, 0, sizeof(arg));
> > +=09arg.block =3D idx;
> > +
> > +=09return send_reply_ok(req, &arg, sizeof(arg));
> > +}
> > +
> > +static struct fuse_ioctl_iovec *fuse_ioctl_iovec_copy(const struct iov=
ec *iov,
> > +=09=09=09=09=09=09      size_t count)
> > +{
> > +=09struct fuse_ioctl_iovec *fiov;
> > +=09size_t i;
> > +
> > +=09fiov =3D malloc(sizeof(fiov[0]) * count);
> > +=09if (!fiov)
> > +=09=09return NULL;
> > +
> > +=09for (i =3D 0; i < count; i++) {
> > +=09=09fiov[i].base =3D (uintptr_t) iov[i].iov_base;
> > +=09=09fiov[i].len =3D iov[i].iov_len;
> > +=09}
> > +
> > +=09return fiov;
> > +}
> > +
> > +int fuse_reply_ioctl_retry(fuse_req_t req,
> > +=09=09=09   const struct iovec *in_iov, size_t in_count,
> > +=09=09=09   const struct iovec *out_iov, size_t out_count)
> > +{
> > +=09struct fuse_ioctl_out arg;
> > +=09struct fuse_ioctl_iovec *in_fiov =3D NULL;
> > +=09struct fuse_ioctl_iovec *out_fiov =3D NULL;
> > +=09struct iovec iov[4];
> > +=09size_t count =3D 1;
> > +=09int res;
> > +
> > +=09memset(&arg, 0, sizeof(arg));
> > +=09arg.flags |=3D FUSE_IOCTL_RETRY;
> > +=09arg.in_iovs =3D in_count;
> > +=09arg.out_iovs =3D out_count;
> > +=09iov[count].iov_base =3D &arg;
> > +=09iov[count].iov_len =3D sizeof(arg);
> > +=09count++;
> > +
> > +=09if (req->se->conn.proto_minor < 16) {
> > +=09=09if (in_count) {
> > +=09=09=09iov[count].iov_base =3D (void *)in_iov;
> > +=09=09=09iov[count].iov_len =3D sizeof(in_iov[0]) * in_count;
> > +=09=09=09count++;
> > +=09=09}
> > +
> > +=09=09if (out_count) {
> > +=09=09=09iov[count].iov_base =3D (void *)out_iov;
> > +=09=09=09iov[count].iov_len =3D sizeof(out_iov[0]) * out_count;
> > +=09=09=09count++;
> > +=09=09}
> > +=09} else {
> > +=09=09/* Can't handle non-compat 64bit ioctls on 32bit */
> > +=09=09if (sizeof(void *) =3D=3D 4 && req->ioctl_64bit) {
> > +=09=09=09res =3D fuse_reply_err(req, EINVAL);
> > +=09=09=09goto out;
> > +=09=09}
> > +
> > +=09=09if (in_count) {
> > +=09=09=09in_fiov =3D fuse_ioctl_iovec_copy(in_iov, in_count);
> > +=09=09=09if (!in_fiov)
> > +=09=09=09=09goto enomem;
> > +
> > +=09=09=09iov[count].iov_base =3D (void *)in_fiov;
> > +=09=09=09iov[count].iov_len =3D sizeof(in_fiov[0]) * in_count;
> > +=09=09=09count++;
> > +=09=09}
> > +=09=09if (out_count) {
> > +=09=09=09out_fiov =3D fuse_ioctl_iovec_copy(out_iov, out_count);
> > +=09=09=09if (!out_fiov)
> > +=09=09=09=09goto enomem;
> > +
> > +=09=09=09iov[count].iov_base =3D (void *)out_fiov;
> > +=09=09=09iov[count].iov_len =3D sizeof(out_fiov[0]) * out_count;
> > +=09=09=09count++;
> > +=09=09}
> > +=09}
> > +
> > +=09res =3D send_reply_iov(req, 0, iov, count);
> > +out:
> > +=09free(in_fiov);
> > +=09free(out_fiov);
> > +
> > +=09return res;
> > +
> > +enomem:
> > +=09res =3D fuse_reply_err(req, ENOMEM);
> > +=09goto out;
> > +}
> > +
> > +int fuse_reply_ioctl(fuse_req_t req, int result, const void *buf, size=
_t size)
> > +{
> > +=09struct fuse_ioctl_out arg;
> > +=09struct iovec iov[3];
> > +=09size_t count =3D 1;
> > +
> > +=09memset(&arg, 0, sizeof(arg));
> > +=09arg.result =3D result;
> > +=09iov[count].iov_base =3D &arg;
> > +=09iov[count].iov_len =3D sizeof(arg);
> > +=09count++;
> > +
> > +=09if (size) {
> > +=09=09iov[count].iov_base =3D (char *) buf;
> > +=09=09iov[count].iov_len =3D size;
> > +=09=09count++;
> > +=09}
> > +
> > +=09return send_reply_iov(req, 0, iov, count);
> > +}
> > +
> > +int fuse_reply_ioctl_iov(fuse_req_t req, int result, const struct iove=
c *iov,
> > +=09=09=09 int count)
> > +{
> > +=09struct iovec *padded_iov;
> > +=09struct fuse_ioctl_out arg;
> > +=09int res;
> > +
> > +=09padded_iov =3D malloc((count + 2) * sizeof(struct iovec));
> > +=09if (padded_iov =3D=3D NULL)
> > +=09=09return fuse_reply_err(req, ENOMEM);
> > +
> > +=09memset(&arg, 0, sizeof(arg));
> > +=09arg.result =3D result;
> > +=09padded_iov[1].iov_base =3D &arg;
> > +=09padded_iov[1].iov_len =3D sizeof(arg);
> > +
> > +=09memcpy(&padded_iov[2], iov, count * sizeof(struct iovec));
> > +
> > +=09res =3D send_reply_iov(req, 0, padded_iov, count + 2);
> > +=09free(padded_iov);
> > +
> > +=09return res;
> > +}
> > +
> > +int fuse_reply_poll(fuse_req_t req, unsigned revents)
> > +{
> > +=09struct fuse_poll_out arg;
> > +
> > +=09memset(&arg, 0, sizeof(arg));
> > +=09arg.revents =3D revents;
> > +
> > +=09return send_reply_ok(req, &arg, sizeof(arg));
> > +}
> > +
> > +static void do_lookup(fuse_req_t req, fuse_ino_t nodeid, const void *i=
narg)
> > +{
> > +=09char *name =3D (char *) inarg;
> > +
> > +=09if (req->se->op.lookup)
> > +=09=09req->se->op.lookup(req, nodeid, name);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_forget(fuse_req_t req, fuse_ino_t nodeid, const void *i=
narg)
> > +{
> > +=09struct fuse_forget_in *arg =3D (struct fuse_forget_in *) inarg;
> > +
> > +=09if (req->se->op.forget)
> > +=09=09req->se->op.forget(req, nodeid, arg->nlookup);
> > +=09else
> > +=09=09fuse_reply_none(req);
> > +}
> > +
> > +static void do_batch_forget(fuse_req_t req, fuse_ino_t nodeid,
> > +=09=09=09    const void *inarg)
> > +{
> > +=09struct fuse_batch_forget_in *arg =3D (void *) inarg;
> > +=09struct fuse_forget_one *param =3D (void *) PARAM(arg);
> > +=09unsigned int i;
> > +
> > +=09(void) nodeid;
> > +
> > +=09if (req->se->op.forget_multi) {
> > +=09=09req->se->op.forget_multi(req, arg->count,
> > +=09=09=09=09     (struct fuse_forget_data *) param);
> > +=09} else if (req->se->op.forget) {
> > +=09=09for (i =3D 0; i < arg->count; i++) {
> > +=09=09=09struct fuse_forget_one *forget =3D &param[i];
> > +=09=09=09struct fuse_req *dummy_req;
> > +
> > +=09=09=09dummy_req =3D fuse_ll_alloc_req(req->se);
> > +=09=09=09if (dummy_req =3D=3D NULL)
> > +=09=09=09=09break;
> > +
> > +=09=09=09dummy_req->unique =3D req->unique;
> > +=09=09=09dummy_req->ctx =3D req->ctx;
> > +=09=09=09dummy_req->ch =3D NULL;
> > +
> > +=09=09=09req->se->op.forget(dummy_req, forget->nodeid,
> > +=09=09=09=09=09  forget->nlookup);
> > +=09=09}
> > +=09=09fuse_reply_none(req);
> > +=09} else {
> > +=09=09fuse_reply_none(req);
> > +=09}
> > +}
> > +
> > +static void do_getattr(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
> > +{
> > +=09struct fuse_file_info *fip =3D NULL;
> > +=09struct fuse_file_info fi;
> > +
> > +=09if (req->se->conn.proto_minor >=3D 9) {
> > +=09=09struct fuse_getattr_in *arg =3D (struct fuse_getattr_in *) inarg=
;
> > +
> > +=09=09if (arg->getattr_flags & FUSE_GETATTR_FH) {
> > +=09=09=09memset(&fi, 0, sizeof(fi));
> > +=09=09=09fi.fh =3D arg->fh;
> > +=09=09=09fip =3D &fi;
> > +=09=09}
> > +=09}
> > +
> > +=09if (req->se->op.getattr)
> > +=09=09req->se->op.getattr(req, nodeid, fip);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_setattr(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
> > +{
> > +=09struct fuse_setattr_in *arg =3D (struct fuse_setattr_in *) inarg;
> > +
> > +=09if (req->se->op.setattr) {
> > +=09=09struct fuse_file_info *fi =3D NULL;
> > +=09=09struct fuse_file_info fi_store;
> > +=09=09struct stat stbuf;
> > +=09=09memset(&stbuf, 0, sizeof(stbuf));
> > +=09=09convert_attr(arg, &stbuf);
> > +=09=09if (arg->valid & FATTR_FH) {
> > +=09=09=09arg->valid &=3D ~FATTR_FH;
> > +=09=09=09memset(&fi_store, 0, sizeof(fi_store));
> > +=09=09=09fi =3D &fi_store;
> > +=09=09=09fi->fh =3D arg->fh;
> > +=09=09}
> > +=09=09arg->valid &=3D
> > +=09=09=09FUSE_SET_ATTR_MODE=09|
> > +=09=09=09FUSE_SET_ATTR_UID=09|
> > +=09=09=09FUSE_SET_ATTR_GID=09|
> > +=09=09=09FUSE_SET_ATTR_SIZE=09|
> > +=09=09=09FUSE_SET_ATTR_ATIME=09|
> > +=09=09=09FUSE_SET_ATTR_MTIME=09|
> > +=09=09=09FUSE_SET_ATTR_ATIME_NOW=09|
> > +=09=09=09FUSE_SET_ATTR_MTIME_NOW |
> > +=09=09=09FUSE_SET_ATTR_CTIME;
> > +
> > +=09=09req->se->op.setattr(req, nodeid, &stbuf, arg->valid, fi);
> > +=09} else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_access(fuse_req_t req, fuse_ino_t nodeid, const void *i=
narg)
> > +{
> > +=09struct fuse_access_in *arg =3D (struct fuse_access_in *) inarg;
> > +
> > +=09if (req->se->op.access)
> > +=09=09req->se->op.access(req, nodeid, arg->mask);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_readlink(fuse_req_t req, fuse_ino_t nodeid, const void =
*inarg)
> > +{
> > +=09(void) inarg;
> > +
> > +=09if (req->se->op.readlink)
> > +=09=09req->se->op.readlink(req, nodeid);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_mknod(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
> > +{
> > +=09struct fuse_mknod_in *arg =3D (struct fuse_mknod_in *) inarg;
> > +=09char *name =3D PARAM(arg);
> > +
> > +=09if (req->se->conn.proto_minor >=3D 12)
> > +=09=09req->ctx.umask =3D arg->umask;
> > +=09else
> > +=09=09name =3D (char *) inarg + FUSE_COMPAT_MKNOD_IN_SIZE;
> > +
> > +=09if (req->se->op.mknod)
> > +=09=09req->se->op.mknod(req, nodeid, name, arg->mode, arg->rdev);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_mkdir(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
> > +{
> > +=09struct fuse_mkdir_in *arg =3D (struct fuse_mkdir_in *) inarg;
> > +
> > +=09if (req->se->conn.proto_minor >=3D 12)
> > +=09=09req->ctx.umask =3D arg->umask;
> > +
> > +=09if (req->se->op.mkdir)
> > +=09=09req->se->op.mkdir(req, nodeid, PARAM(arg), arg->mode);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_unlink(fuse_req_t req, fuse_ino_t nodeid, const void *i=
narg)
> > +{
> > +=09char *name =3D (char *) inarg;
> > +
> > +=09if (req->se->op.unlink)
> > +=09=09req->se->op.unlink(req, nodeid, name);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_rmdir(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
> > +{
> > +=09char *name =3D (char *) inarg;
> > +
> > +=09if (req->se->op.rmdir)
> > +=09=09req->se->op.rmdir(req, nodeid, name);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_symlink(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
> > +{
> > +=09char *name =3D (char *) inarg;
> > +=09char *linkname =3D ((char *) inarg) + strlen((char *) inarg) + 1;
> > +
> > +=09if (req->se->op.symlink)
> > +=09=09req->se->op.symlink(req, linkname, nodeid, name);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_rename(fuse_req_t req, fuse_ino_t nodeid, const void *i=
narg)
> > +{
> > +=09struct fuse_rename_in *arg =3D (struct fuse_rename_in *) inarg;
> > +=09char *oldname =3D PARAM(arg);
> > +=09char *newname =3D oldname + strlen(oldname) + 1;
> > +
> > +=09if (req->se->op.rename)
> > +=09=09req->se->op.rename(req, nodeid, oldname, arg->newdir, newname,
> > +=09=09=09=09  0);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_rename2(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
> > +{
> > +=09struct fuse_rename2_in *arg =3D (struct fuse_rename2_in *) inarg;
> > +=09char *oldname =3D PARAM(arg);
> > +=09char *newname =3D oldname + strlen(oldname) + 1;
> > +
> > +=09if (req->se->op.rename)
> > +=09=09req->se->op.rename(req, nodeid, oldname, arg->newdir, newname,
> > +=09=09=09=09  arg->flags);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_link(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
> > +{
> > +=09struct fuse_link_in *arg =3D (struct fuse_link_in *) inarg;
> > +
> > +=09if (req->se->op.link)
> > +=09=09req->se->op.link(req, arg->oldnodeid, nodeid, PARAM(arg));
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_create(fuse_req_t req, fuse_ino_t nodeid, const void *i=
narg)
> > +{
> > +=09struct fuse_create_in *arg =3D (struct fuse_create_in *) inarg;
> > +
> > +=09if (req->se->op.create) {
> > +=09=09struct fuse_file_info fi;
> > +=09=09char *name =3D PARAM(arg);
> > +
> > +=09=09memset(&fi, 0, sizeof(fi));
> > +=09=09fi.flags =3D arg->flags;
> > +
> > +=09=09if (req->se->conn.proto_minor >=3D 12)
> > +=09=09=09req->ctx.umask =3D arg->umask;
> > +=09=09else
> > +=09=09=09name =3D (char *) inarg + sizeof(struct fuse_open_in);
> > +
> > +=09=09req->se->op.create(req, nodeid, name, arg->mode, &fi);
> > +=09} else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_open(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
> > +{
> > +=09struct fuse_open_in *arg =3D (struct fuse_open_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.flags =3D arg->flags;
> > +
> > +=09if (req->se->op.open)
> > +=09=09req->se->op.open(req, nodeid, &fi);
> > +=09else
> > +=09=09fuse_reply_open(req, &fi);
> > +}
> > +
> > +static void do_read(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
> > +{
> > +=09struct fuse_read_in *arg =3D (struct fuse_read_in *) inarg;
> > +
> > +=09if (req->se->op.read) {
> > +=09=09struct fuse_file_info fi;
> > +
> > +=09=09memset(&fi, 0, sizeof(fi));
> > +=09=09fi.fh =3D arg->fh;
> > +=09=09if (req->se->conn.proto_minor >=3D 9) {
> > +=09=09=09fi.lock_owner =3D arg->lock_owner;
> > +=09=09=09fi.flags =3D arg->flags;
> > +=09=09}
> > +=09=09req->se->op.read(req, nodeid, arg->size, arg->offset, &fi);
> > +=09} else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_write(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
> > +{
> > +=09struct fuse_write_in *arg =3D (struct fuse_write_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +=09char *param;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.fh =3D arg->fh;
> > +=09fi.writepage =3D (arg->write_flags & FUSE_WRITE_CACHE) !=3D 0;
> > +
> > +=09if (req->se->conn.proto_minor < 9) {
> > +=09=09param =3D ((char *) arg) + FUSE_COMPAT_WRITE_IN_SIZE;
> > +=09} else {
> > +=09=09fi.lock_owner =3D arg->lock_owner;
> > +=09=09fi.flags =3D arg->flags;
> > +=09=09param =3D PARAM(arg);
> > +=09}
> > +
> > +=09if (req->se->op.write)
> > +=09=09req->se->op.write(req, nodeid, param, arg->size,
> > +=09=09=09=09 arg->offset, &fi);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_write_buf(fuse_req_t req, fuse_ino_t nodeid, const void=
 *inarg,
> > +=09=09=09 const struct fuse_buf *ibuf)
> > +{
> > +=09struct fuse_session *se =3D req->se;
> > +=09struct fuse_bufvec bufv =3D {
> > +=09=09.buf[0] =3D *ibuf,
> > +=09=09.count =3D 1,
> > +=09};
> > +=09struct fuse_write_in *arg =3D (struct fuse_write_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.fh =3D arg->fh;
> > +=09fi.writepage =3D arg->write_flags & FUSE_WRITE_CACHE;
> > +
> > +=09if (se->conn.proto_minor < 9) {
> > +=09=09bufv.buf[0].mem =3D ((char *) arg) + FUSE_COMPAT_WRITE_IN_SIZE;
> > +=09=09bufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
> > +=09=09=09FUSE_COMPAT_WRITE_IN_SIZE;
> > +=09=09assert(!(bufv.buf[0].flags & FUSE_BUF_IS_FD));
> > +=09} else {
> > +=09=09fi.lock_owner =3D arg->lock_owner;
> > +=09=09fi.flags =3D arg->flags;
> > +=09=09if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD))
> > +=09=09=09bufv.buf[0].mem =3D PARAM(arg);
> > +
> > +=09=09bufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
> > +=09=09=09sizeof(struct fuse_write_in);
> > +=09}
> > +=09if (bufv.buf[0].size < arg->size) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: do_write_buf: buffer size too smal=
l\n");
> > +=09=09fuse_reply_err(req, EIO);
> > +=09=09goto out;
> > +=09}
> > +=09bufv.buf[0].size =3D arg->size;
> > +
> > +=09se->op.write_buf(req, nodeid, &bufv, arg->offset, &fi);
> > +
> > +out:
> > +=09/* Need to reset the pipe if ->write_buf() didn't consume all data =
*/
> > +=09if ((ibuf->flags & FUSE_BUF_IS_FD) && bufv.idx < bufv.count)
> > +=09=09fuse_ll_clear_pipe(se);
> > +}
> > +
> > +static void do_flush(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
> > +{
> > +=09struct fuse_flush_in *arg =3D (struct fuse_flush_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.fh =3D arg->fh;
> > +=09fi.flush =3D 1;
> > +=09if (req->se->conn.proto_minor >=3D 7)
> > +=09=09fi.lock_owner =3D arg->lock_owner;
> > +
> > +=09if (req->se->op.flush)
> > +=09=09req->se->op.flush(req, nodeid, &fi);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_release(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
> > +{
> > +=09struct fuse_release_in *arg =3D (struct fuse_release_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.flags =3D arg->flags;
> > +=09fi.fh =3D arg->fh;
> > +=09if (req->se->conn.proto_minor >=3D 8) {
> > +=09=09fi.flush =3D (arg->release_flags & FUSE_RELEASE_FLUSH) ? 1 : 0;
> > +=09=09fi.lock_owner =3D arg->lock_owner;
> > +=09}
> > +=09if (arg->release_flags & FUSE_RELEASE_FLOCK_UNLOCK) {
> > +=09=09fi.flock_release =3D 1;
> > +=09=09fi.lock_owner =3D arg->lock_owner;
> > +=09}
> > +
> > +=09if (req->se->op.release)
> > +=09=09req->se->op.release(req, nodeid, &fi);
> > +=09else
> > +=09=09fuse_reply_err(req, 0);
> > +}
> > +
> > +static void do_fsync(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
> > +{
> > +=09struct fuse_fsync_in *arg =3D (struct fuse_fsync_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +=09int datasync =3D arg->fsync_flags & 1;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.fh =3D arg->fh;
> > +
> > +=09if (req->se->op.fsync)
> > +=09=09req->se->op.fsync(req, nodeid, datasync, &fi);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_opendir(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
> > +{
> > +=09struct fuse_open_in *arg =3D (struct fuse_open_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.flags =3D arg->flags;
> > +
> > +=09if (req->se->op.opendir)
> > +=09=09req->se->op.opendir(req, nodeid, &fi);
> > +=09else
> > +=09=09fuse_reply_open(req, &fi);
> > +}
> > +
> > +static void do_readdir(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
> > +{
> > +=09struct fuse_read_in *arg =3D (struct fuse_read_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.fh =3D arg->fh;
> > +
> > +=09if (req->se->op.readdir)
> > +=09=09req->se->op.readdir(req, nodeid, arg->size, arg->offset, &fi);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_readdirplus(fuse_req_t req, fuse_ino_t nodeid, const vo=
id *inarg)
> > +{
> > +=09struct fuse_read_in *arg =3D (struct fuse_read_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.fh =3D arg->fh;
> > +
> > +=09if (req->se->op.readdirplus)
> > +=09=09req->se->op.readdirplus(req, nodeid, arg->size, arg->offset, &fi=
);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_releasedir(fuse_req_t req, fuse_ino_t nodeid, const voi=
d *inarg)
> > +{
> > +=09struct fuse_release_in *arg =3D (struct fuse_release_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.flags =3D arg->flags;
> > +=09fi.fh =3D arg->fh;
> > +
> > +=09if (req->se->op.releasedir)
> > +=09=09req->se->op.releasedir(req, nodeid, &fi);
> > +=09else
> > +=09=09fuse_reply_err(req, 0);
> > +}
> > +
> > +static void do_fsyncdir(fuse_req_t req, fuse_ino_t nodeid, const void =
*inarg)
> > +{
> > +=09struct fuse_fsync_in *arg =3D (struct fuse_fsync_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +=09int datasync =3D arg->fsync_flags & 1;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.fh =3D arg->fh;
> > +
> > +=09if (req->se->op.fsyncdir)
> > +=09=09req->se->op.fsyncdir(req, nodeid, datasync, &fi);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_statfs(fuse_req_t req, fuse_ino_t nodeid, const void *i=
narg)
> > +{
> > +=09(void) nodeid;
> > +=09(void) inarg;
> > +
> > +=09if (req->se->op.statfs)
> > +=09=09req->se->op.statfs(req, nodeid);
> > +=09else {
> > +=09=09struct statvfs buf =3D {
> > +=09=09=09.f_namemax =3D 255,
> > +=09=09=09.f_bsize =3D 512,
> > +=09=09};
> > +=09=09fuse_reply_statfs(req, &buf);
> > +=09}
> > +}
> > +
> > +static void do_setxattr(fuse_req_t req, fuse_ino_t nodeid, const void =
*inarg)
> > +{
> > +=09struct fuse_setxattr_in *arg =3D (struct fuse_setxattr_in *) inarg;
> > +=09char *name =3D PARAM(arg);
> > +=09char *value =3D name + strlen(name) + 1;
> > +
> > +=09if (req->se->op.setxattr)
> > +=09=09req->se->op.setxattr(req, nodeid, name, value, arg->size,
> > +=09=09=09=09    arg->flags);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_getxattr(fuse_req_t req, fuse_ino_t nodeid, const void =
*inarg)
> > +{
> > +=09struct fuse_getxattr_in *arg =3D (struct fuse_getxattr_in *) inarg;
> > +
> > +=09if (req->se->op.getxattr)
> > +=09=09req->se->op.getxattr(req, nodeid, PARAM(arg), arg->size);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_listxattr(fuse_req_t req, fuse_ino_t nodeid, const void=
 *inarg)
> > +{
> > +=09struct fuse_getxattr_in *arg =3D (struct fuse_getxattr_in *) inarg;
> > +
> > +=09if (req->se->op.listxattr)
> > +=09=09req->se->op.listxattr(req, nodeid, arg->size);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_removexattr(fuse_req_t req, fuse_ino_t nodeid, const vo=
id *inarg)
> > +{
> > +=09char *name =3D (char *) inarg;
> > +
> > +=09if (req->se->op.removexattr)
> > +=09=09req->se->op.removexattr(req, nodeid, name);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void convert_fuse_file_lock(struct fuse_file_lock *fl,
> > +=09=09=09=09   struct flock *flock)
> > +{
> > +=09memset(flock, 0, sizeof(struct flock));
> > +=09flock->l_type =3D fl->type;
> > +=09flock->l_whence =3D SEEK_SET;
> > +=09flock->l_start =3D fl->start;
> > +=09if (fl->end =3D=3D OFFSET_MAX)
> > +=09=09flock->l_len =3D 0;
> > +=09else
> > +=09=09flock->l_len =3D fl->end - fl->start + 1;
> > +=09flock->l_pid =3D fl->pid;
> > +}
> > +
> > +static void do_getlk(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
> > +{
> > +=09struct fuse_lk_in *arg =3D (struct fuse_lk_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +=09struct flock flock;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.fh =3D arg->fh;
> > +=09fi.lock_owner =3D arg->owner;
> > +
> > +=09convert_fuse_file_lock(&arg->lk, &flock);
> > +=09if (req->se->op.getlk)
> > +=09=09req->se->op.getlk(req, nodeid, &fi, &flock);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_setlk_common(fuse_req_t req, fuse_ino_t nodeid,
> > +=09=09=09    const void *inarg, int sleep)
> > +{
> > +=09struct fuse_lk_in *arg =3D (struct fuse_lk_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +=09struct flock flock;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.fh =3D arg->fh;
> > +=09fi.lock_owner =3D arg->owner;
> > +
> > +=09if (arg->lk_flags & FUSE_LK_FLOCK) {
> > +=09=09int op =3D 0;
> > +
> > +=09=09switch (arg->lk.type) {
> > +=09=09case F_RDLCK:
> > +=09=09=09op =3D LOCK_SH;
> > +=09=09=09break;
> > +=09=09case F_WRLCK:
> > +=09=09=09op =3D LOCK_EX;
> > +=09=09=09break;
> > +=09=09case F_UNLCK:
> > +=09=09=09op =3D LOCK_UN;
> > +=09=09=09break;
> > +=09=09}
> > +=09=09if (!sleep)
> > +=09=09=09op |=3D LOCK_NB;
> > +
> > +=09=09if (req->se->op.flock)
> > +=09=09=09req->se->op.flock(req, nodeid, &fi, op);
> > +=09=09else
> > +=09=09=09fuse_reply_err(req, ENOSYS);
> > +=09} else {
> > +=09=09convert_fuse_file_lock(&arg->lk, &flock);
> > +=09=09if (req->se->op.setlk)
> > +=09=09=09req->se->op.setlk(req, nodeid, &fi, &flock, sleep);
> > +=09=09else
> > +=09=09=09fuse_reply_err(req, ENOSYS);
> > +=09}
> > +}
> > +
> > +static void do_setlk(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
> > +{
> > +=09do_setlk_common(req, nodeid, inarg, 0);
> > +}
> > +
> > +static void do_setlkw(fuse_req_t req, fuse_ino_t nodeid, const void *i=
narg)
> > +{
> > +=09do_setlk_common(req, nodeid, inarg, 1);
> > +}
> > +
> > +static int find_interrupted(struct fuse_session *se, struct fuse_req *=
req)
> > +{
> > +=09struct fuse_req *curr;
> > +
> > +=09for (curr =3D se->list.next; curr !=3D &se->list; curr =3D curr->ne=
xt) {
> > +=09=09if (curr->unique =3D=3D req->u.i.unique) {
> > +=09=09=09fuse_interrupt_func_t func;
> > +=09=09=09void *data;
> > +
> > +=09=09=09curr->ctr++;
> > +=09=09=09pthread_mutex_unlock(&se->lock);
> > +
> > +=09=09=09/* Ugh, ugly locking */
> > +=09=09=09pthread_mutex_lock(&curr->lock);
> > +=09=09=09pthread_mutex_lock(&se->lock);
> > +=09=09=09curr->interrupted =3D 1;
> > +=09=09=09func =3D curr->u.ni.func;
> > +=09=09=09data =3D curr->u.ni.data;
> > +=09=09=09pthread_mutex_unlock(&se->lock);
> > +=09=09=09if (func)
> > +=09=09=09=09func(curr, data);
> > +=09=09=09pthread_mutex_unlock(&curr->lock);
> > +
> > +=09=09=09pthread_mutex_lock(&se->lock);
> > +=09=09=09curr->ctr--;
> > +=09=09=09if (!curr->ctr)
> > +=09=09=09=09destroy_req(curr);
> > +
> > +=09=09=09return 1;
> > +=09=09}
> > +=09}
> > +=09for (curr =3D se->interrupts.next; curr !=3D &se->interrupts;
> > +=09     curr =3D curr->next) {
> > +=09=09if (curr->u.i.unique =3D=3D req->u.i.unique)
> > +=09=09=09return 1;
> > +=09}
> > +=09return 0;
> > +}
> > +
> > +static void do_interrupt(fuse_req_t req, fuse_ino_t nodeid, const void=
 *inarg)
> > +{
> > +=09struct fuse_interrupt_in *arg =3D (struct fuse_interrupt_in *) inar=
g;
> > +=09struct fuse_session *se =3D req->se;
> > +
> > +=09(void) nodeid;
> > +=09if (se->debug)
> > +=09=09fuse_log(FUSE_LOG_DEBUG, "INTERRUPT: %llu\n",
> > +=09=09=09(unsigned long long) arg->unique);
> > +
> > +=09req->u.i.unique =3D arg->unique;
> > +
> > +=09pthread_mutex_lock(&se->lock);
> > +=09if (find_interrupted(se, req))
> > +=09=09destroy_req(req);
> > +=09else
> > +=09=09list_add_req(req, &se->interrupts);
> > +=09pthread_mutex_unlock(&se->lock);
> > +}
> > +
> > +static struct fuse_req *check_interrupt(struct fuse_session *se,
> > +=09=09=09=09=09struct fuse_req *req)
> > +{
> > +=09struct fuse_req *curr;
> > +
> > +=09for (curr =3D se->interrupts.next; curr !=3D &se->interrupts;
> > +=09     curr =3D curr->next) {
> > +=09=09if (curr->u.i.unique =3D=3D req->unique) {
> > +=09=09=09req->interrupted =3D 1;
> > +=09=09=09list_del_req(curr);
> > +=09=09=09free(curr);
> > +=09=09=09return NULL;
> > +=09=09}
> > +=09}
> > +=09curr =3D se->interrupts.next;
> > +=09if (curr !=3D &se->interrupts) {
> > +=09=09list_del_req(curr);
> > +=09=09list_init_req(curr);
> > +=09=09return curr;
> > +=09} else
> > +=09=09return NULL;
> > +}
> > +
> > +static void do_bmap(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
> > +{
> > +=09struct fuse_bmap_in *arg =3D (struct fuse_bmap_in *) inarg;
> > +
> > +=09if (req->se->op.bmap)
> > +=09=09req->se->op.bmap(req, nodeid, arg->blocksize, arg->block);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_ioctl(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
> > +{
> > +=09struct fuse_ioctl_in *arg =3D (struct fuse_ioctl_in *) inarg;
> > +=09unsigned int flags =3D arg->flags;
> > +=09void *in_buf =3D arg->in_size ? PARAM(arg) : NULL;
> > +=09struct fuse_file_info fi;
> > +
> > +=09if (flags & FUSE_IOCTL_DIR &&
> > +=09    !(req->se->conn.want & FUSE_CAP_IOCTL_DIR)) {
> > +=09=09fuse_reply_err(req, ENOTTY);
> > +=09=09return;
> > +=09}
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.fh =3D arg->fh;
> > +
> > +=09if (sizeof(void *) =3D=3D 4 && req->se->conn.proto_minor >=3D 16 &&
> > +=09    !(flags & FUSE_IOCTL_32BIT)) {
> > +=09=09req->ioctl_64bit =3D 1;
> > +=09}
> > +
> > +=09if (req->se->op.ioctl)
> > +=09=09req->se->op.ioctl(req, nodeid, arg->cmd,
> > +=09=09=09=09 (void *)(uintptr_t)arg->arg, &fi, flags,
> > +=09=09=09=09 in_buf, arg->in_size, arg->out_size);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +void fuse_pollhandle_destroy(struct fuse_pollhandle *ph)
> > +{
> > +=09free(ph);
> > +}
> > +
> > +static void do_poll(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
> > +{
> > +=09struct fuse_poll_in *arg =3D (struct fuse_poll_in *) inarg;
> > +=09struct fuse_file_info fi;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.fh =3D arg->fh;
> > +=09fi.poll_events =3D arg->events;
> > +
> > +=09if (req->se->op.poll) {
> > +=09=09struct fuse_pollhandle *ph =3D NULL;
> > +
> > +=09=09if (arg->flags & FUSE_POLL_SCHEDULE_NOTIFY) {
> > +=09=09=09ph =3D malloc(sizeof(struct fuse_pollhandle));
> > +=09=09=09if (ph =3D=3D NULL) {
> > +=09=09=09=09fuse_reply_err(req, ENOMEM);
> > +=09=09=09=09return;
> > +=09=09=09}
> > +=09=09=09ph->kh =3D arg->kh;
> > +=09=09=09ph->se =3D req->se;
> > +=09=09}
> > +
> > +=09=09req->se->op.poll(req, nodeid, &fi, ph);
> > +=09} else {
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +=09}
> > +}
> > +
> > +static void do_fallocate(fuse_req_t req, fuse_ino_t nodeid, const void=
 *inarg)
> > +{
> > +=09struct fuse_fallocate_in *arg =3D (struct fuse_fallocate_in *) inar=
g;
> > +=09struct fuse_file_info fi;
> > +
> > +=09memset(&fi, 0, sizeof(fi));
> > +=09fi.fh =3D arg->fh;
> > +
> > +=09if (req->se->op.fallocate)
> > +=09=09req->se->op.fallocate(req, nodeid, arg->mode, arg->offset, arg->=
length, &fi);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_copy_file_range(fuse_req_t req, fuse_ino_t nodeid_in, c=
onst void *inarg)
> > +{
> > +=09struct fuse_copy_file_range_in *arg =3D (struct fuse_copy_file_rang=
e_in *) inarg;
> > +=09struct fuse_file_info fi_in, fi_out;
> > +
> > +=09memset(&fi_in, 0, sizeof(fi_in));
> > +=09fi_in.fh =3D arg->fh_in;
> > +
> > +=09memset(&fi_out, 0, sizeof(fi_out));
> > +=09fi_out.fh =3D arg->fh_out;
> > +
> > +
> > +=09if (req->se->op.copy_file_range)
> > +=09=09req->se->op.copy_file_range(req, nodeid_in, arg->off_in,
> > +=09=09=09=09=09    &fi_in, arg->nodeid_out,
> > +=09=09=09=09=09    arg->off_out, &fi_out, arg->len,
> > +=09=09=09=09=09    arg->flags);
> > +=09else
> > +=09=09fuse_reply_err(req, ENOSYS);
> > +}
> > +
> > +static void do_init(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
> > +{
> > +=09struct fuse_init_in *arg =3D (struct fuse_init_in *) inarg;
> > +=09struct fuse_init_out outarg;
> > +=09struct fuse_session *se =3D req->se;
> > +=09size_t bufsize =3D se->bufsize;
> > +=09size_t outargsize =3D sizeof(outarg);
> > +
> > +=09(void) nodeid;
> > +=09if (se->debug) {
> > +=09=09fuse_log(FUSE_LOG_DEBUG, "INIT: %u.%u\n", arg->major, arg->minor=
);
> > +=09=09if (arg->major =3D=3D 7 && arg->minor >=3D 6) {
> > +=09=09=09fuse_log(FUSE_LOG_DEBUG, "flags=3D0x%08x\n", arg->flags);
> > +=09=09=09fuse_log(FUSE_LOG_DEBUG, "max_readahead=3D0x%08x\n",
> > +=09=09=09=09arg->max_readahead);
> > +=09=09}
> > +=09}
> > +=09se->conn.proto_major =3D arg->major;
> > +=09se->conn.proto_minor =3D arg->minor;
> > +=09se->conn.capable =3D 0;
> > +=09se->conn.want =3D 0;
> > +
> > +=09memset(&outarg, 0, sizeof(outarg));
> > +=09outarg.major =3D FUSE_KERNEL_VERSION;
> > +=09outarg.minor =3D FUSE_KERNEL_MINOR_VERSION;
> > +
> > +=09if (arg->major < 7) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: unsupported protocol version: %u.%=
u\n",
> > +=09=09=09arg->major, arg->minor);
> > +=09=09fuse_reply_err(req, EPROTO);
> > +=09=09return;
> > +=09}
> > +
> > +=09if (arg->major > 7) {
> > +=09=09/* Wait for a second INIT request with a 7.X version */
> > +=09=09send_reply_ok(req, &outarg, sizeof(outarg));
> > +=09=09return;
> > +=09}
> > +
> > +=09if (arg->minor >=3D 6) {
> > +=09=09if (arg->max_readahead < se->conn.max_readahead)
> > +=09=09=09se->conn.max_readahead =3D arg->max_readahead;
> > +=09=09if (arg->flags & FUSE_ASYNC_READ)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_ASYNC_READ;
> > +=09=09if (arg->flags & FUSE_POSIX_LOCKS)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_POSIX_LOCKS;
> > +=09=09if (arg->flags & FUSE_ATOMIC_O_TRUNC)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_ATOMIC_O_TRUNC;
> > +=09=09if (arg->flags & FUSE_EXPORT_SUPPORT)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_EXPORT_SUPPORT;
> > +=09=09if (arg->flags & FUSE_DONT_MASK)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_DONT_MASK;
> > +=09=09if (arg->flags & FUSE_FLOCK_LOCKS)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_FLOCK_LOCKS;
> > +=09=09if (arg->flags & FUSE_AUTO_INVAL_DATA)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_AUTO_INVAL_DATA;
> > +=09=09if (arg->flags & FUSE_DO_READDIRPLUS)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_READDIRPLUS;
> > +=09=09if (arg->flags & FUSE_READDIRPLUS_AUTO)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_READDIRPLUS_AUTO;
> > +=09=09if (arg->flags & FUSE_ASYNC_DIO)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_ASYNC_DIO;
> > +=09=09if (arg->flags & FUSE_WRITEBACK_CACHE)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_WRITEBACK_CACHE;
> > +=09=09if (arg->flags & FUSE_NO_OPEN_SUPPORT)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_NO_OPEN_SUPPORT;
> > +=09=09if (arg->flags & FUSE_PARALLEL_DIROPS)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_PARALLEL_DIROPS;
> > +=09=09if (arg->flags & FUSE_POSIX_ACL)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_POSIX_ACL;
> > +=09=09if (arg->flags & FUSE_HANDLE_KILLPRIV)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_HANDLE_KILLPRIV;
> > +=09=09if (arg->flags & FUSE_NO_OPENDIR_SUPPORT)
> > +=09=09=09se->conn.capable |=3D FUSE_CAP_NO_OPENDIR_SUPPORT;
> > +=09=09if (!(arg->flags & FUSE_MAX_PAGES)) {
> > +=09=09=09size_t max_bufsize =3D
> > +=09=09=09=09FUSE_DEFAULT_MAX_PAGES_PER_REQ * getpagesize()
> > +=09=09=09=09+ FUSE_BUFFER_HEADER_SIZE;
> > +=09=09=09if (bufsize > max_bufsize) {
> > +=09=09=09=09bufsize =3D max_bufsize;
> > +=09=09=09}
> > +=09=09}
> > +=09} else {
> > +=09=09se->conn.max_readahead =3D 0;
> > +=09}
> > +
> > +=09if (se->conn.proto_minor >=3D 14) {
> > +#ifdef HAVE_SPLICE
> > +#ifdef HAVE_VMSPLICE
> > +=09=09se->conn.capable |=3D FUSE_CAP_SPLICE_WRITE | FUSE_CAP_SPLICE_MO=
VE;
> > +#endif
> > +=09=09se->conn.capable |=3D FUSE_CAP_SPLICE_READ;
> > +#endif
> > +=09}
> > +=09if (se->conn.proto_minor >=3D 18)
> > +=09=09se->conn.capable |=3D FUSE_CAP_IOCTL_DIR;
> > +
> > +=09/* Default settings for modern filesystems.
> > +=09 *
> > +=09 * Most of these capabilities were disabled by default in
> > +=09 * libfuse2 for backwards compatibility reasons. In libfuse3,
> > +=09 * we can finally enable them by default (as long as they're
> > +=09 * supported by the kernel).
> > +=09 */
> > +#define LL_SET_DEFAULT(cond, cap) \
> > +=09if ((cond) && (se->conn.capable & (cap))) \
> > +=09=09se->conn.want |=3D (cap)
> > +=09LL_SET_DEFAULT(1, FUSE_CAP_ASYNC_READ);
> > +=09LL_SET_DEFAULT(1, FUSE_CAP_PARALLEL_DIROPS);
> > +=09LL_SET_DEFAULT(1, FUSE_CAP_AUTO_INVAL_DATA);
> > +=09LL_SET_DEFAULT(1, FUSE_CAP_HANDLE_KILLPRIV);
> > +=09LL_SET_DEFAULT(1, FUSE_CAP_ASYNC_DIO);
> > +=09LL_SET_DEFAULT(1, FUSE_CAP_IOCTL_DIR);
> > +=09LL_SET_DEFAULT(1, FUSE_CAP_ATOMIC_O_TRUNC);
> > +=09LL_SET_DEFAULT(se->op.write_buf, FUSE_CAP_SPLICE_READ);
> > +=09LL_SET_DEFAULT(se->op.getlk && se->op.setlk,
> > +=09=09       FUSE_CAP_POSIX_LOCKS);
> > +=09LL_SET_DEFAULT(se->op.flock, FUSE_CAP_FLOCK_LOCKS);
> > +=09LL_SET_DEFAULT(se->op.readdirplus, FUSE_CAP_READDIRPLUS);
> > +=09LL_SET_DEFAULT(se->op.readdirplus && se->op.readdir,
> > +=09=09       FUSE_CAP_READDIRPLUS_AUTO);
> > +=09se->conn.time_gran =3D 1;
> > +=09
> > +=09if (bufsize < FUSE_MIN_READ_BUFFER) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: warning: buffer size too small: %z=
u\n",
> > +=09=09=09bufsize);
> > +=09=09bufsize =3D FUSE_MIN_READ_BUFFER;
> > +=09}
> > +=09se->bufsize =3D bufsize;
> > +
> > +=09if (se->conn.max_write > bufsize - FUSE_BUFFER_HEADER_SIZE)
> > +=09=09se->conn.max_write =3D bufsize - FUSE_BUFFER_HEADER_SIZE;
> > +
> > +=09se->got_init =3D 1;
> > +=09if (se->op.init)
> > +=09=09se->op.init(se->userdata, &se->conn);
> > +
> > +=09if (se->conn.want & (~se->conn.capable)) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: error: filesystem requested capabi=
lities "
> > +=09=09=09"0x%x that are not supported by kernel, aborting.\n",
> > +=09=09=09se->conn.want & (~se->conn.capable));
> > +=09=09fuse_reply_err(req, EPROTO);
> > +=09=09se->error =3D -EPROTO;
> > +=09=09fuse_session_exit(se);
> > +=09=09return;
> > +=09}
> > +
> > +=09unsigned max_read_mo =3D get_max_read(se->mo);
> > +=09if (se->conn.max_read !=3D max_read_mo) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: error: init() and fuse_session_new=
() "
> > +=09=09=09"requested different maximum read size (%u vs %u)\n",
> > +=09=09=09se->conn.max_read, max_read_mo);
> > +=09=09fuse_reply_err(req, EPROTO);
> > +=09=09se->error =3D -EPROTO;
> > +=09=09fuse_session_exit(se);
> > +=09=09return;
> > +=09}
> > +
> > +=09if (se->conn.max_write < bufsize - FUSE_BUFFER_HEADER_SIZE) {
> > +=09=09se->bufsize =3D se->conn.max_write + FUSE_BUFFER_HEADER_SIZE;
> > +=09}
> > +=09if (arg->flags & FUSE_MAX_PAGES) {
> > +=09=09outarg.flags |=3D FUSE_MAX_PAGES;
> > +=09=09outarg.max_pages =3D (se->conn.max_write - 1) / getpagesize() + =
1;
> > +=09}
> > +
> > +=09/* Always enable big writes, this is superseded
> > +=09   by the max_write option */
> > +=09outarg.flags |=3D FUSE_BIG_WRITES;
> > +
> > +=09if (se->conn.want & FUSE_CAP_ASYNC_READ)
> > +=09=09outarg.flags |=3D FUSE_ASYNC_READ;
> > +=09if (se->conn.want & FUSE_CAP_POSIX_LOCKS)
> > +=09=09outarg.flags |=3D FUSE_POSIX_LOCKS;
> > +=09if (se->conn.want & FUSE_CAP_ATOMIC_O_TRUNC)
> > +=09=09outarg.flags |=3D FUSE_ATOMIC_O_TRUNC;
> > +=09if (se->conn.want & FUSE_CAP_EXPORT_SUPPORT)
> > +=09=09outarg.flags |=3D FUSE_EXPORT_SUPPORT;
> > +=09if (se->conn.want & FUSE_CAP_DONT_MASK)
> > +=09=09outarg.flags |=3D FUSE_DONT_MASK;
> > +=09if (se->conn.want & FUSE_CAP_FLOCK_LOCKS)
> > +=09=09outarg.flags |=3D FUSE_FLOCK_LOCKS;
> > +=09if (se->conn.want & FUSE_CAP_AUTO_INVAL_DATA)
> > +=09=09outarg.flags |=3D FUSE_AUTO_INVAL_DATA;
> > +=09if (se->conn.want & FUSE_CAP_READDIRPLUS)
> > +=09=09outarg.flags |=3D FUSE_DO_READDIRPLUS;
> > +=09if (se->conn.want & FUSE_CAP_READDIRPLUS_AUTO)
> > +=09=09outarg.flags |=3D FUSE_READDIRPLUS_AUTO;
> > +=09if (se->conn.want & FUSE_CAP_ASYNC_DIO)
> > +=09=09outarg.flags |=3D FUSE_ASYNC_DIO;
> > +=09if (se->conn.want & FUSE_CAP_WRITEBACK_CACHE)
> > +=09=09outarg.flags |=3D FUSE_WRITEBACK_CACHE;
> > +=09if (se->conn.want & FUSE_CAP_POSIX_ACL)
> > +=09=09outarg.flags |=3D FUSE_POSIX_ACL;
> > +=09outarg.max_readahead =3D se->conn.max_readahead;
> > +=09outarg.max_write =3D se->conn.max_write;
> > +=09if (se->conn.proto_minor >=3D 13) {
> > +=09=09if (se->conn.max_background >=3D (1 << 16))
> > +=09=09=09se->conn.max_background =3D (1 << 16) - 1;
> > +=09=09if (se->conn.congestion_threshold > se->conn.max_background)
> > +=09=09=09se->conn.congestion_threshold =3D se->conn.max_background;
> > +=09=09if (!se->conn.congestion_threshold) {
> > +=09=09=09se->conn.congestion_threshold =3D
> > +=09=09=09=09se->conn.max_background * 3 / 4;
> > +=09=09}
> > +
> > +=09=09outarg.max_background =3D se->conn.max_background;
> > +=09=09outarg.congestion_threshold =3D se->conn.congestion_threshold;
> > +=09}
> > +=09if (se->conn.proto_minor >=3D 23)
> > +=09=09outarg.time_gran =3D se->conn.time_gran;
> > +
> > +=09if (se->debug) {
> > +=09=09fuse_log(FUSE_LOG_DEBUG, "   INIT: %u.%u\n", outarg.major, outar=
g.minor);
> > +=09=09fuse_log(FUSE_LOG_DEBUG, "   flags=3D0x%08x\n", outarg.flags);
> > +=09=09fuse_log(FUSE_LOG_DEBUG, "   max_readahead=3D0x%08x\n",
> > +=09=09=09outarg.max_readahead);
> > +=09=09fuse_log(FUSE_LOG_DEBUG, "   max_write=3D0x%08x\n", outarg.max_w=
rite);
> > +=09=09fuse_log(FUSE_LOG_DEBUG, "   max_background=3D%i\n",
> > +=09=09=09outarg.max_background);
> > +=09=09fuse_log(FUSE_LOG_DEBUG, "   congestion_threshold=3D%i\n",
> > +=09=09=09outarg.congestion_threshold);
> > +=09=09fuse_log(FUSE_LOG_DEBUG, "   time_gran=3D%u\n",
> > +=09=09=09outarg.time_gran);
> > +=09}
> > +=09if (arg->minor < 5)
> > +=09=09outargsize =3D FUSE_COMPAT_INIT_OUT_SIZE;
> > +=09else if (arg->minor < 23)
> > +=09=09outargsize =3D FUSE_COMPAT_22_INIT_OUT_SIZE;
> > +
> > +=09send_reply_ok(req, &outarg, outargsize);
> > +}
> > +
> > +static void do_destroy(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
> > +{
> > +=09struct fuse_session *se =3D req->se;
> > +
> > +=09(void) nodeid;
> > +=09(void) inarg;
> > +
> > +=09se->got_destroy =3D 1;
> > +=09if (se->op.destroy)
> > +=09=09se->op.destroy(se->userdata);
> > +
> > +=09send_reply_ok(req, NULL, 0);
> > +}
> > +
> > +static void list_del_nreq(struct fuse_notify_req *nreq)
> > +{
> > +=09struct fuse_notify_req *prev =3D nreq->prev;
> > +=09struct fuse_notify_req *next =3D nreq->next;
> > +=09prev->next =3D next;
> > +=09next->prev =3D prev;
> > +}
> > +
> > +static void list_add_nreq(struct fuse_notify_req *nreq,
> > +=09=09=09  struct fuse_notify_req *next)
> > +{
> > +=09struct fuse_notify_req *prev =3D next->prev;
> > +=09nreq->next =3D next;
> > +=09nreq->prev =3D prev;
> > +=09prev->next =3D nreq;
> > +=09next->prev =3D nreq;
> > +}
> > +
> > +static void list_init_nreq(struct fuse_notify_req *nreq)
> > +{
> > +=09nreq->next =3D nreq;
> > +=09nreq->prev =3D nreq;
> > +}
> > +
> > +static void do_notify_reply(fuse_req_t req, fuse_ino_t nodeid,
> > +=09=09=09    const void *inarg, const struct fuse_buf *buf)
> > +{
> > +=09struct fuse_session *se =3D req->se;
> > +=09struct fuse_notify_req *nreq;
> > +=09struct fuse_notify_req *head;
> > +
> > +=09pthread_mutex_lock(&se->lock);
> > +=09head =3D &se->notify_list;
> > +=09for (nreq =3D head->next; nreq !=3D head; nreq =3D nreq->next) {
> > +=09=09if (nreq->unique =3D=3D req->unique) {
> > +=09=09=09list_del_nreq(nreq);
> > +=09=09=09break;
> > +=09=09}
> > +=09}
> > +=09pthread_mutex_unlock(&se->lock);
> > +
> > +=09if (nreq !=3D head)
> > +=09=09nreq->reply(nreq, req, nodeid, inarg, buf);
> > +}
> > +
> > +static int send_notify_iov(struct fuse_session *se, int notify_code,
> > +=09=09=09   struct iovec *iov, int count)
> > +{
> > +=09struct fuse_out_header out;
> > +
> > +=09if (!se->got_init)
> > +=09=09return -ENOTCONN;
> > +
> > +=09out.unique =3D 0;
> > +=09out.error =3D notify_code;
> > +=09iov[0].iov_base =3D &out;
> > +=09iov[0].iov_len =3D sizeof(struct fuse_out_header);
> > +
> > +=09return fuse_send_msg(se, NULL, iov, count);
> > +}
> > +
> > +int fuse_lowlevel_notify_poll(struct fuse_pollhandle *ph)
> > +{
> > +=09if (ph !=3D NULL) {
> > +=09=09struct fuse_notify_poll_wakeup_out outarg;
> > +=09=09struct iovec iov[2];
> > +
> > +=09=09outarg.kh =3D ph->kh;
> > +
> > +=09=09iov[1].iov_base =3D &outarg;
> > +=09=09iov[1].iov_len =3D sizeof(outarg);
> > +
> > +=09=09return send_notify_iov(ph->se, FUSE_NOTIFY_POLL, iov, 2);
> > +=09} else {
> > +=09=09return 0;
> > +=09}
> > +}
> > +
> > +int fuse_lowlevel_notify_inval_inode(struct fuse_session *se, fuse_ino=
_t ino,
> > +=09=09=09=09     off_t off, off_t len)
> > +{
> > +=09struct fuse_notify_inval_inode_out outarg;
> > +=09struct iovec iov[2];
> > +
> > +=09if (!se)
> > +=09=09return -EINVAL;
> > +
> > +=09if (se->conn.proto_major < 6 || se->conn.proto_minor < 12)
> > +=09=09return -ENOSYS;
> > +=09
> > +=09outarg.ino =3D ino;
> > +=09outarg.off =3D off;
> > +=09outarg.len =3D len;
> > +
> > +=09iov[1].iov_base =3D &outarg;
> > +=09iov[1].iov_len =3D sizeof(outarg);
> > +
> > +=09return send_notify_iov(se, FUSE_NOTIFY_INVAL_INODE, iov, 2);
> > +}
> > +
> > +int fuse_lowlevel_notify_inval_entry(struct fuse_session *se, fuse_ino=
_t parent,
> > +=09=09=09=09     const char *name, size_t namelen)
> > +{
> > +=09struct fuse_notify_inval_entry_out outarg;
> > +=09struct iovec iov[3];
> > +
> > +=09if (!se)
> > +=09=09return -EINVAL;
> > +=09
> > +=09if (se->conn.proto_major < 6 || se->conn.proto_minor < 12)
> > +=09=09return -ENOSYS;
> > +
> > +=09outarg.parent =3D parent;
> > +=09outarg.namelen =3D namelen;
> > +=09outarg.padding =3D 0;
> > +
> > +=09iov[1].iov_base =3D &outarg;
> > +=09iov[1].iov_len =3D sizeof(outarg);
> > +=09iov[2].iov_base =3D (void *)name;
> > +=09iov[2].iov_len =3D namelen + 1;
> > +
> > +=09return send_notify_iov(se, FUSE_NOTIFY_INVAL_ENTRY, iov, 3);
> > +}
> > +
> > +int fuse_lowlevel_notify_delete(struct fuse_session *se,
> > +=09=09=09=09fuse_ino_t parent, fuse_ino_t child,
> > +=09=09=09=09const char *name, size_t namelen)
> > +{
> > +=09struct fuse_notify_delete_out outarg;
> > +=09struct iovec iov[3];
> > +
> > +=09if (!se)
> > +=09=09return -EINVAL;
> > +
> > +=09if (se->conn.proto_major < 6 || se->conn.proto_minor < 18)
> > +=09=09return -ENOSYS;
> > +
> > +=09outarg.parent =3D parent;
> > +=09outarg.child =3D child;
> > +=09outarg.namelen =3D namelen;
> > +=09outarg.padding =3D 0;
> > +
> > +=09iov[1].iov_base =3D &outarg;
> > +=09iov[1].iov_len =3D sizeof(outarg);
> > +=09iov[2].iov_base =3D (void *)name;
> > +=09iov[2].iov_len =3D namelen + 1;
> > +
> > +=09return send_notify_iov(se, FUSE_NOTIFY_DELETE, iov, 3);
> > +}
> > +
> > +int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino=
,
> > +=09=09=09       off_t offset, struct fuse_bufvec *bufv,
> > +=09=09=09       enum fuse_buf_copy_flags flags)
> > +{
> > +=09struct fuse_out_header out;
> > +=09struct fuse_notify_store_out outarg;
> > +=09struct iovec iov[3];
> > +=09size_t size =3D fuse_buf_size(bufv);
> > +=09int res;
> > +
> > +=09if (!se)
> > +=09=09return -EINVAL;
> > +
> > +=09if (se->conn.proto_major < 6 || se->conn.proto_minor < 15)
> > +=09=09return -ENOSYS;
> > +
> > +=09out.unique =3D 0;
> > +=09out.error =3D FUSE_NOTIFY_STORE;
> > +
> > +=09outarg.nodeid =3D ino;
> > +=09outarg.offset =3D offset;
> > +=09outarg.size =3D size;
> > +=09outarg.padding =3D 0;
> > +
> > +=09iov[0].iov_base =3D &out;
> > +=09iov[0].iov_len =3D sizeof(out);
> > +=09iov[1].iov_base =3D &outarg;
> > +=09iov[1].iov_len =3D sizeof(outarg);
> > +
> > +=09res =3D fuse_send_data_iov(se, NULL, iov, 2, bufv, flags);
> > +=09if (res > 0)
> > +=09=09res =3D -res;
> > +
> > +=09return res;
> > +}
> > +
> > +struct fuse_retrieve_req {
> > +=09struct fuse_notify_req nreq;
> > +=09void *cookie;
> > +};
> > +
> > +static void fuse_ll_retrieve_reply(struct fuse_notify_req *nreq,
> > +=09=09=09=09   fuse_req_t req, fuse_ino_t ino,
> > +=09=09=09=09   const void *inarg,
> > +=09=09=09=09   const struct fuse_buf *ibuf)
> > +{
> > +=09struct fuse_session *se =3D req->se;
> > +=09struct fuse_retrieve_req *rreq =3D
> > +=09=09container_of(nreq, struct fuse_retrieve_req, nreq);
> > +=09const struct fuse_notify_retrieve_in *arg =3D inarg;
> > +=09struct fuse_bufvec bufv =3D {
> > +=09=09.buf[0] =3D *ibuf,
> > +=09=09.count =3D 1,
> > +=09};
> > +
> > +=09if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD))
> > +=09=09bufv.buf[0].mem =3D PARAM(arg);
> > +
> > +=09bufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
> > +=09=09sizeof(struct fuse_notify_retrieve_in);
> > +
> > +=09if (bufv.buf[0].size < arg->size) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: retrieve reply: buffer size too sm=
all\n");
> > +=09=09fuse_reply_none(req);
> > +=09=09goto out;
> > +=09}
> > +=09bufv.buf[0].size =3D arg->size;
> > +
> > +=09if (se->op.retrieve_reply) {
> > +=09=09se->op.retrieve_reply(req, rreq->cookie, ino,
> > +=09=09=09=09=09  arg->offset, &bufv);
> > +=09} else {
> > +=09=09fuse_reply_none(req);
> > +=09}
> > +out:
> > +=09free(rreq);
> > +=09if ((ibuf->flags & FUSE_BUF_IS_FD) && bufv.idx < bufv.count)
> > +=09=09fuse_ll_clear_pipe(se);
> > +}
> > +
> > +int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t =
ino,
> > +=09=09=09=09  size_t size, off_t offset, void *cookie)
> > +{
> > +=09struct fuse_notify_retrieve_out outarg;
> > +=09struct iovec iov[2];
> > +=09struct fuse_retrieve_req *rreq;
> > +=09int err;
> > +
> > +=09if (!se)
> > +=09=09return -EINVAL;
> > +
> > +=09if (se->conn.proto_major < 6 || se->conn.proto_minor < 15)
> > +=09=09return -ENOSYS;
> > +
> > +=09rreq =3D malloc(sizeof(*rreq));
> > +=09if (rreq =3D=3D NULL)
> > +=09=09return -ENOMEM;
> > +
> > +=09pthread_mutex_lock(&se->lock);
> > +=09rreq->cookie =3D cookie;
> > +=09rreq->nreq.unique =3D se->notify_ctr++;
> > +=09rreq->nreq.reply =3D fuse_ll_retrieve_reply;
> > +=09list_add_nreq(&rreq->nreq, &se->notify_list);
> > +=09pthread_mutex_unlock(&se->lock);
> > +
> > +=09outarg.notify_unique =3D rreq->nreq.unique;
> > +=09outarg.nodeid =3D ino;
> > +=09outarg.offset =3D offset;
> > +=09outarg.size =3D size;
> > +=09outarg.padding =3D 0;
> > +
> > +=09iov[1].iov_base =3D &outarg;
> > +=09iov[1].iov_len =3D sizeof(outarg);
> > +
> > +=09err =3D send_notify_iov(se, FUSE_NOTIFY_RETRIEVE, iov, 2);
> > +=09if (err) {
> > +=09=09pthread_mutex_lock(&se->lock);
> > +=09=09list_del_nreq(&rreq->nreq);
> > +=09=09pthread_mutex_unlock(&se->lock);
> > +=09=09free(rreq);
> > +=09}
> > +
> > +=09return err;
> > +}
> > +
> > +void *fuse_req_userdata(fuse_req_t req)
> > +{
> > +=09return req->se->userdata;
> > +}
> > +
> > +const struct fuse_ctx *fuse_req_ctx(fuse_req_t req)
> > +{
> > +=09return &req->ctx;
> > +}
> > +
> > +void fuse_req_interrupt_func(fuse_req_t req, fuse_interrupt_func_t fun=
c,
> > +=09=09=09     void *data)
> > +{
> > +=09pthread_mutex_lock(&req->lock);
> > +=09pthread_mutex_lock(&req->se->lock);
> > +=09req->u.ni.func =3D func;
> > +=09req->u.ni.data =3D data;
> > +=09pthread_mutex_unlock(&req->se->lock);
> > +=09if (req->interrupted && func)
> > +=09=09func(req, data);
> > +=09pthread_mutex_unlock(&req->lock);
> > +}
> > +
> > +int fuse_req_interrupted(fuse_req_t req)
> > +{
> > +=09int interrupted;
> > +
> > +=09pthread_mutex_lock(&req->se->lock);
> > +=09interrupted =3D req->interrupted;
> > +=09pthread_mutex_unlock(&req->se->lock);
> > +
> > +=09return interrupted;
> > +}
> > +
> > +static struct {
> > +=09void (*func)(fuse_req_t, fuse_ino_t, const void *);
> > +=09const char *name;
> > +} fuse_ll_ops[] =3D {
> > +=09[FUSE_LOOKUP]=09   =3D { do_lookup,      "LOOKUP"=09     },
> > +=09[FUSE_FORGET]=09   =3D { do_forget,      "FORGET"=09     },
> > +=09[FUSE_GETATTR]=09   =3D { do_getattr,     "GETATTR"     },
> > +=09[FUSE_SETATTR]=09   =3D { do_setattr,     "SETATTR"     },
> > +=09[FUSE_READLINK]=09   =3D { do_readlink,    "READLINK"    },
> > +=09[FUSE_SYMLINK]=09   =3D { do_symlink,     "SYMLINK"     },
> > +=09[FUSE_MKNOD]=09   =3D { do_mknod,       "MKNOD"=09     },
> > +=09[FUSE_MKDIR]=09   =3D { do_mkdir,       "MKDIR"=09     },
> > +=09[FUSE_UNLINK]=09   =3D { do_unlink,      "UNLINK"=09     },
> > +=09[FUSE_RMDIR]=09   =3D { do_rmdir,       "RMDIR"=09     },
> > +=09[FUSE_RENAME]=09   =3D { do_rename,      "RENAME"=09     },
> > +=09[FUSE_LINK]=09   =3D { do_link,=09       "LINK"=09     },
> > +=09[FUSE_OPEN]=09   =3D { do_open,=09       "OPEN"=09     },
> > +=09[FUSE_READ]=09   =3D { do_read,=09       "READ"=09     },
> > +=09[FUSE_WRITE]=09   =3D { do_write,       "WRITE"=09     },
> > +=09[FUSE_STATFS]=09   =3D { do_statfs,      "STATFS"=09     },
> > +=09[FUSE_RELEASE]=09   =3D { do_release,     "RELEASE"     },
> > +=09[FUSE_FSYNC]=09   =3D { do_fsync,       "FSYNC"=09     },
> > +=09[FUSE_SETXATTR]=09   =3D { do_setxattr,    "SETXATTR"    },
> > +=09[FUSE_GETXATTR]=09   =3D { do_getxattr,    "GETXATTR"    },
> > +=09[FUSE_LISTXATTR]   =3D { do_listxattr,   "LISTXATTR"   },
> > +=09[FUSE_REMOVEXATTR] =3D { do_removexattr, "REMOVEXATTR" },
> > +=09[FUSE_FLUSH]=09   =3D { do_flush,       "FLUSH"=09     },
> > +=09[FUSE_INIT]=09   =3D { do_init,=09       "INIT"=09     },
> > +=09[FUSE_OPENDIR]=09   =3D { do_opendir,     "OPENDIR"     },
> > +=09[FUSE_READDIR]=09   =3D { do_readdir,     "READDIR"     },
> > +=09[FUSE_RELEASEDIR]  =3D { do_releasedir,  "RELEASEDIR"  },
> > +=09[FUSE_FSYNCDIR]=09   =3D { do_fsyncdir,    "FSYNCDIR"    },
> > +=09[FUSE_GETLK]=09   =3D { do_getlk,       "GETLK"=09     },
> > +=09[FUSE_SETLK]=09   =3D { do_setlk,       "SETLK"=09     },
> > +=09[FUSE_SETLKW]=09   =3D { do_setlkw,      "SETLKW"=09     },
> > +=09[FUSE_ACCESS]=09   =3D { do_access,      "ACCESS"=09     },
> > +=09[FUSE_CREATE]=09   =3D { do_create,      "CREATE"=09     },
> > +=09[FUSE_INTERRUPT]   =3D { do_interrupt,   "INTERRUPT"   },
> > +=09[FUSE_BMAP]=09   =3D { do_bmap,=09       "BMAP"=09     },
> > +=09[FUSE_IOCTL]=09   =3D { do_ioctl,       "IOCTL"=09     },
> > +=09[FUSE_POLL]=09   =3D { do_poll,        "POLL"=09     },
> > +=09[FUSE_FALLOCATE]   =3D { do_fallocate,   "FALLOCATE"   },
> > +=09[FUSE_DESTROY]=09   =3D { do_destroy,     "DESTROY"     },
> > +=09[FUSE_NOTIFY_REPLY] =3D { (void *) 1,    "NOTIFY_REPLY" },
> > +=09[FUSE_BATCH_FORGET] =3D { do_batch_forget, "BATCH_FORGET" },
> > +=09[FUSE_READDIRPLUS] =3D { do_readdirplus,=09"READDIRPLUS"},
> > +=09[FUSE_RENAME2]     =3D { do_rename2,      "RENAME2"    },
> > +=09[FUSE_COPY_FILE_RANGE] =3D { do_copy_file_range, "COPY_FILE_RANGE" =
},
> > +=09[CUSE_INIT]=09   =3D { cuse_lowlevel_init, "CUSE_INIT"   },
> > +};
> > +
> > +#define FUSE_MAXOP (sizeof(fuse_ll_ops) / sizeof(fuse_ll_ops[0]))
> > +
> > +static const char *opname(enum fuse_opcode opcode)
> > +{
> > +=09if (opcode >=3D FUSE_MAXOP || !fuse_ll_ops[opcode].name)
> > +=09=09return "???";
> > +=09else
> > +=09=09return fuse_ll_ops[opcode].name;
> > +}
> > +
> > +static int fuse_ll_copy_from_pipe(struct fuse_bufvec *dst,
> > +=09=09=09=09  struct fuse_bufvec *src)
> > +{
> > +=09ssize_t res =3D fuse_buf_copy(dst, src, 0);
> > +=09if (res < 0) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: copy from pipe: %s\n", strerror(-r=
es));
> > +=09=09return res;
> > +=09}
> > +=09if ((size_t)res < fuse_buf_size(dst)) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: copy from pipe: short read\n");
> > +=09=09return -1;
> > +=09}
> > +=09return 0;
> > +}
> > +
> > +void fuse_session_process_buf(struct fuse_session *se,
> > +=09=09=09      const struct fuse_buf *buf)
> > +{
> > +=09fuse_session_process_buf_int(se, buf, NULL);
> > +}
> > +
> > +void fuse_session_process_buf_int(struct fuse_session *se,
> > +=09=09=09=09  const struct fuse_buf *buf, struct fuse_chan *ch)
> > +{
> > +=09const size_t write_header_size =3D sizeof(struct fuse_in_header) +
> > +=09=09sizeof(struct fuse_write_in);
> > +=09struct fuse_bufvec bufv =3D { .buf[0] =3D *buf, .count =3D 1 };
> > +=09struct fuse_bufvec tmpbuf =3D FUSE_BUFVEC_INIT(write_header_size);
> > +=09struct fuse_in_header *in;
> > +=09const void *inarg;
> > +=09struct fuse_req *req;
> > +=09void *mbuf =3D NULL;
> > +=09int err;
> > +=09int res;
> > +
> > +=09if (buf->flags & FUSE_BUF_IS_FD) {
> > +=09=09if (buf->size < tmpbuf.buf[0].size)
> > +=09=09=09tmpbuf.buf[0].size =3D buf->size;
> > +
> > +=09=09mbuf =3D malloc(tmpbuf.buf[0].size);
> > +=09=09if (mbuf =3D=3D NULL) {
> > +=09=09=09fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate header\n");
> > +=09=09=09goto clear_pipe;
> > +=09=09}
> > +=09=09tmpbuf.buf[0].mem =3D mbuf;
> > +
> > +=09=09res =3D fuse_ll_copy_from_pipe(&tmpbuf, &bufv);
> > +=09=09if (res < 0)
> > +=09=09=09goto clear_pipe;
> > +
> > +=09=09in =3D mbuf;
> > +=09} else {
> > +=09=09in =3D buf->mem;
> > +=09}
> > +
> > +=09if (se->debug) {
> > +=09=09fuse_log(FUSE_LOG_DEBUG,
> > +=09=09=09"unique: %llu, opcode: %s (%i), nodeid: %llu, insize: %zu, pi=
d: %u\n",
> > +=09=09=09(unsigned long long) in->unique,
> > +=09=09=09opname((enum fuse_opcode) in->opcode), in->opcode,
> > +=09=09=09(unsigned long long) in->nodeid, buf->size, in->pid);
> > +=09}
> > +
> > +=09req =3D fuse_ll_alloc_req(se);
> > +=09if (req =3D=3D NULL) {
> > +=09=09struct fuse_out_header out =3D {
> > +=09=09=09.unique =3D in->unique,
> > +=09=09=09.error =3D -ENOMEM,
> > +=09=09};
> > +=09=09struct iovec iov =3D {
> > +=09=09=09.iov_base =3D &out,
> > +=09=09=09.iov_len =3D sizeof(struct fuse_out_header),
> > +=09=09};
> > +
> > +=09=09fuse_send_msg(se, ch, &iov, 1);
> > +=09=09goto clear_pipe;
> > +=09}
> > +
> > +=09req->unique =3D in->unique;
> > +=09req->ctx.uid =3D in->uid;
> > +=09req->ctx.gid =3D in->gid;
> > +=09req->ctx.pid =3D in->pid;
> > +=09req->ch =3D ch ? fuse_chan_get(ch) : NULL;
> > +
> > +=09err =3D EIO;
> > +=09if (!se->got_init) {
> > +=09=09enum fuse_opcode expected;
> > +
> > +=09=09expected =3D se->cuse_data ? CUSE_INIT : FUSE_INIT;
> > +=09=09if (in->opcode !=3D expected)
> > +=09=09=09goto reply_err;
> > +=09} else if (in->opcode =3D=3D FUSE_INIT || in->opcode =3D=3D CUSE_IN=
IT)
> > +=09=09goto reply_err;
> > +
> > +=09err =3D EACCES;
> > +=09/* Implement -o allow_root */
> > +=09if (se->deny_others && in->uid !=3D se->owner && in->uid !=3D 0 &&
> > +=09=09 in->opcode !=3D FUSE_INIT && in->opcode !=3D FUSE_READ &&
> > +=09=09 in->opcode !=3D FUSE_WRITE && in->opcode !=3D FUSE_FSYNC &&
> > +=09=09 in->opcode !=3D FUSE_RELEASE && in->opcode !=3D FUSE_READDIR &&
> > +=09=09 in->opcode !=3D FUSE_FSYNCDIR && in->opcode !=3D FUSE_RELEASEDI=
R &&
> > +=09=09 in->opcode !=3D FUSE_NOTIFY_REPLY &&
> > +=09=09 in->opcode !=3D FUSE_READDIRPLUS)
> > +=09=09goto reply_err;
> > +
> > +=09err =3D ENOSYS;
> > +=09if (in->opcode >=3D FUSE_MAXOP || !fuse_ll_ops[in->opcode].func)
> > +=09=09goto reply_err;
> > +=09if (in->opcode !=3D FUSE_INTERRUPT) {
> > +=09=09struct fuse_req *intr;
> > +=09=09pthread_mutex_lock(&se->lock);
> > +=09=09intr =3D check_interrupt(se, req);
> > +=09=09list_add_req(req, &se->list);
> > +=09=09pthread_mutex_unlock(&se->lock);
> > +=09=09if (intr)
> > +=09=09=09fuse_reply_err(intr, EAGAIN);
> > +=09}
> > +
> > +=09if ((buf->flags & FUSE_BUF_IS_FD) && write_header_size < buf->size =
&&
> > +=09    (in->opcode !=3D FUSE_WRITE || !se->op.write_buf) &&
> > +=09    in->opcode !=3D FUSE_NOTIFY_REPLY) {
> > +=09=09void *newmbuf;
> > +
> > +=09=09err =3D ENOMEM;
> > +=09=09newmbuf =3D realloc(mbuf, buf->size);
> > +=09=09if (newmbuf =3D=3D NULL)
> > +=09=09=09goto reply_err;
> > +=09=09mbuf =3D newmbuf;
> > +
> > +=09=09tmpbuf =3D FUSE_BUFVEC_INIT(buf->size - write_header_size);
> > +=09=09tmpbuf.buf[0].mem =3D (char *)mbuf + write_header_size;
> > +
> > +=09=09res =3D fuse_ll_copy_from_pipe(&tmpbuf, &bufv);
> > +=09=09err =3D -res;
> > +=09=09if (res < 0)
> > +=09=09=09goto reply_err;
> > +
> > +=09=09in =3D mbuf;
> > +=09}
> > +
> > +=09inarg =3D (void *) &in[1];
> > +=09if (in->opcode =3D=3D FUSE_WRITE && se->op.write_buf)
> > +=09=09do_write_buf(req, in->nodeid, inarg, buf);
> > +=09else if (in->opcode =3D=3D FUSE_NOTIFY_REPLY)
> > +=09=09do_notify_reply(req, in->nodeid, inarg, buf);
> > +=09else
> > +=09=09fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
> > +
> > +out_free:
> > +=09free(mbuf);
> > +=09return;
> > +
> > +reply_err:
> > +=09fuse_reply_err(req, err);
> > +clear_pipe:
> > +=09if (buf->flags & FUSE_BUF_IS_FD)
> > +=09=09fuse_ll_clear_pipe(se);
> > +=09goto out_free;
> > +}
> > +
> > +#define LL_OPTION(n,o,v) \
> > +=09{ n, offsetof(struct fuse_session, o), v }
> > +
> > +static const struct fuse_opt fuse_ll_opts[] =3D {
> > +=09LL_OPTION("debug", debug, 1),
> > +=09LL_OPTION("-d", debug, 1),
> > +=09LL_OPTION("--debug", debug, 1),
> > +=09LL_OPTION("allow_root", deny_others, 1),
> > +=09FUSE_OPT_END
> > +};
> > +
> > +void fuse_lowlevel_version(void)
> > +{
> > +=09printf("using FUSE kernel interface version %i.%i\n",
> > +=09       FUSE_KERNEL_VERSION, FUSE_KERNEL_MINOR_VERSION);
> > +=09fuse_mount_version();
> > +}
> > +
> > +void fuse_lowlevel_help(void)
> > +{
> > +=09/* These are not all options, but the ones that are
> > +=09   potentially of interest to an end-user */
> > +=09printf(
> > +"    -o allow_other         allow access by all users\n"
> > +"    -o allow_root          allow access by root\n"
> > +"    -o auto_unmount        auto unmount on process termination\n");
> > +}
> > +
> > +void fuse_session_destroy(struct fuse_session *se)
> > +{
> > +=09struct fuse_ll_pipe *llp;
> > +
> > +=09if (se->got_init && !se->got_destroy) {
> > +=09=09if (se->op.destroy)
> > +=09=09=09se->op.destroy(se->userdata);
> > +=09}
> > +=09llp =3D pthread_getspecific(se->pipe_key);
> > +=09if (llp !=3D NULL)
> > +=09=09fuse_ll_pipe_free(llp);
> > +=09pthread_key_delete(se->pipe_key);
> > +=09pthread_mutex_destroy(&se->lock);
> > +=09free(se->cuse_data);
> > +=09if (se->fd !=3D -1)
> > +=09=09close(se->fd);
> > +=09destroy_mount_opts(se->mo);
> > +=09free(se);
> > +}
> > +
> > +
> > +static void fuse_ll_pipe_destructor(void *data)
> > +{
> > +=09struct fuse_ll_pipe *llp =3D data;
> > +=09fuse_ll_pipe_free(llp);
> > +}
> > +
> > +int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf =
*buf)
> > +{
> > +=09return fuse_session_receive_buf_int(se, buf, NULL);
> > +}
> > +
> > +int fuse_session_receive_buf_int(struct fuse_session *se, struct fuse_=
buf *buf,
> > +=09=09=09=09 struct fuse_chan *ch)
> > +{
> > +=09int err;
> > +=09ssize_t res;
> > +#ifdef HAVE_SPLICE
> > +=09size_t bufsize =3D se->bufsize;
> > +=09struct fuse_ll_pipe *llp;
> > +=09struct fuse_buf tmpbuf;
> > +
> > +=09if (se->conn.proto_minor < 14 || !(se->conn.want & FUSE_CAP_SPLICE_=
READ))
> > +=09=09goto fallback;
> > +
> > +=09llp =3D fuse_ll_get_pipe(se);
> > +=09if (llp =3D=3D NULL)
> > +=09=09goto fallback;
> > +
> > +=09if (llp->size < bufsize) {
> > +=09=09if (llp->can_grow) {
> > +=09=09=09res =3D fcntl(llp->pipe[0], F_SETPIPE_SZ, bufsize);
> > +=09=09=09if (res =3D=3D -1) {
> > +=09=09=09=09llp->can_grow =3D 0;
> > +=09=09=09=09res =3D grow_pipe_to_max(llp->pipe[0]);
> > +=09=09=09=09if (res > 0)
> > +=09=09=09=09=09llp->size =3D res;
> > +=09=09=09=09goto fallback;
> > +=09=09=09}
> > +=09=09=09llp->size =3D res;
> > +=09=09}
> > +=09=09if (llp->size < bufsize)
> > +=09=09=09goto fallback;
> > +=09}
> > +
> > +=09res =3D splice(ch ? ch->fd : se->fd,
> > +=09=09     NULL, llp->pipe[1], NULL, bufsize, 0);
> > +=09err =3D errno;
> > +
> > +=09if (fuse_session_exited(se))
> > +=09=09return 0;
> > +
> > +=09if (res =3D=3D -1) {
> > +=09=09if (err =3D=3D ENODEV) {
> > +=09=09=09/* Filesystem was unmounted, or connection was aborted
> > +=09=09=09   via /sys/fs/fuse/connections */
> > +=09=09=09fuse_session_exit(se);
> > +=09=09=09return 0;
> > +=09=09}
> > +=09=09if (err !=3D EINTR && err !=3D EAGAIN)
> > +=09=09=09perror("fuse: splice from device");
> > +=09=09return -err;
> > +=09}
> > +
> > +=09if (res < sizeof(struct fuse_in_header)) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "short splice from fuse device\n");
> > +=09=09return -EIO;
> > +=09}
> > +
> > +=09tmpbuf =3D (struct fuse_buf) {
> > +=09=09.size =3D res,
> > +=09=09.flags =3D FUSE_BUF_IS_FD,
> > +=09=09.fd =3D llp->pipe[0],
> > +=09};
> > +
> > +=09/*
> > +=09 * Don't bother with zero copy for small requests.
> > +=09 * fuse_loop_mt() needs to check for FORGET so this more than
> > +=09 * just an optimization.
> > +=09 */
> > +=09if (res < sizeof(struct fuse_in_header) +
> > +=09    sizeof(struct fuse_write_in) + pagesize) {
> > +=09=09struct fuse_bufvec src =3D { .buf[0] =3D tmpbuf, .count =3D 1 };
> > +=09=09struct fuse_bufvec dst =3D { .count =3D 1 };
> > +
> > +=09=09if (!buf->mem) {
> > +=09=09=09buf->mem =3D malloc(se->bufsize);
> > +=09=09=09if (!buf->mem) {
> > +=09=09=09=09fuse_log(FUSE_LOG_ERR,
> > +=09=09=09=09=09"fuse: failed to allocate read buffer\n");
> > +=09=09=09=09return -ENOMEM;
> > +=09=09=09}
> > +=09=09}
> > +=09=09buf->size =3D se->bufsize;
> > +=09=09buf->flags =3D 0;
> > +=09=09dst.buf[0] =3D *buf;
> > +
> > +=09=09res =3D fuse_buf_copy(&dst, &src, 0);
> > +=09=09if (res < 0) {
> > +=09=09=09fuse_log(FUSE_LOG_ERR, "fuse: copy from pipe: %s\n",
> > +=09=09=09=09strerror(-res));
> > +=09=09=09fuse_ll_clear_pipe(se);
> > +=09=09=09return res;
> > +=09=09}
> > +=09=09if (res < tmpbuf.size) {
> > +=09=09=09fuse_log(FUSE_LOG_ERR, "fuse: copy from pipe: short read\n");
> > +=09=09=09fuse_ll_clear_pipe(se);
> > +=09=09=09return -EIO;
> > +=09=09}
> > +=09=09assert(res =3D=3D tmpbuf.size);
> > +
> > +=09} else {
> > +=09=09/* Don't overwrite buf->mem, as that would cause a leak */
> > +=09=09buf->fd =3D tmpbuf.fd;
> > +=09=09buf->flags =3D tmpbuf.flags;
> > +=09}
> > +=09buf->size =3D tmpbuf.size;
> > +
> > +=09return res;
> > +
> > +fallback:
> > +#endif
> > +=09if (!buf->mem) {
> > +=09=09buf->mem =3D malloc(se->bufsize);
> > +=09=09if (!buf->mem) {
> > +=09=09=09fuse_log(FUSE_LOG_ERR,
> > +=09=09=09=09"fuse: failed to allocate read buffer\n");
> > +=09=09=09return -ENOMEM;
> > +=09=09}
> > +=09}
> > +
> > +restart:
> > +=09res =3D read(ch ? ch->fd : se->fd, buf->mem, se->bufsize);
> > +=09err =3D errno;
> > +
> > +=09if (fuse_session_exited(se))
> > +=09=09return 0;
> > +=09if (res =3D=3D -1) {
> > +=09=09/* ENOENT means the operation was interrupted, it's safe
> > +=09=09   to restart */
> > +=09=09if (err =3D=3D ENOENT)
> > +=09=09=09goto restart;
> > +
> > +=09=09if (err =3D=3D ENODEV) {
> > +=09=09=09/* Filesystem was unmounted, or connection was aborted
> > +=09=09=09   via /sys/fs/fuse/connections */
> > +=09=09=09fuse_session_exit(se);
> > +=09=09=09return 0;
> > +=09=09}
> > +=09=09/* Errors occurring during normal operation: EINTR (read
> > +=09=09   interrupted), EAGAIN (nonblocking I/O), ENODEV (filesystem
> > +=09=09   umounted) */
> > +=09=09if (err !=3D EINTR && err !=3D EAGAIN)
> > +=09=09=09perror("fuse: reading device");
> > +=09=09return -err;
> > +=09}
> > +=09if ((size_t) res < sizeof(struct fuse_in_header)) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "short read on fuse device\n");
> > +=09=09return -EIO;
> > +=09}
> > +
> > +=09buf->size =3D res;
> > +
> > +=09return res;
> > +}
> > +
> > +struct fuse_session *fuse_session_new(struct fuse_args *args,
> > +=09=09=09=09      const struct fuse_lowlevel_ops *op,
> > +=09=09=09=09      size_t op_size, void *userdata)
> > +{
> > +=09int err;
> > +=09struct fuse_session *se;
> > +=09struct mount_opts *mo;
> > +
> > +=09if (sizeof(struct fuse_lowlevel_ops) < op_size) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: warning: library too old, some ope=
rations may not work\n");
> > +=09=09op_size =3D sizeof(struct fuse_lowlevel_ops);
> > +=09}
> > +
> > +=09if (args->argc =3D=3D 0) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: empty argv passed to fuse_session_=
new().\n");
> > +=09=09return NULL;
> > +=09}
> > +
> > +=09se =3D (struct fuse_session *) calloc(1, sizeof(struct fuse_session=
));
> > +=09if (se =3D=3D NULL) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate fuse object\n")=
;
> > +=09=09goto out1;
> > +=09}
> > +=09se->fd =3D -1;
> > +=09se->conn.max_write =3D UINT_MAX;
> > +=09se->conn.max_readahead =3D UINT_MAX;
> > +
> > +=09/* Parse options */
> > +=09if(fuse_opt_parse(args, se, fuse_ll_opts, NULL) =3D=3D -1)
> > +=09=09goto out2;
> > +=09if(se->deny_others) {
> > +=09=09/* Allowing access only by root is done by instructing
> > +=09=09 * kernel to allow access by everyone, and then restricting
> > +=09=09 * access to root and mountpoint owner in libfuse.
> > +=09=09 */
> > +=09=09// We may be adding the option a second time, but
> > +=09=09// that doesn't hurt.
> > +=09=09if(fuse_opt_add_arg(args, "-oallow_other") =3D=3D -1)
> > +=09=09=09goto out2;
> > +=09}
> > +=09mo =3D parse_mount_opts(args);
> > +=09if (mo =3D=3D NULL)
> > +=09=09goto out3;
> > +
> > +=09if(args->argc =3D=3D 1 &&
> > +=09   args->argv[0][0] =3D=3D '-') {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: warning: argv[0] looks like an opt=
ion, but "
> > +=09=09=09"will be ignored\n");
> > +=09} else if (args->argc !=3D 1) {
> > +=09=09int i;
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: unknown option(s): `");
> > +=09=09for(i =3D 1; i < args->argc-1; i++)
> > +=09=09=09fuse_log(FUSE_LOG_ERR, "%s ", args->argv[i]);
> > +=09=09fuse_log(FUSE_LOG_ERR, "%s'\n", args->argv[i]);
> > +=09=09goto out4;
> > +=09}
> > +
> > +=09if (se->debug)
> > +=09=09fuse_log(FUSE_LOG_DEBUG, "FUSE library version: %s\n", PACKAGE_V=
ERSION);
> > +
> > +=09se->bufsize =3D FUSE_MAX_MAX_PAGES * getpagesize() +
> > +=09=09FUSE_BUFFER_HEADER_SIZE;
> > +
> > +=09list_init_req(&se->list);
> > +=09list_init_req(&se->interrupts);
> > +=09list_init_nreq(&se->notify_list);
> > +=09se->notify_ctr =3D 1;
> > +=09fuse_mutex_init(&se->lock);
> > +
> > +=09err =3D pthread_key_create(&se->pipe_key, fuse_ll_pipe_destructor);
> > +=09if (err) {
> > +=09=09fuse_log(FUSE_LOG_ERR, "fuse: failed to create thread specific k=
ey: %s\n",
> > +=09=09=09strerror(err));
> > +=09=09goto out5;
> > +=09}
> > +
> > +=09memcpy(&se->op, op, op_size);
> > +=09se->owner =3D getuid();
> > +=09se->userdata =3D userdata;
> > +
> > +=09se->mo =3D mo;
> > +=09return se;
> > +
> > +out5:
> > +=09pthread_mutex_destroy(&se->lock);
> > +out4:
> > +=09fuse_opt_free_args(args);
> > +out3:
> > +=09free(mo);
> > +out2:
> > +=09free(se);
> > +out1:
> > +=09return NULL;
> > +}
> > +
> > +int fuse_session_mount(struct fuse_session *se, const char *mountpoint=
)
> > +{
> > +=09int fd;
> > +
> > +=09/*
> > +=09 * Make sure file descriptors 0, 1 and 2 are open, otherwise chaos
> > +=09 * would ensue.
> > +=09 */
> > +=09do {
> > +=09=09fd =3D open("/dev/null", O_RDWR);
> > +=09=09if (fd > 2)
> > +=09=09=09close(fd);
> > +=09} while (fd >=3D 0 && fd <=3D 2);
> > +
> > +=09/*
> > +=09 * To allow FUSE daemons to run without privileges, the caller may =
open
> > +=09 * /dev/fuse before launching the file system and pass on the file
> > +=09 * descriptor by specifying /dev/fd/N as the mount point. Note that=
 the
> > +=09 * parent process takes care of performing the mount in this case.
> > +=09 */
> > +=09fd =3D fuse_mnt_parse_fuse_fd(mountpoint);
> > +=09if (fd !=3D -1) {
> > +=09=09if (fcntl(fd, F_GETFD) =3D=3D -1) {
> > +=09=09=09fuse_log(FUSE_LOG_ERR,
> > +=09=09=09=09"fuse: Invalid file descriptor /dev/fd/%u\n",
> > +=09=09=09=09fd);
> > +=09=09=09return -1;
> > +=09=09}
> > +=09=09se->fd =3D fd;
> > +=09=09return 0;
> > +=09}
> > +
> > +=09/* Open channel */
> > +=09fd =3D fuse_kern_mount(mountpoint, se->mo);
> > +=09if (fd =3D=3D -1)
> > +=09=09return -1;
> > +=09se->fd =3D fd;
> > +
> > +=09/* Save mountpoint */
> > +=09se->mountpoint =3D strdup(mountpoint);
> > +=09if (se->mountpoint =3D=3D NULL)
> > +=09=09goto error_out;
> > +
> > +=09return 0;
> > +
> > +error_out:
> > +=09fuse_kern_unmount(mountpoint, fd);
> > +=09return -1;
> > +}
> > +
> > +int fuse_session_fd(struct fuse_session *se)
> > +{
> > +=09return se->fd;
> > +}
> > +
> > +void fuse_session_unmount(struct fuse_session *se)
> > +{
> > +=09if (se->mountpoint !=3D NULL) {
> > +=09=09fuse_kern_unmount(se->mountpoint, se->fd);
> > +=09=09free(se->mountpoint);
> > +=09=09se->mountpoint =3D NULL;
> > +=09}
> > +}
> > +
> > +#ifdef linux
> > +int fuse_req_getgroups(fuse_req_t req, int size, gid_t list[])
> > +{
> > +=09char *buf;
> > +=09size_t bufsize =3D 1024;
> > +=09char path[128];
> > +=09int ret;
> > +=09int fd;
> > +=09unsigned long pid =3D req->ctx.pid;
> > +=09char *s;
> > +
> > +=09sprintf(path, "/proc/%lu/task/%lu/status", pid, pid);
> > +
> > +retry:
> > +=09buf =3D malloc(bufsize);
> > +=09if (buf =3D=3D NULL)
> > +=09=09return -ENOMEM;
> > +
> > +=09ret =3D -EIO;
> > +=09fd =3D open(path, O_RDONLY);
> > +=09if (fd =3D=3D -1)
> > +=09=09goto out_free;
> > +
> > +=09ret =3D read(fd, buf, bufsize);
> > +=09close(fd);
> > +=09if (ret < 0) {
> > +=09=09ret =3D -EIO;
> > +=09=09goto out_free;
> > +=09}
> > +
> > +=09if ((size_t)ret =3D=3D bufsize) {
> > +=09=09free(buf);
> > +=09=09bufsize *=3D 4;
> > +=09=09goto retry;
> > +=09}
> > +
> > +=09ret =3D -EIO;
> > +=09s =3D strstr(buf, "\nGroups:");
> > +=09if (s =3D=3D NULL)
> > +=09=09goto out_free;
> > +
> > +=09s +=3D 8;
> > +=09ret =3D 0;
> > +=09while (1) {
> > +=09=09char *end;
> > +=09=09unsigned long val =3D strtoul(s, &end, 0);
> > +=09=09if (end =3D=3D s)
> > +=09=09=09break;
> > +
> > +=09=09s =3D end;
> > +=09=09if (ret < size)
> > +=09=09=09list[ret] =3D val;
> > +=09=09ret++;
> > +=09}
> > +
> > +out_free:
> > +=09free(buf);
> > +=09return ret;
> > +}
> > +#else /* linux */
> > +/*
> > + * This is currently not implemented on other than Linux...
> > + */
> > +int fuse_req_getgroups(fuse_req_t req, int size, gid_t list[])
> > +{
> > +=09(void) req; (void) size; (void) list;
> > +=09return -ENOSYS;
> > +}
> > +#endif
> > +
> > +void fuse_session_exit(struct fuse_session *se)
> > +{
> > +=09se->exited =3D 1;
> > +}
> > +
> > +void fuse_session_reset(struct fuse_session *se)
> > +{
> > +=09se->exited =3D 0;
> > +=09se->error =3D 0;
> > +}
> > +
> > +int fuse_session_exited(struct fuse_session *se)
> > +{
> > +=09return se->exited;
> > +}
> > --=20
> > 2.23.0
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


